Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD800740BDF
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjF1Ix2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjF1Ir1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:47:27 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36F3C38
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:39:34 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b038d7a5faso2783177fac.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687941574; x=1690533574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOL4fhmYp/J1U14FeZJzgC75kK+fB1QnqyhzqYSaFWE=;
        b=fRwgN9Mt9DmkEa5cjaHLPqYuOZn6m6+7UeMoEG85Aq4+OMcR7x2J1iLpXGJX1GHv6c
         1N0FBHN3pW8/n7knN5byKI96EnoTpMtg4yMfBc6FZVJfFO3heF+ZnwwK8htDSb3KiCCP
         +0WbL/+4DhhqN7INv+5rybVoS2LbIwLX1chaEDMfmj+6huWHEFQVSSbTu/mpR2qs8iG4
         XMYTixFkxpr9jugQKwPwp0lZ8v+eobCgJu6DAs59VRvrBEqMAWhhibcJOeGsHsUDb3N7
         11W7M0wurJpImUQLWP2x2tDoqO75F2iHUSji+fiSLoFxiO4AtTfXxvnU+KIw94e1IyBQ
         PPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941574; x=1690533574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOL4fhmYp/J1U14FeZJzgC75kK+fB1QnqyhzqYSaFWE=;
        b=lgJfxqQVGsDfgdQrLe1CJjgsMcUal1vju/nCIN4oMnGt0e24w7vlOntMRHEJbslp+e
         PGNltdwFm5sPEmJxD0XRCe+pEY0Fjf5md8RKKX4aKd1zvOQrJNOS559r9bbRqEiddAvV
         mxGynrITkt5vkIV2x8CJk1uSh+50sQyPjRHUmkqtIHvoqZlMVxHnTcu7suJuGTuIqht4
         S3Ho90s9JbFpsXlD/b8QyuzoDVP7Fm4HSG6163TjH7/yMA4EO5wQadMts6+rg/9WwArv
         TXRkXkirHml0a9pNCSoWhvgDExyhjUIiYr5pC8qrmY+9TU6Jz87YkYOvM3tgTTbdRlKv
         Ae8w==
X-Gm-Message-State: AC+VfDz0xqSJMj0jPBVE9J9fL3k5tp3UotJth7NRHc1se/Ajqes9Eetj
        hW9TbWMi0IZYffAIxS2IiRAHf/HOthCk1ui8hYBXgyvJ6PBi/0LUwyA=
X-Google-Smtp-Source: ACHHUZ7A4S4HR26N/0nle94mISPwYAJezxHfyXA6h00XeHK22z59tuMAimzyRG3vETFa6AaudIHR/709SL3eA5vGSzc=
X-Received: by 2002:a05:6102:3c4:b0:440:afd7:cfe with SMTP id
 n4-20020a05610203c400b00440afd70cfemr3062445vsq.31.1687934546023; Tue, 27 Jun
 2023 23:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180746.943455203@linuxfoundation.org>
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:12:07 +0530
Message-ID: <CA+G9fYvcu1z5PUZfUx3VXgwSWrGpnUxgy+gxuUZwPzejpkDRSg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
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

On Tue, 27 Jun 2023 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.119-rc1.gz
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

## Build
* kernel: 5.15.119-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 27883eb9b47ea94a1f340d622c1dbf8680cd90f3
* git describe: v5.15.118-97-g27883eb9b47e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.118-97-g27883eb9b47e

## Test Regressions (compared to v5.15.118)

## Metric Regressions (compared to v5.15.118)

## Test Fixes (compared to v5.15.118)

## Metric Fixes (compared to v5.15.118)

## Test result summary
total: 111617, pass: 86213, fail: 3043, skip: 22291, xfail: 70

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 45 total, 43 passed, 2 failed
* i386: 35 total, 32 passed, 3 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
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
