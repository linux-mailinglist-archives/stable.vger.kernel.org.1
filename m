Return-Path: <stable+bounces-134746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF52A9474F
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABEA3B4CEA
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B431E5B60;
	Sun, 20 Apr 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHXQPKUU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC1155A30
	for <stable@vger.kernel.org>; Sun, 20 Apr 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139745; cv=none; b=lpKSuQu2np5RlpOVyVc2WnE8NKOsMEOSIYx7Mgktx8P4gFbiGobO7zYWaJUt+CC/jNRIjtsicVrcYjNH1TOBkH7uNIP+wDN4JH0SuFEBq+zRMbg9+/UmoJ2xutqS34GkEmuLP5qNd4tWi4FUdLZlrj/UDggpcM46sHXaFtw63JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139745; c=relaxed/simple;
	bh=Vm1SneeIv1DShncqWrSbn2uhWCgJ8xrqSoeq/3C8wiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUi8+/zuzoCj9qDnusbL2x77QmY6MRea7IYpMB3NS7dXQEg4KZI0+wYYd3lQ4hbHDVUjLfFrTiPR8WJVEYhjq41H8etpq5szdMx3TRlm5Ei4nsr03jWpaDLRKElMOwl4+9W7mSaZXE1aANQs7PbDPyTAsBwKpmvV0crEdeA4Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZHXQPKUU; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-525da75d902so1126654e0c.3
        for <stable@vger.kernel.org>; Sun, 20 Apr 2025 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745139742; x=1745744542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQC5AcabxKeiEVKbwfnNZC064is3VX268OdmNT2hLSs=;
        b=ZHXQPKUU+iZYXsgduGBZBf7gB6pqE2SM/piYtVg3aLhoxSULSS8Uo+IQtS6ivhjfRA
         pZmIwiDgfSYKNp41/UIszbQv2yCsq4gZypgxmvoxYzY5R8GBE3RApx/8Lo9ZbXgqB6mI
         iPuglqKMS3uJvKx4Rz73zK0EZOlzeWqIirHul6MabnkXtNZFnnywqEx9UOZ7/NoL93B0
         a8bAXy1HvdCBBxsuchsoje5rs6UtOrpLqBXqql0CEpBhv/3uTxSRn7r0XtMO0pi5dazp
         ecD/8Jzh5G09p5OTEczMPaU5Uulo5O/VoP53rt7NFQYrbFaSF8Fb0qr9+BWD66MalJ8Z
         Y3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745139742; x=1745744542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQC5AcabxKeiEVKbwfnNZC064is3VX268OdmNT2hLSs=;
        b=FLR5oyDmaic7toac9Qm4wErF6vBsDunL7zm6a6zRnmqX88tPLXyTNhIP+LRPcKof8h
         9MBT0qV440QFso0RG6dUhWf1cUfF9F+2kp/gD38hTeRQdzIf3LoAni8I65OO813gtE+Y
         SssE2p/RZVHVEmuo+SaunxzXlUuGmhWqwLpjNJ3LuFckYynGDOTT8MxlAUVS3lW3f9Wk
         YlhU5lGZQYS5qT70ww1vs50ZPvLXw81KqQWAkbLvGAl2Z39eQE9MmhzdlEQKoESqxtVo
         pjEQN64Er6yG8hhj8rzbv3jD0XAnlk5gzmUvAbLEblcCR0Q1ClTcKoFtDvrQzHV3W6+u
         nXng==
X-Gm-Message-State: AOJu0Yw2IYqooWrFkLHjlM/STx4Cmm7Kt/CPG2AJpzyq+8Q/CdMT3fec
	s9uUqsh39trLWR/qURQ9iZJdbzPZQCL/vmyCr5DFAqAIGXtzEeOTdQUketBD94iwqSiJDt+zvEK
	6xbVZ/n5hiLVGRJhpGzBr11Rm4HrCKHuvw2tWB9SjE4dCPIKYW/I=
X-Gm-Gg: ASbGncsrF4FX2KRpp+SXsXf5vCm4mfaWvsefD04ubJy2Nn+2BIXrS3dRSRMFmzXQNAh
	PQ4w3oTdo+TV5vrQfMr4EdEsujtqpLXoSnY8POlEv8TOLYNVVvtWbyxKrOjcGJqviFfI1T7HdVX
	McQXTILjSQZw4sJnF+F8jV1jhfkM8TIHZvFI75AaZTBVtPKC5rdhCTXlE=
X-Google-Smtp-Source: AGHT+IHntgRziFxoHZPrkez9WKkiU2A6UmellXKi/BMY23c6kkHgThZDWZ17Fbw56FQH+1A82QuWxaV+i3kn3UGw9A0=
X-Received: by 2002:a05:6122:1ace:b0:528:4f4b:f0c0 with SMTP id
 71dfb90a1353d-5292540fdabmr5837027e0c.5.1745139741697; Sun, 20 Apr 2025
 02:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110423.925580973@linuxfoundation.org>
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Apr 2025 14:32:10 +0530
X-Gm-Features: ATxdqUHH6FtR7IqNk-DfKZGccRuiyir-02-_NXyIQhhu3k0XqwhRZWMjkZaV1eE
Message-ID: <CA+G9fYtOeB3A_Ebz9rSZ_Z=DaoJG6DAUa6XK9v_k7vqvRqEzMA@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 16:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 dragonboard 410c boot failed with lkftconfig
on the stable rc 6.14.3-rc1 and  6.14.3-rc2.

The bisection is in progress and keep you posted.

Boot regression: arm64 dragonboard 410c WARNING regulator core.c regulator_put

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Lore link:
 - https://lore.kernel.org/stable/CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com/

## Build
* kernel: 6.14.3-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: fc253f3d7070db50a3eaa92f79aacf194f82a6fe
* git describe: v6.14.2-448-gfc253f3d7070
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-448-gfc253f3d7070

## Test Regressions (compared to v6.14.1-727-g2cc38486a844)
* dragonboard-410c, boot
  - clang-20-lkftconfig

## Metric Regressions (compared to v6.14.1-727-g2cc38486a844)

## Test Fixes (compared to v6.14.1-727-g2cc38486a844)

## Metric Fixes (compared to v6.14.1-727-g2cc38486a844)

## Test result summary
total: 131061, pass: 109303, fail: 3209, skip: 18120, xfail: 429

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

