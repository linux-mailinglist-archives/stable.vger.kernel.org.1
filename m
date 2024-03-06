Return-Path: <stable+bounces-26956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8178737BC
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 14:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F98282D5C
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CC5CDCE;
	Wed,  6 Mar 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJAXNWSl"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61112D767
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731935; cv=none; b=IiQLkQ6Jlcf9iDJwZ2o3nZQTk4rwHIN4wlMPEFardcZqxCekOZnkBwduXwaYChbd5/8iRtJ7dFYvibPnUtRb1dPCRWmY6CUtE29dIEeV+FGoteSOV8hGu/ZYiIWkHnNxoxA6HHpewQ9Lg+Yikt78HE3MMSe7osnkvKlrVnk4VPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731935; c=relaxed/simple;
	bh=JShlrHlvSrWcV7xvzKNa8bOyHN6KPV5FA9UCm9W9blc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nF4UNgktwzqFlhiFUDU9shiGmDfYzTbvpEKkUv7Pv2nxcZ4WuVgngpGTW6LqUF5ZKDrm2uggu8gcDMvK6eZWp5648iMcXuGVrRlnWF+d2iigfo/0u21O2DjzwhhpUjepDTTuBqCuhyhS4to3yIAR8LuZePXXYKV5VdsWoz+glAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJAXNWSl; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d36c20d0f7so462184e0c.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709731932; x=1710336732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VVJliLDnPnfl5S46gj2IcyJBhJ9oBjofP72vxE2Gys=;
        b=yJAXNWSlMYhU11RC8qKczN0bcY1z7K3knKS0SFdaPuHEb5cjsNEKs+7V2g7+iVxyYr
         DAKlJ48qyqC6Irl7+EJEtyZaThOVQfCT1hXK0tnpSwO9dVjM5aMA5YI3LeyHl9P+QIim
         NWBf3+Yhys92Ys5Aqwigk6Dqiy7USVM/HL1ITr3K6p5ODb+e9bPnpKNTL9ymzq1t2aaS
         jeFgXof7OA3CHsJ5/tWhGD+7K9amcU7WYtp4hwASAGDbYmVXiepSagss8iTQx1pwiySu
         KmTTk2ANzn2HjqchFvRYOHOR8qu/CO9p/AiGE4VXclCVmrJeT7kgit5DKjHr3XaaCtyh
         XRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731932; x=1710336732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VVJliLDnPnfl5S46gj2IcyJBhJ9oBjofP72vxE2Gys=;
        b=KmiWssipMXCzrRMgDqd7ID/AZkEMWKLVgHU0WTH6E7EVZJoKJWbEQTCnuxh0H1F1kO
         z1u24QxOH/J57xQ5a9oMiS/ytvF0ceLq6s3d4xdZJlfbGvqfoQv8O78xPZGifSOsobMe
         5EkdBj2nCqmU5Cg0Z38KtMHVtu27CGAq48UFXlkeLypSHMY3eaJ57wvfcBi6ClhWBHrL
         XAq81bgVOBKUrv1GH7xob5m6DmVJ4I1QJZLDGScgUwDBZ6B+FN1wtWNGgbNwtMBf+QuZ
         s/UlHkHvf5FxpzjTSPcqgYxEB0H1/CEtSFrrPFTA496ntyFwSKxWlvlBBiVmg51f7pV1
         BCXA==
X-Gm-Message-State: AOJu0YwdTNNFvK1Wdq8pa/paL2QtnQSPSCgXEPRjqHEBR81HpeFKIcfu
	kYcU3MP2d65YyDU+qbBaWbZuyTlmDuzcNEZUapY5CO/QN5hSSh/p66uDD4EUBy25do7iSmKwvgi
	Gw6RsPzHi5UmE6JdtUeET1CKHlVHnsxORupsvWw==
X-Google-Smtp-Source: AGHT+IGxrMfsJxszV9jZHqVuSGYENy3aeQ3AbkXLJV/S5S4sAwGbtxZR2+omrhWCMoCVtr2KbHbLbjE8sGzttOREOAk=
X-Received: by 2002:a05:6122:1c82:b0:4c8:a2c6:c2be with SMTP id
 eu2-20020a0561221c8200b004c8a2c6c2bemr170851vkb.8.1709731932343; Wed, 06 Mar
 2024 05:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305113135.403426564@linuxfoundation.org>
In-Reply-To: <20240305113135.403426564@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 19:02:01 +0530
Message-ID: <CA+G9fYsAG=7Fx=8JZQPLqnSVWqU02d1DYn-GiajCND0xn_c+BQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/83] 5.15.151-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 17:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:31:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.151-rc2.gz
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
* kernel: 5.15.151-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 7466986e020d2a56ac0fd1d1768eb9c01119f652
* git describe: v5.15.149-331-g7466986e020d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.149-331-g7466986e020d

## Test Regressions (compared to v5.15.149)

## Metric Regressions (compared to v5.15.149)

## Test Fixes (compared to v5.15.149)

## Metric Fixes (compared to v5.15.149)

## Test result summary
total: 92511, pass: 73909, fail: 2625, skip: 15908, xfail: 69

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 106 total, 106 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 30 total, 30 passed, 0 failed

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
* kselftest-lib
* kselftest-livepatch
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
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
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

