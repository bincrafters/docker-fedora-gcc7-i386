FROM fedora:26
MAINTAINER SSE4 <tomskside@gmail.com>

ENV CMAKE_VERSION=3.10.2

RUN yum update -y && \
    yum install -y \
    sudo \
    gcc-c++ \
    glibc-devel \
    glibc-devel.i686 \
    libgcc.i686 \
    libstdc++.i686 \
    make \
    file \
    python-pip \
    python-wheel && \
    yum upgrade -y python-setuptools && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    curl https://cmake.org/files/v3.10/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz | tar -xz && \
    pip install -q --no-cache-dir conan && \
    groupadd g1001 -g 1001 && \
    groupadd g1000 -g 1000 && \
    groupadd g2000 -g 2000 && \
    useradd -ms /bin/bash conan -g g1001 -G g1000,g2000 && \
    printf "conan:conan" | chpasswd && \
    usermod -aG wheel conan && \
    printf "conan ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

USER conan
WORKDIR /home/conan

RUN mkdir -p /home/conan/.conan

ENV PATH=$PATH:/cmake-${CMAKE_VERSION}-Linux-x86_64/bin


CMD ["/bin/bash"]
