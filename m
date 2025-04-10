Return-Path: <stable+bounces-132072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7885A83D52
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E217AFAEA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0B20D51E;
	Thu, 10 Apr 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K04/Cnv6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9E20C488
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274532; cv=none; b=MZwXB8BgtYi0MN7Am7nbFx4SXulKovZJs9z04YcnumWxQRXFrNp1/CHeammCIAr+4ZlKp3maZ29qiJzragg52i6ugtGOY1K6PT3Jlq6Xz+iYigqPJaq4t21uJp1Rlf3KMZllSiTkJvjqy+gnAiiRfJPisO0hbtrZ8o48kr3H/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274532; c=relaxed/simple;
	bh=XG6NxBHDCU8e6wWhYpT5+1tNDUysPx2K/UBmryuS2Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8nAm3UQNDFxce6+f2bXkPSssYDgNkKWHXII7Fb+y6NlVKep0ez3XOslYzrPsZXJ8nlxZ2xg0r7sRTKH67+M8JAeQCeTyW6VgWCORnSIaCH7YSlCgr6ZRH6v7bFDa7KrnnTRKkhslolh/JKwwGkWdj7H3yFu9d3SUggosHn5cQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K04/Cnv6; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so201742241.2
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744274528; x=1744879328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyIfJr2KsQTHGuBJx3uboxs4QfrzCXTKIx86BPgvMt4=;
        b=K04/Cnv66rM0VshZousHPTQtsbYKEbOQRJ+2Qp7awQl9sYpEJqdESDNgs2auz0dSIQ
         2Ny9g4o2LRdIdVzjI5VrCDXukcBn+Wm0AU+M1mFHwxoI0EUKQ2AChikADyC9z8+wB+8O
         lDeN7CCc/aXYFuZ+KPILcXIzDELnzEMjA2dbiVeYVXToMJ9tBZUh/9wJjzFCN39t7cPL
         +l4LZb7OM1Mzm6kWU56oo833hZS8WKwfQT1w/orvooHf5WN0zzpWJUbRljSB5nMUxuYW
         Cg9AibkKK7qUSEkkJMRF+r0M9qJsX+Jf0LNdBVtgcWlYLV/KNLM2Gw1t8lNE4nDunW2C
         Xrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744274528; x=1744879328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyIfJr2KsQTHGuBJx3uboxs4QfrzCXTKIx86BPgvMt4=;
        b=v5TIiB6U4gPacv+29oaZZ4MasIwlWyUYdtg0lLP6gBzZJY3HanuJ4y+a7stOmY09ek
         V3FYbIEqc7fsLOf26izfkLri/VJqPhBgxMt0j/+soAJ9rztmh25DhSOkTqvq0m1ywNfX
         AmZRYbUgmY8uKu7zrN4OGjlposFPkGjStqbJSkS4j2JmnSwj7ixD/1tvP8Oj8cpSsrVS
         86HrLAoLDRqKuQTwFf2JT9+AzuKlvXA27j+z8VeOdACidY4O+oX2bjsZ7mi1YkiVCd8n
         odiM4/xj3ULtSxG78+Cumzis84ZL4n3xl3m9rgP3wHdpmqKmec2igmMat/4ApBa3vJ0/
         cN0Q==
X-Gm-Message-State: AOJu0Yy5uzMrU3se01GtRIrIQkX2WvpwdIp9GdR8TzmdLiCLt9yeMdeV
	9B4H8M6mqEiWBz23PdNlrRKZrau87bkQqYqEp+nwWciLe74kMHINekNp0X9L456N+fmN7pg1X1K
	1paQDry/71lmHg8ge/I/SiRiaIRyS/GwnlVLseA==
X-Gm-Gg: ASbGncvnvFvHL4YXOu51kFgBtddFpqXSHEoBESq6Za8jsOQA7jwKcdFMedv5POUYKJz
	xJdsz54mYeSGPE0GksuCd+TzYyPkJy1uoqoUPSrdeFiUkLEo67m8uY4wiKTSDtQgilODeaduqRH
	f4I4xdVbaBvGx7SgYYeK+NQTqZ54IpZOKm626vC2xtY14dEcjYQdgpD18=
X-Google-Smtp-Source: AGHT+IGEyduE75Oa5qN4VHLm8M3R7hj/JMCUjzegckuIY/DQaVT3G91+oV6FvbCTJnJFb7i4ArsCyl/2lP0i82WbZ9M=
X-Received: by 2002:a05:6102:3c87:b0:4c1:774b:3f7a with SMTP id
 ada2fe7eead31-4c9d35c57a3mr1052484137.16.1744274528525; Thu, 10 Apr 2025
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115832.538646489@linuxfoundation.org>
In-Reply-To: <20250409115832.538646489@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 14:11:57 +0530
X-Gm-Features: ATxdqUHVxWyVTy2Pevd2zCaKDuF7x7M_hIPZ-bHH-56kzLv0RETgWUsQbJV9hsY
Message-ID: <CA+G9fYt+bq=20FNgxqTXnEcj0mScu1d20kCnyeoF7NS6LJEi=A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/281] 5.15.180-rc2 review
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
> This is the start of the stable review cycle for the 5.15.180 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.180-rc2.gz
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
* kernel: 5.15.180-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 20340c8f4f00f2248a63d0a83fa118e2894a8439
* git describe: v5.15.179-282-g20340c8f4f00
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.179-282-g20340c8f4f00

## Test Regressions (compared to v5.15.179-280-g0b4857306c61)

## Metric Regressions (compared to v5.15.179-280-g0b4857306c61)

## Test Fixes (compared to v5.15.179-280-g0b4857306c61)

## Metric Fixes (compared to v5.15.179-280-g0b4857306c61)

## Test result summary
total: 51458, pass: 36401, fail: 2669, skip: 11981, xfail: 407

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

