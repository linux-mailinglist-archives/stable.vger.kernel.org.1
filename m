Return-Path: <stable+bounces-132044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DCA839AD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFBA7AF1FA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B622045A0;
	Thu, 10 Apr 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5TUqnNu"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F781D5143
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267571; cv=none; b=ZZtKv6RmHqmIEE8eMrH8vR5m3hABHo5QMRJ28xEe1hz3HKnwaOhcU3A22PZqIwP+ZVObpQlaowU4dvd+pPrL5i5Cf6uHp00BEeMDJy7gOYbmp/0IS4gl9T6AxTOS74MToIsOTvXNiFqK0GyAnM/1YCw63tdYmwjxM+vEPl2+8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267571; c=relaxed/simple;
	bh=sSr05Z4MTo64Ypvx2bVPKbPWej/18+F2EyIz2qX/qEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9nIAB4E/TXy2WiyejFjjdkvqqIe0tEpnDFbe6zHjoBWfjUiJO1E6I0XTSJoYsO4WYvTWdAQJcQ+WLLwuaFNlq9T7V/e4+ynRxWX0lj09u6xgPRobDGoP4m0F1KXmd00PULpDLlphEzVz2rgk6CGJJHCnwDTStpKui80xopogTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h5TUqnNu; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5240b014f47so241192e0c.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744267567; x=1744872367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPcT11jaYN5mShNHWtq3zBklcFvlC0Fzq1ASVJmlPp0=;
        b=h5TUqnNuDJ/7ldiVHNHiDEcsw4R7CfwAoxpVjXlEFM14+yo6ciKdwJwpF0Sn+F9SEH
         2FkCiOfZu4XDcId/lev1oWe4pMdH4UwXLl1xFeXQDWAPB8H4cyTwkiiZK5NWLc4c9b2L
         F3lwftE9pJwVQw0I6QVRpjM20ile+qzOHgv4m8J/X6ysHrJVJ7UjGNDeOG03PahNjirY
         8y/Ny7hhjVFQeGPSmnXZnKuHo4L7sWR9E+3KkuQwrXVO0v3v4UQFQ4yCMy8j0/qD+ghA
         3XGBZg6FfuAjROG441/tf6Kw3pUMTqRX2lV/RoWaNfXBMVJ7lKBf4Zz95skg8sEis1b9
         JC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267567; x=1744872367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPcT11jaYN5mShNHWtq3zBklcFvlC0Fzq1ASVJmlPp0=;
        b=m25HtWV2LX+qRq3+6zk1FflSqxJRoWXxnDx7cZtRbki0f3XBGptbKR4ZM5LQcgojy0
         AnkuGa+mrgun5Fq8HJFjG/qJtrSoM+nChpCoHAiE4ZJZbpk3VEhESsSJROFhl6sLcCxs
         C3uo1J7nMngFRtYhyVZDdpIaugCRzw/d1AtHeFcsdyaMayTYQV/4OZZ5dSpT6LOwzO4m
         cFr686NDZnK5bJK7SyFiJoc4n5tJ7s+L+YKSD3wqNsFO7twxtKE7xwX80cEJMMWFI/Zl
         CucRsqgFxUH/wSYtXDuLpstyaEmc9nlG9/hNDTu7reSaVwsuTSrVz2yexaOud+ZW7jDg
         W0Mg==
X-Gm-Message-State: AOJu0YwTGHlsQ9aJo8+JQEnyxaWI7A75vsVeYKz7eeRe7iNlU/DVzvVD
	QD0CQTUVGqgW1CikOq0BbuzSMIVLrQ4r8oH7lLNHgYJ/dlUNxLZJ1a6KProtwT4fijdbLYEiqbV
	ddYykA8+yTTbcPfzpXgOtO6kjvX/hDedMxO7CPA==
X-Gm-Gg: ASbGncvdQJ5aO2TjHEuE/6Hig+DkoeUJucFaHRdYEz2zY5teDTU5bMD6B0Kz7O8lkTZ
	h3rMaWvK69oJ5Zf1knCk+tskeYmWgFE7X/G9rSw7NaB6/TWgxBz8dOrhol4ShjnTGM231S/56H5
	XT0C/NoMIDLJtprR0TAACvsb03r007TuvK18Y0diEQDbJZSj0FvMRR0Ws=
X-Google-Smtp-Source: AGHT+IFcF58ptX8rME8i60brMH2Rz0ZUwEDEhM4pTRJ84EhXi3e5CvCfc4pa2+GApvjuzqUGXpEjK1FA2FeBPF3M7dk=
X-Received: by 2002:a05:6122:c84:b0:520:997d:d0b4 with SMTP id
 71dfb90a1353d-527b4fc7f4cmr1132792e0c.4.1744267567324; Wed, 09 Apr 2025
 23:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115859.721906906@linuxfoundation.org>
In-Reply-To: <20250409115859.721906906@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 12:15:56 +0530
X-Gm-Features: ATxdqUGvW4YOWgoXk4KI1NpcPGcMFtvH6xWIlP3CPREnWd0I0rRk9RpueS2FCe4
Message-ID: <CA+G9fYuB020QpRb2GHex2-0p-=zdhe60s+txw+UZhqSDLP5rHA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/426] 6.12.23-rc3 review
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

On Wed, 9 Apr 2025 at 17:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.23-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.23-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 27cbbf9f1b51b34889f65faffc14ab313869b880
* git describe: v6.12.22-427-g27cbbf9f1b51
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.22-427-g27cbbf9f1b51

## Test Regressions (compared to v6.12.19-371-g03f13769310a)

## Metric Regressions (compared to v6.12.19-371-g03f13769310a)

## Test Fixes (compared to v6.12.19-371-g03f13769310a)

## Metric Fixes (compared to v6.12.19-371-g03f13769310a)

## Test result summary
total: 121138, pass: 95392, fail: 7426, skip: 17964, xfail: 356

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 35 passed, 5 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 17 passed, 5 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
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

