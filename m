Return-Path: <stable+bounces-134745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ECCA94747
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C951894ACB
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74441E2007;
	Sun, 20 Apr 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvITR8tE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78821E3DE8
	for <stable@vger.kernel.org>; Sun, 20 Apr 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745138432; cv=none; b=Z154Moh3E03LnChg0Heip91naVQC++G6vrUZ+RMiAuDhwlYGJ8sRZZj/vTtgdbZd8ppktPuXft0+RhO/CQS5w2rP1qsySI7c+1Qoc7OyadFltiAsuY1GA0/Kwo487qljKY137KgVrKch1iAupHG6Fyjbj3i+8KAm39x6cwCmWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745138432; c=relaxed/simple;
	bh=woemORrLLWF1K7uMEkke/yXamBeeLAto+ZQdMoP8QfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTkxWBIsYF8sjo21pYf+fEKixZ67Io9/UrGeXoIMLevMrmjzg9/rEEm5ET+klem2e8J8RlOa9lUj8wSTW2wjZOh7YYvQPXxThOgHddsil1Wr/fkMdk/X7GK1tFjj6GFiiz8vpiChptOjeFJkKwreLo9m81oIosk1cz4w+kJc+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvITR8tE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-524125f6cadso2829286e0c.2
        for <stable@vger.kernel.org>; Sun, 20 Apr 2025 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745138430; x=1745743230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViwSHByjhqiBr0sbbqIfk4d141TASD6nPRDr4j8ZRsg=;
        b=qvITR8tEK9r9Mn9MLdD0SdhvLSoiNYyVv51Y8lTuIBLSM5TqDf75vGjpNgGdbsYfvc
         vF4mXPJHc0CXh96dlg9peqP6dm0jsQc+G3EKdJ/okxaXdrFWVG/NBqvEW1L+bVMAYMkt
         84Yz1EWHBfcqrrjzp8NSVet+nAn69OoSXCXJ+ZYQe4SrK//xpvgmJHiNxfqv9brM+R7F
         277uVoY3F+vBoIv9GZh+bYpUPVQrShfBpvJHRqtvKoyUCMQ6WMktNycV2y+8q3fqoYFp
         GM+55mNE7IhwjICxETsJWN/WkKGFq4YUzUt2o2FmfyeWefTuvvmBelxMz29IfAUrsw4m
         WXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745138430; x=1745743230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViwSHByjhqiBr0sbbqIfk4d141TASD6nPRDr4j8ZRsg=;
        b=Xk7311TTbsLlT522Zx8RCGtB7bpkKfBM0nB4ArerhUiLvd3/H0QbybuvNs81UyDZSy
         wenNtlRCp3PefwQt9zFK/EDyyVNYJtddhuvmcv5mG1folaEXUoq+eSeCHcrKIMHsCd5/
         Wv2ZcEZkECH+b9/eEmLg8XTdMe947qudb/4CaK8mshlZYOlUnDRXDMafCAnLpy3EghoU
         TRC2A4+OgsO+qrj1fEmpPuR7Vs6JGDxxRGuvpqjBekfKalFZyCCnuQWkoLCfhra5xdgb
         wizbVncooo0m6WR9S2+//erLj/lfukjTFYbgFXBB27ZNd4VXlH3ZAlNovDUgmPP6tSpv
         NFgw==
X-Gm-Message-State: AOJu0YxRpjUHIsSGOD68b5gZQw5dm1mIZVLEMykY4z59i7wdU/30UWfP
	uvNX+LDT1F25jEoGwF8FkAEGAQ/qEfbwzAHFqpsvyf2zUK7BfPT5aYN0l6icvAXCJ24GMiBKv7F
	fN7IM7INrKu6CWktxVLnVrnUEXSYM5zQsIC6ERw==
X-Gm-Gg: ASbGncuXmj9POx1O5om69hnxRMH1S2oZtKOd9pVOCvnUUSISRgCY/CVAQkC8Fm770fr
	1U55XpfSfgN0CLKtYQPRyMIq0OB/d1R/Ii1mg8yxopiRYr5IXOFa9ZEo2iFxLGSS7AXo17/QHJs
	JGR34a20cNYnVSFepjYM373fBmQw79yQM6TBG2alJoVsxGlajvLbWSRJY=
X-Google-Smtp-Source: AGHT+IEz+be6P9zuFtYLq3tvCI3eYt7lfjnL9C6y6Fzllw/y7xniy8Y32Cqcz3er3WoUJDpn13kMedTF98u4coLzE+4=
X-Received: by 2002:a05:6102:31a8:b0:4bb:cdc0:5dd9 with SMTP id
 ada2fe7eead31-4cb80140081mr5076189137.12.1745138429694; Sun, 20 Apr 2025
 01:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110411.049004302@linuxfoundation.org>
In-Reply-To: <20250418110411.049004302@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Apr 2025 14:10:18 +0530
X-Gm-Features: ATxdqUE5xkiBoMP6NKS2zZ7mRpAnwyQLwHxri0gZPa9PGYQxl-8tp1Lr-Y2D4_g
Message-ID: <CA+G9fYuw8CoFE_xZJTx1c-wUqgEgcpAG16DWc3CFvspXivNr3w@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/413] 6.13.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 16:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.12 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.12-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 dragonboard 410c boot failed with lkftconfig
on the stable rc 6.13.12-rc1 and 6.13.12-rc2.

The bisection is in progress and keep you posted.

Boot regression: arm64 dragonboard 410c WARNING regulator core.c regulator_put

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Lore link:
 - https://lore.kernel.org/stable/CA+G9fYstVDU_e27mkqEJC0O742zUb0A=wny59n2SiiH7Z_ouJg@mail.gmail.com/

## Build
* kernel: 6.13.12-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: dc7115a5e746cfc480bac46a4d170998f209f950
* git describe: v6.13.11-414-gdc7115a5e746
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.11-414-gdc7115a5e746

## Test Regressions (compared to v6.13.10-503-gb51363104424)
* dragonboard-410c, boot
  - clang-20-lkftconfig

## Metric Regressions (compared to v6.13.10-503-gb51363104424)

## Test Fixes (compared to v6.13.10-503-gb51363104424)

## Metric Fixes (compared to v6.13.10-503-gb51363104424)

## Test result summary
total: 144934, pass: 122237, fail: 3121, skip: 19056, xfail: 520

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
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

