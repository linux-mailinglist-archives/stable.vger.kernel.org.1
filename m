Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DD740BD8
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjF1Iwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjF1IjA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:39:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C63A84
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:29:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b7f223994fso32882775ad.3
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687940988; x=1690532988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBsZLVTgJrT+03UCUP7W/SIjStfAyEMLyISpbv+xmm8=;
        b=rd2SdqHSUZDHdyDwiFn/n6OSOwUoxcLf/wil6DUWQzzS9rKVwxg1KxXkz+j1mNjpvT
         KHcFUnHF2fYOW/bQyzp+wxnM1VauF+VIzQGUte5vMxUZQKdpvH4O3Xtd9lTrYfMMrUCA
         DAkc8LHzDHH8UpFfuJ9e0nwFsdTlRBLoXq4sN5sgmKSRW1sS/1ZyEb9oTeqp/JBGDu/B
         sEgHf0je+yratQNux9L16Bsy7mZ0T/1HmdPo0OsEER3JlosQKtSh0ys2sXj5vz9zeG+k
         X8XijJX4ZxrKrvLfd8a3S9EzLx1k91cCjQ3+WTgyhl+4zWNwL3wigu55GSQC9H4qHXS5
         dwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940988; x=1690532988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBsZLVTgJrT+03UCUP7W/SIjStfAyEMLyISpbv+xmm8=;
        b=CjN8Kwcu7qqb8kzmkkdTEJw+NcCMbihQtkRV3P0FK3blycEoCc1D8vPeM/OX6A96Mf
         UF4/w3jexgzlgVJFZEvLIluzsoMowxOmdYQCf9mSumwcXdyeziBT8l1pv7BGxLPB6Zdv
         Lt+BgPOyjpS2R+YFDRxmb4X+2FtxscNcvTevBFlxzE4+bHQSprVi60/2tWdhS/Vy9OFT
         PEZ1R6s4im+xksiC8mn9MzLGzzku/DkeS6nhESyYGE/tP/t3HEpfgmRBlvLBMt94Wxvu
         lc4/p5fHixoYRe/pzhQJm2SJTsDjET5b/BMKNz4k3ilctZDxJNOWG64pfPdKml3kEzMv
         d1rA==
X-Gm-Message-State: AC+VfDy66x5LhcnDFctmSxIihuKhZKfW52aWqxgtPtWgwezVjXxJJ1s8
        1HyvPBZnRJUHRKhRvtq7QiA4CycYpQpG8+43DCTSYAnaerBmQWEZbOKTWg==
X-Google-Smtp-Source: ACHHUZ66FiA8xyxebfpqH1Qrde7H4jIWrD3BH5kC6/BYy+JjAxjAd0yItqgheFmJGhyMczqDz+DfrCQyD/3ICxiw6Yk=
X-Received: by 2002:a67:efd7:0:b0:443:62c2:7f4f with SMTP id
 s23-20020a67efd7000000b0044362c27f4fmr2989394vsp.32.1687934151245; Tue, 27
 Jun 2023 23:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180800.476539630@linuxfoundation.org>
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:05:24 +0530
Message-ID: <CA+G9fYs=AMHqGPMG2wa4wi8o6QmBqYEFABS8B-SDdf_7Ekzw3Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 26 Jun 2023 at 23:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.36-rc1.gz
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
* kernel: 6.1.36-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 8c805fb9757e69c239188ee683605520ff73b913
* git describe: v6.1.35-171-g8c805fb9757e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
5-171-g8c805fb9757e

## Test Regressions (compared to v6.1.35)

## Metric Regressions (compared to v6.1.35)

## Test Fixes (compared to v6.1.35)

## Metric Fixes (compared to v6.1.35)


## Test result summary
total: 166130, pass: 132599, fail: 3459, skip: 29913, xfail: 159

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
