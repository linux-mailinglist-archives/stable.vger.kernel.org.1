Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26767AA319
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjIUVrI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 17:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjIUVq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 17:46:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91815914E
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:19:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso2104124e87.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316798; x=1695921598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXIaP8BOkwo89NYE3t62Gfh3GmNRPPwDXFgTYeMiN5o=;
        b=DP2AKqCrPH5iunu1ASz2GYDX41lInfcj8Ptix5rKOHusj3707/hBBE84xTsdm/8pVE
         IKoG27ZcwlwC1FQcGDE1/Yo6x6LTa1uZ+WMuyiSAMfaBdCLUnhFKe/7cFzT4cZlaT36H
         XjgADyS9MOSAMjHCXvLWBjJXHTc1IX9c7OQ7RDVN8HMiy0TautWJNAzUTkHLCZ9rwo7B
         dIkjm0/guOlSH9dOyaUrBfeqQHOz+M9d6NcVAqO1gfhEFJKQOuA9wNMBEuG6OUuaIUDS
         MKD5LScHmeLCkolhfpFfcFt5aREuEAu+NFUjEwbQcqJAHeKc1OOvoZYRwIXBAvS32sb7
         goGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316798; x=1695921598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXIaP8BOkwo89NYE3t62Gfh3GmNRPPwDXFgTYeMiN5o=;
        b=cg4LBOwBg9De3MM+dhmVfl63Guu61NxXDDrhOI4eHlJeyGsnpHk0E3XyaQAX5iU461
         woIQesgBcX8a0MNf/kVF1n4Jl940ihxs+aF+btOZXMZ1yQqJWd0SwGXyAHHsVwB0lupq
         V+7t9A+wp/6DybO0g1flXOrMnkkN5fesL2iDBHyF1xhLRvA0akOBWVbMnCvVgBAKRuko
         Q38L8+ZtPf4rcnBVk65/rSacNsEpaf60SRNq48RGFx+ITN19i/rZUlJUJ+KHcayVw7KQ
         nDrzzvwyznJ63x3wD3xU9PoaqbOUDC5+aFNHxTSBPFyfPK/5QsD5N4g8DPxExzKZyEGz
         f71g==
X-Gm-Message-State: AOJu0Yx4xJTD0oYo4T1ZyosJKY6wwZzK7mfSFx6Dulqw+i68u+R0DKjD
        QMjWwAfQtIxPq2XMrv2eI3RVjIhgqMpij1/CYXcuao0fsO0P+UVZJEY=
X-Google-Smtp-Source: AGHT+IHWobePNUrTx6EcRCo0kgkXgAZa+6nkgOWCQu1a5F4L1r8xZk7puoI9QlAovdPF0CEBcfNHr1YBIZqYwwbvRZU=
X-Received: by 2002:a05:6402:2d7:b0:523:1ce9:1f41 with SMTP id
 b23-20020a05640202d700b005231ce91f41mr5177223edx.18.1695306834871; Thu, 21
 Sep 2023 07:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112858.471730572@linuxfoundation.org>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 16:33:42 +0200
Message-ID: <CA+G9fYs3CufRDNWZ+au0KS376+4V432mQubpnbMENbAVQ6tTFA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 20 Sept 2023 at 14:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.257-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Build warnings noticed on arm64 with allmodconfig as reported.

## Build
* kernel: 5.4.257-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 831ef442fc4c4000caab32d35d6a4c5fe9d41706
* git describe: v5.4.256-368-g831ef442fc4c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
56-368-g831ef442fc4c

## Test Regressions (compared to v5.4.256)

## Metric Regressions (compared to v5.4.256)

## Test Fixes (compared to v5.4.256)


## Metric Fixes (compared to v5.4.256)

## Test result summary
total: 87749, pass: 69286, fail: 2073, skip: 16347, xfail: 43

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 147 passed, 1 failed
* arm64: 46 total, 43 passed, 3 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 33 total, 32 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
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
