Return-Path: <stable+bounces-111830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8AA23F9F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D901885387
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAEC1E3DD3;
	Fri, 31 Jan 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGlNyWcW"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1D1E0E18
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337194; cv=none; b=irDF8/ugyhTA21kYPprGqmu0UpRjSPxs9XjKwF2C4puCe0yXuGVHU9xeal302Tz0qA0vZZVGlDJ4anoPun6djKylMnABFpkSGmJuVavS8at2ICaskJtMUYzvTVJj+ySYMbUv8UHsUi9nOHRrRz2p6tHzBUjChY+6qZffvrYvkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337194; c=relaxed/simple;
	bh=3/0Z77qweBYXBX/5/H9DIfK+cyaNahHPlntmh0VmQWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orxifjAkZ28Wk457PRniQpaKADGwy+gO/fet8O32lPnAGL5imYa0A+Wqb/4+7a6U9zvQmh0u3pbnbFheDzlc+bQd4BJ8k4hes2PIcaX9CskIzqXwFC30J/Ahws4Tiw8uCxQ2BAbL4M7V2eHE+Hj3WCcZDmo8DP6fuUbOWLAzFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGlNyWcW; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5189105c5f5so1309794e0c.0
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 07:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738337191; x=1738941991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP02GWgqIHMyU6iy1+uU8QTBLlREt7y8gx/+g2WeozM=;
        b=xGlNyWcWMTqRfKtXOLP1mTg3NJX1v1ytiNfnZORjaz3wkO94xpN1DuTpv2GCdXplt7
         vHqREv6MvQ5PY8K3vMkoxwN3ISRmypDR7/Vv/MQ/zFD0Xn7j1fvBplo/VTkij90KB/BA
         czkxy0vNOPltEGd72tR1Q1sgTwDMdg92RPUYOIT3fVxwlWpWieJNiVxdYHkkUPwiLFUZ
         ckjYnO7uebUvXBiFpbzJ/AMwNMYmShZmKnrB9tCNeEqBGA+uBCZaUYpz76VnsVAc6yr0
         mYgnKqIFeNJ2Ds6/+Lvy/NdWBOqfBp83/CZcVaJ4htAvF3047rNTscHoyh3A0mH0/F2R
         a08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738337191; x=1738941991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP02GWgqIHMyU6iy1+uU8QTBLlREt7y8gx/+g2WeozM=;
        b=KZyzxkXYcZ5P/BU1LwRz5wKqR6rh5dSxPl61wGfY7oJApMSYzgDiqmtLHvPl0SM4to
         e3G/K9psfLbxHKrw3htJx5YtV/voII0H4FQQ4XcTSt0ZrhA7Zg6nwBZiI6flB5alBVcI
         MODgsQgISd/BNLfbE9ArLW6IIrQGNCMsGwLigFBJp5Ts7OMghhHb6m2suvhinS7NMQ7i
         /GzYJuwIq/4IHHyahFLAfs6yz3x7MRPmhzYZQgIKhyG/MxCF90UkWK1rLHf70n1/vK5S
         bPaZ+vvuYhB2C8J5In7eVFytwAhtdrSdjcrhReF51jcPFqVHbthWi9hcb0ylCqtA4SDe
         JBOg==
X-Gm-Message-State: AOJu0YxQyXCCOmeoqiusdH/IAo3KEYnVgOktXD/dKZn8WtsS8yY9IXJF
	mn02Ktcia2ZqUDr7A9pI0qPiHZ4/HaSafu8kUgTpaMZQyfv0JhNJpp+eC83O+SKVxjsAu9AzHTX
	FLE6bBV2eBE68gkM1NTU03L+PqIJ7mzTUJrvUYA==
X-Gm-Gg: ASbGncv2CQXtBcK/6/2xA5kFFefVdL8AhMbLeSgXN8/iiGxd2TYnsEbnbF4BHSbV9hx
	37LFLk5+C+DbbNIWUdfqRPuhUlz61enZG2cPItckq62So9OcXP8cVRSTYqFLQHuYqMi7897SoVr
	/WcQVPCNFE5zN14skm8WwY//u+ky+uCg==
X-Google-Smtp-Source: AGHT+IFgSGqRhIR5UDkU4uXh2hescc5V5Oe2OHITJF+o8P44rEboqOBh7//gL+OkBKaqq4UvEZ+nHMcZU6F/+DOPZa0=
X-Received: by 2002:a05:6122:3181:b0:51b:8949:c9a7 with SMTP id
 71dfb90a1353d-51e9e5161abmr9914263e0c.8.1738337191443; Fri, 31 Jan 2025
 07:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130140133.825446496@linuxfoundation.org>
In-Reply-To: <20250130140133.825446496@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 20:56:20 +0530
X-Gm-Features: AWEUYZmkQ1oz6UEbIN2VKYgUkkC8BVz0VFI7lE0Z7qDu76LAGPpLTFiEEL0CivQ
Message-ID: <CA+G9fYtVGFBb0tZzOYSuF_V7xmij7GUZi5Sk6L_h0nOh4G7MNg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/49] 6.1.128-rc1 review
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

On Thu, 30 Jan 2025 at 20:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.128 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:01:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.128-rc1.gz
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
* kernel: 6.1.128-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: da19df6ebb6c09ded78f67e201f202979c1a5727
* git describe: v6.1.127-50-gda19df6ebb6c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
27-50-gda19df6ebb6c

## Test Regressions (compared to v6.1.126-65-gad6747190c53)

## Metric Regressions (compared to v6.1.126-65-gad6747190c53)

## Test Fixes (compared to v6.1.126-65-gad6747190c53)

## Metric Fixes (compared to v6.1.126-65-gad6747190c53)

## Test result summary
total: 108475, pass: 71884, fail: 19274, skip: 16867, xfail: 450

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 17 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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

