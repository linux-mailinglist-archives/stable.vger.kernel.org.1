Return-Path: <stable+bounces-23351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0785FC1C
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572B42893AD
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A914C5B5;
	Thu, 22 Feb 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWHiGsi3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11814A0BD
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614987; cv=none; b=cs1bFGTMhCbU3d0DPuuxtXY7XqX7ztYxrJExJCgib+2h9ZN4tqheECMjb9e79/Lpf58xwFZ1A8TQSY5c4937P88abut57YxdyOxeuWCqL6WsqMAtO6gDOuaF9Ies6G7quE/MErKVmUylj9pfxwYRt8hWkh3Rxa0kAhyezivFx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614987; c=relaxed/simple;
	bh=icxcY8uc+o2IJThcPoIsSP21PpsdAb6o+f7z+Pdo2xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2btU7fjdu9cLuNpBFuLGuQMKj6DCtwgiSPAH4Wv0U2iHUQNG4T4HOJrwehaeear7EahwqkeJfyMjuieREtg/eMuxQX4UEeLwm470Ge47aGwhBevxzRnu66gXyo1WiWq50V3mCT6ITeL0r8NH1+ZKLjeGCJz3MSNMTzsoZYZGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWHiGsi3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c02b993a5aso4840471b6e.1
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614985; x=1709219785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOdoTYWG4356EXT02DJVT6VCmhVf4Pj9aUeOKw00wQE=;
        b=oWHiGsi36O7i/kEQxaD6GjAk+Ik6oek+Wzv980PYR/qNnVoVnH7R5R5PlKtWD1i2n3
         ysljFBaOeydAUSos5Ml9NR4gR1o+ezFPQiCQdtxK7mv05JzPkppODX5JWgDGqeY0lVq8
         SS+BTH/06HXTT7f6Wcnt/lp/b+3FCOiNPDC32QJmaU9SeLLg7mi/sMS/Ep5CaPPWbzXW
         go7cuvNouDDdGiY6t4UmFCg119OBNf/rtaV+V/z0aKMjWKGVbgqL3oseD/Wqy3N0Li8A
         ypOgya7cDuE4VBHc2+ESkhcu08MwTSat2kV8ure6h00e3VlUKzFWbU0WM+9X5mOeFsNc
         nkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614985; x=1709219785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOdoTYWG4356EXT02DJVT6VCmhVf4Pj9aUeOKw00wQE=;
        b=ShDPvkWspPWXrzIporaDQ3g36GsenP4c/wGWnqGIyFpBqyvkkAukXTDToZW3zk8EHJ
         H3kCZqLJ/hy7lyEa8eIcTF6c4esSFV+9ddETrl87GwoSMRR5C+EzToHq5Ulokb6rvgdT
         IJ9A3RXifDZ3wmfUzw+4JffvtKqjoofelMws8zVQNyXbOiJhQvGPxw7HCBjIro366gWu
         ZDGHkocqid1EMaFieYBfvj+b0xYAWKNMtRaY/iAGtNXi3gZ++W0H5m8RB+/KyQ1Hll5Y
         jX1NHNgzimGOh1NrwbQD2v6x+ErwNlKNJitYzEiz+f9tGhl+6bGtYf7/OK6qnbLi3RNG
         k3DA==
X-Gm-Message-State: AOJu0YygMNdUlVpaDmt08HrRGCFQA6b7PP1aBnqFoNGgMj1YyVeQjJ/9
	AvpaVviGwbMpJkZO+plgQKXxvVaDYOIzFVeXd45sxsSxmbB4RH2WKxxiFyXT5B/Rl++jKXwJ4CR
	/Cq+HGD3p+XhWfCTzTMQ/sk8B45Y5Hb145LwjtQ==
X-Google-Smtp-Source: AGHT+IGCT330ABEop5oo+JQQNQCzzjy/J0/pVrUJRTO4UAFq1whof9j5GRM6HGVl3q5ruQnmMDsqA0wmrtK8eiuZQa0=
X-Received: by 2002:a05:6808:1719:b0:3c0:33a6:bbfa with SMTP id
 bc25-20020a056808171900b003c033a6bbfamr23615419oib.48.1708614984711; Thu, 22
 Feb 2024 07:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125931.742034354@linuxfoundation.org>
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 20:46:13 +0530
Message-ID: <CA+G9fYsch0VPsmTTfR-VN+RDZCNC4F=3WXiN9KuK2yNWTK0sMQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/202] 4.19.307-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 18:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.307 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.307-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.307-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 05a45288956cb4f8bd2d47d10050520cddfa9063
* git describe: v4.19.306-203-g05a45288956c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.306-203-g05a45288956c

## Test Regressions (compared to v4.19.306-165-g6d7461510b51)

## Metric Regressions (compared to v4.19.306-165-g6d7461510b51)

## Test Fixes (compared to v4.19.306-165-g6d7461510b51)

## Metric Fixes (compared to v4.19.306-165-g6d7461510b51)

## Test result summary
total: 58627, pass: 50543, fail: 940, skip: 7095, xfail: 49

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 36 total, 31 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-user
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

