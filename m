Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94C714A55
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjE2N2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE2N2v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 09:28:51 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7A0B2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 06:28:49 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-437e8282c1fso611516137.2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685366928; x=1687958928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfpPChZUKQrZTPki0R+7lf3LW5qxrB9wk9nZIjbQitU=;
        b=SMHTwzuSsfXtGemlPeq0DlLfuE/l22Z4HU7yATTzlE7JsxaSNUApkjeJgSQ3awl/05
         VVxYD1BHNd8EU4TecrgXam4C3DfcqAFaOYnP0mcZJk//UdhuUk5XVlcMdRRS0Rha4jP1
         +ANvVzrxjF9HRdlkk/CYJAM9klrWW6njDv+Lq6FoZQeayir+goCqTUZbD1aBYadmB9Rc
         hQj31+UNMA1EL4F2PM8L7Zmr9hF6Vgegxanm2FuI3VwFSMehu3z5xNmW5rxrc4ySXLFN
         nmsHsCmYlxatW00yDNPMQA+Jw4MbutwP35Zs6k3t/QHzfG15FLgL3X6ceBn6HA73GY5t
         U4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366928; x=1687958928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfpPChZUKQrZTPki0R+7lf3LW5qxrB9wk9nZIjbQitU=;
        b=cRNkdBLLX9TyqSxMR4K5mFwP6ARJdttE33mnomOo7S3ac0wo4gfLnBwnAuNAddAH0T
         Slw382sv5lwXanx5bz0ebinec+/gMFyO7AlZjp3UbD5AuQ/4HxkslKQD1qBxb+dbLLr1
         9yDpMdx/jA8wTNR7sD4TXVKuvnEbutJ49H6a0qOCtzPQJy9QetKGakyQnyUfI9QT0DiA
         zOeA8EGpO4qaio+jMbbxjku7Z+LTMWUgFccMv2y99CebQZUnDApzVImZbfJvAHpXxKQs
         gOKD66sLt/ii+pf5UKaT2J3laC4RQ9NwbWGR2anjxuJRNXJIezxGcXErAbdhfjPVgTWV
         rSAQ==
X-Gm-Message-State: AC+VfDzjvQ6PFKiAOh7ri/G6eHdly0qaeI3j2Bh0a39sTRXSemYGGown
        R/HFz39rXmVYympqYqtcR1mK0h4+HXmfh3Lll4rq4Q==
X-Google-Smtp-Source: ACHHUZ6Rvl9N4iKcv+LnG+fOM7hYXHO8wX99Xtx2SjVEwR3JcP6o9clCZ9RxMfe9GIN8qE2OBl829EnZQ1HOTY8bioA=
X-Received: by 2002:a05:6102:3019:b0:439:e3c:8ef8 with SMTP id
 s25-20020a056102301900b004390e3c8ef8mr2726326vsa.28.1685366927970; Mon, 29
 May 2023 06:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190835.386670951@linuxfoundation.org>
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 May 2023 18:58:36 +0530
Message-ID: <CA+G9fYs1Y13v1pWZRtqchZTEBAok9BMJ=A-Lzqg3p7BtYQuF3g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 29 May 2023 at 01:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.31-rc1.gz
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
* kernel: 6.1.31-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 8482df0ff7e727d4244b8bf8537cce39a474eefc
* git describe: v6.1.29-413-g8482df0ff7e7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.2=
9-413-g8482df0ff7e7

## Test Regressions (compared to v6.1.29-293-ge00a3d96f756)

## Metric Regressions (compared to v6.1.29-293-ge00a3d96f756)

## Test Fixes (compared to v6.1.29-293-ge00a3d96f756)

## Metric Fixes (compared to v6.1.29-293-ge00a3d96f756)

## Test result summary
total: 170063, pass: 146595, fail: 3956, skip: 19237, xfail: 275

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* igt-gpu-tools
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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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
