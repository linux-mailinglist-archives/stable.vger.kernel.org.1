Return-Path: <stable+bounces-42952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB28B956F
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 09:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9ED1C2116E
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC1225D7;
	Thu,  2 May 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZXuSNQU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CF225AE
	for <stable@vger.kernel.org>; Thu,  2 May 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635817; cv=none; b=F6EoqJAdNb9nVsVVr+UrqsIDRZAI2JMf67GWKYpmcxJ2jba7BTSdrUpa/Oe71TCXjtiXnkt5+i33y+5HRmCZkNsTkIT1EhW+B6GlGCvgQH87SystW7Tr4bEiiHVzo/wZXtyirD0njRi2jrHppWSH0wEQ7dVcFibpeKI7Se0qsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635817; c=relaxed/simple;
	bh=rDono9JDP3oaHl15CED3BRbCQJ6twVEr8Ie1x16gH/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRbcF5bmwSCN+qiU27sfMQLGIZDwpj6wnp96Zg5wsoD7lK1UrxYiYpuNzp0uf2cj5OChz6sghVHZ3zXdk41KkdAJ7A5ovj8uxHXJilNNd/9CuaDceZmPghDQlAho2P5EpIbfXUppCIWDAiUVAWZJ5Hrwc+TB1qa9tvwmN1Ut/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZXuSNQU; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f386d05e92so476945241.1
        for <stable@vger.kernel.org>; Thu, 02 May 2024 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714635815; x=1715240615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rcob1TfnhXb+bEn5tF/RI3RqQrQ53a9U7OzbM4Ax2nE=;
        b=vZXuSNQU25AfnWQXy32SreNO8BVNkhpi8kiD163g4yfWeh5M7nPp9Bx2VNd1ZvFN76
         a1xK3KW1p1zTTaokXlQhF6JbEFRpKSnRr10ceacvPHQgtdJagUghGHP5nHc2D1S5Nj/p
         W1HDg5alMMUJ4t/lThZE0/0c4vHEiO0n+QuIij90wMMNUI3FWoaz9qCfoZoxKJCG/8GP
         bZbWQ5y15bBDgAK7/w5HCOmiDpLDCanhcwSZVjQDJkC+zwI8lkvkpoQrFiHLK787BVzn
         lJuCKnST7U2A2Nv0ThoQbWQJTdrDhE+Yz9e8bEOi2fXQk4s65UNsA+V7IZEkk8rtn5Qf
         Qv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635815; x=1715240615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rcob1TfnhXb+bEn5tF/RI3RqQrQ53a9U7OzbM4Ax2nE=;
        b=fLuCZV8KoFPioOxuWu5OGlaLja8cuK/V6CHIVYorEoqzsHdl4Bbrg3Q4gQP8NU+slo
         cck4VEczON4vvocpP/5Iyg4gtOZmlLWLKw8aRC5psdYa24fmEywqoKiOVC3kq2zPNQL1
         OgTr03wEt4HaD0a4jg691zC2RJfTE1U/HMdqCaDQEzRPK8gG9PeWXLquBI/6hHCctR9x
         ULpiBZbb8hNhlhMfA56Q2J3gT7eOuIfZ8MjH4spILUdgWUQBwLKSZgwZnWK9/b0r7lvj
         bUcqra6SXPvi5WfkaSkTCCLDeYDNVMTO5+kKtquotsqBv0SGSb+Zf7+v9g/UXno6JXrk
         q4ZA==
X-Gm-Message-State: AOJu0YwwGx4zTyXBSaDqpg6zz/wYVJ3CtF54ifJQN9jcoWePBP2vckYz
	YGse6wEFedErGxyFH7cBxpvjU7PkBqqxSq2VBagslcsi9gLKO+DJLvEzkRB6RDtGuonVG8DbVDt
	iCKo7XAHH5/DmoVnfnkkleai4Zsf1txFwLU4iKw==
X-Google-Smtp-Source: AGHT+IFvrUNNJeORwF7RJ0RFDFEgsKfOtCpFP/WQu6feSafNZETbA70DvepwWypWctu3kv/IkSZEjHNYdd4gxCFiJvI=
X-Received: by 2002:a05:6122:3d12:b0:4da:e6ee:5533 with SMTP id
 ga18-20020a0561223d1200b004dae6ee5533mr5611768vkb.16.1714635813741; Thu, 02
 May 2024 00:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430134021.555330198@linuxfoundation.org>
In-Reply-To: <20240430134021.555330198@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 May 2024 13:13:22 +0530
Message-ID: <CA+G9fYuX5H_jwpYCr+vS2W1G7J+mG67M=D2DYwj7L9MN3=89GQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/106] 5.4.275-rc2 review
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

On Tue, 30 Apr 2024 at 19:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 13:40:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.275-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.275-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 6c530794f59e8e3bb37b90d4bc14a70ec7d657dd
* git describe: v5.4.274-107-g6c530794f59e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
74-107-g6c530794f59e

## Test Regressions (compared to v5.4.272-183-gc3a33bc34a87)

## Metric Regressions (compared to v5.4.272-183-gc3a33bc34a87)

## Test Fixes (compared to v5.4.272-183-gc3a33bc34a87)

## Metric Fixes (compared to v5.4.272-183-gc3a33bc34a87)

## Test result summary
total: 104581, pass: 83299, fail: 2741, skip: 18467, xfail: 74

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 35 total, 33 passed, 2 failed
* i386: 23 total, 17 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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

