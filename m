Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AF6FCD01
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEIRuS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIRuR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 13:50:17 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15E3AAD
        for <stable@vger.kernel.org>; Tue,  9 May 2023 10:50:15 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-780b35fc823so2649795241.2
        for <stable@vger.kernel.org>; Tue, 09 May 2023 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683654614; x=1686246614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4aNOaTI8HiaBrpvAYz/uvXyLMZm5BRoMqS/hObU+XE=;
        b=SXWFRvj6GM+4X5hIZsN1P46oQ/o6sYM/TzLa0dX/TKmILWG4Dh/2bWieF+u4eJEdw6
         9VBVyz94opxC1fRm7PrLMdCVFAN7zRaLZ5TqJYG7RZtQ/6IS0M1ymqEkDOhmvPSqg1AC
         kjS9HuUjvMcBa2If6aict7y/xjj7mLsbybrYzSeL0jnwvn1j7WEzOxDUjePusMWEayRO
         LShXcSL1sBj3aioz4He3xsBbD3X1cSHzoOIyOssNi4H9m2xZzvMvELSOwWSH4NuzvmHZ
         HtveXtYCRJJt4Q5W3da9oYkr0N0VCi9R3KrcUxx4Y2t1e/RnD3vsgsDJBP+VKERlkVzQ
         nNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654614; x=1686246614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4aNOaTI8HiaBrpvAYz/uvXyLMZm5BRoMqS/hObU+XE=;
        b=FhxGodpoUot+nCDMNlhINha6RJJH+CZkyX4be2sG13LK7F4gupRA3MFw57YWSoXU8K
         FnYXR2cNSz1CM1eHtCBJSgfikfoDaSrWO7ZDpssK9mWGrbrt/o2ZCUlEgFiH3sIAJnAi
         fgB0CSIr55cTkJcNjUTYxVUqEsRAAMILS0OBe9ry5vqlFfN4d2ylZBl6VDJEbPVcoIRf
         A/ENMUsefSQfP94Cu9WsjmAh9Bl/7IDPU4SR2gtGRcmH4QdCj6qYgv6ajD2ZmATjX5sR
         K15K3VvmbMccKxvrzZat+05WqcHJcc22WThIijCyHlZbrecGr6Py319zyhWyXTzujmTE
         FYqQ==
X-Gm-Message-State: AC+VfDxTsqzA2QfYt+xP8K9Y6zNuRh9PkYjXM+Gr3tpn2KnX0HsBh4aI
        duw3CekMFBT3yCuJKhT36IhUD4kO7gdyWvdkgHOeKA==
X-Google-Smtp-Source: ACHHUZ4stgvON85kZzf7mBh1ADWZQPAzzLfTGueFSGoY4xHrKTmxyknnwwnoA+zMTop4ntucSfSTceleXS1WPRE3NM0=
X-Received: by 2002:a67:e3bc:0:b0:42f:78d5:d987 with SMTP id
 j28-20020a67e3bc000000b0042f78d5d987mr4749675vsm.1.1683654614028; Tue, 09 May
 2023 10:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030653.039732630@linuxfoundation.org>
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 May 2023 23:20:02 +0530
Message-ID: <CA+G9fYtHRB8n_TxA6CrPfkP7FwL6N5Umg1ate_HA+PeLeoqw1A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 9 May 2023 at 08:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.28-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.28-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.1.y
* git commit: 2b7e1f92aa55cac65688b3de87716bbd0cbfb88d
* git describe: v6.1.22-1202-g2b7e1f92aa55
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.2=
2-1202-g2b7e1f92aa55

## Test Regressions (compared to v6.1.22-591-g58b654bf36db)

## Metric Regressions (compared to v6.1.22-591-g58b654bf36db)

## Test Fixes (compared to v6.1.22-591-g58b654bf36db)

## Metric Fixes (compared to v6.1.22-591-g58b654bf36db)

## Test result summary
total: 326453, pass: 278244, fail: 7551, skip: 40056, xfail: 602

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 297 total, 295 passed, 2 failed
* arm64: 104 total, 103 passed, 1 failed
* i386: 78 total, 74 passed, 4 failed
* mips: 56 total, 54 passed, 2 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 72 total, 70 passed, 2 failed
* riscv: 28 total, 27 passed, 1 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 88 total, 88 passed, 0 failed

## Test suites summary
* boot
* fwts
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
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libhugetlbfs
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
