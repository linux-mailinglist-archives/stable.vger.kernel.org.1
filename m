Return-Path: <stable+bounces-131990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0CA83032
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADBE3BD4FC
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1127BF85;
	Wed,  9 Apr 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdCSHuc9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5A27BF7E
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225922; cv=none; b=L3AzmuZygb6r07TxtOaEa7cYOOnjIo9bPYpEWZ9VHjmMRUcHVoWzAPof9g5N5fMPiDR0bFkEyW8kolG6w9uuM5PJj+jeEQRvz/7IGv5adNIXraSHWDk3Y8qlmFgtbeIi4qix+iPu0wVGw4dGyVfIMKVfZn2vMqi7Gc7H1dJsuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225922; c=relaxed/simple;
	bh=rJVQDauQEjZj0g6jxReYpgMbOkc7rgwaKyOHe56V6g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeBjRJbDPrZrLN/GlWl1GYfrl4c7GovLss9qNBH1fiOzUFF7n0klq+2QMHJvWl/pWlM53K2V7teAdeS+bBHxHWlHEAv04945iw3xKamDYXXfiDOuqQOxmpblKk1fuNg1q/6RqpJTFubrRG+kOQ2v6/6APjG8yveE62kgZg+eYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdCSHuc9; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d377306ddso3064670241.2
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744225919; x=1744830719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wi3/JxnteRx/5BMoOtb3JvQUUrvrHRfi+TmZ/LdTJGI=;
        b=hdCSHuc90MzvGVeO4lZNKSJyPEYfY/D+pJbE+brGQS8ItufP8Jpiuz/DvYlwgoc+Ea
         owWRBUEfRiBU6Xdb61tm2POFbTsedUEvq762UUyFIPSgw4Ai806GrFfIg2LWocNkbdjA
         I7Iuzslxd7FHgdA+3G/5G8Sa29rHYDPizBDUJI8uxxtZ2bbkMtXtOt0hr3qvdY4yth5W
         klV5reWJZ/Hyae/+S3a6EQsTOWj1Xb+0XruhmQEU6Bvv4i8Zl4jXna3w8OZC1hD0sRAz
         F36fX0qK4EXTnER2kRePff9NANBusOKL3M8676a9Bs+AJp82G+haKI9S6lB5+6N2IGlH
         LSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225919; x=1744830719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi3/JxnteRx/5BMoOtb3JvQUUrvrHRfi+TmZ/LdTJGI=;
        b=ddXtv6K9QAK5d6ceuwXUpkCTxoTeYfujrDjAbRuQDCitHo/b1gd2IXTRcO3wB/r9cj
         GPOxzGKdwHnhVynrIFFhltV0p/J0DaAGQEsC2yQByFR0nWdHLnh2ee46xCYmmw3eewVi
         ScT3XqQxj3sv+pTDpTVHqWJd//2HofoCvCdTKKnoL1dkgoKJBELhk4+RmKZtA9809suw
         3vReScMeUUE7kQ6dOoHfWSmxLMpeBt0B3UtE2BRps1wVff0fRSrBHySQpWQ6xFfJCLFT
         pcuWpj/NmMcVY5j81OCV28iBu9G8E+VQ/aVQnhz0rnAaQSD8FD5akA9QyLvB/nUdEjX5
         eBIA==
X-Gm-Message-State: AOJu0YxFz8cgp4lyFpOcjzJjq7YIqeQzYxMf/zhX/CgB0upSM8MwU6en
	vBoPECK1haZoF2M/W15/FlfJh2qr5ZyHCY8HluqQdtWxW7TY4YsVjlV0MbzEaehOoM7Zhu+Nvf0
	1gMqF4ipe8dl35sV6u4yVbw1AE+D9UahVfuTL0A==
X-Gm-Gg: ASbGnctgC6OOKCpJbDA2w/rfC9WIfJAIBRSnn97HU+VEZunpc5tv/WLm/MBJM/fQjKq
	pzvsKuPmBsg55Hx3FVieFpRx34ChW6NUdXYrH4vq6KMhj+LNg+qH1fPAheRf2Wyb88YR/AuMVGj
	E6whmySPpfwqpik6wQD75zh+qcoYUm6gnvOcQSBdIORvl3pmkFExExQeQ=
X-Google-Smtp-Source: AGHT+IGquHRVV8Iwo0UImEXO1PZ149S8v0mbw+LbHunLj+Ma11Z53jzf53nmAhS3dfI8tSSV0Gz8MnVOHEj4TciTaV4=
X-Received: by 2002:a05:6102:5549:b0:4bb:c24b:b644 with SMTP id
 ada2fe7eead31-4c9d36ad092mr112527137.20.1744225919161; Wed, 09 Apr 2025
 12:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115934.968141886@linuxfoundation.org>
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 00:41:47 +0530
X-Gm-Features: ATxdqUFkjZ7UUrX4iO9RrF97-ijUSvahOPsHLqjGxDqg8TdQn2H2ls89xcSQVFc
Message-ID: <CA+G9fYtnTU1KAuXnzt29x2CW8bxGcC5MzjNEYXkdwt3Y-G89gw@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 726 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.2-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression on Dragaonboard 845c and Dragonboard 410c the intermittent
failures noticed,

cpuhotplug03 1 TFAIL: No cpuhotplug_do_spin_loop processes found on CPU1

Regression Analysis:
- New regression? Yes
- Reproducibility? Intermittent

Test regression: cpuhotplug03 intermittent failures on Dragonboard
845c and 410c devices

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links
 - https://lkft.validation.linaro.org/scheduler/job/8211196#L4101
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-727-g2cc38486a844/testrun/27996013/suite/ltp-cpuhotplug/test/cpuhotplug03/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-727-g2cc38486a844/testrun/27996013/suite/ltp-cpuhotplug/test/cpuhotplug03/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-727-g2cc38486a844/testrun/27996013/suite/ltp-cpuhotplug/test/cpuhotplug03/details/

## Build
* kernel: 6.14.2-rc4
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 2cc38486a8443cdeaab34c7ece4e5600fe5d7645
* git describe: v6.14.1-727-g2cc38486a844
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-727-g2cc38486a844

## Test Regressions (compared to v6.14-rc6-492-g8dba5209f1d8)
  * Dragaonboard 845c and Dragonboard 410c
    * ltp-cpuhotplug/cpuhotplug03

## Metric Regressions (compared to v6.14-rc6-492-g8dba5209f1d8)

## Test Fixes (compared to v6.14-rc6-492-g8dba5209f1d8)

## Metric Fixes (compared to v6.14-rc6-492-g8dba5209f1d8)

## Test result summary
total: 103967, pass: 79606, fail: 7152, skip: 16873, xfail: 336

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 35 passed, 5 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 18 passed, 4 failed
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

