Return-Path: <stable+bounces-158528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5BAE806B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE347B16AF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F92BCF6F;
	Wed, 25 Jun 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aT0USNZ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E22BEFE4
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848864; cv=none; b=ERoZPemhVtAd8LmK4T0Y/1S1CZerqWtQ9BHAfgkAHvUmzS/aAbYhZ6uBZj175Bj3W+9tm1o+XgYNMP0ZOePUBfgULJsRWwx9KLkf/5oVXQcFLT0nlFmDAG7xO2Y9lIunb9BIhLgUvtMmEuqbxfRtNnsVpXpj7sjbLUAJn1ywjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848864; c=relaxed/simple;
	bh=oWw3YvvIIyZMO9LMr45beiGm0PsyuB9vcsoRXkosJKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqaY/CdsN27LzhYjKmCvxlTcvFXuASfpDkBZpYXDLHwaISawmVnUG74Y0eUjHEtlF5/vrJ9jNtA5eBvlBJ6eIS6Ex/LqKdJvkst5PU+Gs+mycOZwYBY8x5VORX3DrYkNsx0pp12RbaJhI8h+H5Mcl0yz3C3ksSNcfb86IWLZqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aT0USNZ9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so1574822a12.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750848862; x=1751453662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMQOsT+mdqoi8lnfK5N5XyAR9UzojfvCMCTObb86FVk=;
        b=aT0USNZ9ShDL/4pPXa6PzRTtQNlnpQmOFm/3u1w0msLeBHMotUl8fZ+okNois4hm7t
         YidGfb0Sbf3GlLqY6bdDbZAe9+OMSwGY7XZYVxMJE+qAenBVsOPLu/cQa1V3Hpt+qRtx
         RTeCyPHAibwQ1b5IenmXVjuhTpq41SAFnSuXUfsttAAo5tehnzD+bCLO6NT9JA5R90e4
         9gW5hb31f4QZfoZh4hCpnlWojQNp7Jn3ao/aaQ0Oajnz9rCHMYfKpE7dUsuAswJih03Y
         R1O0CDuQYr4aclSfVNSucr2SenWRpv1yHlNUhhFfqBUvIuSV8LvCwjQ3habQ2fyl2wCj
         s7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848862; x=1751453662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMQOsT+mdqoi8lnfK5N5XyAR9UzojfvCMCTObb86FVk=;
        b=nRquFY84gync89VaKHGy43DPrLiWxbFzh3h5MOv94T62hA8iMlShdpu8e2s2rCxxLa
         k22+naHov7nljXz4LWEM7GG5NcplJ0vogTaKOK0UUF5LkTK2mb/7wihIwxLxdvXHtfUi
         kKYAiIVZfSbfbYUAOyqn6SMPcbV2d0NLdstnhQzHEVU+AnTpNTtQmDaeUKdvT39lEDEv
         qYovPHiPg4IPb0XjNHCaHAmjhU0FU2gf+UwCRNEIasO5CAx4gi++cQYwawFCh5SIpIq1
         caJ7q/1zSi//AYNtz0RY5tH3YkfgSsuU9vgIC3gNF6QKByyLjf/vuhf6P+c8FtzxG5sa
         PAHg==
X-Gm-Message-State: AOJu0YycpSkLhrv1EFzkO1OTvvmObWaen4umEvyOFeRHjfw+6cczGA5E
	aRV9e6Xyo+22XYXm/LMMYWSWWS2lX7/z8a7JprmSoEY6d7ewE7+ElPMS+kV4kANyc3xATLBi5kV
	d53Po1xyJ0wpIv1MFVW+0wr5SAhV1Lu9uEXuLh5uzjQ==
X-Gm-Gg: ASbGnctNsospSXV4gpRtYY9+RzEeuovKxFRU2LoRhpT/jLK4wzX0AvVYB5Td25QAzqU
	uw2zxg9GNM8LYaj70C4x9r/zoggKcJ1iHAArMc6Deat1UGWibl+Id6Jn0mPvlXJ42FSX2MoUmfx
	/QPw6E+MU6NSaXZB3rx2WwaUO/8bnb8lHE7WHtUbqyUHfLk1G2AMwGApM5eKXj752HsxLCaKu6S
	XHo
X-Google-Smtp-Source: AGHT+IHiEEGI2cB5HHq+2rW2I162fZGpGjKdx9vFcpygnRYRBtx9ITlyUhy0ssBTVpCEGfR518CwQjoRlvHR7iSKwUs=
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-315f26192efmr4507300a91.15.1750848861645; Wed, 25 Jun 2025
 03:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624121409.093630364@linuxfoundation.org>
In-Reply-To: <20250624121409.093630364@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 16:24:10 +0530
X-Gm-Features: Ac12FXz97GBM2balbdrYLnqrqpEMD_cJZ26q0A3b3jEWkftx66qzM1sifzdDU30
Message-ID: <CA+G9fYt_Z-Vtoan2z-OEoArWuNy=A9wwAoTyRF=G8zobZBaDvA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/288] 6.6.95-rc2 review
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

On Tue, 24 Jun 2025 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 288 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.95-rc2.gz
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

## Build
* kernel: 6.6.95-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 33e06c71265b793ab2b3f3358952f6995d09e793
* git describe: v6.6.94-289-g33e06c71265b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
4-289-g33e06c71265b

## Test Regressions (compared to v6.6.93-357-g7ef12da06319)

## Metric Regressions (compared to v6.6.93-357-g7ef12da06319)

## Test Fixes (compared to v6.6.93-357-g7ef12da06319)

## Metric Fixes (compared to v6.6.93-357-g7ef12da06319)

## Test result summary
total: 233901, pass: 212419, fail: 5723, skip: 15315, xfail: 444

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 0 failed, 1 skipped
* arm64: 44 total, 41 passed, 0 failed, 3 skipped
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 30 passed, 1 failed, 1 skipped
* riscv: 15 total, 14 passed, 0 failed, 1 skipped
* s390: 14 total, 12 passed, 1 failed, 1 skipped
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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

--
Linaro LKFT
https://lkft.linaro.org

