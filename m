Return-Path: <stable+bounces-94516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4429D4C60
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18E928157F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96F1D4324;
	Thu, 21 Nov 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERClybw8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45401D31AE
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190208; cv=none; b=GTZyU1j2m+EQOWPmWKSuVz4Gqu5Fj3U05tseKpDRx0UaxRgj5VgsJ7sY8km8A1Y5l3m4/oc2nMKK+kI8ERTO0HQtWhmMmcJfNv1cdiSeqxetRLzwr1hoVeht+mtCn5W8ebU/hqY+gCQ1qIQSA6xHfrB2t535vSjv8M6A9e3+jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190208; c=relaxed/simple;
	bh=VkGV7Zt+rEd3MMDFMNpRohwhdhdrUG06HHcUUpm+I30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i09xyvA1Y53rYSbB9ZZQDWK9tKXO8ub6EwJluv55lOOAdrhzVkoiL0YUhMs7NJ3oXfupOv0lPJqoROWwQVQ+MHy37qhjhQMb3N3GqeQbNIxNI/MQ+bkKAR7SO2vL4IplQpKCdxNicWoPs9J1ZEdP3AkQQgFbNXA3axYLVLp/e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERClybw8; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4add2193012so16090137.1
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 03:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732190205; x=1732795005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Gdo3Vzol5nCNRn6dlVpR9KZyNtJnDJ8NArSZRSKrA=;
        b=ERClybw8FlIG83IVV9As7lnxNaBMT9NCTA6g/339dAYqA0PzhFKvJS2B2+LJOkCYMu
         mmFVRgJxOg5A1gHR1aUe0c5PpRzXay5PYMZn2yRlgnWjFGtkrzxUpPZEWg1YKD31Bn2l
         UuvBEVp04bKRCyzWMbzlrSeYnpSNP/XkcCUzV6Un7Y0afXgA9N/AA+0ATDHjFTCM/UUv
         Ad9TlhogXRSfBooTUhmtM7PHVuAe94Agt+1MczjeJdL/wBm8CATGKetOWgohhqujpjSn
         yDNE6qTFVYjfotR8trubusJcjlj+0mNnmZj6kUhpchxdhUK/XERn4e2AkFtVfUzgoDem
         pJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732190205; x=1732795005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6Gdo3Vzol5nCNRn6dlVpR9KZyNtJnDJ8NArSZRSKrA=;
        b=UOAYLzvr5eVlSYJafFD3wy8/qpkPEf5vQbD/2psgVx6oOocwTnv/eylE6B0u64LCHh
         3Xx8IK4c1t0EBGClr+8AC3cacsZxB4P+rrs1OO8AXYX5W29/j9pPOVtrrgBMhSIi3GKm
         bTYSoZ7B5rK++Bbwl4V4U8VOFFo9zKnKjCHYnXxemG+Z7HViNF9eA0x8o38U/ornmwN5
         jQKFy+/uHBM9HxDb+KhHFWOzYgbzv2xxB10glE3i+ZONk1yNo0ZqLRV6ujSsnzeRZSk5
         pqI8HLhARxmjLAubepAy6POczGskQg48RBZzUFBUDAMq1qs/oPWTkvUJzteWvwPtwUdb
         yf6Q==
X-Gm-Message-State: AOJu0YyZvtHqbudHkbJZdDsO+nt6spwl2p2SKlID2wQPZ/t0iXflRtCg
	7D04+Wzz68H5hEnnxh0MnkLA3xCpGWpa8WMfoSm9dnLDMhCXnQLvhrWGqfTSItVMcXsCYmLDiv4
	C+hN537zgxkRAUwf4ptbmfPDqDSeseKt0AcFOhA==
X-Gm-Gg: ASbGnct67pjT8E1fwGJyfXh6JxWB/pe1KiI/Bffc2YWpafhX9q+75Bw8tkBnjT31MJ4
	Fatyj1k8kXzlex4pvofJTkyhxK3MCPlxuNjARMxiEbggLGJCaeq1byXSyPMDmz5y8
X-Google-Smtp-Source: AGHT+IHWx4Ch0jeGqZrv+bKd260l45EkCV/RlRxsXv4mlux6sr5BbBUsPegersHTqKg2s9qYi7j388Ee9Xg4esX0wVA=
X-Received: by 2002:a05:6102:f13:b0:4ad:4b64:530b with SMTP id
 ada2fe7eead31-4adaf4156a1mr7940550137.3.1732190205519; Thu, 21 Nov 2024
 03:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120124100.444648273@linuxfoundation.org>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 17:26:34 +0530
Message-ID: <CA+G9fYsuQ_F0H8ByKiNazExpVbPGNrZ8amUoXCjc_njwng2Vpg@mail.gmail.com>
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
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

On Wed, 20 Nov 2024 at 18:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.1-rc1.gz
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
* kernel: 6.12.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 11741096a22cc5e52f0cd4cc91f4b83bb848ff62
* git describe: v6.12-4-g11741096a22c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
-4-g11741096a22c

## Test Regressions (compared to v6.12)

## Metric Regressions (compared to v6.12)

## Test Fixes (compared to v6.12)

## Metric Fixes (compared to v6.12)

## Test result summary
total: 137313, pass: 112117, fail: 2757, skip: 22439, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 136 passed, 2 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 24 total, 23 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 44 total, 44 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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

