Return-Path: <stable+bounces-80623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5E98E980
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 07:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABD6285F68
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 05:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BB42049;
	Thu,  3 Oct 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzYEGM5S"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D14C8FE
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727934360; cv=none; b=Xs45+sqxvpEuT7XWAgZngCJaB91yPSP8UzLu2nW9AXYmJkAT6bjHkDq5gNrrrU4SFoEnpo9fci40XJiB46Tvp4XKf9DixdTLdPG22qoznAWOYnKOAMsjr0V9TmriDCLxJapmhYrR3Vz9mxAu2YuYVRlNd9iM+QgFwsFGOqsUUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727934360; c=relaxed/simple;
	bh=7VB1xwuRR8UQe+a/YaYfy7RKFBUy5OIT8gml3aNe52M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzTCdKnLUY4bOJhx45wW4H9c5mjT5ht/94f2ogXy8r5gUQdCdToppd4SDMympkKUucWOZ20UzC+rF0wAgruSGg3Hon/Y0eMAw3pugW9Wvz/3lbPK9k7SZmiXJazZVXkootSB1B45KQj4xrKE8e0GxnUJdhtsQYtxK5MA/ZLKEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzYEGM5S; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50a9ca93e71so177766e0c.3
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727934357; x=1728539157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYnUWcnI0m9f5QC5Cm9op/4MJS0/hwrdxOc5nlsYkAM=;
        b=TzYEGM5SjE/MI1Hr2tWVPMPLnkL2PF1j759GvNNOfoWeB35WLHFPlYojc8VLai7gmM
         7gLj/ps82RQ+73FoHDS16k8/q0ng6t1sYBSVrqwNjW+z/VbRqPUIXfQU5Bbpm8mFjPVB
         cz922zhAkAdvcHNmzT3Edjcv9HxI/fXn2MsA9wbwEJtsdzHAhthrHn+zqBaWjFm1gtV1
         qs33VW2HOjRqkvM3lo8psRRP4olOWTgTx4Tw9s6MMKAk6OfLdpzanbcIuz2aTABAFPHk
         U//E4wKdappy64fP/5JevsKAxYNcXhcT3GHNw6mkxrangsZs1SImzw+1l44JY/8kVFeZ
         Xx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727934357; x=1728539157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYnUWcnI0m9f5QC5Cm9op/4MJS0/hwrdxOc5nlsYkAM=;
        b=cHEUj8o9YsVZSBWxrPhlOGb7gCwO+4gRYUxUnaJ123n/nQN0MCgbQOjHSIAAGHJHLk
         dbJRhmnr/gEpL78C+wq0fTQ7H3HXY4xKM/V1aQDto7aHyUBGI/gzsQ5/hqVRlKQx7Toa
         OA91cNOxUjpT7cdKBA7jxpBLRvN7mJ+PdpCo5qALW0l9iIN2h+ddn5k14yL8OTjmJvhP
         qOavmAINREpx/VgHvBKDZ82wFuo//Hq/TbK5Ms7v22E8u3BkIfXj99qeLYS7z4x4RQMO
         pE0nel73qO/fC3yu22P5tTMIcaZnKjrcxbW/Qfok6Uw8cij6BOGz95JcMNo4KrEVmSCF
         FJbQ==
X-Gm-Message-State: AOJu0YxAdpFW1gYOqCN/VcRz44quoKH9+QHqWDeEZL1r+c4L93iXY5Jh
	Nc8u2XA5zdRRO3cL7aV/m5QJ+B2v1dW/G8EF7UpusdJ3h7tFmDvHjgPax/upSIOgbMyJglZYCZk
	6sYFI/i/UUETh4E1jYXOBKAGROKexVlAqgKRIiCbomM0dHTGZsX4=
X-Google-Smtp-Source: AGHT+IFpH4XX7rfYGKfWBYMuNXQ88HCKR/3QMKVyiHnotXvFJGZug8zkeuptdJDqYvH/9P7T0UeM3MKDZoV6nnKyT1I=
X-Received: by 2002:a05:6122:338a:b0:4ef:5b2c:df41 with SMTP id
 71dfb90a1353d-50c58265495mr4544590e0c.9.1727934357251; Wed, 02 Oct 2024
 22:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125811.070689334@linuxfoundation.org>
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Oct 2024 11:15:46 +0530
Message-ID: <CA+G9fYuv=ZKfhFTcykDDit2DKVJSsjeVP4=c8PG7t4-nuKKcgw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
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

On Wed, 2 Oct 2024 at 19:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.13-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f5f9dc8965d511c0bab748c48b3456a1d5cfca61
* git describe: v6.10.12-635-gf5f9dc8965d5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.12-635-gf5f9dc8965d5

## Test Regressions (compared to v6.10.10-178-g8b49a95a8604)

## Metric Regressions (compared to v6.10.10-178-g8b49a95a8604)

## Test Fixes (compared to v6.10.10-178-g8b49a95a8604)

## Metric Fixes (compared to v6.10.10-178-g8b49a95a8604)

## Test result summary
total: 214298, pass: 188888, fail: 1735, skip: 23195, xfail: 480

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 35 total, 34 passed, 1 failed

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
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

