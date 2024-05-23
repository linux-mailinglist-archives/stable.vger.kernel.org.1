Return-Path: <stable+bounces-46008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD208CDC24
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D01C209AD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E083CDA;
	Thu, 23 May 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3JEasDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B141272A3
	for <stable@vger.kernel.org>; Thu, 23 May 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499962; cv=none; b=N1ZxC2Gobs5oBWBY6fzTk8kO6bJlWyXW/tX7511oNxdUuUSjHsH4mzuUpoaPlylkODSNJdOepwwOke7X1O34WNSXC5ZQtFQzxA3G/jM9xJTxs4zKrAeOumzsKxa7Lf9KvPPa9LWgbRLmtwt83rzUAsc8EqSZzGMXsaBJiyldSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499962; c=relaxed/simple;
	bh=zkITAr7CmBWLO2M3b7jQcZH99hzVRibXay5tFUhl/E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YazPzBtzDFhnloKWEYLtk5LwUbldLxk98uyDNOQfwJaLUpJ8guvHu5a5Kb7dwy89yZqOJBjFdH2ZHYbXyVEee5cWIGEcCRKRPV72Clf43XMJq+e9ETltT/YL5b+y4xWI83VcbyT0p+sDWl9TbIqg/gYJosTPUHglECWaKKZoX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3JEasDy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ab9e0a4135so1205296d6.1
        for <stable@vger.kernel.org>; Thu, 23 May 2024 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716499959; x=1717104759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUt0t/lv5Qq1PHFIIh6EL2Y/XsjWxY/5yhdxX3CRxY0=;
        b=W3JEasDy0Tm0bM8Jw6UrZFbR0kTQmIUH5U3je6QKVYoZoBmvbghc9+eA83npXEuDif
         sYstUkwUOxHRiyGj0JIuRcxnPTyP00ut/JJd3W130+iZxOVLEMy6K2kc0ygUvYRWM7FY
         KIHSMSZqEKrG8NBWH8usAUyqQ5wrfIPWfDscHX/ZlRkna+4flOqbglmcPZ8NS6HjGDfi
         n3UaOZhcIOrXUuxYrYvd6cZwPE7ljzo59Lit42/Nh7+LmrTIpu/ryl28hRfdzV/+y6Cv
         AC3ORCJC/geIhGZc/WeQy6XUZUPoN2Y/TraMg+Bb3uG4aAW76g05M6XDf8am0lRmid+3
         6fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499959; x=1717104759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUt0t/lv5Qq1PHFIIh6EL2Y/XsjWxY/5yhdxX3CRxY0=;
        b=lYpIVK7Vi6LO/74B756vQ+VzdrkTpG+XsYVhUlKdGuaxO8DZtQ8klqPiaoXPrk35Ax
         13jbvLE7kcr3MNPF40NISqdNJDIEIKYdad5dL9qTlZj189niOs5QBgRToisoOllqOOIS
         /oOy7kk4x4LV5nQReRThbMhmtHJ+Sog062CCfleAti6Fky8VyiRw7ed1bYAeUcYP0Cxz
         qCSJM1lkk2Vjw3oQSxvq2ZjRZheTgO1HNC3MS30eJ67d4TM3yyqFqeTznYQ/JFfFR1TA
         jw8zJIZVlyxqTQNGhvfJpivQSDuzYW4C2mAT8IcPtTZVIcG1Xyx0KUIDPtLl8NI6C+N8
         EY5g==
X-Gm-Message-State: AOJu0YyeSQ3Fh/ghJejCaxKypkohmNqE7C13o3ucvWZZguqFjWOiceqb
	Jb90skYkrDwkkLIQM7LM/xx/Pb7DQxSu1MeRqEWphW9G/6AxyrPInAlOwwTs+CpAEYu+/sVSh0l
	yi+htNgoZBEZ0nDVR/0M7xNHeDavCshy0GsCuXQ==
X-Google-Smtp-Source: AGHT+IEuBNQdLSthf/iTYVwBTUTOk5SUNT6V9pX+RZqJC3Zt89SpmPn2fjjJFos5V7lmOzNq6/+DLzlZhfudIcKNmrs=
X-Received: by 2002:a05:6214:b68:b0:6a8:ed2f:384a with SMTP id
 6a1803df08f44-6ab8f5f4fd9mr72035616d6.30.1716499959388; Thu, 23 May 2024
 14:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130329.745905823@linuxfoundation.org>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 23 May 2024 23:32:28 +0200
Message-ID: <CADYN=9LRNB_T1wv2VW8Kqr6raHQKJ5FaiH_ahPYhy0cfvw+RCw@mail.gmail.com>
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
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

On Thu, 23 May 2024 at 15:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memory-hotplug
* kselftest-mincore
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
* kselftest-ptrace
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

