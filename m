Return-Path: <stable+bounces-132075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C7A83E6E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9731BA1096
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17B219A6B;
	Thu, 10 Apr 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXgbvJzK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C7215182
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276623; cv=none; b=YE8CbkIJBdfHaabFMLidaXJlPqxaBaQFTrq3FPKQKdki7JprFphimG3fRWAz6Bm8dUQ7SYgU/g1d8/6+pGcf2r54HxbcCmVgABVnE9S/iea4hpN8LO42Uzh9NYEqyuiGqP6OH4MHKPMvPADpiFWytPr82Eg4Rv4xxdHgDwLMJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276623; c=relaxed/simple;
	bh=Xa8Ff/pN7rm82/Hw80lblkpQWMIqBTW7/2gVpQ2MNXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLmw+YOiqdoHIfvdr+KLXZ9pfQ+qkRyIsUq+MV1CSjcbZpHvodfhiC6AT2TAuAzFi81zMPEdibmX/cF98M8zG2WMh1+O1mSjscIfr6M7fBpAMqqxnl1KFs8ycG4xUAkPFYfdYrEL4vBSp7ZMx29hCSV68cZ81FCQOfn7GrbuTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXgbvJzK; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso228496241.3
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744276620; x=1744881420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdQmyUTj4g0SuNw3N9A0Br4aQqbGmhp5SDoz/CPIiNU=;
        b=lXgbvJzKR9hLaoCo40b/AMPyVlrHEYIBwL61vmDP2hKPaH74g9lFn/BlPdFk+NAA7Z
         ra8//+iZvyPa3UsOil0uFxva2KEXaqgjyzD3cSojG5heBIuOrE7SSVJCEztrkGfZm1ob
         Az8YUih/KgT8Zm29D6paJ25vBd1KeqBe0cgwR4OMssQw8wFAA53a98ocBVoNw588XfTi
         xw9tEqwJRq8KxuJXZy4TG37MMzkCNCyvRJqzan554oMurmuqFEK3cmJu5fnYK4mj+4tY
         b76whUWK1yes/5uiCdjsZAYCTwI+gW3GdmfKuMhtzna5DUOlk36is2yDwCJC12WnlUsT
         ZhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276620; x=1744881420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdQmyUTj4g0SuNw3N9A0Br4aQqbGmhp5SDoz/CPIiNU=;
        b=GImOyBT9nFVJGvCQ42IKJDZ8w6whsQExActVemBcJOR42Er5VHfFI8WsYfdBWxuV2k
         PiGcKRawEGE/MG9KxqWKp5gnPLJXgQ7IfM9wCtMHOZ/8XsXN0a9SklAy2AmWpZY637dI
         0nN+ccQmsgNN6OMEFP3vkyBGNA7vmZQbExjXXOQ144gOb4BMZ6Cg0AeJRuQWHoC1GjxJ
         JE4iQ0wCyMYaxsWr8cJimkSGFoYB+3159cO5EygOFrmz2BdcZ5ylw12K3Chd0VoaKCpa
         Q0Lgyu9+SfcMpUWEOkKGxKfCisq1in5wdilDeusblJALF02H3gg5MybmUEXeSaf+BEc+
         jghw==
X-Gm-Message-State: AOJu0YyQzk39BrC0e+zfD7gblMo6fjPODaYnkGU1QQiPSYHF31/myOkt
	OEy2rXpwH+rc271gWNGf7S61IBlXLLVnBcFLLqlXdJU0HvXdW/iW+51lBsB3NdWY4v21uyI3OzH
	VFf84hvieCpTG5dOMTWAj9z11d6tl6xoOdD/XTQ==
X-Gm-Gg: ASbGnct5vmdSpgQjJNPSo+GpJHfc6O9vx2xEowFmj13tKc3JFuJUzpggKcZ+ssOgubp
	8thsF5Lo4TndRZxoitPaTvVaZj4LkbNbjxVx46ZUzTuHpu3vYvF0Q5DKD6OsS5ceFeKFb6Rck5I
	W7NEhP15S56gjwie1dHm68/lH61dl/1vtxp8JFcmcAFIGRXTG2sudvE3xZz4kGGsbGzA==
X-Google-Smtp-Source: AGHT+IE1KynZHJuyz3u/gcawT+AeiFFoZZSoMAW3X0C3a+4tVcuYH3tbZBo6Pebhc6HyfPbQV+caJt9l4kTsChhokA4=
X-Received: by 2002:a05:6102:160f:b0:4c1:924e:1a2a with SMTP id
 ada2fe7eead31-4c9d3620e92mr1047489137.25.1744276619774; Thu, 10 Apr 2025
 02:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115831.755826974@linuxfoundation.org>
In-Reply-To: <20250409115831.755826974@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 14:46:48 +0530
X-Gm-Features: ATxdqUF-Jfnj0n0r8H8OdiFSk0hQ53ptwMn1zgVSD-9e5YmY8uzIaVkWfZZN8_g
Message-ID: <CA+G9fYu3c-bgqcAxs8royX1LJM-+BqZE8yOkNueD=4H2UStNZg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/228] 5.10.236-rc2 review
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

On Wed, 9 Apr 2025 at 17:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.236 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:57:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.236-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.236-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 5b68aafded4a439a2c6c9b0fdf18c2c3a7560bb7
* git describe: v5.10.235-229-g5b68aafded4a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.235-229-g5b68aafded4a

## Test Regressions (compared to v5.10.234-463-g92c950d96187)

## Metric Regressions (compared to v5.10.234-463-g92c950d96187)

## Test Fixes (compared to v5.10.234-463-g92c950d96187)

## Metric Fixes (compared to v5.10.234-463-g92c950d96187)

## Test result summary
total: 36631, pass: 24606, fail: 2712, skip: 9093, xfail: 220

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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

--
Linaro LKFT
https://lkft.linaro.org

