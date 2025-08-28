Return-Path: <stable+bounces-176568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B575DB3951E
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3871622CC
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2852C2341;
	Thu, 28 Aug 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMMhTHSu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF821CC61
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366007; cv=none; b=g+x8zM3VDY8kMhep1ftDLd1bJ7Th6kVWBKgNF0Cdqfak/k6tV6B5UlDzQbrZots+oe+V3KbYlxfaEz+HcM+sFYL0HtlkelouOBMeerYMVvx6ttpEmG+3knfwK3iVPUOUlAbP+A2brTS26NfHiIRAGq6yBZ2OjoH3lFa0ItwQxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366007; c=relaxed/simple;
	bh=FWeqn5vRZAH6k0pKhP35N/soh/ogrNerUNcbSo/TcDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feBpGXvwMcH/CbzsKsCd7jHrL0kr5G9LvGElavkCEcoR2roItN61rR8KkBb8r/bX1kCN++OMQ4ZaQsJVGejPJVRq1GlzLZcvlE6rjdq6H9P2HiPiYUcyPnBGt4sterlleGSSFracJSz0Io8xlvDVjIFlbQejqJfLwNO28MbebTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMMhTHSu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b2a09bfa2aso593461cf.0
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756366003; x=1756970803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7deqPVGcNTC25viCblNvhMMKUTMA22h7onsyE6m/3YQ=;
        b=qMMhTHSubkfeBVCiHEsPH8rqv51/6Isto6DRac3BYo6yoJyjB3R5cIUQXgwATWnxF9
         F9fw0i5eAvt9xRjcAmwTUMA71ZxgTBGsaPPF/D+Bwv7bBuKD7P+/q51EoL/4Ie2AVhUg
         HzMoE4Ec50FvUC4dHnbv1J3bG0oV4TXBqddHzHeawPZ5zUddX7gSyuJIL2kSfsbibG1o
         BdEGqeb4dd1yScngzYsCnZTZ5We7wBivNn7vLxzQal/Fu9Bvl0JiVZ+dHVE9OKpGWjnP
         mef8bixg41e0lPbdmGgK5NoILU5wSEeqqypjkrYdKyqLEwXPMbG9p+8/9IX7NeHGew/V
         KbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366003; x=1756970803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7deqPVGcNTC25viCblNvhMMKUTMA22h7onsyE6m/3YQ=;
        b=eVBgyzkG/4Td4S1pDHbehrQCXpvx2nC/rxZCUstR4PcUaVyM+Xp9Eic/uMHvMs1+zd
         0g6Zt3J0FDOzALCGqRmuZ9u/R2zqJGzyTWvL3VNaRGSGZCK/6iUiEJO39SooQ+2NdYqC
         m0/vpCgMP4dxFHZQDwB6/2dmIxHQjIORbGCXN5Jzc33dlEvV65DTCmEkFl0tkb3xuxXz
         gWQhGBiwFV+PvaWlF5dZChGxawLF+qlnOWKq6TyybsfQ7ACY6vvUPZHtKNYqxiFBUFfb
         P6yQ+81cFAJMGkjvQI03xmXV7ZzEXM8OI08YJTAXVZ9zyMqEFtK/Gr5S2Ws+PNyuA4/x
         Z6NA==
X-Gm-Message-State: AOJu0YwJmH6suv7VJPV89aZ7w/yhyOHltRwJUZIHo8Uhllieka5zE1jo
	nEAR1xKr50BesO3TYMPFnXNjmT4haHnqHjr6ZQ5YCSbrCYcjeJ1Tzc2XGiRv5N65WWk3GsoqwkL
	l+5dFplDAESzGo8vhzTZ00YbjTXDgUrwRFBIOd/UaEQ==
X-Gm-Gg: ASbGncti6OyKQiSgOmVKrJpxqbG0rkO8LbMTVwgEpn4/iouRZYyz0dOP8628EQHoxVG
	WD/WJwEWmQEEQYE2A+RrGzU1Eqi+5goLwRsxsQN6bSCHhdq3QS4QY2yhr5x2nvWq4CYBMZRLJYe
	WDJwQsg08IztILSs3ilO1efiBH474vjjBIZsrFWnpdli5rl9xBlHwNl38OQvBc5HYqZy9DPEm5k
	y6s6PczQ0070r8J
X-Google-Smtp-Source: AGHT+IErKUhUmI37jeBXoTvy7qMI9WCIiqOnvQ/h3DmG9UhJAH1k1Z+eP17jDLSBcN8nrX9bC4v/R4LnJVxfLQLcGYg=
X-Received: by 2002:a05:6214:1d25:b0:70d:96d0:83c9 with SMTP id
 6a1803df08f44-70d970c54a1mr165565056d6.2.1756366003397; Thu, 28 Aug 2025
 00:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827073826.377382421@linuxfoundation.org>
In-Reply-To: <20250827073826.377382421@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 28 Aug 2025 09:26:32 +0200
X-Gm-Features: Ac12FXziFZRFGNoRBwgurFlgUSBKRKa9JvBPPmeOBJJCRxUePGr8466KojIL_b0
Message-ID: <CADYN=9LV1rjG1dv-Ctbk24nwhRuu+a_mzBagaFEMZkQ7qG65WA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/403] 5.4.297-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 09:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.297 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Aug 2025 07:37:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.297-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE: the previous reported arm64 build regressions have been fixed in RC2.


## Build
* kernel: 5.4.297-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a860ce417cb1ff7332caa94fd6014183f8639a17
* git describe: v5.4.296-404-ga860ce417cb1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.296-404-ga860ce417cb1

## Test Regressions (compared to v5.4.295-145-g6d1abaaa322e)

## Metric Regressions (compared to v5.4.295-145-g6d1abaaa322e)

## Test Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Metric Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Test result summary
total: 43352, pass: 33098, fail: 2462, skip: 7622, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

