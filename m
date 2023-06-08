Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA586727E82
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjFHLJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjFHLJR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 07:09:17 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240544B5
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 04:07:39 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-783f88ce557so173223241.3
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686222449; x=1688814449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT79DiTiFwcBzPo8la5kITvMljqoxHk4MZnGjZJny0U=;
        b=QHkXmTOE7unXIJUKUhRi0JsDMooraLzjqTBjmfpmynhu6pFSPAA1MTXcy/suoFphid
         ZI9KBfZO9Jn4gxpHnfsKE72Rmei0M9A47D/n2Ty4JaKlpwSlwp4kxVFicWPCK7+yFx8c
         /c0kYbPuyrh1ZoBWXn2jM2mLvYgXlg7ISFTSMode52oTNs2mvMSaBs+Wfgk8cOJxyCfY
         vi6lVqWpgQ+dEtxEQjYI1fpAEx3PbnHscFljjs0lHDc3zGae/NL+gBctrHPO1XnkbUOe
         mOTR6u8oD5ROHRMUISJG9jjGD9DOTo4MK+0WkkzScpZTnx/59c2eCLtcT8Vhf6vntZad
         b+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686222449; x=1688814449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT79DiTiFwcBzPo8la5kITvMljqoxHk4MZnGjZJny0U=;
        b=TrRRZi+QGx9L13OHjJogt2yON86o/h5Qgdcks05Iu7gzoXD9C9nIJTmDmVCOEYCbpu
         yAKKb04drSoOfPUClJo7F+KTHqt23efr4GD3K2vONi+tPXRNLQ959LXkfVVZCByOFouK
         Psy/hkTx2hMJPdy7q79Dy3U1yiKPK0+BFwQBzg21Xe9dCSadVYWbJMvVZzbXzUrf+9l4
         uquQTg4+wbshW8TREE1PA3Xjp82Toaw7wmwswogA4Cj8PAa5Krv5oO9Z+SvhCbV8Rsh/
         a+E97WAgXqttOHndo9NKq7oodoFwFSDvlnTdgOUJL4BxrNd7mpwONUdZeI6jlJlITOGc
         zPmQ==
X-Gm-Message-State: AC+VfDxfQK6FI/NU1qz8jmhmV9zpAb9UHkhm7973i4KsxRMxsNOFKfy3
        K8+G3eWCenQ+5KhadW+S2Mx2AQ3rnu2rt96Am7cXWw==
X-Google-Smtp-Source: ACHHUZ6lnuhTM/MDg8XJON5BeL7R5yqKhWqXoJ16LkyTJFgCSVD+wh45Yvt5D/i41vorKUtaN88vBfjlxvGk+RgRAnU=
X-Received: by 2002:a67:f852:0:b0:436:4da:8d63 with SMTP id
 b18-20020a67f852000000b0043604da8d63mr1784432vsp.27.1686222449260; Thu, 08
 Jun 2023 04:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200913.334991024@linuxfoundation.org>
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 16:37:16 +0530
Message-ID: <CA+G9fYsJEG=mZu1rmDpuZ9qmP2AsuZ67URLUWQGRz4w3gR1WpQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 8 Jun 2023 at 02:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.33-rc1.gz
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
* kernel: 6.1.33-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.1.y
* git commit: 8f4f686e321cfb99dd17774b45f93d96a16c2073
* git describe: v6.1.31-266-g8f4f686e321c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
1-266-g8f4f686e321c

## Test Regressions (compared to v6.1.31)

## Metric Regressions (compared to v6.1.31)

## Test Fixes (compared to v6.1.31)

## Metric Fixes (compared to v6.1.31)

## Test result summary
total: 111194, pass: 97858, fail: 1305, skip: 11824, xfail: 207

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 142 total, 141 passed, 1 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 25 total, 25 passed, 0 failed
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
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
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
* kselftest-kcmp
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
