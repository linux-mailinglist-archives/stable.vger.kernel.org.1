Return-Path: <stable+bounces-89092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F349B358B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 16:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00C82833BA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD51DE4FE;
	Mon, 28 Oct 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3+pJxHT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5D1DE89A
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131148; cv=none; b=McZ5VVJaeKC0XCqR1lOUWXzwbB2Gg/zd9BCyO86MoCgFGTCNxKdmqDYPojLx8CwnR3S8d/ssUH09Rg0SFOMOW7XGY4HdK5Y/dmNx0GaPdOothlIhkC11HlVFuwJ4wy1xdrLZvu8eRcEfoHVbqjyz/VWUe3T3d0O9M2exCN8LiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131148; c=relaxed/simple;
	bh=2v+31fsAuqH5Or/7S8FGahDVr8vX2gCynpJPJHnnhyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aq3ckaswA7VB3eU4ko8I6lEK0tteACtWbjv0IEqXdP5hMif3bquFCcFtB60dXeiLnRCQaeF73S+SaiyRhl5XC2T2Iqg2z/4XIttaRlUV/11+3LIp7uF7UZxgnqv/j0fjYIcBzPQI3g+5IP05Bs6F4bFlJqIe06xqAOq8MBIdlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3+pJxHT; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fcfe29e09so1162878241.2
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730131144; x=1730735944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJC6auGRBpZe13DzVemmuLWUaBopi5nU7ExWxzvBshU=;
        b=M3+pJxHTCInfI2wxzh6MbYGWF+/k/WrzaEhEHyC30DGoiHzLSevHF3k3xtWEDCgSKA
         zf/qrfy1x85A3P0rnV0D5vXpGngzsnFiSDFUwAHE4xO12dWfBfImUHrTQ4VWxl8LpEAk
         e36A5ikOCdUrbJAy69JkqOTuOH4nMTaTuRhBklvOtO0t2JdfbXUUg5MXa6mlb2cncoE3
         AURtCUZbmPmM1T+PjIodzUghAP9a72DO0XCw2NjOVS87VdqRkJUXbND6ZXRp1iEeYHda
         JYw9UnqJqv94qTb9DYlpl0bDGnc49pMxshA4BJ3Apq74Fd/p7K2p/hEwXKPR62qAyp7l
         onBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131144; x=1730735944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJC6auGRBpZe13DzVemmuLWUaBopi5nU7ExWxzvBshU=;
        b=lBuAZ1hBkzauQjycmkHCURUjFh5FteKZOSAXSMFUVCNSHdItlaBMNRwOCGBNz1+kM3
         RJkHfdN7WCc89IY5nfuuGjtTGJZ6ZZtY/Xh3XbTP+vTe6um/XAPCKYaDOuCRldPAKtbu
         tzqGKsqonnhq5QKGrsOVu6ZdThYxUtZ5eAWbn8js+sVYFgqUffP40MuFjIr3PGEGhcVB
         7ZzCLOZw0eYJdH52hJZPwbQ5LrXso1f+8AsMwCKfBmd538Y+U4DSIGTX3vyHF6tgMm9y
         ek0gUeq8UluxIfkFwQCIbPiH6g4ZH4PO0mqOeNU5jL9WHfhRrTjjZoPXGCi8JfrtXKQl
         6Rag==
X-Gm-Message-State: AOJu0Yxugo5TOPPo0bbcitEFlquQGlDW2zFaqRuojBYyj4pUR4JvMQ3Q
	ibma5NsOLTh8QJHxft7JtkqSFNIdLOXQkGvRwFzxumct7bnm3gxvyWh62J4DhDndLdPrxax7cJa
	9g2SSlynQjI95M+qm7akhj0bCtREMyFLwsRcgzQ==
X-Google-Smtp-Source: AGHT+IFb5ipmqTDP6PRkDrrbgx6qFZCwCBWXaecTKmbEwMANvBnjLWkMV3ysuK/t3SKZVkuElvNc4qm9C0oifErOJUk=
X-Received: by 2002:a05:6102:3910:b0:4a4:8928:718d with SMTP id
 ada2fe7eead31-4a8cfb58da1mr7235134137.8.1730131144638; Mon, 28 Oct 2024
 08:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062306.649733554@linuxfoundation.org>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 28 Oct 2024 21:28:53 +0530
Message-ID: <CA+G9fYsK_qFQ1Y5UwmDvgLGp9KDapucDraWBTjPx+Xmi+wLx+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
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

On Mon, 28 Oct 2024 at 12:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.59-rc1.gz
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
* kernel: 6.6.59-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 02900c91433b84926f38cf08dbcf877e84697d21
* git describe: v6.6.57-334-g02900c91433b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
7-334-g02900c91433b

## Test Regressions (compared to v6.6.57-125-g6cb44f821fff)

## Metric Regressions (compared to v6.6.57-125-g6cb44f821fff)

## Test Fixes (compared to v6.6.57-125-g6cb44f821fff)

## Metric Fixes (compared to v6.6.57-125-g6cb44f821fff)

## Test result summary
total: 111228, pass: 91063, fail: 1276, skip: 18810, xfail: 79

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

