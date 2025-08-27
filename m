Return-Path: <stable+bounces-176481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13612B37ED8
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891757C735F
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EC53451DF;
	Wed, 27 Aug 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udW0HjAi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB984343D6C
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286972; cv=none; b=KQdviVsN3H4Lu/9Ie2bi1i6eeRhNAxHEwAcERbI6IGIDm47f/KqqOobZ3sEsilggAVolr0OdZDuTXIU7LcvSpqtZkldBqLp93NoKqpe8AH0c66lfxnS4P9zd5QzORSdpdSUh3NmctoSeGCo1bJSvCdHrojm6Gb3Q22oVQmbG23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286972; c=relaxed/simple;
	bh=GcNpmztmTRqqdm3O9mPVD0ax9QU9z7NwP3oSb8yc3/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1jdjccq+5CbEE1EQcvoMQYWqD0un5Xwhpt52Zep9674V7mNn6A6WGVkz/K4g2JlC1ahMgC6K27FmMqcrg1RLfAlnH0QJWQF4fTn/jrkdN/D1JCsJXGWPafXMtqSNfjIZDzeXX17KMklKFZRGyuqrSsPNhL4zGM43rVsKvKuTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udW0HjAi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2e15925baso4038771cf.3
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286969; x=1756891769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqFI0TtuqmFQUi9Tx/zkbb9OSqCOCzVU0RfIWLMYKqk=;
        b=udW0HjAieolEZtl8YJYabPx4eMJ+UtQZmxzE72Cgtw/jEE6fj7DzRws4GGNydMImKo
         dlLHfzsdWcO1TttprPUGwO4kD9yoBe1NWSajDOtuvppYJu17+RkGYrdoGc5weKllVSRi
         2huBjv6O4UNu+B8E8DZcrckRNU+r9ebmMFJ2i1X5NJNKT7CIWJJcJCZLPsnP5jIE2QXY
         XJeZib6+pelnOQZFujwYHkzvNpPyWOgfnrxh8yaWDT1gCznPpGhm5bTYv5jQvYwwHbZU
         OXmkDrRkbPM1pQIsgBsimg6It3LCd1UZMfQrr0MUmtvjbqWGOISvi8F5Ioj3yL1TfI/e
         D0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286969; x=1756891769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqFI0TtuqmFQUi9Tx/zkbb9OSqCOCzVU0RfIWLMYKqk=;
        b=CH8s5nq+lFs2U6EVQo4q0pkLSjCibPa1ZqmVZtlX86Lqc/pnfjh4+K/HukH4ep7S76
         pgzXLrEisHvsZaXvRGo5nWSrozParYq1sc5M0sOKQmR8XpkN1oybM4ItczIxr8+jpAVB
         +AmtXA0U6Z3x1lAQ8kBv10aJLiwuMgVmBoju+F3NOd022tk1/RKl1SwRH0NDRHXPUqak
         Xsh0h5rsJ3laQpCKBOuwNPmknehqxPECHO0NajXjZ1Qconf/Opq1XOV6p+WL09cdenYm
         2TcEqtiRMie1UX/2ZvE4Y4vwASPHEP3HzCn4S4MBgk9s8jWG+8bvtWoEUmxF8IA/JMFA
         5ePA==
X-Gm-Message-State: AOJu0YzVTC4GCzlXO7SxsBB17qjJ5lpx21F9wzQ3YpTykuNd8PAdGH4C
	B4gC+pGEQ89vRDk3SrRCExvsbIDkXIau8jY73fhog0SX2jrQXNvv4bIO7ciPV5aQMhzqyN74vsg
	apt7q9BQPJQzrsb5G0Csnzfosr6tSLfHoDM3XaZlh3g==
X-Gm-Gg: ASbGncu01PL6QjdoNcVB49wPtdz9QvwQfvUjX7jRonRkN92cJMWe3zkOSKzWW9V6KJn
	oVxbKx+Llw6uBCqBKL6s4/PrV4ATgJuKk4GuFYojjQhLCDvzMgjmmOW+eh07uUUtQOsQfu+eWoy
	pZsfttKk3upJGJS0+nsoh5xQ2XwsDngXQpoZfUDMEONvL9aA8YDyVfpjXfQQJmZl5Tgf+1WuC2h
	l1oO2hKCyfwdGJ373WGacNGJzY=
X-Google-Smtp-Source: AGHT+IFD5TPc+V9xOcpuKeQYiT1w05IlKqY8Kw5x0gWCfSNrEcU0JjpkY4wKULa1TQ52o/gR6PruOBApZ5D/oM+zlXA=
X-Received: by 2002:a05:622a:453:b0:4ab:76d2:1981 with SMTP id
 d75a77b69052e-4b2aaa5a391mr141324221cf.5.1756286969245; Wed, 27 Aug 2025
 02:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110952.942403671@linuxfoundation.org>
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:29:16 +0200
X-Gm-Features: Ac12FXyjR2_2Ap9DL_NxnNquyZNvutlGiFrfINO9_uWhwx7OhDnR1sI8UBJW6vU
Message-ID: <CADYN=9+-T2KM14LfXqCt-Vb2ubz7T2Oc31vk356iYGUp14KCJA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.103-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 6.6.103-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: dd454ff512a6e333a3ff003fb0ab6297d90867be
* git describe: v6.6.102-588-gdd454ff512a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.102-588-gdd454ff512a6

## Test Regressions (compared to v6.6.101-263-g7ec7f0298ca2)

## Metric Regressions (compared to v6.6.101-263-g7ec7f0298ca2)

## Test Fixes (compared to v6.6.101-263-g7ec7f0298ca2)

## Metric Fixes (compared to v6.6.101-263-g7ec7f0298ca2)

## Test result summary
total: 278693, pass: 259513, fail: 6340, skip: 12440, xfail: 400

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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

--
Linaro LKFT
https://lkft.linaro.org

