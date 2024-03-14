Return-Path: <stable+bounces-28191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512787C2DA
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 19:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947631C211A2
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87874E26;
	Thu, 14 Mar 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZaR9OBb"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D63398A
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441407; cv=none; b=sEzqoXZTEk7HLgp9hNBdrLZ/hVe37efcF/mz/MhaXE6J8Mxoo7QDdZ9eRxbdcppOJzIXvzVsG0BRftcr418Z6IUjB/wk3KAv7jphX6WXy8eaqEQMCE2p4iKCONmQQ0xCxjtLMBSLbX2YXegsO3Hnmca8PkmCZY/izajV4js8ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441407; c=relaxed/simple;
	bh=3k+VrxDwa70WtizOQmXYHJ8G97Gl2+cm55qibdppwcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADNWmPnQCTtDqIZE2x497fpPAtnPuqxeXBhnzvGLF3Psr3NVBdxcOtNgfqRCP9T2Ts23dQiqp4uwRv0VwQ0dERxug4yrTpx2pByvlMJznFjEpy84Cr+jtJqzBhFNglYsgVXux6m4azdaDNjDRzNOlTRbGuZMoc2mATUgC84Y1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZaR9OBb; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-474c8333fdeso402444137.3
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710441403; x=1711046203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcX0Uep0pLIUzMsPSa7FXdMMMsvS0Nge/YTeKrunsA=;
        b=UZaR9OBb9x+Hj9vSjoLxzJjxCsIT3GrFoOeCDl+nyyyflwOpcmIqsyWLg9WS62Hgyc
         MwmHrLPD5YHLg4UyBwRtZ5pmJXNXaM2Yc27vDaIYg+kyV0YKQNA5ia7HJOEF6dOBxtB6
         Pl5OmMBHJDwaFc1h0bifzquPiVSXl0buh8K+4VTS4Zj22hGOFDJqKvaHE4/f3t27s8FD
         VDq0dgChLAYfrWR50owU983pbWurqjBiZaZn0ByY8Y/nfp9PrINMfDNa70v/zV0R700b
         CrDJkHl0scEKqe69g+lDH1r6eNaWWAAkXH+NK/ohzhp+1QjZBlbO0kzWTJKpPESKdXFi
         pG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441403; x=1711046203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEcX0Uep0pLIUzMsPSa7FXdMMMsvS0Nge/YTeKrunsA=;
        b=mf0YyGyS1rkEs3WCr18ETWS6Zcyho6kYnGXHPZgs6DpIkrVZTSaPrbWWLpzdgo7Myi
         1D4iyHI5laIZWSFDG69Zi870cr2ur1Wr8THBZrq7aRiLBR479Al584AsVGwduVAu+YbU
         W5c8QK5PhhAxx6YLtO1BcumtJN5usLoTpjcM9akBtyR5FyDl0CzHBa6BynRBsYBSPzaT
         uVnz0uhBWsR4Q42ZV7Irylg2rDzfr9X6zNp30+IjanDbKKUk3cOyBQDw+uovuYyQ745T
         RIbdgr8F/QacPXQPo0yZHi1N3I4O9cRld1w2rP1C3Rbn1F6U4D3I25FXz5zZEkuvFbyz
         l4YA==
X-Forwarded-Encrypted: i=1; AJvYcCXLvv0h1jGIGQpXw5/ZTCqpFSYVZ2RvattHCfADy16Ki6HR9G3UGxgjdTyTtXDJEWb56LtAPW2X1NMFhZqAMNvxXYd6dTRn
X-Gm-Message-State: AOJu0Yysw/Ark6EhmiqePM2eu+9uD5eREeMYrz1gr04ocJ7HZkR8w9Jz
	N7P6fWEQqpb0FzrwovqyNbMOwK6l+yRABW/g8oRHZJ2QPjlG2AtBxC7WNB5TC7sUlyYrcWkNT5s
	7litbYDHpH2FUXgM+eyaJWUvNuqJhW0teJQzzpw==
X-Google-Smtp-Source: AGHT+IE+99XkY2/NlibDgqoDI/34ZCAGZt8CUGDMDDywEAd/UigCDWYRk9S24bwUGR1st9rmSZikIBXzx1WO89HYXJg=
X-Received: by 2002:a05:6102:128f:b0:476:6d3:dec1 with SMTP id
 jc15-20020a056102128f00b0047606d3dec1mr2450675vsb.17.1710441403461; Thu, 14
 Mar 2024 11:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163019.613705-1-sashal@kernel.org>
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Mar 2024 00:06:32 +0530
Message-ID: <CA+G9fYsG58KQ6QJwoSccF+B9XsNJMuQcD-TquBHccQsLzKdPfQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:00, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.8.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:28:11 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.8.y&id2=3Dv6.8
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: aad69864e4400284b2792c16361be9d38237348b
* git describe: v6.8-rc7-266-gaad69864e440
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8-r=
c7-266-gaad69864e440/

## Test Regressions (compared to v6.8)

## Metric Regressions (compared to v6.8)

## Test Fixes (compared to v6.8)

## Metric Fixes (compared to v6.8)

## Test result summary
total: 245920, pass: 214243, fail: 2828, skip: 28849, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 129 passed, 4 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 33 total, 28 passed, 5 failed
* mips: 26 total, 23 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 28 passed, 8 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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

