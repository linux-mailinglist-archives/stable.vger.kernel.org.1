Return-Path: <stable+bounces-128343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A82A7C305
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C67E17885E
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD580219A95;
	Fri,  4 Apr 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5Dutyeq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295A18FC92
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789572; cv=none; b=U99h0n0uOobI6YRKBsZzzoIBD5xr0l71PozQ/3OBRHTJXSa+DsKsKoPX81hcTeNpKukb3hBQDKirKjCUabs+lB7cUTV1pOe8G81L9UVDdAJXUOUDdOtHL/dJEdApA/2H9bXDbkRER7Zj/bu6Smn5TfJedmYOUiuryO2pfjH6vwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789572; c=relaxed/simple;
	bh=q8DoTobLpnYblqeIorLCLu56Rsyfri0rK2AVfCaxCQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMDkg8P2+TLagm/g3mj+v9ufgarOwRv3W+JIgGrTaGUUpz+UduBNayHfiIt9p8MZB0tggW98b2jqPbhxFsJ+ZQr00wFZ0qPrVpXXgBlYnUmUByVQ/b0oEBXruYOmL2xZuFeEscdtGeIx+zqPLle71uAuYdRWanpH9glOiauBf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5Dutyeq; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so983226241.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743789569; x=1744394369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHT122mHzqsL6lq6QlrYjoaMISpllKEJj8WOiydjFLc=;
        b=s5DutyeqVOZBqKTiRFP4ZR9nQB2xG/A+XW4U4RZv/8dm8jnxnR/W1gLy/1bYbZGCw2
         A/9wd7RdaQ5XO0gDxPQc7jCzzIq4RbWV6QdJg0Qe3asg+QJFO01Wg0mYrTaSgwxIU9Fh
         X7JHatd6UuXFUujVVGVL4uJnliss0QhiOo2lWYaDMChEDBmiAXfvBNYu3V4PajSHUQMW
         7hdlAtlt11iwRy8PeRpt7i27BQ8P20jEkuiUcLQg4xvW1Rex4Jd6XfUW7ywn7kQwKLS8
         hPEnCwtGfB066dpzOwcTRPEGFFXCRzTYMjckZvNnG6oAvUgCL5PIDkJY0W6J2rftrzxw
         1xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743789569; x=1744394369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHT122mHzqsL6lq6QlrYjoaMISpllKEJj8WOiydjFLc=;
        b=lIDN2xBDkQPutNBdvk81YKdphKvAVEzPJsQSAaqy4sRngm7NTFy13zyq1R5wo9WvBt
         axhYg9EoDHbUgV8ekOJGrAEULy5LrHp4j4+azf6N87yTCi8V80bDcFFp2Wrzz7URbtr4
         cwclzO7Y8DnqVsyYCe4swGWNF1PmEznexujr1SZ7rpjuXATphxG2BoTaEoxPCcw1eK03
         3m5n3BD6Ciofum26FQhUXcC91ljWJ6IhnLRIqls+JqIQrReGJ7q8Ie8wk/2DbPN2X6Ia
         0cOkxrNKtYZol+acqwGuj4cMTATCWddBWffuexhnZd3voktGUc935V8ppycNM5jrCkW8
         bjiw==
X-Gm-Message-State: AOJu0YyDxXWW0dYfHHLW9bMAf+e+uTGSkZR6QL506lhU/YGFOPCbv+2a
	/g4yGusLgHmLrsSXx4A7PI/Fj/aaQybAmwfQbxYpiNG2yH/nM/mbtvdwkSlHjgQeMmddbyF7r4M
	6KAM0rbt1ZrE714GOq53Ua+A7Jen2t3W/v5icCg==
X-Gm-Gg: ASbGncug2XZDF0dGORhmDq31Lyn3loRe/XvKH+Z8fzGZK///enqu0EYsNi6WiekRyct
	GbbK/nfg2GReMAD6dryaemU6JZCfNN1CGIiIE1x8e8HiTYHH8gqDQvRD/NnENkZyJoJqbPZ7FaZ
	r4K7snZtvJuj190SsIlSRFZ/bsBcnR5bm/sEeAgGT9aSVs2iqJLcEzY5A5roo=
X-Google-Smtp-Source: AGHT+IE9WhJGCC9Sf0OWLwG2goCnVjCBxH58MrkWIcuF26FFbG2ANrEsW1UY0l1r6UUcxRxBqHIsKVGD+fmPzNj3I5I=
X-Received: by 2002:a05:6102:3a14:b0:4c3:49b:8f78 with SMTP id
 ada2fe7eead31-4c8554b54b3mr3755908137.25.1743789569527; Fri, 04 Apr 2025
 10:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151622.415201055@linuxfoundation.org>
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Apr 2025 23:29:18 +0530
X-Gm-Features: ATxdqUEERi0sXqrIoWXVmVmXORGEUPIkxW2NkQkG6v3Qp4HIxVCRpucxb4_Rqk0
Message-ID: <CA+G9fYvKqmjaWVLdOWqk8ATqyTTgyE4d3L5UN78wA7L+-BRtVw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/26] 6.6.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 at 20:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.86 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.86-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The following build issues reported on mainline and next,
* arm, build
  - clang-nightly-nhk8815_defconfig

* powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig

clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
 - https://lore.kernel.org/all/CA+G9fYuQHeGicnEx1d=3DXBC0p1LCsndi5q0p86V7pC=
Z02d8Fv_w@mail.gmail.com/

## Build
* kernel: 6.6.86-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0d015475ca4d65fcd012dd52ee5c8c432cadb1e4
* git describe: v6.6.83-270-g0d015475ca4d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
3-270-g0d015475ca4d

## Test Regressions (compared to v6.6.83-243-g1a8546896fa3)

## Metric Regressions (compared to v6.6.83-243-g1a8546896fa3)

## Test Fixes (compared to v6.6.83-243-g1a8546896fa3)

## Metric Fixes (compared to v6.6.83-243-g1a8546896fa3)

## Test result summary
total: 119369, pass: 96334, fail: 3835, skip: 18728, xfail: 472

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 29 passed, 3 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

## Test suites summary
* boot
* commands
* kselft[
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
* kselftest[
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

