Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DB740B6B
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjF1I14 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjF1IZx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:25:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EE4210
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:15:42 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-345b347196cso9507975ab.3
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687940142; x=1690532142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iichXkU9g/XJfOh2ks749ZybEdtHWrMk0Xz57/tgOJI=;
        b=NhdEyo0dqS2HVYvqVjvwqiuFKgIay+dhFcb/DeszSxUkCooJwXiUAuimmwLoz/GDDp
         9FDMYGkpkmjF7ISOG0R148qwWoPSoBZeteVqa3O/wPiEgmmguaQa3hy6tlUhpJlRQ+9C
         AiYNPKv4+QzWXZ1lQl/U0HcGewBQfKdTVSOrAdQTT9VNRza2ujp/bpD/CWrLQYjYXWcL
         TOGYm5RNkSLGS8pKm71lGQmAdrt785gpwxYh5FEHetGRGoAPqWr7//nY45tYi3aW1o9B
         srhHnqUlDKeaYxW/iMwAQYMeikkhdYciAmEZ2ghh6f9fXVb2AvTjowL1mpmHRcd4NL9q
         xZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940142; x=1690532142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iichXkU9g/XJfOh2ks749ZybEdtHWrMk0Xz57/tgOJI=;
        b=IpOts/3wMq4WxbE541zAsDZdILt5pE9RCjHPqCuRJby9rSb2+gE2oWszyyo4Zi1Sqt
         iiiBpahvu75R1+Z+x5RIW1A597ySzORIPL4nNe9xX4mrm3+gbcqIvb4rbVxBD2YblIPh
         rWALB7Z4Sd2P9O1E5EJKpcCtPjBK56lJFw4W+48YTDu2lBAi6b9t6I0og4RR65kXTlfg
         /MGusBeetT/LyYXclA9JABCRMtMbGcWCFNZq7sJLJKz7ljE2WHz3AXesWZmTdc3WR5Zt
         /OpE36kb1FGD9D79XAni0exzMr/etwoX6CMlYvuAOEeEXRVSjLsRENu3k15FV3U4JFHr
         8HAQ==
X-Gm-Message-State: AC+VfDw8gGM8vxI61PrNqeRX4aWj5nhSlvTcTjmbLR5HusnAUXZ9Iyum
        B6XygD1Nf8Yo98D7N8xFTbrTaDjfXrGGWUqKyG09KMIAHRtl4QLqtv/aGA==
X-Google-Smtp-Source: ACHHUZ6VnukVAQ1/fGZwHC1ltTN/zizq/VmIBMXyFnWMtOY7uaE4kWodZOKrq9+bM1xgMwFudSyfTycFvR+JLaWDdEU=
X-Received: by 2002:a05:6102:3641:b0:443:64c0:ef3e with SMTP id
 s1-20020a056102364100b0044364c0ef3emr4399976vsu.21.1687934274621; Tue, 27 Jun
 2023 23:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180805.643662628@linuxfoundation.org>
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:07:17 +0530
Message-ID: <CA+G9fYv=4j1e1-7kak3_dpkLAcRf1FHXK4j3tCNjPEsUks14kQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 26 Jun 2023 at 23:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.3.10-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: 3d49488718bf7f62bf7e49db5f677e4ad0d5a900
* git describe: v6.3.9-200-g3d49488718bf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.9=
-200-g3d49488718bf

## Test Regressions (compared to v6.3.9)

## Metric Regressions (compared to v6.3.9)

## Test Fixes (compared to v6.3.9)

## Metric Fixes (compared to v6.3.9)

## Test result summary
total: 189021, pass: 155522, fail: 3063, skip: 30272, xfail: 164

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
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
* kselftest-mincore
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
