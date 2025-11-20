#!/bin/false
# This file will be sourced in init.sh
# Creates CUDA library symlinks required by Triton/bitsandbytes

function preflight_main() {
    preflight_create_cuda_symlinks
}

function preflight_create_cuda_symlinks() {
    # Try standard location first
    if [[ -f "/usr/lib/x86_64-linux-gnu/libcuda.so.1" ]]; then
        ln -sf /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so
        printf "Created CUDA symlink in /usr/lib/x86_64-linux-gnu/\n"
    # Try CUDA compat location
    elif [[ -f "/usr/local/cuda/compat/libcuda.so.1" ]]; then
        ln -sf /usr/local/cuda/compat/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so
        ln -sf /usr/local/cuda/compat/libcuda.so.1 /usr/local/cuda/compat/libcuda.so
        printf "Created CUDA symlink from compat location\n"
    else
        printf "Warning: libcuda.so.1 not found, skipping symlink creation\n"
    fi
}

preflight_main "$@"
