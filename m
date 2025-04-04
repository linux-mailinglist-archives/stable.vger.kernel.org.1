Return-Path: <stable+bounces-128342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E738A7C2DA
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D22175493
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11B219A90;
	Fri,  4 Apr 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYDjA2Wd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445D18FC92
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789236; cv=none; b=mQQyhtm6GTcxdEVY9o1uTdAphkFVDx/+g63y0rHiCEuLWsxGTItymIAotI7MleEUKBhpqClHMJQDU0jxc8fytriCB8FlpHeFqqIrgZCupjO+1p+HoSCgrK0POlymRYQzO5TFWZ7aSOhOhKgb0ygphM5d0f7YnQe5WKXBKTkrSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789236; c=relaxed/simple;
	bh=w6XLZQZ7SxQAxIlopsBskwMTuttUnj6XdCz/qeLI9Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kx+URmWof/WEjF3X3VO/cAE7AK2fbFRQj5ehWHhB9DkJLZzyJWdYl8BO6GAmxP9p5wUdXdB3pSIhepzOmwN7jmkOIRp+iumJE14yEBUgK3d+dzykXhKdgPKm9qk0m5ZUoQdj4TNy9S04v4Z7r65gQm56xEBruEF6fU8+nsoQOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xYDjA2Wd; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so997168e0c.0
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743789234; x=1744394034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/QkejiZqG1AwqRbXs+dWYNpxR/iWqIC5Zwh4CzRL48=;
        b=xYDjA2WdkaA15+BSMUVp9r9mcffmjGf7eKE5H748L+zShcZUtn5XvuT+k0f6wmKcac
         7qSYjhlE9RjD5+91OH2/WwociuaaC6XdQglsDpaeD/stn4xdv5Mmy+wWKZ1XeV5Q2XxE
         p2aIc1BB9ojqc4TCfbYCBrChpz+DP4JAZDSdy1sEPUwD/8S2CRJV7yMgaB9EWwsiuw8v
         /ZaWImVqoAnxZ0BkXgnfxLJfKfcuChTpxiqorL9tQGQnLIS6TEQmthxWylt2XaL5DwtA
         7CPsHMsRj2UfdnbCJtMl65zpoXNZgvcPKD7oVEfKq0ddGsEmFCHjcKv+fkydD20zkuKp
         nELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743789234; x=1744394034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/QkejiZqG1AwqRbXs+dWYNpxR/iWqIC5Zwh4CzRL48=;
        b=uBtfNUcb7M7bVj8nL6lirHstr7fOnPhIwnWHFDmwVyCoSwz/SfzERZaD+rly+bsJhI
         RlSwq8YTi0JTOh6yP43CQ53/t81qR452Y1GfRT6ac24dFIE2GgF4tmbdB0M6Vm1YBKyY
         eG28bb3iEeNJPrcQHFsC8CmZi2L5D8buS4y3zOPxxFWCNGVYtPdp6CWQ98G+zARPnx2N
         FmD/n9iFxw/jdcvRrn6xOW+m3nfJ/NOoHZ00S9BaDc9sqKGEnmmDlbMKkDNGpv0Ds5O/
         KFdXYes7EpowEyR3kriS/wiLl1KUyQRfqfbblJmAA+AQrF91WBtUmHfDNnrllQXVGS2k
         +z7w==
X-Gm-Message-State: AOJu0Yx7hvipZLtma/2VsVl6pLtZ4Tm4DfFkIE/vCQdvK9FArDZKMCPy
	xpQUzj7FqmnKwzN+Qq3ggDjC9ljoecljBY27HnpWMMoB8Od5CiFSatEsioYkObNsoTuSxI2UMVP
	twmGKqZ9ZUmsXVUwz7NLxX2PMjkGuoZ8+hMhKoQ==
X-Gm-Gg: ASbGnctPmfs9WSj5qtc3NH8+6Adt1WFeCEfxd9wbtscw9Fw5D+/WOnoI9L+zkLb6pqr
	sz6oshFJ8XL5HPcAvnz7k49qzWfFzGJXVp6SOkXsEBUUNIOho2/Lof4y/jqI6jLVdWa4Ke5+xAu
	ohPQsecGHgILTnPhwmmO1jlmzGr2HM51xtB1ol5QmOQAOqVsD7MXeQg0zU/5Sg03hv2icS9Q==
X-Google-Smtp-Source: AGHT+IHb0kf0KwRowiN1++/tNtzAOf06R1sEJzd3+qIJSrUlcgjsj9QhFya2h5gmYkdwJlrbxqRyKZFKlVdDC+1LPu0=
X-Received: by 2002:a05:6122:a09:b0:520:42d3:91c1 with SMTP id
 71dfb90a1353d-527645a5e5dmr3682982e0c.10.1743789233728; Fri, 04 Apr 2025
 10:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151620.960551909@linuxfoundation.org>
In-Reply-To: <20250403151620.960551909@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Apr 2025 23:23:42 +0530
X-Gm-Features: ATxdqUFpk3ftm-esTm2WI6L89CtrJ8-6rIhluVCmpjNB4EDEzoJu5oFlJFgC-ms
Message-ID: <CA+G9fYuixzW3nkcp_2mPwZnFkDSgDRietB=-Dc=7QZP3KKTCKg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/22] 6.1.133-rc1 review
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

On Thu, 3 Apr 2025 at 20:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.133 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.133-rc1.gz
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

NOTE:
The following build issues reported on mainline and next,
* arm, build
  - clang-nightly-nhk8815_defconfig
  - clang-nightly-s3c2410_defconfig

* powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig

clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
 - https://lore.kernel.org/all/CA+G9fYuQHeGicnEx1d=3DXBC0p1LCsndi5q0p86V7pC=
Z02d8Fv_w@mail.gmail.com/

## Build
* kernel: 6.1.133-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 819efe388d47dcb84a834dbbe01d7bd2c120053d
* git describe: v6.1.131-221-g819efe388d47
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
31-221-g819efe388d47

## Test Regressions (compared to v6.1.131-198-g0c858fc73636)

## Metric Regressions (compared to v6.1.131-198-g0c858fc73636)

## Test Fixes (compared to v6.1.131-198-g0c858fc73636)

## Metric Fixes (compared to v6.1.131-198-g0c858fc73636)

## Test result summary
total: 89322, pass: 68357, fail: 4336, skip: 16301, xfail: 328

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 133 passed, 2 failed
* arm64: 43 total, 42 passed, 1 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 29 passed, 3 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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

