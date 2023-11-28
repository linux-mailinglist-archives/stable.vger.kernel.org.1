Return-Path: <stable+bounces-2882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911087FB698
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2349CB21826
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A04C3BF;
	Tue, 28 Nov 2023 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sel422hm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB695109
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 02:03:23 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c500dcdd7dso119030241.1
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 02:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701165803; x=1701770603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CxLKyz5l0EkmmXVlbTwykLEQhhHaJesh/izL94dzvS0=;
        b=Sel422hmB2RFftYT2ZrzRCk+jZyjIJrTEwYZPDM1L/Qt+Ipl3vjk/RvSYKd/UWZp6j
         Te3tR/GwNjTskxDQW0rrfqMjGWWrMXgZukz+rkv++2GU2n5jlxd+kDK2bcU/O11e3gOS
         nbTXrbdKoZW/xtfWl461Ges9jTm8PyXpAOalMUN/ICwOW6xZWfvjkoZ4sba6usReQoIQ
         xWQFb6sVYPTOnB13cNJSAQl6Sxct+mImhiSLUT2mxp7gFqRUmQiZqd/YfEP00jt+Za4B
         SC5okYLxZ81tM7WywZ2/kSqcYENy8ohJ70LIb9KHkIP1hTP9soRfK7T7T5XJ/QT6iD3n
         w0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165803; x=1701770603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxLKyz5l0EkmmXVlbTwykLEQhhHaJesh/izL94dzvS0=;
        b=wU3pZf/lqku1U2Fh2uR+ZvSK69U3dKnwQJT5FVPV+DdB4GVpMdBQXuRgb9wgKlTiZU
         Pn5fan12Un9WZwZ2HwUD+9POCvAaH7Kj7wM1cdZKiuZhlE8mvy2sdH8y8C5jTIz1zruy
         hxRsxhiYHYmEfKcCqh6jWliyTzkr0H2TlBOOEXmsXtBdaq3BnDPa1fHdSEp/pcJtXPIe
         qHF/Ecztei6bvM2vydCvIGXtx1S+CQw7EzUzGlMjYYwE+3HIL0jUVxaRBg2tp4Wne/8q
         SUpCHDgRZkWFA3lD51QtDInkaxANKO1od2bz4BZHstlqR/lvunUi4WYis27LhpXX3GMZ
         abRQ==
X-Gm-Message-State: AOJu0Yz5DEC1kTHpVx+RNTP4fxzNLGrztAJVhyImgyRSv4EyKLF6alxA
	FmVBvSpAMlofll8HQN/PZxkcT8Twtpay9goppteB0w==
X-Google-Smtp-Source: AGHT+IH5tonKv1UsYDqBYWDyswTeTxx+8UPeRgCODMz3Wlh/FWZWFbbhZmcdRUAvQPBrIGEpFD9rWcsRX/m/Zi2ECYs=
X-Received: by 2002:a1f:fec4:0:b0:49d:120c:3c2a with SMTP id
 l187-20020a1ffec4000000b0049d120c3c2amr8653904vki.11.1701165802677; Tue, 28
 Nov 2023 02:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154329.848261327@linuxfoundation.org>
In-Reply-To: <20231126154329.848261327@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Nov 2023 15:33:11 +0530
Message-ID: <CA+G9fYsXii1M=4Y6qrir8n=bgCZoGY338fbqEeE9m-TTE9AwpA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/152] 5.4.262-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Nov 2023 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
1)
Perf: PMU_events_subtest_1 / 2  - fails on all qemu-armv7 and TI x15 devices
These perf failures are also noticed on the mainline / vanilla kernel on 32-bit

2)
Following kernel warning noticed on stable-rc linux-5.4.y with
clang-17 for arm64 defconfig.

WARNING: vmlinux.o(.text+0x4e2a80): Section mismatch in reference from the
 function ks_pcie_probe() to the function .init.text:ks_pcie_add_pcie_port()
The function ks_pcie_probe() references
the function __init ks_pcie_add_pcie_port().
This is often because ks_pcie_probe lacks a __init
annotation or the annotation of ks_pcie_add_pcie_port is wrong.

Link:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YlCuygCpZ8wNd4DS0txeyTovV4/

## Build
* kernel: 5.4.262-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: ec4ef9e1558368d6a9606ca04072d398d79a6b7a
* git describe: v5.4.261-153-gec4ef9e15583
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.261-153-gec4ef9e15583

## Test Regressions (compared to v5.4.261)

* qemu-armv7, perf
  - PMU_events_subtest_1
  - PMU_events_subtest_2

* x15, perf
  - PMU_events_subtest_1
  - PMU_events_subtest_2

## Metric Regressions (compared to v5.4.261)

## Test Fixes (compared to v5.4.261)

## Metric Fixes (compared to v5.4.261)

## Test result summary
total: 93181, pass: 72823, fail: 2493, skip: 17814, xfail: 51

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 148 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

