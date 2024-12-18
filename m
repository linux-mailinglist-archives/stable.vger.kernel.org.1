Return-Path: <stable+bounces-105176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0139F6A5A
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6491702A9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623B1F427C;
	Wed, 18 Dec 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGxqr/Gt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95E1ACEA9
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536804; cv=none; b=FrVByLisVauvYMLr5TM6sc9XmDOw/cVCCxNNZmrvfYCuXWrmLPMsqRAPs2kZI88bvUlX4Kuw7qvASgY9oDHhjmivZMByJdljKBZseumnM5LGyNz121fAIi07UUeCPgJ1eGdRl2FIHePLSVOiu6DLCo4cKGdQw6oy7C5yBTph/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536804; c=relaxed/simple;
	bh=fl10JA3keK+Mu3YbcjUMlWLHDFGW7MaZLwDVZB+DUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEHzeEMJdHb9JU04sw1COv8tFE/CUqnkubA0hLJSumTaHsJYHxtxQ2ffbq8YNONXx3Jz91Dthp/5A6fFB7kkxQ2tStUxmXdC+7e7QiFpdZvb8WG3UfW6oWVdCEZWdhKdkh55hCHFXSL1Z0jTZCjLRFemyDYDTVBi1x19+H46PR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wGxqr/Gt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dcf62a3768so17265936d6.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734536800; x=1735141600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QaQov78Br/93bdXvfIihcrtJ5nJl689OakmMk4I7gu4=;
        b=wGxqr/Gt/48XpZUltxHKzJ9bujCRu/d+NHY9YXgnBl8Z/5VY0hw1SV09PI54ew+kkG
         gjpnbv3Qtdv6Oa73zJS9+CXiu5NfDCkvqRrNfV/MqyJma2jvqcfs+ZEA24gxoCsCGG5E
         8oSV97WUp67JluCVjVzaO4x2yabld33tq/wxOKWH3cto9GuwcAguqHSgftXYMxu4otur
         td6EnIsnepd0TuYSL7PuP0FnZLu/s92TsuXvI1zmU2Vew5Gt8UuLv+ZSVa3Dydc6KnlD
         vWI8Kyvr+OlJOQGERJB3lhGVoxQUYMtDkVDWlLGaAdwCf7dsla5hl3F2sgOK0oG8qUxv
         zvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734536800; x=1735141600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaQov78Br/93bdXvfIihcrtJ5nJl689OakmMk4I7gu4=;
        b=gIdGmsDwdOL+kjeYeemDwEQeMtdNLaJbHnew4nAAQEI0ipCjhsv684R/m5j/7xlIzu
         cR5TVP/ULDL+jKH0HDJr2xLLRv4Pkr/KQf8JOKYeBrNQkhWk62KfqKoi246PB5s4zkNj
         yTp+sjbTwmc5rcP4v18zTQhP6YU1ls97e0oqzRlw/0A2ACfAhS2uRl4Jlh+EH6uCNGkt
         GSJE+bl0U536WWTvbMofoLBUBYT3Tq+5oCl721JyZZo6RMjf6Isa82QC0LfFpsMs74TG
         jnlP7rDRZQk549yu+8Bej8oGBvq4cDW1dHjv4t5RtPTLhSUmabuHkrLzvetoUQ84Z3CA
         qLzA==
X-Gm-Message-State: AOJu0YwROTUy+mgIJeIAAOv/RECGBrM7k0D/5D9ibpbwt1xCxPI4gt+J
	/wns57b1L4Dgm+aEi7uLV7QaVxGI0vMfboH6+9xer8WTXOS6XeKHtfDfoEu6own5DScBHfaqoLX
	/1w281ivALWc4Xn9aFQOhnuj4PpaIqiSVZuVxNjquwKqtwg52Dlo=
X-Gm-Gg: ASbGncudL0QaWdGQkMqi0s/zeCUCm2VOHSyvxKzhaQ2+e0n9lcIh4VAUlo7IErFq+94
	pd1P+Q5uKdMGrt2IfBcgmg0DME9v6sqquxzVZ+w4=
X-Google-Smtp-Source: AGHT+IE1Pp2xLJTcdKTmRqNCBhElQ10uwnZna/kAAuuyP8gm2xp1+puetNKVCE6BAcbDmo2izyj7vPbmIY4ZIFogv0I=
X-Received: by 2002:a05:6214:2b0d:b0:6d8:a1fe:72a4 with SMTP id
 6a1803df08f44-6dd0925ca16mr52727056d6.46.1734536800344; Wed, 18 Dec 2024
 07:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170526.232803729@linuxfoundation.org>
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 21:16:27 +0530
Message-ID: <CA+G9fYuqP-XiWQAvj=prtSGVoSipjCzYeaEET=gZSpvjb0LiMg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/76] 6.1.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 22:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.121 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.121-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

js wrote:
Yes, the fix is at (via one hop):
- https://lore.kernel.org/all/aec47f97-c59b-403a-bf2a-d8551e2ec6f9@suse.com/

 ## Build
* kernel: 6.1.121-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 1855e5062cabff8aaf8ff42a0df6998fb40be9ee
* git describe: v6.1.120-77-g1855e5062cab
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.120-77-g1855e5062cab

## Test Regressions (compared to v6.1.119-773-gcb4fbe91b7b2)

* i386, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-lkftconfig
  - clang-19-lkftconfig-no-kselftest-frag
  - clang-19-tinyconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig
  - gcc-13-lkftconfig-debug
  - gcc-13-lkftconfig-kselftest
  - gcc-13-lkftconfig-kunit
  - gcc-13-lkftconfig-libgpiod
  - gcc-13-lkftconfig-no-kselftest-frag
  - gcc-13-lkftconfig-perf
  - gcc-13-lkftconfig-rcutorture
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-i386_defconfig
  - gcc-8-tinyconfig

## Metric Regressions (compared to v6.1.119-773-gcb4fbe91b7b2)

## Test Fixes (compared to v6.1.119-773-gcb4fbe91b7b2)

## Metric Fixes (compared to v6.1.119-773-gcb4fbe91b7b2)

## Test result summary
total: 105316, pass: 82169, fail: 4298, skip: 18795, xfail: 54

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 134 total, 134 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 0 passed, 27 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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

