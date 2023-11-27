Return-Path: <stable+bounces-2760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5937FA2E5
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46ED7B2105F
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CE2EB13;
	Mon, 27 Nov 2023 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xczyG6CX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438F1FEB
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 06:33:41 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d7e8da5e99so2337595a34.2
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 06:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701095621; x=1701700421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mkf9QcG9pXv0Qdie0/NQ3M3Nqa2uonDOOeKyBty/vA=;
        b=xczyG6CXSKr/7rkNK+RW8PuaPK8cCXsivfRuhEZSHi8NNwQJ2hzHYkkxKqmmGrpFam
         LzmfdJLCKK4NyuFEn+T0FknRkuN8CU4uhK7KNW+66vtYuHKF9DkK6lgeIKx36XGpdC0d
         oDBgeMNRc9Py9ROh+x3Ch/1+1se+7Oo6wKd9Le8tyhE0+PERnNV/3APer5pk7oDjsDrd
         E4/IDpOm4kwtyDeeoi0jEbxPXTEtxIrIUTfamefKiXIEE07iETki1dmMq+yLzjFjf05L
         JN+7dECiyOW0GLAnPCk35c/CyeuPS279mI85EstvRU033Cs5Lq30iZTa6mSPy6tjlDOl
         /WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095621; x=1701700421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Mkf9QcG9pXv0Qdie0/NQ3M3Nqa2uonDOOeKyBty/vA=;
        b=BcYZ6HRayzg/ayn6njPPcnoxnkNOVjer9m9v75ah86RND3GU6JRJdFXdOwSdNO0ZIk
         SG5HwUxdB52JxQWUCg25V+yddHvzeOcldKHJDZ3R96rd2oE/3m199Xrg6wjC696mJZ1J
         Z6WijqcchmTOkxZXcHuLv7909/Ws4kW/Jj6TwIjacYl6pldr9zFQocmzc6QsX8Oo3+1T
         4XMgsVXrb0iTqWkLQE0evWc+y65sH91eO/IXfFC7xU+tcF5QATybO+nTzWgyOJ7pVrQc
         y16WSH1smxlnl8uyNpSNGi2BIK/PJa9bm/aBdys/PBsnvZ43qX0Fjv3BCswEm4FijTBT
         BRdQ==
X-Gm-Message-State: AOJu0YyNqtIBSOv2xLlq2kAFvFYi89sQfjRqVjdl5QotiJ6qRhU2prWP
	+jgVx63nWS3b3+7V6geEC6T3iYXmgZ5EJRuHeRMbZQ==
X-Google-Smtp-Source: AGHT+IFL0Daxg/eseyWSM5ZIm84vrvKN7f+QFiyVVolXNZQwTeRn7X5tk1ApVycvVSZVAYVR2565sXctWyEw7Dbd7Mc=
X-Received: by 2002:a05:6358:2249:b0:16b:f69d:c8e7 with SMTP id
 i9-20020a056358224900b0016bf69dc8e7mr6752393rwc.0.1701095620791; Mon, 27 Nov
 2023 06:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163059.878143365@linuxfoundation.org>
In-Reply-To: <20231125163059.878143365@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Nov 2023 20:03:29 +0530
Message-ID: <CA+G9fYt5W8CX_2B-6piLu5YytSx+ZoSKcOOo-ppO+u9jGzeWmQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 22:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.331 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.331-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 39ca2c4cec46e5ef545815f62be91cba998b8927
* git describe: v4.14.330-54-g39ca2c4cec46
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.330-54-g39ca2c4cec46

## Test Regressions (compared to v4.14.330)

## Metric Regressions (compared to v4.14.330)

## Test Fixes (compared to v4.14.330)

## Metric Fixes (compared to v4.14.330)

## Test result summary
total: 54577, pass: 45662, fail: 1547, skip: 7326, xfail: 42

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
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
* kselftest-vm
* kselftest-watchdog
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

