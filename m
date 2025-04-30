Return-Path: <stable+bounces-139207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3EAA5201
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FA189EFB2
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2BC2638A2;
	Wed, 30 Apr 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeJXU1HN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B711DD0C7
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031782; cv=none; b=H5tfkB2YCs3ffmbCkN4TL31J5SpPTYkYASOBrMQ8B0TrILBAEW8lz5SoyUtulDk+w/7XEkzvENE+t8pbzzVH/LNi+a+49Fv7FUU2ya1RRPfnEHwtYWgI5QZYgCb4XjxqgmfFJTxclL5Up5MMaTGL+4UM/cSVJJTIHU295YlYQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031782; c=relaxed/simple;
	bh=3rnUtBbGRrj2GtfIBzxXQYWs4cLaMq+FIs5BosSWcq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDjrzzL6iFyyvwRBOiqo1I1Pr7PsIX0rdzU2WehtRZTLPTUojzFCG69u0KOgFiESAuanrUMNh04043x/YoAakH5j+02ANgrmggeH/3OG+mRaP+lTwtVV/PvrRngnWJkCN4kMKg4ivDMxHSMAKpesC1t8JNCLCsd7ZvsN1P4HLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeJXU1HN; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso833349241.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746031779; x=1746636579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6wGEOSopeYQzjMpu6ToZD/+3YW6eIVoWLjM6+vWMm8=;
        b=jeJXU1HNLEcT2nYiWAx5SMxRKUIbwJSUUYqlJ7SwRVA6dRJi6NrU7836M/u8G8oq0K
         UGD/+gDI6Uwtiyujq2VtmWh9LMJGejNXNbOGt6LHrApw8UfuiM8+6Vz8E6xNVQ9ArAAu
         ERWBGfXWLxQd3b2bMwBZenRpPAy/PR2Y5BvOgardaSvPzU0MmqEcssdyDGk9NI7GWrkp
         SyCXeg2PI2PbyxYPqFRRA9Kig+pJPDzVmOkAfkWEx8QJGVwzyepucRfdNd+/w0FLWdJ8
         yJckLum1dWi291PFsDionYqDyXKNxEc3mTIkcyOuqBgqIH/982moUQuxwg8YEOSaYeUB
         S4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031779; x=1746636579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6wGEOSopeYQzjMpu6ToZD/+3YW6eIVoWLjM6+vWMm8=;
        b=MMKjmFvYS3BpfmVzXRxcAW87G+CrzrSiJGf8a/4zbjtlM25wc7+oumgLIoeP0vA6LU
         Ts0x+pn4/BYLcZiDI7pnjDBucWUyaCZgtH8zPzlbQFqhm96nwj6mKOjX6gORJz19q+7A
         TTay0XMX+mfbWLX405nfNEqK4odaGEqvjEnrDi46zzCchRQvUZWZgN5mY9sX6IJNzE4W
         dhVl80/DFnYgdgej/As7LFPjauFc1lZryc+28BcmjyaxVK7jLw5MJ1nO7DzdhOLApzfi
         hHKDvmasYvlTWMk4ITPzm5ieNS1iKyQgfL9w32qhzGW3ziguEOV34FCT3tmYzuo8F6Gl
         OBsw==
X-Gm-Message-State: AOJu0YzdnBHG8duHAKrM7YVUK3/RSwbJYyxBGdX9Hm1VESgH/y6vKjpX
	qoqCgQKnsGajc6eRd0X2AXIeo9sZcQVnsCEhwooqLh6w49bRbstX+xh2JmL/lV1oFvBagn/kzip
	FqeHMaIrJeux8ZKr4lM1c9i5sGagSWInTGwzemw==
X-Gm-Gg: ASbGncuEubiB8oE4HiwSLlUMhuoJ57cGgydmIjepFP9hGWW2f+xyKcdLanbhAN5yUi2
	ryxJIhlbKYwZUAWUQq8Tye+rHmbvTZRywdHR5bQi5QyOE1zf8gax6LBecrQWj9PmRtoHCkmLV+/
	gDQZo7Ut/iAGGUO7sXa2+wOMTxWpdaJkAFcRZu1vJPpL6idk1i3b2KU1k=
X-Google-Smtp-Source: AGHT+IHB9EAwLxpqiSSeqU27ovIV9mp5mBfnZNLtn0Kyqm5KskL5elpAVGIgTEid98G2EVBqt6/xAa/38um/Xx1bBi8=
X-Received: by 2002:a05:6122:1ac3:b0:520:4806:a422 with SMTP id
 71dfb90a1353d-52adbc88c7dmr243623e0c.3.1746031779296; Wed, 30 Apr 2025
 09:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161123.119104857@linuxfoundation.org>
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Apr 2025 22:19:27 +0530
X-Gm-Features: ATxdqUHDFBFjAk7YpA8kz6XQdc4Jmx2bsFw4-LGkVUjB74in0vBizWcCsZ4TzB8
Message-ID: <CA+G9fYu2_JCDFF+RtB2-nw_zcPYcXzNEMhZcM9cU6DcjHwTsTg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/373] 5.15.181-rc1 review
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

On Tue, 29 Apr 2025 at 23:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.181 release.
> There are 373 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.181-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.181-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c77e7bf5aa741c165e37394b3adb82bcb3cd9918
* git describe: v5.15.180-374-gc77e7bf5aa74
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.180-374-gc77e7bf5aa74

## Test Regressions (compared to v5.15.180)

## Metric Regressions (compared to v5.15.180)

## Test Fixes (compared to v5.15.180)

## Metric Fixes (compared to v5.15.180)

## Test result summary
total: 62723, pass: 47525, fail: 2904, skip: 11880, xfail: 414

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 22 total, 20 passed, 2 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

## Test suites summary
* boot
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

