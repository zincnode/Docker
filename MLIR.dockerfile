FROM dev

# git clone llvm-project
RUN mkdir /root/workdir/ && \
    git clone https://github.com/llvm/llvm-project.git

RUN mkdir llvm-project/build && cd llvm-project/build && \
    cmake -G Ninja ../llvm \
        -DLLVM_ENABLE_PROJECTS=mlir \
        -DLLVM_BUILD_EXAMPLES=ON \
        -DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_ENABLE_LLD=ON && \
        # -DLLVM_CCACHE_BUILD=ON && \
    cmake --build . --target check-mlir
