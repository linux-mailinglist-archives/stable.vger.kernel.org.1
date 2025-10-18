Return-Path: <stable+bounces-187829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E2BECC17
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51B2D34FDCA
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486A233149;
	Sat, 18 Oct 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MprSnvQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C52737F3
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778540; cv=none; b=LPABoloRUM3AiGMrnCiLWJs8gQUNyteWKGxdrnqAtFWaLTzZRKe9dnnNQ2uGIy8WQXcDEIUN9N3eJVUvf7wVEcFeldzTXtY5TZPxuqDY0UxecQhhKlRRo2IXLy8ADwluKsWyVFe85mUECLKgBRaRvfavZeQPf/TjMcORE2mDu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778540; c=relaxed/simple;
	bh=/FYWQzbOzvoClNNL0BIFiHpFJ4T8coSYDyWOiKJ8bcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkR5PEuo1yepWlXkt7caxkNmYq+CbOhWmIrzs9uO1WYCfruQm0M3sLxY2l6+xibkvKIk/l9d/9p6WId/wUt7QNYrNC2XV/n0XryT3NY+hRn3KS6Cmnm83YO7qSQ13/ZAQltk8VqFkb6+duLNwfQdroSQHzPxkoLIh4yAHI0g9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MprSnvQ8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290ac2ef203so26417685ad.1
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760778537; x=1761383337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQVK5cROH6bxNTSxavoBpXRZvMfmTRCZy1DV7Locyhs=;
        b=MprSnvQ8MRhc2RRfGhJg86G+TmvhqBU8yWA4ifgpM76GuqBIBujgIAZ1FFUbCk4HaA
         dQPuVnsq5JbJycqKY7767LPzyC+152NgIw0WFRSdgBCAyNoUyH3nM/wzDrmpyHBwtrHR
         KHIiv18df78yee3nSU3r1puT1iam4unSyxA4OovtTE3R/gBHBvZSXkXNpdDYOjO3RRj8
         XuoGCXiWJIst2ZJbmfhIy1lCbYrdz/YGNMxkbv7Z3xd2ST9duJT1QH8gjhiHwAO4/3yI
         V1e7rjuoiKmrZMZTlyOsmKyhoXrRBKPEjBmduUE9mYrd+6LSIsMNcBu64c3IMSiLnh7D
         0Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778537; x=1761383337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQVK5cROH6bxNTSxavoBpXRZvMfmTRCZy1DV7Locyhs=;
        b=vfxW/uDkR1qawIzxY7XBpyD5P2DApLzdsRfHSzA6qPCt80tuJCQUZiH7OIIij4Q9GB
         imhE0NltbZ2aHfUNjcxo4A0AwezLfhufpEE/d+oLzOaVvwrsVfvep6t7RWOZeiaTxd/N
         65Z3Efuv2i3k0fVH1c9HIqlOGU9Gq6z1IIhXYDvseYHvmpDtmsF/Ftahut0rxwb1LEQb
         zqBPwmgjRHJWMbsR3Z+BCMfm6wXX3CH4LOxTmShE4I8QzNTl2JfdYzCVovOmr8nXWxVi
         Bv1hdqsAG7VDrlP2YHtyezjhmcexN7oGhYF7z4gL3jwt7//zujz3OQp2BhYiXxkwbqyL
         K/3w==
X-Gm-Message-State: AOJu0Yz6m6U9C5ezQc/N07VEhNrySgNE3UGQitX7tx2JVrUanfpijU0I
	OVgCdzZZPJQ5PhB01zsmtx9YydAr5XeY5N7fEaRgp7wmrWlqp5PZ58Lkz54MewIaMy1UFYlJD/7
	4jVE77zdxHuJ6i6LO8dmp9/VnUYJ7HGamKzGzb59YXQ==
X-Gm-Gg: ASbGncsP7zL0KGszu39K1o8KS3PorN1tYwcNc1QdqJXwNeR5ntcsVTDwOZub5KNM71K
	3QBz1e6fjQHbksRhhnJUdZubxDQ2aTt7MztS4AFbMJwvozT/h560scnYg474ePLVY8St91ybKdQ
	KBZLirzqSmkYDfiDlZ0Y8I2HhOO5tJoyM6nSCq72bmN2WvKyDNuQKA06v3KtCDxOnmk+OyUlp4b
	Xq1srOVq0nAQi87nwwek4f5TA4a6D0XSbzsIYkZzVn3H4/wEgOS3vBVPNfkGF8LI5Qro/CZvIbP
	7593dYeTJ/OzQkLB0F/40DVztuxTc7nOxROF+XKNtNOYHcJK
X-Google-Smtp-Source: AGHT+IE7ExrY3OVIoQB83N9TwSHawvzsErqOIigCljvk7FolrFSc88sMzVtkF59NgvcU+Q0F92YmHusU7wsTlGLSEM4=
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id
 d9443c01a7336-290c9c897damr96864885ad.9.1760778537482; Sat, 18 Oct 2025
 02:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145142.382145055@linuxfoundation.org>
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 18 Oct 2025 14:38:46 +0530
X-Gm-Features: AS18NWD0KnBH7UJI41xuDQpsLXOxSTkkZzLKu0UMG6njeRrDPLXw0BTSVYr9tqQ
Message-ID: <CA+G9fYvRHXOJUfKqxj9MNA1ax1i2xCrazh0x9b3QvrXLm+N+qQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.195 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.195-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 build failed on stable-rc 5.15.195-rc1 with gcc-12, gcc-8
and clang-21 due to following build warnings / errors.

### Build error:
drivers/s390/cio/device.c: In function 'purge_fn':
drivers/s390/cio/device.c:1330:23: error: passing argument 1 of
'spin_lock_irq' from incompatible pointer type
[-Werror=incompatible-pointer-types]
 1330 |         spin_lock_irq(&sch->lock);
      |                       ^~~~~~~~~~
      |                       |
      |                       spinlock_t ** {aka struct spinlock **}
In file included from drivers/s390/cio/device.c:16:
include/linux/spinlock.h:387:55: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  387 | static __always_inline void spin_lock_irq(spinlock_t *lock)
      |                                           ~~~~~~~~~~~~^~~~
drivers/s390/cio/device.c:1353:25: error: passing argument 1 of
'spin_unlock_irq' from incompatible pointer type
[-Werror=incompatible-pointer-types]
 1353 |         spin_unlock_irq(&sch->lock);
      |                         ^~~~~~~~~~
      |                         |
      |                         spinlock_t ** {aka struct spinlock **}
include/linux/spinlock.h:412:57: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  412 | static __always_inline void spin_unlock_irq(spinlock_t *lock)
      |                                             ~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/device.o] Error 1

### Suspecting patches
Suspecting commit,

  s390/cio: Update purge function to unregister the unused subchannels
  [ Upstream commit 9daa5a8795865f9a3c93d8d1066785b07ded6073 ]


Build regressions: 5.15.195-rc1: S390: cio/device.c:1330:23: error:
passing argument 1 of 'spin_lock_irq' from incompatible pointer type

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34CVOf1lD7sJImDyWLFpIY7OBMW/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.15.y/v5.15.194-277-g06cf22cc87e0/build/gcc-12-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34CVOf1lD7sJImDyWLFpIY7OBMW
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34CVOf1lD7sJImDyWLFpIY7OBMW/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34CVOf1lD7sJImDyWLFpIY7OBMW/config

### Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig

## Build
* kernel: 5.15.195-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 06cf22cc87e00b878c310d5441981b7750f04078
* git describe: v5.15.194-277-g06cf22cc87e0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.194-277-g06cf22cc87e0

## Test Regressions (compared to v5.15.193-152-g2e59a3f5f544)

* s390, build
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

## Metric Regressions (compared to v5.15.193-152-g2e59a3f5f544)

## Test Fixes (compared to v5.15.193-152-g2e59a3f5f544)

## Metric Fixes (compared to v5.15.193-152-g2e59a3f5f544)

## Test result summary
total: 54723, pass: 44299, fail: 2433, skip: 7666, xfail: 325

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 27 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 0 passed, 9 failed
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
* kselftest-livepatch
* kselftest-membarrier
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

