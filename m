Return-Path: <stable+bounces-116492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720BAA36DFA
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 13:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E54D170D89
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0711C32EA;
	Sat, 15 Feb 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/+w0UIL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773F70824
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739621542; cv=none; b=VtkgeO2+fN4xRHNjd8QBsAZP3HBtE90vE3mGdc6YyBusX/6Jukd39ZSQJgdS6IdwTQUczp1mKILbibqT4TIRxdJuOG+fhqNDHXlhtVR+adqEm9fpMR1n3HVG0l/LHILUAyzTb8D6kmUtZ6QnR80Se8kAOacTtGJ6dS8dfE0BWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739621542; c=relaxed/simple;
	bh=qm7JqI8ig6K5eAnFPE39CQ1/XQZUUQaMrkJkh/owUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4qzdQT/HjMPCkCifpYePgvoKn+EKsX42wPL4Di6GorYU83FX7gpVmiCqGa1q6hajqQuvj0MQGet4fAPyF6G+TJXLALr6Ax/hurkiZoOgRFGyt7J5XQR5lDJItwCukYreoDdUSKgVp/BFkNcbZSvYQeH67aWqKAap/7JJ6p8XMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/+w0UIL; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86715793b1fso794942241.0
        for <stable@vger.kernel.org>; Sat, 15 Feb 2025 04:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739621538; x=1740226338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzyW5lFbonLTH6dEaUk/CVs9DpxDfukUfwlAaCnLwjg=;
        b=b/+w0UILDazyQX9EQuetSbFsX0LGMSEfSX4g5Deq44xuevwDI3TZ6poEy+wP+yn9NW
         O6+0CATIA5ThpJJ+ebg/w57eKlmB3Jrhnksrg03rTozjR4KKOLhh2oR1cse7Xxpn8kQs
         r6MTbsKKxTelpw860tBt6V/QzIkw+iYlbYHVcl/bycrqUHcn/qOz4uDClFZBMylmkPeS
         Io3yurdVFAZ1lx2WX3IFPu/dy4G8YWMYZ6qIDfC/sA/Rky9QUDqe2a1uzATdSZGYHbih
         LJ54IqxNtZ/U7nPAod3jtuxl4vUtRQ8OQ2esyLtpKRz3+AzlmpvKW7Ie9VIVSBXXSO0q
         0UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739621538; x=1740226338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzyW5lFbonLTH6dEaUk/CVs9DpxDfukUfwlAaCnLwjg=;
        b=g3VUBZFsTP+u/wnWDs9mA0mKjVDCBGayYcRgM/gaHcgbfYaOvuuLoontiUYREZfmaS
         fDHg5/dD4fX+28bMjue721sCzMec/fFFmPi21rZlIk3Gh1uhNFvmkvmrQfxXoD5MBz7U
         mePtQr28pDfsgKDRbUrKsbfxlmP8oXUNcgzNgK0LIQ4IaSlyLDc3+jubQ4PQVvJ7B+WY
         adYhMT+k068GEfuB7NuAPRfN/Bei/67GHNfI12Xq4EEOWx1xyaNWNxtJjJxa10oSAUoo
         SCi9C6G2U4hq5mqPdkYN/IEpFe1WeyxnqVInP5qEe1Msf4AM6lWEp3ZR4bwZrHcKkfrn
         s78Q==
X-Gm-Message-State: AOJu0Yy0FNb7hw8RHg6cOy3VvTUqVATsAgLIEHC+Oolxgyy6PTqKGC1q
	NsmqjldpXj9Gw97zvwNgu1yAmfYUKLfcBm2vlU9MgshF3m+1lgWEV5SWH/6mlbrMtbnkJRgO9qH
	QhaBr1wb0rAY4dX3ea5a9Pwh/qpTUBOrrX4hxng==
X-Gm-Gg: ASbGncvyOd8yYnv76tDZevtJOM2XcahYdnf2o3qU4Dpt7rfbI66vBgW9lyOw2e6jBs/
	4ONTJbKFb6NBnxAYQCFah4qsUD7aOqVeNwZvP5PwQCLZFA8nKdAdAzDOvleAzYVNJMaKzRY2jNx
	IWhTQiVR4AxOH7UWkbfIhf4ghH+3MkHVc=
X-Google-Smtp-Source: AGHT+IG+qAaL9INIii0CYjn4sxooc4GBiJBUznHaqojYczUXsH1b2QBXbNmC4WxQ129FZ9ODjRKh+gTNEJ7w4OX7SZk=
X-Received: by 2002:a05:6102:3fa8:b0:4bb:e6bc:e164 with SMTP id
 ada2fe7eead31-4bd3fe8d0d1mr1766320137.25.1739621538337; Sat, 15 Feb 2025
 04:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142407.354217048@linuxfoundation.org>
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Feb 2025 17:42:06 +0530
X-Gm-Features: AWEUYZlYUCeB6Xdq7w2fGkp4n_51VEaKcRaaeoXlSkD-V7Bi0gZgwQIacbP_7zA
Message-ID: <CA+G9fYsnK2+tfv3Oy6PoVuVDn52dPEejb68Gh7Lx69GyJzOS8w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/273] 6.6.78-rc1 review
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

On Thu, 13 Feb 2025 at 20:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.78 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.78-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.78-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e4f2e2ad0f5f9ba880bae6771875ab6c3b9eb64e
* git describe: v6.6.77-274-ge4f2e2ad0f5f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
7-274-ge4f2e2ad0f5f

## Test Regressions (compared to v6.6.75-390-ge5534ef3ba23)

## Metric Regressions (compared to v6.6.75-390-ge5534ef3ba23)

## Test Fixes (compared to v6.6.75-390-ge5534ef3ba23)

## Metric Fixes (compared to v6.6.75-390-ge5534ef3ba23)

## Test result summary
total: 56711, pass: 45681, fail: 1533, skip: 9334, xfail: 163

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 38 total, 37 passed, 1 failed
* i386: 26 total, 24 passed, 2 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 12 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
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

