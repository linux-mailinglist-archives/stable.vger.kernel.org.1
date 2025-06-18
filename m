Return-Path: <stable+bounces-154649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B30ADE8D5
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F203BA0C4
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940F287511;
	Wed, 18 Jun 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwNFOSi5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDA287503
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242029; cv=none; b=gm11vM68BFsNHuiQQyd5xLIKxtgOqHp3Kn6AcZqkC9CCcmb5apiho8ezSVCz0l1PSuCPpg9DgHrg/Viy0cb4J68h+tNeQ2ZEUsLFujY+qjMC1EiJ8tTR+ylmnsTSreTxuDRHmKiyUE/domhV42MXHJ7rRBRLPqBakSin6BOgI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242029; c=relaxed/simple;
	bh=TSkpXMUCGBLGW57RuPGfv/LqzC6cxyMmgIfCk78NNvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REklSft7Rk/+QLmhLXsiKGCaxO7aiJF8F2ruIKaLU09uLiddo/qasBi4GvvLFic0qUOpYfCH7/XgwDFctrInMwHHtzAUF2edQlo86Q0zae1UHhPlnhPITC25REKzboFDl+n370gQGEp/vOiPgsU5JzlgrGjWck5+Z4NRILz2VdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwNFOSi5; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f2a0825e1so345146241.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750242026; x=1750846826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZscgBK7vQh5GyGDP3R0SwzOToDIeiQZZam9YvCUg+A=;
        b=VwNFOSi5uvpYti9AuZLJqrSlSr4FVHcx9wFtFhisLU7mIQl3cVr5TA39mekGOHtW6w
         yDiLu/lWbGM1WQ8BVmu2mS8sbwxEdGfGW/h56F+sV5l4ssflU/tbAfWUiAtYWPJK07q+
         cRVpyz6NRxDYVuI1yn1lFej3TWloa+VE9Wzgv2cALhPPN62u6YEPnx+pIAFsOEq6wyJK
         WI/IAApGm9sObcqNDD0YQUcqgfWCxVkC63AWenDcu+JkLNYwWYsngJ9LSdvMBK7ruISW
         CgtmPK+7QqLpsV2bcgeVkJrKtoSqU3cyUtbkgbr0qmL8zkaGlVFNkENxah0k1J7Duc6q
         69hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242026; x=1750846826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZscgBK7vQh5GyGDP3R0SwzOToDIeiQZZam9YvCUg+A=;
        b=v0J7cK6Z8wPRuqtA7AgXVOkZy6yeaHCz40Xtgy59CutQD5I1Bh+UHq9cPXm9QP9MGP
         dcVGNO33bDYY007QxOHLw9ZB5bfpZgMGcVctkXg3SKa2vy8q2WTX3FeyaKo8ML3HlXkJ
         mN0IKPFDbEcGcQFv9LZBFpiWcGCnP5c0rgjK+n7XjWhijTcVfryZyzXJbhAHpOlW50HT
         CgKGz5SrFy4bEQdKeX31FZ8Bqaknt3GU/AlvwmtZ6P7O9vc7bWnV+Z8OjmgxckOcD4RL
         H+gXs+LN8S8RM2d6yZ1eJ51oWBLCYqd6YFSyZkhg3hAFWN622n2xmhJLrimTkXktX6Qq
         rzlw==
X-Gm-Message-State: AOJu0YwW1SaX03hUVFlh8wRE3Cuxdq7aAC2uFZUfWOSNkYMg0iMTDc9h
	ysJt28+U4NNvgxmay2GGvbvSztwUyF8SkPt62SoQoyra0o4oUf4wlkC8gdo+QbwO2EghKHdyyxd
	G4lfZpDfOH13Rt6zg2ZWiAPrqm3rLKOV62bw8yf1d7Q==
X-Gm-Gg: ASbGnctkwJK5xbpJfbAK2oP+Oz50bjxx0XHGkptt8gYmLFB90mFS0mf8cgGrF1S29qQ
	JOppXayqGFqZam4pD7i32d2/6191VzkQS/DuCezXpVYByUv696+qmEPdd8mRzH4lvuSN+k0tDIp
	tpQ9p6/1g76vDvZ17VMLWTootMROdkanYnismPXimOmeHom7w7J+jxGQ==
X-Google-Smtp-Source: AGHT+IE3OBH47heT44z75CQFO2vVoaeyYg3Kk8JAVuB+6zADI2o9rVsm2ZYzU9bGVzLJfE7whT3gToQzdyWSK6aa+PY=
X-Received: by 2002:a05:6102:508b:b0:4e2:aafe:1bde with SMTP id
 ada2fe7eead31-4e7f61b60b9mr12500027137.9.1750242026432; Wed, 18 Jun 2025
 03:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617152338.212798615@linuxfoundation.org>
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Jun 2025 15:50:14 +0530
X-Gm-Features: Ac12FXxVzmGim5VNLRe8LnObfmRIABb-cQ6rWKWTtElMPXcLJuXbjNGza6aHiF0
Message-ID: <CA+G9fYsda33su7S3ysR9q3TSoytpZnWtMX9jU8XXAKTTjoNz4Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/356] 6.6.94-rc1 review
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

On Tue, 17 Jun 2025 at 20:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.94 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.94-rc1.gz
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
* kernel: 6.6.94-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7ef12da06319e12118a7bbb823004d011c57f718
* git describe: v6.6.93-357-g7ef12da06319
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
3-357-g7ef12da06319

## Test Regressions (compared to v6.6.92-445-g58cbe685685b)

## Metric Regressions (compared to v6.6.92-445-g58cbe685685b)

## Test Fixes (compared to v6.6.92-445-g58cbe685685b)

## Metric Fixes (compared to v6.6.92-445-g58cbe685685b)

## Test result summary
total: 217939, pass: 198129, fail: 4284, skip: 15211, xfail: 315

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 0 failed, 2 skipped
* arm64: 44 total, 43 passed, 0 failed, 1 skipped
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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

