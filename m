Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB7788751
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbjHYM3U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 08:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbjHYM2s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 08:28:48 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A572738
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 05:28:20 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79dc53034a8so344674241.3
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692966477; x=1693571277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wha7J25vV0atq5JE9tAh+HzTmtKY/2fpth0d07VMnXE=;
        b=yYYS2vNF8cg1bKJ5Si6cRQ8iaxrwnNsMjW6pf7Poz9N5ZrUs45jR2i78KeoLXe5aqU
         LHnPyDxgDIyK2asadtosMycy9YeushYM46Q+I+cImmEMJ2+MDNrVWRYLvU/1I+KnYrKR
         4k6FqP3UR1lPlYw7KkzwaRHMIL6tyWdKirLwr5KVG5EKR76e/RXn6s8nx7vT6e+py+dk
         jjyi597hrBdYakMFCkTllFA2AkwMPEysOoIaw/8/xOO31aZM6Rg+VVjS3ilnan7lvnF9
         5BLD0S8R3pJxhcgduoSCh4DuvFfzUz1lBYQga9bRkxAQMTs7r/Keeo0UYsYkzawglq+3
         ITIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966477; x=1693571277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wha7J25vV0atq5JE9tAh+HzTmtKY/2fpth0d07VMnXE=;
        b=che5lS1kzx5F5CFRF6eLRVsS1LiVMUznQXjoheb1yGqp2ffLNvvKzeAwipx+WthBqO
         C97chk4eEXsD7J/IFhpPKxL8HctYvF1Aj5M/WdodwN6S3G4VJl16TKliGHNMukyg2sWH
         yyl9CYMDl5oKIZwu3dGoySKq8W1lfbvRZW0NjGGaLPA16rYvOw2KMizdNdvKzp4I6/Tz
         VJE2vO+9XepUEvoCTNMKzO6nranpYSprE79OCO6TpZzE85fI/Ebcvu7OoUOYWdeXZ+Uo
         Gajv0R0coevexCayWQFKVPPdkFcwnY7FZSrkHg/nEmurs1D+AkxDF8o7ksol1ga7PjDu
         jjzg==
X-Gm-Message-State: AOJu0Yz4F9uBKRWQztZlyo/yoWtjQjXrWoYpux74PRaYVkA0VQZRB15H
        YijOFiMrQiXEF9luNcsB9hcr8ayb47SdxL0ftKTdHA==
X-Google-Smtp-Source: AGHT+IHJq0/tUP94HY6tolgTlx8cOe6DV+WHLKzjr13Qf05hotbt029g77/P601mRBhfhZXvORDwYW5TukRn8mbq+x0=
X-Received: by 2002:a05:6102:1341:b0:44d:6246:658b with SMTP id
 j1-20020a056102134100b0044d6246658bmr8237349vsl.4.1692966476666; Fri, 25 Aug
 2023 05:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230824145023.559380953@linuxfoundation.org>
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 17:57:45 +0530
Message-ID: <CA+G9fYsUUhvRre2EJUSisMF_QzyunRdwbeYMoYpHieeTRgAvEg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 24 Aug 2023 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.128-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
1)
LTP syscalls chown02 and fchown02 test failures on NFS mounted filesytem
on arm64 Rpi4 will be investigated further.

## Build
* kernel: 5.15.128-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 00e5f0b76767cab779762a1d27fc17c1cf2a3606
* git describe: v5.15.127-140-g00e5f0b76767
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.127-140-g00e5f0b76767

## Test Regressions (compared to v5.15.127)

## Metric Regressions (compared to v5.15.127)

## Test Fixes (compared to v5.15.127)

## Metric Fixes (compared to v5.15.127)

## Test result summary
total: 122966, pass: 99727, fail: 2827, skip: 20301, xfail: 111

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 115 total, 114 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 37 passed, 1 failed

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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
