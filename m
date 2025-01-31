Return-Path: <stable+bounces-111829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF7A23F92
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA39E164387
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F71E2847;
	Fri, 31 Jan 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggMOjec8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A11DE88E
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337044; cv=none; b=XsdfXEiEikHw3ebW1bxmPqjYCIjsMH5ObTethXV6n+XQdDMbmsOIWfxXYWh8ilLwz64NEECy5PSFSkMWidkkmGcbf+1WeIXkY1rTxOwO8ixozGaaA6U5FlfTfApjvWPSUuUFtPWEU9sKS59IwUQbDE66xT5ONZ2/8ndLt0v1BGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337044; c=relaxed/simple;
	bh=TgBVuZbqmONVp2cBCwO+GazV6gt3oAzqH+Qi4bWhabc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu2KX/hccj+Xv4zsGIyonMNBfTFJfQxDX6/6Jew0uV5X+Fln3SSODCcOh45v2xb0z3PSbjghdkA/pf+D5v09QLgQHtdGGw+LIOvaNCpqYwK023jB14w3nDFqZOpvD1aa9vuTJpD2E4/of4gYQ4QoYKwuic9Yx+kti8RCCNiGEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggMOjec8; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so447516241.2
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738337041; x=1738941841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MmB80dNlZ/Z5Y29wc6E85ls0e6J9rncIwWF25L4zaU=;
        b=ggMOjec8QemDBXmsU1cxmhRgWsRkluDKuQIUjjeYCiPhJo/hAQG1/rNb+E7DwpBHBO
         EWZUfmA60uE0UkRPoz+k4nY9Mbeb3bFCL5Oh2saoIrapYN0pIQ0SeTjtqfdymGZ+yF6e
         Bj3XacQ9yCSKGXrBkwNAiJVNng87Pcu9xT8Vwa/Z3IiQH5iaZ0CTFBGZZBj6pShmzgCA
         CfCPvARLZow0mSvxTl05ZBfxLu3Gql/hcJUFrYaJwq5q9iwXf4u5ABtLEj0OhVCPKvEh
         VhHLcZ16Tw2pwbiVSR4QHxA1yTESSlSr8DFxhDWls8F6tqVT1VkuP6hqYnLDle3bp134
         br7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738337041; x=1738941841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MmB80dNlZ/Z5Y29wc6E85ls0e6J9rncIwWF25L4zaU=;
        b=PAdtzGhz/D7fFBSIBAdkkF3W887rW3QEtkCfSly5z8ZkSqxEIGNJj2WAQ9lwGhxMX+
         OXGRyqa4bwhP1iyX22WRXbVkZcqJrkJYRWJ8wjDxdwyB330Y+o2Fap8YWtGUrjnLpoMR
         9vtvrDmqjPIv7IqqOpdqmv8jww8dOx1tzYv/PZ3VTxVKvnVtox5mlmm/4RRQbT8OU0FA
         JgowzZ1UoW3mPk74RmZTCzAMv76yiK4JiqfhIzFlLElesMvPPBMSjCJN9djl8/9dSXyW
         3NSQ/ZYh2XHKxu5rGIMkxLjbrCo+bT9uHqmR+DmBlzO+sMAmHBRirfvp0kxxEeuspiOD
         4phw==
X-Gm-Message-State: AOJu0Yx7DdZR5na+75FYONg6Q1o2b0pO81bUeO1lwdI4WPqMBY1yPAsx
	+35zmvMWx+s2AiSV3/c983T+qW6G1iLeI8exm+aREVO/UyUlpEbLgcaKFeMu+XLJ7sFwkkrYDDw
	soaRFBiGkRHS+8a+7kZioU98rfqgxHL6Jn1FCTg==
X-Gm-Gg: ASbGncvj6meW227Bo4BP7ljSXy3dhmIjE0995ukec5qw5MzzGqZ6CHsF2jt7feGagqi
	hzNsHxdYnlb/9vBloqhCp+a4GtyONv5LNy7CNGOmSELo1GfwnxPKWv2oX8QGmAefTyhHxzazppE
	AyWqaZgf731NNhOQJYWxeVZxOatlZSfQ==
X-Google-Smtp-Source: AGHT+IF7h0wUp9yKsdp71mMvKTkAx8g2V0RVMq3BeCI0OtZi8JKdX/kz++4pwR/QvuGJZGjFqCuH08TtA+D2g9xEv+4=
X-Received: by 2002:a05:6122:8c2:b0:518:965c:34a with SMTP id
 71dfb90a1353d-51e9e3d2831mr10218805e0c.2.1738337041648; Fri, 31 Jan 2025
 07:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130140127.295114276@linuxfoundation.org>
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 20:53:50 +0530
X-Gm-Features: AWEUYZmodaflHy0FpLJdmZ8d6jjAWwVYtcU0AZZUKH1TGmHeKkGEWQYQ4fvFlbU
Message-ID: <CA+G9fYsi1EFDWOM-7Si5PV2HOi7ShcPtyM218jiWFkL64uZyJg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/24] 5.15.178-rc1 review
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

On Thu, 30 Jan 2025 at 19:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.178 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:01:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.178-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.178-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cd260dae49a375098c2120ff1618e6bdf874791d
* git describe: v5.15.177-25-gcd260dae49a3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.177-25-gcd260dae49a3

## Test Regressions (compared to v5.15.174-52-g11de5dde6ebe)

## Metric Regressions (compared to v5.15.174-52-g11de5dde6ebe)

## Test Fixes (compared to v5.15.174-52-g11de5dde6ebe)

## Metric Fixes (compared to v5.15.174-52-g11de5dde6ebe)

## Test result summary
total: 61427, pass: 41406, fail: 6650, skip: 12892, xfail: 479

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 24 passed, 1 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 28 total, 28 passed, 0 failed

## Test suites summary
* boot
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

