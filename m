Return-Path: <stable+bounces-200059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97974CA4F44
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D12B31342FE
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CFE354AC9;
	Thu,  4 Dec 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBTyVwmc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18442F83BE
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870956; cv=none; b=KnYAvorA9IqKjr0e7zzHLBII+c563UGWKJIJezDbyMuUEkpPv4Q3zCQNslAY8M/tw9HI5iVtXI6SEvItNhu2HIIIXb6V74a/Qdy5BZxF5ywZfACg4oBqCYAuXKuIn+RxhK2IDsmh9t98pCSJ4x0mgX5/5Bm6jI7RvCM9N40GEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870956; c=relaxed/simple;
	bh=5vLgtYok1A8ceoMP3lg7slRGOGBZ0jrvCBTqvED1JBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AleFFR6fvyIa1vKypFef/C+OEeHsONs3zmGsA8GXNMrmA8dVjUljrvlKHIy1QviMjtz2q/HHD4HZNZqFWC5KdY5IwHYjV5M/EYHC4kaqvQWa70h/NNdH3a85t0DBUCgCMCUvYT4PmaF1ITu6WKvPNdur8+62dY4ypADCA29u+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PBTyVwmc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso1112789a12.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764870954; x=1765475754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3c4WoOG20J3VvX18sn2KxsV9WDaKR21PbQ36MIoHyA=;
        b=PBTyVwmc51+25xdr6P+q7Vzr9HmDT4hxRZ8oAn8QLLVe+1kLglHelXhz+4mX2Fw9Jf
         SMAkD8QRsHyRuND0cTQaca19ejPEDEwzar1PTfBQTl3Z4rwYlEC3UqohWijXlEKWthIN
         LJDfz8QorT5hwlY/M/JivXKG84eBhwUfyII6+baPI+eg78R/G1gHJntV7EEXeoHxfHL9
         hbiGzTRjfbcETCfBwfEaFRQxBSvSio+3U+zXHu3P9R6c/s+iOpu0M6mgR88SrMLCx1sp
         4DodrXubKOK8BQIZ9YFD0xNCsR5bc9PXB/m6IeCeoJjajp7zypku84FtZ9CB7N56kMZS
         FGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870954; x=1765475754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3c4WoOG20J3VvX18sn2KxsV9WDaKR21PbQ36MIoHyA=;
        b=T184CBAM5C+ncXG+KSc8riDZedGqCpehB82hNv0+baqJf4R24danytoWrDgwBJs0rs
         kyhEu4Ki31vcGHe+yiRDayEa2tC3CVUOGOwX0Wg0kZ7ZLmdgYJjc/muYL70JvmcJwJle
         FixAk02SkHEkaMZww0LYLqXGaq0PKakYvo3LEvOPGmRMOLBwDx5dP2BbD0TMEgev5XuP
         i2uph03WfKp61BgUzE2wWHTVvUEHnd6h3Z6zGFseiott64StAfnG5+cy8Q0PJxt922UY
         MXgeO3eFUBQoayKwzzHRAsuzEJi1vJHRPS37UeXFYBfpgW5Y1D7qoDPGRmuRwv8PeEOd
         kAaw==
X-Gm-Message-State: AOJu0YyhFO+PxDMuppimnl4adlX8gPaSq4GfZLjCpF7ie2JL2QJgG38h
	GZ2gdDAz/rnFWg0zrBWONXBRiXccjQcZR47Bh8oo44OT2ox26HVpHfVG5/CGpe+Ep9vdsgNRXYP
	grIEmYlBMev8/24F8KqEPdw36F/ksprkc3Vls35dhoA==
X-Gm-Gg: ASbGncvsxUugS+8mtm/SGE2g7EdIvas5PGu0P9VU8eQjg2xPiQslozdaxmfnFINxTXp
	mAynHu/foZVIfZJbC68MuUX7Lwy18Sf5Dypn5fuH323kcx0VepQa0LvzMIiF6INK+eLlrL7U5PY
	oQDMD8v4qUXO2zTsJxECPhyRwnOHYWOJL9sHsud4S6r5DyK5m5ZBTr2NVmnd18hRmgLUWxLXZH/
	mOie0Ihvbdax3M8CBvhXfUorSrwfH0rX6PlUTsB2L3hlndXE+vaDxpJ+W54IuuEbNvmCOweIl/4
	T6O/GbzPMn7h4g2Ri41ESJZT5KEq
X-Google-Smtp-Source: AGHT+IHCerma86MyvJK9SIrNon7cU+mRDt57gJnpXxtskmuXTz7OowKZyHDV6eFnHDPTqEMYFwOAeT5h/i4kA3917fc=
X-Received: by 2002:a05:7300:f403:b0:2a4:4e40:7c89 with SMTP id
 5a478bee46e88-2aba44fe0ecmr2654885eec.28.1764870953779; Thu, 04 Dec 2025
 09:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152336.494201426@linuxfoundation.org>
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Dec 2025 23:25:41 +0530
X-Gm-Features: AWmQ_bn8KWrUmUf22xvnCznWOUjCV9YFp6keyqaUF1hgEJJzjp5DWV4V9B-mFl4
Message-ID: <CA+G9fYs4g-3C3UihfxzLzKWsidKaKJh8usp1gJ9_A=oTRyP56g@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/93] 6.6.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 at 22:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.119 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
allyesconfig build errors:
 drivers/leds/leds-spi-byte.c:99:26: error: variable 'child' is
uninitialized when used here [-Werror,-Wuninitialized]

allyesconfig build failures can be resolved by a recent proposed patch,
 - https://lore.kernel.org/all/20251204000025.GA468348@ax162/

## Build
* kernel: 6.6.119-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cca93798e4cd9365a29b85a0d56a0332912fdcb8
* git describe: v6.6.118-94-gcca93798e4cd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
18-94-gcca93798e4cd

## Test Regressions (compared to v6.6.117-87-gdd9a47301c80)

## Metric Regressions (compared to v6.6.117-87-gdd9a47301c80)

## Test Fixes (compared to v6.6.117-87-gdd9a47301c80)

## Metric Fixes (compared to v6.6.117-87-gdd9a47301c80)

## Test result summary
total: 111140, pass: 93968, fail: 3457, skip: 13425, xfail: 290

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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

--
Linaro LKFT
https://lkft.linaro.org

