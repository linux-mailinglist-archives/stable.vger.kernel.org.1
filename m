Return-Path: <stable+bounces-200060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE59CA4DB7
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86DD30BAFE3
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CEB36A028;
	Thu,  4 Dec 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="as+brHWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2B36998B
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871259; cv=none; b=F/9BA5SabdJ+6pWbYMUekSlsIHwBAt8TN37sKfzsXNDqDqTi3rOgCOt9sBsweQGT6i6VyPV8bEU1IQ2Vjont2NmVafJvYNCwH2qMsbNIqhfKD1uMRW1DP3XIBe8vuCVzDCrEfj2zGLw8VMsm3pVwoE26RGJpspwVLtDnOBQlp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871259; c=relaxed/simple;
	bh=AkT/MHdA+WbO70MEHMSPURhco0mqbbQwlaoRfxu0rrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNWhgRPEOHxeMg5P9VZXMHhOmy8TXtukPuTZQQPQ11Cj4ZJlrlAfSXarS9/Gyy5gu+fKNsTPdbVPanuYbkxOdo5fD3vTiCJlDC8udgfwmxVdY+th0c1pnZa3NptmTzBSU0oxQbhYJeHJnn/Jwwp/0vwPVQdxMtFpfE7cLlx8Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=as+brHWI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso1102011a12.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764871255; x=1765476055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4kaFJonuzYZVLvAuUlFCNJ5LpvqeGU0bsDP9xWjHKE=;
        b=as+brHWIV/cKBKsV6hOKucXhLkF0lb7q6gQ/t/uxsDwFcKl6M+paS/9IomAlDAAXpp
         wVhc280iz/IoMWWWmsRnG9YRTSkm6viRQ0AS0JgB+sMFgBuVt8amTvr7c0oJcH2soEkN
         biWFclC4aNEZteaAVA7rrXBBPV46XJ2c8tR1XgFHABzxkAY1Z+VA6pmi1hXuYUBHRD+N
         HHYQo9cLIvOpER8G9wgXnCgV6G3JrT3qrmHqKW497EwbJNh+19fnv4o7AC/5mnHO3PJ6
         0v3W9BiXnx5CoBsFVPBs3NoRGcLLoD1TdH7OdRnVr5LOboyx6NBE5LeETXfVpx/PbnsA
         puIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871255; x=1765476055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4kaFJonuzYZVLvAuUlFCNJ5LpvqeGU0bsDP9xWjHKE=;
        b=pjslt4WZ+8LXWoHtgl3UcjG5voJfvP0WGMluocBj/CTKYh7UKjeJE77KEK4DlfVhXf
         yVKIDJJgFV9zKavmNE/+qpDd0sGokHw5O0psQnqEEf6kGDQV5WjPjrLMTfGX0irXSORJ
         E3XISDtKyH4G9PtlO8Cs4elPDcXspPKJ8ya4Ih0CKY+pY4n0RFlmUOhnjrvL48EAaT8z
         YqtmNyqgiDuGjCG0m9aEl7TzGZTIP8ch+ThXVpkdJxRzzknrRwHKkErx690zDUW91LeA
         MzUVNdAnnaPnYAkFmG/J90qr72WcsSAVAwFdJffXefmzogLbRsiBUptOjbfYsQ0Jq6ok
         D8XA==
X-Gm-Message-State: AOJu0Yy4rWFf39a+8mBUR0WNPvCCPBmoir94Lh4kEzZNPRhJ/zwEHvMM
	FXG37SdvNX1x+Jtb5YriljWPb/NC7Wq8P3uTzQo6VpJAnopqJRWKJLAGzvP2lKefMA9gr8WUV3k
	q0b8W55beCXEie069xXoxUeZqgTxospxawKMG5wU+VQ==
X-Gm-Gg: ASbGncsp0kY+HXZrIkz8KkBCaDamIbZwwJbJAVUKTRIujJBjsZFUaUmObsEDzR2+jyf
	xvm0hsTZsGg13xbkbrhsAKvfi480x2MrnrZMcO73rqBKSc9rLym+CgATBeT4MjsYWB8ek4llPwx
	OR1J2cAa1ej+KbYhaXafF/F2wj2PPmeKBpvjDT+WSr6mODYDgK+k1702Te2w/55pLe5AKPba43A
	F0mVfpylgCmhcTUNtvS+UJf307g+gQ5pknbhDZlahYCCcKeOclW3l/yLhAt5wzLYAtx/9bhGGHX
	i8Zy/6+1VlhlC9WmwE/1BtwTthQ1
X-Google-Smtp-Source: AGHT+IHMjgpsVlwYiWNNyRSKMR4UA4jvGJd9/H70NNgoJ44IQ9WNlkyfQB4M4mlZDtJnSh7vv9A2Ar6WYLGBRFfXrO0=
X-Received: by 2002:a05:7300:de42:b0:2a7:127e:bff4 with SMTP id
 5a478bee46e88-2ab92e2e0c9mr4061491eec.24.1764871253194; Thu, 04 Dec 2025
 10:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152343.285859633@linuxfoundation.org>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Dec 2025 23:30:39 +0530
X-Gm-Features: AWmQ_bne0EMC-y7fzl-jo7GD22l99epNjDmm1QaJlFZHFxuu7nyBRpdwv8Bdttk
Message-ID: <CA+G9fYu0LrqEAdnq7binH4vJpRdUtogTnKS8fHyw2XJ7=H0PPg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 at 22:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.61-rc1.gz
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
* kernel: 6.12.61-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8402b87f21e8163831f70759368ad9a87192eb40
* git describe: v6.12.60-133-g8402b87f21e8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.60-133-g8402b87f21e8

## Test Regressions (compared to v6.12.59-114-g375669e5645f)

## Metric Regressions (compared to v6.12.59-114-g375669e5645f)

## Test Fixes (compared to v6.12.59-114-g375669e5645f)

## Metric Fixes (compared to v6.12.59-114-g375669e5645f)

## Test result summary
total: 121011, pass: 102647, fail: 3763, skip: 14233, xfail: 368

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
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

