Return-Path: <stable+bounces-134744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F2AA94744
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D721744D3
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83C1E3774;
	Sun, 20 Apr 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrhhtZVR"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48171CA4B
	for <stable@vger.kernel.org>; Sun, 20 Apr 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745138252; cv=none; b=jMVlHMRv64oNSgw3p6onuCn5HRnlQd2N0g52ECokoHl8pOpUk8E2lRnWHs91e5J2twHejSlkUZHbuBoOHH//WLrS2NA71t8qKmxLxgaOtNmNgbNgL9LinWN9yf//E7yfog1QS/DUc2NEebfg7ca0yyQwetnxxZP93hVjCJJg+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745138252; c=relaxed/simple;
	bh=XOedVC2OqIkvM32YOlVepMWbA4ZVgTX7dcNX9a3iyUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opck6D89yUiR+AVZQ86Xl8C3WCqcQ9lUjUe5X/piRieZZdW52D+Jh+E6AH6FYPFJtBjLAdcyJQc3wl3Gn5FfN+JF2jBb/1BfKGGDTFE/Re/BkjGYb9ZVwLv+6K4J2DiY7YO7V6uE/93e29Ejr4DFQkmoo0eGpPEv1+/GMTOTdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SrhhtZVR; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5241abb9761so1231498e0c.1
        for <stable@vger.kernel.org>; Sun, 20 Apr 2025 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745138249; x=1745743049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKGy/O1Y5X3EKpR0Pd5g6I+Zj0C1CEMV455BmTDC5pI=;
        b=SrhhtZVR7gELTUFkYqKiFbnZFeBI52bVxXO5s6sGFewqnKb40IVIfQIO9sLWP7JX+4
         pc0fzW+QsJelhdRH6eYhsSR88m+xnE4QFpMFA5x//KBCxFRGV5BC0Z9ca3FPLwETjf2N
         5XZrQE6PbsBPgynyCjWxR3uUFdSiTveMKRKqu70KsnyHXyZlTJuJLrnVF00BEHGGXlPj
         TDiKdVamOwxN8H/qviirdx4CTzL+kIP77aofextlfSYjEKdljHyizztdB/IMJ2n0F7jz
         tpTFkjYCaqMsJH2qtvp2GH4ISJdVpdy1GGvvuzktDbzN3iQNduhmPLjCCFCYUMYdNNSl
         7SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745138249; x=1745743049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKGy/O1Y5X3EKpR0Pd5g6I+Zj0C1CEMV455BmTDC5pI=;
        b=xJHo7okvK/H/RSZ5BmULcl1Mpl/fl3jMBUUzrUPIoVY8/5Iz4nltcQJ1VOvyvJ43wk
         5ESCS5UAb5kq4itjxI6cN68wQ8a8AFt36WzFkxSofL32j/vFLxdmyFBGQ3Z3N0La6jyP
         LjCIrASdAb2Md9TS59lrXuMhbgphT7u9zhdEleStjbU841eL1On6LcaTF2bYkcfBPARl
         4qHSFtsagq5Zaj2c8i3XoothPlOYGFnIjc3fR2c1hEKFsYnXTHYxzlIIvTJw18/ykdzq
         rMDEX8UtTMvBnq3DvADyliODxkitZdpHNIP/Ze5l9LsXeUpq9HpeoiW8O8mFJR/ct+MT
         fVTw==
X-Gm-Message-State: AOJu0YyAHWG5cBU07u6Zqdzzrj3TfkwDaiLmKiIkznRcVcrIpFRcbRmt
	WKDCXv8P3DNFqX+nKoL2Nb8YpC5xtbx2ieBbxhJtXCzICsPinlFxpw/oFBAVUpzOk20RAUGq7++
	gq4HvUxAb5e8biQU8hlmk/ZBhQ4SPkdfgxJVEhg==
X-Gm-Gg: ASbGncvcxkdVmq4CcegwqQBOrMzIIaJLhHKZjch08sn6jm53G/elXIXiLNylUPWbarm
	qw+7jb2F+RoMfEMqV2gT+rL9FcbDGec89d8njiM/1AJOYidw7RV+3beE1MY4XubdDKY5Nd/ERoe
	imEWfuuQ0//CS0mrwJC9Tstfk4TpkipIi0NnLqmc1I+gKO2iCWpcR6ZZE=
X-Google-Smtp-Source: AGHT+IFyyBbYrrnY3oRNhMICpkh3U6C14+ws6Ya2UK9tFei4AKCOzunP7pbazBufbKc+pkOMt7WmkbcrFYD+ebFGdZk=
X-Received: by 2002:a05:6122:3109:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-529253df465mr6314139e0c.3.1745138248931; Sun, 20 Apr 2025
 01:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110359.237869758@linuxfoundation.org>
In-Reply-To: <20250418110359.237869758@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Apr 2025 14:07:17 +0530
X-Gm-Features: ATxdqUFaBu7M7XklmnYHibRuXM6rlLQtZObQzh9w3_qgywS20rS88v6OMHfqzs8
Message-ID: <CA+G9fYtGn8EDdkUNpZNQR+Z4+GvhSzgGYw3X6sZEEewRG-2M7Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/392] 6.12.24-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 16:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.24 release.
> There are 392 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.24-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 dragonboard 410c boot failed with lkftconfig
on the stable rc 6.12.24-rc1 and 6.12.24-rc2.

The bisection is in progress and keep you posted.

Boot regression: arm64 dragonboard 410c WARNING regulator core.c regulator_put

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Lore Links:
 - https://lore.kernel.org/stable/CA+G9fYtaRQhArip=UYkLt864AnXBD6Y07-06CjOJZYSDZ858SQ@mail.gmail.com/

## Build
* kernel: 6.12.24-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 7b7562936f806e759a787c58a46b0c9ce988f15b
* git describe: v6.12.23-393-g7b7562936f80
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.23-393-g7b7562936f80

## Test Regressions (compared to v6.12.23-2-g8e0839d16957)
* dragonboard-410c, boot
  - clang-20-lkftconfig

## Metric Regressions (compared to v6.12.23-2-g8e0839d16957)

## Test Fixes (compared to v6.12.23-2-g8e0839d16957)

## Metric Fixes (compared to v6.12.23-2-g8e0839d16957)

## Test result summary
total: 147158, pass: 124098, fail: 3723, skip: 18937, xfail: 400

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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
* ltp-cv[
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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

