Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0C740B26
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjF1IWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjF1IMw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:12:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A7421F
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:09:19 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4021451a4a4so16005281cf.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687939758; x=1690531758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKt46WH3haNdn68oDulwJLfg6Dbw6icGdyGT3p+VLw0=;
        b=vHjdwrm0+Yd7Dc8058YsSvMhEJ8/MtjSaLsPbwEWF2Zf6x938m1WHHRonxe5BhfzEs
         931KmoNK404Qf6RnAlmP5Y0BG07nVfUjc4BCfX6KvP2eM6gISiB1WaxZwE0oMa+r8NT2
         aX67UsOo5WyCmC+V/T+GPvd6WB9okVgCl2GnrGCBGqKXLY2BAn6nNVXf9c7czXiLYGBs
         fQLjroUGZPQE2ThLRZaqUvQnsSF+KGMs0tYk0ca9LNTnlZyuiMNyU4vqgLbM4kCkQSn/
         C6T3dhG6ol0VNJrK3+Nc22A5lQj/3dq6XWjm2nvHeLe+SG7dBFOhR7O/sLC/e7d+oZH4
         95ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939758; x=1690531758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKt46WH3haNdn68oDulwJLfg6Dbw6icGdyGT3p+VLw0=;
        b=M+ClyA6C6Hwo9SWMeuN/zj2bOLmhmu4tC98R4OXIUQmcy13ijzs6TFtHYqHpfVqCrG
         vdEJLwMOJokqBX2uXgymviD8ynGXAsligSt5U5qiB/B7JEk5zovVkVP9Ocu/Z65SoM4E
         bhnwo1NVFkKtULcPDeZtITKVEDoSVC5DcYidOfiTBEnK36oGn5X+9QSrgoAQXDTYCnV1
         C9sbytD6OfnrJ3Y6wgTE6Jhc6NvP657p48fyXS7hZXpq6eS6ty44THvQtVestk4vNhse
         d6EyEYvJXqkBvZb8cv7f9jPbENHJ33XiStr5ygtXbc7FnPWPRldiBRAWpzUN8WeVPuRC
         haYQ==
X-Gm-Message-State: AC+VfDy8IYcN4CTC7uMugzwpIPTGUiTRQfxwyXhAcwdtP9LFp8havCpJ
        UyJfzTe3EZb+rxxDJl18s4nCWtNAXHqFqY456rJXyqkXX6TONjsJRA89/w==
X-Google-Smtp-Source: ACHHUZ4UnxeddFx5DIcm9mVNTPRPajWiHva1L+q9Tk7Ikj+GOB9OfZEnDxVa3jmGUyFeD1tDajfgyDTVAO8JaJDmf9Y=
X-Received: by 2002:a67:f615:0:b0:443:66b9:b8e9 with SMTP id
 k21-20020a67f615000000b0044366b9b8e9mr4364431vso.20.1687935850952; Wed, 28
 Jun 2023 00:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180739.558575012@linuxfoundation.org>
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:33:36 +0530
Message-ID: <CA+G9fYu6KHvkpd86q2aVjWF4gXbpBw2mgc-Tmu=4hG4eQ11z1w@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/60] 5.4.249-rc1 review
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

On Tue, 27 Jun 2023 at 00:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.249-rc1.gz
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
* kernel: 5.4.249-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 824b023c3cda00fe610c1f79d14a6223d68f425f
* git describe: v5.4.248-61-g824b023c3cda
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
48-61-g824b023c3cda

## Test Regressions (compared to v5.4.248)

## Metric Regressions (compared to v5.4.248)

## Test Fixes (compared to v5.4.248)

## Metric Fixes (compared to v5.4.248)

## Test result summary
total: 115217, pass: 90332, fail: 2137, skip: 22692, xfail: 56

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 129 passed, 19 failed
* arm64: 48 total, 44 passed, 4 failed
* i386: 30 total, 22 passed, 8 failed
* mips: 30 total, 29 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 33 total, 32 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 39 passed, 2 failed

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
