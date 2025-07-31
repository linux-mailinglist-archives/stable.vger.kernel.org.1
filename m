Return-Path: <stable+bounces-165642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD7B16F97
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6480188846B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFE21CC71;
	Thu, 31 Jul 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5a+lBw+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C27220F25
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957825; cv=none; b=mJ5t/XvrXh2u8bSuQy+lLyxOIFXxZO1RzUV41pSlc7jraerKaZIo32hk9SX0lsD1ni+M8AM+O92sNxGFb5FUxZFlJLA5j181Xy1TdEN8qLlVhlVYDFElA39TRiyQK+4yWFe8a+UQNPvif7pzZ2LlRr3oKEXOVMZxNs69R70zPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957825; c=relaxed/simple;
	bh=cKgxv8GKYiGoJyvHvFtNmsnGCey+KIp1OZrYAvCNNWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJUajIFXkm/9dd+QVVT1cc22PfVdz5e+D9D9B7xRPRalSrE3jmte6HMkWAZJMeR+jNsjmdHLjHoU+/OXw1M3d1kB6UA6YieXz9iVBek//RaEbVD/QiPDXjILjaQedIMwu6l0YO3/JJRfdlZvHRTCd3AuVEn2KxTXwGwCnL3LFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5a+lBw+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so720392a91.2
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753957823; x=1754562623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Oi2qTuWyaRtBb7dTg+6FPQ+pI3wu1nBaCzxMIA45Do=;
        b=c5a+lBw+HZyCmpL9W/vBhuicESMnVChARIriMXeA0dnEl0J0r+BEWU1z5zscoOcpLR
         oT0MfjLvhjfUmITmFMYnSDGVWUiWxnyyQCFSBt724iDx+F4LSFhuKis98AvyFvZ6Y036
         RdwdaP62NrKtmMEiUFEYX2hWkYdsOo7qjPwghJx60rgoWqzG0H3sarTc8h0n1j2AchMl
         AxO9AeumwnYvNg4IFF6CB5lHqzLso1Ys5ivP5kAZdns1EwabV8Xzoi6AhsVrJE+JR/dX
         flWoCHEB9vGtjjEl2ap1B+gfFBVe48KQ2KtJpPbPntv3gX1HVZJ0h55hlK/wwypSSbaX
         1vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957823; x=1754562623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Oi2qTuWyaRtBb7dTg+6FPQ+pI3wu1nBaCzxMIA45Do=;
        b=Sco8TMhcXvEgLLO8FOW0zx48xhvJeoO7E9+UVL1lektBA2TWrVSXnlxIr+C3ZrZq9d
         ghtTKQ9NBtkuqXaRsEvUuLDYE2kb4Dtucsbw1jms7kBEA53XO+4lQ5IgjcdM1mOzuAgM
         PouZd7GpJiPv2beVGURvZB++AMJ5yUJ0lYUm60CD5q7FAe+2wjcFyoYtfc/zWF0RCvTb
         2P85O0v3rdguBkcxypHw2Vi4zXZrjshKG2vvh0+7opDdQibwrCq4YEls/rIYE6WJZpaG
         azSOL0VH1mitpFuBp2t/JRupXA1rNrX53OX/FR7q71W4jkl8HmkI21gKVcNkctyxRcQS
         LO/Q==
X-Gm-Message-State: AOJu0YxCNNd2Nt5H1QglOIXi3nrw67+sHSOOO4jyO4h77iebiDh8Vs/S
	wSiNrgB5OvgGtWHepexBL8KHPjai7dHS35WsLprW9bsUpiVED8sVl/5w1ekfTzZ3Gl1TGvJphhc
	NidBjGFJo3LQJCpjTZt7wcha7Tz+hgcI6IaJ2Dvrzfw==
X-Gm-Gg: ASbGncuNyimBKqQjckEt6xBLRzxjvaD/o8A22vX2TwQrX4683bsOXTGLzDwJdirP6/L
	4RlNJ0diuON+ZnLW42h5nUm92HGjkw5NEW/C9y0DRXHn8A0sGV/PYr0DpnyctczjVYOkNX7y2cq
	HENsH/+YJakl6+hYci/pLyE88gJzXnyjS2lrAIKBdAEj1VOy3r1UygQ5CAe1/BBhTVfVA+OeeDG
	NgA1rPjWDIgirkDFBnrjQtazJEFxWLZ6Ctvp9I=
X-Google-Smtp-Source: AGHT+IFMo8eS9540Ycpyz6BLwie54ysqPXYxyB99tqOVm2Ha7a5bBRqVrHC8MFt21s2epCH8JoGbsK1iTUkRJU1SI1I=
X-Received: by 2002:a17:90b:388d:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31f5ddb5096mr9836519a91.13.1753957822885; Thu, 31 Jul 2025
 03:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093233.592541778@linuxfoundation.org>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 16:00:11 +0530
X-Gm-Features: Ac12FXwer49nduMpxwQFJNtfBz9Kcza_Gc1ctDiNbFgtwe0wrfzSSf3cJpFYum0
Message-ID: <CA+G9fYsFR+u0BLAtwvj0kyA6MRKEpihf_SpDMYy=JkpCLexhng@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
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

On Wed, 30 Jul 2025 at 15:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.41-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.41-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 487cdbecb4dc1c90451661e3de44c8283c2743c2
* git describe: v6.12.40-118-g487cdbecb4dc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.40-118-g487cdbecb4dc

## Test Regressions (compared to v6.12.39-159-g596aae841edf)

## Metric Regressions (compared to v6.12.39-159-g596aae841edf)

## Test Fixes (compared to v6.12.39-159-g596aae841edf)

## Metric Fixes (compared to v6.12.39-159-g596aae841edf)

## Test result summary
total: 326156, pass: 304428, fail: 6239, skip: 14887, xfail: 602

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-mm
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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

