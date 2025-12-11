Return-Path: <stable+bounces-200773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E619ACB4E4C
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBF3300BBB7
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7464296BD4;
	Thu, 11 Dec 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuEuXCJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1A27147D
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435463; cv=none; b=JQUL3Olkdx3srT+G6Ogt69JGaE4W5WvmWSN1nqAj0wbZ6u94muUY+/uQyMtyC374HKx3J+ETSHU/fgRQmnJGsUzl82jrIJEr6aXYmQwAQ6s65Aq0WveWH63IzTuIYltVScHfMGB5hrTgP5y63VYp3xB6L8x2VI1QAhP6bYlYDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435463; c=relaxed/simple;
	bh=I3DoY5IXK00Eqyo5v/88aFKiir4lFJwaytRbk6+jHic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSM9PGKizzj/svudCYZclTo3rxHtJgUmvxYOxRwMU79z+aP1hOilBukDLCEuP8XOJBH/DL82RcWGbetWVpu1Niry8R5AZ50d7r9+LyQqJD4foUAq7pQQECxbznCppTiiXPp0caiEk81pHrlXfobGxND8OjhkVmmfId3YJEcBbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuEuXCJt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so579671a12.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765435461; x=1766040261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2Wz+FF8tXlSaQpLPb/9FXC05Bpx7SchjoEE86Alp3w=;
        b=NuEuXCJtl5XR8xVgPf5CcCRfaj+UKcRlJT0JPnANVlFtkhe5hC+Nr74U0yY94NWte9
         0INXUCpc6HhsF512bFGoypCAu0jsC4Yl5pZhznp1uuiqsClSOaK7nTeUFIva9OhcjSo9
         n7PrHSkDeEAYgbzx87W5VJgyu4yQmcbefP7UJMy7p1pGoWSvOQDQHgP9gOTaNudoUU9Q
         1in+OGtanjLqfBBDrrT11JG0F1JIkG0IkcKWzR/huaoL9EgIj0CfF0/5VvC+Dh3Vaw3W
         rEYeRF2fSELL2ai4d0tLINp1Yx2johqOcvyrEsPcLyKxLcoR8ScOHgZURzSDlprX/AxK
         ldbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765435461; x=1766040261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2Wz+FF8tXlSaQpLPb/9FXC05Bpx7SchjoEE86Alp3w=;
        b=EaJ9FuoQ0873CDUAidHdKXdP9v99N66hWbLL7uv0cvj1F37ExEs8+zzhqUDLWT5cOJ
         /+vhVe5dAoaxeSJSL+ibG5CeXg8ZxWvW68wchV0ebuODDoiOopwIu3mZzaNWJqGcFAs4
         /KDehSFFXl4XR17weCdEH46NWHVhHd3/USTVYuOUI9NMu66ssWhaJrizOkiImAc1CQVy
         6JBaiFZ4gwYy/BdJAC2ZRtz8RSbfgZM5qzwnpQj4eKkv32dXXjBzbzR4ZZME8gSJ3JKB
         xubsPWV5UEZZCRxZ5asPc9S+iUHgXflw7KhwrIShqYmdvMnMAJ4Vc6w8TuWwg+GGlvdb
         V9Sw==
X-Gm-Message-State: AOJu0Yzxr3qhLhE+pXBfGerZgFYPej6GQ46QHQyinn7jf+ABzNylDMe7
	OfeYoap+F5P/jPrhu78YtK4HGdZFUcrGabQMAT2yqXmGnq1e7iEOmWrzpAvh82EMP8g7EZpuvyB
	iysOVQGnWMp8LkhJ4P0nhlyGj1U/rHGqJgfv8VhqO0w==
X-Gm-Gg: AY/fxX4USsuoiV9f+2oDCH6aee7W6OWTOQhQRlp12ZWRE0LoW8+2bd9bJ7YOuJk90C9
	FOcfVA58jfNNUXCXhaSOygLM2D88vtYaiA/zKQGp4mI7sf8IlI3ljiGmXulgzgm6e76wWYVg2IR
	y1CC/8DG3KRaNZXKGJ6sGNRauah08l9j/Am5RHaJm4jbFI1IWz65JBmw19jxFptsiaX5vDBJhE/
	WXQ9QaM0uzSV089a4rLBPFj6jVDKFZ0G1MGfEVT2NdH+k+7ojjNXY93l+cRnu0VEOPyK28FkMGI
	6l2pAWP8OVPrMmwonC/1YRzoQkbO+A==
X-Google-Smtp-Source: AGHT+IEBhF3ZD6pqQhHGKW/yGrs2jr4pOZgjV+jVfxmy+c2X9mLL4tZcKDT/0kMUOHG6StQEDh7Mz2q0dKKYOT3AqRU=
X-Received: by 2002:a05:7300:220f:b0:2a4:3593:6452 with SMTP id
 5a478bee46e88-2ac0544be0amr4883763eec.2.1765435460961; Wed, 10 Dec 2025
 22:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072944.363788552@linuxfoundation.org>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Dec 2025 12:14:05 +0530
X-Gm-Features: AQt7F2pOtyl3D7vhCfaaVLgMxtqAUIm9hKtsocFubsUvatP3bH5AEP804uA_ELo
Message-ID: <CA+G9fYvtuO3sr4cmAmd2Vt020jLvr3dfxfm1KbQbJX6fiKw2dQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2025 at 13:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.1 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.18.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7d4c06f4000feb509a90ba5eeb00be9839decb91
* git describe: v6.18-30-g7d4c06f4000f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.18.y/build/v6.18=
-30-g7d4c06f4000f

## Test Regressions (compared to v6.18-30-g7d4c06f4000f)

## Metric Regressions (compared to v6.18-30-g7d4c06f4000f)

## Test Fixes (compared to v6.18-30-g7d4c06f4000f)

## Metric Fixes (compared to v6.18-30-g7d4c06f4000f)

## Test result summary
total: 105808, pass: 88879, fail: 3320, skip: 13609, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
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
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
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
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

