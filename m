Return-Path: <stable+bounces-105199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56569F6CAB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F9816609C
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA11F37D8;
	Wed, 18 Dec 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBiNxptu"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A181F543F
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544235; cv=none; b=oFj+NU7iVmvJ6L8S49Oto/iUZI8uxchsCggvT+BkkoMqTT9jOTHgPru/4yV76+vVYm6kdaOspNs2Aqi9IRgOELVL6WovVUna69X8ezBOSAcAaj2ZJy5Z55axEkqGY3Ky8+W5/2oaZqiKuKa8o/tPC8gLddVwrNdLcom8FMmq2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544235; c=relaxed/simple;
	bh=g4Ka36KBBCMFfxKyDfAx6X3SSxRqpkHT1rajD5T92xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM7eYr73H8wIXnlj1mO1kLE39KMKfiF2c6xl2zIvJIlFBNFkZFraQbihtmto9wU41LhGNxnNuEz3vbkOyzWnglqFT8xU41dv/gbtsuS+v+ZRJScjg5y7vJV7oFcwkqiLlCBTeKmbvL6phTJqVtk75PlSvHfXZm3rsfeUsXNK4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBiNxptu; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afe99e5229so1893623137.3
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734544232; x=1735149032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2sR4vxr2u0bEo+T81Gp/c6dhWFhrBiBB15YrQ3Dd9RU=;
        b=pBiNxptu+hAk1gDmzTMg+Ox9JF+nPEU7Fz6kFm41sgTKsxHGqsI/PtltsMZmTfWrKn
         MX7ivEtfPr2c+7N/iE9ESrqt7z7tuLZnFqZnrvLywiSnLeIdPRM8z81/qOYCBcI93qiN
         TKBo9WKYRsVFYtBiOJTMl+lP1yyG75CXYPspSXyB4p6t7+3S332tvQEEXC/XgWYpIRPO
         NmyIro902zyCox+V/L+dNc1sAbH2QA4EW81+Zj7xExGlVAdCbQNUQzXtwwVINz4WAGBa
         gAoAXy/Sj9pWnRy0z5Bh2ZoIgxvY/jtkJcLb1ghPHlbnrAP68R/x8WaFMpVMJI+6xp58
         74NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544232; x=1735149032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sR4vxr2u0bEo+T81Gp/c6dhWFhrBiBB15YrQ3Dd9RU=;
        b=AZixR0FEofwldHn6DV+2qQ/ZADDdx+udhDjrFOK2YhjgxYHsunLEOix4Yw24bQ1vGa
         jB+y15TjDWdDSgK89LyBcNrqEkABJG68qamwk6iLMTxA6setWw2jU9RCg7R5uB941S3D
         ePjUVa7TItB8XOIbp8UnY80ezlg6kQpcM+h/0cMJ2/a0096bJV9PHPa6xg1EgFq6tC3I
         aMCXpEcBrFiwdUiYHEk0Fy5/ZIVWQyHT8UPd3w37T090rTThIzoswSN3vPdr93y1XW6C
         O7ruum4G/Aa7n2m5ytFyWmHRsE1NFZGPUX55VJqpuvY3Mfy+m3diHGa6249NbZMl9JGe
         m57Q==
X-Gm-Message-State: AOJu0Yx3C033m8YvWWNo0lZ4S/Cw4kcIDqEzWlbFVBBxSQZ3O++4DHlp
	C3KHCourZjWGLK6L4XM12m25VrZq8UpaUfcOYjKyr3qOsNuRYhZGXxrB9Kx6qcHengZD/2VEKUh
	rHOCfdjMe/NNKvQShjH24j5wXBDV74w39n1u8Bg==
X-Gm-Gg: ASbGncv1ky1yabmYJ3+UpWk3SgM0b4Ziul3qRC99KdUpHGb0iO1UjC5+2BBofIrzx5D
	pPYHEO0UH4Av6PhTQCpfsUnvxPE2YHey5wU7QyaY=
X-Google-Smtp-Source: AGHT+IHTQX6gwPKKgU9qU6opkl/kmrHOgFrpfKorqt+GbF/0yKvbFZ1/+4jXQsLW/0QZqR0j4eGvBMpHuZ1/u+fi994=
X-Received: by 2002:a05:6102:290c:b0:4b2:4cb0:91d5 with SMTP id
 ada2fe7eead31-4b2ae78b08cmr4243706137.15.1734544232186; Wed, 18 Dec 2024
 09:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170520.301972474@linuxfoundation.org>
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 23:20:21 +0530
Message-ID: <CA+G9fYv8Nbwosfygns-xbEPqF0bWeoJTodJr=o0NUUaAF60CuA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/51] 5.15.175-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 22:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.175 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.175-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The all i386 builds failed with the gcc-12 and clang-19
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

js wrote:
Yes, the fix is at (via one hop):
- https://lore.kernel.org/all/aec47f97-c59b-403a-bf2a-d8551e2ec6f9@suse.com/


## Build
* kernel: 5.15.175-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 11de5dde6ebe6f214c662453d6b8b6c3fd349590
* git describe: v5.15.174-52-g11de5dde6ebe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.174-52-g11de5dde6ebe

## Test Regressions (compared to v5.15.173-566-g4b281055ccfb)
* i386, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-lkftconfig
  - clang-19-lkftconfig-no-kselftest-frag
  - clang-19-tinyconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-lkftconfig
  - gcc-12-lkftconfig-debug
  - gcc-12-lkftconfig-kselftest
  - gcc-12-lkftconfig-kunit
  - gcc-12-lkftconfig-libgpiod
  - gcc-12-lkftconfig-no-kselftest-frag
  - gcc-12-lkftconfig-perf
  - gcc-12-lkftconfig-rcutorture
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-i386_defconfig
  - gcc-8-tinyconfig

## Metric Regressions (compared to v5.15.173-566-g4b281055ccfb)

## Test Fixes (compared to v5.15.173-566-g4b281055ccfb)

## Metric Fixes (compared to v5.15.173-566-g4b281055ccfb)

## Test result summary
total: 57093, pass: 41250, fail: 3116, skip: 12683, xfail: 44

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 0 passed, 22 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

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

