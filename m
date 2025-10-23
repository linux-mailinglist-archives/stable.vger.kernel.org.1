Return-Path: <stable+bounces-189070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4727BFF772
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47E564E72FE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5E2BE03C;
	Thu, 23 Oct 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blqg4DDY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA2239E80
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203477; cv=none; b=mz+kOa9KnnJUdsRfjZBHAyqI0ji+HWUHC5oM1sRmbJ3X77bruvrpLoqKzZvGozW87nV669mrZRD6mbZTFKXqkKL+T0LPee5hMsTzVGraasvPvqmKF91CJhgHmyYEhPMFLAgfxhMwyuoVc8gGac8dtUs43hLsXrV8Hg331dKWNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203477; c=relaxed/simple;
	bh=83WfB3SqYO2Z9dZJO8Pzq5z46Mj56YTUJvCapIfPmAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRhEn0gyTZZlHZBSvQN3be4nDqo5VXhzxXzDsDBxIlaDtujysiLZKPEUJhDSF6aoLxrn3hXO0So/K8CVIP64Q6Cc/j9rVyOdkkuQ5vPjr8el5px57qjyPbU0DE+w9UZMxNIgmHBy9oqKTfQ2xYrKziHYsgWkYWlZtMIKkmargbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blqg4DDY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-785cc93634eso3609347b3.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761203473; x=1761808273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVFmcKppr8jIO/+cy4Rhc1x+4EvS+GSHFcZUJ4Pfb18=;
        b=blqg4DDYSCovejyIvemMMK27MlBOA9HC/IIQEU0bq2gnWMguHL83E98lhcT1htszE6
         H9x8CdGAhQ0EoYpOl7gH0P4smixwy4iCkDWiI2HjJtEcVrlYDqZvw/TzxPlf+5DsbTs4
         eT8X2d5T4GjVBo11Rxy5MlXXuZ4KMaPgQ8JaReied2UHFO+klNDm4JPOWY/sugMFhE3a
         oL9/ogIcNf6HDyoV+IS2gr/PXuebRiEy5iOFDjFCZcFng1yWDHlF0L/OXK/TEYu0LiWN
         apMtE5lDnPR1H35cLjDzOUixSKXx4JmlkvQP5b0P69mNoAuGMS+M3zfTO4MqMWx6shUk
         lI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203473; x=1761808273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVFmcKppr8jIO/+cy4Rhc1x+4EvS+GSHFcZUJ4Pfb18=;
        b=oQfalQyEPF3H5P1ldvyKBOesrdNfYVLFnjvwverP3LpDj7n5KeWC7gDAZjt4vgn7K9
         4JQUoa166Htm/sb6/2PTvwd0cR/YMqER+xPOh9sD3mrD4fpQjX5j7wHx84jbbhNDYE1C
         +J0KEA7zv5ZzbLzRhDof3F/wf6s1pl0+mL+bKi4LArCeOzMhO543iCy2TXcUURdeLZih
         WqzNN/pCOH+eBMmewdMdr5EK6vQHQ1Uq6hnr9pm8WK3PCwca0pEy5h2ygFiH4ysjPYWM
         GgwLghzJGLZArzTRnuhMUdpoE2dQkjyIV7HzSHzdcfiz3D7ws3NjK+GnM/OzmA7LeYEW
         EvDg==
X-Gm-Message-State: AOJu0YzizgKNfh3P9Z4ibhYtSbuysmAPhhp5eT+q94YCyurBtvysTGT+
	m1BUtPpbm/gcp+MXoTJv/1z9wiIYBLuH/5MABoQx4iuSJ8/6XaIjmprFqavdGoSs6N0snrAE87y
	vMggHck4BsdsRo9lQr6epVes872re7kcBEjRTYKSUIQ==
X-Gm-Gg: ASbGncs1brXes7Nyp4QE48bWAfKxxZc9T8cgDNiYegyoAvG2u4nXkkLe9XXLTN4nTHC
	3Htp0+f7F+8uYEYDTYHpc5mvoiMSfBCtT/6vBFpzFbM5owrQ3oXBkwhA134G4EVnkN4zopoFFSt
	ISnRh/uXuSXRpLMt2EwiMx16LZo4o9ED5GLiLY4lRo99hjnaVHUPqvZIx3rpWex6pFBk2BqwH1P
	u/tkq8U3Mt+ntuPpEqq37/o9Cl/nqImR11eKvzhHBfx0qdU1KTgzE+LxswTRLfOqRWIMO024Whb
	C62Yb7XwYpg5t34TrR4M6Pbckt4KHqScnXRnvxW9VQ+UqNss5i/jz25EO5LTbmhdhxgSZDI=
X-Google-Smtp-Source: AGHT+IH3VvCDO2eAFj9JJJRDEEDT2NNCXO5PyFPHxu8d0hi6hIJxQoOArUWORp1GvtDA6/0rOxpi/UwchI9zIngrtoA=
X-Received: by 2002:a05:690e:d85:b0:63f:309f:6354 with SMTP id
 956f58d0204a3-63f309f66efmr3332065d50.47.1761203473301; Thu, 23 Oct 2025
 00:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022060141.370358070@linuxfoundation.org>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 23 Oct 2025 12:41:00 +0530
X-Gm-Features: AWmQ_bnJFFuVapEywiEjdKwHI9nFNuApBe7za4vRcqQ8LxS3q9W1qtdNuEfmywk
Message-ID: <CA+G9fYuEMMptWPgF5wmEPN4T2eyrDC8i+Ha_xLT_E35AXHeP-A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 13:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 06:01:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.55-rc2.gz
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
* kernel: 6.12.55-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bd9af5ba302635dcb1e470488c0fdf70be8d45cf
* git describe: v6.12.54-136-gbd9af5ba3026
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.54-136-gbd9af5ba3026

## Test Regressions (compared to v6.12.53-278-g6122296b30b6)

## Metric Regressions (compared to v6.12.53-278-g6122296b30b6)

## Test Fixes (compared to v6.12.53-278-g6122296b30b6)

## Metric Fixes (compared to v6.12.53-278-g6122296b30b6)

## Test result summary
total: 119783, pass: 101440, fail: 3822, skip: 14162, xfail: 359

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

