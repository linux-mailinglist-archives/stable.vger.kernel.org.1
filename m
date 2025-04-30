Return-Path: <stable+bounces-139218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99CAA533A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 20:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6697164A59
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CC265614;
	Wed, 30 Apr 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK0xF1VV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205827A470
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036014; cv=none; b=PqhuLfG0u9ZTbBQ9gjX/NBUtvrpPWuwESp/4wP8VkueD6T9bzX8zFHeFW6L4bQOwHmtjXfSmB0YrdMD6Le1ZMEvJaHGqincMu7jICXb5AL1PxywEAxbC6oj57RP0Tsl0dnPPm/MIHemMEE065ShpxDqwDH3tcYCFFNNQqroQLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036014; c=relaxed/simple;
	bh=10pmLhKzUmr3h7vg9qIfs6b/59122c370o19zaJP0hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5xRylahoeQ3d0gpm959k0C68oeMRwnpSDJ8xBFiBvyVMH8cUPAPs4FyulEf8tp0+jNJEZjqbBuspfLTPakV1eZ2MJqykfZwk/T69RavqZpri8sTa0ap7HGL6M1CxhhPDoDaucEM2thb0VfhOuUufedSXJCVI1u/abz3WctOtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK0xF1VV; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52934f4fb23so95011e0c.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746036010; x=1746640810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCof9VBkXgR10L5RBwKjY3VTomGE1kUW0h6R7CFwK7o=;
        b=bK0xF1VVZD7TfaW8cvaSaI2n5CtvjYWk04Gq4237PgyaL9XaGSP7bfUUrbhUozK7br
         zfhyzMTo4sH23k/3JZoDFmavJyLRpxGtS38BmCU+GKb86aYQUovNEVK74vLB5f6OJo8h
         4RRNyCpDVkwF7TPQLD3GJlSFvuKrLtcW7wHO/lUusO79xNVjzQrueC0MoXXuFOesdZzl
         z3F35JIPQkhSefW6JQSAeMIFdYdIwBP/5iKKdCDT18Yh6FzspT/DKlhIv6b60Beawibb
         F7CLEyUTNIIQTkTEl509KGO8e7TcDrYnrd4nApRPwIGlkIjl7bj+pxWs1AIOpjfR3BGL
         FpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036010; x=1746640810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCof9VBkXgR10L5RBwKjY3VTomGE1kUW0h6R7CFwK7o=;
        b=tpyKy4u0KPaf/WtQvRFloJw6Zqv7SCOvVEzVQvrYyY8ltzwExo8nFYLMLMKq11cTik
         dZMMovSEN/aYlV2bLuiWUZV1ymyYR5tSpPFIRG3mi29lN2lVvjRc/2GXJIcfFqoYArf/
         tcxyW5v1LVPoGOSLImO/4M9aG88y10u2JfseYCYH7CJfzAyUVNNzV+ZD6VrDmRM+CfmQ
         J17j+8cw5VNH91wjYDDsfAlSpbP/QsEx2WvVa21B4Uv+zXdVj8AAjZi3dd/IxBVZRwrO
         47oKuaYDc2/7pXWKJoWs+BQE58DDYIqPpsdewOgbtbY/10OBrsh3vTnDpYAB/YdfulY1
         DUCQ==
X-Gm-Message-State: AOJu0YyP6w2U77KHrXitVGW/HQEVu9v0Eoe6QwqYeQj9LR5JXS3j3gsA
	hXMVmlSHmoCFJVHHkC4ya45WdmS0v1JGCOla8Fz/hDprO5GAFQGwpQEgOB90bh7FmMAy1pG2usk
	DlhjCrwyDwotd7wBSZUxRtEGCCWRiZt7Pxepey97tV8c85x3YUhk=
X-Gm-Gg: ASbGncsAnFtmqcHG4FTFBuHzIfVsWbXLo4GrcgioGfrNsGvTn3I82ibpgGpOC54NWdV
	SLSPALn7rZmeBRm8bTtO9Ei0KiHr4tOkU3oV6Mevk40KjqfIE48rozDKieTBAYYrhc/w59uzxLz
	IXjAe5DdTp8Lk0ckkSy0CDtFwraw+jh28o4AQuOfUC4K3EkNWCf+Roka0=
X-Google-Smtp-Source: AGHT+IGZ9gQ3tu+qzuFMr0iUFZmrrGHM6mufdWGBmolg3g4UfIuy5JKVSAR8n7Xn1WvRpeLZXbEb1LtM6OVxDrfeO18=
X-Received: by 2002:a05:6102:152a:b0:4c1:94df:9aea with SMTP id
 ada2fe7eead31-4dad35bd8admr3238552137.15.1746036010199; Wed, 30 Apr 2025
 11:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161059.396852607@linuxfoundation.org>
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Apr 2025 23:29:58 +0530
X-Gm-Features: ATxdqUGSmMl820yTA2v7nLItMEKSOy9gbZK2IzfLWQ2IEh-AL8fgRuomfjJoYNc
Message-ID: <CA+G9fYs2AK7jGyJ-kR884-CJA3RRLLWD8r1L5fKLYn68TSQ1ow@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/204] 6.6.89-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 23:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.89-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following two build regressions found one on riscv and s390.

1)
Regressions on riscv build with allyesconfig and allmodconfig with toolchains
gcc-13 and clang-20 failed on stable-rc 6.6.89-rc1.

* riscv, build
  - clang-20-allmodconfig
  - gcc-13-allmodconfig
  - gcc-13-allyesconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: riscv uprobes.c error unused variable 'start'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error riscv
arch/riscv/kernel/probes/uprobes.c: In function 'arch_uprobe_copy_ixol':
arch/riscv/kernel/probes/uprobes.c:170:23: error: unused variable
'start' [-Werror=unused-variable]
  170 |         unsigned long start = (unsigned long)dst;
      |                       ^~~~~
cc1: all warnings being treated as errors

## Build riscv
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28273725/suite/build/test/gcc-13-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28273725/suite/build/test/gcc-13-allmodconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28273725/suite/build/test/gcc-13-allmodconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2wPmvuQupVPFOxaqXSUOvDNirrW/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2wPmvuQupVPFOxaqXSUOvDNirrW/config
* Toolchain:  gcc-13 clang-20

2)
Regressions on s390 build regressions with defconfig with gcc-13/8 and
clang-20/clang-nightly on the stable-rc 6.6.89-rc1.

* s390, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-allmodconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: s390 pci_fixup.c error 'struct pci_dev' has no
member named 'non_mappable_bars'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error s390
arch/s390/pci/pci_fixup.c: In function 'zpci_ism_bar_no_mmap':
arch/s390/pci/pci_fixup.c:19:13: error: 'struct pci_dev' has no member
named 'non_mappable_bars'
   19 |         pdev->non_mappable_bars = 1;
      |             ^~

## Build s390
* Build log:  https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28271143/suite/build/test/gcc-13-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28271143/suite/build/test/gcc-13-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1/testrun/28271143/suite/build/test/gcc-13-defconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2wPmvTChk1B5KLhldYbYaKP2ckj/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2wPmvTChk1B5KLhldYbYaKP2ckj/config
* Toolchain: gcc-8 gcc-13 clang-20 clang-nightly

## Build
* kernel: 6.6.89-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: cbfb000abca1fdde27066eaf6cb77cbddc7a21c6
* git describe: v6.6.87-594-gcbfb000abca1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.87-594-gcbfb000abca1

## Test Regressions (compared to v6.6.87-394-g2b9f423a149b)

* riscv, build
  - clang-20-allmodconfig
  - gcc-13-allmodconfig
  - gcc-13-allyesconfig

* s390, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-allmodconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d


## Metric Regressions (compared to v6.6.87-394-g2b9f423a149b)

## Test Fixes (compared to v6.6.87-394-g2b9f423a149b)

## Metric Fixes (compared to v6.6.87-394-g2b9f423a149b)

## Test result summary
total: 127756, pass: 105351, fail: 5243, skip: 16647, xfail: 515

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 27 total, 20 passed, 7 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 17 passed, 3 failed
* s390: 14 total, 8 passed, 6 failed
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

