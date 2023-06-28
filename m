Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD845740BDE
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjF1IxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjF1Iju (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:39:50 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FB19B0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:31:16 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7943105effbso518772241.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687941076; x=1690533076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUQY/KQMUAHY8497x7ti5aFzbngQAIZSi9WNQAjVh48=;
        b=ZK6rJQ7yPzWUUaz4XvHx9k6Q7LyrN3IxgEBAJImbABshxvMnMKRmrqXvDCD28LAdhy
         1FX8Fb87aO/uYsLG6WhFsVt+8rf4SklYC4HjAeXaRoocA41vNHEbNT6F0iv9wqTEgmYq
         36GzlPqvJ7844DEYyrJK9ygR3NDA7DLz27UqeqjeygHYM/44rQyim0t1eJkh/13uii7p
         3/ECXy4Tstx1P5bDQuGLrXGAacucw+qenhMGkrjGScRsIydwax/A3AbsxEetdMumep3L
         1wcDmpeDlCDYWXy1E/D9JXVFY/eyy9amTrSMfhORkip3xdOrO8EMaSj085nKICx6F9EB
         9WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941076; x=1690533076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUQY/KQMUAHY8497x7ti5aFzbngQAIZSi9WNQAjVh48=;
        b=hSDn/5dwqUGeZSQspfRcc/Q3Pb6Fu703XIbYMCnnSj10CTQIS3rbVYMx9eq+jbS/FR
         QVpPrDoztUlAHdyJXPIHcEo0L1zjXPr6+GpA8DM/WPyvU0LU++NeuJSdtC3UNW+qg31Y
         24UA7O1KWi0TKGoU3NILAP+h8n91taSibiBzIqo1Xzw2wSMtZQ1l/WgXxw/FXAwDPaFi
         Sw1V4qnlk8xWeX77IuMvSUcaJ8EsSbi7nSGQ3a0JU4f9a08f+MHROqDK+1dFl0nzUzgG
         VBZT506LYc1alB4IiNQ1ZrDov4Csb3pbp6wZU3QuRYe9HwHFuA1BG6mtvyFZ2cg+xMEf
         3k5A==
X-Gm-Message-State: AC+VfDxyjQipv3XpOP3GKusB92ypho/4YMMWUTj1GoUHWYxId6K8w1m4
        9jWcG4tmHYSsHIOmvy9jINs5+zdM6wUdaq9iHXxBfw+14msQVaUz8WXTdw==
X-Google-Smtp-Source: ACHHUZ7QdCQ8B2raBfrqmhG5hbwLg/21LM6OqtC13nev/uKtd/YHGsSa0Vrz5US+v+LkYfjUS5t0MFlOFiqgSIZt6VM=
X-Received: by 2002:a05:6102:ec8:b0:443:8053:f969 with SMTP id
 m8-20020a0561020ec800b004438053f969mr182680vst.17.1687934658947; Tue, 27 Jun
 2023 23:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180744.453069285@linuxfoundation.org>
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:14:00 +0530
Message-ID: <CA+G9fYttECVM514OrQLxYu0SVhUsiKp46TRu+fJWJ48fGdEA-w@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/81] 5.10.186-rc1 review
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

On Tue, 27 Jun 2023 at 00:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.186 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.186-rc1.gz
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
* kernel: 5.10.186-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: f7aacfe10a2532408aa014a3b046aa1efc426cd6
* git describe: v5.10.185-82-gf7aacfe10a25
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.185-82-gf7aacfe10a25

## Test Regressions (compared to v5.10.185)

## Metric Regressions (compared to v5.10.185)

## Test Fixes (compared to v5.10.185)

## Metric Fixes (compared to v5.10.185)

## Test result summary
total: 108478, pass: 84486, fail: 2704, skip: 21222, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 33 passed, 2 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 36 passed, 2 failed

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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
