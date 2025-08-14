Return-Path: <stable+bounces-169516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70791B25EBF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEFE1C815A4
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7622E7BAF;
	Thu, 14 Aug 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0gBMjrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68E2E7659
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159884; cv=none; b=EwfurfoIZg1CJuTwT90QF630Dl+IA2ERlxPE1OBL4HGHAn2kfEDQD/uN5Wenmvd6SlgsdTQZBKLKZR9rZLFlOBL6DgrmKwx9/8xHVX+gxRZu9563OA05lO6CvQs47uu5ZWPZfEwQLBPmgotaYtLcLHFY4zF7CROhoroRNSht71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159884; c=relaxed/simple;
	bh=QRuY0xcssAqNzsjoe0+GUA8Ky7ufdADxvjC0vu3O1m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUBanJNYhbL12/9bH6eeDTBODHTm2ZLRW8sNg8Y1B+KlDQnZ7KOkOXifGF8FZz8JQPp+LzsPeFfzMpiSNAQ8J+UTgZ5B/YMSDKHyNPza5zdJ8+GRGa7Z/y0KuPTOPXgqyXyu6rSb47zoikMjAejdMPCsAaIwyTXxIHHjmxF13eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0gBMjrG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717563599so504425a12.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755159882; x=1755764682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN4ndrkgVneBhF71YXNayTVC1k6fq5rxQE8AAOWHWiE=;
        b=C0gBMjrGoGoEWwSDu9dlfODOYAQEXw6ta3mYFDeqUZenJBwikZtfeDUXTM4CkwM9sE
         VyNXWNlG+8Hpz6yS9+5uQkU1Cn5hxST1QflmH23bNR0BizP9dcji0dKdDucIbaZarXkU
         5So270KWNsJcSF/8hNGSHBRbK4XOCHTDf8lIsAgBz1awuAM3LhrFyqJvaxt8eJc8ZOUF
         Nm57lLEdCdmRHMSdkOlOUbOaCY13V2ia44Ua12HHCiqUJ+5SWiTiotJ34wxYjOUUESbC
         iabESHXFvmMiYmeYlhOmABe2H0dk4HL56Chz0s3aRMjDuNwACxritEreeMvTdeluoXQV
         /3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159882; x=1755764682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN4ndrkgVneBhF71YXNayTVC1k6fq5rxQE8AAOWHWiE=;
        b=hUQHg547wo4OyTqbrGR0gBLgKOoVy/wMAyNcHBvFAdZuIq8eZ6XcaJcTXu/e1NedUj
         R45bh6hb3ZVxKeIiOAeiifBxWmHs1Jw33fAb8z6MSfhMRc7pYLOePww8hUcw5u4ZQUsz
         5C2LcjoV+/Xt5bGHtdSG6KpmUGVgB/mjB9WjRg50BNpDq3AJznZoB+8pVdH0y7RSEJfZ
         a99JmTJNHiFLnQEEPfBqe+jxccXAM0GtJ+327A6NU3s8oDkHciiJsVy3nfTb7gsVmU7M
         Zn4qavyrYViXDiY47fmngQZXMoVu6+i0wIP/+gb/bL8xpNVFXOMEplX04IJGoO0jQE9M
         xs5g==
X-Gm-Message-State: AOJu0Yxuip3OY+NgRLh1CsmPP1j0wGeD/kxTaS2Zr4vts/0iuIAjZuqr
	/HsPnKA+yLcx/G1Jur01E3XpGuSEsC10zEqESZ3lmCfY7uFZZeUlIuEig2fLrDXFOddwOpWHDB4
	+affwLRF1Ne+sGycdhEbaOAbSDLLwNhBd9beEfaBwSA==
X-Gm-Gg: ASbGncuGvoQ8azEC98/IgylCawufJiJuhrd5iN73xVpVrIDXCCsXhce0kso5u5jHzrN
	5LuLjx4+ULpJgipnRGhBYeOo/dgtkhfKiK58gofCdfptuYxECdBVrbn3w7Ja91V1gGFBRdOz3pw
	hZ2uw30ec52phPsgJ28BCrqxga5Lk5kQoDR9Ikht/8bZOeFQ9mB/IvLlFbeUVDYsiwDfW7HpxE7
	387Vpq1nQSAw2nF26mn4Tu3e3g+uOumqE/6labcB9D0XZ4cnrAp
X-Google-Smtp-Source: AGHT+IEQ6olLFhlnuBt+suQ/HYvysyluDH8m5MsRBc9LHDFH2apZD3pSIajpR/6y6fisab/HUr4DU1uJ9Fx/39JH2o0=
X-Received: by 2002:a17:902:da92:b0:243:17a:cd48 with SMTP id
 d9443c01a7336-2445851f038mr40305795ad.17.1755159882053; Thu, 14 Aug 2025
 01:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173014.736537091@linuxfoundation.org>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Aug 2025 13:54:29 +0530
X-Gm-Features: Ac12FXyyGXeSA7vfnwGf0EzVOprDr4qz86gCpoS_15nupDMTeTdNSdzNao3uL0M
Message-ID: <CA+G9fYvMdJpO=qWHh0o0u7qeaTS3-=AF2FgtLgMbRuKQ_5vccw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 at 23:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.42-rc1.gz
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
* kernel: 6.12.42-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3566c7a6291d9602f9f443a3e97340103197f811
* git describe: v6.12.41-370-g3566c7a6291d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.41-370-g3566c7a6291d

## Test Regressions (compared to v6.12.40-118-g487cdbecb4dc)

## Metric Regressions (compared to v6.12.40-118-g487cdbecb4dc)

## Test Fixes (compared to v6.12.40-118-g487cdbecb4dc)

## Metric Fixes (compared to v6.12.40-118-g487cdbecb4dc)

## Test result summary
total: 308371, pass: 287741, fail: 6222, skip: 13991, xfail: 417

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 21 passed, 1 failed
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

