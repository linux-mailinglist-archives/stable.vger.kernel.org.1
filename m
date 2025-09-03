Return-Path: <stable+bounces-177618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF441B42148
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF20417DF23
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFE2FE587;
	Wed,  3 Sep 2025 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3Wd+go7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F43002BF
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905605; cv=none; b=rxTjJXTq/tVvG4APkn2rLxImHlDqxvY/IVtwbnbbhcj5IbqSehIWAccEQF0kcK4n47U6QpafHsksWItlW+/EAB6j1u+uWCDfnel3kC2A+Zsd4vWaMIWULKWAB4JSbgtIhngQEYJevhpuWtObsRPqwD9tazrdGJve1AyNPt8uE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905605; c=relaxed/simple;
	bh=MBf+FNCGKxwXMZFLdgqxv1wJ2tqUK75/ygRKEJaaXYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj73V9kt4qEnm1abqL5N0VXRgZCZAPWEgkthLU9Q1t6/wxq9hqpBkrrih21Fs26JwgNV7z1DuH1QJ8ikl+mT8QmlsVuA3WffBcvh5Yu+TXhiYIJUEG6ZY1maNhBg2jNDlwwSyFA5Glu73gaigUDocU1nEI2dF2JCB2OHHFuV+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3Wd+go7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24622df0d95so49791495ad.2
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756905603; x=1757510403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNv0gNy0s2fPL97dDkfmI69n6Su4g4QO35nVtCIF/5c=;
        b=g3Wd+go7IOsGUhTJadcrXlgtX0u49ayGemg7ITi22IzLb9C7wpiqKhWoxss+RyYAb2
         M+bAkGb5yn+QEW0F1959n6Nom8tJmkzYTsqF7SbAZq8qSWaVyR+ZABrF97In9tHn9haC
         8ta/6TbJP1iLW0BjN/QhKD0rHVELUZACV2vVhtirRMbL0aazB0f05HyZRDNH0Biqk/eZ
         9nOO83zkPaWXXh/RiNkW86zV6uH0hQi/e6INzajKDKmgKmONngxerbW0H2NquiIbjk4o
         soKRMyKLRfCYM7DU3b4ZrxmGu5SimILhxz+ZL4ha64L3CJROAoKyjK5vaHVHech7hKYO
         2bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905603; x=1757510403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNv0gNy0s2fPL97dDkfmI69n6Su4g4QO35nVtCIF/5c=;
        b=sbBLASZecgI/SxfQrEyQv7udmB5KH1pHXnGyH6vHsDqVt1Ri1Q1haDz8RDj45PoWhV
         3rw1n/RqhWP01S95i44sCR7Uu0oCDBZWLwas5nsVRW5lKiqYq1ylpCX62kN6wTZM32Pa
         XXP46KfghDNkeYy3Jm777d4vIu76LmpFx8BHmn8Onl6tProZDwS+j2QNaO6eHNLzjUM1
         4qmclCzE6m8DPy29xBHqy7DDdu84Pyoz9N6xF3P/2RNavGHTsYQWUcI19OFuak0OjQEx
         FCtShwI1ySvL4DcrTs+OYqG4Q72MS2a+VggSOWywMsG0dZ7/Xq+KVBBHzwEOJW0/uZfN
         OPQQ==
X-Gm-Message-State: AOJu0YzbE3+K+uQqPlH+YXFmjNPVE39tB+dAqUonYacopnVVLFOgqFyH
	8l2n6vrPY02hnSxZgRi7CR9jSDGjWDuLgtDYnC3FEupoK/KjqpbypyGx8+tqBrJWf2cIWuvya5M
	+3vK9CPaxe3XY4Pm8KN9I2LqW5Cem5l7TLR1ZXE5MFg==
X-Gm-Gg: ASbGncvR3vZAT3rfVBEwz7psW0m8QVwUG+URgoZgiSXSXatGHJR/zxuP85hTE2Gcaeu
	gztUdFsLgg+0ZAS7XRZrAW4iEl+FkfdzjahRkX5V+0C4RQbp+TVQdTTdWxUe8ZgsJSdYMJGYPA0
	3i5SALDQGwMK07lw23aNH9TQo/ITe7t/qW/S7/t0fTB94C4tMNGlr4FvGaZL4VDQ2f5W3PluW8k
	39vVFQiX3WrAFT+CXJKCtiKQhw41bBS2bIGVEjGZhkmSaarcoU=
X-Google-Smtp-Source: AGHT+IHdTXE73KoeeFD67NGkxzug3Oe1MMbVqH+Kjq3Jcv+JioF9+0keLKnL4nXRSH3NfQ3WSa62apQ+FE2SJGMwrTg=
X-Received: by 2002:a17:903:1acd:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-24944af0f6bmr215296135ad.46.1756905602528; Wed, 03 Sep 2025
 06:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131930.509077918@linuxfoundation.org>
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 18:49:50 +0530
X-Gm-Features: Ac12FXyFlwPtRrrFcPyzEecmFta83FVyMG0IZbGUnmR2iHwzBgijBa_82EhQWLQ
Message-ID: <CA+G9fYshM788qKDL0cjYOxLJJy-1wd8RRB7Ky8weKA1QWWKvzQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/50] 6.1.150-rc1 review
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

On Tue, 2 Sept 2025 at 19:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.150 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.150-rc1.gz
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
* kernel: 6.1.150-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cdcdd968ff27439390868ee985f1a70f6d6081a8
* git describe: v6.1.149-51-gcdcdd968ff27
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
49-51-gcdcdd968ff27

## Test Regressions (compared to v6.1.148-483-g3c70876950c1)

## Metric Regressions (compared to v6.1.148-483-g3c70876950c1)

## Test Fixes (compared to v6.1.148-483-g3c70876950c1)

## Metric Fixes (compared to v6.1.148-483-g3c70876950c1)

## Test result summary
total: 226941, pass: 211392, fail: 4456, skip: 10839, xfail: 254

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
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

