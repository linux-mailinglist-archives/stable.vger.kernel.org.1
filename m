Return-Path: <stable+bounces-179054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA538B4A4CC
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C12541604
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575224677D;
	Tue,  9 Sep 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBHt2jeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2C27453
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405684; cv=none; b=mlqAqS8QOTfTnuOidey3gS4/9NnxLm9ZEc81zl9yqwDdJLDmUXarKKXAIfH0PobwaxTcmvjzizw8nWOPnFLx0mUEMmDCCfQ66bZduSik+J5U6casdSFgo6V/iH4n5ckW/6/X/TcP61ZL16Iw2H3USFJtxn+fIZ3T0BlUZRIgEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405684; c=relaxed/simple;
	bh=Y/R4UDZ+ZSvt+VaXgW1xyYWYXJ3iCy6juBUJfKRwCSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0m3D+5a+t14g3lXN1B1Mzl/rUmEPrgIN4HySMsg9++CMjndOp3UqT51omo/7oN+CEtX1Enhyuap/m2qK48N4tiOS2nExQqM+mztp24yHBqXBKQKGgHzDmfM9PKdqWam87iLu0FbM5y6gfS6jQi8QDL2DOOe2mU2flUIqxQmVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBHt2jeB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b52403c47b7so868375a12.0
        for <stable@vger.kernel.org>; Tue, 09 Sep 2025 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757405681; x=1758010481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIpgvsteZsFCH9XFFKILSkJ+RpxiXOarjA0CWs/e0Ss=;
        b=gBHt2jeBuOa7Z1cpO99PkCx/jc8kWQNtJTXHekg/JSooq8yERTzA0Owq3sZZr0sfdl
         dCcQdmAUUpYFuEiF0oGhQJqstiEDk7CMlH1N+2atvjQSVvbWvUIx87rNSzMUdXAgvd3i
         9Ov4n/h0ckwCOXTLO8v8/zIounM+3q6BIuttyKmsDS+Wd4LBUndgxO536KVYDcqzt4fk
         AFA/lFr/OZEMgl7wU23pAsI3pFZGyEb2wrXH6PaqHHsQOh/NENXFtKVmwj/lLVUbir0Q
         eBG/Z5K1hB9z1K0ZpkLworbne1dgvsD9ZDqV+X1nuOw7pdt8+7BvcFJc0hIdA8KwPKSk
         LmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405681; x=1758010481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIpgvsteZsFCH9XFFKILSkJ+RpxiXOarjA0CWs/e0Ss=;
        b=FQ6bYyoEynbCncczdFDZMVSqQRHTmF+3H+Xxu+3qY3W2IwyDxgYaSDCHT17u+7m6+7
         QpLIY0sEtwWXqw5zNGnD6Qq1VcP8RVziipjZG3+fWITyqHjDyIuVsP6/jphA1KYBdy4Y
         vLprY7XNUSa0ddMnEuOBOa1VaO8h+tm2uyrqnLuBNCPAhuTWLEo22UN0fNz/DjY+IXi3
         bkvvWV22il1frSbXbrUJ9E9B2OuNB3LbY57SSFtrP+tSF6ajDh9/j2rN2cYHbm2uwaWP
         yVoi9sdMC1/S3317Nnv/K3R05Sg6x+y1NrVx+GnoW94Npk1ib1iZ8npLrtOboaTxVjge
         8Sew==
X-Gm-Message-State: AOJu0YylZUcmC81GaYR8ly3fs9p7aZsSPpcWDfLlYEWpkKBSSf4seG+K
	Sxdn5hsFz1b192gj2J8j7n6zyN1qu9Q1Vwit3iJbA8IrHODeeA1Pi+xUaTCci6spDfS0hjYLXVf
	RzXMgZw0z+vB8YT/yfzMXazvJFXs+OQ4vP70PpqpG/g==
X-Gm-Gg: ASbGncufJufiPvO8OxDwDtd+9hXMX1gdxtUcduA4heoartYjnnbzRotYr75PeiRMS3+
	3HCGiHA0NxHRaelp2YUkTjEJDymV/ff5xVH3Pk8vpn5jd/bwHV781dW/NvbqSc5XtBtCmdSBK2E
	YvFWNf+8b/FfzjBksEsEQ+paOyl/YDOGbMpiCy6Qsd4LnphO+RgDSATrRxpvko76qjdfwgjGIx5
	xppVWSQfJxUnFEdVvy9CUn2ayoI1nlL+e3IOz0Vk3S1Kas7arGPu3Ryyx/6JrIE4exAi3w=
X-Google-Smtp-Source: AGHT+IELD9aMuOIBvTjO5dI/RE7Ggtv6zlFzVxwqiI8iba1V70sNtE28/4+HPw/Dy2au9sKayL5Q3BSRVpKjTZNUggY=
X-Received: by 2002:a17:90a:ec85:b0:327:4bd2:7bbe with SMTP id
 98e67ed59e1d1-32d45037837mr13813712a91.4.1757405681401; Tue, 09 Sep 2025
 01:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 13:44:29 +0530
X-Gm-Features: AS18NWBX6sG9ivlDQZwj3uF48WgLHfvr7cs9tUI07CgvAn1-iGKNVR1tV29XcAQ
Message-ID: <CA+G9fYtHR3SbJthRkd+HfOMQQJ75L6fKNhU8uMmk5chRmN1G6g@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 02:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 665877a17a1b1f125d4ad586fb5f032accb7d853
* git describe: v6.16.4-327-g665877a17a1b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.4-327-g665877a17a1b

## Test Regressions (compared to v6.16.4-143-g6a02da415966)

## Metric Regressions (compared to v6.16.4-143-g6a02da415966)

## Test Fixes (compared to v6.16.4-143-g6a02da415966)

## Metric Fixes (compared to v6.16.4-143-g6a02da415966)

## Test result summary
total: 348600, pass: 321208, fail: 6791, skip: 20601, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
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

