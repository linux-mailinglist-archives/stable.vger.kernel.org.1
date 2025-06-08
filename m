Return-Path: <stable+bounces-151876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7FAD1149
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B41C188A8E7
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331A1F542A;
	Sun,  8 Jun 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/sj0v4r"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90E1F151C
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749365102; cv=none; b=AtPY1upNl/vs8LEmAH3OcaYopyFi+M019/D8p328kQh6XesYSCJu8FUEuKtKE5X4li4kdab1Uhg7M1J+qZR/xXfB7p0c/LBd6ndjv3vpjXlu2i/qKwalsOHUOH8/OPAkloPSslkFkKmzVoNHguCIx10zIZhix9WSRK7ZGNe5FGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749365102; c=relaxed/simple;
	bh=C+RNxggqN2QjbPJ9FTlgd8P1BsnmUQvdpu2uGyhkwQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p79HXtmd51TqFBJO/aVUampujxuBA4RLXPgyk+dHbY3CzVFAQgxz6wfUFmRlMHXF2Zmzy8TzRkbYmwJL9i9gIUEJUFYp6b9TyD/GJ+jpQT4JpM7icft9ynRZ2dz4idZZmIL4uCVqdiJsNIaYtUxDyuWHuLwZvb36P3SRWVd/ESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w/sj0v4r; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e58d270436so1119269137.3
        for <stable@vger.kernel.org>; Sat, 07 Jun 2025 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749365099; x=1749969899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+TMvdbUNerpyH8sJEZRNYZgyFmQavgKhbR7MC4e4Bc=;
        b=w/sj0v4rKIPz+ESLggj7WzChIe36ikRWdVDyogw/EdxasT/Xl6+p152dHUkef7BtWM
         2b1kAcosBCd+yq12YsQJ+1Up/VlApqYBWYoqcVl6MJ3safPq564X7lRwIxgaCX3WBZSv
         qro6aFv/zHrC9eVfgr1OE4r+sCPQ7ynTSk5YxhveUYJcBc+Xe0vZth6W2GBcaXXWxuL+
         0OZqg/sopLMiHc2coBeRkhxlAfBJj/5yDDucWBPm8fzgII4YN3Idppckjn7yFf3TkWXP
         eK/wi+DCQWRDHFHg8cSUIMcRSKL8jcrL9LKFdZBEu9zgRoZq21V+RmDCdbaF51/puArs
         EzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749365099; x=1749969899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+TMvdbUNerpyH8sJEZRNYZgyFmQavgKhbR7MC4e4Bc=;
        b=oC/16pNIcsJIAbRrnL8aWnv9W0F8piUAYMkVV2vSwpV7BX9MEDf07lLd35gYplmpCl
         BL6SvF6KUH0MhLe/L5uuU1vILsktj09ZKS7IW1In5Yi1S1HKoXDL8oeVvtGn7Zuo/g/+
         Npsebu3FXEvsKY1ZTOLOO4CEK0BjX/oRK/pv+lxk3C5GPzEg2uOK2F0LUrPZwmKt89zb
         3XeChvNNnSU2X1NNk9l56DITeBoxdtA5Mh8r2QVCCGoxOTlvD4Wc23wvnhTa8+qTduJq
         viK6Ru4jvznJ5dolgjK3QNU/BLMsNQs9CIlt9shbyQel3Pvt+M3O5u1zqbAGkI9c7+h3
         fAbA==
X-Gm-Message-State: AOJu0YxJnj+YnjV4daYvKiEwT3PNY+DS49/Idga5w/7JJEb/DNIMtNwp
	QFo+bLBzvyIiz5ZTWEBY6o/fI2f4L1hNUMIOm2Krwo/laepLmKaAqsqiog7a0VET8XpfVTwarSf
	1z3BKgAFxAg1ukBF+2HxnTuJLF1vip8JC3H9YGnIpCQ==
X-Gm-Gg: ASbGncs3TeyP31aF3N/UDVe3/4IsNVfYu/i0Y1sy6oik3L8nc+o6kdlbEd5dF5wL+A6
	LWhpEdDFC+2jHE28A4hwUfNkea36y50/IjfN/utwiuHV6wAJ5SCeWRgxlO7/gekzfqSIKWRUBZo
	GxB0iy2N5CPV5qiL0l3JZTY0gDVl2cmeV8EfjNQ4FdPnu5DiL8g2P4Qj01w6wjvIyCVXuSkHeIj
	ubL
X-Google-Smtp-Source: AGHT+IHLa/yHhkPSfcyx1hKMa6syQe3C0UX3pgVWBFkb1l/f8WChidJTzsKbqoK0sorDh7BtZ1JkYL+c0MZNTNe9gP0=
X-Received: by 2002:a05:6102:a4d:b0:4e6:f86b:a715 with SMTP id
 ada2fe7eead31-4e7729dc77emr7919545137.13.1749365099319; Sat, 07 Jun 2025
 23:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607100717.706871523@linuxfoundation.org>
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 8 Jun 2025 12:14:48 +0530
X-Gm-Features: AX0GCFs4rHgJPJiFvVM86gqPeYrxTo-ECIBTxC4hkOtMqhkYsoHvI40OXDuMNTk
Message-ID: <CA+G9fYsY7DFXk6=L93QasmVR_3-FsyPMWjv-hMbW3HcnZEHifw@mail.gmail.com>
Subject: Re: [PATCH 6.14 00/24] 6.14.11-rc1 review
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

On Sat, 7 Jun 2025 at 15:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.11 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.14.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1927b72132dad3de52539a325870bb7257258f73
* git describe: v6.14.10-25-g1927b72132da
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14=
.10-25-g1927b72132da

## Test Regressions (compared to v6.14.9-74-gd9764ae24926)

## Metric Regressions (compared to v6.14.9-74-gd9764ae24926)

## Test Fixes (compared to v6.14.9-74-gd9764ae24926)

## Metric Fixes (compared to v6.14.9-74-gd9764ae24926)

## Test result summary
total: 256049, pass: 234537, fail: 3929, skip: 17018, xfail: 565

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
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

