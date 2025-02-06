Return-Path: <stable+bounces-114116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27670A2ABF3
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085D71889A59
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB111624E0;
	Thu,  6 Feb 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jY2ujJSU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A01A317F
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853824; cv=none; b=Zjil5TBk1Miy3PEhJmOdsaMIO+3jLnSoSBvFnylA4+uiiDyYeZIXVzf08UTbJV7noE0Dmk15KzxaDKFPBX6nNfbFfdbdsrKklIM8K6j1SNWsnYaJHCPdAkVVUFOqwenYPvo5viUYkgKUFT99VQMxY6uph9MaWQxXDY2cZ55RBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853824; c=relaxed/simple;
	bh=6uq0mAsPLJS8exNPPFK8GwkvG8bs5kLtKrK6eAgoTqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPkSdJIEjZ18hk6zR/C6EbAxhVx5mh8OKe9nkNM1pmSWsFhBDTYkdB0T5WUDCcHRo5GFGw522i+x23he9sm/zjhEdCtv0uBbAoPpcYCUip0IIslhUrRmqhE/ns/hJhZZx7yoHHIw36nyyRkcaN9+8OiRDCG4v6C3MEHC+7UvXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jY2ujJSU; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-864e4f5b253so282874241.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738853820; x=1739458620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfnsTMmEDZLdDZKD5lXbIllWt+t0HFZbbF8QjtXMaKs=;
        b=jY2ujJSUSJ0aBuXzzPrwoj2Q4OuikHs6aHDw4AmvAFXvNpWndL83SjkU6dfNt6BnLD
         g5hiEIK/7f/b6aKYpFcmwRJ7iHtnnwlD5oq8ZXo7QmMiq+AQgvsOUjhOsC4Bf2jfk7mo
         KlzUu0ZdhOxZBN0TyeFR5P9zBmQXeIf0K+4O6Acj6hw8o+Pw1VEpK2IenSPmKXbbj+n5
         7gI4RujpgUFzuT1SgYTxcnvvKvtoumVpK6IPluc8/dZ9VZQuz0Xaex2cjPUo2d1vrLO8
         Dik+2e4ab+PuCEX2apFhE6J+hqXyX7v34KI4Y3GggcEpMEMpuuWm2eHe+Yu4xFtGdfUS
         kgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738853820; x=1739458620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfnsTMmEDZLdDZKD5lXbIllWt+t0HFZbbF8QjtXMaKs=;
        b=iz8vw3115pk2EWvMap4qTa6K/6dy5gg2KF4K5mmqu+FGD3fUR8RZOfj1Aflk8jmcW2
         qf7dZOM8e/wZgwrGdyReFfJYolHwBQXuaM317NqoPaKY06/QbUogcCTin25B6CKNW3lU
         0Le4QBaybvDXNaZymE2ZT7AcZy8bQF8CSIEzVCCUCoPSrxpZ37bhvU4mJ2HoiSe2xuAa
         bOcxsidkN1x+cc37PkC/+iCLftj8WQPf9f4hL/6nw1F88v5HPcpk4rw8Q2a/OOlLzhhw
         R91rUl1mcySmkvN9X+6cTLWV5QJqUKETkQjsqKQbtrvXUIpUgNC+zDxYIQSIs0z9KP35
         0BbQ==
X-Gm-Message-State: AOJu0Yxh8RH9n5WhmIbjA1KpsFBZ7LOG9HokJT+dWINzoeDXiMzo5wjO
	SADpITiWRaIDUdf5D6VBpH2YfKWzMQQXUw4mCWQpr0fofPps3MhJxfvhtCE1VoSsHBxnn3sWsqf
	Xb6JXpycc8NttSXlzZ9sJioNKLSO7/BPbrt0+yQ==
X-Gm-Gg: ASbGncszsHJz/qIHcFK5dZN6mK0c+sLPPTflYqM+KJwR4okqLh2k9Wj+Srbo1snCe3f
	mQhoyfmflGzqRmOBwkoj8qP8JrYJkUFSRE4Ubytp40YHB/00dtC+rAVYQdIp6CDVp4JLRPIq8Vz
	cl8mL1h2cgxl/IMipg/OmnQSV5uck1mQ==
X-Google-Smtp-Source: AGHT+IF1gfa+n/8OkVpzIpcr7+uOCYLCT1ZeK9A33AjOH/LYrvhC5X9BjSQGBsh4TdmE2VYnL17ZPfLGRnsQkuzHtR4=
X-Received: by 2002:a05:6102:2b8d:b0:4af:ed5a:b697 with SMTP id
 ada2fe7eead31-4ba478e696cmr4806047137.13.1738853820234; Thu, 06 Feb 2025
 06:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205134420.279368572@linuxfoundation.org>
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Feb 2025 20:26:47 +0530
X-Gm-Features: AWEUYZlyhthLvcxBuYa3QMp3qch5FNwA3x567X5JSJFQpCw9jy_XQspq4Iungu8
Message-ID: <CA+G9fYtCam8wR6Z-Agx6vaQOtXcomc_PaM+TX6QFY9BOFzk0oQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/393] 6.6.76-rc1 review
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

On Wed, 5 Feb 2025 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Feb 2025 13:43:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.76-rc1.gz
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
* kernel: 6.6.76-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3b8d2f9dc632278f4bc3589b49712b752cb93654
* git describe: v6.6.74-439-g3b8d2f9dc632
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
4-439-g3b8d2f9dc632

## Test Regressions (compared to v6.6.74-44-g2c44b59139a8)

## Metric Regressions (compared to v6.6.74-44-g2c44b59139a8)

## Test Fixes (compared to v6.6.74-44-g2c44b59139a8)

## Metric Fixes (compared to v6.6.74-44-g2c44b59139a8)

## Test result summary
total: 71538, pass: 42664, fail: 17801, skip: 10732, xfail: 341

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 28 passed, 3 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 37 passed, 1 failed

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

