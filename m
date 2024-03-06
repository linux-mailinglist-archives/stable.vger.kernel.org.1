Return-Path: <stable+bounces-26962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33655873826
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567341C226A8
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6213174D;
	Wed,  6 Mar 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSyyu3pO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D113249F
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733131; cv=none; b=mEBVnE8i17LmuAdbI9/eQjsveKhpPdpxa/9+kTXlyVSUhTE2XuR1PZ7q0NoaQPNVa429zYoHuSKAjxkWtRQJVl6px/ANTwZx+yY1JkZP4tnr/3zLVg3MOtBwQGZwvMWRydCRXIk7e/XZpJ/rZoOvpVDB0VXXxhaUITaNNgzTl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733131; c=relaxed/simple;
	bh=DxD2l0TYNyX0nIo8X0aUdafi5RwApWasX/Fm+UM7f2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PatSqjCAzC736g7k2AKq2hRMVhZ6jmumvvALGfV076TKL6gzv43oSF9zOOtGHJL6eksWkAMCgMmgf/YN8DeAD7nUf2r8XP8cT63/bqCRpyIh1yktGB4WuZrimHKxoo63xLohoXUt/t2UHohCft0eDLrP8XqpuqzQ5ULCRuhlbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSyyu3pO; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so2879651241.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709733127; x=1710337927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIv5f1kNqPYJFCk7U0R+MAUVSCh7feTHZ/Nse4z4iY4=;
        b=CSyyu3pOCI6EKXhSz2E0+jNIWWWD/UDIBmXgdnUjNA9+UF6qS//DStBp6kEh1rWon8
         OUUh5nz1BQjSe9G9qHKwcQuO0e1T7Ro09js7P80Se4vhFFmqKRCEmnbfNMOmSs0WzrxY
         hOpkB/9p4TOEAJQ0XNXDFkQ39k4Io5EPZHg8koGXEY+4BoQovXoYQjfBGkuZNG9meN88
         fVz4TWkikG20eDAKtxOABAWj8lqdRM/y3LMsll7CLPw+fUdwFDtGZmYUSo5LN12WXg/o
         MiBYKEmoVssOa+HROuoFKhv5gxoQZBLlC17KdSREWpo58/IQhID2I3RZ4oPm40bJMh/P
         MBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733127; x=1710337927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIv5f1kNqPYJFCk7U0R+MAUVSCh7feTHZ/Nse4z4iY4=;
        b=m9MahuNKgr8Ez64Q1MYN/Nvzje4lQmHRFYtjXHgX2zJvi+hDFDXOvQf2clvcD1ON40
         tq9uy3zFHVtjXc9DbG0NgQN00iVbo02cVT4YTYRuiqQ1tCRu8q6rzKS8f/4a56nljJwC
         7Xvd1PIn/QHdzVlu6P/26/FR4KdHsM7wMckSDoG86Fxn4VrY49+VtvGiCxUY4hFma54x
         omMJUvPLJfVaBd01cPA55Cc7V7Aq+snnP+UNKd4Pt2QA2R06R3dF58z+GkLSwRUzVI90
         grHt8qoY7lKi/jO21mFQaDZWjzgkoNz/BGfb3VQ6gbRRbNnBQXpuo5F7+GcQWvdzDiBr
         S7QA==
X-Gm-Message-State: AOJu0YyZNSMYUK8D4plg7ekpZJ64FYC58y/uZ/CkeP38pLRTLwn45uKs
	eGfwq0nbv+zbFTx4WQoVWBMN3qgOZxD0fP9a4bHBkzpBEKMNW2xW4t4fagkta1y9CW4/cYiIRVQ
	siml1Cacc53EhuvC6AzsWgbJCMDF6yjaEfggh/g==
X-Google-Smtp-Source: AGHT+IHhkU275prC88a734xDgCRlafAyCScqUTRNlX3nQgmvhtdfhst4HZGyhvX8Gi1Gdr3G7TwSw2pUSMs4KDdr2fU=
X-Received: by 2002:a67:f408:0:b0:471:b9ab:7bad with SMTP id
 p8-20020a67f408000000b00471b9ab7badmr4148859vsn.29.1709733127093; Wed, 06 Mar
 2024 05:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305113119.020328586@linuxfoundation.org>
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 19:21:56 +0530
Message-ID: <CA+G9fYtdu7zVnS0=Z12x_YLUbLaefpFL2F4CnmD0AHyP1p_j4A@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 17:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:31:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.212-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.212-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 713b6af903ad5057407164571c78c1e307098b8e
* git describe: v5.10.210-165-g713b6af903ad
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.210-165-g713b6af903ad

## Test Regressions (compared to v5.10.210)

## Metric Regressions (compared to v5.10.210)

## Test Fixes (compared to v5.10.210)

## Metric Fixes (compared to v5.10.210)

## Test result summary
total: 92769, pass: 72680, fail: 3078, skip: 16948, xfail: 63

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 107 total, 107 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 30 total, 30 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

