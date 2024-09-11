Return-Path: <stable+bounces-75816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F7975093
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEB71C22310
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C19186E42;
	Wed, 11 Sep 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4Mjn+v0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB2185B69
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053283; cv=none; b=GWORoO8xG4OAMLQmW6KcPcDCyqoJiEpgDCsc29vLUIPSbaL4+NwdZYvYXdfBm0QDmEdH/9UuGdczI3++E3Y18a7MkHauEWl7jy+CosZ/ZPvVg4XSpshVPP2JmmI2jf3/pbuadhlUyNPF7qNKt5qsJuO1JF0kjAvKw5LkLwDEgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053283; c=relaxed/simple;
	bh=eLZ7w7cowPa3hhjddGdA8bWcU9jM6WNWngJVkRAKwMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roe3OkJmHLEkD5JKE/BcYJfsSV5wuGJuWUivSZRXaEsd8On6z1TrNN8B2yuSpl8nKTCMr2wLdhYK/K6hUJORafy65OyVeJ+iIsVQeekU/H14k8dCkYqIJK7Q0fGV17wkZeUJxDYqmAUcQ7lFkpJlrxyiCW4PlMu3ZQHzHShZscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4Mjn+v0; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-848750e7e5eso1781979241.2
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726053280; x=1726658080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbxD6Wjz+v5CvHgK6ct9WCz155k6N2RRxLxKsD63LvI=;
        b=t4Mjn+v0eERdcTy++Q2ij2zW7rDvn+iw+iPmx9Sx7fksQs9fDFTtsPsqHUk5ZsBr+m
         QcV8jT+ftPKhm/Cf21vEfu721tVp8giU41v3RkmkKShWVBnscNiARjndDSIT6m0/lqaL
         oC18Ncla1cWVy0Z+CWVLD/UpbrdzFni7U5VWUZvPFzmQBWgGaCOshNhuC3CkrZ6Cp2gM
         Ele9h81FnD9LJ/nHRIQaWQx//1Wzh0syAm5T3Zzs25kjOwkQ2iJRlkgZ6W71ck8QRv84
         J+WKWF+ZCURn+/X7rFgnVfk9ELthHKqLic5A80j5G0rF1uCL1N9oaMZfdZlEAx/deHo/
         S2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726053280; x=1726658080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbxD6Wjz+v5CvHgK6ct9WCz155k6N2RRxLxKsD63LvI=;
        b=MZABACH5qcH3Rmxiql5irx3OhnFSaIxAvDOm0+wIIRaFZXmvP+PfMu0yCKfM3DLMGm
         +RNCqqL82ZWJ4xOV8oKw8bKXR+34nJv/7pmVQlQKUyHVMdMTbOz4RaRQuRPHcOyDo13F
         gH71QnD9ObS9AKs3dA3f0gmDOnfzVDYtTe5OHJx8L/Ii4HW3VVA5sYgXbRZCZKo4iX4+
         f2sPRGglS3cq7+ffRL4MqloTvF5g9bvq/3zcg8MDdbZEMl+rAErCuxWMuKEFE9uJU/mB
         smZCbBDOCNOZZ5BsU1sw+jNqJU8Q82TLqJ0imaM70Yj26elMvxNjzGiJg1q1z5/w7H0T
         QZlw==
X-Gm-Message-State: AOJu0YzezXaVq82R1kXruA7EbcfqA/zqdqzzfS2EeR/PGJk+dO6oG9gf
	UdCO6WCDNLrmQZYZLN18vWnBtVSj04gXQ4Njetd8Q0QJ18O5O0VA6nK0CPNuMboudJne3adY7S1
	UEWgvb+avynhIFYCJLLtG9rWf+EoZxF40BxrO4A==
X-Google-Smtp-Source: AGHT+IGJdmdDESJ2hyYLx3bgpfboZD9Buso5h41DrgJJgM3cqrVacNQh8sevxkDEFVdgEIxpTzITdrKLs4m4zvYwZhE=
X-Received: by 2002:a05:6122:2021:b0:4fc:da8f:c8c4 with SMTP id
 71dfb90a1353d-5022146e600mr18116038e0c.12.1726053280241; Wed, 11 Sep 2024
 04:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092558.714365667@linuxfoundation.org>
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 16:44:27 +0530
Message-ID: <CA+G9fYstZOHMFx9OHTseUTpXEZtRMSEujTMT+frbdSzQmm++jw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sept 2024 at 15:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.167-rc1.gz
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
* kernel: 5.15.167-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 72253b6b4643a28e11448f1ee2d2f0fbda027130
* git describe: v5.15.166-215-g72253b6b4643
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.166-215-g72253b6b4643

## Test Regressions (compared to v5.15.165-216-g36422b23d6d0)

## Metric Regressions (compared to v5.15.165-216-g36422b23d6d0)

## Test Fixes (compared to v5.15.165-216-g36422b23d6d0)

## Metric Fixes (compared to v5.15.165-216-g36422b23d6d0)

## Test result summary
total: 278874, pass: 232368, fail: 5633, skip: 40510, xfail: 363

## Build Summary
* arc: 15 total, 15 passed, 0 failed
* arm: 306 total, 306 passed, 0 failed
* arm64: 87 total, 87 passed, 0 failed
* i386: 69 total, 69 passed, 0 failed
* mips: 66 total, 66 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 72 total, 72 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 27 total, 27 passed, 0 failed
* sh: 30 total, 30 passed, 0 failed
* sparc: 18 total, 18 passed, 0 failed
* x86_64: 75 total, 75 passed, 0 failed

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

