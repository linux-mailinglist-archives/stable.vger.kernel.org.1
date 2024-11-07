Return-Path: <stable+bounces-91798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1789C04E1
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1289E1F247E3
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B882101AE;
	Thu,  7 Nov 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2WhETj5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D2212172
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980262; cv=none; b=UJITskvKyaOIBsRm+N45fxVqBflgRpI7469FqK7NTKfTmAwCiE7K5UTDIPQUxq8a/av0JJrFtHe0KYKWqgIfUL6Z+eE1aFJXDeaD2mgMfqwbS3X6kbmsTG27PAHH/oKn4z5kZkgSRgX7pBXTy+CGLCiYCkGxqFpFalshxBadYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980262; c=relaxed/simple;
	bh=Mvs2mAn+Drk32JlagAj6fXdJ/5G6gyP5H7MHIcqftUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8GNUUcOL5xCI1pVAloPSRA6GLtmdUJZ2qfC3pmRs3BkmkjCa5iMY9Ni6dM84HOI+3cHhu5b+rzECWt1rnCDOP9xpYUl0X3BPTFzfc3pWci0Vg8i4Jol3XYcZsbY/1dLRm2lXLgg52Jtbvrbd925L5J/4cLsNs1r2t9UZCbPu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2WhETj5; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso1580680241.0
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 03:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730980258; x=1731585058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAOAzPzMyM9M2AFbfquPPJQN+4hXvXsj2wZKfn4Sf6M=;
        b=W2WhETj5qXDZs7XASHlVyuj3reIbFsk8Had3GoNtvQZ6s3IbskirmTCQznwPCBycVm
         tUuxKaEtgOzlIh1AUsZy32l9UH9lV4ltXe2nTNqz4nIhkZna3QvrJ/UdLAySED1kWCbu
         8G22BZJofp2cwmAq1zSZQX2zlvhby9Lvl9Yn7hFTsklbsqx9D+1JJ2JhPdgtE0my4LGq
         rHF3mskBtlXm9Yrr0PzHZnW+oGjAyR7CgMRCk47sXd/Dq2yxmCS6PpyY9pwzaaCL2Abn
         sjznQrytcsMFczyOiAsUbmypPAG960T2lNczHV+JE6kCPUqQMO247V5socXpMskQGFdU
         8yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980258; x=1731585058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAOAzPzMyM9M2AFbfquPPJQN+4hXvXsj2wZKfn4Sf6M=;
        b=mLzWkkv3KiKmuPwG2sincoa15qjW+henGSxo35hPc3znHSYA6sPPnZZQX2TnM5vY0C
         AMtwW/2bRMAr75emUIUwnc/6VVBxMsiSTtjjPjeerZUVBKOeE6t1T7StNejlilocBlEW
         bFRZJUJ1CkpNQQ97E7njRfuIaBJs5Qfuv8Ez3ZKAXz87UNqr++i9/aF2r94vjAdgKSxm
         3ScMXZnjfKAYg7ymH2PTQo9KrtmKMzTVeM+0JieFfDoCBTR/LiQjZaRoZcnfR9wTFnOg
         CcPMaUSgXCB+VljuvphkXZRr+pmjWQMaKntn6Tal4EKLYtVDEiEb6UD4Lh3HQge0q8tm
         6DcA==
X-Gm-Message-State: AOJu0YyW/foFAL11iY9PBY9GF0hHL29KzrplLx4UO7Bi3e/noXDj5qoI
	KxIHuCxf6QiophbhWNThNe77pBNBSWbY+zfmtJNSZozc7ta4cbHVL5kMpFq3buGjqeYT01pBEIE
	BX2weoQCRXjYcYBl3OEufc0xXytgo4GK9dgbUDA==
X-Google-Smtp-Source: AGHT+IHOorGanACLiDA0VqGusHLjdV99Wf3r3+lkatrz0pw0DdKsclrxXksCxolyu8HoLHYrbpx2b0DNBtEIBbR7Log=
X-Received: by 2002:a05:6102:200e:b0:4a4:71e5:eb76 with SMTP id
 ada2fe7eead31-4a9c24b1d4dmr1441105137.10.1730980258545; Thu, 07 Nov 2024
 03:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120306.038154857@linuxfoundation.org>
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Nov 2024 11:50:47 +0000
Message-ID: <CA+G9fYs3Jb0RsnX=uTwVi00HPZBCyOF0kZQ689_Q45e+R408iA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/126] 6.1.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 12:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.116 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.116-rc1.gz
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
* kernel: 6.1.116-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 17b301e6e4bcfbf3583ab4432c71766837667b6c
* git describe: v6.1.113-359-g17b301e6e4bc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
13-359-g17b301e6e4bc

## Test Regressions (compared to v6.1.113-232-geeea9e03a3d4)

## Metric Regressions (compared to v6.1.113-232-geeea9e03a3d4)

## Test Fixes (compared to v6.1.113-232-geeea9e03a3d4)

## Metric Fixes (compared to v6.1.113-232-geeea9e03a3d4)

## Test result summary
total: 113467, pass: 90642, fail: 1843, skip: 20882, xfail: 100

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

