Return-Path: <stable+bounces-177570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F304FB41615
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B325B54822B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376C2D8399;
	Wed,  3 Sep 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+b2V58e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F12D8398
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883873; cv=none; b=VOCwya4qte6RUPj8I+jOn946uhVRVqmjU2qDeV04LqR+9Wkel9j0FmH1bUgF7dpS/9YHPZPV2+670u6TC26QQCdNHpAfp9RkZeOS63BNKYqrRX3eAu5Pj0S4pfcZjYioeWkdnFfJUdZpWavoxo2Gz5NfVWkhtMqu2adMMYfRP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883873; c=relaxed/simple;
	bh=UmRwMk4UyU9iF1L52qhq9eclMpOmDUwbEL6NkhJwQSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkQM7zZpbHlCVaDSJ7IBPvPOylzARudxtGoBnVSfWoexRLKLwJtgnPlgP+t2uVkzLuQNfSfHr67MieOFdM2+tcyWcSfMLhKE/YgoRGbQqFu0b+uTN3v6TEBQcXl12I0XA0Sn3aCUR9uGZG2nGHQwiuRzriDODOaArHz2DOjdUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+b2V58e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so1365342a91.2
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756883871; x=1757488671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtZQk3qEYaGrYFmRuGVls3E+sSCgFoBR1bXzERkWFbI=;
        b=J+b2V58ej1WYdDXwGSFuAbVTbJXn2qLvSi8EVgcuDSVA6PYoGy+hSsHZ4crP0eNg14
         nlDzwjgUTV8AXbBHwRbDx5X5vhYnV2kNroRytXY3tK37Z0hppbx5fDXpO+WFfcpsyxCJ
         N21VMRblw7iSN+FmdunCIvDZ54QGQKtjzOPyZFcnYza606Ch5npoMKT2wMVyAf0/rmYj
         iy4wLHtNNCtd8JoAcpAOz0uB4zoPeiKTVE+T5pd2vxe7CSpZd5Q8Y7NRYZYdbWrh8u/g
         Vj6qJHOJEm/b72GO824Fn96/XrzpBtAWYb/zE0DmWspC4LD7jDPHPn7BouP3igKXe4yu
         uURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883871; x=1757488671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtZQk3qEYaGrYFmRuGVls3E+sSCgFoBR1bXzERkWFbI=;
        b=WH/FyGLKrFjod3aaYUbTt2L5RyZ9zzG8K2I1Bzkzk7+OEYc1PCfMcKTrnVA98TTkqe
         3CqY4BhtmLMJYm2H2nXY/5zP7Ktac7EkaQCykq0kgk4RIYOrTfEh4l+qfZrf8E+ok/tr
         2NhycwW8Wh5ppU5G9LyT5eauidynY+KcqfAKTnlfWb/yhhA2pqaJSdB0et0aaxEPxl2k
         fi08wsV3UK59nzleHUKsQ1KIJcMupddwfhbNc+MABKJHuKbMIsIIyF55a+NmlSnVe9VE
         DGci63U6NmJAsDkI4lpN0xykpayukmr1UPT/SUXl2+iNa4bxGwCP+XOg7bckc72UAErw
         u6ag==
X-Gm-Message-State: AOJu0YxvOCeY7e+rOdH+Q/nHJ/yIxYJeLocMHPV5OraDQAz1xwci3+i1
	opX7Saw5/A9Hww75lBaX+Z9xIZI1uS01in3CAPLh8AcpGCmzhDmWtO4Gh+BXGXUyaOtFyRi4Ndr
	ONo2YYlKyuSIJvU7ymX11yLq5ncoDbKDR911EzJ33PQ==
X-Gm-Gg: ASbGncsUoxJrcrQlrRbTPrwPn8GHhLYAr+iWB6ZCOhAOhYB6TaMnYUY7inY/M1+DUhk
	O3DJgBa/7o3gOHDG1JnXYp67mbFenkgheEsQF4nXkWN0xYRvT+73bVIw5VBEXgoNx59SvdR9qyh
	SlFlqI5FyO4075HHetyhRiK+vsyyVEOxsim2lesiWAuineTCEthxCJffYpOkMLnuAz3Cys9bSGk
	bNLZUd3QPv/Frct7RIvWokdmAFPWmIOGujoXlhzSfsA4Nm8fr4=
X-Google-Smtp-Source: AGHT+IHbC2eWGnJAQSmz8QCetFm2ywFgVLZ0FazDkS4bKQYQIfI4IWjdRDCFy0BXSLm08wp/pFcKC9G3amxy2x1vLgM=
X-Received: by 2002:a17:90b:4b8d:b0:327:c9d5:257e with SMTP id
 98e67ed59e1d1-3281543c7a0mr20454710a91.16.1756883870836; Wed, 03 Sep 2025
 00:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131948.154194162@linuxfoundation.org>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 12:47:39 +0530
X-Gm-Features: Ac12FXx2JI1QpukV4Lu7p9dVUayZlLzc7S3-kKnWthy6XbZR_LyCoaVFceYkR08
Message-ID: <CA+G9fYsc5L2CHwD26-+ZqcCyDPzxi3f9Mc=s11QEtcguBRMfJw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
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

On Tue, 2 Sept 2025 at 18:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.5-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6a02da415966f62533bff14bd579f6866076597d
* git describe: v6.16.4-143-g6a02da415966
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.4-143-g6a02da415966

## Test Regressions (compared to v6.16.3-458-g2894c4c9dabd)

## Metric Regressions (compared to v6.16.3-458-g2894c4c9dabd)

## Test Fixes (compared to v6.16.3-458-g2894c4c9dabd)

## Metric Fixes (compared to v6.16.3-458-g2894c4c9dabd)

## Test result summary
total: 350240, pass: 322942, fail: 6798, skip: 20500, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
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

