Return-Path: <stable+bounces-180528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99884B84C9D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483ED17F317
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65B3081CF;
	Thu, 18 Sep 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BY7NcnGV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7F3081D3
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201965; cv=none; b=CtoHozdWdUHPmt9og6VHdtaQIsMJbbaUMq6PTpzSOW2w3YQ5jGnRuE95eKZldZWKv8EBICZr4guGTiQmJrZsHcwmETitYiE507XI54zHjbTL371G1p2DTGTbEQANEsLQ3bJjuOtYXeGSEwEznULlyRMqqyjjczgYccb6ZhG5jyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201965; c=relaxed/simple;
	bh=sKKGe4udWACzWhqAdi305rOKksGfjETdgSrUKdv+zU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDVQ7NMQXfl67GZOe8byiNUR+BjxpCx6DFhlMAkuiCqPdjTHLZrq23jAXr7/ag7Bu8m09t+/guI1/z4G613rx9lRNIyxSh4wpvNyAroKal13vzI2Ml0vVXlqbZdNsGa8QYrs57flXmOGGO3rzSPUVi4xZs8MRLEVDCFQTTl6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BY7NcnGV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-762a549167cso120836d6.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758201963; x=1758806763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZqMt4K/G+aNuVVlKY6Pziorek+/gEUY4hP1jRsabzw=;
        b=BY7NcnGVq1gXUcZn0qXxKfl4stNoOGEjWo1Ho0DiPIhZ0LXdw2a5zrAlFn+aU1UZ13
         enlue58gBD2QIL+kpkA9PMhMOETjVOy/kJUu7DtIuEMebJJGlee9ymuiLo7sAt39ginH
         mv8qzg6m3SeA7jhw83vt72WLxG+z6CILFl/Q0Fktr1lZB8b4eH7X/0xtxDipplixiwoD
         TNICIL2LbNBU1CmljNSwFtOAX5QQsLNGRUOOx90F/aCtEl0eqynK+NJJK5kIFxNuy+wH
         uX57rkosFa23KbloaTu05z/G6LLhXba1a3Es2g9RWrwCH/qwfSSJjgVAJa5+BWu82cjX
         FegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201963; x=1758806763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZqMt4K/G+aNuVVlKY6Pziorek+/gEUY4hP1jRsabzw=;
        b=OVfua+e5rgZ06d1Oouz+KvaTOw6Vh3NBQ0JYqyBnG+XZh30YBFGILPX7E4NaUETawj
         mCvOuIX8JynS8STTdil8dbVRrsuVwHpwVjqSoL/f0wq8claY8xVY/H/9UgqhGkbAojxj
         j3F7RbJN6pHSV7eS13h+r9lj52pB3P9C11sq8yvPT6yvSXPkNXugpksPruxO4Hu+8n9v
         JCeuPuwXbbgDejFKubSKK/GPSY6qCNpX/m9qts50LUyyMwH9M0OoTrdqGhU3VhWcJKFA
         G6k64N4FfAfYJFz9Lj3WsdlCD/kb6mt7wRQgTN2QPJlPrhrFJqBjWKhMz4kqE67IdE/8
         gacw==
X-Gm-Message-State: AOJu0YzW4BaZ+Nd+CBvnoO24NX0S0vJp1nn3DF8MC8TS9XccqJSZztFJ
	5MvlWWIISDd6MqnP1q+8nTHhFbwJ0J0W5341AWvVbSeNwI601eTnRf1MCKwPf0BF5p9p+BaJK04
	X8ACBpwBcdbZIzS6UyE0kaCW9zF1Tgjd5rGqlnL0BRA==
X-Gm-Gg: ASbGncsojPMX/ziblb1mBQjgPtobuz025AkRmsCXY5nIWbc0gLSVmXO0ukIPBHeaV8/
	TeCLkeQ86+okKjRikjIebE68DBMcKm1OMD+2usccUflsvvMGS56+A4sX+GDxfkT7zBbn0AYPIrh
	qB+jEZXoam0Bpacgzq9R+qxQTpO/V6rWtTnZkF+SADcTJWR6BIj4PLkzCkL995D9fR32Ilnp3V4
	zIySg6td13xoYUF4Iqq0KoBipeNl9k4dICpjuVey2HF0P6OFfyZRdiYtqM=
X-Google-Smtp-Source: AGHT+IEhGcjXIq5juHs+rcd7ux5juyXPqiBwVCMB/GGE7FVWIgH56a3eeP4+Bht3k2DanWRLSwnt88hARH5yBKgUW2c=
X-Received: by 2002:a05:6214:cc8:b0:784:4f84:22f9 with SMTP id
 6a1803df08f44-78ecf30352dmr42536936d6.7.1758201962847; Thu, 18 Sep 2025
 06:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123336.863698492@linuxfoundation.org>
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 18 Sep 2025 15:25:51 +0200
X-Gm-Features: AS18NWDwdwAnr-M3-pDOPzu-5opfFPc20llgS9na2I9anw7ECm274EbiWpFPTfM
Message-ID: <CADYN=9JK+4kiJt0=VrFYHPGZUV-7ruDnmfL92nn4oyVvrLX40g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 14:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.107 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.107-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.107-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 08094cf55442a5e155c3d1d56b3c9d88de791bed
* git describe: v6.6.105-110-g08094cf55442
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.105-110-g08094cf55442

## Test Regressions (compared to v6.6.103-195-ga13907443c81)

## Metric Regressions (compared to v6.6.103-195-ga13907443c81)

## Test Fixes (compared to v6.6.103-195-ga13907443c81)

## Metric Fixes (compared to v6.6.103-195-ga13907443c81)

## Test result summary
total: 273078, pass: 255191, fail: 5386, skip: 12149, xfail: 352

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 30 passed, 2 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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

