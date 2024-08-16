Return-Path: <stable+bounces-69298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B49544B3
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28529B216B8
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90813A25F;
	Fri, 16 Aug 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXfZY+eJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C707C6D4
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797958; cv=none; b=bOVsSW1ubStyZ6vBk5Kzwe3IBDw/XJDHNcFGnnEbs3XkorKqg2jxmkEvszEikQi8IokxB95rvLMpFh/VOkvhx5DQD8PxyhbYj26h8cMqDxOql0LAbRimdls+Jcp9q2OP9GXsWFJRWJbAiR43iYAqcckHCkfbbviSl18QzjnNzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797958; c=relaxed/simple;
	bh=l/cqChJg/Qri4UK2uKbK3Vo1Mya7dlt6OUhrF+Ts1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJjxoTaKuCMi2RPDTAaZ9vxWnGUkncgWv7FA8GncLHftTI1L7loweFR2YeFPxutg75ozFUkZlmVqzlhV6EIGQiO10N+lomyUygXPpZpUdCC/z8wNO4XhPPBBeH4EVYoajupVye2MuUErwJ3cgIVP8Cy6ILLlJDfi9bV+btAAS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EXfZY+eJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1768338a12.3
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723797955; x=1724402755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJckoRh5CnaAaQkEaSAtT4W0I5ueEE7s+w6QDeInXtc=;
        b=EXfZY+eJew+YTKgcADP8BKRZryu6p6V+Ndjt9HihYjNF21ViZFx2OwzCKdmh5VuoGP
         TZHGhqHrZ3eyOCJCCsDby1i4JiTYufm4wbRwCrzGe0ujDjjFTbLjXbUD/7ZAprbBvkfO
         mGz93NQpTcsXyr1dHdsn5n7Ei8t7j3C5gN2JVfhTkuMOGYGHPjx+XicvgKS5MRzVLzOy
         Fm844go8fCnA6rxBOtvzj8L6vASlnTfmDtYpIWc44PveI4DFdG4R9EcBdjLoZGdtLPXX
         QAS/w1PUDmRrUM1M4yvqv1H66NM/FgGGJCBTymsIiU7R6NHTzhTbVQ2gzHdWRwh8Xdly
         liqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797955; x=1724402755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJckoRh5CnaAaQkEaSAtT4W0I5ueEE7s+w6QDeInXtc=;
        b=jANaddxMxZAarOQ3Pdgr+TjzMtOLVQ5oabruWfTI7W0HdwZyayripbuSWyuL/vqJnM
         uVmV/gjX4u+/VNx/8tEUM8zP8SgiyTqQMomewvFhdQy8rsSxEmfMwdlHkCOO0GOcKyQP
         0DhT5k8++5619OnrErLUqeSsgrIpINm548lnb8GDo8PpKIX2gC3JS3uyHI+R4oBVLfpy
         /nWKnq8hnmwyMoxssrWkCKq13DrywYZQUwjGXl+mm6GJxkh1+yMWk3FwZQ0Ci784M1DW
         cGBZ/co1tI5E8uMmDTem0Ejb6Nrlc7ZpDMLWJtWMqZ4Px9u3en/Z3K/vTUI6E2pSN6sN
         hY6w==
X-Gm-Message-State: AOJu0YzqNPZuXIHck05J26a+zNnSNdIrKHSWdODoAyHW/CVi3xS2KAq+
	GbwOeTxFl2H7TVpVnT+PkOc3qR8gRyeXFbn9odqDDHVMvPWhLL4ybYaOFSiAK1hOsIyrkaTwl/c
	FixK+QD4MrSAqrIvk3qzFibr9jhcYg1v7oAAhBw==
X-Google-Smtp-Source: AGHT+IH7RfoI3zCZ18l1bcOSWl0DD/OyHznDjT1xZTI8Gokc7IBOc4WLg21syXDGg7iJYFGi4t6uaJxwgE/Oz36dr2Y=
X-Received: by 2002:a17:907:6d12:b0:a72:7245:ec0a with SMTP id
 a640c23a62f3a-a8392a47243mr135538166b.58.1723797955238; Fri, 16 Aug 2024
 01:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131831.265729493@linuxfoundation.org>
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:45:42 +0200
Message-ID: <CADYN=9L-zL+r+K-XwMGQrs0AqOB8F=k-mE=ULxv+z_DpCMixAg@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a812f2032d1ccdc36ece9248c14ac3ec8a936cec
* git describe: v6.10.5-23-ga812f2032d1c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.5-23-ga812f2032d1c

## Test Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Test Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Test result summary
total: 246703, pass: 216815, fail: 2082, skip: 27407, xfail: 399

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 24 passed, 2 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 18 passed, 1 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
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
* kselftest-timesync-off
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

