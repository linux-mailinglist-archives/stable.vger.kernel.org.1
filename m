Return-Path: <stable+bounces-158707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCFAAEA4B0
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFDB188729D
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3B2ECEAE;
	Thu, 26 Jun 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBCtn/ro"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08E2EB5CC
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959888; cv=none; b=e5gZBV5LhXgNdT2cZuu31ni69NBqEBGtZtOgs7drCsnMzem1XERQcE8CNMBEFrAjDorZX64n0kN7RE1yEqMBChyrzHLDw4ZdOKSQQEfjamqGC6/Y5hwamREZ8afuE4IQeLFQ1S26iaMW3RUxr1Q8lBknmnOzUolJaBQPzW4BoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959888; c=relaxed/simple;
	bh=zqUO0sW+cNaKMWzNEDMI98mGQvarDe1iRGXhZ+Veqss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USwYz/VPvKN8lVq0TaVA5rA2xnE5d3y62QjOyaBDLxy9rYY+z3cayj9rywyk4YZOMzmOwkSAo5XD08Iw39FaAinHVTzpnv40mCXqrloK91MFGr3zqstU68YeQgSeICNFKFdp+95V1YKF0+OkG/BxldqygbwPA/3yIxFcfnsLTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBCtn/ro; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so1002443a91.3
        for <stable@vger.kernel.org>; Thu, 26 Jun 2025 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750959885; x=1751564685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awzZr2qt61hMaORaAhilI11J4L+Y4ATtUQ36+lUSj4E=;
        b=FBCtn/ron0kYEA+/6EO/VYIzRzGisMQFV58vimNt/6bM7W6wxjx6gsubpxGhEKkJVL
         T3AVg4enXNe1axnDBJE95/1riYSFdrUdzhjd/EsBEb7A57vx+K/rV6Zk/gqydGcMFud9
         Li7bz+8ejPqwGbf0QM7/X9SDwS1HHImJP08nlgtaTW6ibxssJAobas8tLvE5qTVK3gcj
         qV1lRcSQBMOuE+3Dl2y1uUT960/ZxGaCDNCghHvOJ6mtZPQ7uYzfwNbQb70Gjwt3JlES
         CgPvqUFRYw/TEuqtj3HpKKqKRCGmFF6v4Spl/EzrqdfS2fvSSrEB10KbSoe6/0y1tZwa
         b8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959885; x=1751564685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awzZr2qt61hMaORaAhilI11J4L+Y4ATtUQ36+lUSj4E=;
        b=rWW+ZBRCDIoLEXob3vwPa2ou7bLESPomozUGdHm4pdlgbkHYP2n53uFAUGrmf1ofPM
         2ztzR7P2r7OdNWbn4FlRbLRSXYDle9xR3HFUAxzloZnIeEefG8N+LtdQs9nc56dRLFKS
         FMVOjzHZNF1bmbWcMyV9DZBQ8ZV5ugWeTnpdDBurCurFDQEJlfQZw+gKpUX6VmyJRO0+
         LV70ctUSBZIMJwRs7xoqfu1g04lzBBhbj37C4lhUvj18SdcpETZbDvxlrGFHSyCwtEnC
         Ki+531B4gnY83aFxAgF4BkUaO4uzzn2IrIB5QBSM/dxZMsUUeV2/1CPxmUdMdgwqf9VI
         AQRQ==
X-Gm-Message-State: AOJu0YwMcjI9tAQII1PCokkuhuUONtkBa3Gd/kVvqeod4T+z4X9NZUxW
	iXy+SC6TSV/2h5xXOl6JKjV4/7dL4u9Wiz+FuJU/37yYN072nEyrYtoSeWL/DBWPQOElK7N8nFi
	N9A5QgTbKMKpcOV7iVxcW5mfGyyOxG+zVwHg5vowrEQ==
X-Gm-Gg: ASbGnctBFxrOtXPHTpUTVxcohdApxs4H6iGYWbw1el6az6qgiy0thy1SQc7R/gAzcwo
	mze4Tvx5wqOYIMFL7MiWPvZOaSHMTAp/FovnB0z0JZYDY1+iKSdUh5m6lg8+HJfbNS7MHowpwFF
	ds7CQlPoON7gb1wHgnTlVcsA+bX87tFKpv5phiqwofcyq8vf5E0j7DbLJbSpXKSXvBl6XCVuZsX
	mmp
X-Google-Smtp-Source: AGHT+IEFPPEqV7DtiqEA1oE1/fKrctRNlSpnteTT9tcvCUfZIlkuK+VPMsW7r1iS1qPSXO31ZrE+Ng7a60BAXQEdGNk=
X-Received: by 2002:a17:90b:3cd0:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-316158cc4d5mr6717061a91.13.1750959885262; Thu, 26 Jun 2025
 10:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626105243.160967269@linuxfoundation.org>
In-Reply-To: <20250626105243.160967269@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 23:14:33 +0530
X-Gm-Features: Ac12FXycaF7oeRJLnS3XeYXVpdhngxsyXODthsn8k9cqqTJDz0BHwpoRhfHoX6U
Message-ID: <CA+G9fYunftA3YqTxm-2GMN1fpQ_PVviBpDOnGznUo4YSW9pmSA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/589] 6.15.4-rc3 review
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

On Thu, 26 Jun 2025 at 16:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 28 Jun 2025 10:51:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.4-rc3.gz
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

NOTE:
The reported regressions on 6.15.4-rc1 / rc2 LTP syscalls readahead01 has
been fixed on this 6.15.4-rc3.

## Build
* kernel: 6.15.4-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d93bc5feded1181a1f0de02e38b4634a7a76b549
* git describe: v6.15.3-590-gd93bc5feded1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.3-590-gd93bc5feded1

## Test Regressions (compared to v6.15.1-816-gd878a60be557)

## Metric Regressions (compared to v6.15.1-816-gd878a60be557)

## Test Fixes (compared to v6.15.1-816-gd878a60be557)

## Metric Fixes (compared to v6.15.1-816-gd878a60be557)

## Test result summary
total: 270887, pass: 246235, fail: 6441, skip: 18211, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 56 total, 56 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 33 total, 27 passed, 6 failed
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

