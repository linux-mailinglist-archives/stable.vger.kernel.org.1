Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144657EDFD7
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjKPL3R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjKPL3Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 06:29:16 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0E2C2
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 03:29:13 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba46683a88so267646241.2
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700134152; x=1700738952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgZuTWIqDoEfzrhfwR9hBMmPlIJ36L9Yx0IZnvedSxc=;
        b=UTKhl4BxKUT5zQnc1sBvxeEvFQklVbr+xM1J514I4eGCHPK0bU6boxgvJimFNaNKwb
         71wNgEqKfZj6IHf7cO3AwvsnkFypFm9QNRBB5q+QPRCxvK5M/YrBUjEvyNKX4goi3ahl
         CkCVV1SfpERT+Lcdz99bNA8IN6/2MNWTyzqe2dx5J1KN4w4+0l5E4Eg8mEoTAYukI5if
         MY8rQRLJe0/qm60/37m6AY2kGBejr3TfitV7GlEszj9muu11gV2ysqVovzPAVBYByArR
         1HdsixVuZ3bR6farx5lMYZR1+/igZHrEMXEWXRGgpEz/crx/6COizfE2JZdCFEuWbk2d
         0tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134152; x=1700738952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgZuTWIqDoEfzrhfwR9hBMmPlIJ36L9Yx0IZnvedSxc=;
        b=slc3xofNUAYPC/p9tbl23/3itXdlctH9Ai8yNyBJCpLArSX7FC4WMcFPdG65WdYzM3
         9PBfiDSUQEElo75jGN8rxy2uDilpR8N8qmvVhsC17ImoEvJPOes73s38Vqmv1hkkggrF
         RleUa0HepjBQrbUNPXTE9Hn5FZARcJodZOCBBomXTGcRL6LWRt8+W9jf+6iqRyFWJyZ/
         59Qxm+7wY6iyBgYUZFwzXrPhMy0Tauk3GN40YDTbqYGr+4fnGHQaGdCxR3y/QgO7CCjc
         ZmZVbRYsi3uQPk1CdUVC+jhP6D0UdGk2jgeahbIxqvVyyi5qyqukHLCLbs4j3+HS0v7Y
         8pvQ==
X-Gm-Message-State: AOJu0YwiEAADAfLj0BOS1TH0u2XVGKWbeohh+l1TwpSq8/4ILPCCytjX
        aOAOP3JBHpdTOobLKiC9VJGQkbHPTtWE89CJXso+Aw==
X-Google-Smtp-Source: AGHT+IE4HyODO+ul8EitVlUI58gYld954XEZGDB2U72usvZq2IozoC2uXX9VlZyvWcME2u/ldmebMpj77IM0fc3NpaE=
X-Received: by 2002:a05:6102:440c:b0:45d:91f6:2796 with SMTP id
 df12-20020a056102440c00b0045d91f62796mr20805030vsb.26.1700134152486; Thu, 16
 Nov 2023 03:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20231115191419.641552204@linuxfoundation.org>
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 16:59:00 +0530
Message-ID: <CA+G9fYsCscnmNLHQE8F3bZQvTjG0RUrpnecF-tRioHa+dkUv1w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/45] 4.14.330-rc1 review
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

On Thu, 16 Nov 2023 at 01:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.330 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.330-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.330-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: e54e4d8ac976c722369c6934276a14df398f7d2d
* git describe: v4.14.329-46-ge54e4d8ac976
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.329-46-ge54e4d8ac976

## Test Regressions (compared to v4.14.328)

## Metric Regressions (compared to v4.14.328)

## Test Fixes (compared to v4.14.328)

## Metric Fixes (compared to v4.14.328)

## Test result summary
total: 48478, pass: 41283, fail: 1157, skip: 5996, xfail: 42

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
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
* rcutorture
* timesync-off

--
Linaro LKFT
https://lkft.linaro.org
