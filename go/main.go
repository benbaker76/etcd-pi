package main

import (
  "context"
  "go.etcd.io/etcd/clientv3"
  "log"
  "time"
  "io/ioutil"
  "crypto/tls"
  "crypto/x509"
)

func main() {
  var err error
  caCert, _ := ioutil.ReadFile("/etc/etcd/pki/ca.pem")
  caCertPool := x509.NewCertPool()
  caCertPool.AppendCertsFromPEM(caCert)

  cert, _ := tls.LoadX509KeyPair("/etc/etcd/pki/etcd.pem", "/etc/etcd/pki/etcd-key.pem")

  tlsConf := &tls.Config{
    RootCAs: caCertPool,
    Certificates: []tls.Certificate{cert},
  }

  client, err := clientv3.New(clientv3.Config {
    TLS: tlsConf,
    Endpoints: []string { "192.168.0.50:2379", "192.168.0.51:2379", "192.168.0.52:2379" },
    DialTimeout: 5 * time.Second,
  })

  ctx, _ := context.WithTimeout(context.Background(), 10 * time.Second)
  _, err = client.Put(ctx, "foo", "bar")

  if err != nil {
    log.Printf("put error: %v", err)
    return
  }

  ticker := time.NewTicker(2 * time.Second)

  defer ticker.Stop()

  for {
    select {
      case <-ticker.C:
        ctx, _ := context.WithTimeout(context.Background(), 10 * time.Second)
        resp, err := client.Get(ctx, "foo")
        if err != nil {
          log.Printf("get error: %v", err)
          return
        } else {
          for _, ev := range resp.Kvs {
            log.Printf("%s=%s", ev.Key, ev.Value)
          }
        }
    }
  }
}
