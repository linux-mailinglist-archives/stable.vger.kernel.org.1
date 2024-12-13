Return-Path: <stable+bounces-104074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75E9F0F7E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E549D18820F4
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B81E25F1;
	Fri, 13 Dec 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLPKboXF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C11E1C3F
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101370; cv=none; b=c9B3z5hAPb6kQAgHZql0OVxEiV0Gg+UY/4N+MAu/yiO5Q21t5J/2OTEOe8D4e3kG61yzyovvYMz/yfHbEIy6pSoyf4f6lK/MLdNGGCNfmLt/0r+ILoRJl5bCy+X7I5Ojl0Tnp9bf8HZQCI/kmIarucJfYcLukqjDdvpbSNFMKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101370; c=relaxed/simple;
	bh=hByqeNYL+TZV1cYmgGYkHNhMiCkV4v9idGQn3nu0lpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/lWTVYV4k0Ra9nzR+Am55Zrgbcpm3lHu/FVQU3e2DOZghEsSVedWrULLVKmuYj90JW0QFD2Ym3hPzlyy2YVOb8UrXKrhCzuLgnpMJaYe9b7a6L2F9vmdRsJyfrk3030PDgZrlkrPvRd/OL6L3mpfVdHF8bj/VTMq18MNdafLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLPKboXF; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85bc5d0509bso385548241.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101368; x=1734706168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bKxIAldnf2WV3uWw0aRPXep5q1Q5wgQLNkyd2UuYH8=;
        b=OLPKboXFnIxAPo7/SqBWrCNO6t1B0u3paoH5tdDeh4JwNXuaz999zt6bHh2UpiWKME
         zSlLi3rV7VB/GJTdp+ANXYM06iDrxFNF1Y6tJFiusphSEVF+a6KWsb1kCs/GmQJ27WVN
         fo4YifI2Ug9uP+wKypwDpHh+HlAgsH89EbcVNuwzsedHRSHM3UZdplvQnuNECuxI+bFv
         QG7HL7UeJe9fC3wI7efjjdgqnt2O9Z6J7+A4Fz8KGNY/va/mhd/v5WFTZg0kcDvZhwhC
         1dfRBbOhUeHEPwHDA+FbyiO1zKGTwkARZavp5t1enN3cyAW1gu4Q/xyQyvH82igPJHIb
         Sk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101368; x=1734706168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bKxIAldnf2WV3uWw0aRPXep5q1Q5wgQLNkyd2UuYH8=;
        b=mVHjJ8A7yOGwLX7C7PknegfZZGHutc/z1ZoOtbZYtx65EkQuSuQ2SEj3QF7u9orHsO
         9T3LFfxyjv+5icN/aPBhlOF7dLruFTBy/eer6ZRUXljl5uP+etFTM+9L335l3HX7WVrs
         2g6s4Y6HE9jgeDMf57YHjxBztYFG3caibAjFKLhtZWrNhaS3Q/ZHteQQOw7IuXArRpp7
         5GmYK32uo/fQHYAX9t3fpnzBHXGyw+cTgooWwwgl+MWxWyLVg/r+7CyHEIt/Tr7HgE62
         GNfdBH8ihsgqk1ADfsKHZMKxxbbhXHlDsPRTAGO7Ph3zXzNhuFyUOjKLopLmZ2kxxd94
         C2Nw==
X-Gm-Message-State: AOJu0YxNtqIfnUCL1Ize61rlcpO8USLRYWuuL4i3u72aWCMEvVjtMnqc
	AsJuA9kVyPq+4VnuPp59cp7roTwwsCfpcdWPlw2EX7Y3r5MV9/iWTax15L5ut0kaSVcIVsNoZiE
	23O4ypTNiRbmTUO9kSgwcL5ghlDP5S4FmsWlZ4g==
X-Gm-Gg: ASbGncvwmPiF87vIBf/qTSg0JefUZhm0ABUH1zsIgjFlWaDVR+3f0G7iSSlcTWC9Yyi
	66D+bUv0ekXBNafRF5uFM/0nNWAfyo7DuGLhin+M=
X-Google-Smtp-Source: AGHT+IFvRz6amg0/LCv795PFdcXSwZFAuHmhc08GDUubo7a8UJkjnqdzDOeeViMLb5gcFryVLpGHBJmY4rTH42n0lRA=
X-Received: by 2002:a05:6122:8c12:b0:515:c769:9d32 with SMTP id
 71dfb90a1353d-518ca399ec3mr3099699e0c.4.1734101367579; Fri, 13 Dec 2024
 06:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144244.601729511@linuxfoundation.org>
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 20:19:16 +0530
Message-ID: <CA+G9fYv-qg_TbgP9o_VyBcBAYfecxFvRPjq0w3SFX_PvJWDbkw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/356] 6.6.66-rc1 review
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

On Thu, 12 Dec 2024 at 21:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.66 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.66-rc1.gz
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
* kernel: 6.6.66-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ae86bb742fa81e7826a49817e016bf288015f456
* git describe: v6.6.65-357-gae86bb742fa8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
5-357-gae86bb742fa8

## Test Regressions (compared to v6.6.63-677-g1415e716e528)

## Metric Regressions (compared to v6.6.63-677-g1415e716e528)

## Test Fixes (compared to v6.6.63-677-g1415e716e528)

## Metric Fixes (compared to v6.6.63-677-g1415e716e528)

## Test result summary
total: 130339, pass: 106681, fail: 3098, skip: 20494, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* ltp-commands
* ltp-containers
* ltp-controllers
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

