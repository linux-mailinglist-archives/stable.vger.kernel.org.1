Return-Path: <stable+bounces-104066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F539F0F12
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0633162DE4
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD881E0DD9;
	Fri, 13 Dec 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jie6iTmA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732D1AAC9
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100052; cv=none; b=RFj2ghsTm6O//uZ9paxPcEMkpnmKBjXT4x4ebRLtgBYECNx+Nv3+D0QMco+4xLStaKiJpUlu1v0HEWlLzHCS9NKBPAk1rhmmgDeZkghohdafoB0y7ls0ZkcnqNBuulLc5bl3s4emcnJVwhOkqPvpkslcZqspk4vsDvfn1k07OKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100052; c=relaxed/simple;
	bh=Mpm/LRwd7IySOim0PidDsZae2gN8BufbqTdj7uEiDdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcCXfhVN5k43AgNAQMVtC9RrrZJb6C1Y185n1w48PXhZqIH2CyEz0Li/5++ALLVh6UPvlY2gSAJmzDPDXXwsMBdYA+PiwjX5Lmloeyp04AFcV5UbWAxocaxlwXiftmIUKOVJ+c+klhiiJSOcV6eOOeYJpEq311C21141NCI5yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jie6iTmA; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c4b057596so415303241.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734100049; x=1734704849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jDrucwrqBIUmyUbK2gTGdYC/lYz1YCAOzgB9+QZb9JQ=;
        b=jie6iTmAWqf7KFExCS0HZJroPqnUS0mZ0fvTTJKlq81UnHikvtOzyQBsgosWohpiG1
         P58qIxVB3vZsPwkdpvhjkNfK9CybqZzczO6QWlAWBIYAYtdZPQGlYr4qFXp/B1uesNsD
         K70gT+KBKDZkkgO9nLMalHmx3cOge//403M9aae+FIfxNnRc1h1JBtw+Iso1fx/R/k8y
         INHv6E7iox4L3BJ3qSiHDIR0tl9NMichXcF10rCRvqcKUAFhs1gJft34nWnyK2eGT1xp
         aIluwkUooh8DpyCBe34LAaU5xVfsG7fkZbvfcOSdWSMOuwOmKT063O7LtJhVxPRErnAS
         oXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100049; x=1734704849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDrucwrqBIUmyUbK2gTGdYC/lYz1YCAOzgB9+QZb9JQ=;
        b=tAs9Lqz9dhPfWLyZQU68WYhS5S3xDP0HSfUDEHeqFlRX92nKkbSKGS4cLUOcd8BTiw
         BTXK72RZdR1vqyfjXK+/VFg6m5aW0yiZ8KRHYXzzsDOq5sum0AIUwFs5ojAOHUM0YdQJ
         bcqWNDzl7MV5FB3kPY1yVHCtO28AneA//Ay3i2RDobsGZ3xqVcYBsPUJn/u3cVl13NZo
         8WyxfmBSRYwbHGviaS7K3tey5OSUjIMndTYyMhDan1XiucQsFTJPrwMVyT+/pnXwbZWt
         phk3aBbq1v89M3jGijxhctkG7TxVEKrsl9UdNK6rGGmqsTbZF+bUcejT1RWQA59MMCc2
         p81w==
X-Gm-Message-State: AOJu0YxxUsNKKY/uwIuvIwr8M8yx8Qx5WgdypdMlEGAadTfdI3Z4T5nK
	r3VVjUhKweUK7uUN+NcCe8Jvt029qpRMwgHu3zT6TAdb23qltV2o7qrP03KffousUNK+yP/wCw+
	N+wCo/RlwSgwrYwmooR27/d2i/AdmynODAOreZg==
X-Gm-Gg: ASbGncsY4KoQK8r5fUvVhxMBZIfu8RJ1H1RQ4oMbSLIdhnNnlr9eAbEMfTnuRwzz6Z9
	ZUX/tFU9NT7QUNlKO1t4Hkn+ZBIr+SKJ/fexTcpk=
X-Google-Smtp-Source: AGHT+IF9Zpfo6h5y90m06XlevNuAJRPH+b8VWzhOQ2n7NHbhAbY4bKoFRFrDeNJvMZVeIv6vbwAbVLbWpFW8tTRxZf8=
X-Received: by 2002:a05:6122:a0e:b0:518:a261:adca with SMTP id
 71dfb90a1353d-518ca460b50mr2578122e0c.8.1734100049567; Fri, 13 Dec 2024
 06:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144311.432886635@linuxfoundation.org>
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 19:57:18 +0530
Message-ID: <CA+G9fYtbkj_VWQYjPsojO66rRgbcovrWSCDsgcp6PGqWEzGxgw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 22:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build warnings were noticed on Linux stable-rc linux-5.15.y
while building parisc.

* parisc, build
  - gcc-11-allnoconfig
  - gcc-11-defconfigcd
  - gcc-11-tinyconfig

Build log:
-----------
arch/parisc/include/asm/cache.h:28: note: this is the location of the
previous definition
   28 | #define ARCH_KMALLOC_MINALIGN   16      /* ldcw requires
16-byte alignment */
      |
In file included from include/linux/skbuff.h:31,
                 from include/net/net_namespace.h:42,
                 from init/main.c:104:
include/linux/dma-mapping.h:546:47: error: macro "cache_line_size"
passed 1 arguments, but takes just 0
  546 | static inline int dma_get_cache_alignment(void)
      |                                               ^

Links:
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7pt39eCahVwI49vKMQD6qe12I/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb/testrun/26287983/suite/build/test/gcc-11-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb/testrun/26287983/suite/build/test/gcc-11-defconfig/history/

 Steps to reproduce:
  - # tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.174-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 4b281055ccfba614e9358cac95fc81a1e79a5d7e
* git describe: v5.15.173-566-g4b281055ccfb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb

## Test Regressions (compared to v5.15.171-100-g056657e11366)

## Metric Regressions (compared to v5.15.171-100-g056657e11366)

## Test Fixes (compared to v5.15.171-100-g056657e11366)

## Metric Fixes (compared to v5.15.171-100-g056657e11366)

## Test result summary
total: 54603, pass: 38929, fail: 2776, skip: 12823, xfail: 75

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
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

