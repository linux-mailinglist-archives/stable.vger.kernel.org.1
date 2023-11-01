Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8B7DE232
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjKAOAA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbjKAN77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 09:59:59 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDB10C
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 06:59:52 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so2239695e0c.1
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698847192; x=1699451992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgR3nF6EZLqp/H8kxFE33E+SA9d5i66IyhQCWYiF368=;
        b=EujWtprud9yMrJv4kqSj1vZmlpvwoYbY1djYnuPVjZtLWtTLjF8sxs78Xbn0KAJhas
         r71XTVdg+i8lIoT4RHV95dujb3GRJ4oBUYnsXrWP9aRSJCnJ4WSUNX2tC92VDIAz4Jkr
         BGKsUu0WlL46ZKpXAEbJqv09cYVPrxJOSgsllCwRtiCRDJSmjkvnDd6r0jJsESfuPMLz
         M/5n/JtcgUCJ6J00wG9eWcpmxZly6Nphq6Svos5gn/M7Zlmwt/Y+dEg/3ypMbXbzl+O8
         biCaPINUsT4RO2Xs7pWnoOmxu5rfobuP1eCDjyKYM/8EI9vEScxYk4mErxWl6whttRAi
         9t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847192; x=1699451992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgR3nF6EZLqp/H8kxFE33E+SA9d5i66IyhQCWYiF368=;
        b=ALZHPuK/BejfX9JPfB9f32LbnlH7T6pQVjQu/a6ubv1lHC2RiYjXyShsfeAWSqNk2Y
         JAsFd63NRlqzjwvKpFt4Y2A2uAEY3BqJmdOCJVG1V/KmCN6cv+C/c/yrugnLXfrtxpZF
         71T4Y6lTVgndXchVdHTxng6idec0uPtjwernKvfJKFUKbNj4JTjPeJc8T18D5VSok0d3
         bGzgohwKPdNsNpYcf9R4NCBx7dAR+/qRt7Bb+nvIlYSVFYhaGQ8F1hzM3V8rc9AlTH0L
         PGmZ3SNcDCL32cTG9qI6a+XIhvOWBxMJm18W+jC4jV3yAAcpcvWFHQxdqRpVL98jD0AG
         0Sww==
X-Gm-Message-State: AOJu0Yx8KQ9eIxnOL+lxN0H5Dn6xY1wU7URK8zkXJZKNY8AlO3Fp1lz6
        YjWWQy68XGhQaJulAQoB315vmEtl3ebPMWdIbFM1dg==
X-Google-Smtp-Source: AGHT+IHW8V1lpNIY3CAfyhi0XQek+S8lZMVyeE6Df+lCTa+Lo5LiXqssWb20eDJxfDl2hfODwffDXgN+IOHOhSHe2FM=
X-Received: by 2002:a67:c083:0:b0:457:c17a:d34 with SMTP id
 x3-20020a67c083000000b00457c17a0d34mr10681087vsi.2.1698847191929; Wed, 01 Nov
 2023 06:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231031165918.608547597@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 19:29:40 +0530
Message-ID: <CA+G9fYs7JCie4Vb2=A2oAVVDHyo6KMv1szqqPzSrE7NS4k3XQg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 31 Oct 2023 at 22:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.61-rc1.gz
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
* kernel: 6.1.61-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d87fdfa71a8c82a481a41421b387544c7012b21e
* git describe: v6.1.60-87-gd87fdfa71a8c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
0-87-gd87fdfa71a8c

## Test Regressions (compared to v6.1.60)

## Metric Regressions (compared to v6.1.60)

## Test Fixes (compared to v6.1.60)

## Metric Fixes (compared to v6.1.60)

## Test result summary
total: 123155, pass: 104208, fail: 2398, skip: 16422, xfail: 127

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 147 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 37 total, 37 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

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
* v4l2-complianciance

--
Linaro LKFT
https://lkft.linaro.org
