Return-Path: <stable+bounces-52261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B850909661
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9DDB212E5
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A315E86;
	Sat, 15 Jun 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWgeHRcg"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A95FC12
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718434032; cv=none; b=Rw7U/LkeUeVVTH8bk6WjvC3jGe65LAOYYfAoIcubxyXZI6a2ldcV7DlmNYfangbxK0B6IPEVTBNJzFEL0l9haAotw/jrMX+/cz6fUBV7me/SAFNPlHwz6Mpo1kPREA03p0KZZ6fKzLxwd/wYh5wXSfSMXgiGW9/J5O97REikgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718434032; c=relaxed/simple;
	bh=znnbojbn7bV82M7iK5JAhEnZ3lVFFlNFEcHsHJkwCKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMJFGWlicgCbPZEUuwmW/aTu6G23O4NDoXvb0j4fTLV9r9zgOrHbuRY199kORpxMGA7SS8my8EIHbCXg8mmCK7uruy52aH1zDDIhDOWGkBdz+K9dD7a15UqLXmHWiagkxDmBpZj+SBOIiIvLlZUirSLjezsqDmzDMxp7GYxOscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWgeHRcg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4e1c721c040so997025e0c.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718434030; x=1719038830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4RbldOmyuB3cQWDkIPG/+2f11O33ZLaDT0kxFu1pIc=;
        b=hWgeHRcgccSVE0c7uNciJnVJUZP3Rv8i5+QlCLVcETxT3DXH1/hpWUdGCFOByLbf9f
         y+g8iJ1sHETZeasD/u4+TWIF94EHgYE28YHG4Vwfkz7wA2kzSM2n2+N0W0g9klb6N9rG
         +wH8XUkK6OoBPJB5pBY/HioYlbDxGjb8CF8jz5uVWvmFsz96pih7/hqetn32t9P58Jsh
         9GhPQmCw9ILj66+rJVJSGYbXHhRTYqL7ll0xz5wJbeXR5Bgp7caOO/ElpIbwyl3WSykE
         WWAtZJKyygOLjwGRNFSMr4II7NsvGomEeIIVut6nhIaMxQRBRo6ZP2X8HsYVFq3hxZ2E
         tnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718434030; x=1719038830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4RbldOmyuB3cQWDkIPG/+2f11O33ZLaDT0kxFu1pIc=;
        b=DodWLLcAMgYyc9IPU8qBqD3I75XpY5IycabcRKCqzv1K+80fDRjnMMtwp7gpTS0c1T
         CSzntSfGtDPVtwTnYM3KG1PedFg5WbI+doAVJ3q+QxHIkbR3IRv28H5wYpLwPZGyDHHE
         K5VxOfBxacF48sf6kglXLV05MWFuIXjuQvxfXOtUKwpN7ytNYRCu6vq480AB6nxYrFef
         9XzW2SUGzapce0PI6gAxtxNbL0OnhkOJ/apwyHk+bYzxujfeNih+xdA/x7NM8a+Bukoa
         r5JQ57KXQTX+3JE2woh+vfuNZc0840ys32wERJxB4E+0xYAsiedugla12N0U0jVRaFDV
         yt9Q==
X-Gm-Message-State: AOJu0YwkHfbL79QebDDqLiu8ODBsgN3I+EabX/JtusSL1tS50C1zM0tS
	/IR0iQoNRSnI0TcF/Lzp5fAgckawsUXsvF0hMhn2Ny0eD/78CEeUCW9Qq+Y5X10llToN6MUIVBC
	Wcr8p0ijtMzQojnu4d9dJ1k1Q7a1iLmsTYKTmfw==
X-Google-Smtp-Source: AGHT+IG9UQzi+/x6u3a0CaY7fNyxTDm/VpR28UpB4I3qr8yCgEap85fJlxSVUf2uR9MBxivdeIvjkY1RaWQ/j/8Eb1c=
X-Received: by 2002:a05:6122:2a0b:b0:4ec:f183:c9a8 with SMTP id
 71dfb90a1353d-4ee3f757840mr4716374e0c.9.1718434029824; Fri, 14 Jun 2024
 23:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113302.116811394@linuxfoundation.org>
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Jun 2024 12:16:58 +0530
Message-ID: <CA+G9fYvCQ1afo2s66UUDGMKGoTAe9BnONg8LqgzOnY_HC7FFHg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/402] 5.15.161-rc1 review
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

On Thu, 13 Jun 2024 at 17:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.161 release.
> There are 402 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.161-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.161-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 382eb0c7888246aec43f7bbb93ef43abf816ec32
* git describe: v5.15.160-403-g382eb0c78882
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.160-403-g382eb0c78882

## Test Regressions (compared to v5.15.160)

## Metric Regressions (compared to v5.15.160)

## Test Fixes (compared to v5.15.160)

## Metric Fixes (compared to v5.15.160)

## Test result summary
total: 87886, pass: 70665, fail: 2514, skip: 14636, xfail: 71

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* kselftest-memfd
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

