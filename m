Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C97EE68C
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjKPSRF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 13:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjKPSRE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 13:17:04 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F00195
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 10:17:00 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2f28caab9so703215b6e.1
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700158619; x=1700763419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDj+XBdAjS8rpp3nLic5C7ebUl0lQXibSRxWXdmfnSs=;
        b=aMvWJBd1MaqwOuHpS24lPkBogNxQzfoDMlsyBq6V34nHJL1tfiY8fTOU6gXDrxcY2i
         OjueWPsywovpNlOq7Rpp8r1M2vR6nfv5r//r4NK0OUofCH6C4VRyArWk7KuB7wgKUxot
         LmQzFtjPBosUDF8x9OojSraHP6qXINHSIw/N85jWKh0voaNMf/kBDt8sVRdo9tHdXOwh
         +6qF8ynqEwXa3b/4LIehswHDr87JNAPHoFZxNW9+QeyiSF8fc3i9KGDqwTgQODSl0/dm
         sJDq5bs9KGzX49WcOSNKUKUmoXCwqAMwJEtP0k9+3hN+MqTuPVrmlMWNPD23wMGGSp5q
         a3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158619; x=1700763419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDj+XBdAjS8rpp3nLic5C7ebUl0lQXibSRxWXdmfnSs=;
        b=gNI2RaVDI3R7kiUZVZ/aRh7ckAN0MQfgCeluf55SemhwpDNrbBA6uGcDTnsWS1Hrgt
         KzI1W8A44quJMZaGfrgbpVUYvfp1Kcmr/8IRGz+Gn4tB8IKEDc8uFJJFYQqKS4uqf6ck
         zZQLPfmQbO7CUI3eSRxOA3K8GlFGpZv/UmNI+tGvt9uhs6nd0uOCAT3dvx+VsqVdvPx8
         nHSHPnqunivetDo3bD8oY0kz7s2vSv6UnWsF02S8jsCQTa9kVF+zTC9bztrjFSOltRnf
         h4t3tcMlhD61URueSBD2fDZQ/bpZQRm6D4tKLLRvkgJXahHtJhH063rUrtkhmiT7wbE+
         uzWw==
X-Gm-Message-State: AOJu0YxAr2d4OeC7AwhUNSnbreGY/tgEqaXCpdxnjPFqFXly2hv+8ZGy
        PYHoKeoL9iVvVV4mYzts6+MwqocDcaWR5RT9bejN8g==
X-Google-Smtp-Source: AGHT+IFcnz1Plnm5GNybizW6I/9yZWOt/Gb/hNP9j/tUVyvus2SvjhwhUyg6qvQKcY9sCy2VUd24BpNcbGXLMPavw0M=
X-Received: by 2002:a05:6358:e4a9:b0:16b:b4c5:b200 with SMTP id
 by41-20020a056358e4a900b0016bb4c5b200mr11503001rwb.19.1700158619486; Thu, 16
 Nov 2023 10:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20231115220132.607437515@linuxfoundation.org>
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 23:46:47 +0530
Message-ID: <CA+G9fYtXJJbQqzj8et66YSGsabELLMbodVkfyV93G2BcmfxW-A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/119] 5.4.261-rc1 review
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 16 Nov 2023 at 03:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.261 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 22:01:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.261-rc1.gz
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

## Build
* kernel: 5.4.261-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 4e271d1d9d68c0508c93f7b906cb2daf293b4d70
* git describe: v5.4.260-120-g4e271d1d9d68
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
60-120-g4e271d1d9d68

## Test Regressions (compared to v5.4.260)

## Metric Regressions (compared to v5.4.260)

## Test Fixes (compared to v5.4.260)

## Metric Fixes (compared to v5.4.260)

## Test result summary
total: 89529, pass: 69705, fail: 2000, skip: 17774, xfail: 50

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 28 total, 22 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 26 passed, 4 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* ltp-crypto
* ltp-cve
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
