Return-Path: <stable+bounces-71410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8896286C
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB61C21996
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163511862B7;
	Wed, 28 Aug 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMp8wDyM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9D1849D9
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851049; cv=none; b=VrNslVrHyOtU4b5totVtN7XeTJ645LZlSh7fly1Pq2z9xO+ZgVgFlgLvMx/Ea5nYGROohyuwWnpqq8nKE54u4Y9SGpDcXxPPIg4VsA2NqxrUaLjRKzD24TzsUHqJFf5wD+sURqM0axeifPa4P1X9IAvc/MdfWrDZwQbIb8bWRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851049; c=relaxed/simple;
	bh=hPDWqLIHM/DnZGu4RmS69ayFXne41WlztcIZGcd8f8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbGcrNMA5fVt7b9jzkFo8Y+7e2/1UHIWUXa3mBThIiMDZhXf5rWTrr7NYv1pnaH6nCmg4RvTBPZXxy0xHHoUb+NDBOyD8K22ZmPGHGlxUShcae73Z1bSDt9O9CxQETZ9jkjhbe8qCXq5urvZ+dTI5IhfgiFkfDyXzXrdx3gVLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMp8wDyM; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db130a872fso1191461b6e.2
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724851047; x=1725455847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p85AmrzBy9ysQPfxftCN2WfEfLHzF0fIelXYs6ezfX8=;
        b=dMp8wDyMHW1Sj4U8c/zbU7ONSrUx6TJDwDtoxQNeOxP92T2uZCeBZX32/AtJ1M7m7s
         Opf6pD31La5ahEOvW39NRo/bCYjWXKBgQ7odnLun77Fqi3L+ND64WHy9R1MWAz3ipCQb
         XOA3TjLseLSx0pCLf8Zi7P16K4F8V9qPrybiJrm1zg/VYgNZClbHEQ83Mk3OBrOBBgVn
         NEkw3I4cbNdF/QL5H/IA6KxQiQJMDGq0u/KM39ePI6vB0UnM80YXfxp0omd6Hv6wzJr/
         R6vrCZ9030/nudMrgLebMVmM34TGygcuTSdfA00f70+NRdntwQmlDVkY+rh+08IPszes
         uhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851047; x=1725455847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p85AmrzBy9ysQPfxftCN2WfEfLHzF0fIelXYs6ezfX8=;
        b=lUbWefmg8B/b0MCBEslVgkFRX8wblJAXQ7MKtzcYdMx3yoiQDSL+2TxeGUYeP1IX05
         yiwdqNexlp7adfQsg1+o+sjDAttSy8ukOVcHS1UoLV3ynQ8RZThhHL+ssUh2Q4gXxZ2i
         1/3+t2GszIySJ/DIBuREsnYgDCLihTR6PF+ycgH1DHGSUDKo7pLn/vbDpaiK7lXS5Jxt
         /EEoBU/i3h1N3yg3ksI02UUKX3SubGVvaEEp8ijZYvyA1dXVN95REosZZa5UuJEvOJk2
         IDEz7zIMUGqk3R8nSwz8NDxxWF/bw2tLcabPeETenqSLPMN9TSgra+IqoqMp2xUpORbD
         wd7Q==
X-Gm-Message-State: AOJu0YxehoEyeI6ygRyoe8twkPy6Que6M4A0aI3UAiygTsnI5sjU0yUv
	qEGvNL1GGZx/DAjyEtSQX/H/tOO9X4mF3T9gVwgfdlZyyGyYXPpO3N/daz7AhAVr8q0kbxU/NpT
	Hu4xl7j2hly3Wgne52pnJ8t6r564Gwyt/qAGRRg==
X-Google-Smtp-Source: AGHT+IG2ZNqmCpvxZnZqXDnDiNptOQpD9bze//Y71Nl6tPd+HcMtO0wrNlyQSgo+kAl6HiZywcc/ScZhP0dm+GM7DHw=
X-Received: by 2002:a05:6808:3026:b0:3da:b3b3:191 with SMTP id
 5614622812f47-3deffbae250mr1974969b6e.48.1724851047220; Wed, 28 Aug 2024
 06:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143833.371588371@linuxfoundation.org>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Aug 2024 18:47:15 +0530
Message-ID: <CA+G9fYvH=+SD+UxZ0koz4rtm4XxHfG--oZZCpD0svEcODZ9pjQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
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

On Tue, 27 Aug 2024 at 20:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: aa78b3c4e7eeb94e23ce019c419141739613862e
* git describe: v6.10.6-274-gaa78b3c4e7ee
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.6-274-gaa78b3c4e7ee

## Test Regressions (compared to v6.10.5-26-ga522cad06418)

## Metric Regressions (compared to v6.10.5-26-ga522cad06418)

## Test Fixes (compared to v6.10.5-26-ga522cad06418)

## Metric Fixes (compared to v6.10.5-26-ga522cad06418)

## Test result summary
total: 171554, pass: 150636, fail: 1805, skip: 18905, xfail: 208

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

