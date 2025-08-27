Return-Path: <stable+bounces-176469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA2B37D39
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37865E7681
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29058322C80;
	Wed, 27 Aug 2025 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZNJoQPK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442C322770
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282316; cv=none; b=SIwwu6ggXxgC1tuJn/p2SJncuNTgriY9Ob/RKcOqM6fj698W3l65CnDESZZqNvj0UHJj2qlBmy/rYGopqsB4yowkfFx2J4sfhoc/P1JJ1d24nFeTPmDQL5g7/9rcIiobHqquttjhKe6WLhzubYNZkJc1iuFcU73oOSM1RzmnpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282316; c=relaxed/simple;
	bh=jOoLC5GpPdKtCOkN4m/zgPw33LJxJ5I73DN/I9tbbWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2gY4B8WxZXhVeMtUzAkazvEC1k6QmLCXgCyTV0SzA70SWUw8rwh4dx6keczVrwAX5LB0X6CgyjhRHVAz7MrXfCEg1Nnc56qFDSKR5aj7VV1rQ2l5HQtDaXo4VGQyJJwsHYFGmwNC86dJtExXj+pb8vS53JK5/uyOKCG+xUbDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZNJoQPK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2487104b9c6so14209725ad.0
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756282314; x=1756887114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B83u6UCsQHtIoE+ppMxK8f8WCkMt55tIYpEVdEAzh70=;
        b=RZNJoQPKBSBeaxi083h+oBSoP4TGkdPFR9NVbPAfDKxbZxNTYtwPn+Ua5RdezxyUVP
         UqtmmLHHvTiB0eoeF0HaRMjcKSKvo6oG2ZLYM8UA6moB3L6JcmQQ3zQmzD426IbJ8oDx
         hYIGfCeREly8NMODNV5nq+ggQO31cd5gWlPGq9cDyEI6S/rr/aq0h/yCoitSSwUET/xx
         a9Xtn4jRSqd4/MJfIdtqm9ajDv7v8uq+vC/inWcZgPN6931JFDWKM8bgB+lHKx8RldXa
         O/wvjCI3s+Ns8/w1wYt+w7e/E4DxSWBMlX0ijda9NURwpXpR23VCMqox4h29e1hzvGdB
         kxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282314; x=1756887114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B83u6UCsQHtIoE+ppMxK8f8WCkMt55tIYpEVdEAzh70=;
        b=fBcswz2d39FpYj2viqqgY0RCDyc+LqR0jvMjOMOeK/mwhnV26vNQi2aYoL0IMJajf8
         hEjK+kM14dQUCd5uS5xGizuNYxGtOfbA/5lEvoO06/3Dv2pU6q8Y1vNQAWyiznYUrSxK
         EmoFynKRch2UyVNMXd10hYgZLArCMi/iVkJANRudmt+9CoQlAK/UgHnwuHHcmOUWNFs6
         RW2qNmCppqnxdZ1dON/NedyNs/oXyCFkSuH9riHqog/+JyhTH5OiqLRd4GuZb6fgUu4n
         FjxQPr9M8+CQuPsgoQKeFYCFHbO1MhBxD49q6rhh5H/gPRMNcUl5GRFMWQCqi/TBfdGG
         UwAQ==
X-Gm-Message-State: AOJu0YyBYpMnCQopnyaQNy4DwhLHmClJn8CJdO82TicBxG2VPXdJG1Pe
	qQ8k7dwX0b4J2QtVyY3Kqjl3/y/Fa6vvcENNT7E/Je8G0vRScy/Yss9MQrYvVTzHt23m6yojS5j
	0mpdPpPbG8sGF26Nv5njwjkeKqYhXuEc/IY9qTbhOTQ==
X-Gm-Gg: ASbGncukTyqMn8UejnOJuiNX1dmyIgD8zkuvj2vwmc7dYCRVn1jm340fhrAR3Ptkl3a
	iYHbwsoBT8M4Ce3k6nx1r8EmMmuNoN88A8NT7fd3hT2e78oH7nIBJH9CF4a3MTLSKoMzonKRySK
	BaBxftnPkGJUWMQPGSXPdtEGS6QldlPiww77BcvSC22BwLGdc3l2iu/pzt74reRypAobOtzn01j
	Y2woB6AcVWmTP2HLLn6uF66i66q4CIazKgquKgM
X-Google-Smtp-Source: AGHT+IHDCckS2GvgDg3rDQSosFDUnr9S/UaRCXlraeNDTOGtJ1FdHBVbfzE1VsmrTB2K196QXG+a/QAuc80Hecze1BQ=
X-Received: by 2002:a17:902:db0c:b0:246:2703:87ae with SMTP id
 d9443c01a7336-2462ef08e1dmr213164435ad.30.1756282314497; Wed, 27 Aug 2025
 01:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 27 Aug 2025 13:41:42 +0530
X-Gm-Features: Ac12FXzNZVkmP27De3ESl3_w9jJo97pXSGB9GkNlHU7vxAIViOCe9v8deHERbMM
Message-ID: <CA+G9fYtjpQDKwsBPM50kZ22h-dcgy1oZiywEvDanHJd=04ks2w@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
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

On Tue, 26 Aug 2025 at 16:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.4-rc1.gz
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
* kernel: 6.16.4-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2894c4c9dabd275ab1a7338d9631bc10e5649c91
* git describe: v6.16.3-458-g2894c4c9dabd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.3-458-g2894c4c9dabd

## Test Regressions (compared to v6.16.2-10-g3fb8628191b4)

## Metric Regressions (compared to v6.16.2-10-g3fb8628191b4)

## Test Fixes (compared to v6.16.2-10-g3fb8628191b4)

## Metric Fixes (compared to v6.16.2-10-g3fb8628191b4)

## Test result summary
total: 344576, pass: 317202, fail: 7069, skip: 20305, xfail: 0

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

