Return-Path: <stable+bounces-2753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E617F9FFD
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A48D280F67
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135A1E535;
	Mon, 27 Nov 2023 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHTtN4TT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE61A1
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 04:49:24 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b843fea0dfso2471226b6e.3
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 04:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089364; x=1701694164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N27F9Y7OHA8rFvW3503qZQypYzzgn9MSB8NAchfIsXM=;
        b=eHTtN4TTfcG+HXaN+66d0ZduM8TBp5G8xVeAv3xnF9+Ju3VkoaDe/wMLu32+TraQab
         3d2iKZtzQhrSxB8akxc9h3w7w6Ur2tDgcvSWWAafvej9eKqfrFcUY/DlvR8qPsF7GNEk
         b7C3ZCVw9LCEdFQmCUyEEFneKvPak74Ait/xNxBxU7BRSazKrTq7xWugJxkP9VMT3p1E
         EWJG9bUBJwRIHrMRwqRmB2+FRNXo7yQc57GDORqqLg+aR/Bq5IskIPGyJx87hhv1KraT
         xjXwzUz7uFG1AwT44QbZ4TgafYIMND2Wms14yuOcNYASX2oo044MjCscH5mf6FiBaUEh
         AQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089364; x=1701694164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N27F9Y7OHA8rFvW3503qZQypYzzgn9MSB8NAchfIsXM=;
        b=o+TN+rmcYs4LI45Z68nZyyMFTAQ7Hnkkmvm2G8O7/OYuWZjoa6ZqZqOB1D1Ihsr3EP
         SbWgEnDBmDY2pJpJdooHwoQVZhtTQSQKGbNT43a6/Vx6jfxc26FST33KNDSRv1ZdvCOy
         dssgfsqohp4DfzliTlFEYp6QIIzo913UXVjBgih03hkgdrXkg4CUVIf5F5RyjZpRqL34
         QrBGdsE6trd/OQk5ciPq/lNjbXBIyCcqFJSWVOFjOspM8uudqF3bQ2lybEt12Gwi0Nkz
         FeEUFShQzZ6rRPmmyTq5wcZ4uDcStBIROkxjv9qiVN3XXL4CjiGYc7V+tOnVpt0IdEML
         xYrg==
X-Gm-Message-State: AOJu0YywA4ThoTNhbzI5acpaLJP1ME8swO/oIR8rDMI7JFCeyMno0YGQ
	LjojU/ShkK8/c1ka34KvBakTW8Yk6egZYkUcMK/0EZOSPq546K/L3lI=
X-Google-Smtp-Source: AGHT+IGr0e750TbFhHnjrjPt0RI6h232xekjGC7TeCzyxN/0rvld+fdKwux+mZbUmfgX1fBFJgGy0+cSEt4z+Bc8UE4=
X-Received: by 2002:a05:6358:281e:b0:16d:a668:bca9 with SMTP id
 k30-20020a056358281e00b0016da668bca9mr11152451rwb.11.1701089363676; Mon, 27
 Nov 2023 04:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154418.032283745@linuxfoundation.org>
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Nov 2023 18:19:12 +0530
Message-ID: <CA+G9fYvT1ud6dciv35hOBnc6rXJezNqDBr2kd9qNMg1eXP2xow@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
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
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.3-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 0f3bc3a11114624b6a964915954396db0dfd5c9d
* git describe: v6.6.2-526-g0f3bc3a11114
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2-526-g0f3bc3a11114

## Test Regressions (compared to v6.6.2)

## Metric Regressions (compared to v6.6.2)

## Test Fixes (compared to v6.6.2)

## Metric Fixes (compared to v6.6.2)

## Test result summary
total: 150377, pass: 129261, fail: 2399, skip: 18597, xfail: 120

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
* kselftest-livepatch
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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* libgpiod
* libhugetlbfs
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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

