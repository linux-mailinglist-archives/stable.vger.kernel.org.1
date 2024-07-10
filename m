Return-Path: <stable+bounces-59026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F792D528
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A9F280FBD
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504681946AE;
	Wed, 10 Jul 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhQKcZb3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1D191494
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626027; cv=none; b=TcdzvCEtsJjmfJG08U1adCJ/dYicWbC2C4OdYyLKxwOlUlrUxF4YkujXXV34Sq+LfccxfQjkJh5b7MJL4h3kAXUqQE4B9M6E1eBq7Jod0jI5H5URjv39/W32mOSNEujwT7ANtpWOZqyYm1VrgNL5he83kl5F97cjJc/x00768rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626027; c=relaxed/simple;
	bh=omsYmQS4hG6YsBHUkFIaSOzlEc+6+TrwpnKMHsG7kjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubs4Z3tae0OSDniKut6Zg87cc2HqzUK9/jmGJQh9J3jxz/NkW131/nMlBfHBSDihMZCVynvLyL/GEdXd+7f3JlwCx/hycomrDSo+AHgVMkIMBvN1sEfN7fgTznnkdciaoTtSdPB+9ScUsPA73i7zUGX69kvMwyTg3n07AdUSkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhQKcZb3; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso2343383e0c.1
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720626024; x=1721230824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4D3P6HH5i1NmF0CLERJUVLqTlBKOZEShSy+djf8MuU=;
        b=vhQKcZb3whpHTLr0F9ct7j0sBE0ManzW5dPVXvS6OcT80JtpU9Kf3JQ3jCcdmtHQ8i
         8O2sPNkBcGXx11DzXES0T9xQphhNWhGUBpBRZX4XUqdSLuofHm8HvXSMr3QZ6vJByM2+
         f9jsgnEH6fcuxR2N578Rhl8PBU5aT+7VpJhIB+HajGgTPiAig/qSDy2ObJ1vgw1qC4iM
         a9zmNHr+K1CWfHSzYckGp1GfqtBdtWUmJwXVmecGeOBjCLrz0EqpWNKpNGDMyqa02mnP
         TlM9FHFYpCoPlaAzfhYMZlKXXMq436Tj0AI0JwmM5dRAyoCvUBUWT26dFTsgmCcuAYrR
         4//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626024; x=1721230824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4D3P6HH5i1NmF0CLERJUVLqTlBKOZEShSy+djf8MuU=;
        b=hCbi9AFp+3ZZ0CQRfYqMUAl54lbapErul6/UgnOXsqougeWTbIDt+50NWZlMNLbZl3
         n2C7QTA2tj3pKSf6twCi+XDta0q2BsDNqNrb9MHOsKHUe8bOkDhDufh/MM1MrHBzb4YV
         aePJx/bgiT2h92QPGbXRdNnhac9vYe4kIMbTSZpuWGgwudq5iZG3+bP9ybj5yYgyXC3p
         Dd8JwB76b3uuFZoRwuL4knMMgpNS71kZS/f8lY+mbfNg8IzmJoJVzLCPY9MEHVJX9gF9
         ul0Jd25WIasBclVlrpRQmGrLckfxWECmH2Rzo8gGDqJL4UgUcP7xXruFPIPTGgDzL8Rl
         aI0w==
X-Gm-Message-State: AOJu0YzGjqXUaOkNRHj7BV8abbjWbVQBLRa5DuZCXFQ5S7Z9EHxv2kwo
	9VpH00rAzuBW9Hd8PiysnwyoO9zjSJKCTzHxUXakAnz1XW2uUSFR9yoFBeWrEX4+IENtrcq6bHE
	/yjMw+lKNeNE7z/DFIQQ8GS9+SAiela72w7pnSg==
X-Google-Smtp-Source: AGHT+IFcz+poOzmDVoRNcSrqYhk1+y+wQ2Oo1g150vyTo2Ei2HItWpnr+yvlW9NI0uR3LPGWCGrwTMDdo7z5n/JlGjA=
X-Received: by 2002:a05:6122:a03:b0:4ed:682:7496 with SMTP id
 71dfb90a1353d-4f33f31b0a0mr7123315e0c.12.1720626023634; Wed, 10 Jul 2024
 08:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110651.353707001@linuxfoundation.org>
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Jul 2024 21:10:11 +0530
Message-ID: <CA+G9fYtK_CCvQ01LdANMViMpAGfY-fyh7vFwiOq7XzQw889jHQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jul 2024 at 16:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.98-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
We have two major regressions.

1)
As I have reported on 6.9.9-rc1 same kernel BUG and panic noticed [1]
while running kunit tests on all test environments [1] seen on 6.1.98-rc1.

BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq+0xb0/0x17c

 [1] https://lore.kernel.org/stable/CA+G9fYsqkB4=3DpVZyELyj3YqUc9jXFfgNULsP=
k9t8q-+P1w_G6A@mail.gmail.com/

2)
S390 build failed due to following build errors on 6.1 and 6.6.
Build error:
----
arch/s390/include/asm/processor.h:253:11: error: expected ';' at end
of declaration
  253 |         psw_t psw __uninitialized;
      |                  ^
      |                  ;
 [2] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j0YAKrnHmvjt4f=
KPfYoEmSKWlG/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.98-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b10d15fc384867cd42b1e770181e6cfb116cb970
* git describe: v6.1.97-103-gb10d15fc3848
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
7-103-gb10d15fc3848

## Test Regressions (compared to v6.1.96-129-g54f35067ea4e)

* qemu-arm64, boot
  - clang-nightly-defconfig-kunit
  - gcc-13-defconfig-kunit
  - gcc-13-lkftconfig-kunit
  - gcc-8-defconfig-kunit

* qemu-arm64, log-parser-test
  - check-kernel-kasan
  - check-kernel-kfence
  - check-kernel-oops
  - check-kernel-panic

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


## Metric Regressions (compared to v6.1.96-129-g54f35067ea4e)

## Test Fixes (compared to v6.1.96-129-g54f35067ea4e)

## Metric Fixes (compared to v6.1.96-129-g54f35067ea4e)

## Test result summary
total: 229438, pass: 197119, fail: 2855, skip: 29094, xfail: 370

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 0 passed, 12 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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

