Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59EC7E474D
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 18:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjKGRof (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKGRoe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 12:44:34 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65146121
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 09:44:32 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45dad6ece90so1458081137.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699379071; x=1699983871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW3+W1JkqemIl2KzUEEcBPa9+uOwoIHQC8p9y1KLnPU=;
        b=OzZ5GycYqangRFKEI0KIiV3ZGAlIC5jRITO4NWtrDOrTxZ/I+Zc6U8PjvUYzzd2vrm
         oxmnecCvsGTxUZrFGwYpjw46y6g36tkQK9ltPpSaTboEHNI2y1XYkjm0z7bHue0vePS3
         NceHwb7jTOIdzBUvQDwi/juPbyUMMg5DaMVCYUR3xsoKbDiKm2e/7eq8y7g2w3dTPS+J
         Ok9Qvc+Mp3MZ+j/LfbjUkZyZr7XjmMOkRW9QxS0lTrfL9Qwro6X6SUYvLAp+sk9XCDGq
         oNea3oRIZS1W4+Ul5DChh8F9c1uR3gpKxwjIqGFbxn6FE5Wcbh3c8IpMEQlhOdERxMID
         OmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379071; x=1699983871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW3+W1JkqemIl2KzUEEcBPa9+uOwoIHQC8p9y1KLnPU=;
        b=Kr5vwBm9JejR+xWKIOaq1V5JGLSfGSw87kF+nQuAEgqdrlOLPIRn8CcJxG0Bj1FtGe
         wox1Rprh2rermWfCxzlR0qRcUz0asbzOnuvtvwkEYqqy5CPhWKK4+T9DVVqQUptZ00If
         UDF4D1zKFJsCQMdf7/hsJhO5MfzHllz4AEXnCdmQZwrCm6szqShw/CZEda+/ocgfKoB+
         PjKbwIuQlL4jPz7435RbuI232FG1AmG+snJ/HVCUiEObOv4aha68vYMKAOGC3nysxxVA
         tB1CLiFAGCGBF977DFeRI4OESrV0e3etrgYq6wjnDm5hJLtjXdRSkQyShbLevFFeHgev
         bAtw==
X-Gm-Message-State: AOJu0YzqM2/7Ls7hSR+HFFVi5iRRxaOJE2uXW9aJv054LCfEpv5VQiT1
        6Pt+B9JKbR8Ey2PihZjKMzHRmzc5UI0B4sqG7gZBvQ==
X-Google-Smtp-Source: AGHT+IH5Nvyc0QYX9FMsRsyZZgmkaVjGPNhVriJFhSefM1O+XV/gnLRrXf0kNV1QcMZtN4cAmcC1V8dIUMExhg6+V2Y=
X-Received: by 2002:a67:e1d3:0:b0:45d:9a4d:dc1d with SMTP id
 p19-20020a67e1d3000000b0045d9a4ddc1dmr6989197vsl.8.1699379071442; Tue, 07 Nov
 2023 09:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20231106130301.807965064@linuxfoundation.org>
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 23:14:19 +0530
Message-ID: <CA+G9fYsogYh8S9F7hgjEJPmNN2pE7t0yU6Zz-A64S3UXu1DCzA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
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
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 6 Nov 2023 at 18:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.62-rc1.gz
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
* kernel: 6.1.62-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: f2e7db5bff4666814d68d4f2a8f1818be97f5e70
* git describe: v6.1.61-63-gf2e7db5bff46
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
1-63-gf2e7db5bff46

## Test Regressions (compared to v6.1.61)

## Metric Regressions (compared to v6.1.61)

## Test Fixes (compared to v6.1.61)

## Metric Fixes (compared to v6.1.61)


## Test result summary
total: 123810, pass: 105299, fail: 2422, skip: 15973, xfail: 116

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 147 passed, 0 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 38 total, 38 passed, 0 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 35 total, 35 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
