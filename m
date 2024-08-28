Return-Path: <stable+bounces-71417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D17962A59
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B2FB21172
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A01898EC;
	Wed, 28 Aug 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3Q/mxC1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018018801A
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855682; cv=none; b=Fy5harNypdbzOTJHamDvkFDxKx/WS+2xpUJ6Xr4pMqvBhKg0t9leBXtPSmHa0dRGlFCCJNAzoOOHHi1pdKPZTk9Ng5l7YU153uOCxqygshPNta1yCp+87oaQktIN9zXweB7amJnBbVeGqxgJnGq/lf6P9p9hLaCc85ssZdSS9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855682; c=relaxed/simple;
	bh=CI4CXriw67wC68iskUm0bZE+6Nt/fOtp76fyzaDXIBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz5zITyFmnhBhRTuAxWJJBSFmJVDMwyLBWaku/Y8EK/y/Q1Esf0Y/iURUMHLIYwEGZchqgkkHIUQsisppPdKn9r28UEuOh+ajEU/cKl6Mx9RO7uJX5J7lkSQYDHX79ldaXCweRQZB2RQsX+GGnf2nRiyXAl9o6mY5H1omx0/h2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3Q/mxC1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a4df9dc885so48235985a.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724855680; x=1725460480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyUo6RUUr6GklVooVru1PomCfQxfqpdR7hVYNrLOVFg=;
        b=E3Q/mxC1retEzgdYTp+Wp2cTs00/cVAU6QVTd8s6x8b18gVkxT/iPnUf7XCBN1VEtr
         p2cm+0rI1br6zRsSmX8Uhqp0MenHT9bTjWX8kttgeExnc65joap/LKPLbmndHIymLMC9
         WReongYmvKBaMPKtAB/7qzXyEjhbwksT3f5TuStsWWKMuxvqlPGDkhWlYcPicWKaPNnI
         C5AM7boXbTPxxl6YSvfluRFVfvJVHR1m7oQ6LWN5SKmeaBt4qb0UvjMkQu1BlGgSyK3+
         ofOqSJksCmLf74EvYmpoICp781KVIoDofgvVnSwunyfBoRuKFypsVw0YxOsOFVz1SupA
         XuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855680; x=1725460480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyUo6RUUr6GklVooVru1PomCfQxfqpdR7hVYNrLOVFg=;
        b=gi9fG/CUjTC0dKIW34qfqFNBslIRVgoK614M51kFsSf2mf6BHGrLxKPoKCjhfhcaSa
         831Pc0xFcGcjIptJE1DGDVuYhBjQU0SSlAW71cm6lGhejnbXoAmNLDYbYtuxsr/AxkgU
         XXEz1FsMzP/Bd4kELPYrC+ITvuL2aGKabiI13CXGXVhqrWJnMn66OoyuDSvQ5VU/fyZE
         jxCvHuJtM/ogKWuIfZhyzbJA1TdwSc1pO5QrODV+XZkqkvcve3BkgPGtCMP3OafS/f5c
         q2aDEVW/RC0ouMiPtXL1tdmEJS/R9pg9mZ8Z+FlCbK86IZo+jrPQ3aljhmkUIeglF+aw
         X/LQ==
X-Gm-Message-State: AOJu0Yz8gr7IkSPjzqz0hKyUPiWgGegZ4fwvWpJwt9V/olLBJwtdLeUa
	WVOBBlzyrxBdh02FlLvN0yy6aFPCdo8UH2My0KXw7NoMj4rifvD+VmhFIPwAV2nlJlCgttM8pSb
	U1S/RWRbjFTqyuEgLqYFnsPI5ovyPYQf573NDaK27EhRy3GAZiis=
X-Google-Smtp-Source: AGHT+IEmRhy3Ri7l+t9MTzUjqcgJRsQ6zYubfPpsh9IZnoAxSLNHwf8XAweS0vRUop5x8D4Zqj0ISY/ukGb1nnceqlE=
X-Received: by 2002:a05:620a:44cf:b0:79f:aa9:b3a0 with SMTP id
 af79cd13be357-7a7f4199661mr424667685a.13.1724855679800; Wed, 28 Aug 2024
 07:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143838.192435816@linuxfoundation.org>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Aug 2024 20:04:27 +0530
Message-ID: <CA+G9fYsUxRMXOZi6skrOV+ZOo0yCj6NrmBFi5CptTdRRQzWXpw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 20:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.107-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The tinyconfig builds failed for all architectures on 6.1.107-rc1.

Builds:
  - clang-18-tinyconfig
  - clang-nightly-tinyconfig
  - gcc-13-tinyconfig
  - gcc-8-tinyconfig

lore links:
 - https://lore.kernel.org/stable/CA+G9fYuS47-zRgv9GY3XO54GN_4EHPFe7jGR50ZoChEYeN0ihg@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.107-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: b9218327d235d21e2e82c8dc6a8ef4a389c9c6a6
* git describe: v6.1.106-322-gb9218327d235
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.106-322-gb9218327d235

## Test Regressions (compared to v6.1.105-39-g09ce23af4dbb)
* arm64, build
* arm, build
* i386, build
* x86_64, build
  - clang-18-tinyconfig
  - clang-nightly-tinyconfig
  - gcc-13-tinyconfig
  - gcc-8-tinyconfig

## Metric Regressions (compared to v6.1.105-39-g09ce23af4dbb)

## Test Fixes (compared to v6.1.105-39-g09ce23af4dbb)

## Metric Fixes (compared to v6.1.105-39-g09ce23af4dbb)

## Test result summary
total: 141679, pass: 122248, fail: 2025, skip: 17193, xfail: 213

## Build Summary
* arc: 5 total, 4 passed, 1 failed
* arm: 135 total, 131 passed, 4 failed
* arm64: 41 total, 37 passed, 4 failed
* i386: 28 total, 23 passed, 5 failed
* mips: 26 total, 21 passed, 5 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 21 passed, 15 failed
* riscv: 11 total, 8 passed, 3 failed
* s390: 14 total, 10 passed, 4 failed
* sh: 10 total, 8 passed, 2 failed
* sparc: 7 total, 5 passed, 2 failed
* x86_64: 33 total, 29 passed, 4 failed

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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
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

