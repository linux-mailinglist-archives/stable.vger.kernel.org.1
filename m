Return-Path: <stable+bounces-185636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BEBD901E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA6A3B20C8
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9D30FF02;
	Tue, 14 Oct 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqHqBvz2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455C30DEB6
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441187; cv=none; b=doHdOGkrYYKxIIN2O9Tj9ZFqPYrALgn/9uWOjK0+rF3Eq2cWqKBo+uMNgdpU2yIPdgUsHERQahKEdzDVql3eBWpd/12cruuxTvoUbjSBJBhV0Nv+PXL4hkY4YfIYe6t11qN7fbLz3OKHW027fiRGhFVPRGjZg/O71xn628n5O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441187; c=relaxed/simple;
	bh=lhmKYp1HEXdi8uvGeIez6CnOvw0aDg5m/CFlXJlE44A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEq5BfbhTeXYByCatFnyHWY6s/xcGuPlPcvtMacEcrE43KuD/91pvHfsj0JToxzQ+Y8Q22k+0OcrU5bjPi8xZth5xPoSGJtMZVZEezvllYKVVgStfJ4zU769vfDxT3STBuUuOib26OAw+vsF+jU1qLlRkDdR9mk2YSs9g3JrAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqHqBvz2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267f0fe72a1so38062845ad.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760441183; x=1761045983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MrvNzgtUD4jIWNAqMAqvVvyYhJjdrVewiw+zojqIvG0=;
        b=kqHqBvz2G1YbRyJ5qjPZbaJi/r0n9nkpVLVu9b8SqWzUcJzUkHrHdlS+7YjZaq0PvA
         oEh3BIathze5TM21i4AsKaqd0NUs2jPI9rYJcAjyDPbudhfTTT3wyQpi2qKmMy1A6020
         V/xUK3cJyRsQdomG0pY2+d0fgXC1wIiP+Xy4T+o2Y+Voba+QTCxW+XG3Pju18Jwpc3y9
         +sfDt2rTd3kB4tZRdHpACcdY3o0CQ4lqel+8Hn0GZoqmHSAmthj+5MBuc+opX+EEDMTo
         K5bFg5L4SWWykgHQhOaNX8NskibdKktU5z04ZRZZvkFa5+Ml2JqJ2vseuGIVkY49Cr3I
         cCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441183; x=1761045983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrvNzgtUD4jIWNAqMAqvVvyYhJjdrVewiw+zojqIvG0=;
        b=PE9TIjfFja5f1u0K4VlvVsT8tUKhV2YReGvi6113uIx1aYS4KozCQn689PgTbS0Wsh
         1N427sSTfdSMImB4Jdje5/3Ic5Vhtl4+ZnC9LWtCNgCDZ1m5qU/EfFQDRI34D2UpcLt/
         OgYKCN5tgLaYXkkzK4jKx7nmZsKGxSI/aXAGXB8Xne/reR9fWi2soYCN2RG1NfFiBz/b
         M2jyvIVYaSrBav5CwLm7Fz/vxuQX406NdU33vqCQVUWzVOs9L5ib1puCkHs49a7udh2q
         6Yvh54N8FUcyK29MvWcgEZJnUJXbKj/C37usoy94DxkVBAPfq6Fbges38gJKPiCCwwEG
         ePwQ==
X-Gm-Message-State: AOJu0YyDIPTOa3RogFLszdy5FSLnVsVIpZ2yToApljkzKNvLJehxwNYH
	nSawMkEbu+7a0kh8D+ZJpKLtXqSi8f0lmvtHkstke4BVQntTx0hTyRXkCCFSzF3WmhEtNmB1N9+
	YSr0hp753LI0uSxFH304dwdM9IMKbG3t20EzqmB+j0A==
X-Gm-Gg: ASbGncsaGw/oH6pU0rI1gnJkd72sqU4uAuHRD4VW5/fKEQg8eT+Dx5WflUqRscvcKpe
	MPm5wkQVOwuaZ1N5bypnxEF6Bdn6SN8gxBFHhmwoZyKBNCiW9eNa9vIrRdXDVTcnw/WDObGDZIx
	I+pbDj6fYCbxBI2+imhySmYX4JYrP19X7/7pbBzLbTKL47sQI1vDRB+l1dFMFDMcldkgZFj14BT
	ggUb3n1kponuaZ/D1/8xnzdCKbwXJ2JGq/HzLBiY10MHdGosGemVMlyA9wGXN8Wr/uO95k1JeQX
	HE8mxxWD0w2wY0KMwzI=
X-Google-Smtp-Source: AGHT+IHwg7xmTszUL/SFBHh33H8YJlErW0QdvxmOvcZasjPvJRMAkydcriG/Tv/ojvIGN9D0JGRguiWK500rgDVCCC0=
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id
 d9443c01a7336-290273a1725mr289912375ad.57.1760441182743; Tue, 14 Oct 2025
 04:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144326.116493600@linuxfoundation.org>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Oct 2025 16:56:11 +0530
X-Gm-Features: AS18NWCaA-1Kru16tgB66u-9S9WWZNi7-YltYKxwj_4Zn3wDV_IwhfPwMLShZB4
Message-ID: <CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, linux-s390@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 20:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 defconfig builds failed on the Linux stable-rc 6.12.53-rc1
and 6.6.112-rc1 tag build due to following build warnings / errors
with gcc and clang toolchains.

Also seen on 6.6.112-rc1.

* s390, build
  - clang-21-defconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-14-allmodconfig
  - gcc-14-defconfig
  - gcc-14-lkftconfig-hardening
  - gcc-8-defconfig-fe40093d
  - gcc-8-lkftconfig-hardening
  - korg-clang-21-lkftconfig-hardening
  - korg-clang-21-lkftconfig-lto-full
  - korg-clang-21-lkftconfig-lto-thing

First seen on 6.12.53-rc1
Good: v6.12.52
Bad: 6.12.53-rc1 also seen on 6.6.112-rc1

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regressions: arch/s390/net/bpf_jit_comp.c:1813:49: error:
'struct bpf_jit' has no member named 'frame_off'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# Build error
arch/s390/net/bpf_jit_comp.c: In function 'bpf_jit_insn':
arch/s390/net/bpf_jit_comp.c:1813:49: error: 'struct bpf_jit' has no
member named 'frame_off'
 1813 |                         _EMIT6(0xd203f000 | (jit->frame_off +
      |                                                 ^~
arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro '_EMIT6'
  211 |                 *(u32 *) (jit->prg_buf + jit->prg) = (op1);     \
      |                                                       ^~~
include/linux/stddef.h:16:33: error: invalid use of undefined type
'struct prog_frame'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro '_EMIT6'
  211 |                 *(u32 *) (jit->prg_buf + jit->prg) = (op1);     \
      |                                                       ^~~
arch/s390/net/bpf_jit_comp.c:1814:46: note: in expansion of macro 'offsetof'
 1814 |                                              offsetof(struct prog_frame,
      |                                              ^~~~~~~~
include/linux/stddef.h:16:33: error: invalid use of undefined type
'struct prog_frame'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro '_EMIT6'
  212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) = (op2); \
      |                                                           ^~~
arch/s390/net/bpf_jit_comp.c:1816:41: note: in expansion of macro 'offsetof'
 1816 |                                0xf000 | offsetof(struct prog_frame,
      |                                         ^~~~~~~~
arch/s390/net/bpf_jit_comp.c: In function '__arch_prepare_bpf_trampoline':
include/linux/stddef.h:16:33: error: invalid use of undefined type
'struct prog_frame'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro '_EMIT6'
  212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) = (op2); \
      |                                                           ^~~
arch/s390/net/bpf_jit_comp.c:2813:33: note: in expansion of macro 'offsetof'
 2813 |                        0xf000 | offsetof(struct prog_frame,
tail_call_cnt));
      |                                 ^~~~~~~~
make[5]: *** [scripts/Makefile.build:229: arch/s390/net/bpf_jit_comp.o] Error 1

The git blame is pointing to,
 $ git blame -L 1813  arch/s390/net/bpf_jit_comp.c
   162513d7d81487 (Ilya Leoshkevich)    _EMIT6(0xd203f000 | (jit->frame_off +

Commit pointing to,
   s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
   [ Upstream commit c861a6b147137d10b5ff88a2c492ba376cd1b8b0 ]

## Build
* kernel: 6.12.53-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 7e50c0945b4ab1d4019f9905f6cf5350082c6a84
* git describe: v6.12.52-263-g7e50c0945b4a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.52-263-g7e50c0945b4a

## Test Regressions (compared to v6.12.50-47-gf7ad21173a19)
* s390, build
  - clang-21-defconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-14-allmodconfig
  - gcc-14-defconfig
  - gcc-14-lkftconfig-hardening
  - gcc-8-defconfig-fe40093d
  - gcc-8-lkftconfig-hardening
  - korg-clang-21-lkftconfig-hardening
  - korg-clang-21-lkftconfig-lto-full
  - korg-clang-21-lkftconfig-lto-thing

## Metric Regressions (compared to v6.12.50-47-gf7ad21173a19)

## Test Fixes (compared to v6.12.50-47-gf7ad21173a19)

## Metric Fixes (compared to v6.12.50-47-gf7ad21173a19)

## Test result summary
total: 152513, pass: 126770, fail: 5572, skip: 19634, xfail: 537

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 8 passed, 14 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

