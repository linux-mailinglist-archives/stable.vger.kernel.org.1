Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DB740AB7
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjF1IKz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjF1IFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:05:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B31B2D7D
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:04:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666683eb028so2978266b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687939469; x=1690531469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSn4tuQbZU5tpej8ySDKdoCTz3C/VKUeJEIDXrI8ApI=;
        b=hZo1J2W8cbHelkQCqrgjEa8u/Q1nTclZ2KybjHjINOdwzP5R6p/do+LRSiFO1HnUM8
         QxJNeh1yDSW3zMW4SxHtNkKx0mdXtgUidrCFv5d5jepI592zOMFPKZ733X+O/GnKFqWf
         92L30zeHYCze5HzoogWZTLTCQt7VEsWiCq7dUPJmSWiVqf5aQCGecLKwQwNpYOZQSY7U
         B4MT2QU2FciG6M9V5tQeJv8uPg4WJGUUC1Ktrsd8hR1CZV2NJemlgFUnrkgyxfaqsvXl
         3XulW0+BgWxGy9sHrGYbVddFdESujTKpwNiA63oQhPf0li9tgTS+XL54K06yczuph3Ie
         yzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939469; x=1690531469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSn4tuQbZU5tpej8ySDKdoCTz3C/VKUeJEIDXrI8ApI=;
        b=cXn456C3GLzVDeac+74ij1OxNjKOpcqQN0vD0SJPZbm0Ec1Lh4wTtBSgTn8MBC5P5t
         1H2V1TwF+J9dxtwYqirniu7w3FhZg82UVNOl4d3ldxryexisg+lfbK+im803hNCEHu4K
         JxJgEDNmhLrGz7kBz10TvyN/H1PHCOzWqUV6PKEVMKYso0PhDSiooejCVUJAm4Law8xo
         iIyicopvVtCsBBRS1iKG+UP7M0bkrFFMU951a0kG7uBlWcX54Hv4VCuuCcGXVy0XUNjg
         3SIWG/8zhtK5UP+5fVxqwN/1zAOHSikaaUzuHz1IVPRAuPII1pqCUWieBLbES10TvtFI
         D5Ig==
X-Gm-Message-State: AC+VfDx1XnkV6rP6hPkCQ7EbQMaZC6eY0DaE2HNbCjviklf3gRHAwroI
        oWisUjZvaZy2lk/x+LCBy7r/CMqFuYbFaTvwreuHcJ9AN3iZW9F4gZSucQ==
X-Google-Smtp-Source: ACHHUZ7t44iUD/uayELXJZDpQD9e5qu/zLWUfEGQ4HOTGsdJOeGEWwlqjUuEh6jUUU001f88X4GQWC028YZtissqo8E=
X-Received: by 2002:a67:f309:0:b0:443:6052:43a7 with SMTP id
 p9-20020a67f309000000b00443605243a7mr3835859vsf.32.1687935587369; Tue, 27 Jun
 2023 23:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180736.243379844@linuxfoundation.org>
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:29:23 +0530
Message-ID: <CA+G9fYvdQOWt6uq4CHViVfiOzP9dOcvES_0vRCgsSg-p1qkpCQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/41] 4.19.288-rc1 review
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

On Mon, 26 Jun 2023 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.288 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.288-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.288-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: d46c55c4b242c7dc4d40b4b2a0fb5dbac24ae5cd
* git describe: v4.19.287-42-gd46c55c4b242
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.287-42-gd46c55c4b242

## Test Regressions (compared to v4.19.287)

## Metric Regressions (compared to v4.19.287)

## Test Fixes (compared to v4.19.287)

## Metric Fixes (compared to v4.19.287)

## Test result summary
total: 65773, pass: 51942, fail: 1892, skip: 11895, xfail: 44

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 106 passed, 5 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
