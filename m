Return-Path: <stable+bounces-124138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B60A5DA67
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F08189B94A
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930823E325;
	Wed, 12 Mar 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykJtVod8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4670237160
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775139; cv=none; b=s7qulIhgGDduAcRFVPfxXqrAI9gLRnf1QcrH8BuZPiixlZjG3/xWAK1OWFC9eXlBZJOImNQ2MAc00PyUhdhNqUqYx5PXMUGr1Vl0IxlU+dNfI2A2H4E5WTylEB+hKJG9VzIlzrmaprHdP6aZNmQPsLCNEhOTx5yvOXI9RLpe3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775139; c=relaxed/simple;
	bh=PDHO7y+ERlJAnN05ImfV1yuUpp0i/lJuWqtTfGpzzzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/mYOMYhkm1rYVhTfX7TA6aEGL6Gd6v+STEakqSytZ1VUv83nUgHzRrSxM817sDU6oRP105uTI5UIqUif75KOchV9gXZRbWfpQS2/IwkyV6HYF/wJGSzLpGV5CAAkxNblq5dbhUkwGmbvSdEgoYYa/hzkFBAMBgRoKHAH3RH9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykJtVod8; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51eb18130f9so3065508e0c.3
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741775135; x=1742379935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGtpHZfxRNzO6OoMpHooKBsRfISaZAIh8bkBtSxi4jk=;
        b=ykJtVod8q5rZWeryyKys+KQUnJbZ9bbfdm8dbbiczIQ+8NKlRUtNuqi024vl+83qIS
         LQAHBYGVOhir3s/BVvq2IthQwmAGrDOnZggcFzd894t6WhfyNl+LSr8C3K6cQzpMg8Gd
         D6eiLJHAmAB4RBCHBauzxihWO0wvcjLqkzcQDVeMz8K0zRhzh+iN0tUBlAVObWgSp1De
         /IvIqCaZURWPrf072k/XZCfR/lCHUM4itDYBkmpf4dEqaqMl6EtbI63890FrKocagHMT
         VPjfPUJsQHhsdwoVy2EixKOvBRcjWi/0weg2Lhnlsul5leJ8cc64qeYMFv3ryRJdNEZg
         sYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775135; x=1742379935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGtpHZfxRNzO6OoMpHooKBsRfISaZAIh8bkBtSxi4jk=;
        b=Gte/N6wujD3jsvTMsLeg+rcw2pl7E0k51t+m6dxPm4O0ynUQX6aI3Wnh0GN17iXavS
         bD/U3laq6gNUl4bxSjvhAtIcNMXQDTYPhpYhMWeaGLWrJ6BSmNzXCVpLK/DKFBKpyUPB
         c4ZUEJv4a0Ox9/S7AqvtwSvAE57sjfE2DaoE8RunRX7akrKrHyr/FeJ3MRq76OtYjgu5
         hL7Hk4riQRiiH9ouyK08WEC0HpgUt7SyKx6T3R9TWzbg5HC74i1TjtKPvy5p045d4IaR
         hU1GDnhDCFhxFhjMZityMGmnxUy2R3UNNWpMmdneLodbPk663hBXIoJr9U/PMjK7FPx+
         X/cw==
X-Gm-Message-State: AOJu0YyiartDtQSZUIwSGTLxv8F08i8zAhHNstndzEtKEJMeVu7mhj4H
	Drwf+I8oJAHNC+XFNhSyOlNcgMRh+5gkbJbeFXKL9dbReGmQb1y6t5XdglH24T92UkDpIfi2GSD
	TAfiGVXR4foZYe8YaeAbha+8AC3RCe6sFf2WVvA==
X-Gm-Gg: ASbGncu/4HrmK3eiim1rf9u+OCY1olBT/kn/CsxpvF3zFrqjltQrLv2yfTqHqN46Tkz
	B4DJnVW0BvnzYmRiHZw1u5aVKjvYVBC+XyrGkzgRix1YtcRS8dqwAiNb6lh61xT5tmSuoUqv5ZO
	S7Y1KD16YRtesruTNSg85XIvT0VRl970dd+qxwBc4uOjYfpf6CK+vSMsosiJM=
X-Google-Smtp-Source: AGHT+IFL0HreR/KlcTDMM5OcMZYgMMEODEZdj0hq7LqEb2TK1xUYjtp9ukuN5QzK8OoEYGp1qR9p2Zj/muGfbshTL10=
X-Received: by 2002:a05:6122:828e:b0:520:51a4:b84f with SMTP id
 71dfb90a1353d-524198002dbmr4416579e0c.4.1741775135572; Wed, 12 Mar 2025
 03:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144241.070217339@linuxfoundation.org>
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Mar 2025 15:55:23 +0530
X-Gm-Features: AQ5f1JocR2QVAetGvMUl47oG9R-0y5q4g7PNIHcghhHTaNTnPuThs4tcrPj0feU
Message-ID: <CA+G9fYuK2dHLg5AGVyN98eRKwZQ-aMByvhBLyasHuJRVLNkpHg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
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

On Tue, 11 Mar 2025 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.7-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fca1356f3f511f72adfed5a76ddf17a30241474c
* git describe: v6.13.6-198-gfca1356f3f51
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.6-198-gfca1356f3f51

## Test Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Metric Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Test Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Metric Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Test result summary
total: 131178, pass: 107823, fail: 3844, skip: 19511, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 1 failed, 1 skipped
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 41 passed, 2 failed, 1 skipped
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
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
* ltp-filecaps
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

