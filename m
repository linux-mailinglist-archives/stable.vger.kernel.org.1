Return-Path: <stable+bounces-176482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B521FB37EDD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DE336860D
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EACD340DA6;
	Wed, 27 Aug 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNc8qgNh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6F2F60A2
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287042; cv=none; b=NXZXgAC9SL9MfWLc8F4JUeyZLYAIMGZTeBjmKdUKd/Ky8E+xc9B/mAzPjD7pbDVlFuAUjLEUoHI1TEJ5LTWIMF13cro34CE9XzOxM0QFbu3arf3xgXs9TaU7pNEwD11cBfNAbfMs8jGRO0InT7Ut4sxoMrxaYbeoVv3NxoIq1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287042; c=relaxed/simple;
	bh=tdG6lwDqbuZN/AVud6hb++JrEIXzuwXpSeTEcSPRwQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnVBbvPnYR4luE1VcHF7gbM2oFX9VufwOosERaLu+BHj2ogAQi3Cch8h5702zB66dfqgo23u8IttBIBcRb6s8g4wCCBpSg2qjDgM+rjJUGlT5g8uVu+kJcl9pIvxc5EjyjzcdIKdNBFr9F+ny+m5aijYzZNe8SB+oOjJwO/Dnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNc8qgNh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70bb5f71f31so8347116d6.1
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756287038; x=1756891838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p00Dt79OtqQoegFZ5bdUUNG94Edo0Rx/ZyhTvrQlI1M=;
        b=vNc8qgNhD3G17SWb6ppCo40LvpvIPgsxBKCpGERI9U/aee3dLvn6v7YxQqYj7VKNHg
         Rf0UX9/8KreWrRm6CmHaoAdTMKuuyx2eT54ZUcRakjgeEP/pYIFtQiZOZGNEOo/IrjLP
         kHvdnImhT1lOoPfhY0UBcXXGcF9R9Mf0dLcCaDHkmSpp2m4LeRUjnvKLs8jDG2XpQ4em
         XyNaSmSHOnaT+H8CXL2jxp8VLIOlHt1ycRkz5gPA9WLNX3SxZ7MhvYfGfIvWUl5fVpyR
         afDG7jlh/NSSwDupy+IF6HtslR+TBsIIUcCgszt7QckXR/AvAbcKUC9bBFWMB91+kE/g
         K4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287038; x=1756891838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p00Dt79OtqQoegFZ5bdUUNG94Edo0Rx/ZyhTvrQlI1M=;
        b=cmfvcC0BTwK4dQmy2ee7Go3MNASTMCXYQTVaa42QwvkXDntvuXm3A3cDo+3uu2Igca
         MYBdlQH9AzAR9nUbeiPAO+kQCxUo+FXmYbeDUQOg6owBXIgCpE2uiEL5HBK4SfOJWpq9
         C+fRwREhzc+eZ8m1on9QaQRIegGIGg28B57vAauGGGtrfK1pX9RJT097kGTVSE/7L3fJ
         3FnDsN/E7OGkOKfFBHCZ1gZtcHPxBIqtcXjLhajzujHi/n/lSiwAjA3ydTU4jJVJPx4O
         FTxvX4v2vy55y7jqCc4R/y9PRDA8+WZVvFo3OBpJZCqtAPTiKH1bOdvom6LIJQTxrXlB
         WLMQ==
X-Gm-Message-State: AOJu0YwEaJ+JrDoeiqRnrQlGLKRVtn0U4c5OyD4GWOJQImY7wK8Xd+j/
	fAqgfCHxpKrJlE1Anzrvr11uCmRnMW0HMms+fhVsxzSWZjt2GWZsnfdwTsEfjwOq4TdMp/rkyG8
	MTGmmQyTvDIJoQ1q+9HmMO2CxQq+4pK6GMBpbyH6ArQ==
X-Gm-Gg: ASbGncvBUl+DEOffK0avW5g4ezPmi+rPyXkmbrGw8x36TnmivpL6cj3eU5svyM0Na6W
	+BZi2mnCwedRLhUclpQj0xiJRNCl1XSpWAoWX6eeURHslvO285dDhdVsVU/ArwcPjD94+B7PVLd
	Jw+t1BEHbodSr8OGNL/q9FgGwKZtVLGhkruFeOKjR0MipyoWlBTQCuGPOV8oBhEaZVdNxelpZNX
	/BrnRJsoJxdkiaH
X-Google-Smtp-Source: AGHT+IEwdIexP0HA2vYtTuFG+cmWr0/asWhdvS54qUEB5cX1KpPDhRdmpS66B3nEu6uVhib5L2CvrhCMss7o7yDziw4=
X-Received: by 2002:a05:6214:3003:b0:70d:c054:9320 with SMTP id
 6a1803df08f44-70dc054964bmr76720416d6.3.1756287038013; Wed, 27 Aug 2025
 02:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110915.169062587@linuxfoundation.org>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:30:26 +0200
X-Gm-Features: Ac12FXxJh0tPtMslPn4Ikgd1vLpYMc-s1M_Anx8mniQakPdgUznCnVh2ZgFl6zs
Message-ID: <CADYN=9JmvSQOxp7TtLj1UgrYQzb2k8tLz_V2sN7OS4wNLVG_Qg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 6.12.44-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: c7e1bbb3520545aac86b8bcdb924cd3a7d200bc8
* git describe: v6.12.43-323-gc7e1bbb35205
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.43-323-gc7e1bbb35205

## Test Regressions (compared to v6.12.41-808-ge80021fb2304)

## Metric Regressions (compared to v6.12.41-808-ge80021fb2304)

## Test Fixes (compared to v6.12.41-808-ge80021fb2304)

## Metric Fixes (compared to v6.12.41-808-ge80021fb2304)

## Test result summary
total: 333492, pass: 308486, fail: 6580, skip: 17877, xfail: 549

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

