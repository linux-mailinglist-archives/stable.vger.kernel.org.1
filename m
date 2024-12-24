Return-Path: <stable+bounces-106087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 973999FC1C9
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 20:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD287A1AA0
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2131D88AD;
	Tue, 24 Dec 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpSAwKji"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C8442C
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735069795; cv=none; b=UVEKlFYAvHfKvZ52qpbMDeWWaPh5MkwRMrgMOVAd8Q6iUjvnvPRj24m5K67Jhl86ZAwYcsPHiFgp5jBPRxmoHvjEBUwIwnZ1YQ4KJHqWNb+eqiFpBG/8UHsR5vufMD5e+89uiYm7MrJSlGTnvWvJKyUBU0Dx4JN/DyMtKQQDM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735069795; c=relaxed/simple;
	bh=EooV5dRH1VomQVwWesRF5UOBj081lQuMZ5xzC2esV3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHQQxls9aZXasa+1O19IcNa9AGyicbBXstsefpHLArxGRWyWNZK2vARRYs1FqiV1zwsB5qZWnnnPKs5SIkBTbZ34399aC4lLTtvBB1yp9cL0oEDigibeuBQoo37R7XybSQ9l6VOwSdqylASxLrybYSnkIHGbljCkJ7ntqr41vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpSAwKji; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso2819531e0c.2
        for <stable@vger.kernel.org>; Tue, 24 Dec 2024 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735069791; x=1735674591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAhTCxY2E8GbbXq8t2noXElW7YamRqwknMMlRfdq3q4=;
        b=PpSAwKji+2HLlxIwxl2S5NeMI5FFzy+mnLc36B7oaQ87UUxjFlMgLPweNo026nMvJ4
         Gl2BI1zHG7vyxFcZfzro72ayOSzcpy084lVzMgqQNDahIMsRMTfQwoxuZ2bS1D5Bu1qk
         sIudV+9a8H4TXLxFCufbLDtvGq3zuFJDvDk2IJri1qAPzWMzPpf6F2AZwq2m3EGn40dL
         3LQtIgO5fpPkPtKAUujCKSOI5N/hx2TTlcGXXtKpML5nBdfI1nhayYcnQg+VAT1GzoNJ
         SmW9Sa0Ydcjem7rPGkmr5VZ2+cfdhJTRZR5te9PtJHyiOnHeSJx8bGVaMwpYFogCzIER
         TI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735069791; x=1735674591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAhTCxY2E8GbbXq8t2noXElW7YamRqwknMMlRfdq3q4=;
        b=rAw4QCXYyrmalRB+Lc003gNuUdWYNnAzoW87ZPI/nImYFxDK5sJw1atBkMpQiZQj/U
         pwHM1dbLImoNWQj+8pfU6LM98EOPg5AXpeC4Slz15cjwPu3p/PuT+CrnhjmIljeFsHp3
         APx7rlABC1WvwsUc0dJotLDCseIr+mfCOXvQY3hcY17VAFe20yKF9eSye//yNTukTxAl
         7zH9a2OEL4O6+5gkG7v0sKSNo0Zl2LToCkgUHgfAToJuArxHW02RBf7Y3U2eNS195vGm
         Yd51y3ZHvq+MKPwcDdQ6zcxk+FUTt3kd2Np8GPo7946J4ECo9s11Nrv2d3Df9UHhpLfW
         DHkA==
X-Gm-Message-State: AOJu0YyHYg8zF3FKHs08hq/QbtTt3x+J24s8oHVQO0kVdSptkZnV1Rwv
	eMPiuinfxWu1DYRoFdi8Zebk0B0DSSWHoLvj2lDCFlvyuQY5mvHiC1KeUoOXHTpLCJE3expiSVw
	HyChHJFORB4gHLysyy2c5s33U7CdcqPfXG86PyA==
X-Gm-Gg: ASbGnctHQtXaVZ99nw3ehydiuRBGz82FYBbdfUmCNdF5gAFZvxl//z5T8Ao8NplIS4g
	nAPmfaJaU2uhBVYc4XoXboWB+iwFgwXZ/r15Ckt123948KVAKltIY1nU7NQKTIu8PL/9+DrE=
X-Google-Smtp-Source: AGHT+IFXZOp/aPyL2HKTjIsaxhiaUUMaP9Lfk3DUJnOyaEnrBQoiZcjTjC61Pc9/2k80o6cYY6ruMMKiWz7F8XVSb0Y=
X-Received: by 2002:a05:6122:1d0d:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-51b75c6b632mr14745628e0c.5.1735069791462; Tue, 24 Dec 2024
 11:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223155353.641267612@linuxfoundation.org>
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Dec 2024 01:19:40 +0530
Message-ID: <CA+G9fYsEhViu4e24r+atZA7ideY+n=k=gtGGXkQXJtaVOckp7w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/83] 6.1.122-rc1 review
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

On Mon, 23 Dec 2024 at 21:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.122 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.122-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.122-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7823105d258c4486e4f3d63c075edb7c91052bf2
* git describe: v6.1.121-84-g7823105d258c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
21-84-g7823105d258c

## Test Regressions (compared to v6.1.120-77-g1855e5062cab)

## Metric Regressions (compared to v6.1.120-77-g1855e5062cab)

## Test Fixes (compared to v6.1.120-77-g1855e5062cab)

## Metric Fixes (compared to v6.1.120-77-g1855e5062cab)

## Test result summary
total: 116739, pass: 91216, fail: 5085, skip: 20365, xfail: 73

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 17 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 36 total, 36 passed, 0 failed

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
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

