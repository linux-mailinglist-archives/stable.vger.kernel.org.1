Return-Path: <stable+bounces-61917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A693D7D0
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B571C22A9B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4543BBC2;
	Fri, 26 Jul 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3DPqiEG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5243BBF4
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016377; cv=none; b=V4gQ2h1n89W3ChnPl12OZjw74KPs9FTiD5NZzGBn6dLfibd+Z4xP693aOhfkis4d9wbgKtx0VvyS5VOJQVoFYTESSdm/OxX5HGpqaQOZnLk4vvlCMCH4EszslRO/p9O1Bbueh+nULOW5frswCH/Li4v33+OG0c1tRWGpNyi8EvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016377; c=relaxed/simple;
	bh=mkF+Pee6lb1ToWKFNH60jhVzkBYIt8qW1uZTFxDZ+zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6EiKFFMraKsoOrMrHSeKYPPsBHz8golaV/8CYjuPeMvZHKOYpCkSy0PT8yWuKb3xoPcMeTVpgcL0D75z90tdbx+V8CauRhYb9cCsgkaVkrvJFKAyBcBPHqZ/VuVQovkyGqisu/UbjmHhjlRjJGEN4ht007VxmzFuSPbHguYfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3DPqiEG; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so266676241.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722016375; x=1722621175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x12eU06nk/b6qPGqlVPTZBZDUnzaXcNsls/AJe1ig14=;
        b=t3DPqiEGgBlk6MyV5HmgqhLZWc1md3vNWVnFZODhW5KoM5aAr4OxZqPr9KeSyapZYZ
         zPqfQQrYEulC2WcPvy6zURRYaU4nlr/v0XQKHB4OxVJAzUcjOpLKDuEC8g3E4VYLGMRI
         jrSceDFa7fPMLlptVwFUtkcySutlgL1dmszsgiLHHtsw3S/VoTGX/crekrS5gPWflQJj
         vT5BECwVs1710TnmV00qst2oAlaqfkHn3Xl6XONkcvJ12HDk3NaswjDi05r5qkuU1fdn
         MMWQkGBG+4EpvO9HOR7J6XZLnlohyvDewcpynrPr48zaOsEjMHGTXWeaK+vJ8ccl5y/Z
         Sipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016375; x=1722621175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x12eU06nk/b6qPGqlVPTZBZDUnzaXcNsls/AJe1ig14=;
        b=DKuvvkn757c6MGBrfdR48IUssgIDDsGDCaQ9gc4CFQbiISKQscU8/2+jOcS9pJDSUg
         kY+71ypNk+DL/cHIldH5pqzfhifabq8/8kwDGbhCGeLN2Z9iagn0GXa0OhLzeLv7ZLpV
         Kh2hr8bm0QqErZpWz4IP712WJMjDl4ofJ0NoSgnwO7hNIsKV41E25XawbOOP38Rn3ddn
         aWgannbY3nIAnvix1yuEBpC4sqYzBuRgAw6B2hMMSt+6/UJwThP508WDl+/nnr1GUERm
         Vog4+a3a+0wZR6BXBIIr5ZVO8KjqRV8+P1n2ASZfOwtE/0MrX5SJztWjZf/BywzlzS5i
         +lOQ==
X-Gm-Message-State: AOJu0YzupZVdTTUVP5gKXke3sHeP2JTF4zQMmA9sG3wmBCFTxyGt+6DS
	9J0+fppzvsEdWZIH5dzVtxHRSsUbYmsyu1702O65Ej3MERSJOQxdQqXNGi3HTXcTIHk74BQF+4p
	909C0EAWkAOyxn4qY1oP28AWRp62p5VTzBo4V/A==
X-Google-Smtp-Source: AGHT+IHDXp+ujHJusVxUfPG9lAeVWXV/StaxhOMcw3TgC/hxKR4ZDDwvx8aoDwvUl59nBDgOmeRr6zb1PPKijFBH3E8=
X-Received: by 2002:a05:6102:4425:b0:493:be92:d1f1 with SMTP id
 ada2fe7eead31-493fa607925mr719766137.28.1722016374981; Fri, 26 Jul 2024
 10:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142731.678993846@linuxfoundation.org>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:22:43 +0530
Message-ID: <CA+G9fYs+KxD_vOFwndGQNHfC8bE5f9-eiCiL6dO0aux7H1ugLA@mail.gmail.com>
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jul 2024 at 20:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 692f6ed6607e027dbe476c8301112605c72385b2
* git describe: v6.9.11-30-g692f6ed6607e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.1=
1-30-g692f6ed6607e

## Test Regressions (compared to v6.9.10-164-gebb35f61e5d3)

## Metric Regressions (compared to v6.9.10-164-gebb35f61e5d3)

## Test Fixes (compared to v6.9.10-164-gebb35f61e5d3)

## Metric Fixes (compared to v6.9.10-164-gebb35f61e5d3)

## Test result summary
total: 253976, pass: 218579, fail: 5284, skip: 29585, xfail: 528

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

