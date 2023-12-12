Return-Path: <stable+bounces-6473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B480F274
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B36281B0D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD977F2D;
	Tue, 12 Dec 2023 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SItsHyYh"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D398
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:29:16 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-46484f37549so2061751137.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702398555; x=1703003355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySNEeZzkT5HeoVN/1lYVLQEQlZebmBvQl/23qCP/8ME=;
        b=SItsHyYhjBCoW55TgqPllsCLAGuk8/pJbi8SxslH/mDirnrOxSdQXaP00I3p8NiCC+
         q2aEbxM396UlYu9b4lnffZub34GxLa3KIqgzGmzOsdgAId/+/rzxrg+BKQwlLyG9r8Ox
         RPHAPPsDH72PEHBT38/xFYt791RL+bNKLFOWmWKHbl4lrFOhkyd+JeJGVJnwSPcs63Kt
         MsaO1R4t4tapICE0caA2ZBjz6YH159M9jehbzZ3gXnsVCT360Lfx8nGNddI7dkABtcY2
         qnoNBxpSjIsXX6hmsCXBMI+yyYJP/ah0kcAkeypg34uq3f0g/1p19auHsA6AklTJ3MmD
         s7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398555; x=1703003355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySNEeZzkT5HeoVN/1lYVLQEQlZebmBvQl/23qCP/8ME=;
        b=WULPnZhYpcyJLf3jMXq/m2nqL/XJ77smlL93jyZjLgVvjSEwlC9i6fnZM9/0eDpRBr
         11YFXmhHzH8wGm+yzSCuQ+XCHPM0YDeMA46Q3nWtwH6A2uZMGjX6gliipn9aFXmRCzvF
         gA12Ik/8RFePYJ9G7/qar5nY7/ig8S1D/6kLnfxNrUBTKmKoCSEsvA42XEaJ9l/4C/r5
         NW4TaRGaYpvmhwBSc17+dMtnrqFP099mRgf/DJkfh33S7bR10CpUfFkQ8TD6iNlIZmHB
         mjmyZrsCIgQ5bOX805P81U01O6Yk3aSE2iPwGz9HUabQUN1Hna7+MN4aRp/DPrCdT7B4
         dl+g==
X-Gm-Message-State: AOJu0YyoHoyaiVrN3GJpnL8uT7IT2VPlS+AuQ6DpdbmKbaYecwGlZnnF
	4FaADxXZ9iQiwZkQI4N8zjwV7CBi88v2++PYXdb1hHUvtY7uozJ0uDY=
X-Google-Smtp-Source: AGHT+IEeCdPmkS9YxQ3As9yyYKrZVxVAaQFrNJwqjtaPRa68f+SpKBnM0iLrZSbgFfbsfqiDcisLSTDDOCVZEegmouM=
X-Received: by 2002:a67:b403:0:b0:464:7ce6:9ba5 with SMTP id
 x3-20020a67b403000000b004647ce69ba5mr4240246vsl.32.1702398555322; Tue, 12 Dec
 2023 08:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211182019.802717483@linuxfoundation.org>
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 12 Dec 2023 21:59:04 +0530
Message-ID: <CA+G9fYv24ydc8gV9u7O24hQFKscFF1cnWvbAzaWWcM2DyLxGfA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 at 00:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.204-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.204-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 670205df0377e191c0a123ecce9257eba333bbc5
* git describe: v5.10.203-98-g670205df0377
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.203-98-g670205df0377

## Test Regressions (compared to v5.10.203)

## Metric Regressions (compared to v5.10.203)

## Test Fixes (compared to v5.10.203)

## Metric Fixes (compared to v5.10.203)

## Test result summary
total: 89128, pass: 67943, fail: 3495, skip: 17631, xfail: 59

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

