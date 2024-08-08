Return-Path: <stable+bounces-65996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D494B699
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370D1F23424
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAB1862B8;
	Thu,  8 Aug 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyZlJegG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5094A1E
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098077; cv=none; b=YZ/aQJPeIOZCAjzqvG3mG3m2n6ZIufBbgK84Q3LMx6ieYGROHvdNALpWstVJMS9ySZny03c7WP+mHthfM5chjSlHKgmN0FwCMbzuAUxoidHwO35+ASJxWnNTVa07pFKYbBdUB84bojcYv8TsY29/NUvHdEkfMQ0ZZlwCAb5h2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098077; c=relaxed/simple;
	bh=V7Nu2/ZOQOgFQOgbJi83OYAm3jyTziBatBEifZmB0Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzW4fKeLcYiRM6hmn9toMC/kq1quLlUr+3jmIjSust129EpD+GHSU4I+XtsWhpCHO1Ri1vciji72wNt5sCExutcgBEPzwd0cMoZr9CAlFzvJV84oCr7movifNN+TupoKsiufZdWnhSyXU0BkNCzNTOz//M2FkoY3sHVztj//fuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyZlJegG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so3951106d6.1
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723098074; x=1723702874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5AswontD5tk+EsapM0JEEIt5oaBQZ21TTd0t8hYM3s=;
        b=NyZlJegGnSvPLJGFtKOMV6TFtQrIoFOC4h4nianm1cZ/Rvju61/9AtiRiPU2/Xn3BR
         iDHPOU6/WW+ugw09NMH3Rt3VxS/n5BJLclEg5cwyDTDNgnVzm69CybKx0xRY5Ak1OauO
         JK5FL3FonKzFFYXxT9bTaXWRo/5L9vhLxnKWv9TT6Pp3JZ/BDstPpOQEqXhj5PYRclX+
         qdxVIM5GOwZs6aMaX90VLQAdj7Tyw+9hKhNNuqmwwMrYKgha3TDmpTLuhs5J6YbsiEdy
         8HMMFPscq/Ni6E9dfcxRuVzIt4l4t17QDqE1RTZWjMco+T5tT41EKi7mtx2TltaW9wXy
         8bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098074; x=1723702874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5AswontD5tk+EsapM0JEEIt5oaBQZ21TTd0t8hYM3s=;
        b=qojoSdB3eDca5+jPkJQa4D9hhaJPuQkPXAKjy9HYu+wKP/1BDe0zUHDgYUUcfkmb+O
         jrMdaoHVUCXgeogrufyrNGB9Sovd7JFHskPi5B2W/7Z0k09c/Pi6w2mfX2k+ddtyH1vs
         T2tNnIPk4nfuWDMcBiqETvBHRdzZn1EZ6Oc+58J3ddFE/NVt9l7N7plfGes4prLdoH4o
         jwd86+L7FJV8AMbvjuOAWDCKSu6MMfUWvlx1rA7a/VgwlQ6HStrxM3G5VBuc5CVKQHbb
         Q4Gt/24XZ9TiA9Fcf4TzIFqK2oqrfvYbnPn/RZNfUXeKGysrelrHXB+zwpJVQJxUZ/Tx
         UW5Q==
X-Gm-Message-State: AOJu0YySfgGwd2T86kGoJOUbWgymukh6ucYXNnqmlHKFlrQCcniLX4VB
	yp8JfH4dFNMRylmvatBzxGQ7uIG/NlYfZZR7EjyEN43bDp+mDHGCzQnwiTJexwLMIsbgmwiQDQZ
	xn0cRNQl5950gc0QqMuacQCLjBuXjfuRuXAdXZA==
X-Google-Smtp-Source: AGHT+IEZklhFPOddni0uWN5gwDIhwP5DBZkY/OQVLihWg66EVGvODni6waZMR/SeojT4IYuqP35xq7zDik4puesJWU0=
X-Received: by 2002:a05:6214:598a:b0:6bb:b4c1:646c with SMTP id
 6a1803df08f44-6bd6bcc6cddmr13156246d6.22.1723098074051; Wed, 07 Aug 2024
 23:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807150019.412911622@linuxfoundation.org>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 8 Aug 2024 08:21:03 +0200
Message-ID: <CADYN=9LVRXcvLU5nHcK5sw5_uHok41X3-HPznaetV4cE-SrkJQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 17:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.45-rc1.gz
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
* kernel: 6.6.45-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 272b28faf61f0b80e9d6f92cbcfa32817f9ece7b
* git describe: v6.6.44-122-g272b28faf61f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.44-122-g272b28faf61f

## Test Regressions (compared to v6.6.43-569-g7d0be44d622f)

## Metric Regressions (compared to v6.6.43-569-g7d0be44d622f)

## Test Fixes (compared to v6.6.43-569-g7d0be44d622f)

## Metric Fixes (compared to v6.6.43-569-g7d0be44d622f)

## Test result summary
total: 238058, pass: 205175, fail: 4074, skip: 28347, xfail: 462

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

