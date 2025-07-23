Return-Path: <stable+bounces-164433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3BB0F352
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A71A960B27
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023433DF;
	Wed, 23 Jul 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iW7dzB9e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2A2E7634
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276039; cv=none; b=TqAbk3KSWvspHpnFDpmH90Ip9dYq5gvUcAu1f8GU09r5vp3Uhv4zZGUrTmIiJW1ChVPlkC2WXmHYRrRVq3fYR/zuSKC4y0BHRISyqzBSigiUd8zVShPC5tECB6PkxDmvgR6lkBjC9hiZW/WhWoFHp1qAIDY8d8cxCBytTxdpeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276039; c=relaxed/simple;
	bh=K5g5ghBqJeQ8gfTrmh/oFkJT1Bbutgsqi9q9KbN3jrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9pJ5EVlh6uQaYDaCsE/81Y5nGRKawt7uEJlI1KA/m5K7p56zIol6AImcE0RRPqRvhgjMi4C+nOVL8JTL13GmigM0YM4mwPww45RlPUgN3VxNnWAW7WybliUVbGvw5LOw2sqkQai0L5mr9vUEz+1n1RveKzRGlTyP4GIUnJJW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iW7dzB9e; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso6111806a91.1
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753276037; x=1753880837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILj9WSAGRmrcwz1/CE7SMUUUscFZ+MMHiLlins5DWvU=;
        b=iW7dzB9eZwvSxABapQJMhQEjvqHM8W2sL1A6g/GxONea3sBy9XHlv1gdrZS5Jj3mJs
         9RhXDALq0Egu6gnUTXh1SiaTSLd+3LiS2BUOtoUwn7RwkVtG2mCdlVGfV8YSVJJsZhbo
         lJmylEZBxmzXoGWXg5J8naETV4p1QCcSl8ugGd075Gi6BBnJH212r7vVHUqiNkmvjMZf
         jYoqC633xZBTAxHdRYS39tR3blN68kIHkYejdOxXks2Cs5RXdME28kP18uhaFTKPQOcR
         ChUWml5fb1x7BcNL4Huy/hKVDmmf00DRRbn2CaT7jHC10Qi2Bpy6uTh2EvbKsru/RUGe
         MRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276037; x=1753880837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILj9WSAGRmrcwz1/CE7SMUUUscFZ+MMHiLlins5DWvU=;
        b=ArVCuzFPfaITec/612D3qTKszOMrwMoneugqURxPQoy8ogc0n3ARYcOFE2cbWSDssS
         YcCbP9SqUXndLT5WdZp4ZYwOWiwHnjpGXm3oGRoMIov3mCijhLVzqgmTlc2BldvRC4+H
         gSyb8OUZRq1M8ruy7rfr+ZfC8tWzzVMLrvckUoiS3abLUGiyzj5rcPzT6cdypwmKpKnL
         GKkd6lCRoXrJoxz0vL78iDJBYM6LB3nYR5pik02gK4bjX4jIvD3zmmx5Z9HzMzlIeUVj
         pPA0sGvnhRlgzbsbgpq7QqrKnG+XaGCRcVi2MjyNUTizwGBZXU9WifSdkjIH+zT+BbON
         n3rA==
X-Gm-Message-State: AOJu0YyTr9b0+zraioiySigkC9fqUnYtGyxddQcYlWYFbAJh2Ig6uYNS
	V8NbdjscrT0MlVzDBQ9dq2RZburY0WdnKm6EkgbIUyNqqdnVAA+/PtwoxsbtJFncKJyBWEOfbJ5
	VtdO6VXXeMLSNlSe/343YHj0svlprDePapx/PQnyQqQ==
X-Gm-Gg: ASbGncuxTkNBF/+G3yNDNvYwONDzW7NKDG6hYOZx5hz/E3SCgjofVOLbn/zNxV5E07a
	TQH9cniPSPpbPMoI6bLdeoazn6AYQqHyXkFkiCSOrybRNUOCj/pRbAlVBA6PbdPwnnYcaC3iRLU
	6vVba3jI7L7E6nqe0kgcldNlaFEzPMQiJ80eZKYitaxFd0YU+1dYjQVsi+8Bn6U422+Wl9MLrFb
	h50FNcqZLErgT0YqfgD4ifPn8PwDn/ZZTibduDR
X-Google-Smtp-Source: AGHT+IFFU4rGd/eAENVQgxvllM7kgatqYKSu45A5IXoyTjOesjXiiHd/HlBjUVHHJk/SHkBrHRo8js/6zPqOdNttFNA=
X-Received: by 2002:a17:90b:57c8:b0:31c:260e:55e9 with SMTP id
 98e67ed59e1d1-31e507dacffmr5191069a91.24.1753276037411; Wed, 23 Jul 2025
 06:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134328.384139905@linuxfoundation.org>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Jul 2025 18:37:05 +0530
X-Gm-Features: Ac12FXy2f0C4oio3mLtIgEQuU1pBJlEEwNWkdnl-ndkktKLp4yIP8BKyubkNb5E
Message-ID: <CA+G9fYsXUvYV3+JQf4St-NjvmMoOOpPCZZ2HqDxcVAoZ5kCd=w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
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

On Tue, 22 Jul 2025 at 19:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.147-rc1.gz
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
* kernel: 6.1.147-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3a0519451f2bb2cdc91626b4ae69a622467bc60e
* git describe: v6.1.146-80-g3a0519451f2b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
46-80-g3a0519451f2b

## Test Regressions (compared to v6.1.144-92-g33f8361400e7)

## Metric Regressions (compared to v6.1.144-92-g33f8361400e7)

## Test Fixes (compared to v6.1.144-92-g33f8361400e7)

## Metric Fixes (compared to v6.1.144-92-g33f8361400e7)

## Test result summary
total: 223705, pass: 203512, fail: 4887, skip: 15084, xfail: 222

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

