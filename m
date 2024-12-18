Return-Path: <stable+bounces-105200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C39F6CB8
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488661889453
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B061FA8F8;
	Wed, 18 Dec 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0wYT/Cv"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A291FA8DC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544537; cv=none; b=Z8bz4gjHFvu7H3VJUYVZGal95ICRViWGpzTRamOGWqoiru4S60YEhZczZNoeATIgeOcbWNzncRZ80jDiCWnkIMMAHvqF19g4Y04l/JFDW5QkbC+kAjFQLaxsAUj105MDqdB1O6ovjMdYb90BJBDIgx+dRhpN99PoIGBoKZqkamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544537; c=relaxed/simple;
	bh=1fkc7nikI9BL9Vpy6dN8PYFjwbzoeCT/uR15Wpdt4gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQNkxhQ/v7uhJAoqQWmzAXFs0uAg+4kPFL6gWR9d1dNB4q/QImA0IaCZ1Mu5bDeG8+CJKGlGtefvrPtke6z7t3PEJTRb5JI9MoMQkAA/9lkr1RbwCDoVFGFOwLVwR9TidDPHqxxQIq+YvtRG58o7AyunQN76xN5zKpdwa5t/LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0wYT/Cv; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-518799f2828so500179e0c.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734544534; x=1735149334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxLa6N0s8/8I31GT13Dejz5oUFgro38O/kMhW3m5z2k=;
        b=C0wYT/CvJ1HD9Qa8Cz7wmuLtjh3IovDvKUD+QF994Snxl4sB1itZ+D9len1plwHSMQ
         H2rj5t2yCzfTLm5sZUS9XCGOO73zWACgJk7TJRYNUo7KSrq9GvwB/0ngL4VLfMzwzqcj
         yteqEo3iRPXCJjMqAUGFpJkblG6az5T4PBjDOajVVdkoxvBN4jzrmHdNsj7zVGZfPLEC
         nh9TmoMDI7rE5/y3M9dOK8ZavPyZ3syBYUx9yg2ZqqsjChLbzOpO85mCFB1xe5M7Wlwn
         SrUGm70gaKcWVSiq2YYJk2epvdGloPqF1JdYRLJaNjHRU0ffg9V2ylM0WrVEkogcXUDq
         A5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544534; x=1735149334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxLa6N0s8/8I31GT13Dejz5oUFgro38O/kMhW3m5z2k=;
        b=d5rYJlTqdwvqCwLX31JYolyfLXYvzpCIs5Iq187Q94+ERF0BnG3zybqPOdyXrpj4MP
         qddt7NvwbekH0jr1aQ504zi5SAdqAaO9UZwCdSwlRwSfmJUfPsmtkTdV6wBf/am1N9wa
         YCoLFFhkogDP6SM2BI84QUwco/VDC25jycfCHBlhh/D4jVQxc7ChyErSJUFx8O3OFkxK
         rL0cOUTUTO770e1Yzv7+UUB13ug0z76FAp6MblsLRC50or2tylOGCnFUqjcKI64mQGUU
         AJWQ1PCAEvYcj750RcBiwlwBNnrHVi4mEBxoqXEagK44L0w4v1uL1v0uqBxEDPfVgI5O
         TbiA==
X-Gm-Message-State: AOJu0YwrvB9T6BXnU3Wh/BnZl5U+bOAnmSpbngOFcw3QR0eWkKi+Br7t
	b8ZG/Gpth/q6k2XBsrPzYEEpBY48mJo8ZOtk9QRIne+Y+/ugFTEdRNpMfpWPOP0o4FjP07xFxjN
	7+stm7hbDxqUNZJs/IOHFukgh3ccbvsLtcPDZFw==
X-Gm-Gg: ASbGncsNPfpvyUNtOgeAWflMqBFjqgZLlz1Xfk9AdDMybAoffAn7TAdWOnCGTt6wBGS
	L9kz1S8nodaOEw2xFdknI8/6lQpxBfABMmk+Bovo=
X-Google-Smtp-Source: AGHT+IFqRvqnqWJ1jd/PevedQX2jc68TXErACDNjxzhdRH7HlNsSyrNrB+808c8lEaAcezLrIXaWYtwNNJ+tsuNu+Pg=
X-Received: by 2002:a05:6122:3c89:b0:50d:39aa:7881 with SMTP id
 71dfb90a1353d-51b649a7444mr390997e0c.0.1734544534354; Wed, 18 Dec 2024
 09:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170520.459491270@linuxfoundation.org>
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 23:25:23 +0530
Message-ID: <CA+G9fYvWDOkOn2n6n1fasib6g-nEH3Ev88eZfM3mwjr+=f8-XA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/43] 5.10.232-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 22:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.232 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.232-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
ld.lld: error: undefined symbol: static_call_initialized
>>> referenced by static_call.c
>>> kernel/static_call.o:(__static_call_update_early) in archive arch/x86/built-in.a

The recent commit on this file is,
  x86/static-call: provide a way to do very early static-call updates
  commit 0ef8047b737d7480a5d4c46d956e97c190f13050 upstream.

js wrote:
Yes, the fix is at (via one hop):
- https://lore.kernel.org/all/aec47f97-c59b-403a-bf2a-d8551e2ec6f9@suse.com/

## Build
* kernel: 5.10.232-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 238644b47ee3440015a824c17a271f482d551c13
* git describe: v5.10.231-44-g238644b47ee3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.231-44-g238644b47ee3

## Test Regressions (compared to v5.10.230-460-g2146a7485c27)
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

## Metric Regressions (compared to v5.10.230-460-g2146a7485c27)

## Test Fixes (compared to v5.10.230-460-g2146a7485c27)

## Metric Fixes (compared to v5.10.230-460-g2146a7485c27)

## Test result summary
total: 34331, pass: 23179, fail: 2919, skip: 8221, xfail: 12

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 0 passed, 22 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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

