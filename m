Return-Path: <stable+bounces-150706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF6ACC638
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C772A188D18D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433122F764;
	Tue,  3 Jun 2025 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmrjhwnb"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E3205AD7
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952880; cv=none; b=mO6b35n6Xy9CXaEQp3stzcHVjprD+smu3EtqrqCCtqpTw1kVj82kZV73bupUiEPr6PR6r5jse0MjU9aXua+jUOn7efzcN8uSQNYQ3uZxiLCOKjeqR6BGi8ksl+Mh8t92Xva+9UdF6BdGVesM5asWdP2SNogjdcEbmZuYdzPD2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952880; c=relaxed/simple;
	bh=t6VACjOwekeSdoTcNJF/T+YgRqCVuvNSNERLhcOem5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVrkDJfqn2AjZ3ko38W7aK3k0rGLi2uRWrbKzbgjD1aNb107MmWb7sqeTlmgZfxYH5k+RrwfuS+Sudo0USvHLhJQ1mqgZy0UWVb3pCPZaQ5jqOFx2R65+IaLbo6a2nL1lCSuRIiaOsUoA56XOYWWkunWeMm1J5v2ucj9qbnL2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmrjhwnb; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e45cfc3a26so3913194137.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748952876; x=1749557676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekMu844lc62J2cT/hTWiYp5z39/Arp1wDxCaIiaTRQ8=;
        b=zmrjhwnbIC8jDqKguWd79ZZt5Rfd5iAz+Q2oE/EFV5q+9+iMat/rJd6lB3u9KvRjQw
         /vAiuricHwaqE6SbIzx2q6gBigRzxhrD4EAioZH2mv9xH8TrA6ABu8Z+/Z6pYa8vR4VJ
         OoqDltDCGVgvhgO3Q/5oXpc8THLcAiBT+jl5qWf6zbgRE2IbxoS7n5FIKkXQPpnFjqnn
         6gDd0Zp6vKW0V+pTicj1/B3rWLIFb6WsMevIivsTnxwelklO72fIfpNWFVcSpLUhJ9yc
         IpF8NY0Cvlg3mj840gNE6s6PXfeU6qqYXQShltmmPnDHzdZE5a2hBsCv57zPHP1fMkMN
         u85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748952876; x=1749557676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekMu844lc62J2cT/hTWiYp5z39/Arp1wDxCaIiaTRQ8=;
        b=ektt826+j0fxvuwSwc8MV0BQRyQg4tPZiFeFXgWXYv6Sh0YhYLP90YZYjcTOZ78JyD
         SOAiiiTmlZ+rwbpdX6ShepBVKKiUdHtX7z2clPwXxuysFw4XQW3QXK+P3tBu5CJtKR2G
         DFs8EG7Z4ajJDG0/sXaUJE9ggJ7P6IDJxYYWaSMTd8ARWH8sQyZx3OK+Be2i7Qt3lVMX
         nOZcVIPSkta16mf2Phki0EZqQF1XsV4CFiQ5mSEQjq9RRbOnNh7xD1SS3UVa/klxP/eR
         QzkmA8bMxFbeavgI4sqtW4nuKVoQD8fx3QXpGMUtor6/Tx4uyPki3qOCGCD/AWiBp914
         C/MQ==
X-Gm-Message-State: AOJu0YzmInBGDWq0iOsk+RL4Rm4L8dX90nPTzv1EKBQ+h0FuYIADIBMk
	KVikNhoBBpfgUrIAvyzF7yfdXQlZVKCUP3e3QZk2wTCbmIa68vIerXO1Jp0WocNJORJNW5a0Gnl
	8SBE7esoGpq1YpSSSWJqlGsmahwOYXuI4QT72jRo3LA==
X-Gm-Gg: ASbGncsw4Xs4ni0VGBX0OMyGBmT/oFnyOKmDhd8ixt64dJefiXlLO8t4/u6WNIUXAUU
	Odue7BHp90IEYriQhJoGjqKVTFr+RQa7b2BiE5L31u4c8sRqEF43pA3uP4N9YxM1C/qS7wtOenq
	87u87fu/KMwrzBQdpQuuKC7dtThgFZk5CpEEjmqiTktg==
X-Google-Smtp-Source: AGHT+IHiguH/q/uOG6AU4kDV0YQqPceDg6Ud9t4FMNb+4rqbBbm2F1nz7LfKFd2Q4SlCoMcQHCIYagI1s9WlCBukVG0=
X-Received: by 2002:a67:eb0f:0:b0:4e1:441d:be9f with SMTP id
 ada2fe7eead31-4e736014deamr1157543137.2.1748952876505; Tue, 03 Jun 2025
 05:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134237.940995114@linuxfoundation.org>
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 17:44:25 +0530
X-Gm-Features: AX0GCFtcVR-C4Oy5JyTm99FTojQYH7IOaO2ypXBtQVxYm4_OVJOIEFtSBGiuXhg
Message-ID: <CA+G9fYtv6GPx0guY03DXBwoCcM-VdWHwUy5mScP=cP2g7zzo0g@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 19:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 86677b94d603c727f6b88b4b77bfce2601aa4465
* git describe: v6.15-50-g86677b94d603
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
-50-g86677b94d603

## Test Regressions (compared to v6.15)

## Metric Regressions (compared to v6.15)

## Test Fixes (compared to v6.15)

## Metric Fixes (compared to v6.15)

## Test result summary
total: 321892, pass: 296354, fail: 6075, skip: 19463, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 55 passed, 1 failed, 1 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
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
* ltp-ipc
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
* rcutor[
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

