Return-Path: <stable+bounces-107842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F66A03F64
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49443A058E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D51EE036;
	Tue,  7 Jan 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUf4YFCV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135831EE032
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253429; cv=none; b=Ob1wAfDRpu8g3KMVRwz876ouYjQLGwQLhnzHRbkKwJgdoJd4RW2kE3RpjqktyaM4LGezJoqAh1hOvTzGmueJA7trbjKQu/RcveYS2elWEFKpNLIb2j5Fdyyyzq7zAMN37qLsMtUbi1p+edoTKe0p0ZRHM2zFAgAqruI13F701+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253429; c=relaxed/simple;
	bh=t1n72OseNab7FuyJhepxlJi2akVqhRVK6GPd3nDE7fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFudMQHcbhYWcwqEU2jcV1OUpT5DaP3qDxISn6g5SdrqybdOt71MoI+vG6cLnHPOmxicOBR+fugu+elCHwP0MPjQ9FTgP07tX89YC/XQnXKk+YeCWUclxw3x806h6j3sQFfb/nhCAyBReN0hG8wZ98tMCSwJ82HRHMZOQ0RW31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUf4YFCV; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afe99e5229so4358452137.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736253425; x=1736858225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIlTnII7lXnwEw9J19XvQRXl5owerrmaRqUBra4MQiw=;
        b=hUf4YFCVtErwXPZF/aZan5Cji8EtWeskGbQC/TUphmI8F34ccQjclnPLp9ihk0F0sP
         Y64mcJGVfssrJLiDGFMKrBKX9E4jNwvTjE1hkZ3Q5xDKuJdVWxWjgdf4yPMaA6nW5mQI
         bqDHRnEqxFsBHqHjunOgZjCrWs0HStOQFf7LQyROmcutRZuAHznn1ceFixhbnWVAjuXe
         gFuBAvczJjHmhHckVYfM3wRSgb4s9d43q7kcAXyiL6KnUbzJmG4qzE11w1y8fLgagBu/
         BygPSEMBDUvRr6XhTgIEP1ATd01/ipqRn2OLGatwStEbN9VEQALJv+OZ1zeyN1gBDsJE
         lqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253425; x=1736858225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIlTnII7lXnwEw9J19XvQRXl5owerrmaRqUBra4MQiw=;
        b=jJwcFyEYtaDDsaOxVZbKgcdmuOil4OrFeN8HqsqBv9mJ8Dzq1t8jKCj0F7cdTVD8jP
         xiDBwXTHSs85cMR3h+4gsECbSYA36oKnQrQ1aDBplRY/yQbfKMoWkxSUWPaV6e8hjb5+
         eOQ2K7H/FKABAq0CT5M8BimGpe08zClCT45etz7QQv81O5nv1dIzfPfk2gnyjJVvRKFG
         mc05F46Jppo6JPwHmVo2l+GEb314lcCl8Sg/JbShaDs8M9N+4+PIg9QSgGItaWdBAipu
         6uEPLkAOh8RXV1EoQu3MJIS9hPZPubQfJekfr/tBJNbMrUVsWyBBdjXPmNSc3z875EIY
         Ww4A==
X-Gm-Message-State: AOJu0YwHeEH60iYZbaAkxDo+rmoMGFWsykQ47AhFlnU9/gMm2qygt28I
	oenDN+4nax4Wfglt+GEALEInvaNM3cXDcoe6d2ntVuADewv+P4N6wwRO516PoZbyfPc6VROtuUr
	4qWaeaRtxEWyj2Io9VJY3GOGCg39KmcKw4gOrRQ==
X-Gm-Gg: ASbGncuaEwmOI+shT/sxhDSz9DeYuXMsn6oirJWqezaIaQ0le9+dPDC5iTveFlukpGx
	nOSCDaV12TNhyZwCWvULt7KO5QaauksSJxI4Ewuw=
X-Google-Smtp-Source: AGHT+IFXRUdS38Tu+KbeKP8zhQYDaKQRDsBp66iFxxXtcnLzdoa4OcdTycz9efyEmWJMFz48X9/u9Ze/uNpldv7b9o0=
X-Received: by 2002:a05:6102:3ed4:b0:4af:a98a:bd67 with SMTP id
 ada2fe7eead31-4b2cc313aaamr53643688137.3.1736253424942; Tue, 07 Jan 2025
 04:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151129.433047073@linuxfoundation.org>
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 18:06:53 +0530
X-Gm-Features: AbW1kvZPVmZ0nAESpvurAnzQbyjpI7HxHiK_qTPQKxCtFxBl8Gz3ViwtpD3IB90
Message-ID: <CA+G9fYusD4gyjrt7AgrUUbMVdW5vpiKx6vO4NK1wZSVwBohtQg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/81] 6.1.124-rc1 review
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

On Mon, 6 Jan 2025 at 20:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.124 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.124-rc1.gz
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
* kernel: 6.1.124-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 88f2306b7d7493dc9a6aaa851f2983532fb5666f
* git describe: v6.1.123-82-g88f2306b7d74
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
23-82-g88f2306b7d74

## Test Regressions (compared to v6.1.122-61-g519f5e9fdade)

## Metric Regressions (compared to v6.1.122-61-g519f5e9fdade)

## Test Fixes (compared to v6.1.122-61-g519f5e9fdade)

## Metric Fixes (compared to v6.1.122-61-g519f5e9fdade)

## Test result summary
total: 114042, pass: 89304, fail: 4717, skip: 19888, xfail: 133

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 17 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 36 total, 36 passed, 0 failed

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

