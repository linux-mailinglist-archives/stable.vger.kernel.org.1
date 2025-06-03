Return-Path: <stable+bounces-150645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F6ACBFBC
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BE5170EC5
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 05:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E51922DD;
	Tue,  3 Jun 2025 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0p6kvfL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE51F152D
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929729; cv=none; b=u/Q2GtebNPdeATUvq14aWB21NCwViHMhfy12yHZ29J5U1EkKhw7vz7aNFNW4hbWjt7VPkYyHfPrxm3GsiBCNQGmgCH9dg++JgVYMqWmDo9lQ4aMWcZqiu+Dt8m0cVlStP9x4VmGj3EXg2GU4/2sRtDcRZuy5GebFkrtie8IRwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929729; c=relaxed/simple;
	bh=7jWU94ik0QbWpSiooVhPx/UIP9kCzHJhH1gbv4/E8qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNkFZVaWAxUWVA0rTW5TAtT4B8HwP1hkBWKtmkrzpuK+BFTkGhTqKGQgiOIi4dzzOy7VjK6X0PARGXlmNNhEAyMWjKpb/Oxt+F1YSknfBhrYQOaWXT/lvGF/jKZgBcVBPlvvZ/0pBQIIVS/XrhrQQOZMMsQcA4RWbs7EaV/CgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0p6kvfL; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5240764f7c1so1563201e0c.2
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 22:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748929726; x=1749534526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CaaJTsDGCShy9NH8Xsdsynpcxp9Oj/lPPlRCEtkrCPY=;
        b=v0p6kvfLs52dT0vp4hngO+CPMgP4kdiolD9OkOtGXTDOay0XGOJHwdqznJvS+DQZYF
         8cPPXMIyXSnru9ADzZvD8K3rruk5VCi3bLDpSQq838QOy1rjf5EL7DdvQFuslPnQtPDf
         q2ATA5ZfMiCdx/dvOEuEZkk61Il0ZZYFHpP89vDtX+i6Ldomp/ILVg3lQESYuzJ8aNwm
         lDINZI4c7Xr+5OoN4q5doEMg2f/yR78+cKR7el6dobdyjC0/2FF+SwirfsJMpr8R1uvn
         pu0KCQNZBqd8rMA2O4ICocS5V8XkzPLD8w98cfrzeSs/LrATYSGaVf61dEgB6fjO9paW
         fsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929726; x=1749534526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaaJTsDGCShy9NH8Xsdsynpcxp9Oj/lPPlRCEtkrCPY=;
        b=qwnmE7ofE5Z1S0biM8IRtCsa7J/Bu+5nViLQCUMKOgixOujyKhOyNaw0VUdbDgReP5
         Zr+RTD70ocYVJc2Sy8oAYdF1cBSTZZgZMhiqN9LwPQAZEIvRtSq9cgBWkkv78yPVSWW8
         zVkqAzHc+t1DNMPxNqRViD5JZcn9pScAVi/lbcztpvUAQbcpeug1xyjDwW8PSmpjhiz+
         yU87VetVYu+g+DP9j3ijyd3qf9NdpBS/IzRVTWYQk2tb1D+c31EzXIzGJE6TzdVb7lVl
         +KeqU/7J8z/3iHAccAAvlg0Ms2hgrBFBN3z8zYxbDVgCGkprdLosMjod+B1UHjVy8U/v
         iseQ==
X-Gm-Message-State: AOJu0YwHE4q896RghReYQYVHtmraP83hjmYkmuKVW4ZyBZdnDy6LMiUA
	vTZDk0iL4JWIj/uhax2A5T34QHCkS6eyo1xHoLstOhhWFI+t5SbqQlxOVJ6uOKZTCX2UoU4ZUXO
	/rgJgEtY5Ds9IDv+738XTa1SCLYc1+n3S2ZzmX9sAVA==
X-Gm-Gg: ASbGncvXolprHv36fCVO91nBffsPGEqub7g8EmcfyDOgJh25g35j46CjFMmQowZzOVf
	3fyuIippJ4eWt1tgYkH0/vtu8fG4dd+1J5TlQ/kfPVLwmkkc3NRkav89MVNuT4gBhJ2ZXAu9U4Q
	cs8w/micRKvrsXIHUQByXo1Ylie4YKtNE=
X-Google-Smtp-Source: AGHT+IEE/W3g2hwG4gBEVSF+Iek3RiiwVhogHCqvDg/sShN7bI2AYBy6Y0DQ9iTRS3tglw6ByUzvKUeEdmZvkZarTk0=
X-Received: by 2002:a05:6122:a2a:b0:530:5a43:db61 with SMTP id
 71dfb90a1353d-53080f59017mr14951319e0c.2.1748929725864; Mon, 02 Jun 2025
 22:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134307.195171844@linuxfoundation.org>
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 11:18:34 +0530
X-Gm-Features: AX0GCFu7rs0fy7qq0P5qjPajChCgj4kaqGSHnyRwSFbbdU0gilubxy8DH1XzJEY
Message-ID: <CA+G9fYvkMUv4vFcde9A_chiiKOSkRiydGwnahgZauGExdmWEtQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/270] 5.10.238-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 20:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.238 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.238-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

There are two issues,

1)
Regressions on riscv defconfig builds failing with gcc-12, gcc-8 and
clang-20 toolchains on 5.10.238-rc1.

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: riscv defconfig timer-riscv.c:82:2: error: implicit
declaration of function 'riscv_clock_event_stop'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/clocksource/timer-riscv.c:82:2: error: implicit declaration of
function 'riscv_clock_event_stop'
[-Werror,-Wimplicit-function-declaration]
   82 |         riscv_clock_event_stop();
      |         ^
1 error generated.

This patch caused the build error,

  clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
  [ Upstream commit 70c93b026ed07078e933583591aa9ca6701cd9da ]

## Steps to reproduce
 - tuxmake --runtime podman --target-arch riscv --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

## Build riscv
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.237-271-g8bfb88108193/testrun/28635871/suite/build/test/clang-20-defconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.237-271-g8bfb88108193/testrun/28635871/suite/build/test/clang-20-defconfig/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.237-271-g8bfb88108193/testrun/28635871/suite/build/test/clang-20-defconfig/history/
* architecture: riscv
* toolchain: gcc-8, gcc-12, clang-20
* config : defconfig
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPulf5bqlsj7nSlN9PnLY9NXG/config
* Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPulf5bqlsj7nSlN9PnLY9NXG/


2) The following build warnings were noticed on arm with clang-20.

Build regression: arm at91_dt_defconfig warning comparison of distinct
pointer types ('typeof (nblocks) *' (aka 'unsigned int *') and 'typeof
(num_node_state(N_ONLINE) * ((1UL) << 12) / locksz) *' (aka 'unsigned
long *')) [-Wcompare-distinct-pointer-types]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build warnings on arm:
---------
net/ipv4/inet_hashtables.c:946:12: warning: comparison of distinct
pointer types ('typeof (nblocks) *' (aka 'unsigned int *') and 'typeof
(num_node_state(N_ONLINE) * ((1UL) << 12) / locksz) *' (aka 'unsigned
long *')) [-Wcompare-distinct-pointer-types]
  946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

This commit is causing build warnings,
  tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
  [ Upstream commit f8ece40786c9342249aa0a1b55e148ee23b2a746 ]

# Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig at91_dt_defconfig LLVM=1 LLVM_IAS=0

## Build arm
* architecture: arm
* toolchain: clang-20
* config: at91_dt_defconfig
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPtpUSdrY70QnawZR0ftSwhPt/config
* Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPtpUSdrY70QnawZR0ftSwhPt/

## Build
* kernel: 5.10.238-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 8bfb881081935b7a621f358516e28f4470af3296
* git describe: v5.10.237-271-g8bfb88108193
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.237-271-g8bfb88108193

## Test Regressions (compared to v5.10.236-287-gce0fd5a9f1a4)
* riscv, build
  - clang-20-defconfig
  - gcc-12-defconfig
  - gcc-8-defconfig


## Metric Regressions (compared to v5.10.236-287-gce0fd5a9f1a4)

## Test Fixes (compared to v5.10.236-287-gce0fd5a9f1a4)

## Metric Fixes (compared to v5.10.236-287-gce0fd5a9f1a4)

## Test result summary
total: 36900, pass: 27422, fail: 1956, skip: 7366, xfail: 156

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 100 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 6 passed, 3 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

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
* ltp-crypto
* ltp-cve
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

