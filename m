Return-Path: <stable+bounces-106084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95469FC19B
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 20:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B87D1659EA
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEA212D6A;
	Tue, 24 Dec 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja0u7H/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55941D86CE
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735067574; cv=none; b=GKMH3e7RaoHILKj5BNkquPmQcUkuHk9uf3SofKvkp1xyfIzAqbv1GT2eON1DF0o1f8H9RtGj3Mfp5UYJbcEJjIbjJY2wQLCB2d+Rqt1cK3fL9sVu/AxLBsrGXL/xWNTAVJifSvvYPcZWxORkA2FvkDl75d7adBQKo+z9HBYNb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735067574; c=relaxed/simple;
	bh=8A+b98JNIDRhbi2s2CumQEx1aa1YKcE79fkY15gi8Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSIWYfOA0JCqcCpaH4zJtup0TQ3rknti+RTnr9dy+6d7bdWXZBAk9+XThbMX2Erw+h1yAm+NQFGsGhr4IATwwxlmHIJJ7b+01oH4uWxcidyuJ2K5KJ7oVP94DdIQrOsx/0/kJcGF8v0tjijH7CmIS1Xmcz6KX/KMbpILpegUaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ja0u7H/4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51ba75ee2f3so426465e0c.2
        for <stable@vger.kernel.org>; Tue, 24 Dec 2024 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735067571; x=1735672371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ft1G9qnkXTKDkqaaBP6ii5hk2OFuzUItQ0NxOC4M6kk=;
        b=Ja0u7H/4BFjmNelSJnun/0KVU5Ye6gC6QonEyYRS/STYA/o+pM/5pINIuVnbwHD4L7
         Si0AGC2rvSK5zN5ABAHC2QMim1jdJ0QVrDM1e8Wuy/GxW66V3fEedulBHUkD7x6AVawS
         /h5YLKRnFtPCMltamghYhlfIR9lQVWmGB5koYugXQIqfN95tDBkWvxRR2ZoYQeVrcCCg
         uq1oAaJumdmbMmq1rnRHbuzSGKZ54d3Th4WbLZXhqOHzj+Yu5gkTZd/XqoceB2MOEW62
         tF9MZ8+sE6HI2oCOdS1lxcOlDfWOPJBEERSl8lqMFrRLp+8ctVNGSvt1N7BNVbMmYPgB
         cgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735067571; x=1735672371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft1G9qnkXTKDkqaaBP6ii5hk2OFuzUItQ0NxOC4M6kk=;
        b=cN164dfhnqwDH6BCSZEnIgn2FLeGhtnQvAEHNgUWetE071zZtW8ROBTNtVaxxhWwHY
         seU93ovafyUA1krwuS+wK96FwK+yynsuuEKmKaZbAdk2+ZqXFumegRU3vntXtFBGih9G
         cvKnqaDknNUQXdbuD0AtLtxFAu3MqWgvSm+PZheuQwoKgw9K7S8Ycy8l3aKt3uUM/XSb
         0qwiZgttkZ3C6mV2CHUa3su/SduFnqTM9vCvF4twqHmqFABETw68cWVtYFfz55jz1hAA
         EqVeO+xoaZv5shb0yDmbaZjILBtSuwvQjRWQnE90hlLx4gXZ+sCb2ipl0tjBN+f9Vbfl
         1cqQ==
X-Gm-Message-State: AOJu0YwlFIplvHmsr2/7o57zvTTRZbF3YTPERS/FEZzDM/Hfm8FZD/nd
	gcbBIe8oxuD6OTawofZj9HpDPR6lehk7RZVn6WqZdOz4qtsB7WY3DFzn0ihQrsuuH18AT3VcMcC
	XzM7oIpryEEMJA+t4hif2B3g0/ncI6oTsP7l8LVpdzZKnAuZvWJI=
X-Gm-Gg: ASbGncs4+JFTYn/0rfGkUi3GpSRxLA83fp9lBgGEIgwAuYmZ+7/3xD8YmcZG11zr2E8
	A24Cq6R1Mf5UXPQ9cd9BFXIDAobjJDIlyQRJwVM7SFopAGnBYOB5ohE3wqc4xK5Xzo8GNwxw=
X-Google-Smtp-Source: AGHT+IGqb739NzKu2KSkV8ZwxqrrVb3TmWZf/HJmKud1eY6x3i/W1K570ku05H0gXOsHhloAXfcrHe12LD7CbbZkV/k=
X-Received: by 2002:a05:6122:6607:b0:517:83d1:d438 with SMTP id
 71dfb90a1353d-51b75c2df66mr16754462e0c.3.1735067571575; Tue, 24 Dec 2024
 11:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223155408.598780301@linuxfoundation.org>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Dec 2024 00:42:40 +0530
Message-ID: <CA+G9fYt+k1m9oTuuZaGyTXqg+EKsSTnmfsc2HYijDWmEjx9xFg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Dec 2024 at 21:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following test regressions found on arm64 selftests
kvm kvm_set_id_regs.

This was reported and fixed by a patch [1].

* graviton4-metal, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-nvhe, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-protected, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-vhe, kselftest-kvm
  - kvm_set_id_regs

 Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
-----------
# ==== Test Assertion Failure ====
#   aarch64/set_id_regs.c:434: masks[idx] & ftr_bits[j].mask == ftr_bits[j].mask
#   pid=2627 tid=2627 errno=22 - Invalid argument
#      1 0x0000000000402fe7: test_vm_ftr_id_regs at set_id_regs.c:434
#      2 0x0000000000401b53: main at set_id_regs.c:588
#      3 0x0000ffffa640773f: ?? ??:0
#      4 0x0000ffffa6407817: ?? ??:0
#      5 0x0000000000401e2f: _start at ??:?
#   0 != 0xf0 (masks[idx] & ftr_bits[j].mask != ftr_bits[j].mask)
not ok 7 selftests: kvm: set_id_regs # exit=254

Test report and fix link,
[1] https://lore.kernel.org/all/20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org/

Test failed Links:
---------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.6-161-gc157915828d8/testrun/26470691/suite/kselftest-kvm/test/kvm_set_id_regs/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.6-161-gc157915828d8/testrun/26470691/suite/kselftest-kvm/test/kvm_set_id_regs/history/

## Build
* kernel: 6.12.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: c157915828d8f4b0a4f2e60fffed2459c27f3003
* git describe: v6.12.6-161-gc157915828d8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.6-161-gc157915828d8

## Test Regressions (compared to v6.12.5-173-g83a2a70d2d65)

* graviton4-metal, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-nvhe, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-protected, kselftest-kvm
  - kvm_set_id_regs

* rk3399-rock-pi-4b-vhe, kselftest-kvm
  - kvm_set_id_regs

## Metric Regressions (compared to v6.12.5-173-g83a2a70d2d65)

## Test Fixes (compared to v6.12.5-173-g83a2a70d2d65)

## Metric Fixes (compared to v6.12.5-173-g83a2a70d2d65)

## Test result summary
total: 116741, pass: 93918, fail: 4621, skip: 18202, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
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

