Return-Path: <stable+bounces-132051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D1A83A0E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7273A3CA1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3C204698;
	Thu, 10 Apr 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WegCxNm6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8002040A8
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268263; cv=none; b=lrD4Y/KPML3s4VMU6qJEbcf8rG0cwbnBOcttv7ihbGy/TWX+Ab+N9+Nszf9iH/Z1VWmjQjkM1bw5fOVSomUNZI1KiFFzcpG7bKkmhGiHD2J1IOMQY65XzwY37GzEXPxq0EKXFDZjj/+cQa+EOZunaH3wxfm9rMrd6ZWUIeLnO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268263; c=relaxed/simple;
	bh=sTwsAjGY0cGXvK0SH9dMyP6DZMtS36qt5mtZ3fR9MlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EntM51motdO9U3HIKbe8OnMBy0RTfgtY6jF9fIszXFndqYakaqwYhZ0OM0lqH1yjIO8IFXxGFfRGXGHM1r0yOLCB3h1q1FbMcrpAW2CThQNRDyiBuyOvEAae5gGMd+oAUV+iZQ6vQVQiI/TkEaLzqGl5Rv+UT+jAbsshAIByNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WegCxNm6; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso179936241.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744268260; x=1744873060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARRmXRJ2mCRgXoILVP1SStKYj4zjnHUfBxpKz5KWgHA=;
        b=WegCxNm6ACIpSo0rXU6oya50pl06wvga08zSKecB9dQoq+OTKuFDPN5VZEKykgZUsQ
         flzC2lZPQnJw9OhsDkKYxcrbKQxd/kpmkX4qCMIDYHNmp/4qLUCwY+E6vvK8wkayBJm/
         kIeVuyZkmD6VDNYefo4wkAYAblgUINR2oUbM1QmXgAJBfXjNVX6RHf0rI5D57AGn4V27
         wEGXP0VxT3uGIs9umt1EfqBCozGXmp8wvaNsbnHK88UwG9DNIZCZ1ixILv8jdh/fbQna
         xAxQVCEY3Zfme5nQ7oDfdsdCczb0/KI7vMpkxtCKW7qy+sS2TiiLVzDo4NUXgnNbt3L8
         0B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268260; x=1744873060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARRmXRJ2mCRgXoILVP1SStKYj4zjnHUfBxpKz5KWgHA=;
        b=P/w/5u7txsb12bPMmnxFKp8FbLiNvYlcfBXmNp1iOyjh2L7U/qnAl6T3tGMcCeyN5a
         /AXwaIpjxLYOX/NzDEyr0xqDZcMEgVA5bYYCnIZkn2Sxvl+6y7jmGNPAnwdjhJso2RbV
         4ed5bypYnwq+lgceAUYSgxMLdtC/8B9bNVRsK19COU5R1VR9K9DdxPHhIb5JXtIVpPH7
         iXhcI/wQTw7nu3EixMfkslkDIbDlG5DRH7lhePz+v98QqU1g3SkBMcTm8U7MjveiAqy8
         jnhulJGOjZc3QCSUbyObYNbkkqzr/+KguGlVBbra4JCLgPxLN6TzE8ZujiHUtyqluUut
         mT2g==
X-Gm-Message-State: AOJu0Ywjd8wF8XY9LWNFPCsNbdw5nntIeJelk5ZGUZSnFMIX1cAVy5cI
	FJEFkBZtAfmzTBaGI70uTmqwzzsw6k2lbl2lOyiFaSYEh3JdQKMwJAp6JtLbfJoiE28qLfqCIpt
	kyoZ62QMQL2uLexJwLMwpT36qcOhSajAXWbilyg==
X-Gm-Gg: ASbGncuX8Ln8VyJDtw7pTme5EgWxlpjqrK1pthg3fB97pkMGCEUZhy2YLUKTLRyfOuS
	xZGJiQJVFR51khG0xa056AyN3YJW32veXB9l9rNBSx6IlwrSuPPB7ut+QQkdWe6Ece4CLISrV83
	NRxFHn0YHBS1rQOi+8Dkotl7TjAorcbzHAcJm+Oe7P8YfX33tVFqR/xiA=
X-Google-Smtp-Source: AGHT+IHnUcAdtPw/Bu+bfLYER0We+JE2unYWgD9+ylsXtm+yAmF1+/a2MICvq/3Z6LjMbkZydv/6M4WXUoGm3z69jlw=
X-Received: by 2002:a05:6102:5714:b0:4c1:9e65:f90b with SMTP id
 ada2fe7eead31-4c9d35c5826mr1056195137.17.1744268260583; Wed, 09 Apr 2025
 23:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115840.028123334@linuxfoundation.org>
In-Reply-To: <20250409115840.028123334@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 12:27:27 +0530
X-Gm-Features: ATxdqUFpdOs38enhPpqvgs50sZwp2PaSSnIi3QTcWZBE0JZMUFx3jvgJXa9Sb2k
Message-ID: <CA+G9fYvgMbV0LK=zHsCO4EGLdKKPPaOwJZ7UzgePNP_9O6Ag_A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/269] 6.6.87-rc2 review
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
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.87-rc2.gz
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
* kernel: 6.6.87-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 327efcc6dcd0abb5f5c298eacd01af487dc297eb
* git describe: v6.6.86-270-g327efcc6dcd0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
6-270-g327efcc6dcd0

## Test Regressions (compared to v6.6.83-270-g0d015475ca4d)

## Metric Regressions (compared to v6.6.83-270-g0d015475ca4d)

## Test Fixes (compared to v6.6.83-270-g0d015475ca4d)

## Metric Fixes (compared to v6.6.83-270-g0d015475ca4d)

## Test result summary
total: 109721, pass: 87807, fail: 4013, skip: 17422, xfail: 479

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 29 passed, 3 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
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

