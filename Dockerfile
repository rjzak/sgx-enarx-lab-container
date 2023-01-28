# podman build -f Dockerfile -v /var/cache/intel-sgx/:/var/cache/intel-sgx/ \
#              --device=/dev/sgx_enclave \
#              --device=/dev/sgx_provision \
#              --device=/dev/sgx_vepc -v /dev/sgx/:/dev/sgx/
FROM quay.io/centos/centos:stream9

RUN yum -y install wget yum-utils python3 python3-urllib3

COPY get_fmspc.py ./

RUN wget https://download.01.org/intel-sgx/latest/linux-latest/distro/centos-stream/sgx_rpm_local_repo.tgz

RUN tar -xzf sgx_rpm_local_repo.tgz

RUN yum-config-manager --add-repo file://`pwd`/sgx_rpm_local_repo/

RUN yum -y --nogpgcheck install sgx-pck-id-retrieval-tool

RUN /opt/intel/sgx-pck-id-retrieval-tool/PCKIDRetrievalTool -f /var/cache/intel-sgx/pckid_retrieval.csv

RUN python3 get_fmspc.py
