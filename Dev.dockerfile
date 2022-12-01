FROM ubuntu

# change apt mirror to bfsu mirror
RUN sed -i 's/archive.ubuntu.com/mirrors.bfsu.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.bfsu.edu.cn/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y curl wget git neovim zsh inxi \
    gcc g++ make cmake ninja-build clang clangd lld \
    python3 python3-pip python3-venv python3-setuptools python3-wheel \
    golang \
    nodejs npm

# install oh-my-zsh and set zsh as default shell
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    chsh -s $(which zsh)

# change pip mirror tsinghua mirror and install anaconda
RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple && \
    wget https://mirrors.bfsu.edu.cn/anaconda/archive/Anaconda3-2020.11-Linux-x86_64.sh && \
    bash Anaconda3-2020.11-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm Anaconda3-2020.11-Linux-x86_64.sh && \
    /opt/anaconda3/bin/conda init zsh

#install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

CMD /bin/zsh
