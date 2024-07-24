Return-Path: <stable+bounces-61314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1393B618
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9E1C237E7
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8015FCFB;
	Wed, 24 Jul 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXDMOy9r"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E291BF38
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843044; cv=none; b=Cc4Hl3om6N2W/n6LpsMmBCiUEmQf6+OEfiCH9tQQps0IwKh0xmsddRPi+vK5cOipTMHI2YvTYkcbL01oWtkHunFJU1OrVTAWm3/E1xcy4sftsJM0dG+0cToZ4n1bLP3OcSZKNNa3RykfsdowwUpYutJZC+hKqTJUzf5wERU1sUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843044; c=relaxed/simple;
	bh=RfpW55UTZvyZzzckL2ImjfWIVW2ihlQWqrDTt2uhNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obkPrCj5CzSJ/B/HLN99P+JBKDOn1KPap6WAwO6aLRFXPY/i9XQZ+vOibPyYtsXbjfg9T/s64EYeNcXb0CKeL6HobO0jY/xSFXRjzSG+PRUI7pbS054sadK/ibZzKP3eSJrt64w1Glcz2wHEieSujbRvgIfLCCRObZ/AnUzy1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXDMOy9r; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-49288fafca9so10080137.3
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721843042; x=1722447842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWNxmwE7SepXHSEluHdYdY/sD0f7oz4k9ZSiygi0+EE=;
        b=oXDMOy9rMOg/Vso/Y5OqtF+jy+tP6u88LFSc60OL8NyuEmhIirgHRgYSlR6ULjgO31
         IMuYmsavIHIFlcdluV7kUKtp8m/kdMi2Q9tSIX6hzirjJH0k7/xDNtZefuWK8vUxqI9Y
         bdhqGZ9Z8Yp9XF44JvAJTS9gLgZZhfo/XSayNIlOp9fEQyw+e2U/RjpEywVE8LWBbW/d
         biHqmU14SwaRbGC3lJz5pXOE0cX8Gn4EVpQzorx4dj1uLuxL8HJSHPzoVEGGrNBDbp/f
         YIr9eg9XkDcdPHdZmXm42dMtTIyNdjQsSVggg6vTrp+xdUxQU5BsPM0uTvbc4gxsvOgk
         jOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843042; x=1722447842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWNxmwE7SepXHSEluHdYdY/sD0f7oz4k9ZSiygi0+EE=;
        b=Hohq14LjeVlWTA6zyhhmiMH4BaBDfmrLswixDOJTlI2CghqrGwj13ICfUMoQyZYTjn
         wLiW+7bXBxby21i7Erl/4K8jMVqU9MjTtfURfGqUNuFL5tULUFTbLGspMFgZ9k3q1ztC
         tXUpk1Ca42+SLvYZTeZL0Tr6VyjINjvqQzomxsBllBZ/6SPFnX1I/NtD3sww9B1HC+Zs
         yphLMETxHbF2ETc76WFazJg75T+mXB57NFpukUVb2oWg7tBje3wkRak+t1ekzDlWTuJs
         JAJuyUKYGUHaq+St7CnfcwQ0PvPIKpH+WBVgz9AE96ywtV+NV50pRUk/KeRPRllul8RJ
         ILOg==
X-Gm-Message-State: AOJu0Yx8/CbNbtCNLjUCOzXVA/jk87RFrsJ/xt+XY70xihpm/You5gc/
	eIRskv18Tw1qCLu1SXa9lfIqBXEXxDjuv2CZpA75tWpehY8oMmgxSAark/S2TdhtL8MRxrP+dz7
	Ky4PEPEi3BSlcjBZHLn43ispbPeCB8gKJo65S/A==
X-Google-Smtp-Source: AGHT+IE0a50hyiZ7t3CUoJJvgIA2KhaSQAKstOkmmukXOTpX+4W5PyJLokyGQ/tSWCMeGGPmaVd3UmMZEkFDjEO06Wg=
X-Received: by 2002:a05:6102:33c6:b0:493:afc8:17e2 with SMTP id
 ada2fe7eead31-493d64554bcmr357072137.17.1721843042117; Wed, 24 Jul 2024
 10:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723180402.490567226@linuxfoundation.org>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jul 2024 23:13:50 +0530
Message-ID: <CA+G9fYvNZNzz1xBDi5bz=DQXqe0T1-J_xcJz0hf5iikU0d=Uzg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
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

On Tue, 23 Jul 2024 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:03:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.101-rc1.gz
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
* kernel: 6.1.101-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ef20ea3e5a9f08713890ee514b5d1a5bd067ed54
* git describe: v6.1.100-106-gef20ea3e5a9f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
00-106-gef20ea3e5a9f

## Test Regressions (compared to v6.1.97-198-gc434647e253a)

## Metric Regressions (compared to v6.1.97-198-gc434647e253a)

## Test Fixes (compared to v6.1.97-198-gc434647e253a)

## Metric Fixes (compared to v6.1.97-198-gc434647e253a)

## Test result summary
total: 160040, pass: 136908, fail: 1846, skip: 21026, xfail: 260

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

