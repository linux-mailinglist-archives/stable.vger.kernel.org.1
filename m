Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973AD7BFFEC
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJJPEZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJJPEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 11:04:24 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966A97
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:04:22 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57be3d8e738so3129504eaf.1
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696950262; x=1697555062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SAEbd0VwxslKJnxKMj+GJmEDHTq1sVdO9guwnutcFY=;
        b=C8518zwevuy9DOG6vm4Ge5T8z0UKdO00VccHkh/0tvE1Tjru43ET+7cMUxs632ejsA
         jjpVZwC6AAvLjVPjevV+FG8wjBGGY9NN5K2nGI6JxBayOdSpPJTGScjDslNUTxJ5Fylu
         AEFY4ItSF81kV8EX96TuN+jTlniZUksTl0v/7m2DFXqa5qYxBcVm7hOH7nEsgzwKN3+J
         HtjwFs7PSafI/pGjOoA0JjECQiV9vsku3QZaLIkd3XSWMSy7OPZTLDnHcCmR1AbCjj1l
         VXkgtK7B2OHS32u7VOjRHDJzpJAKPk1dAJVff0ukGifzdl83uLufe8SR93HzI59CuYVh
         1ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950262; x=1697555062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SAEbd0VwxslKJnxKMj+GJmEDHTq1sVdO9guwnutcFY=;
        b=jCJuDgZDA2QJR5RiOjI7lfyOwSmJCZr2k0TNzFXfl6eu5Kf+M064PNhCjLDkDgEg6N
         Vj79LQ+fi+uPoa/aiUonFIHD/9Lx0qdWmxJypeUoFrZv6NDtBI5od9gusxW6Nsyn7ccA
         fNspJiglrtN5fcTHeKBvkJq5oNqx4Y8gdJ3JomsNy9yaE+YBjS2x1ik3tHAVXg/htI9g
         3xaNxXC753GE6Qj5q4Snvn3s1KDBdweW3D3n4kpJ0b7pa4Cm2mE0Psem6XiHc+/YoJxm
         P0HT4l6LXu0ZHJ7/GVn+wqS7cBe4A12FG6KzltrOcRv1vre0V0gItCuiD6/nnd/XYuOk
         ypNg==
X-Gm-Message-State: AOJu0YzYiG8V0s3OqSsRwg2EISVh9d53QFQeOkVk+K8Ow3SbX/mQ9eAT
        dkqxTqAVJJZUE1/srjFdo5wwFVpXRTelxRZvhuQ38w==
X-Google-Smtp-Source: AGHT+IEEYpapbrwGyfoVUt6tiVqNaYx8L9UiAUIKvj+j36i41JVIjMX00ZBNaMkRfypAltACXf2zYmklGH7J+qRr878=
X-Received: by 2002:a05:6358:2906:b0:134:dc90:b7d1 with SMTP id
 y6-20020a056358290600b00134dc90b7d1mr22725552rwb.25.1696950261802; Tue, 10
 Oct 2023 08:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130124.021290599@linuxfoundation.org>
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 10 Oct 2023 20:34:10 +0530
Message-ID: <CA+G9fYvXPjVW-kH11PHAyWcOWdJuXO6PF9uemvGqUVxrwBm3dQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 9 Oct 2023 at 18:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.7-rc1.gz
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

NOTE:
Build warning on armv7,
net/mac80211/mlme.c: In function 'ieee80211_rx_mgmt_assoc_resp':
net/mac80211/mlme.c:5474:1: warning: the frame size of 1064 bytes is
larger than 1024 bytes [-Wframe-larger-than=3D]

## Build
* kernel: 6.5.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: e640325b3c9a18f1de24daa332563620eb03309e
* git describe: v6.5.6-164-ge640325b3c9a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.6=
-164-ge640325b3c9a

## Test Regressions (compared to v6.5.6)

## Metric Regressions (compared to v6.5.6)

## Test Fixes (compared to v6.5.6)

## Metric Fixes (compared to v6.5.6)

## Test result summary
total: 132702, pass: 113630, fail: 2151, skip: 16744, xfail: 177

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 141 passed, 0 failed
* arm64: 52 total, 51 passed, 1 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 37 total, 35 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 13 passed, 3 failed
* sh: 14 total, 12 passed, 2 failed
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
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
