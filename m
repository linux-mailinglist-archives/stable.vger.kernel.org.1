Return-Path: <stable+bounces-187994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EFBEFFBB
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74E6188FE56
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F642EC572;
	Mon, 20 Oct 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhZ4QVn9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA2EC08D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949353; cv=none; b=Kls+upS/Ql/v+zW8OLKw6M1WFPZVY4pHM+jPknNWuNHMhFf9xRQZTX1NRo0fGLrzsYVj3CNOBhdrP/AoT6TA7PHlTHXFxJoR4JYWu77B6gIulFV/cuuxoUyPlWEIOg2zE9QqNj5Pq4iXv2yWQOaR2UO+kK4z1+scUf0UG8uOmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949353; c=relaxed/simple;
	bh=KXiu+5v4UcoRocSgo+bMn+59MlVJLOAB9GTC3B2T+wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlaxyqV+oA+Y4xg7MLpocoX+aRJQBNKidIx4vkBd8Y0LUmfkr1qf7ISwmQN+EhSA5oOeUssc2l9zlLVaX/c+998wy/CvKjKWnAzIxPUODI5udyo8xx5sIFcULP6+fd5b/Vs+Ln2BicIncjAhkJ3/0MTDeKFlHwZATS8mt94XN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhZ4QVn9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2646635a12.1
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760949351; x=1761554151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FX9Zww9O3Jk2h6ADYPcVlunSkVS2QEMfHLussiu3vPU=;
        b=VhZ4QVn9FuXOpsBid61MR2wZ3i/1wMUrh8tKuiZXWRjxt2k+c/4cULgmcDCXwBlFqM
         axAct7Uv50PtPhQJg+QTonfKT4+0wM/7u8J71qG6+eoHeh08M1taBuq8Mzc2YnGYpeT2
         /jyQoxXLzK5yN9+vRPiaKGtncGlNn1iIks1Ce4DB/T7qNFIjVmXObxOo86oV6th4Apaq
         z13sXlYy97PF58KmnEPvcmaxsVXC6LGMYMInukvLs0iWCF4ZsMW/GfHmRXfDXoNSGQsY
         cFGdEn6qxSzuLuuvHKDnQJ6ReyhAmmFDhHkHdyp5P2eK3/9+zUrJruzGr7URhoKwig9R
         C+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949351; x=1761554151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX9Zww9O3Jk2h6ADYPcVlunSkVS2QEMfHLussiu3vPU=;
        b=bN2gZh/EKsZk9fpWEm/pg+L16NJ50wcpKvYZHY1dA2g6yZ3RVD6qfp2DxhYykgP3Kv
         AIBwVtWsl7w4TUR6TiZkzCxEKc+hnQ9m3g5GdXGvQwFgqccSP7Mt93fAkePWX4He/oW8
         YVeQKgTz5tS5uc5mA5i6/Ldk4yTDNJQN6PYSnSXanrj37g0c9VkLQeq46F2q+cNsbQub
         6z2naDvX32J4Bnies7AQSPDlDCJZt1k6JeCBzAV74YZHrpIfZdzZq2/oAjU+YYZSFi/8
         cP+3qg9YL7H2Ox7FhR4KuMtq8ad7I35WDqfFLYPvrBeuatFmDl4GDGAA0wgEPpN8tect
         FPFA==
X-Gm-Message-State: AOJu0YzcNo6kuB1XYZdQ9BwzZI22Owgr57wiNLROBSv7pFTRge4IvEHV
	rWyR2prqp3OZIv6WjMvzUtx1G9k2qTa2KYWWbcicbGMj+ltmPTFYPkbuEpMDU5SjOGdSN9ycLTB
	TvqI3owJ3LDrG7JiYfFpLMNn8LmKcam3CO6N+yxQmHg==
X-Gm-Gg: ASbGncvl7of+gmwTSSW+JItMkaOIhagvGLcCuMYQ1aDF6XNhOnMKaE5xgWXOVMC8SnZ
	vCREJEWgOjSAJvoevcd7bcg6c4lT6sJJMs94GH7EaowkHOKrjqALc8qXezpq1ZJXGjiQgcmIfWF
	s8oRKENxSJy6n/zx/R/gcu33onN5A9QV+KfJ+6VR2zw766zbHPB4sTr+Sh7JH29aJNlvxbgo4Jy
	hSYVH49Om6LxtjWBWin7jR4SXzN6Dsp9TZf0R147PhCMal2PtrO/awftkZQhDTqPGGixrWo4NI2
	PkoT09lHUvmQLJiX8/O/7sQLS76JeZq/EQNuBu7LeUEXu3lNDWKTP3duwCoo
X-Google-Smtp-Source: AGHT+IFU6oqLPRomRy1wMoIHTNVRaMz6K0vF41c8RKflT+lxT7vnWZwSA1KlnTClNRdxk+a5OsNTaoZrTRoLJTs8c1o=
X-Received: by 2002:a17:903:1a0e:b0:290:91d2:9315 with SMTP id
 d9443c01a7336-290cb27ec56mr149901045ad.42.1760949351069; Mon, 20 Oct 2025
 01:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145201.780251198@linuxfoundation.org>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 20 Oct 2025 14:05:38 +0530
X-Gm-Features: AS18NWDNViaBt7FwHRCuMSW7fzYxCXS7p9GLBdmfGDKx8T04yDIJQhzU5po7OCg
Message-ID: <CA+G9fYt4j3TvEtk_LsSUJojecZ2sk13Q_fXGi-ew_zNnii+RgQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 20:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

[ Apologies for the slight delay in sending the reports, due to the
long weekend here in India.]

As other reported,
The riscv builds failed with clang-21 and gcc-14 on the stable rc 6.17.4-rc1

Build regressions: 6.17.4-rc1 riscv pgtable.h:963:21: error:
redefinition of 'pudp_huge_get_and_clear'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
In file included from include/linux/pgtable.h:6,
                 from include/linux/mm.h:31,
                 from arch/riscv/kernel/asm-offsets.c:8:
arch/riscv/include/asm/pgtable.h:963:21: error: redefinition of
'pudp_huge_get_and_clear'
  963 | static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/pgtable.h:946:21: note: previous definition of
'pudp_huge_get_and_clear' with type 'pud_t(struct mm_struct *, long
unsigned int,  pud_t *)'
  946 | static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:182:
arch/riscv/kernel/asm-offsets.s] Error 1

## Build
* kernel: 6.17.4-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 396c6daa5f57fff4f0c5ab890c6bfe6ca31b3bba
* git describe: v6.17.3-372-g396c6daa5f57
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17.3-372-g396c6daa5f57

## Test Regressions (compared to v6.17.2-564-g99cf54e7bd2f)
* riscv, build
  - clang-21-lkftconfig
  - gcc-14-allmodconfig
  - gcc-14-allyesconfig
  - gcc-14-lkftconfig
  - gcc-14-lkftconfig-libgpiod

## Metric Regressions (compared to v6.17.2-564-g99cf54e7bd2f)

## Test Fixes (compared to v6.17.2-564-g99cf54e7bd2f)

## Metric Fixes (compared to v6.17.2-564-g99cf54e7bd2f)

## Test result summary
total: 123725, pass: 104164, fail: 4205, skip: 15356, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 19 passed, 6 failed
* s390: 22 total, 22 passed, 0 failed
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
* kselftest-mm
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

