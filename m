Return-Path: <stable+bounces-69299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C070C9544B7
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FA0B2142C
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21913A276;
	Fri, 16 Aug 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1On0/6x"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEB7C6D4
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798038; cv=none; b=E+LVGgx1AQZXCBjhuoWx+/C45JhXVoL1uTdL5NUuR2t/PqizAOlh7ducx+QnnYAg82isLpc4iQCQ+x1TR+VSyBlz4eWohBECXf5fr/63IV+FgC+Vws/+R+dKPNW6Kl42bVYyLZXuoBXqm79u8PMmRN69C/dZXQXxEsLDz0ZZY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798038; c=relaxed/simple;
	bh=X+mXAbQqboRcObqzKQpaXGDJkEEX7ypQ939Nh+mB3n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGJvd9LutlWzY1yz1AAjlayeX6pARjUFVb9qtBS7XKvG3Ull++b01xruYV62w92jhgnjn8Q5jb1bwfoE2MpfwVhqGOYBah0ocrEOTXdNnUqN/rPhghHStFx0nCI5jo/NTZiw2Gvl25qHhqGhXUYSCnI7tw9euHH8k3bs47cwaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1On0/6x; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53310b07267so2165927e87.3
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798035; x=1724402835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1wA22C8XYQ9wdJsqDDaxVdz3LjGATSDMDKJ8K3/NQA=;
        b=T1On0/6x4CMiXkhoctBq7HPssbWKgpKiOsTUBU8kaMW2V5q75u942q3uInO6tREW+4
         f9x/0B6ymihFxTvNmdycusksrkJcakiu/vRZDts9GEl+I7a1dQPXEkRwEOgBlipdDBue
         oKohRtjz2BRHcT0h8v1fMefO+JbsQgtjlMTSN2UClQt0Cl0QGo/mLvHQuat9p09GJF2F
         yLSpKTULIbuHoZJFqCZIFqTJsIIJmBKWuPv9FbOj0WcG1JE1qSOlVvkNZnxoAGVc8dQP
         1svTO6YBIELXZS/G8V6QdgNLDZIijbIv33/6xh8yKJC9wCng5uwE2+uTY6c+n6K0sBh7
         3I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798035; x=1724402835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1wA22C8XYQ9wdJsqDDaxVdz3LjGATSDMDKJ8K3/NQA=;
        b=P9XmpP/DzX1b2+6an+Tr99uBS8l+b43I5FcNcfBtaqGlJ65ew8pReUIHY5GrS9PQcB
         JQh7SYt5bEZxnrRk7/5+QkmZREefDSsH6Nu0B9hzT/2O+rjbs4rUbdjw08kTehHkwuFf
         1ZaB8jRDDFEUwxlAS9x/fWvAcsEsOijcxHRk2KfYr1lbRvJA4tXjQdjNurImBJ08Vagn
         1f3kaEInSdfzD1lBQ/Gdq9nWn6pGDO48c+eNuO1EUBVD77XooXZL775H/BjErmB8/72D
         Jl7fsnFtiNgIrRv1j7Sj4sodtN8cVTN7NoZlRO89aLz0N9MiHKJhpd0ehOkRWie0uXqI
         //LQ==
X-Gm-Message-State: AOJu0YzTXuu7B8JT72JT8KSVRX9QzLcekmUkH1pvDLJXnkDmETMd+RVr
	HqrEyIikoWB+QzWoxydINW7lSP/ZeJRJNAENb+0vbW7q1lewmVdqhgxnkqfYZa2/mTh76KmzEK/
	PQxqO+OpfPwCEIKIomyby/IjSBZsGT05o+we5ag==
X-Google-Smtp-Source: AGHT+IF/yq4eogQpb+KVB6Upi7DipVo81AdBqPCKVZbN7W1SoDT364gYIxNe6Qhgng1hz/D+R0Z49KDYsGPcDoS7noo=
X-Received: by 2002:a05:6512:2346:b0:530:ad8d:dcdb with SMTP id
 2adb3069b0e04-5331c6a1931mr1836355e87.19.1723798034663; Fri, 16 Aug 2024
 01:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131838.311442229@linuxfoundation.org>
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:47:02 +0200
Message-ID: <CADYN=9KdnuT-ng_pyL_NtB7vuYwBRyFxBP104QAGJWtMjGT-pg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.47 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.47-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.47-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f44ed2948b39fed7ff60f13f1f4d810c88380e65
* git describe: v6.6.46-68-gf44ed2948b39
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.46-68-gf44ed2948b39

## Test Regressions (compared to v6.6.45-190-ga67ef85bc6ce)

## Metric Regressions (compared to v6.6.45-190-ga67ef85bc6ce)

## Test Fixes (compared to v6.6.45-190-ga67ef85bc6ce)

## Metric Fixes (compared to v6.6.45-190-ga67ef85bc6ce)

## Test result summary
total: 208016, pass: 181890, fail: 2308, skip: 23462, xfail: 356

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

