Return-Path: <stable+bounces-105161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173A9F6733
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06541896915
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4D1A239D;
	Wed, 18 Dec 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxDtFdX4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD5155CA5
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527985; cv=none; b=F6drowFP8iRe7oc6RCyfOJ+klU6+GY6Mq2q7EI+RAb2ro6sSJGFuojq8VqqnZiWxXdRrvm+YIvmCEidKSNJ8Ku0fR4BVHkyHb4X3JLlbfAuK6L6sJkx2BscEstfxwYlklCWQc6/eB2fJS62mRFKz9f03sdcGtz+rh8/mfF7z35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527985; c=relaxed/simple;
	bh=OSYIhm6gzc1k9xUO3sAiiENwmsUpJfErX3/niG//G04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzuoe6EjcidhBxDypGv1hTpMecnEVxqdpwdhLHCM9R61t1QRnyCJ0AN4gnTGEWKdF08vDqqCKnWN1SI87a+VOPhOXwVnx1vxepIY/+aoCCdy8lt4Yf7SVx+rCC7iJPfQ/Q1/Iz0q7KXT3eG7DgbTTbDzYck16xpm5gb6Uck1ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RxDtFdX4; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c559ed230so1245570241.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734527982; x=1735132782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nkYHqGiM51R3u4JuJh1n9R4Y0+8hH2nTYzCkFQ9MdOA=;
        b=RxDtFdX423Wumpz3DeU+iPwH42TL0B302X/PBdpA1HNokMPyc20lL3e/8PF/LPuPsV
         D6icguQ4SVzdU4J/TVWlAjb4AyEKnW/M26jiLei11eNvc1dTJNSfvyCXj/yEhX5EDW6E
         2fDryhsExA+pcPc1/AOej1+/rCrHeXNVkSvqd2lcaT1HDXAV0pqRFkL8TuOHRaCS20q0
         YK3XEW/ILWZP1bExe1bFDjNW26jJVBo4V7x9xrEjE4zP5N5sluIc3Yu6zsN5ujFhshTG
         0ClcIFlFMGck79Nlvx7DftqXtL/8kpoLRmdP1mHygk7vWRU1mD8dgzTIlexvOQTV3H6G
         S+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527982; x=1735132782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkYHqGiM51R3u4JuJh1n9R4Y0+8hH2nTYzCkFQ9MdOA=;
        b=SK0k82XCDOiIyuR81TGDDIDN9UUegyHeKoow9W2wPtwHg5epXXx4iITUFOellOB2C9
         Rj/C4xaot8xeJEVZpAeMS2BjEAOvhMMrkY1+btb1R6SywdK6e+SRXi9jA0rCENZH9JTj
         ZqYReDN96PBMQEfa4XV7gcc9u6dw+dLghV51iLcENKf9AUwMtnUDmtVQlZ++Jqg/F6cv
         gqqJk8Oq77c3+LeBV5yBHLmtbVs9FUDVG3oEYe4g0nD/nvsqeEjKXFLkluEj5N2Rk6Pc
         AFZ5FNNY+mQ2WUOLaRxPILVMCaQwrEIBEILHHfQSyru7B5w0eeuhpADdeZVxanrSK4e+
         80ag==
X-Gm-Message-State: AOJu0Ywj2uvMx+ptHrgzlKkYRP6pEHH6b7cMv1enDb7R8KKsxTrCCB6D
	NwubRQ+nKz/pczJ8zyP7s9RZPwHmVRG8azsBEXb+QHNPBkGrKewleQykdOLimhP2CRanvuODYdC
	fLVLvv6UEVzs6PFyzfGHJVqFuN5r7ecCP3kBSHQ==
X-Gm-Gg: ASbGnct4St8E4rEBtoWRbvn6wu1Ecj5bivlC6MEfJCGM0dA9JwDqNPwTaCNV81izwAR
	IRxG813Fhbr7wTg0rtcJZkSKJwuCSYockiTDeQtA=
X-Google-Smtp-Source: AGHT+IHV0AAjiF7AGclwvtan1ApM2gM6uozIVu6uhPJD1V/RlAg1+y3ThCejjCXK6XckfaMd1xrkY3SY3zDSzqRL8Hg=
X-Received: by 2002:a05:6122:1ac7:b0:518:791a:3462 with SMTP id
 71dfb90a1353d-51a36d992d4mr2513184e0c.9.1734527982196; Wed, 18 Dec 2024
 05:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170546.209657098@linuxfoundation.org>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 18:49:30 +0530
Message-ID: <CA+G9fYu0_o6PXGo6ROFmGC1L=sAH9R+_ofw0Hhg8fZxrPRBKLg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 22:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The all i386 builds failed with the gcc-13 and clang-19
toolchain builds on following branches,
 - linux-6.12.y
 - linux-6.6.y
 - linux-6.1.y
 - linux-5.15.y
 - linux-5.10.y

* i386, build
  - clang-19-defconfig
  - gcc-13-defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------------
i686-linux-gnu-ld: arch/x86/kernel/static_call.o: in function
`__static_call_update_early':
static_call.c:(.noinstr.text+0x15): undefined reference to
`static_call_initialized'

The recent commit on this file is,
  x86/static-call: provide a way to do very early static-call updates
  commit 0ef8047b737d7480a5d4c46d956e97c190f13050 upstream.

links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.5-173-g83a2a70d2d65/testrun/26375840/suite/build/test/gcc-13-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.5-173-g83a2a70d2d65/testrun/26374171/suite/build/test/gcc-13-defconfig/history/

## Build
* kernel: 6.12.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 83a2a70d2d652a062cd4373f4e09baa111160de0
* git describe: v6.12.5-173-g83a2a70d2d65
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.5-173-g83a2a70d2d65

## Test Regressions (compared to v6.12.4-468-g602e3159e817)

* i386, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-lkftconfig-no-kselftest-frag
  - clang-19-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-tinyconfig
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig-kselftest
  - gcc-13-lkftconfig-no-kselftest-frag
  - gcc-13-lkftconfig-perf
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-i386_defconfig
  - gcc-8-tinyconfig


## Metric Regressions (compared to v6.12.4-468-g602e3159e817)

## Test Fixes (compared to v6.12.4-468-g602e3159e817)

## Metric Fixes (compared to v6.12.4-468-g602e3159e817)

## Test result summary
total: 106171, pass: 85929, fail: 3687, skip: 16555, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 54 total, 54 passed, 0 failed
* i386: 18 total, 0 passed, 18 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 24 total, 23 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 46 total, 46 passed, 0 failed

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
* ltp-commands
* ltp-containers
* ltp-controllers
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

