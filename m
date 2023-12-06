Return-Path: <stable+bounces-4840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC528070B4
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69FC1F2141A
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD61374E9;
	Wed,  6 Dec 2023 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywDDwgjn"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA4C7
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 05:15:35 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-464964d59b7so1013963137.3
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701868534; x=1702473334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39DggU9sTHpsnUoWZEmvwMwfR1yAMVP7JXWAH0X6msw=;
        b=ywDDwgjnWhxiqUqp7rC3rTFbMPbtnjBaIUONzH+D7a+Pu7/CenFHTZjnDEFOE1EInA
         wCCblupu+FbZhs4733xh+tNZ3CilG57sH1oZSSCfVIq55BVrF5S9CsdtIakoyS4jBMtV
         NwVNSAsPunkG8Y0yne7EcS2ff7O7xkUx1hT+htpdpLZg8y7V1ZnKLY6FDlqC5WedcYel
         jCr+E5KZQJVlyHkbNd/1sM5f7CG6Iw3OmESUkgLA4014k9mGRjE2dK/aJ28Wzt2R/r5D
         LmOZWlC8IGRxy+hTZ3yoZIb/nqXupfOiFRiaHJmOmxReaAExbLx4bhWbbSE+WGoP8yoL
         kqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868534; x=1702473334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39DggU9sTHpsnUoWZEmvwMwfR1yAMVP7JXWAH0X6msw=;
        b=qT/jaBI1fY0XNa7ZKP1jT7g3wQUYGpucD67sx5PPCWTHJNI00HdhKy1yUgTfkORctl
         7PVIODVBCBqQ4mLWmRvMIlbutVA/E6TAiV6+eYJJoWA8RQoxbE8ZQr8sZDAhYYNVEyPr
         GPWET6XvwiQmBbZfXIUZIbD6ZFBew7kwqVVPbYMmyzXChz4hXkR+jq1GcY5j3Jp0+nbP
         8qQruiie4qAkZzhybw6ewfCQoU0YnQPj0kq4e8sXZA2NodzaqeCEXa61l5EYbU/afxmy
         T/mhEvBtUBx39DozGVZZGb15WaqadgOUWw9s6K0kGjkuQczozWDloC+SEprm13kzeVCI
         KXyw==
X-Gm-Message-State: AOJu0YyXE4If4EN2JTPd4CQrXA/IZq167iCR7gO9igPIZhI5+P7H0h/J
	nCooqP9GZTmgxUSxLhX1y38f8rksCrBA6GV5ruzxFw==
X-Google-Smtp-Source: AGHT+IGx7fu4jijoKMqQ8y3ZfqwsaN43tRyxC36L7eMmwuNg36EnQrysFEpN8/HA5UKrzboEFzI7wVyWWNPTVvryF6w=
X-Received: by 2002:a05:6122:1782:b0:4b2:c554:fbb3 with SMTP id
 o2-20020a056122178200b004b2c554fbb3mr807554vkf.21.1701868534305; Wed, 06 Dec
 2023 05:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205183241.636315882@linuxfoundation.org>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Dec 2023 18:45:23 +0530
Message-ID: <CA+G9fYsKJfHPS2NgRkg4o0acA82eGreFLRtm2ZuGZbi0A4TeUg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
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
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.263-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 97430ed51c915b4a8037655ac6656a644fd42e9e
* git describe: v5.4.262-91-g97430ed51c91
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.262-91-g97430ed51c91

## Test Regressions (compared to v5.4.262)

## Metric Regressions (compared to v5.4.262)

## Test Fixes (compared to v5.4.262)

## Metric Fixes (compared to v5.4.262)

## Test result summary
total: 90072, pass: 70700, fail: 2384, skip: 16945, xfail: 43

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 129 passed, 19 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
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

