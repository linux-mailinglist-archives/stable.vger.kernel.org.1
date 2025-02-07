Return-Path: <stable+bounces-114289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B837A2CBDB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D7216B99A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C985197A92;
	Fri,  7 Feb 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgd2PA2v"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBF1A314A
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953933; cv=none; b=bYkbfFHkKMMzYd+inx/A/poEmvW4uPZSOEFWU+Ks/tTd7QXWt2/AgE0bTBua7rfeITFW00uVhb32C+wvZpH+0FjpUbOSYVRc48TRVvAd8Q/KhZ5mGvGoJtrdOnyBF8U8BPGAGqkpONSmsYlj7Gf3S8k0wNGcjyqq0aMsJF3v/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953933; c=relaxed/simple;
	bh=OdW1emNri8kVC8pI/hPYJfis2oc+JFChRYjAeCvy2mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGLygKZrb7+n86ei4kaHiSgNf6/WWLPDPbnOQBfV2jSteQKsIRaaR0CfYeBF4kqHUDbTaHvIJuu+RacbZOIUmPaWc/zBs3NJ6U4pXl9/e6Lo/PE9CPgRCIk+Zxeb73Hszk/AWoJWW1WumM1hE75SpoCPYBzs40jxgxhfiNVzO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgd2PA2v; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51f2af99ab4so475270e0c.3
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738953929; x=1739558729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrZJNd0kBd4brj90D7LeHLADJbtHZxxD8+SSJUSVGgU=;
        b=mgd2PA2vIt3dWeOWEeHRaJY5hXOuqXTSuB4+e77LBaIFpY+OdhshrM0XOgMUZmgEIh
         h0MfSgUt0+UWjxgvzIo4hNAazi3hbPMQoYx7CF8PxDMxjILpyXyw69DAlM5c01pYdI2j
         EHaiN0f57ouLmRyEuIJ7QqlE0oNNMDMqVdd7pW+mhR1k8aHL8eSjFyhrD7+dIv5E/ZP5
         vOcMzVvk7+k5Aqt11PQ7N7bTM4jUZQFYUIwH69u6RKUV94XafM1HUvgy7qH5/bJgLLl3
         2ei2XVP62R0M/YDlL8hib3kfAMGue7It7DWEnSuq5kkiYecc5F/cGnx19OVc7LNQkXZR
         MKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953929; x=1739558729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrZJNd0kBd4brj90D7LeHLADJbtHZxxD8+SSJUSVGgU=;
        b=eFrJAIqbEIXPvZpheKRYPi8nMoiBylVywJupWsyYd1YTmCgNpEDunrkLcs2rYP1nQ2
         aQjR3E3BOeTMelAi5IXhJMZrZRMVXXrDcpZPg+9UVNWS1bQZliJdTsDFQHwOus4fy13m
         /5walby1kfF60t7pLbfnkbIY7n9H6HjW+/nFV/4hcjgB6Kj1YVE21kVFMevI0bvOEYWV
         eCE6Nmpbd4AQl8FtlAdTm4PipEgOl6fHsmhs8h1aq87RjDeHAPSXY3FhalSHQIL5Cw8a
         bM849FLAU8MXhBz8Lmz9kXPFFc7u43HYvkkHHkEE1bgvwu1MtqqptUfgYcrkY21av/tW
         U9WA==
X-Gm-Message-State: AOJu0YyEUFNjkta0PFLTT0Q1BMzJzmtkVBsDM3HV7FuTjlFvxEZZtiQD
	lWKx5P9RwEEDeH1GWvqRV+yH0lv7tC7HUurKX9a542V6YIGdGfrLIUvmiK61OSia4ln9JAQw2SG
	FvfLruX5wnKaN+x2gkwQE2QrqL+rVEhLLh3DrQw==
X-Gm-Gg: ASbGncuyizXEaeRLJ5HvPw00LJSHqN9cn7biF5XLApjFBCy8ALsdyENi7Yhfx15AcXI
	xyNs1UEIi9hRLB7C8qasnK5XJ9k5Oh3vQSkrPzhoA1ojOFGHgpnR57Zf2wCye7W4XrHjxWL51MD
	5wQHe6E0Odvnw4VxfNX27RS1Qelbxn
X-Google-Smtp-Source: AGHT+IEG4rTjDac1kRwYGWerf4E1q0tf0QDbq8ANmQnNsBSbKG+iJQfyy/kNZ0kixZlxKvm+YSfXHquWbvrO23DhSrg=
X-Received: by 2002:a05:6122:10f7:b0:51f:358b:1c42 with SMTP id
 71dfb90a1353d-51f358b20c3mr2497181e0c.9.1738953929027; Fri, 07 Feb 2025
 10:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206160718.019272260@linuxfoundation.org>
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 8 Feb 2025 00:15:17 +0530
X-Gm-Features: AWEUYZmMx4CBm45_f0XpymDozDy_fR0zv3UmXrlXsWxHCGnqcsBXal63hDRC1eE
Message-ID: <CA+G9fYtytLbzC=2BQunZgpv8CKHKN3bdFOB1eFhizfz6iRd62A@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
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

On Thu, 6 Feb 2025 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 619 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Feb 2025 16:05:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.2-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c541e7f2b5c78da7ce25ce3e55189f2136efd142
* git describe: v6.13-648-gc541e7f2b5c7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
-648-gc541e7f2b5c7

## Test Regressions (compared to v6.13-26-g65a3016a79e2)

## Metric Regressions (compared to v6.13-26-g65a3016a79e2)

## Test Fixes (compared to v6.13-26-g65a3016a79e2)

## Metric Fixes (compared to v6.13-26-g65a3016a79e2)

## Test result summary
total: 3290, pass: 693, fail: 2452, skip: 145, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 113 total, 109 passed, 4 failed
* arm64: 9 total, 8 passed, 1 failed
* i386: 16 total, 16 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 13 total, 13 passed, 0 failed
* s390: 17 total, 16 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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

