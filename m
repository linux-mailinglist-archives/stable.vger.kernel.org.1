Return-Path: <stable+bounces-160288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B793CAFA467
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742987A5D32
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987031F8BCB;
	Sun,  6 Jul 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9Pr1rxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCF1E9B3D
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797215; cv=none; b=pxBjYdbj/cnR1eEa7EuoGxRR0/u2W4vKGzz3MGXccaVQAVBTBzTzcJSytMoJ2zN9C2mK36p+OTM1y6XYadR3jhmB11yu6lmTfHRAXmsGtZrkNz2Kt8OMttBiCbzhfOitDNloVndXNXfDWlQGU45La5cqAc46A88e9lCFUWXTIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797215; c=relaxed/simple;
	bh=3i4oNzoxPApaR7jJuESFYKij3qYI8FDE7ecJ4O4s6v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJaeXRfrj500RPDf16WPzaC3RuMN4sRBrsUnSJBhdRqiEfBIMoQdjApCe4YCkbHNayq7TPnupROcUCaePatZP61QwDffVgHbyanX9mYAEBa3DsyQEUbmBRXAtHvYMx0utWS9cA+blCW+MrpjMxOWZTm0XNHjHSSwjyPpHw5zNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9Pr1rxh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so2170749a91.1
        for <stable@vger.kernel.org>; Sun, 06 Jul 2025 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751797213; x=1752402013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJC1YnqRsI/+BxDwAPn1fBTIKeVMKtwCwKSxFcD1Pmc=;
        b=t9Pr1rxhzmqWhUCsBOBszbpjkx6P4w1d1BpQAk9lcUvKSBokdW+Afzwha/Y5pXFGtJ
         gRjIjPbd4PmofjCJvggeZ/MLDdgKYdpOg4qhp9M+1w+hn/LS8BeH3dl8f6fdzQQSti6U
         AzauP5sEDY3izCVQNJJb1tbO0gn8UkSc330qbkh8r4ohMINZ35mKYq/ycbB4SsqD/G+B
         21RYa7hC0DTgxcUjU2x2gIKtkrzfr0JfInA3RZl5p+LqACHo+FBN3cDbFMuq2tb1l81z
         hSyhX5VAXqq0SqJ0y2XZX1PMoixZoYfvnNmUlvmgJ0JUWYcBjzm5H4zHm9I/zmqzoTLO
         MFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751797213; x=1752402013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJC1YnqRsI/+BxDwAPn1fBTIKeVMKtwCwKSxFcD1Pmc=;
        b=IHg3fPac/WcYZjpJro9//wAelrcTf1u7/PLdoSn7MytHLMmt8MbP8+nK8u3h07bMAI
         I/a1Qontp6ic3+CkDrbdIkKrcmNfODM4aKWvmal55jb4orcnj+P/tMGRVR+Q5eLlVHQi
         292ySkwPqprxqShIGfo8AaMwAYb9w6AdHnPuKifcfV4f43+Kwn7cZoswI+AKCcmN7v0u
         5OOgTAwQclClQ/+zmrmxbfmwlyALe+NUmiIePO5ne6lncfuvBD1icb8djusDkw2w3njQ
         q36p0mvJlJZ7Wg/6AAcHNtJ07Iicm9bNGw0rF6eHBa+Qg654VbARdNwtMyTEsY3hUZnh
         4RNg==
X-Gm-Message-State: AOJu0YxF0LR/q+mnzwdIjNkpbXnI+10r48KpR0ftCfkFAxPlcXmWKwve
	vkkW2S4vsWtKX/o8SLNegNcTcqoF9nkpr6TrP0TMaGZ+Jw3WzuvEC0zZF/2r30CkEIqg7rnnXHv
	NxPk4yiJyDpnYlgBypUq5WuPsAhA6poy4dS37e7m8pQ==
X-Gm-Gg: ASbGncv/9rEELQVGxJ1uEwwLkLv6yVlR9cpWdbGj6JV30U3RdP3eoD37yLZfDKzFzKL
	uRmWcSJzYZWau/Dkf+Tnwztl7ZIoUkqGFAd7XMaBb5YKWXNQRSMkJY3C8ELmKG8M1gYz/E6/LKZ
	/j2B3NBTU/Bhg+4vuve2lfxD/1iT4alFBmqIFQdaO+1C6Pvg==
X-Google-Smtp-Source: AGHT+IFQ/yDgnJfWcTEvzzr/hLpoYvYM+BA8AZGWWKSHWa4EZGYJ4x258RaKhie34g761N9q4rOdXTFzMTulgstLuuc=
X-Received: by 2002:a17:90b:2f43:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-31aba85c314mr8110906a91.15.1751797212944; Sun, 06 Jul 2025
 03:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704125604.759558342@linuxfoundation.org>
In-Reply-To: <20250704125604.759558342@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 6 Jul 2025 15:50:01 +0530
X-Gm-Features: Ac12FXyH1VcLc-KLE5gEDuJ2sOEzP3oBxjxO9umnS5MCIQGy6hwVYE4nMG3n24Q
Message-ID: <CA+G9fYvidpyHTQ179dAJ4TSdhthC-Mtjuks5iQjMf+ovfPQbTg@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, jakub.lewalski@nokia.com, 
	Elodie Decerle <elodie.decerle@nokia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 20:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 06 Jul 2025 12:55:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Approximately 20% of devices are experiencing intermittent boot failures
with this kernel version. The issue appears to be related to auto login
failures, where an incorrect password is being detected on the serial
console during the login process.

We are investigating this problem.

Test environments:
 - dragonboard-410c
 - dragonboard-845c
 - e850-96
 - juno-r2
 - rk3399-rock-pi-4b
 - x86

Regression Analysis:
- New regression? Yes
- Reproducibility? 20% only

Test regression: 6.15.5-rc2 auto login failed Login incorrect

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## log in problem

runner-ns46nmmj-project-40964107-concurrent-0 login: #
Password:
Login incorrect
runner-ns46nmmj-project-40964107-concurrent-0 login:

* log 1: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb/testrun/29021685/suite/boot/test/clang-20-lkftconfig/log
* log 2: https://qa-reports.linaro.org/api/testruns/29021720/log_file/
* Boot test: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.4-264-gf6977c36decb/boot/clang-20-lkftconfig/
* LAVA jobs 1: https://lkft.validation.linaro.org/scheduler/job/8344153#L1186
* LAVA jobs 2: https://lkft.validation.linaro.org/scheduler/job/8343870#L1266

## Build
* kernel: 6.15.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f6977c36decb0875e78bdb8599749bce1e84c753
* git describe: v6.15.4-264-gf6977c36decb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb

## Test Regressions (compared to v6.15.3-590-gd93bc5feded1)
* dragonboard-410c, boot
  - clang-20-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-13-lkftconfig-debug

* dragonboard-845c, boot
  - clang-20-lkftconfig
  - korg-clang-20-lkftconfig-lto-thing

* dragonboard-845c-compat, boot
  - gcc-13-lkftconfig-compat

* e850-96, boot
  - gcc-13-lkftconfig-no-kselftest-frag

* juno-r2, boot
  - clang-20-lkftconfig
  - gcc-13-lkftconfig-debug
  - gcc-13-lkftconfig-kselftest

* rk3399-rock-pi-4b, boot
  - clang-20-lkftconfig

* x86, boot
  - clang-20-lkftconfig
  - clang-20-lkftconfig-no-kselftest-frag
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-defconfig-preempt_rt
  - gcc-13-lkftconfig-no-kselftest-frag

## Metric Regressions (compared to v6.15.3-590-gd93bc5feded1)

## Test Fixes (compared to v6.15.3-590-gd93bc5feded1)

## Metric Fixes (compared to v6.15.3-590-gd93bc5feded1)

## Test result summary
total: 259237, pass: 235906, fail: 6376, skip: 16955, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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
* modules
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

