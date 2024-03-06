Return-Path: <stable+bounces-26937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11887344F
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E571C214C5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CD5D8E5;
	Wed,  6 Mar 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0PU2SIA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175B5FBB7
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721205; cv=none; b=tWIzv4A7xopsBie+zUJr0H6ePuSnlXxF1nunhkJhcsR9BFkrGRMBWIvW8+loa+vjMyRPj6aTumw+86g+wIozSSyg8R1FneGB/31dXpjzmS2+/CUYfqPJNGAcuWwI4GeI2OnFVLbJt2w2unSr55mZfYd59SLwodND70u+K9pYE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721205; c=relaxed/simple;
	bh=r8I7d25oS9grIAnDMBNqKWHgDV8KDouDSkKqAk9Cgqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqGjJhJA6QLCHWr+NZvkpAIsYeGVRRzEX6BztUIRzSyvKPbpjIBNdPno4AIDwQN6Ru1q6NJoNLJzUSTdoRCpEGUdeqtzpYHfcg5FAWDPCoHSRMI1l8pBYDhZxyoMZQfCgVqd28dabiqUSuNQIv/K9/+c8nzXqrzX7G77YYR2ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0PU2SIA; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4727e38ec10so1404409137.1
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 02:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709721203; x=1710326003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFkaMIm1obtudGJ1kf1EFFHAyCZ7GxqkHja4nTwRsKA=;
        b=C0PU2SIA3qaEwyrBdfLuRX5MBjFNkJ/xqs3aZufVTsXCaoxBVcNnPjnkRLZRkaU78f
         L/iU9qDQiNMj24lg5aZPdma/srV1UaulmY2Ifp3/LcHTu6zuOV3pLWG2Jwc/rJE/iYIn
         WDPytyAa8tbbt2icPrCMzgo8eBOnd/+MgkCijzxEx54uOVWhBcKNHZk7QyJCp6cD/VGc
         5CiUJE2tRI+YKJD/vRduNffdjaUryUReCOgWmP/Cwg9D93ZQFvMfiPeks/cDACjwvssV
         SyYr8+1B5Y2Ypaxfi3fWZTeXNU3ItOzk8otfvly/LD9DlgJRsoCKgub/AtpJqKunuu0d
         IyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721203; x=1710326003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFkaMIm1obtudGJ1kf1EFFHAyCZ7GxqkHja4nTwRsKA=;
        b=v51HYF0dVVGbeh83QOIgr6Q81XJgEHkwRlddGhzpF13F34vHAe8cvCKnD+nfBx9DYf
         RpsWUmwf3GhR6WC8OPDEykt6YiPT9zGVMvoIFT2+v7FBo9lYsBqmHfv2sFW109vQoKJO
         /q9oRCyeQuy7H846bMwfvWRRudM/rWUsySgjBI1DF3Sl64OVJUCzFF/YKaRwlHV1lNzD
         kQtgxxD6OsNvOJI128z1l4EdPJGQBT16B1G5n3GMme6U3mqrig1plkATP7gOCzomzjb1
         l1DDgX5dImi2OQ8B+M3cWqcYhyh6q9uiEcUXUuGDSRkP2Mi1+cgkxjQ+SOyhNfTCJ4zj
         ON/A==
X-Gm-Message-State: AOJu0YyWYBhy0xDWpRD0U84JqqGXIwM7u5yFgqG3ubYTwPPZKCBGnEeI
	gVp5PO0+5cmprlX/M99RYranXkMGHk6X6+2Cr0eThOfghV7fGuip1WJLzpFYVBUlJeYkjasGL+/
	Ri1Db6LciogK3bwa7rRlULFNjGxpheHmKaSyO7Q==
X-Google-Smtp-Source: AGHT+IE0x77S84TtLxcOdVNEf09H8CAh/J0+qhX6uQO+4pPNNBGqMdIxF9axcvTED4L7HLfrhT+Eebw3d0oNaEqcLAk=
X-Received: by 2002:a67:fd8b:0:b0:471:e8d5:8c8c with SMTP id
 k11-20020a67fd8b000000b00471e8d58c8cmr4596459vsq.26.1709721202759; Wed, 06
 Mar 2024 02:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211556.993132804@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 16:03:11 +0530
Message-ID: <CA+G9fYvcS6gy_-pbiqwFoJh=s_ocLGh0TSZR-zNiTSh9smZWfg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 03:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.81-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: cf578ac947cbb5bb72cbaa7a166d0f92318c3126
* git describe: v6.1.79-411-gcf578ac947cb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
9-411-gcf578ac947cb

## Test Regressions (compared to v6.1.79)

## Metric Regressions (compared to v6.1.79)

## Test Fixes (compared to v6.1.79)

## Metric Fixes (compared to v6.1.79)

## Test result summary
total: 142733, pass: 122117, fail: 2309, skip: 18166, xfail: 141

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
* kselftest-mm
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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

