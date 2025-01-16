Return-Path: <stable+bounces-109235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377FEA137A9
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6A4164E24
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC21DACA7;
	Thu, 16 Jan 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgQEOCYH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030E142E7C
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022805; cv=none; b=kKM5h3GN288SHlDOsMFKg0Lats+AHiNdlVm+buZ9kKCEYsWtp4Zvj6+XTIENdvTPkWjh0RbDh/h9ZpOQhCtL5E7H4hBMUDt/flBZSpXnWM2eDQyPQrmo4SMOXYzX1C2dQrTSHxzTWR3K25H6dAqhKcNmZguISMQIBLmJ8C9VyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022805; c=relaxed/simple;
	bh=r/PdQZCIiaSOmdTKkSGIGRdKH8nSCZ430OLi3pjld0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deNo9nwHVjyQhcTUncsZRqiXnLSWvW9kvzR/UvWoUMpV/ut2IbJJ8fGXGSCfDceCIAGu/hOeVdxSZvIoVZNmIHYLnbVVP+CG1MlO3DNSio8RWfc6p/+7GUeap2Aj9sqBmakZw735cAAn/ISNUUE7eF5Lzk2RsFIY/TdX00wS86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pgQEOCYH; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so137033241.3
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 02:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737022802; x=1737627602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWTcprBJAJma4CuHivwxMfhBEdMs6vyqa3RMxgQxWEc=;
        b=pgQEOCYHYsE0kVhj5KHnArLQorl7k8U1mkIsDLcIFilaH3bsivFFWebwFOOMHXn8j5
         0nKVz15Nw32rWIlhtOZ4btOC9L0nGEY3ybKrFed2v9QFajOSC78g2FgdZogptK54roNt
         Pm93MAejmj0rS5ALEDZG3sPM1mExz+22m+MIB9dVb8KPy4Y+4UJicgLD1O356mHdXUdg
         UeDQkBb1y7PNvmm+syE/iXyLX89Ni8mjQLHi6ECPmPTFMEHUpQnmc85ynL+pX5lQ03mr
         MKQOSzvX7qZBJzBP5/rByC7LptxHSKiipSOmzxH/C3Ant+AhZi9ARsJgCrbBAP5iNxh5
         Vaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022802; x=1737627602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWTcprBJAJma4CuHivwxMfhBEdMs6vyqa3RMxgQxWEc=;
        b=nuPF1Cchfx4G6LAMvQ7yzm6QcRhSik7Z5fIhmKNEbY/pIbqfkpSpc2i7WQgZwPAFl4
         A3f4gii/8VEdXlONM+5pOvfGgCgsH0mJn4s1aUHcQzt5H+5yR5jpXGtJNksAj36zfeBO
         im5Bjf6VU3VF3yD9h9nBEwZHVeYmGqN2b1Fje6/VDMO22OVzLyoGWqMJ7yHMPdomvQmw
         y5vvnT0+/Ty7a1cr8WtSVMleHC9v1S33Bvg53GnIcfNXvqp/zO6t3XosQz0s0UTlEBvg
         10Jq5Yk9g/yB9Pu3um2thiqIE4f1aWHNegsn6yMEzvaxsR8Et/1UirEOXd/SkqMn0Ct/
         AX8A==
X-Gm-Message-State: AOJu0Yyw83e82QIhMO6i7rG1oMjYS2hduY8w+gLuZqcQha26KI62Hnxs
	JH5IiyBaPLRNK/k7KDtiAiYfyC/kh9WQ6eEPXmI0JEu09OeaZSm35gI+128L776ZuuYvl59uFfS
	mVLtDUyO88lAG7WovnCZGFsU3I+wwF46eCpsETB8KzMdin6Zq+hU=
X-Gm-Gg: ASbGnct5rtYr0NSg0iGoYg2ks+V4hYCWY/TOs+bppzVUokACeqVR8VUAVQHqp3cWV05
	t+DfsdHTv76WaCrMAgT5dxhRfhWFWuYrYlKAeS7k=
X-Google-Smtp-Source: AGHT+IErC7T/bZRIDZPFx3j4uL/0qHL4VIXPJviQj8dD5wqQFuUWCOuFA8M5C697TCUDkU1kNzeILJe38Krp0m8mcUw=
X-Received: by 2002:a05:6102:290f:b0:4b2:5d63:a0f3 with SMTP id
 ada2fe7eead31-4b3d0f2d89cmr27621975137.15.1737022802183; Thu, 16 Jan 2025
 02:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103606.357764746@linuxfoundation.org>
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 Jan 2025 15:49:51 +0530
X-Gm-Features: AbW1kvYgOTGuVDKU-uEsiPEWyUP5JKx5iTOKmdYD8p90NPG3Azs5Y5IdtGW2ALU
Message-ID: <CA+G9fYv-AgeUpP1yPDmy48T869Ms80jgUdjnwtBNoJmCKQvZDQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, clang-built-linux <llvm@lists.linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 16:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
---
The following build warnings noticed on x86
vmlinux.o: warning: objtool: __static_call_update_early+0x33: call to
serialize() leaves .noinstr.text section

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d056ad259f16555e7fe0d129820d01fa6b6c468c
* git describe: v6.12.9-190-gd056ad259f16
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.9-190-gd056ad259f16

## Test Regressions (compared to v6.12-4-g11741096a22c)

## Metric Regressions (compared to v6.12-4-g11741096a22c)
* x86_64, build
  - clang-19-x86_64_defconfig-warnings
    -- https://storage.tuxsuite.com/public/linaro/lkft/builds/2rf9vPfX8BaAN=
y9mq6s2tWqaVJ1/

## Test Fixes (compared to v6.12-4-g11741096a22c)

## Metric Fixes (compared to v6.12-4-g11741096a22c)

## Test result summary
total: 97783, pass: 78194, fail: 4177, skip: 15342, xfail: 70

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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

