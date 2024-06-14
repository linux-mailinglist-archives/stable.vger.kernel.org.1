Return-Path: <stable+bounces-52139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87422908390
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404F4B21EED
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E11482FD;
	Fri, 14 Jun 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi1hOcjQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363761474D0
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345672; cv=none; b=bG6x0KWl1Eh/uJM0Ae0BOHL4aNb/JbWShlCXLH578QRdpiwBJlHVJEMapqSablUV4C8VYvbj1hX3czL4ZCny4XnPbdTecaXULCO74oDVYbaLpYdtrMpXfv4pQvD22RiEbjWePYnGLyzr+JQTqbgtGuACKKWIwUHIWs9lh5ryx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345672; c=relaxed/simple;
	bh=MytOr15lMP9zYsxVhkxbv0AtZvnkkeakkDkldFUcRxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGUJnXfkYlLWsCpnewhivevTaBOcAMB40plPEsmAAL63skFuUdPnVB5M8mMuhTsAFRp+V+v70VsRtPoPSgE/TIKAchm/E42kIotFwCXL2tx9N0eTlrKbdMHhPtCz7Nd1alco6bCBssvTrWDGG9EpMyFnSB9Mz1fsVyjz0z7C3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gi1hOcjQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48d72c72079so577063137.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718345668; x=1718950468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoQCHg8nTsh29WFdq4yg901so4FoHg732Ietl0cilNY=;
        b=Gi1hOcjQcQZqEvNE79kA13iXLzzPyDrPsPoYeKlymEOQuXOGsY5m13Cztxh3h8j4xI
         0CAQA7oSWuynGDo9mZuff/j+Ymw2n+IR8NK9QeraAFQ2Tpjd4uBrh8gEoS3V+/jXK060
         CcvvgMuMV6oyt2yRO56UpUnMiD9e9tyeVabf8dpXdQn1O9bOTLUfePE8VDZchTXCGH3H
         68voNGNYD0o6ShraEjYYXROZZSvRGXSJ0c2yt5K3piVpqcCRWakpdkvexXhNax8eL6q3
         YpqdMd7HkxznWyaRjWyCrhVUuiRbD6no2OK149mTNAbWrzuc16+xVWbnielNwiIOlcv3
         eTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718345668; x=1718950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoQCHg8nTsh29WFdq4yg901so4FoHg732Ietl0cilNY=;
        b=FNypbpO9TtRS7zmDKnXswyRpICWVF1uuu4mGDR53P7qATZIpwtz0o9DIh+PtntjP16
         xAn2iwFmqQkEvM06WrB6UZFKvKbFYgd7tgq4ebm7Kjt1MAsWJuZF275NKBrubKc6PBWq
         UQoYuVqIBy4M16ipCtutsYTefQDQLVWaXazvu0E2r53ItTSyfNq7wLuYKaeOm5wFLWpI
         umgWDUNQmMlYE/nV7SC/BVq76VAu4D8g5dw1yTfvlj18jP60TAa4SM+IVPJrlRw03H+z
         a0FmNa+WpDW5KFKRh0CuXma0LE7XvfhQqaEusixYmANwaI3vitLqXPU3jbDnzVtHqmDb
         F12g==
X-Gm-Message-State: AOJu0YyF5HFZMgiPfXJXJDdoEMcLhXmt1PxvddLXb5hx9TZ+TYzVdFEC
	H8XuhC2kvscjT6e/Hq3WjXvcnd0/wbWpNehgo5FBt5tZKNLyQPd1BZ9D+zot6v243PXnzE6MFCr
	40JqDvFOKLhCK0iQvWlM3pWdUpC+tI6Nqd9r9LWf/z8OJQaN8z+w=
X-Google-Smtp-Source: AGHT+IEVZCYAAQG7nnH9roHg5Tyj8jl++9tnhsT+t3AfgbA2BKnr0VLls1SY6LHX7bDPAF2WAjTvShgUu929VcT/WkU=
X-Received: by 2002:a05:6102:124f:b0:48c:368c:3673 with SMTP id
 ada2fe7eead31-48dae404fe1mr1824714137.28.1718345667916; Thu, 13 Jun 2024
 23:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.389465891@linuxfoundation.org>
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Jun 2024 11:44:16 +0530
Message-ID: <CA+G9fYsPRCZY+n3iJfLj-KhWzNHaG7q8198F+okV7zKPR9NVjA@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 at 17:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: 3fc8ec8cbfb63bed37f4702410201c973a690450
* git describe: v6.9.2-957-g3fc8ec8cbfb6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2=
-957-g3fc8ec8cbfb6

## Test Regressions (compared to v6.9.2-797-g4aee3af1daf2)

## Metric Regressions (compared to v6.9.2-797-g4aee3af1daf2)

## Test Fixes (compared to v6.9.2-797-g4aee3af1daf2)

## Metric Fixes (compared to v6.9.2-797-g4aee3af1daf2)

## Test result summary
total: 163101, pass: 141914, fail: 2059, skip: 19128, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* libhugetlbfs
* log-parser-boot
* log-parser-test
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
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

