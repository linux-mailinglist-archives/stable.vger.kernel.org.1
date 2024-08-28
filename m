Return-Path: <stable+bounces-71433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA5962E7E
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 19:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C91B1F22EBE
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8161A7043;
	Wed, 28 Aug 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBlFGv3t"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186A166F2B
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866197; cv=none; b=Zpi+WmhlNULJ+dVt9HrMiJZjNEMS9t7l0MN+uJSU/Fa1JYCkn8RiLTDy4eOjTsBoobzQIMdZY8fG75LeyEiXzRL87DI+4yUL1bjK7lzFaqgXk2j6RBly4uKFuWqvKuBcb8U2c/A4RNIzUZCA2gaCAC/yLUbhbSILysZ1o9Wm45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866197; c=relaxed/simple;
	bh=xq2862FC2H9fTr3XeCMmA8f8ZF7zdMx9ormtEYxTxxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaLzAj4CZwPUck9golaJP00UxKavQkZRm2x9QvuPKxC7sQnv7WjCh48pM60U4hUsI+OpTYu9a7m0atSZ9G6Sh5iso3M+DDMVi0wzGO6fIv08lg+4UZKShklcknO/RqiEDygOOlCCTTz1D5pcWyHIjLlh0PZ+lU5RWJFjU3d61QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bBlFGv3t; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4989b18ee2aso537333137.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724866194; x=1725470994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jO6WbuA2uYR9pLaLcnV8sYv7zeqotikN0u6aKu20M7M=;
        b=bBlFGv3tpMvKT9weoBVDiwXPPn95LbdblNXbZIGVmysfJc7afXB1MuJgOjNilvvczz
         gkxcaFzwD1KNLLgcF7lDWD+TmTecaK4O5UdE4dSmpsZRo/Axmlorpy/bMS9BToheRXVR
         MxI4nqIK2QeJLSSh7mOHwHETnVrqpbCLspSnAbCZtpdy4g1xXFHRXDgNBGQRnjphJ8Ca
         EXHfuD0QtjSrkjYx6Ic3CqegxfYSTTPmarRD/5gcEUl0vSASM7Er+4xH/TrAwah4VprU
         eJ1MV6Dype/+NRrds9C2v3BBw7msVls3QQFQZ30tYNoLkaRSsajNLHd79GRGgbcCdeN1
         t6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866194; x=1725470994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO6WbuA2uYR9pLaLcnV8sYv7zeqotikN0u6aKu20M7M=;
        b=EDkwOEBX28HguYnMcT5qRdUdRCcjlnx1ZOnXlqr71TABc8mkfacMkwq2C9KlN3EL+6
         5qk0eFm42J9d7yvW/yujYgfWu8EIZ0h+xjwY320weX76J2CKQg1gs5NXeHPbx+nWkmJY
         Z4m4ggWEWzRl6f2dRMztC6RKSXatSbrQ0g0dl/XuUEvAjWuD7Ac3TWt84lE9P8EN1xyy
         5aNaO+mgwqni3YgCsAmVJLAeNpqgXNkbv5vqV00R/BjrJuJ5QtC+/68vxM8GLIx+3K0Y
         nkqDwWcShgE/s7ArJw3Hpjl8O8c9HoKE+5QjxeHkVlH9QWcMle73+tlzb9wL95EG4aMT
         rhPQ==
X-Gm-Message-State: AOJu0YxqcaF70OGMMKf71pVz1GlxVSvveD63pgucPGOLG5hmr6QnRXKN
	nh5fuyVZVxgeacWqhwzGS48RmfJN23ADaIkdkhujA6yFbb5NCT98oIH3aaYZfS15X7U3YK9oZCM
	xcU9tirIlzr5KkfJ/ipbVB+BTn9MOVZl3ucH9GXSF8cc9504j2ds=
X-Google-Smtp-Source: AGHT+IEiCFyB3OZw/XIox94ixhU3xa+nvwgNWznRK/vYEYi1rvpOzRrq8hn43RDFNhXIlTGReAClTYmoduDr2yIbeqc=
X-Received: by 2002:a05:6102:3051:b0:497:6ae3:e541 with SMTP id
 ada2fe7eead31-49a5b5bfcc3mr398727137.14.1724866194092; Wed, 28 Aug 2024
 10:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org> <CA+G9fYuVcn734B-qqxYPKH++PtynJurhrhtBGLJhzhXoWo0sWQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuVcn734B-qqxYPKH++PtynJurhrhtBGLJhzhXoWo0sWQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Aug 2024 22:59:41 +0530
Message-ID: <CA+G9fYs40THj+m4hWqV3ubYBPZaWQE44SXOUYYuU1T0x6R83Ng@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 20:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 27 Aug 2024 at 20:12, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.48 release.
> > There are 341 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The tinyconfig builds failed for all architectures on 6.6.48-rc1.
>
> Builds
>   - clang-18-tinyconfig
>   - clang-nightly-tinyconfig
>   - gcc-13-tinyconfig
>   - gcc-8-tinyconfig

The bisection pointed to the following is the first bad commit,

bc2002c9d531dd4ad0241268c946abf074d2145d is the first bad commit
    rcu: Dump memory object info if callback function is invalid

    [ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]

- Naresh

>
> lore links:
>  - https://lore.kernel.org/stable/CA+G9fYuibSowhidTVByMzSRdqudz1Eg_aYBs9rVS3bYEBesiUA@mail.gmail.com/
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build
> * kernel: 6.6.48-rc1
> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * git commit: 0ec2cf1e20adc2c8dcc5f58f3ebd40111c280944
> * git describe: v6.6.47-342-g0ec2cf1e20ad
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.47-342-g0ec2cf1e20ad
>
> ## Test Regressions (compared to v6.6.46-68-gf44ed2948b39)
> * arm64, build
> * arm, build
> * i386, build
> * x86_64, build
>   - clang-18-tinyconfig
>   - clang-nightly-tinyconfig
>   - gcc-13-tinyconfig
>   - gcc-8-tinyconfig
>
> ## Metric Regressions (compared to v6.6.46-68-gf44ed2948b39)
>
> ## Test Fixes (compared to v6.6.46-68-gf44ed2948b39)
>
> ## Metric Fixes (compared to v6.6.46-68-gf44ed2948b39)
>
> ## Test result summary
> total: 175487, pass: 153815, fail: 1637, skip: 19813, xfail: 222
>
> ## Build Summary
> * arc: 5 total, 4 passed, 1 failed
> * arm: 129 total, 125 passed, 4 failed
> * arm64: 41 total, 37 passed, 4 failed
> * i386: 28 total, 23 passed, 5 failed
> * mips: 26 total, 21 passed, 5 failed
> * parisc: 4 total, 3 passed, 1 failed
> * powerpc: 36 total, 31 passed, 5 failed
> * riscv: 19 total, 16 passed, 3 failed
> * s390: 14 total, 4 passed, 10 failed
> * sh: 10 total, 8 passed, 2 failed
> * sparc: 7 total, 5 passed, 2 failed
> * x86_64: 33 total, 29 passed, 4 failed
>
> ## Test suites summary
> * boot
> * commands
> * kselftest-arm64
> * kselftest-breakpoints
> * kselftest-capabilities
> * kselftest-cgroup
> * kselftest-clone3
> * kselftest-core
> * kselftest-cpu-hotplug
> * kselftest-cpufreq
> * kselftest-efivarfs
> * kselftest-exec
> * kselftest-filesystems
> * kselftest-filesystems-binderfs
> * kselftest-filesystems-epoll
> * kselftest-firmware
> * kselftest-fpu
> * kselftest-ftrace
> * kselftest-futex
> * kselftest-gpio
> * kselftest-intel_pstate
> * kselftest-ipc
> * kselftest-kcmp
> * kselftest-livepatch
> * kselftest-membarrier
> * kselftest-memfd
> * kselftest-mincore
> * kselftest-mqueue
> * kselftest-net
> * kselftest-net-mptcp
> * kselftest-openat2
> * kselftest-ptrace
> * kselftest-rseq
> * kselftest-rtc
> * kselftest-seccomp
> * kselftest-sigaltstack
> * kselftest-size
> * kselftest-tc-testing
> * kselftest-timers
> * kselftest-tmpfs
> * kselftest-tpm2
> * kselftest-user_events
> * kselftest-vDSO
> * kselftest-x86
> * kunit
> * kvm-unit-tests
> * libgpiod
> * libhugetlbfs
> * log-parser-boot
> * log-parser-test
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-hugetlb
> * ltp-ipc
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-smoke
> * ltp-syscalls
> * ltp-tracing
> * perf
> * rcutorture
>
> --
> Linaro LKFT
> https://lkft.linaro.org

