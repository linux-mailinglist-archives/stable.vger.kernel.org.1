Return-Path: <stable+bounces-177583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB089B41882
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FDC54760D
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22D2ECD1C;
	Wed,  3 Sep 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzM+dLsM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1692EC570
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888131; cv=none; b=c5jiryB/kCXuci8frXx8626C/b2aNW3x6IGJWrhJr2rUkDYxDX579Q8jVKdJTCa7usF0+PGCtKnI98IHmv3TyzZqQHgkb78BlmrslbGjudW2EYIHwy9lDsQfq2Ae9YV4rRFN1lFM/cp/sSET5md7P+F3xT7DR9lzxK9SMuqs51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888131; c=relaxed/simple;
	bh=1Wym7Nu8boFhEFpKuUAnQJFtOt+aiYW99MGI9WjtyNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4S95/ViI04CQ5Yvz7kSQ3/9FNwcinD8M+me2XKWRx+gsiCOAGiLu9EuYUYCTFXRAsiGGRlGFIeHhEOz6CaCRyFMGexgUfgpSsgZ3uaDmkis0rIcyq3lG71jjOHNm5aKBmqgiyiHVUfvAu2RXSC5YLcnHoyufl/rB/CUzsN1jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzM+dLsM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24c784130e6so14178315ad.3
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756888130; x=1757492930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLdFeYJfsJKqx9nSy+skvh05dFulDLtOnZYFfC/PFRM=;
        b=DzM+dLsMY90/KjFeqqt22otWyWpAjsnj1Z1JEMnzZ5d2ZFeIE9dLVflw7VHEU0HxOb
         B+gexaodksBYEz9aI2srPCDvSgcM620lab/SBURIlJf8qUxiFWxsXaIsKPRKLm4xM2j3
         62BeSger8wlvGPtbUy3Jst/abAtxMMEQooGT4xlwmvytu/DN56WAXbwklepE8TN8iNNY
         dv/nw+fKjHZuLtZAh3zEEbYrRuxb4iA/mc3ESTUfjYFhMbZWYPjvzza66Wmj1KlBH52Q
         h+juutuO5ReDRMS0JOEo/t9VJdK9tbF7KU8aGZVlnTTS7VXHkPkLvUbGHRPvWRW2f8YI
         Plug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888130; x=1757492930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLdFeYJfsJKqx9nSy+skvh05dFulDLtOnZYFfC/PFRM=;
        b=U2GXb/bBTbhmw/5bPJ96HpO6wEkQCVKBxQtCp0Ng+NG5sVsxBHo/qUEwWoUMYWFT2w
         0NjrJVYXrghvyPO7vt4DgM9Ksw7jyw9Uly3FN5KD7MfCTUPDVUC/sXOsbrFPDTPFvmat
         /ZG/R4DSWzzfpw4kkEazOzZtVvRAkrgaqAJUAzDi8NdNKivedCVKWlZdHwLTKVbk5XSO
         rOY+plMvNco0id1gbrjvaopID0JKSrhYiaYnP/cLjgMJdNWQSkjlW5si1XAxtUhYFtPq
         LEQI0dCOBU6pv618uUjblo7phAtGtBpfpa7rwJZgabI393TEb+FE6p0qI/h82oBGT3tL
         jFKg==
X-Gm-Message-State: AOJu0Yxs3SnePXe+ZX4x35ueo+MUoB1YmYmvARU+PHgHm0eEcg3yg4bx
	AuLvUmTop8HjahcA8tpF3mHgbW6Sab4TgDIB45hRz0ma6WpU8uStv6SFq3Uk3y8A5niWaKh4WJE
	FhpGVBOh1x74gWnEOfMbGbetjXLE23CtBU88L0WFIiA==
X-Gm-Gg: ASbGncttyjzHbPibbHkXL8g08vXvINhrdz3HXqqkOC9hWM2twa+Lk3+BT5FC5++alPK
	0z3Y30tD6uLXSJGX06UsJlqf2CseU9feCPXRvQAdZEw6DdTv6fWP25VSVK6UKsmez3O1pdK/FRe
	Y/szxNLcHEiyAL3N5cne4gJyO9q1gJQgFBhLMrNJYXQz9sQSRpKWZ/ggFo4EFq8mHiQ2lia+B/I
	5W2bV7xPtMdMvE8xkS5Xl0YgrPxK4hIFYjczlIRtRiVk9536XU=
X-Google-Smtp-Source: AGHT+IFa+3oFduUGstIxVZlUPFivKo6G2a3ngt5XNcSYKiNIJHejXq4G+jm39VsJCLYhYa1GOPB0rsCi1WwOgIqzKgQ=
X-Received: by 2002:a17:903:987:b0:24c:180b:d103 with SMTP id
 d9443c01a7336-24c180bdb6emr52728045ad.15.1756888129560; Wed, 03 Sep 2025
 01:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131935.107897242@linuxfoundation.org>
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 13:58:37 +0530
X-Gm-Features: Ac12FXx9HCXftwKC32N7kq9QfFr14TNGWUGwqxvrn45DLYReD-NSj3e0oV3dW2s
Message-ID: <CA+G9fYuKHWwz60jKchZ5cTZVt0p+kg_DLFqHchrrdkUbSCdC6w@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/75] 6.6.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sept 2025 at 19:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.104 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.104-rc1.gz
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
* kernel: 6.6.104-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 12cf6be144d1470c08fbb5844926e5b617dfde95
* git describe: v6.6.103-76-g12cf6be144d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
03-76-g12cf6be144d1

## Test Regressions (compared to v6.6.102-588-gdd454ff512a6)

## Metric Regressions (compared to v6.6.102-588-gdd454ff512a6)

## Test Fixes (compared to v6.6.102-588-gdd454ff512a6)

## Metric Fixes (compared to v6.6.102-588-gdd454ff512a6)

## Test result summary
total: 276426, pass: 257769, fail: 6102, skip: 12184, xfail: 371

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
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

