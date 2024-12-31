Return-Path: <stable+bounces-106607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E09FEE18
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 10:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200653A2B72
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D318D625;
	Tue, 31 Dec 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnCRJg4d"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2013B7AE
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735635625; cv=none; b=Pc7cV2wq1F7ubYq31KZ61AeRnHEfIa18iPB94Ys/9qKzLK76G52GmEZNi8GN4Nf00GbKMmDQxi8CUtTUC6S8b76zVKkU7667i11Uy+ouVchQGGZze+3J7qdD3Z5nWXhJLvjyCjCfPlAHuDVB1LNJe/4DK4wz9hHNRg9UMlhgO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735635625; c=relaxed/simple;
	bh=mUaz7V+0PEjxde47ZIFLIv6+udOt71PERLcQ+z97L98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUs4lOJHd/8uPqO8/+bXp/sBGJ8YQZWukEJU7xaAhn6juXVYANQHt0mVBfegI627mPC91zOaqJ0yYcwCpMPCJ9PBQdtABx9Eyh3Axp7zNcLh2vxz08I7lL+gDaqDtaZEMb4dE7xhCuYSs/baiolHWQtlY7FKe4Y9UvPfZ8blyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnCRJg4d; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afdfefc6c1so3097524137.0
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 01:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735635621; x=1736240421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV44Er4wRAXw4AQa0V8ZgmaVXCQ6ec2RCxnAf1lOfGg=;
        b=TnCRJg4dr4qep8qtceWFYDyYV+mC6rPDOS9BvqX5yOH2ZV9MH1dMi/B1kPG/izU4ZC
         aEnZT92dXTfhJSox5lenqIG/0/InyopEU27yMvF4nqSg1zgKrtMonwAnTyDfKGUxEYfK
         L+htpRfc2zZjd371XNtEGgrRUdDkOyBrx+jkDfdsSi81k3cnKEZ67tVI8C5DVObX58M+
         Rjgnyc4XsLsV+fSKIOsL19ePanI3GJ+T+cyay351eNtqOOtzsEOSX7UlcmulOojHTp2f
         iwZ7g/wyvT40CVOMGyPg55sW3e+r+PFbHVai3p6+FUD6o594yURVA9Q+d7Wep3lvErUX
         7Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735635621; x=1736240421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV44Er4wRAXw4AQa0V8ZgmaVXCQ6ec2RCxnAf1lOfGg=;
        b=f0SXPTuUmKRaTZx6nCzAHsT2tMVmIoPEtp+91bzx6Qopcl1gX8JZmaOstb9vqQmNSv
         bXaFvC46qmR8QbpeA5Amm8YCt+P9KlR16hrXnZ/CIZ4bBbwlB7yBJakLGdMGa4jcOQZS
         Fzs7vyJS9uFakSgVEsTLg5UcB2I4m3KBCLT0tl6Kri6DImuou6vv/uNZEWKkwx8zGFN+
         s4n9W1uKNhdu3e9dljBoh1y7w8L/Ojd+Q64iiETGByfavAKI0QKQkIgmyNOwoAerqLt0
         dU2RoIOWnE/H9wyQfvLiGMkrV2UATkaBA9H6hdyXNW4sbFGjmPyKh+iZ65MalVAZeZt0
         S6dg==
X-Gm-Message-State: AOJu0YykQ7gZxrj81md8JDtUCA/EufZB34fEq78TLZvjImkJ34Vn2Fcv
	0c794T8x4S1X9oaAMABdHEowUEj03ArnyL5AIB4JGimyPuDG7k9m0mKcP1yYksbGza3M203Q1Fz
	pviD7nLIltEjLYGJw/Zn7Z1Ga2qsUDTOc2XASmQ==
X-Gm-Gg: ASbGncu4d/xnGZwFbFowOqbwtEBLmDoMevgl9/ji/BEURKqbm5em5BGVUNml26BacwI
	B4NFYIXLzXcYqGnJrTUeSyxQ+704D2trdmBZ/SSTGN7gNGthOCCJhFZfxIi4p7r49F5fgTg4=
X-Google-Smtp-Source: AGHT+IF7FaTBkk37IejVxQeRN/hYGcd8BaRyjocVh1dqULx9XFD7qpfJRznRFyLO+3//iU7WzuOKLOsz51NOc1+/604=
X-Received: by 2002:a05:6102:a47:b0:4b2:5c0a:92c0 with SMTP id
 ada2fe7eead31-4b2cc37daa1mr33432417137.13.1735635621612; Tue, 31 Dec 2024
 01:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230154218.044787220@linuxfoundation.org>
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Dec 2024 14:30:10 +0530
Message-ID: <CA+G9fYs-YvKJsGp-7+YdWQgoxTkAh0kUsOO0aXYhLHPTZAzzyQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
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

On Mon, 30 Dec 2024 at 21:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.8-rc1.gz
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
* kernel: 6.12.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ed0d55fbe89cd97180e55170f9f3907b2aa5f91d
* git describe: v6.12.7-115-ged0d55fbe89c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.7-115-ged0d55fbe89c

## Test Regressions (compared to v6.12.6-161-gc157915828d8)

## Metric Regressions (compared to v6.12.6-161-gc157915828d8)

## Test Fixes (compared to v6.12.6-161-gc157915828d8)

## Metric Fixes (compared to v6.12.6-161-gc157915828d8)

## Test result summary
total: 106218, pass: 84898, fail: 4380, skip: 16940, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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

