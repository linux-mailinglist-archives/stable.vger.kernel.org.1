Return-Path: <stable+bounces-118422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC26A3D906
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5DA16C8B9
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72A1F3D21;
	Thu, 20 Feb 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+8mHFMh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577541F12F6
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051611; cv=none; b=ITYWECOZ4BYIROgCPAKfX2FS1YaCEJLeW9738SGtCP+IFUy4l6FIJVjchkRiKeWbIDiZy0sdcr6bVgd/XJF3DyFZBRhgu9na40cRUR9l+zURFeLHDuMCxmGh+L/VBoy04P5dxg+gHk0RaJ69Oa2hS+mULQDiXxxTyLzYXN438oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051611; c=relaxed/simple;
	bh=eAOfwsqQ8PG1lklb+kYxzDxtQNtsyazqKqe/WfuseOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp4rPpnIgSivdTDOAe/NfZas+anMjXcUmWA+vbW+QSvnY7EXM3G3HcYuiasEkLPHJl9FvzIMKAqBSSeQqY2663Dlx+zf9xt9e57UP8NXXYNDECmid8P74hd18s90zyh90bhSpNizA3VoBLhCeFHDrbH0pB81ir+fAItnLutzgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+8mHFMh; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86929964ed3so462373241.0
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740051608; x=1740656408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzgTSWeHSpJRGiFSifmTH+Wfxn1Cdsi8xpzMCpPcT9U=;
        b=O+8mHFMhTNFJcjs9ZFDCHddafJ037Xdz01O5pejYsPXsrut14I+A4bh7DmPwXxYg6E
         hzD8Gq71+/pdW7hudfqEIROQYH9qxDdem8OwIirwTiPdVB+bnAVqGde+fRJ/piD4Izl7
         KYGb9Yc11OqD49uzhcbgkHtohknZ9NW/gaszDKb85/6ulKLDkf3XmRBuIj9GHvJERuo5
         Mvxa4xzHcQH7YQTJKfoNtNDZGfIqj9V/RVazkv5dCeJB0CMXUSTf3vpcHNk18bnP9U63
         fIuhS5qYyj017NRp9ZbXNopNv2vMKjVNrGFKTvjo2SRZGHYrs1x60OSPtJQrVPVEw1zh
         s7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740051608; x=1740656408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzgTSWeHSpJRGiFSifmTH+Wfxn1Cdsi8xpzMCpPcT9U=;
        b=momB4olVj4TUIFSGRZNI0M/lCaI2IDh2xLRnZSrzgwnb0dgC6FT8hGKgmWpURrZR3f
         iJoH3LcFWQVgl1J9SJF5Agd3NF+qOhCLX6q8EbRxOFVoa73ldFhpZJWeIiIguKh05+49
         xjPvW8ca2+39wAu7gA0JNb/DCSAxhSAqUJ3DzN9iv7iwNsx7cOH4cDPxNBL8+DgzrsOU
         wrbsemYCsgwleeemOiL4WgnO53hb3BhJfckkSLRjn7cojvO353yLYNRk7YtxpXGcUWA4
         E5ID+dmkYGPRmpgVcxNP2jGY5IzLoy9r9RVFeX5zezqRkLLapFCehxCC+xhV0mFkXQXB
         h6HA==
X-Gm-Message-State: AOJu0YyonvCUNuQCgk7leeAON/Pu+zFRoxVoDABtHTbTR81OUcU6zFOQ
	Za4/iKTefrU75XZwEP1JjjHQxU5iQqrl76Yvw84zEexAD4Vic5gvLcYZ5RPpGdSivhF3X6KcPon
	4DT6sjAJe+Ki7bXvpZP0X3tnvklLyBfhyNhIw+w==
X-Gm-Gg: ASbGnctiKfRfnBkhXNCz2gqM6Ma856puaqAuSTTmHM6yAiIwLK2JYLl1RYDbq8ySr1H
	TDHOkzrnZCR3wUf3oWjU2se4v+va9qSm1w7pYiASOd9RJl5v8g38xzROiv20cd8lmMYRKdZIj9g
	/ZeBzW8YtSAx7JcKG8tsDuQVa2VBp6
X-Google-Smtp-Source: AGHT+IFOkqN2CGqfVZbis2+W4/1tF03d2S0k+uTt1KOsy6VWfYfx+gU8hHMLO3g9P5SaEkbG8ZS1YKhD1cbkBS1nk5M=
X-Received: by 2002:a05:6102:6cb:b0:4bb:dc3c:1b47 with SMTP id
 ada2fe7eead31-4be85c04e93mr4306655137.14.1740051608001; Thu, 20 Feb 2025
 03:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082609.533585153@linuxfoundation.org>
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 17:09:56 +0530
X-Gm-Features: AWEUYZn47O1F-ZaWjo-DYedUH1Zw-C39d2YCRlVT-7kJbYIWuc5oy92wQ18eqoE
Message-ID: <CA+G9fYuBdefC8Fmi7GZUGhj=fMEucoKJBi1E1NmHDCL_zFQj-w@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
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

On Wed, 19 Feb 2025 at 14:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 274 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.4-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: df042386d398b1dd18940b647ec2a78164ebfabf
* git describe: v6.13.3-275-gdf042386d398
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.3-275-gdf042386d398

## Test Regressions (compared to v6.13.2-443-gf10c3f62c5fd)

## Metric Regressions (compared to v6.13.2-443-gf10c3f62c5fd)

## Test Fixes (compared to v6.13.2-443-gf10c3f62c5fd)

## Metric Fixes (compared to v6.13.2-443-gf10c3f62c5fd)


## Test result summary
total: 63316, pass: 51057, fail: 1685, skip: 10574, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 21 total, 20 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
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

