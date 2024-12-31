Return-Path: <stable+bounces-106608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC29FEE6C
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55AD1883133
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E0199948;
	Tue, 31 Dec 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rs2F+q+9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FA1946A2
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637955; cv=none; b=uP7HLy7A2/+K3QnoaPZq7gGhHun19GB05gYyyAXXsgjglnUDxlqb5am8G34jrnJW26t7LhfyZ1/yyrZZrBWwMdSB+KKGDKE132EaK4b5K86G7AtoBCNytkXjPMhbFfvNE590drAud3whIiAZlzfBKDM92Tb7OZrN3bmF0YmaEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637955; c=relaxed/simple;
	bh=JubYt5Kao1ifQYg6uWKODwQ7U5Ert4I76DkK/0dNFPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHwmoaPfPDcVIZuqooCo/FtWvQWyHWYxSOXyM4tmagU/80J7hFpOAq2DyZ8R/7y1kXbX90C75qu/d2I8KAj8oSyFxbSwcZEWkW2iV8B1uPSoHm08Gy9D/J4z0F49BEY38Qpxiu/udDGOjmlZO2H3vx6jUAn1lN9V3ls/te3XOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rs2F+q+9; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afde39e360so2668145137.0
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735637951; x=1736242751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSAlkebACWYAyq4hv5CuWrWBuC4EK+CgRnFsGwGaXCU=;
        b=rs2F+q+9ZYH6ILwP48RDuUlgEOeZ7YrT+vvo/UUh7ScPiLtNurctvjUryqge0g74zU
         4yOLwwCvr0NVKEWIdip2/+vb9H3ggy0aXHVGnFYWEUkCN4Lj9wqJiyh43lANJiYbjX1e
         sI5Oud8Shabjk2DbgpNxdzVQPf61ntGvdG4Wm/jXRtFCIe5wB7xeeJbsxsIQtmk5hkWl
         /xEZjvm40JpvVXYmGu8txmsEIXSH52C1LxAnvvYl4yWsIzY6mtBVEk7yTudeGLypM8YK
         +RLPN/AW7rsuRB4t2Go8CTgzlaMmVYHTXaDr9PsNsIjJwXWfVPS6m1MrYG0ACsOuXMIP
         ynLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735637951; x=1736242751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSAlkebACWYAyq4hv5CuWrWBuC4EK+CgRnFsGwGaXCU=;
        b=dN/Q3Ts6sHZ0jXOKnioX9x3QHA21KjwpQ7YilQzd1ystncsl4iO3MJ+C92sE29iD3i
         yGq4nTLeq62syv44/l1kcTCSrmBvKJr2RL6JmRf8TBqFzLufnH7NtkGJGltEik+NO4/t
         6FxYFXat62gaGr8C+B+XS8NImEDQybYHJNjEKG8hYVLOZfFoXNJW8MbYFPuJVjABfJxc
         eLxAIVkBfLXGu7c8l/I4OCPrV9YW+1EHyxotBPQzihlizk4qtPb5UC5SxfkrxWwJ0SXi
         eNO/4KjBUEXi9uoIApVRmv9e55TVQYURmyPiRzmG0sKkvQ37vLrhjuURekTGwLQw7bUq
         l1hg==
X-Gm-Message-State: AOJu0Yylx2ZFcB6bJncH3OoGZtUs4T9e5J8HxS4dRQtga6Ii1GxWGbKt
	Dq+vUCYbRxggy/qD/d4hOY+/pFMWN8JEEeboWlqPH2F8+MAFXXYqooU9nu4gvJRBnWbjGMf0xpg
	rrqjGI2CEEKpnYZdndEIpbn2ImMTspva1vZi9Yw==
X-Gm-Gg: ASbGncuGHnb13M8ODzcxlfWn8J+e/QYNX9f5jJICTz8kOAnqU1XyY/ObOWuLVg48DFT
	yWQ+mBOV+c+A9kSRQWV4uCwZnVLbzAV3NfrKczQjAn3UdDLoOT8Mh0KMxOtHR5wn69mYH/5g=
X-Google-Smtp-Source: AGHT+IG6JtQQYGEhtHg+sejplvyBFrH64R0XhcG9R43DjsnokYo3SQZfkEyKgw9EUEajCF9/J2ghflLjB5Cflu60NZg=
X-Received: by 2002:a05:6102:3f0f:b0:4af:f275:e747 with SMTP id
 ada2fe7eead31-4b2cc45dc5fmr30675406137.22.1735637951195; Tue, 31 Dec 2024
 01:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230154211.711515682@linuxfoundation.org>
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Dec 2024 15:09:00 +0530
Message-ID: <CA+G9fYu+yy9g1McuZmB0TfCOAQBg3XiS=eo9Cm=21imciqFvMw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/86] 6.6.69-rc1 review
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

On Mon, 30 Dec 2024 at 21:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.69 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.69-rc1.gz
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
* kernel: 6.6.69-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 159cc5fd9b139e65594480f46bd2c71c7caa9f19
* git describe: v6.6.68-87-g159cc5fd9b13
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
8-87-g159cc5fd9b13

## Test Regressions (compared to v6.6.67-117-g6a86252ba24f)

## Metric Regressions (compared to v6.6.67-117-g6a86252ba24f)

## Test Fixes (compared to v6.6.67-117-g6a86252ba24f)

## Metric Fixes (compared to v6.6.67-117-g6a86252ba24f)

## Test result summary
total: 147184, pass: 120768, fail: 3602, skip: 22739, xfail: 75

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 31 total, 28 passed, 3 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 36 total, 35 passed, 1 failed

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
* ltp-control[
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

