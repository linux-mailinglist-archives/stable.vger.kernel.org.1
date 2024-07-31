Return-Path: <stable+bounces-64798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FF7943669
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 21:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B307284527
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6015FA7A;
	Wed, 31 Jul 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jjb0j9zf"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673060DCF
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454201; cv=none; b=h2WOrfRym6hON6aUSEOzZ5rxXVmjmZSkbRwHA9moh4xasmS4r2N32BjGVOKq1d4pA2OdoMtlYaP7YVjD+j7bk+KYTC0x900+XB6t56k0VQ1fAZmhUj/Huvp1q3sRskJt16AJ/NRZq4ggmjrVWaniJXi+STjS7qkrwWy008SL3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454201; c=relaxed/simple;
	bh=8VEBFafnSr9VpBkGUOOfJzMmeWvifxk7DLlZrSgU4b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSe8L4KGSklF2CUknqv5G2F4+FIx7zWWo55e2FJrn3gPXithR9qHUCg3gue9NRR7YQVhrkVmS+XLEevBzLBpe/Yw12b6XC8MmyGg/Brmv7j8ShFur7fr/N8x74di12rSQK8r/Bj3CA7Jdq0fmg6Zd2v/7yn0+JFw34ohzypVqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jjb0j9zf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f521a22d74so2003843e0c.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722454196; x=1723058996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajHV6NX4xbC0/X/XUlTpJgiJmCRqspyluOYbTikblWw=;
        b=Jjb0j9zfPcbIFE3sCYvH1EMgGz9A4BHSQnL6mlo3vnmLktVvyJWLeZCIgfwYYh7VRk
         rPvQHuVVnl+G9uD1z+qVRaRHjYQT7TzgaPY9xu1r5sx8QN/DWnIZ4JtRzzbVVh+KBfzL
         st6yvYMsy1GjW+gnEZWf5m7QkoYSi7osfbJQZVFTIaSaTa5/ckg2y+FTjGnO9tlxcJUV
         GnpFcognvzAnJt7k2swAfTA1N5Bwni+budQMKQluMQ1vl5TPa32RvTE4BtQT24YUWR4n
         VhC7wOn7qgVZAhnC+DsOYmoSHEa0QsjCVS2/m3mGTHmCfUZ7ow+pzxHdV8O+Y5vj4KMo
         4MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454196; x=1723058996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajHV6NX4xbC0/X/XUlTpJgiJmCRqspyluOYbTikblWw=;
        b=kT2D3U+0SI3WgfIpGfh+yBK6q/aaNbtAtFYF0r0+qATDe8qr+GDIbWC08+NfhKNDjS
         EVJrXh8TlUjX047J8jizOW28DJGZjtOjFwgMormIqX/Ik+gwojF5PbSeO/U+SImlnA7e
         dZuUVaI8iwEqRkxFUjzS8Iz1Nvb4hLAbArotVgwTrHqaVuadDbSY9AANlYWNz46gly4B
         8tMQo4N0Qg3lgiJHSYK4IvkhkqIjhzqqo0czWSfam0ve+mAoS/05VcI/C6YE/7Td8Zsz
         D7ZAAc859j5XHdIjhp+qVeN4Htzdqm2KAtyQvMyBG6JWCbSl5taaEnRNLe5sH+XRRJaD
         Lfcw==
X-Gm-Message-State: AOJu0YxSKlWwHQF5KvhWdmcuN6IH/tK8JdDk9kuUuCKUbQ3eQkc+sc66
	Jq7k0FCHgYZXKgveQ5EBMLFEAt613bvL6JEmQN5n6o/L7eSae0Z822XPuj2pLwXbSjawMSr8dXQ
	OmYNkydfqENYF7ejA65VDNRBscXtMjih5SgybOw==
X-Google-Smtp-Source: AGHT+IFGOh29LmDbgQeNaPW8BywZKqEMuxk4LG7u9wPcpkJp43UNZWjn4ROEnmMSCiHxRRMDEiuIuZJG/HI/Hu5JbdQ=
X-Received: by 2002:a05:6122:3c52:b0:4f5:21fb:5e49 with SMTP id
 71dfb90a1353d-4f896714753mr489423e0c.14.1722454195700; Wed, 31 Jul 2024
 12:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 1 Aug 2024 00:59:43 +0530
Message-ID: <CA+G9fYsf0tqqUqLsMAZuLhhPVJaJvX7gw7nhdsbScntYVBLMXw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
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

On Wed, 31 Jul 2024 at 15:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.3-rc3.gz
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
* kernel: 6.10.3-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: df6b86a465e839f8a9912c0de79b3c5681d0f1d9
* git describe: v6.10.2-810-gdf6b86a465e8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.2-810-gdf6b86a465e8

## Test Regressions (compared to v6.10.1-30-gbdc32598d900)

## Metric Regressions (compared to v6.10.1-30-gbdc32598d900)

## Test Fixes (compared to v6.10.1-30-gbdc32598d900)

## Metric Fixes (compared to v6.10.1-30-gbdc32598d900)

## Test result summary
total: 418796, pass: 365615, fail: 6357, skip: 46059, xfail: 765

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 254 total, 254 passed, 0 failed
* arm64: 72 total, 72 passed, 0 failed
* i386: 54 total, 54 passed, 0 failed
* mips: 48 total, 48 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 68 total, 68 passed, 0 failed
* riscv: 34 total, 34 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 62 total, 62 passed, 0 failed

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

