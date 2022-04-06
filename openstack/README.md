
# site-values
## Global values
| Key | Description | example value |
|---------|------|-------|
| clusterName | Kubernetes cluster name | cluster.local |
| storageClassName | Kubernetes stroage class | taco-storage |
| repository | helm chart repository |  https://openinfrav.github.io/helm-repo |
| externalIP | Horizon URL용 외부 IP or DNS | 172.16.53.26 |
| ceph_keyring | ceph admin user keyring | AQBAHAdfHQ5RLhAA |
| cinder_keyring | ceph cinder user keyring | AQAin8tU0CFgEh |
| rbd_secret_uuid | rbd secret uuid, nova에 cinder volume을 연결할 때 필요 |  582393ff-9a5c |
| adminPassword | openstack service의 db 패스워드| Pa$$w0rd! |

## Chart values 
|Chart | Key | Description | example value |
|---------|------|-------|---------|
| ceph-provisioners | conf.ceph.global.mon_host | Ceph Mon Address(IP, dns) | 192.168.95.12,192.168.95.13,192.168.95.14 |
| cinder | pod.replicas.api | cinder api pod의 replica개수 | 3 |
| cinder | pod.replicas.scheduler | cinder scheduler pod의 개수 | 3 |
| cinder | conf.cinder.DEFAULT.backup_ceph_user | cinder backup ceph user | cinder-backup |
| cinder | conf.cinder.DEFAULT.backup_ceph_pool | ciner backup ceph pool | backups |
| glance | pod.replicas.api | glance api pod의 replica 개수 | 1 |
| glance | pod.replicas.registry | glance registry pod의 replica 개수 | 1 |
| glance | bootstrap.enabled | 최초 설치 시 이미지 업로드 테스트 진행 유무 | true |
| horizon | network.node_port.enabled | 외부 접속을 위해 nodeport 사용 | true |
| keystone | pod.replicas.api | keystone pod의 replica 개수 | 1 |
| mariadb | pod.replicas.server | mariadb pod의 replica 개수 | 3 |
| neutron | pod.replicas.server | neutron-server pod의 replica 개수 | 3 |
| nova | network.novncproxy.node_port.port | vnc용 nodeport | 30608 |
| nova | conf.nova.DEFAULT.ram_allocation_ratio | VM 스케쥴링 시 노드의 실제 메모리 용량 대비 추가 비율 | 0.8 |
| nova | conf.nova.DEFAULT.disk_allocation_ratio | VM 스케쥴링 시 노드의 실제 디스크 용량 대비 추가 비율 | 9999.0 |
| nova | conf.nova.DEFAULT.cpu_allocation_ratio | VM 스케쥴링 시 노드의ㅣ 실제 CPU 대비 추가 비율 | 8.0 |
| nova | pod.replicas.api_metadata | nova metadata api pod의 replica 개수 | 3 |
| nova | pod.replicas.osapi | nova api pod의 replica 개수 | 3 |
| nova | pod.replicas.conductor | nova conductor pod의 replica 개수 | 3 |
| nova | pod.replicas.consoleauth | nova consoleauth pod의 reeplica 개수 | 3 |
| nova | pod.replicas.scheduler | nova scheduler pod의 replica 개수 | 3 |
| nova | pod.replicas.novncproxy | nova novncproxy pod의 replica 개수 | 3 |
| rabbitmq | pod.replicas.server | rabbitmq replica 개수 | 3 |
