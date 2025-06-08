Return-Path: <stable+bounces-151877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAEAD114C
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A787A5EF6
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735661F540F;
	Sun,  8 Jun 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWUDl/ZA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015818035
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749365599; cv=none; b=Kat/Sa74XyhnhpuNJqdq2BEfUVKy8ORMu9265qDjnPERVlJ11xHjW+9+LTW31844WXfYRGH/RsYpQEqcrHsfz/pGUeNi7AOKI6AtouwZCDYtSV58P3hKT8x3po6YeMdLl2g44q0dKVhMK33YSsh1D3ZcZq8NXa8RqdHyRAZaPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749365599; c=relaxed/simple;
	bh=fltpmOTVj6/s+N4xDOFhIyaKZHFzGfdIvwoqzO3sESQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmXfLh+g7MpjolAwZrNMHhPFr5KwF5QjtB3+L7c+hVkfJFieevEMLhRs2duea1h/9p9MGP19Pj3/Xa6ZM9cAuVgMf4kilGInPLLKRwM/61vgFwYVAN1noGlbh8OGwssmicF82BiR8QRFD9rf0BPQgVd+rj2XtuE8xD4tG7I9Dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWUDl/ZA; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so1283085137.1
        for <stable@vger.kernel.org>; Sat, 07 Jun 2025 23:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749365594; x=1749970394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNwcX+iuw1rpN6EnNjGPjmJquCREC1cuVweFhZ3D+PE=;
        b=mWUDl/ZAIOzawpToKtnyMcUAKddGQ+huvQ2zLn6RvC9fEuwwsjD0IwFKll5i/55viG
         BUWpU2GzuAWbZlegg8q8rv10X3iuqRYqIV5HW0Z8yuQc7IeQn+YrLzROge7XZAze6KAa
         bxOgaqoHQ2eXKXwsH+Np90wTBXa/aSjqkZMqahrgAsxzI5yBoed4jzD4R4O+hJk6zM0l
         JszsJevRvnCIXrW2NvXTMX3ryWzYmMcrNxiMLsRSc34zFlQwCCkXKDxxKiYFX8K/BPOy
         Jl0UuRm6UIXwh1IHV+fRO40asGwrr23+hzRbWvFm0DZ4RTd6ZHwH79OnQTRHkI5/n3yq
         IDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749365594; x=1749970394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNwcX+iuw1rpN6EnNjGPjmJquCREC1cuVweFhZ3D+PE=;
        b=gimTZxOW6eiFErWXKlDErGCka5H0dmEnM8AiSAbbN/BXwzlQDx1bD0Sa/gNrqqbFgJ
         CuBXj56Gcu69M/JL8ASwWk39Hey3kyBP5IfiQoiwG2xV64ChdeFqX5aM8mcyjbhz1ArH
         AwVUxLAsInGPrEQ+x1kIr/lvHJpWooFCTgRde1Bt/0Hg0JqqDlALiVSnrkElOooCQ0pj
         xnqQW68zB0uc3C2yhLOaYsOmkO6ZNX46OJzNqJ3YbhA3tlPndka0w+OzAg79X8WoHG2W
         KsCoc7GC4sh9YDzfvweT67vNurXodyr2HAFAk1E9aEuJkw81VvpR3e4Gbp6MCfnT//wS
         rt3g==
X-Gm-Message-State: AOJu0YzvcIJHjKDPcKq7QxDM4VYmJVo0yf4rtaU5RqRJssE3LnlhLDLN
	+ZK1MlXDauRcyMS15K//XHy0he8ajiGNAGkADLmFYK0v5BwVdocivGG5J16RyjanAfFnUClZphI
	qZN3tYy9h8v/IN+34PjVKsKnlGtLES+fdzNp5lMYD8w==
X-Gm-Gg: ASbGncuyJi4dJoELQoEa27vX49z9mjtZXICR5G2MvPmmKqZCa67uut1wRTxuwhMrEk8
	oXZI40gIueXtvrZp0M8d56uQqBA/v2W5y3hOFS9Oh+6WFPRpKprCd4txjxBZozLyRwEzfeJUMtI
	1hSdv4yIh32dHL+DoRQGPy0OJFvU4/gZOAMcZ7ruNu/yG7bnSPhvNY4jLkYWSRRYsNuYSToEgkd
	ky3fTzcrfGZTDs=
X-Google-Smtp-Source: AGHT+IFhy6gwvqP26SFAPg0/upYqeLloMafe7Q+koiMk1eAonxrLWGLo+Ayjz6xIWKvXVlmT3KOFHOuAYOJZQuH2YUw=
X-Received: by 2002:a05:6102:41a7:b0:4e6:ddd0:96ea with SMTP id
 ada2fe7eead31-4e7728badc8mr7428119137.10.1749365594500; Sat, 07 Jun 2025
 23:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607100719.711372213@linuxfoundation.org>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 8 Jun 2025 12:23:03 +0530
X-Gm-Features: AX0GCFuv5wsl2DecrYyVr5gO-RMH1Fhhv5VPgjaw7xqi6ZCYvhnLsAAHIWDZfgk
Message-ID: <CA+G9fYva8JzG5iWMuJ70Rj8sz4Kq7nX__D2JkrpHviwo+5-woA@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
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

On Sat, 7 Jun 2025 at 15:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 04e133874a24969592ae14d2839d4f0040da5ac1
* git describe: v6.15.1-35-g04e133874a24
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.1-35-g04e133874a24

## Test Regressions (compared to v6.15-50-g86677b94d603)

## Metric Regressions (compared to v6.15-50-g86677b94d603)

## Test Fixes (compared to v6.15-50-g86677b94d603)

## Metric Fixes (compared to v6.15-50-g86677b94d603)

## Test result summary
total: 255351, pass: 233351, fail: 4991, skip: 17009, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

