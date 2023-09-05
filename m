Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE3792807
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjIEQAo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353792AbjIEIQC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 04:16:02 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B01AE
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 01:15:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44d4c3fa6a6so894829137.0
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693901758; x=1694506558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54+t+GkvMz0+EsIrXlLUHC247aFke2V/z6h4/2GcDU=;
        b=oegmXLLOJ1Dv451Dmz3Xr9y8BaXt0ufSRa4qeUAkZlSspDobVon5c1iDvTx5Iv2IWA
         ikmZuJsgpziOi9cZzXexXLvB+15IxAgV1N3pArHhp/GaAptTs1srJfstRLA0l6ciB1MM
         c6H2/TY/cb4SklhwO5SQ8XWoqwsxJQwy+X9rPZ89DhMSi52TC0kIhBKnIhXf+7SB0uYK
         HPT+0FXCQnh6FA5NoBlVoe7uXHKrVNmeB4DlwHOp4ycss0Qp5UNg4hgMgD4yMDl2uXPZ
         QHzoUnmsKPrriTpBvNjq8hLsEwl2uDlOwVkF25JQTaukQnI5e4jT0jnmRrYSvQTwYgtf
         EDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693901758; x=1694506558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q54+t+GkvMz0+EsIrXlLUHC247aFke2V/z6h4/2GcDU=;
        b=d3codu0IHJWwD47Lhp/P7A3Ix7eXNxoBcNp8DQMPZqc3IDB/dpsQjSpdvGMI3KO/j4
         6WFXDGZXxbdlGocnwXCDDo2FHuUOo0dY+ZLgoEuUK8O6cEaWALfe+cMIYnEX6w82n33J
         b1FdpMqltSHGeyIptw1O7H9BVUdaU+4SBOFwbnqLPMq53pOXgNG6poHbUyXeAysNqyqs
         J7g/5C3j4YWP4ogvO5B40GKHAOPhXhUQAKzPL1UR12KC8EYl7MK1WfXeEchCOcG2tnpN
         KF7X6V75jqWrWovq4Ilswd3DMPZrTNaU09pvvcMDk1C0OCuHeKjUKFngpSIqiUJ/d2YG
         xyXg==
X-Gm-Message-State: AOJu0YzuEC//OUF3zH7yHL5locOQxiXdSh6q9hqn/jyBMhAeJUv9QD5C
        8eiiGw+3x4sFbgmqXqia12KxtnfiOi9mZW4mPvhI8fGlkE7XDUhqVjo=
X-Google-Smtp-Source: AGHT+IHsKZp4iDKBLFP1UeXIV+qaRIH3SJ/11EW4C6xwXMMWSQDhVHAvHyS3ZhAORKFgZUZ/IxVjp04oYbfGd15tqds=
X-Received: by 2002:a67:e951:0:b0:44d:4aa1:9d3a with SMTP id
 p17-20020a67e951000000b0044d4aa19d3amr11478780vso.32.1693901757911; Tue, 05
 Sep 2023 01:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182948.594404081@linuxfoundation.org>
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Sep 2023 13:45:46 +0530
Message-ID: <CA+G9fYv-JmXWxjTuUDGujo39xiaCg8SciMuvKCrqRie4YzA8Vw@mail.gmail.com>
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 5 Sept 2023 at 00:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.5.2-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: 3b1345379dfa8756bebb7a0a5dcb41cf9e0ba98e
* git describe: v6.5.1-35-g3b1345379dfa
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.1=
-35-g3b1345379dfa

## Test Regressions (compared to v6.5.1)

## Metric Regressions (compared to v6.5.1)

## Test Fixes (compared to v6.5.1)

## Metric Fixes (compared to v6.5.1)

## Test result summary
total: 142284, pass: 122577, fail: 2113, skip: 17398, xfail: 196

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 142 total, 140 passed, 2 failed
* arm64: 53 total, 50 passed, 3 failed
* i386: 41 total, 39 passed, 2 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 16 total, 13 passed, 3 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 42 passed, 4 failed

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

--
Linaro LKFT
https://lkft.linaro.org
