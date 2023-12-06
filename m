Return-Path: <stable+bounces-4825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24C806D8A
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F7D1F213B4
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E131599;
	Wed,  6 Dec 2023 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAtLtfP6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05218137
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 03:12:30 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so2006022241.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861149; x=1702465949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UubSG//sobKoRD33O6F2nApl3ZVDUMYW81HNRkiEIo=;
        b=RAtLtfP6AT+g9UPBV5Xz8lq/6CB0Dr0YhY0vB06OVjB7mz+6AVGs+9vNJ/F+OiTPGY
         alvO2yOWmXULsK6htcb8EnjE6jro6ud3/kyipalwHLQMmxVWzORCP52yqznM0/k/ZkUP
         nD1gvjoztOIKbuZ2jNfFIUiANEqzngvtNAfJYna73tZwzSnd0APKCoNDpcRtXa3V4EV4
         4TmNZSyHifge7D7hD/Ry1wEQFoOfUUGfgbfDu74Fl2wDXdRbWimMsQQokLDVPV4Ped2O
         y/vNhNGxgR1+FtkL5vRtBzi9/f7tmS7F0R6jFJdraXrEVDmCpYnsDevs3U3Rulz20QR4
         c+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861149; x=1702465949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UubSG//sobKoRD33O6F2nApl3ZVDUMYW81HNRkiEIo=;
        b=dCskZZVduPtL1QDtkh78wBY/pWWjiMpHs3BwxwdKAAiTDjVln8QWR7zhAkvxcNts39
         MgLiCVqiOSgCirWfirWEFGYswWxqOfEYp8r2F25cjgqsTvk+y68Ilj/VBT9Xr9YV7VIl
         7OqHcLUkmhDTD0F7fBWxEzFyy7wtAYdtzhsLIYd+mLvv6n9dbtElYFTcSz8WhdeMoaFz
         sMH5mHAKLBYJb1RXdJfGWa7NVKIvID4+6pjRtV18XUDf5O5kilXXhkT6QiQ/GymqSTVm
         o2mza3fyLFMmmiyfO8hl1yKuf+KiVkDP35me90VTrg04cfCwXwFkHozs3NCD//WBQYg5
         F8xQ==
X-Gm-Message-State: AOJu0YxkmPBqqFTTwyBwZcd59IQ8zMKz/u1a+uClsVCCbrZTYz/CgM9O
	jM27CYWgsYaiAR9Vkt6iPxsK1d3/VmvdlBPvNYRgLQ==
X-Google-Smtp-Source: AGHT+IEHidwbwpgNXmJ6MjWYNBfa3WUcLMr01LVFkssVIxIj415CK0pHbZj8DOAExFJwLgoQHJSK+7fccH16ZKyb5sQ=
X-Received: by 2002:a05:6102:c87:b0:464:73d8:769a with SMTP id
 f7-20020a0561020c8700b0046473d8769amr692447vst.26.1701861148966; Wed, 06 Dec
 2023 03:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205183248.388576393@linuxfoundation.org>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Dec 2023 16:42:17 +0530
Message-ID: <CA+G9fYsEnqEnPNsaV--Ugp9hAbrr7yDwdokJuZ=jpUBEgY9+EQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Following regressions from the previous round have been fixed now.
* ltp-syscalls
  - preadv03
  - preadv03_64

## Build
* kernel: 6.1.66-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b22b2d52d0a36cac86d9e27a0dd7bbcfb3b36fa9
* git describe: v6.1.65-106-gb22b2d52d0a3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-106-gb22b2d52d0a3

## Test Regressions (compared to v6.1.65)

## Metric Regressions (compared to v6.1.65)

## Test Fixes (compared to v6.1.65)
* ltp-syscalls - all devices
  - preadv03
  - preadv03_64

## Metric Fixes (compared to v6.1.65)

## Test result summary
total: 127405, pass: 107870, fail: 2806, skip: 16606, xfail: 123

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 130 passed, 21 failed
* arm64: 52 total, 46 passed, 6 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

