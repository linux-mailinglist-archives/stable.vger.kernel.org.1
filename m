Return-Path: <stable+bounces-59003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA8892D1A1
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3991F2249B
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5E1922CC;
	Wed, 10 Jul 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQTrE6Pm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2101E488
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614667; cv=none; b=cJkDTTegiWuiCV3KkXZjY1YuQ5KrDDwC4Jf9vyueWgX88EZtGvOYvT4GVQypVOhPz9KomxeU+Bp2XT8KY+FmLvgFMDqrsBt0BNzZ804otkuPr2R4N6Bi8xZ/HfTPkYHO8J/tmbeA3Re+MJLiuAKGUOaYJFMdM3G+xVXtGqXSUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614667; c=relaxed/simple;
	bh=j2CB1IYugxTa0rXRRo+PzEw6wqFVB3MyPRvpWsJp/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0M/4oJ5yFuHEZVQH2xeGUDzooEYkuy9Cql24y3wdHdd2s4BYX7MiE4PyLQY+BFTC0X1I9dlnXW5pyBfMn6TJd7oByVUuK/Ge44fI/F+EdA+YpEaCdv/vKQHfTqL7JgAitScjPJi91kYyPyTiQdkVtPL74U18iCGiZTnRQ80gEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQTrE6Pm; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f30d197e5cso443654e0c.0
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720614663; x=1721219463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx5K/74FS6SU2gZ9vr31wzdS+iWH8sI+s/sfE4t8SU0=;
        b=FQTrE6Pmweg6nmmlg/I41VX7IBYAC3KPtaGFcSHcF8kNS60AWTWVWjjucTONjXBHaN
         S2uPOfVTCMYhUr0gV8+dQnA+hvdbo4bZsInlUipENYMz4d7ejOlvf4yQgVb1oOstkMK5
         STa8baadFTUU7TdFSqe6ipZ7SFHlV9BCDKn4HLhc/XrBOFXM0sRuBox34aD0ZXqdHTYC
         AKMyQImQ7NU0m+4/iPZIgCO/HyIrE9/v3zZg7gx0isLlNnR9xzijLhtqTU3ZrdWCT1XH
         mCWMg8sg2z4Y/tsJRxfBkZMQcqtY7hMYVVkKymFfRP1T5QqZfHWfLN22BBbcxf4BIP8O
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614663; x=1721219463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx5K/74FS6SU2gZ9vr31wzdS+iWH8sI+s/sfE4t8SU0=;
        b=WzcrbTxRE+uJ6z5LxjPFkU8Wc0hBMdDowY5F+G36nDNt8gQFLzdBpgijRORxvYHBqc
         f73niQzIyEa96lNSrcq2e8N5vTKkAOGQQPc5ahB29wDHwwZmbFUv3rHRMdBUxDSqIumH
         aydko9puS9P8hchEpCCEPIJAUNgPwrcMCev1S29CUAq25nddxpgULD2SMu7zH5Dohn3T
         f44MZSiD4rMMhYwn0p+CdhVeDS+u4tMpdCVa60XbauiHjI4E6O9qJ3g/mxZEKJg9Hczq
         IScKAUddkzCUqHXSaqGdtVit9/A64JQmcAIMl+vGza0HcG1hSCfwj+dIzUBWMgLFyNnQ
         lZdA==
X-Gm-Message-State: AOJu0YwF3Jp8kGlxK7bKYe+IaEabIzU/YkSCHCIvkiwVG+XcNT3VUwf/
	6eJVSkN6biG3L5nxgjzf5HTFMsQx/ver8ZDGEwRM1MAl/9GmBE9K9VboX3w94Y8Qw6YrdhpHuUI
	V8pH6byD8bB5i247zsw2i8L9OZeDyDF6nmHnI3A==
X-Google-Smtp-Source: AGHT+IEnrOL1Ef9b4qJMG/aI4rTGiGMeiNh1rANHAMpP1crKDydeBnuAVTvcgZZsLkksfqrE4YlJ5vw2AyweNG7013I=
X-Received: by 2002:a05:6122:12bc:b0:4f2:ffa6:dbd5 with SMTP id
 71dfb90a1353d-4f3a35c890emr2508024e0c.6.1720614663476; Wed, 10 Jul 2024
 05:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Jul 2024 18:00:51 +0530
Message-ID: <CA+G9fYvs8EmAaxoxzHuEhr73+ppK7=o95yxUkJRE4U7RUjvyEg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
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

On Tue, 9 Jul 2024 at 16:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.39-rc1.gz
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

NOTES:
1) The Powerpc build regressions reported and bisected [1]
Email thread link,
 [1] https://lore.kernel.org/stable/CA+G9fYvcbdKN8B9t-ukO2aZCOwkjNme8+XhLcL=
-=3Dwcd+XXRP6g@mail.gmail.com/

2) The new Build warnings noticed on arm64 [2]
arch/arm64/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
arch/arm64/net/bpf_jit_comp.c:1651:17: warning: ignoring return value
of 'bpf_jit_binary_lock_ro' declared with attribute
'warn_unused_result' [-Wunused-result]
 1651 |                 bpf_jit_binary_lock_ro(header);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Build
* kernel: 6.6.37-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ca32fab2f2f9ffc305606cc41fe02e41bce06dd6
* git describe: v6.6.36-164-gca32fab2f2f9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
6-164-gca32fab2f2f9

## Test Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

* powerpc, build
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig


## Metric Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Test Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Test result summary
total: 256613, pass: 222330, fail: 3270, skip: 30550, xfail: 463

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 30 passed, 4 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

