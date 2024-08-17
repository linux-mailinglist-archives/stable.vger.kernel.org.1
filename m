Return-Path: <stable+bounces-69376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7D0955590
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58455284845
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58516E619;
	Sat, 17 Aug 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3u/zd+R"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953212CDAE
	for <stable@vger.kernel.org>; Sat, 17 Aug 2024 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873073; cv=none; b=vDEDCxVNUUrv1r2hk0NIq824850G/eN+KNPxcUK5TdbkTvbtGfoA3hAG8sUkRt5Do4WHkbt+Be8bEgLlOhZ8+gEixKiyW0pDRLolQbKTU+Dw4hnDMRA9VFE4logYYQLiU03KDJXtibccX0nYKRFOxq7VwllUuLmYRmB05BGS3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873073; c=relaxed/simple;
	bh=ujOztsrgUtLCkTBUlHipOetZmwwdWGPqzCzxoHRIJX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Zx+TRQIo3GBpO8Dui/SrlVyijfvKZKUSiI/sJOu4frmT4fUWHmwQuilUxPu0RPqeR+gAzphc9qmDgkpofZ2Kcx8w4a2+FXKhsjwriFVl0RWNpXfLHxyBE4KAIDVr/ZWNaF917383zNUP9htegBCA6M6C43ifImCMeVUvKkfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3u/zd+R; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf84c3d043so5302436d6.3
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723873071; x=1724477871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B9dSjIaAHGCyPPaVCWVW6TuKrm6s6S4lX4QXVFVhLL0=;
        b=D3u/zd+RnL3vSADZMD2IiH0NDnw+vPU2DGKBR+xY0sRjWgtWT4pVXvfB7TKFYH1bIL
         hN+r1cPBGrmDa2cjiM5CtASKgVIhP2QPY/yARZi0UKij70IVtrx7QhKuWwgh9B5FYRe/
         HlArbQwbgfQq/C0I/AMZzpHmviQQwRVogMPOR8Lb0AkYtYQnDouEmqqVc+f1Lw8pP+Ql
         ggYPBuLJl3+lFVOdNGRuaA5QiJI7X7FFTIlqJ8yb9kDBFaGfTpxokR3uzZ4qj8dYxxzn
         nLb3BwCwmmNpxpYVaVnZ0RHMTH83cdwLlvYqrXqYPvdtGJ5WY5MCfr1rQ5n7okLSI5pG
         JgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723873071; x=1724477871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9dSjIaAHGCyPPaVCWVW6TuKrm6s6S4lX4QXVFVhLL0=;
        b=sJvVBNcrWFz8XbgxmIUh5ceHL0HTjxCr6CfR1XB4bGONmyFB7HLIQMFICKtuhLg/lA
         QRPeGOheVtjrH73qOVldxF6Q68Z3iY7YR1kBYr9N4xHTh4cRLqnKmXx3WiGebV06ED9r
         uPK6pgWvR/15OwkINO4XmbiYMNhGVdWSBl3e6/kkHBG+ungRC84GxBVvc+IqIsjTxuMi
         LXwKoYqmoElmWIswp27zo5PDhhnQsJPn7QOxTiLrU5OQORE+uDN+DxBnOcI72Cy2nXKP
         a4gbHUoEc/OqR8dnJ6cSWRhv6s9ZmWOP8XEh9G0/Y0LDNZOlrpvVlltvVMCSJa308cVq
         H/Tw==
X-Gm-Message-State: AOJu0YwjpxG3POfEcFP8YcPzWpuNV2J/Rd/866oTLz3VCGJgHCCOQ8du
	fRwh6k5ZY/HEA9WMcPRG+pXnRszQMahj2KAytZ1rToCyDw7C9EpAe5vtHsBLZFNUIFA3skkLlxI
	nJpXiHlFxHe0v04eba2egxvKyxZLeYtCA+SzdEg==
X-Google-Smtp-Source: AGHT+IE41BzwdEqIQUO+1LkM52qPPXRw28C3Cm6JIiY2t7NJfcA7rB2LPTC97GSof/qDgZo/9EYft+CrYFvMBzjyX0M=
X-Received: by 2002:a05:6214:5f04:b0:6bd:80f0:42c7 with SMTP id
 6a1803df08f44-6bf7ce5b4b5mr59785926d6.42.1723873071026; Fri, 16 Aug 2024
 22:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816095317.548866608@linuxfoundation.org>
In-Reply-To: <20240816095317.548866608@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 07:37:38 +0200
Message-ID: <CADYN=9Jhe2+1Uw9uMQxaBThuR5wudFXoupLduHc0-u+Vxr51XQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/255] 5.4.282-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 12:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.282 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 09:52:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.282-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.282-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: da98fb7f23b59f6e03a312fd33f84927786f36d0
* git describe: v5.4.281-256-gda98fb7f23b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.281-256-gda98fb7f23b5

## Test Regressions (compared to v5.4.280-45-g6b3558150cc1)

## Metric Regressions (compared to v5.4.280-45-g6b3558150cc1)

## Test Fixes (compared to v5.4.280-45-g6b3558150cc1)

## Metric Fixes (compared to v5.4.280-45-g6b3558150cc1)

## Test result summary
total: 91832, pass: 75526, fail: 1471, skip: 14777, xfail: 58

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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

