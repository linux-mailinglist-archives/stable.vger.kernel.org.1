Return-Path: <stable+bounces-25396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849586B560
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759272898E0
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0F15CD5D;
	Wed, 28 Feb 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtL2l9jQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342573FBB1
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139446; cv=none; b=ADhM+aK7nH5sPBDAWsrA6pGR1AclF7uaGubxiwtZdrIrSJae4R+23vipvqzESr3dVDC3u7CLNdB9NuciEQwXqXCPR3kA+aeElnusKlLbJEE0eBh0cBb6zct8asN/KJsMmLHvPbUWSR8JrF0yuli1VgBUnKDOWaFCSCrZkVsF8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139446; c=relaxed/simple;
	bh=oxbZNucaFzw+bKW6bDkMNkI0wPAd97IsaMqhkGuwG5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoZkuOHkcrPR4zYjiltn6wMhJPVUPPDT8SWEq9yc7jWTSXtuEGntk9M54t4kPMbFSLOMdb8nc1UjOOcedzCHM0RBCdj0p5L7hMs7R1h4rVfMmra8USWaKaIBhtiTglbsdTLJ7dXSEuIu3421VPUcZqZD+Vs0cmLaghPu/qh16Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dtL2l9jQ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4caabc3f941so586151e0c.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709139443; x=1709744243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8ZCXlkSEn9sHLTdA1hVAvLgAkoam9yf2+6BQoI+uFM=;
        b=dtL2l9jQjGhujsW3Ka85LH2Sdy/JxNHCqPvmnMXvccfcLJw6A0A+bv1ksuLoE4rSKe
         rXnc5vw9H0rWSjW2E3bKsTdR+9n8xggLHD4vUuJ9zgnoe04i6Hkdvt4jqD6C+iAcBlmt
         hLhyB3AvWp9dXXk5SkOjauAbsL3PGQJVmqxZ6yHioVJhLE8Pa1VXPMo+ogUpFOqEWn2Z
         LIAWenF/LFExaUmOtCceaKE1BJ1XtJm0j6KgJve6wLgOdyWFGzBd5xxaU6xCiTEJi53d
         MmTFDs1SNZOXteFqe23GqFHudTYmqylv0kDQv6NKTpXImKmFiIScjUcmAoampn5UfCVL
         1ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139443; x=1709744243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8ZCXlkSEn9sHLTdA1hVAvLgAkoam9yf2+6BQoI+uFM=;
        b=DLPZ83oibUKdBHxx1BxesRAEYFxAWEe7yesOXiyCCsD/NY2NS6ZicuXCCsHgNrxq5c
         1aOFmIRlMJMui7RmIzpGOQ5ZHqzcgGwjGvPWkj7WjhEzLzG8ZNOOSmcV4Gf/ws2ztkSW
         87ztoIW/IBhfsTuQq2SxVFwLJkfgTYAyVSNU5ci8U8iFXNTJzzpZjVIgKgk9uwDytblP
         ypPEcRKNSu29LkdulnA7+d33t2+MJSr9wjzlnCqGfQ4NCZ2ivj8PL7K/xBIqrqMXum3y
         TuVf4gMZB6vKGK/FXlrRFoF4BUJvnFWeZm4TWmjtymbNvdwg6BjdBfwDPZ76swywDeIm
         7D5Q==
X-Gm-Message-State: AOJu0YwuQ5f45Nf+pqbFunee0HDQzE9M0KyJXjBK3tKmWf8BMc/lO/TI
	ZklNG/JiuhQHfKp22Gw/PT6ryUrL7g3CMaTyscOAj+nrQXx445tLynYaA9otlyWrpYxZmsyHSx0
	I8EHJhB3aCeGVT+LdY6l+peVDrsE7yOwbDnsJIQ==
X-Google-Smtp-Source: AGHT+IGXE+ieJuji5Gf3xi7ZEA3I2p8k6LgKwtJ/+ODluFfA8K0fvyI367HZNofy3S28Bs6hldwV/7TMkAA4RddfDHM=
X-Received: by 2002:a1f:ddc2:0:b0:4c8:2803:9468 with SMTP id
 u185-20020a1fddc2000000b004c828039468mr14872vkg.3.1709139442794; Wed, 28 Feb
 2024 08:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131625.847743063@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Feb 2024 22:27:11 +0530
Message-ID: <CA+G9fYssEMP-2-MS-YCDBB5DtJh+GS2MDaUtVTjojbQY8-nRxg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 19:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.19-rc1.gz
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
* kernel: 6.6.19-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 3c05aa9775af6258ef849f6db3539689f244d3c8
* git describe: v6.6.18-300-g3c05aa9775af
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
8-300-g3c05aa9775af

## Test Regressions (compared to v6.6.18)

## Metric Regressions (compared to v6.6.18)

## Test Fixes (compared to v6.6.18)

## Metric Fixes (compared to v6.6.18)

## Test result summary
total: 193689, pass: 166903, fail: 2157, skip: 24386, xfail: 243

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 41 total, 39 passed, 2 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 32 passed, 2 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* libhugetlbfs
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

