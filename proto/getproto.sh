#!/bin/bash
set -e
wget -q --show-progress -O auth.proto https://raw.githubusercontent.com/etcd-io/etcd/main/api/authpb/auth.proto
wget -q --show-progress -O rpc.proto https://raw.githubusercontent.com/etcd-io/etcd/main/api/etcdserverpb/rpc.proto
wget -q --show-progress -O kv.proto https://raw.githubusercontent.com/etcd-io/etcd/main/api/mvccpb/kv.proto
wget -q --show-progress -O version.proto https://raw.githubusercontent.com/etcd-io/etcd/main/api/versionpb/version.proto
wget -q --show-progress -O gogo.proto https://raw.githubusercontent.com/gogo/protobuf/master/gogoproto/gogo.proto
wget -q --show-progress -O annotations.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
wget -q --show-progress -O http.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto
wget -q --show-progress -O descriptor.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/descriptor.proto
sed -i 's/gogoproto\///' auth.proto
sed -i 's/gogoproto\///' rpc.proto
sed -i 's/etcd\/api\/mvccpb\///' rpc.proto
sed -i 's/etcd\/api\/authpb\///' rpc.proto
sed -i 's/etcd\/api\/versionpb\///' rpc.proto
sed -i 's/google\/api\///' rpc.proto
sed -i 's/gogoproto\///' kv.proto
sed -i 's/gogoproto\///' version.proto
sed -i 's/google\/protobuf\///' version.proto
sed -i 's/google\/protobuf\///' gogo.proto
sed -i 's/google\/api\///' annotations.proto
sed -i 's/google\/protobuf\///' annotations.proto
sed -i '6s/^/option go_package = "\.\/";\n/' auth.proto
sed -i '12s/^/option go_package = "\.\/";\n/' rpc.proto
sed -i '6s/^/option go_package = "\.\/";\n/' kv.proto
sed -i '7s/^/option go_package = "\.\/";\n/' version.proto
