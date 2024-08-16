Return-Path: <stable+bounces-69300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B49544BA
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3F1C214BA
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733E13A250;
	Fri, 16 Aug 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Up+PNOTK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87796CDAB
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798091; cv=none; b=jT+1n/h8LZ/vImuJvI35lDqEe+ZPEgurzAhbL+OsOcZ8jrtVMC6WdBAPnlbPlcF8jM9ha/sAOJ3iBADUwZKTWXBOx1USZuZW/RghTESQU+R1WbTV0oQRvhKcWgrpqMDIarSToo/6xhCnJwEfToMGYSqUFae8ROmY5b9Xz/lHoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798091; c=relaxed/simple;
	bh=bmyrHc574do+lctxZWnJC4whXOXLMycGax7Zbv4IkWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J04J7HRo9ziTH3fSyk2o+35HEpO45dvcgIyhu6f/CSydgGIKq/SBrGV/nW20RW7eRNltVJebSIjYkO1suIlq8bw20qN9ZXwKaGa/RX4tEo3ky5Ehq6jmKimdiD43rxGt39yTnllyNov+R51oVlbcnaM6HBGY0DyKhLPzh43bqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Up+PNOTK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94aa5080so206219566b.3
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798088; x=1724402888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgDB2NePct9+ltaB/xLwIrrImMavCdcOJFMhb/o2DB4=;
        b=Up+PNOTKwXJxodXq4rxwDfR1Z3eKsTaAOsdPY/MyUo+MiRO3ro3reUU8uoS/nmpXZB
         5ufoKUpAeIeP2WKklEyWrzH3E/N4RPFXCtsJKate10wj9MSJCYi+SyGPRo9PGufFmBcV
         r0ffrB00EhkFXZEmDBw+gfQdNa7khzgiZR+TeU58vcFxP/5fElpM71FM16SLFkfDZbVK
         RZstBPlyN+yVBCyr035jow1rVCooe3wxlwzWydUwPZ89tv4Hjw0VTyhv4OZEcbAa7qxn
         yCOB8ITROMShuKfVfmj57SqH//HqRHcRBzto9Nnwd/Z8zz79Ul/EmKtCUtbDIzg9PCx3
         NMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798088; x=1724402888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgDB2NePct9+ltaB/xLwIrrImMavCdcOJFMhb/o2DB4=;
        b=YABcjemNXD919sIUyjiXUJ955+8gBFEiPYSc+qWw8L65YrU83caE55WkkXHrkZhStq
         wl4YQTAp9V7T/+60JMZaNDDN/OujPVo5PdBcLADxha5NKw5vcAUnm2PyIz4cP37EqA0U
         naMCczQz2g4HcdJJoIFLzEZVe3EYkQq+B1O78dHvmqRNVb9DVUm6GmRhly9ZNQhbMT4g
         K7VxqY6zlgQRP49vIK9iAWhrwJrfemCA07KhAotlsaAQg6PMV443gt1Pl7PYi4/TUG1d
         rGtZ/ROujasL7LyD6iQcOk9NnqLn6LjtWWxAImGDI0BWid0hqimmw5kXL2QI3pNPrE9v
         LyjQ==
X-Gm-Message-State: AOJu0Yy4JYjCoxeR5yrztpqc0cbYakootRgk23pDlnjt0YdD53CKtZLj
	WZw6DQe4Pbl0AraXzWhtuyFeTFB/7tZdnLt6090xi997KqJkbCiLr0S126zmLe5KvgK+WvaVmbN
	Gscat/lVyJy5UxuAQ15zqZf1Ioxg4l6hNNO3Bcw==
X-Google-Smtp-Source: AGHT+IHMrXHEq/AoPlWkkFV3X21l5tRq+ZrKaLROjooBrsCA7qHeDdKASNHVtAR6pCNmKKXHOqYkmYzfqiBhVBsjRLM=
X-Received: by 2002:a17:907:6d10:b0:a7a:b839:8583 with SMTP id
 a640c23a62f3a-a8392a42a3cmr161029266b.66.1723798088013; Fri, 16 Aug 2024
 01:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131832.944273699@linuxfoundation.org>
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:47:56 +0200
Message-ID: <CADYN=9LTKMLu9u3XZqv_-r_KK4hL-tnX14VpSpE0iA16Favkjg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.106-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.106-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 09ce23af4dbba4a348ad90cbee52a46ef1d685cf
* git describe: v6.1.105-39-g09ce23af4dbb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.105-39-g09ce23af4dbb

## Test Regressions (compared to v6.1.104-150-g9bd7537a3dd0)

## Metric Regressions (compared to v6.1.104-150-g9bd7537a3dd0)

## Test Fixes (compared to v6.1.104-150-g9bd7537a3dd0)

## Metric Fixes (compared to v6.1.104-150-g9bd7537a3dd0)

## Test result summary
total: 159479, pass: 137501, fail: 2504, skip: 19237, xfail: 237

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

