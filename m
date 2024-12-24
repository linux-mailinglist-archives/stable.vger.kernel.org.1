Return-Path: <stable+bounces-106086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9119FC1BE
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 20:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97E57A2122
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB3212D68;
	Tue, 24 Dec 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/3xd+C8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3602212B3C
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735069151; cv=none; b=ZniT+pE/kRB+qgbKblyBIos/uceE4FpU8He/Df9FdaZrMj1QFWRs07c+3GGfbyxeBQlmK2JG4WoEctMgWCFZ+8aT8HWZ2lDd8TrXy83xLe3Gpu66nEzZlPV09SNmaxbDGk5UJNPeTXahfX8o9bt/PgQRrSvcuVua5PsMM5owjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735069151; c=relaxed/simple;
	bh=P79BEIQODNe99azMRwSsdpYNiZFg5hahoQ4kkJN7k64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmmAztpmMIGMVzBGcFcUBMywgxt5L1Q1wwVzJ1ke8z9As31xqh0X+JuYbVx5gC3Y0E7YTnkdw9dhBGpsmQ+6Lr4pml7FkRaoOGqjRq5sMVAwx11VBZuyFqopwWquf0EE58y7xTR9VX854oKdoiJZU/oIhD4lwDSQtdTCjw9+Yig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/3xd+C8; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso1419671137.3
        for <stable@vger.kernel.org>; Tue, 24 Dec 2024 11:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735069148; x=1735673948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDU2RqYWAfV3xYeDvbcqmpikJj4/SnpfG2/BshVfimY=;
        b=L/3xd+C8wXWrTIupmZ2v0zPe9aGNCffDafM5oumOqvy31ANZPPoC7xJtE6oWI40tsP
         ZUgy7s94xQz9K32hktM1zno61o0uEez/39XATA6DkgFAqbE3Ec4EBrTiGneYoKrb/hzk
         wZGzWykMDvRS7yg6CO6Nr7o2IEL8BZuJUrtvy9KPKMDKw0sNt7Ff9HeomftETCGFud2a
         jR3ETvyHTkSQRo4bnB9evh944uY6+3YC7W6nbDqHPpZeVqCJ7qKTZCsoPA6uXwIto6to
         dOVWLoiMv79M6bxELeHr+3Je7MMSK2wZZIvNFm0iG8AHQF9e2NauLLyvGoJIi21fQAk5
         9ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735069148; x=1735673948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDU2RqYWAfV3xYeDvbcqmpikJj4/SnpfG2/BshVfimY=;
        b=utxMPR4ZEV5LWW9Mxq7nzDUdQWt+TEy1629YMVWn81i09OsTsto6SRb6euSyXQgLyW
         /JgSp3ylWybM2mlr2Drhx0bwS7SkPrQGHCI4hBLB1OaFrxcPmoFRZflMLbUvq//MQiyZ
         XMNXF4m8R1Tjs7L1U7txoTq/wjJCjcn8gIx4r/5MSGCeV+qtywUz+1E9MCkuOlMNZpTZ
         pPvyxzwx95zxSrioK+9eGkgjn0Uy5Y5XauMgdoSMG4Ksc/1UWg4xO2zL8ejODp5/5Te0
         4AMEWjPw6zFeDDv1IB2OoVcvmNVpzGftOqZeb+6HTTcfbtTyINTdv0xcJoxbA0aoI16i
         bMTg==
X-Gm-Message-State: AOJu0YxxgF3z9To2RPF72O060F8T21eyhjoHIr6zNSrh74DlRFaAVPvl
	iKpU4Q+Y34TyXoZJAHE0sOUuQ6PcVDMzdNdTbESAfZpsDOwURLhSDuUmnJwfLT3n6Y3a1+1U/Mw
	rKYQZ05s09NG9IghLQr+eabjcVj5qHjXqCCR2Tg==
X-Gm-Gg: ASbGncsOkeILx37KzgsdMdtyrvUq/TInQfWsv7FuGI3TKS8xIctKi76ObByh8C2Uvjw
	PnlLBJPPsHSNvcSo2UGa1HJTpFL1dEr0bXtf13uK29Gvgc7aH2ZfpuVhQYI/pATaONELJ9Yk=
X-Google-Smtp-Source: AGHT+IF2/qZ3gwl/ss0K6oIyCHGrgrb+OBSpU2UQ1JUhJXEq1qUVo4pv7jPdHz/VRKkbyGLYUwrPDeeeCNdDughZTmI=
X-Received: by 2002:a05:6102:b12:b0:4b2:48cc:5c5a with SMTP id
 ada2fe7eead31-4b2cc399b84mr15765409137.15.1735069147423; Tue, 24 Dec 2024
 11:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223155359.534468176@linuxfoundation.org>
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Dec 2024 01:08:56 +0530
Message-ID: <CA+G9fYut6mGnMQWzbyhgCEgb8CTjWv7STOVkcBhsi7nk2DhJ2g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/116] 6.6.68-rc1 review
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

On Mon, 23 Dec 2024 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.68 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.68-rc1.gz
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

## Build
* kernel: 6.6.68-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6a86252ba24f89c8deb21b44cb5ffc867d9ab96f
* git describe: v6.6.67-117-g6a86252ba24f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
7-117-g6a86252ba24f

## Test Regressions (compared to v6.6.66-110-g584b6d5f2ac7)

## Metric Regressions (compared to v6.6.66-110-g584b6d5f2ac7)

## Test Fixes (compared to v6.6.66-110-g584b6d5f2ac7)

## Metric Fixes (compared to v6.6.66-110-g584b6d5f2ac7)

## Test result summary
total: 158707, pass: 130517, fail: 3971, skip: 24142, xfail: 77

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 31 total, 28 passed, 3 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 36 total, 35 passed, 1 failed

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
* ltp-sm[
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

