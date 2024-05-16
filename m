Return-Path: <stable+bounces-45252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D129C8C7304
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5D1F228BA
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B01137920;
	Thu, 16 May 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPlYj8VS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE133401
	for <stable@vger.kernel.org>; Thu, 16 May 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848847; cv=none; b=E2gCSYMmiREF4zmN6hj/vSTdJ+Khv8i+xzjZToxAIUMK0YuMAbWemxYRamIuoHHmnwhljOwEPy1/9xNGJHtTT7is7UmYems0fUBlqy1P8OciPmjYIseagb4/BZgSs7pt1f7mEQv3X2ksJ2qLHsLH0c6MkmIZ/KuSGdxOYzW6Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848847; c=relaxed/simple;
	bh=roLqMz8FqyfVf6527S5XMqLSRWOu42nvwfArTsB08Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jA3ZdCCH+gT1585w8GDuc6rLEe/270zWlT+30b5fUMF4TivkkAQWYS+zsOIegPzRgJA6wDvKB0+JlFJCjhf1GMm0gEbeI92cvOsoV1sTvHehOSwrOCQzvzbGpA79GhQu1JzvG+wlV5dG0hXNTS2aVReZz959fRLA8oI4rtzUhWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPlYj8VS; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df6e7414fdso2441073e0c.0
        for <stable@vger.kernel.org>; Thu, 16 May 2024 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715848845; x=1716453645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNAVmwKwoWfzHs+l6xT+mMxjt2LA2ipTuVGLXkM2+bk=;
        b=aPlYj8VSvWVm3yjy/8UJVmUbpx6f4NYpxzaegxWJaa8X7LKStvp1fiWLwjPR9SM7TL
         G+/4oI9SklXZTAOM3PUv2kQau6IgBmaThuIB3NPBb5aVkkESjhBLNGc1aBMUpr6Hlzxp
         Jymun0X1+hLtvjWXVZ/NFSH5YYNDxauT6ntfjEoRdnsfM3BFPTlmJG1RAILQRETb3cpq
         ByZ1muN2VL07vm6q8/54HMPCl+LFybRI/vXGviWyq87K0HuSy+evWlzS2PJOza608jHn
         B8zJ206K95qRDHri12O2Xaw147BGSCk/hjo60t2kCK2i/UdfB34NZzaoknPsfnlA2jR/
         sTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848845; x=1716453645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNAVmwKwoWfzHs+l6xT+mMxjt2LA2ipTuVGLXkM2+bk=;
        b=hPPrEx3GuotTRwsFE7/FLTT6h9sxfRwLe6VOTjsZn9ZF0tl2zEFyxUEsBHsCpeDL11
         /x4KnmvP7GkftVh5hxaXsHn32T8Dwt2BoE8bB28GMB7wP4/BZzF7/+4YEKLy+poTAD60
         6/EsWCWjnsEBOjbsMMlAfMVfaBnRSWvBt248WsNSupO6KotBwbkv/leagF+TjnV21i9Q
         nP3jPB+AFpQNSOP68MDb31ppybt5Lk5LDIX2NjC2motsJLlj6N1bevye86RIj6WnQ01w
         0wn8yWqu2Z/gtdF0z/WKPVCJNKpyIiEHgoJaVmE74WkZa7ib7LKrMHplT57dNlFnPnTd
         zyXQ==
X-Gm-Message-State: AOJu0Yylhyww4WsxDoHbrlFfdk8ef4HOtjtH9kPS6acZxATDWFB00A1p
	FDVsl5MRQtH3Yq4GwR+D+9zHlhb5KMzP3n6oDZXj0Gz7vGt/V79CsF26l0eYqmn5nk+o6OnHTyB
	66qLucrFdSOttzo+Gni2xiT940qBA84euOrMtjw==
X-Google-Smtp-Source: AGHT+IGAczQ2X1s0QEP9pFvhWZ9B/pTAeRQwN6LW+rOGXflwh1HJZbZKRNSwz4WMtA43g7n/wWbl+4inojdNkhyvrSw=
X-Received: by 2002:a05:6122:2215:b0:4d4:1cb7:f57a with SMTP id
 71dfb90a1353d-4df882d2696mr15840836e0c.9.1715848843208; Thu, 16 May 2024
 01:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082345.213796290@linuxfoundation.org>
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 10:40:31 +0200
Message-ID: <CA+G9fYvtMyHwnPVjtp5vET9JWxXArPWdY_U4zrfA_ixNAPnmbw@mail.gmail.com>
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
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

On Wed, 15 May 2024 at 10:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.1-rc1.gz
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
* kernel: 6.9.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: 17f066a7f99c86ac634c661e8e013b124c4726b0
* git describe: v6.9-6-g17f066a7f99c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9-6=
-g17f066a7f99c

## Test Regressions (compared to v6.9)

## Metric Regressions (compared to v6.9)

## Test Fixes (compared to v6.9)

## Metric Fixes (compared to v6.9)

## Test result summary
total: 180327, pass: 155672, fail: 2287, skip: 22368, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
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

