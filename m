Return-Path: <stable+bounces-45249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D178B8C7212
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A111F21738
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DD2D054;
	Thu, 16 May 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyULS4Fz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90A2C1B8
	for <stable@vger.kernel.org>; Thu, 16 May 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844821; cv=none; b=izcqTIua+h8q/SJRu+X9RuBd1mAjlHDIiesPCLiXj2QXiS20JzRjpqMtccY3ZUhnKOzyGOp6BS+bNKXfh4vTl1hYjSWycEkyIxUhXm72BXoXaZtwOKX5xBb7QBoRXKCCHHUGsDhmo7sejf41J3r6aV0A4U0k0Zd052YyzrLhrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844821; c=relaxed/simple;
	bh=mV3bzfV2I1TjTPcS2ZrQrzUq8aipyYkqsnM4fcoounU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYyZTXKo3h1MQ1SAfedsHx3+yND/vbaMxjnNeGRyjVtc8G97eWvg2AQcwf/5N6cfB2UG+IkO0pX3ch2sx/ZBmHPhEvmAJgI2e9YfRRfsKU97W6PaNaQNRBO8mTYBEkwQeKvwctBqHJuX85u86NJTQZxHffu8+eErmBuK3pX+uXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyULS4Fz; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f82c932858so2180503241.0
        for <stable@vger.kernel.org>; Thu, 16 May 2024 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715844818; x=1716449618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIWq/FZE2YXC731qnWaoLEetM8Q50pTmv2YuXDZyF8g=;
        b=KyULS4FzF/SRY53c24Y/rfSUD0+Jeb7fqb8OVVheMZV1DPdEP8KNcW4rxhc5o48JRB
         OjL08KVwK385s23GsZ+DdZn4105KBZj4QE/u3tBYku4lqet3anlwduzrWaBfh/m36LqJ
         WtOUzjcrOuSUbIXCghdS37Bc2tUNNEnlodhpoNFkegUh+f8kv+0Cyyy4ntpQdIhemwPw
         PYrXGBIF1MDyb77PSfc5LG2Glu2/yhcil5B3SHbUatJh5DoszdbaBkQiloim7EZBEvoU
         EnpDX7eGsvQDnkRKvqXYwCtXF2zgZZBLVvd7Qsu8HMAcAwu7LQ3aGHJpicn+lMKo+S0o
         rQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844818; x=1716449618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIWq/FZE2YXC731qnWaoLEetM8Q50pTmv2YuXDZyF8g=;
        b=lpOB2IZhO49FucCdVUl+GXU1yix6lEaC1xAxWUN0W1f74Mkmc4BUvQNLQ9JpJsTYB3
         dCaiAWr+rDnNXq/w60zjVwERr4RWr2OG35PMqZLfO+hd9XJ4bf0IctaQDO3ouNwW7Iuy
         GqomK0WGev69gz2x5Xr5IVYlzpyz459dfYfmXqjVTNGTmOMOvca66kQzKh5jo/AM120k
         wIrA89KI4zmdVrP4qyZEssWKdGXqOHlbFe6JRkK5pq40xQaDmsbPu87mu3lrME7yvz57
         n3IaBMrMEQzzKhNak+CmX9s9KtrBDcnBi/siaDo5DKqjARrkrDaoSnx1I3962aTVoirk
         KWIA==
X-Gm-Message-State: AOJu0Yw/MQu+dwXNyixxUdDUPxceU0Aj6E5oTmYG4vpnzm3ahdqGzXKy
	dVQngWYTz6paH4ABp1kWwjoq0dKOdgmHemdgcvNwVxsvrQ75QUgJFxhcuQmcc0O43Aaoem0TuEt
	6Zgy31fgAjeOkyWsQPzfej+kK1ij4K9nb5G9gGA==
X-Google-Smtp-Source: AGHT+IGpRPi8is2Z+QCntAHBaeChPe/gMG90B246WuBKo8Y5w6+Oj96SVZGUzvo02KPLmnyH2zx4kpOyclGT5J1KB+U=
X-Received: by 2002:a05:6102:c86:b0:47e:f116:4535 with SMTP id
 ada2fe7eead31-48077dca716mr18583373137.8.1715844817070; Thu, 16 May 2024
 00:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514100948.010148088@linuxfoundation.org>
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 09:33:25 +0200
Message-ID: <CA+G9fYtvj5OEOeAG31vON6vE_NHE8a-3Sqg=ptb4hmf0icLmtg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/63] 4.19.314-rc1 review
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

On Tue, 14 May 2024 at 13:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.314 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.314-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.314-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 61b47a187ce8efaf5f5b7cd7e2ab6ca1b7da2557
* git describe: v4.19.313-62-g61b47a187ce8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.313-62-g61b47a187ce8/

## Test Regressions (compared to v4.19.313)

## Metric Regressions (compared to v4.19.313)

## Test Fixes (compared to v4.19.313)

## Metric Fixes (compared to v4.19.313)

## Test result summary
total: 42289, pass: 38159, fail: 195, skip: 3906, xfail: 29

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

