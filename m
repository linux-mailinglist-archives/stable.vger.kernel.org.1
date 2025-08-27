Return-Path: <stable+bounces-176477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241DCB37EAB
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7053C5E83BF
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C23451A2;
	Wed, 27 Aug 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXJsQyjz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A113431E9
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286508; cv=none; b=i1E4sysQ0Q/FM5YyAg1c53+VG0/GA1NbgVsJGQKNtV21bipvtG659XaNQCN0vJAt5j8MacolfwmmhlRZzb8dbjzS9BCoo6z2P8Pzj+LZUxQ2RuP2UVNbda5Wq3th66s1bJfqWktr2PKt7CkyLRk1lwboalPKrSkzfuxffP9z5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286508; c=relaxed/simple;
	bh=AZj1pPR0y6aQduaZ5xgjFt/qPTTBCkCy04MTwZiYc68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odCs52rdwgRiu58CLKL/drgFKm3s/l7Z1R05voowMcgdmJhF8HjKITTz5zAFqnn4mWUIoNcih6KhRnTsILWfp3vWQwJis77hDbps2O3TdnqqZBT7XNAfP5trUaPNRYNRCeogTXekY4TwnTpHBooMda1L1QDkhYNOVWNWxJocexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXJsQyjz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70bb5f71f31so8336366d6.1
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286504; x=1756891304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TokNB2bRsR2/8TfbgHqQMAf+PDOGibFsscNCc1T3i2Y=;
        b=DXJsQyjzv7bGB67WaGlP/U/Jn9ntzRxhpvuLco63GLMqt10RaqmkWdstLTy6jfgqDn
         eVvJy58229Fq9GoFAgm3/kxh8dspGIlwerg2g5RHKReYgevwy5RV34xhwDT7Zm9OkgnL
         aT8g+vLbEx2CUXSm3GPNIy8E0Um0s/0O7D/nRcXnks+Kify2FJiGhJ/GN3rl1eLbXVJk
         NUrmiiCbQi1iGkcbE6TOSvTo6IFavxxMoGiek6Pg54wwAmXkO1sdMxPJqGUcMkvEkGXh
         Pr9f4MjntxVF0CQCHmqz1NuKV3dAAo9J2N+l2AyKIahrarmcdCbB5k6Uzt1P5AnDs9Uc
         HWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286504; x=1756891304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TokNB2bRsR2/8TfbgHqQMAf+PDOGibFsscNCc1T3i2Y=;
        b=iNrSFftxMKybxawNKHX/shuG6TYbU5PdnfIbF6UEJPcf96fAg5fLNJWXgFxWWBFo7R
         Ylz2sOhr2Cr4pJY8S/lbFkg8MQJojwW3cACWdoz/KZNZhxXZ+Rpr+dJ0hesQzUn2qANN
         ubgiYI8+6WC9wpoAQg//0Dkmmtk5gRVTTgjx7bKHjBmwNpxEZx0Ubm0lHfSVkz1+TfnZ
         IA4ty7rCNv4Z9HnmNpZw192GSlJNZTHLML8dysdPvlYnhUOhhWiPQbufq9ue0uGjydzg
         8umcFY7M6jENzwRqEUxceylEhsiPEpWdRiqMdo3KpWOpJTRu4colQ/fUuSBBB0Ldp2Td
         GrrQ==
X-Gm-Message-State: AOJu0YwdsFo2jMKCyzf3eVcZelP48/XbcqG4otfbnmtf78f08Yguugc6
	OXD2dbHN9bZubWw6UrmYAa7GRE76b1AMLST3zXtYQy5jxNjU2ZZwdCaCdfes2Gz8ebjGzjiDnwK
	lQZUrlYOxgmzsWRpZjDaeQ6PSX+gVq9MAnOVeYPOTosrrDJ6W6RnvtyDlcg==
X-Gm-Gg: ASbGncts5xwWrawkuYmYFksUX13uaeS4gRqhE2cn2iMEdo9FoPswPUeTSvcWOxAHIg6
	b1srIkVrk1SO+fJK5TtrAPoR6DJmpKQxHBtf7JhkDTT+flpIHfTLLf12W1cIfkM3h/SvD2TQDjt
	eVBSz3o19hWw7pNCnmbvzdND4oZJeJiNDAW8bMxkKNUFaHtzURY6xGnKeR8anc2lwMTib5ER5kY
	L/Er7S+WJFJlNVj
X-Google-Smtp-Source: AGHT+IHRCD/JU20GaEDsiDJhdDH/JUKzDUt65iA63JTM/WPiGZauyuzKZ1lvNdONWuPnXHyUAwIhAWkdWHIzEzbCdvI=
X-Received: by 2002:a05:6214:2602:b0:70d:dcc0:75e with SMTP id
 6a1803df08f44-70ddcc007d8mr23662316d6.4.1756286504325; Wed, 27 Aug 2025
 02:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110924.562212281@linuxfoundation.org>
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:21:33 +0200
X-Gm-Features: Ac12FXx6SLC1LrRxF2iJyXQTbryx0aIJgs-VszLB4HPdRp05YybesyDgvF8jLqI
Message-ID: <CADYN=9JypMr473i0yV00bwEkOyi3hgN+q48+e+dEhikqPYQVYw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/523] 5.10.241-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.241 release.
> There are 523 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.241-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 5.10.241-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: d8db2c8f2fffdb163fc985c8f87a2847f3ccd4b8
* git describe: v5.10.240-524-gd8db2c8f2fff
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.240-524-gd8db2c8f2fff

## Test Regressions (compared to v5.10.239-210-g2067ea3274d0)

## Metric Regressions (compared to v5.10.239-210-g2067ea3274d0)

## Test Fixes (compared to v5.10.239-210-g2067ea3274d0)

## Metric Fixes (compared to v5.10.239-210-g2067ea3274d0)

## Test result summary
total: 38319, pass: 31293, fail: 1893, skip: 4967, xfail: 166

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 100 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
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

--
Linaro LKFT
https://lkft.linaro.org

