Return-Path: <stable+bounces-161490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7EAFF2C3
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D2A5C07E9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87230242D8A;
	Wed,  9 Jul 2025 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oG/jDJFK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF297235046
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092059; cv=none; b=N5M+c26rvY92fVEsjdtzHN+WqFDgc3KL0xPe7zk7rt5szj/UURCg7vDr1/vedbyQW+PdsfZ0mLvfBcjypCWOAxWFxkfD/ukFQVHBTgzNIYv53wXWpB4KcDOgZ/xa04XDdUJDBTNryfd4wMopAKXie/RmGiik1YZDshRlbRHlRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092059; c=relaxed/simple;
	bh=mZkXqww+jb/XVO71FjjioqL0zO3mDWI6ykKz9T+vzLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ikk6VG7pJenS+GyJ80NNCYfkqQT+ys0WeJeyGRXJM+5yKcqyQgXRWlooHu0jqFJMXyAwUaSQS+Wr3E+HAyoNdzKDJeSi/MvwoB1kC2QXM2t9iYBKmeuG5+QSaH0x0I5dS3ecDEUhaGWF9vZLYOGDaHrtL9FU+A031j3wjkLtMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oG/jDJFK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ef62066eso4858675ad.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752092056; x=1752696856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuxYNeYCZnL77eXJRYZOLoWLDjp2y5zriWpKfZSuYH0=;
        b=oG/jDJFKhgzf2maul8EUDHj/GAsOBghNLZUVf5GUnexgF1PjGVR/pCYxqFrRse6mXf
         fDBP78KVg0t5FH0Zn3lzmXs5jgxbgRxbhjBTgF6/BFxTGJq0FHSApJbTi5aFT9bLxfGN
         FrhA0ZkJTLy5qEqU8yc5DN0FpL1oFjuRm0Wb0h2EobBBI2P5XZwNyt4gkqmZSQVafTyI
         1M11Y6qBTwoLsyeaMqfv8LWdnnRdukq1qXehLPl+vIWhJgBHtn3f4UpG/pxZLabyOPfL
         mcUBDZpmuzJ5njwhISE7s/D7zGXnUGER+MN+d5tBUc98WH3r1lRc3J0bRcEubbcLeLvV
         YeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752092056; x=1752696856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuxYNeYCZnL77eXJRYZOLoWLDjp2y5zriWpKfZSuYH0=;
        b=EgIGurBvVWnkclIMo8AXSz0jNi9kKrSHefJCUIVrAf9te8SQOM7g23fyo9V7VAtVp8
         yEmcyS5Vs1TAtI2Eh0Lg2BccOuSZej+JPbAiAFV94zkj7X8y97aKc37XiCGPXIAeIy2K
         NKh5hQjxjcyBMxfox/VbbbwV2mb03881yWOL9VV6HGx4FqQv7v7hyac6fVtiUCb878hL
         kPPU+no7e6HcY9m0lAExE9PWaGcg3d4PMn/2avlWBfVjKomriZ4fhguJQS/DXYAWnpaK
         uxt2ahuCtZXy3HsP/2Q6IoTpeIN3rOE6T/yrM3DRjEB36mnfSq6R4rLuwGMdYGtL4fOh
         l5Pw==
X-Gm-Message-State: AOJu0YybNOHwRdPO+/oPB1NjpTR2J3Qujez1YMSbrNTD9dnjtOS6DQbF
	SLAmdIcf7QwyMfG8G5lWh+zf2My4LrkrRYAmBEHXfJ07xr+wH6sLT1958uyH6PRZtT7v7+egro3
	LNfwbB/XuzBobRjbLnXHnehYtgeeZzqonCh6i7bC1jQ==
X-Gm-Gg: ASbGncsyt9q0IRjlRmvJrj3TYPJ/r7mWKVHznbi6g0fV5bq+rdd0Qdc4WxQ1n8aueoB
	z+t6TFaKO23QEmh5i8E6NS75jlRfv61p5zFF2tlppBJTURTOpibMyFVudsAPG7voClgkI6j96AD
	HLjC+9stG6TFsG/LUCxxqr2AzFfPOc3qXwzgqcmRStV1Fnn7T2cafKbemxJgYyQuoNZ5G3AGBuI
	dc=
X-Google-Smtp-Source: AGHT+IFh/sTD5lUyOFdlw8hE/8kKo7Xs9ZCqPLR1Lh4w5Hi9Jl20KQ/pQrs0JRpksabCumWnfS39o2yvc5ajsDmmhNc=
X-Received: by 2002:a17:902:e807:b0:234:8c3d:2912 with SMTP id
 d9443c01a7336-23ddb1992famr54743615ad.11.1752092056088; Wed, 09 Jul 2025
 13:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708183253.753837521@linuxfoundation.org>
In-Reply-To: <20250708183253.753837521@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 01:44:04 +0530
X-Gm-Features: Ac12FXzORM6LSIxCdmx06q_Rj-1ftioDgwAg8gn-LNGMC7ssMysWR_Kqlywr4AE
Message-ID: <CA+G9fYubeQ12JprZ--NJ9-kcsedRre2V1ZBadeGevo62kpbQgQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/130] 6.6.97-rc2 review
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

On Wed, 9 Jul 2025 at 00:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.97 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:32:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.97-rc2.gz
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
* kernel: 6.6.97-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7b8f53dba183736f96bb25a8e29066fece62ce31
* git describe: v6.6.96-131-g7b8f53dba183
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
6-131-g7b8f53dba183

## Test Regressions (compared to v6.6.95-140-ge950145d456d)

## Metric Regressions (compared to v6.6.95-140-ge950145d456d)

## Test Fixes (compared to v6.6.95-140-ge950145d456d)

## Metric Fixes (compared to v6.6.95-140-ge950145d456d)

## Test result summary
total: 287982, pass: 263718, fail: 6340, skip: 17505, xfail: 419

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 43 passed, 0 failed, 1 skipped
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 12 passed, 1 failed, 1 skipped
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 0 failed, 1 skipped

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

