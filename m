Return-Path: <stable+bounces-132041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39918A83926
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E504A0086
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428F202F95;
	Thu, 10 Apr 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkP2VXxH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B061D5AC2
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266340; cv=none; b=MEfGNrU4Pu9NCzX4r1vQnGxoMPqRAJQsw+DXsJ6IEodlp5/RqHZwfLcuxf1rmh7G7G2mCnHw8NtI36JzfZI9gxomU1JbKErle6GFXhWQ/moPfDZS7DTZcwmGJcsFDpBDTOtJFpCyJ42oNIB8HTFMgLchQh4xc9bFzyI0abvQC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266340; c=relaxed/simple;
	bh=aGpkY4O/3TbhmrBDujSrzkv1VCnxkOFYrMxit4qRUFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX3Y8KNJ/pXydCbp9cpptpU0UsgZcqxure2Z+Cl13C9vfS2PacvZsxit+EnNgxC3JYkDo3XiqGv6eGnR5brqhaOaXzAUlngK+wMEX2+2y+pt2g3dP+/nPZZDXPJaSiCAxnK1U/I5fWTgCYyWI/HVbmAU/QzG7nX8Fuo01PcXeyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fkP2VXxH; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so390041241.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 23:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744266336; x=1744871136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyNWqPKOQ9/3oQt9wRtOOs4tLD3TZ787ZZ5Pjy8pmfA=;
        b=fkP2VXxHMwWrp53nFCp5fb+U+XrjZTBpQbrhRs4ZTYkfyjKpei1JFRusgaSXQO7cKP
         +ZsroYOgAFns1mu9Lvq8iCITkaOB5Pb555HeSrGqAWb0ogvyKtQURLBp7BODz9E9Wv9+
         0tM1sxGqyFBhbPT9Dl4X3e38KuXdWJTCL9hn3fHGnsrEvwDrJCUamBxFNFxWpHrvYoEo
         Nl6qHpc5ZGgOJRf89jrwi9BUdOLV1/h54adKjXJBrRSgx5D/fu/FdoXBlRMVVINIJ1XL
         OQzxpIH2Ki5wzwSOsNKYeXYkD7/PMSqO277/wKbwD/gLEXk7Wys1BD7oPL02SgbNaMM2
         SqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744266336; x=1744871136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyNWqPKOQ9/3oQt9wRtOOs4tLD3TZ787ZZ5Pjy8pmfA=;
        b=EnJVnsGrCnQcLZrjh0wtntIZUPj9S2lmkDknRUprOuCthIR61YYEzwvOjAqT8/jJ/e
         3dgErfNPEa6iXhDGxVHel4I79nZ2LWpkN+fuYQ10zb7oxj7kq0V5R1WEnW8lPKcQYOa1
         Q68/I7jzZMJg6rTBPGIeq/NrIuBPkSKoacY3mdfSfML4+gB+/d/bqpeKFdwsbrv6CwB7
         vuGbuVCkEzp4h0l5YadnPBSj29ScKwUy2H3MeVcYnFccqQnHbMVjJoE3qP9dvZIZNuId
         0wymBlOg3Jx0lycIQPwLe4u1oVWHkA3VfLPsAqeHlrwMYbU5NEHjeWLN3jwesrvhCgct
         aI3A==
X-Gm-Message-State: AOJu0YzaRzHuJW4yPF6Mq/MPP/VD7p29XzbZZwPzK+QXN4qhsWZkpyZJ
	4MgaN9GKTpAAppJ5XvYv9PDsdI5JjG2YoHLTgro0xu2EgyzTsInSp9Zi99q2aqPwJk3Qs2Jf+vy
	CX+o32MGAcFmYbqtInrCmPq9NTbwfyVGHI+AYaQ==
X-Gm-Gg: ASbGncvFXMddLbbYy+Eyd/MBJDLfXPZlVnOpgFKli6o1ugwlnAvM+53zD1m7PxQYZSi
	DjdWeULYEU1BX6oIDoRLMns6D0Lj/Vp/NI3t/BAkq7oaKGEvGkfJLiZwqt+x77xU1a/d8t6/bbD
	T0pT+7tFZ87sFQAFbUbGfINTZm4RFoHiwCCSCKX5BdOH3g1a+bWGDekwzP1M+FLBUu6w==
X-Google-Smtp-Source: AGHT+IG2aNdsOXAjNvzpg7zSgl4b9ctMJGLb+z8eiGPuyFdtc8URMDmcUMZ8aMiJWyf0izLJvmAFLXZo1jsBoBoZ+OI=
X-Received: by 2002:a05:6102:5615:b0:4c1:83c4:8562 with SMTP id
 ada2fe7eead31-4c9d629409bmr371847137.13.1744266336159; Wed, 09 Apr 2025
 23:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115907.324928010@linuxfoundation.org>
In-Reply-To: <20250409115907.324928010@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 11:55:24 +0530
X-Gm-Features: ATxdqUGwvc_wcV22L39WBJ0l-_5Wti_pClWG4Nk2KEj2x_9XnIDbIyGu4SQml3A
Message-ID: <CA+G9fYt18c-W0d2aZOt3_=pryrmp211F-HFUdmHNb-Ew8DQjWg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/502] 6.13.11-rc3 review
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

On Wed, 9 Apr 2025 at 17:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 502 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.11-rc3.gz
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
* kernel: 6.13.11-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b51363104424dfb8b160270333b1af3057374b28
* git describe: v6.13.10-503-gb51363104424
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-503-gb51363104424

## Test Regressions (compared to v6.13.7-385-g8cbfaadfa0ec)

## Metric Regressions (compared to v6.13.7-385-g8cbfaadfa0ec)

## Test Fixes (compared to v6.13.7-385-g8cbfaadfa0ec)

## Metric Fixes (compared to v6.13.7-385-g8cbfaadfa0ec)

## Test result summary
total: 130642, pass: 103832, fail: 6766, skip: 19617, xfail: 427

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 35 passed, 5 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 18 passed, 4 failed
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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

