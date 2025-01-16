Return-Path: <stable+bounces-109240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 375ABA13845
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8481885D5C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD221DE2BD;
	Thu, 16 Jan 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWAYUStC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FB1DE2A6
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024518; cv=none; b=iLFzuEg97hz65kUZMjoDx03ah35zcuiMn97iEFFNH4fXrRgPk27qkIILKj8jJ+7XH/gM/DPGU8HcYOC4+TCZIUCEjQE+lyapPYEBjI7JwYRWlMS6wfQ8QVkxMU2+o4pCoRj9QwvRPXQ6aH3dQTGtzinJGonrxQM4lofWEUS06tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024518; c=relaxed/simple;
	bh=u9XFg39HPyG8rqv7eF8mTN149vcnkYLhk08IiOkjGkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0qFBznbudZ23MNQkbDFj3iydhE4Fy1R2fShtpzPKHIv93yGXOkKLB1H4fYWFeb+QidWEwGGSdiL2M0BmWaBmSlDEigDYlOP0nfV28ztkku7xLM4ykSRMWe1p98IrSOk00CYvoot7tfBrvZU9evyr3LggCdg50Jk6R7SiF497zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWAYUStC; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afd68271b6so143974137.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737024515; x=1737629315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCT1zI4OT1vpFsYxXFe9LQUvS7Xlh9EgI5AipLw3miM=;
        b=wWAYUStClN7EXlEfIZ33VpHVBT6mCVcWOkHWg/aP/gLpv4u0nRa9cyvNGivU7Ovn39
         WWSTN7DBUPxTTtRH+6iippThliGNcTz/r2AoOAPX5IZ9820uBc4lBnPFEDU92r5iR2fi
         OG/3a7bfMyci5FKdRccuAOM6gcSRqq4xV3DApIQN15lc/wuGikoqvmts236Z5R+RL0G/
         3rRfDOdZd1efrFHCKHRK0G6tQeeuJfENV8sxwV1JSslY32OJ1FGU+U3N4BiwHiaKpBpj
         irRZ+x+bX4YYXbTVhLeyxOn37FEI5bdFo+J3iz3L65HtOUiO4eehoSv5ksqx3VeLmQ7Z
         1Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024515; x=1737629315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCT1zI4OT1vpFsYxXFe9LQUvS7Xlh9EgI5AipLw3miM=;
        b=w+QtW20cWl311vr/ZuuGyS9vanFjkAM5rJCSwi1Q1tSpiVpulmeoi5znhtEvDVVN5T
         Eohk2dZNJ1nVkSVNisDOFKSuS7OD5GXf5Cwcc70NFCFjHaexS3236hwQp4PyJq1/dvqA
         74OrkgZX/IzYaXLbgooLPf09uihw0Iso1SASj8GzM/qxZjinyl4f62WfVD4H/Jb3cSMm
         ud/1gzi1UaAX/nz9R1RvVoqtnIAnFF840jYsepVXccUclv1uhxsrHgvuwzESMw3BEg4l
         5cGDD+hXs6gTqxU3+Uk1jQGkzGIp7qrY6pSau6dRN6HxHqxTgr86rk5hRlJ43k1gP4O0
         +a8Q==
X-Gm-Message-State: AOJu0YxetURlpsZnWtdxae/Z+UP5BFLFJHb7JoHgjqbK5SnpngFPoL6Q
	6o+xMDuvt6hw3YuZcLoY0LOy1XqvnHs1HuYBV7r1/Z37VQuy7yA2ZXJDcIrz2WfJ9v7iZG3uZXr
	nlBPRDSn8AN/n1ZAe0oxfHnvNydt7Ol+BxYrvKA==
X-Gm-Gg: ASbGncsqt+IjJGxdscsD5w0lGKAt5MCGBo6DdxSqonj+KoU0qBDA+EmVc1Q1XCIZF/f
	hEcyYA2xUw4wCbdjv3IrKfbxKEvTiFr6MmLeIA90=
X-Google-Smtp-Source: AGHT+IG8gYhAWxdgo4p4HzmjwQWQ94NvOR5d54MWDMQAfpeO9WURUE8UD95sTlO+C1IU9Qx2OQ0F4OEBu0Ka2fnenk8=
X-Received: by 2002:a05:6102:2b81:b0:4b2:48ef:3cf2 with SMTP id
 ada2fe7eead31-4b3d0fe7048mr29507046137.25.1737024515296; Thu, 16 Jan 2025
 02:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103547.522503305@linuxfoundation.org>
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 Jan 2025 16:18:24 +0530
X-Gm-Features: AbW1kvbHnl8KdKwXAVuaxCqnHkSKU6IB1QZRoqweOPf4JkpbzgeHXkmoeBTwW0M
Message-ID: <CA+G9fYs6cKNmVBqeo_weTAPmJmBH_A_ai1WYvLwtnXcf3TDoiA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Kai-Heng Feng <kaihengf@nvidia.com>, Wayne Chang <waynec@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.125 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.125-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As other reported,
The arm axm55xx_defconfig and footbridge_defconfig build failed and
also arc, mips, parisc, Powerpc, s390 and sh builds failed with below
warnings / errors.

Error:
----
drivers/usb/core/port.c:417:21: error: no member named
'port_is_suspended' in 'struct usb_device'
  417 |         if (udev && !udev->port_is_suspended) {
      |                      ~~~~  ^
1 error generated.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Build regression:
gcc-compiler-drivers_usb_core_port_c-error-struct-usb_device-has-no-member-named-port_is_suspended

The bad commit points to,
  USB: core: Disable LPM only for non-suspended ports
   commit 59bfeaf5454b7e764288d84802577f4a99bf0819 upstream.

## Build
* kernel: 6.1.125-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f121d22cf28ea1a09e9040843f57dd73dde42bc0
* git describe: v6.1.124-93-gf121d22cf28e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.124-93-gf121d22cf28e

## Test Regressions (compared to v6.1.123-82-g88f2306b7d74)
* arc, build
  - gcc-9-axs103_defconfig
  - gcc-9-vdk_hs38_smp_defconfig

* arm, build
  - clang-19-axm55xx_defconfig
  - clang-19-footbridge_defconfig
  - clang-nightly-axm55xx_defconfig
  - clang-nightly-footbridge_defconfig
  - gcc-13-axm55xx_defconfig
  - gcc-13-footbridge_defconfig
  - gcc-8-axm55xx_defconfig
  - gcc-8-footbridge_defconfig

* mips, build
  - gcc-12-ath79_defconfig
  - gcc-12-bcm47xx_defconfig
  - gcc-12-rt305x_defconfig
  - gcc-8-ath79_defconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-rt305x_defconfig

* parisc, build
  - gcc-11-allmodconfig
  - gcc-11-allyesconfig
  - gcc-11-defconfig

* powerpc, build
  - clang-19-cell_defconfig
  - clang-19-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-ppc64e_defconfig
  - gcc-8-cell_defconfig
  - gcc-8-ppc64e_defconfig

* s390, build
  - clang-19-allmodconfig
  - clang-19-allyesconfig
  - gcc-13-allmodconfig
  - gcc-13-allyesconfig
  - gcc-8-allyesconfig

* sh, build
  - gcc-11-defconfig
  - gcc-11-shx3_defconfig
  - gcc-8-defconfig
  - gcc-8-shx3_defconfig


## Metric Regressions (compared to v6.1.123-82-g88f2306b7d74)

## Test Fixes (compared to v6.1.123-82-g88f2306b7d74)

## Metric Fixes (compared to v6.1.123-82-g88f2306b7d74)

## Test result summary
total: 82792, pass: 63395, fail: 4390, skip: 14641, xfail: 366

## Build Summary
* arc: 6 total, 3 passed, 3 failed
* arm: 139 total, 131 passed, 8 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 19 passed, 11 failed
* parisc: 5 total, 2 passed, 3 failed
* powerpc: 36 total, 25 passed, 11 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 12 passed, 6 failed
* sh: 12 total, 6 passed, 6 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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

