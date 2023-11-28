Return-Path: <stable+bounces-2890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CA7FB9CD
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB3A1C21249
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D84F8A6;
	Tue, 28 Nov 2023 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPowrISi"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048BBB0
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 04:00:10 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45d94e7759eso1581959137.1
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 04:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701172809; x=1701777609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8mw1BBxaan41I9CSKaTQssL+4Iit3B3xfGkQ2tsLjQ=;
        b=bPowrISifx0CtGUe6Qid5AnT1qLi3pPNtvhN3x6QZ0D1hfGQ5ECVlfwfEyEHn6XWo1
         YSxuA7skJcQdOWnKP+mQwkaqkkusGoHMwCAqOE4LY9vL+X8HHBxDT938zELCNo8qQ91f
         FLB2CUzNVAN1YazZLn5m/3OkfLL8GAnaaMzSh5BXQ8afwgKK0e/cyP9zw+rs134R50Gd
         5P5D2obHfYVjk2jG7MW5LOf6g0TF1vLUCgecvTaS4Oue67N5ds4qiAeN1L+zDtJZH81S
         sCqy1mRnoAafiPZR0aB2Ih5/9N5XGuRiG4g0O/bOtx+3IDw+T8HPgJ7HIpNFElV637st
         5NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172809; x=1701777609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8mw1BBxaan41I9CSKaTQssL+4Iit3B3xfGkQ2tsLjQ=;
        b=NYWLCMF0P9AJPh5y9ThTdzVM5WnN1m9DeaExQo62QaYRszrreDKQ7TDdUPa1/w/BRY
         8y6dqDiWC/Mqyv0HyPdFUgtvNlz8E84cisCnVsKllA7cYntLYVeqMwg7qSUdkMllSIE6
         xf3uh5OxHAvwT8ceKnlz0A4zFpitGrvcBBvTPwePEIMbnX1FEF55wFu1Q4Y6SfyGBrxH
         86MAVBrC8MdINUOonkifI98DIrBrin0YpZi/dZXr6FWW26wUVZlsKLyfHPqlErya9+O9
         hAezIemgaWWuH8zDOZNkLlkyVY6H+nyqCcdNzPRRUL5NmAswgqI5rkdCVUfNo/Z0UlBP
         e8aQ==
X-Gm-Message-State: AOJu0YwvcMehw5KW6gn90VyDubh/kD1Yr8zbcnbGscN1lankTkwhLxG3
	SVQp2ZzNhn5FFMEB4gmPPTa6t3LyaMQwgQTA7CHlew==
X-Google-Smtp-Source: AGHT+IFfqgv/3Uaurmh33ezO33O76n9Jf80DJ8xYWK8+FGfFie2AFINkJF8CYB6v9LFf/UozfxTwG+pmSmxcxoxLciw=
X-Received: by 2002:a05:6102:34f1:b0:462:8d09:93d2 with SMTP id
 bi17-20020a05610234f100b004628d0993d2mr14651660vsb.3.1701172808970; Tue, 28
 Nov 2023 04:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154348.824037389@linuxfoundation.org>
In-Reply-To: <20231126154348.824037389@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Nov 2023 17:29:48 +0530
Message-ID: <CA+G9fYveNT9jVqUSrugWQ9aRq2XrCGOdEnqxoieaSiSKE_vJiw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/292] 5.15.140-rc3 review
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
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
1)
Perf: PMU_events_subtest_1 / 2  - fails on all qemu-armv7 and TI x15 device.
These perf failures are also noticed on mainline / vanila kernel on 32-bit arch.

## Build
* kernel: 5.15.140-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 659e621811001944973a85712a1f1ce31200daec
* git describe: v5.15.139-292-g659e62181100
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.139-292-g659e62181100

## Test Regressions (compared to v5.15.139)

## Metric Regressions (compared to v5.15.139)

## Test Fixes (compared to v5.15.139)

## Metric Fixes (compared to v5.15.139)

## Test result summary
total: 96041, pass: 75848, fail: 2597, skip: 17534, xfail: 62

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
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
* libgpiod
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

