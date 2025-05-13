Return-Path: <stable+bounces-144206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D44AB5B67
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773C34C1991
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE62BEC42;
	Tue, 13 May 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1j0nyco"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744E14F70
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157592; cv=none; b=vCEIIeDmVYscAbNOcyf1t69Ea8WhSSLnM6jYuu9/eI4Vv11z7ZnU0mIKn4PF3nx8dmspbi2vnytwYbC7yzWC1aYvxs65yce17k5Wirf9tj/rE0OKIYhocksGFy8unCjpjLTNSIeYKaY3wOg38pCJreiPLqN0TDj9+VWb+C40OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157592; c=relaxed/simple;
	bh=181/6XfkiZiDiaZQFYts1ypmeeCj9Bxgoo5NUHCw1xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk4eq7ndh6kiI8ooBkkK2OO/oxXtdMYptdWOeAZkS7NpfoS/mnjFjy1qhxXkD/J9xHVTxmZnEsTdpExIZNGt2AWlzAp4QEkXFpO+MNUbeoG8xU8b5kpWxoxrQfRyJGdZI/ptHftyw3XioRDvX4+1Y9Ji0xSRsI1tWQtyzUYDMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1j0nyco; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7415d28381dso5085474b3a.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747157589; x=1747762389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ78LRASepbKRHv+EBFpcortTEBtcfFbz829Py5N4Fg=;
        b=I1j0nycoLGZneYhp6aStVVUtkBHnAYSNdgF2L4hEhuL25UNwq9p2NBvdK5tR1Pp3jC
         sx6C56WzkXyTUCRaY6vuFO7qhLr9b0r5zZW+JLFSE+TQVCcMRTojIvenBRwibcayTWFI
         A5TEC4gunWSZ4zTbii7gHVGX7kAbML8B5rWhtBQmL9cNApxlFPn/LJ1DELxTCC/4fgPp
         NUODLmHFLjoexORG6fNB7knXw0hz8YPaikJ9a9n8qLLvM5fg7eL4QbKupj97rpQaZHk3
         /GlUIrKFwXAHHVr7E/8udO1sZiNa2N/PU3fLEsKcctCs93letf1szeToh+DX2mNKXLfk
         irxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157589; x=1747762389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ78LRASepbKRHv+EBFpcortTEBtcfFbz829Py5N4Fg=;
        b=fEpKyBKNI7PiGffvoG0xKtk7Dksmc9pj4wB9hX6+zEZl8IMRKhQAFv8zAgnSoFGi1b
         g/qM6FynvD5LtB1Kht5X7zVkXhAapRuqLIqhKfevbMDsnnOkEx72zI/Pmv277e/iZ/QV
         p0LDFN5awGEGhpzfRZBt+HiK5AyTuJRXqmvDcVsbJn4w0wX3VM2YT0A5ntkmsqIAI6QU
         x57QH8XVFY7rFxIUQHGyR7BU8Lk6PJdObo1ZyZx4a0nlkYxPs0x54GI0Jfg4pRJeVA91
         DWLprDETiPFNFWqA9peQVJd+fgD2WgJH/EwgTcbWnJrq2DNyDT8tu9zyAxmP341HpvfV
         NCyg==
X-Gm-Message-State: AOJu0YxNbANpU1r3FhyqLBjQFjkMsz+mQxd5DZ1kjgpmER8pNmtM7yst
	JqLziFAwevo//8pFATjwpO7bRsh6tsbYNQo9bJZRnfMgY6K9X//M8XKJqKKHCGz7DphG/TNx29q
	175XXySio+0i/glrBbuo9JIqGFBHb7KRv8yb1/Cva+8HnwRqAVz4=
X-Gm-Gg: ASbGncvNADcTrNRx9fkjGN/oy2/Qn+jMUPAUFANOnR4SwjUXpfZVmhE2udvLp0yx9iU
	jwXRTziQNyRNB4zmHDg5Me5VnLBv1ad88VRl+0t2RjDmzYoD8xlSCfR2/YvrZxQq32sDPGjqj/Q
	iE+mC2pGag/xBi5ZPkMw/Soyxh69qf1zA=
X-Google-Smtp-Source: AGHT+IHaSraNc4If8Dzd5YNvgi4mmUzyWm2Z50NAMbHyNH0U41IN9l6+nuCKoX1UgOAsxQqPQJFcK8/TocEH3Gv7YUE=
X-Received: by 2002:a17:903:1a2e:b0:225:abd2:5e4b with SMTP id
 d9443c01a7336-23198127775mr4086715ad.16.1747157588769; Tue, 13 May 2025
 10:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172027.691520737@linuxfoundation.org>
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 May 2025 18:32:57 +0100
X-Gm-Features: AX0GCFv3ol3ofoxdFfKQkwZwmjcTr6QqYSytm9VmW8NQd-dGeucGQGrJiJFq2Gk
Message-ID: <CA+G9fYsQTEcYgaBP8L2+ypF2KRszCUWiPSc8kpxZwcQ00HYzGw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 19:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.91-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on mips defconfig tinyconfig and allnoconfig builds failed with
clang-20 toolchain on stable-rc 6.6.91-rc1, 6.14.7-rc1 and 6.12.29-rc1.
But, builds pass with gcc-12.

* mips, build
  - clang-20-allnoconfig
  - clang-20-defconfig
  - clang-20-tinyconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: mips defconfig clang-20 instantiation error expected
an immediate

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error mips
<instantiation>:7:11: error: expected an immediate
 ori $26, r4k_wait_idle_size - 2
          ^
<instantiation>:10:13: error: expected an immediate
 addiu $26, r4k_wait_exit - r4k_wait_insn + 2
            ^
<instantiation>:10:29: error: expected an immediate
 addiu $26, r4k_wait_exit - r4k_wait_insn + 2
                            ^
<instantiation>:7:11: error: expected an immediate
 ori $26, r4k_wait_idle_size - 2
          ^
<instantiation>:10:13: error: expected an immediate
 addiu $26, r4k_wait_exit - r4k_wait_insn + 2
            ^
<instantiation>:10:29: error: expected an immediate
 addiu $26, r4k_wait_exit - r4k_wait_insn + 2

                            ^

The bisection found this as first bad commit,

    MIPS: Fix idle VS timer enqueue
    [ Upstream commit 56651128e2fbad80f632f388d6bf1f39c928267a ]


## Build mips
* Build log: https://qa-reports.linaro.org/api/testruns/28415740/log_file/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.90-114-gbb031f5ca8bd/testrun/28415740/suite/build/test/clang-20-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.90-114-gbb031f5ca8bd/testrun/28415740/suite/build/test/clang-20-defconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2x0VamyqibDAUz06y5ot4qMwMFU/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2x0VamyqibDAUz06y5ot4qMwMFU/config
* Toolchain: clang-20

## Build
* kernel: 6.6.91-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: bb031f5ca8bd915d7802486e59e860738824e535
* git describe: v6.6.90-114-gbb031f5ca8bd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.90-114-gbb031f5ca8bd

## Test Regressions (compared to v6.6.89-130-ga7b3b5860e08)
* mips, build
  - clang-20-allnoconfig
  - clang-20-defconfig
  - clang-20-tinyconfig


## Metric Regressions (compared to v6.6.89-130-ga7b3b5860e08)

## Test Fixes (compared to v6.6.89-130-ga7b3b5860e08)

## Metric Fixes (compared to v6.6.89-130-ga7b3b5860e08)

## Test result summary
total: 119656, pass: 98071, fail: 4521, skip: 16650, xfail: 414

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 43 passed, 0 failed, 1 skipped
* i386: 27 total, 20 passed, 7 failed
* mips: 26 total, 19 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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
* kselftest-mm
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

--
Linaro LKFT
https://lkft.linaro.org

