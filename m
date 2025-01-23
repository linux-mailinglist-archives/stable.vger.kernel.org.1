Return-Path: <stable+bounces-110254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD0A19FC7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D216DD98
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3720C01E;
	Thu, 23 Jan 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJY5127l"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131420C013
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620614; cv=none; b=UTFAW61k1ZclcqyAj/Q05Ql+4tIBvf/HMSB3W9WsR027K/Ykqn4qDzfJi0TKHp9rzKgxWxOJ1JxEis3t654Ix/2L7LPbSnaVcaUSwygaAejAhyBecXHvuO6M0kZV39VEmGdHyXbzq7DonWZiE4I5V07gOJnos9CsiDZz5Tyl7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620614; c=relaxed/simple;
	bh=k+F4Yh+Ql2d5/O3Hz9vVyBRTDvF+gjl0ohaq2x+51rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcCLB5sHGeEJbimomlMZKTsULgfq+AVrhWUP7jqfI2A+0KpD9zOtTcwWLoR6Ysi3wAlu1aidZ1Enh1uVJtZ2qlrcCiV0DLuENmz4WNBuY+EhIYiGZnXDIh6w6JT7dcmXUCT6sfiI1fN/5U7/y761pOX6+LS4mjMSuJMEhz2v3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJY5127l; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4b68cb2abacso130714137.3
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 00:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737620612; x=1738225412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn76UqJ76Uut5NswtzAbnqW0Jfd4Qqd1Omi81eFZ2/s=;
        b=mJY5127lhOsgousEyJbKjuE+nzXCc1Fm0yGTgrq1EXa9y9zoyE+oShSmmv/cvxXixY
         UXbQdXr/NUB0st1afraTq/iEsUAxD4Y0LZTOBA6fODDEeysnva6kRi//JK9MX6WYFDOW
         51gq8Worih8+roiJUtIl9N6usEBH4ef3lBP6FgMj46kbQA8vsbFN7mKhY38pGut2tL/e
         5cet4o+9eVImDvm6lC2W5TD5hTWolMRvqmsN7xRvM3dZ9XdeNqcPCKS00hCT/cEtWaSK
         zjSPd66VJB9wBJx+/NSKJoIsTTfEBUENRltRO6VVRk0WuhbL49e3tUiYIfOABUzsJxbf
         2nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737620612; x=1738225412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn76UqJ76Uut5NswtzAbnqW0Jfd4Qqd1Omi81eFZ2/s=;
        b=fQysgK4BXF5nMPR2AZ/O20TafX5awKmsjEqE69mRWd5xVdjRX2dVkMF/lbkDQADsFR
         kFwsVaCJF8FvEI4r4fD744mmAoGqf4N998ayl0/ftGgCXCXKSMiFVHsjV/lMIPhzKgbL
         oYPMQ+b0hNqmX68Tw2iOxVhoNzsume0SAYSjrflS66Ej5wASHbx3BD/S1T4Jqd3F4TR2
         0PPZsRQ1imWe7XcQjAJkB2Vek1ahhfVpr2QLB8uqBrMrI4lPHItWJsFJ7Pg5W/47ZB2v
         A85z8pSZG4EhErFg+L2T0WCmJx7XS8t6x6YjzQXtLFioOfu1u7SwzUxn6VUyouCRB1cz
         644g==
X-Gm-Message-State: AOJu0YzUCxNF88/qI4DxlwE/rdJKjNK4anqnXumit+ByrsXXRIkLkwVq
	38FlPI6ueL8EfpucOJ2l1x9RfJUNxLXE3fp3Nao53kk8avFBHkWSAvZFYJ4G1apBVVnQVgdldy3
	ZFqHVAwO0N7i5+CCUdq8kCWD6TogeUlibnNcWmQ==
X-Gm-Gg: ASbGnctyE2sSykHGPv54Iw2LweNMAfbpnFAv7rj6tdIR71IJjs+Fxp4CqrdekAueChy
	WhyQ+e7zkRjxDzHE6ESsKdWk3UJRjNv+1hqe+F8donYDABi07XkPtE5IC3IVYIOg=
X-Google-Smtp-Source: AGHT+IGK8fI3fxpC85rMREdfJ/pQd3JZ1PoRr2/QFlFJtCWEM2QLjvwLRdwewRksGtG4+Bhk82RHb1zruVyybEG+37Y=
X-Received: by 2002:a05:6102:3ec8:b0:4af:e077:8a73 with SMTP id
 ada2fe7eead31-4b690bfc4c7mr20151892137.13.1737620611776; Thu, 23 Jan 2025
 00:23:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122073827.056636718@linuxfoundation.org>
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 23 Jan 2025 13:53:20 +0530
X-Gm-Features: AWEUYZn2E7j0_LQ9Ij4benW2eZMt62H7J96oDuzB8A3K93Bhuz0BdRo7UwvEI6A
Message-ID: <CA+G9fYvEVxCS6nb61E2ABxvAzvULuZTD7xvdut=g=5tfbg17VA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc2 review
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

On Wed, 22 Jan 2025 at 13:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 07:38:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.127-rc2.gz
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
* kernel: 6.1.127-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c5148ca733b386401ef46ed4ec93a2f4a078e187
* git describe: v6.1.126-65-gc5148ca733b3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
26-65-gc5148ca733b3

## Test Regressions (compared to v6.1.124-93-gf121d22cf28e)

## Metric Regressions (compared to v6.1.124-93-gf121d22cf28e)

## Test Fixes (compared to v6.1.124-93-gf121d22cf28e)

## Metric Fixes (compared to v6.1.124-93-gf121d22cf28e)

## Test result summary
total: 101152, pass: 77945, fail: 4846, skip: 17897, xfail: 464

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 17 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* ltp-co[
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

