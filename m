Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE47AA12D
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjIUU6z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIUU6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:58:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151AAFC05
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:07:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bc3f8326so1146313b3a.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319663; x=1695924463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Hj2ZbHk7wD50zNluyjwn885x6blD4upSIobGwpX/8c=;
        b=zddMOxXN5XT+klCCTIi5BeyOckkwGTgU6swG4mfqrSbZ3s8S+AXs3uNsrIZ/PIvAbz
         PNnC3kJmiyO2BiQj+EQJD3LwirgcOHiOz/jRZn79mrssztnGb8RcXmFs7D7OpB5IS0Nt
         66hS0vubWgvQz1VdMRF4aUktoRrA/36OKOXjlJYgnvo3RDWxm2t3qBZYWAN1ulJo95hW
         gF77PrPQ9mt6/up4xA0W4OHNnsuI443dRAMsOI0AVITbKX5k1D1yY8SrqNGCvFThKx13
         GeJUe4aNcYvmh3W9IHmQLTFQg77fzQhX83rifnvnkHBhF/NO7AxzDEKS0+Ou8j5Ct6xy
         q+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319663; x=1695924463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Hj2ZbHk7wD50zNluyjwn885x6blD4upSIobGwpX/8c=;
        b=XuErc+G/0Kk5YPsfVI5FgHGedsWqvjU/m/6A+lkz+NzwJA2+C05Looj3lR1LKbCkdV
         DMF7M6dg1t00vwiTqolgS+gL+zxKXTgPEq4IfiosgKMHscjr1eRnMQj4qWkWWRjfHsiL
         h2xNinp7Xq7Py+12q+/DAO50Hb6De4tnJu7utV6YLrSKA02Dlhjr/eDAIRutDywDlECq
         UzZtc7izJa8wAPpwuvuwFdMPsUrAxIQUTTsheUVaRZL3sjF+ra+z3QbhH+29DR8NTjlH
         PJpKpJvTk9pUmOvR4FzV2cwpaqS85fadaSMtAm0M+zgpBGvjDbQvGJMeOAHprshX+h52
         /rhg==
X-Gm-Message-State: AOJu0YxVSJK8bTODiNZJLdQ9G8BTt87b6Ti2PEGKtMiVkR2OnPQhW6zS
        fnZX4eltKd2uBjOEy8Ljnv6uA+pZUhrw4OgAdx0hnxErRw5ww99TjqMD/Q==
X-Google-Smtp-Source: AGHT+IEsnQ4F2rramLNiHmi2v+BX80aZfHjTbk4kweC9NP3w5GMjoWSjNXzGB0kbkdULrF6gpsuuRZ6/t6J+Wg7NkpU=
X-Received: by 2002:a67:e205:0:b0:452:86e7:5b3d with SMTP id
 g5-20020a67e205000000b0045286e75b3dmr5918515vsa.26.1695300432292; Thu, 21 Sep
 2023 05:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112836.799946261@linuxfoundation.org>
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 14:47:00 +0200
Message-ID: <CA+G9fYvOHuu+7Ozt0eLFy1A50j5KHoacp69HGvbHezTVeDNSCw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/186] 4.14.326-rc1 review
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
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 20 Sept 2023 at 14:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.326 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.326-rc1.gz
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

NOTE:
The latest version of selftests ftrace test fails here on 4.14.326-rc1.
This is not a kernel regression.

## Build
* kernel: 4.14.326-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: db587d473a47d83c9329f769e7df2c07df6b77a5
* git describe: v4.14.325-187-gdb587d473a47
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.325-187-gdb587d473a47

## Test Regressions (compared to v4.14.325)

## Metric Regressions (compared to v4.14.325)

## Test Fixes (compared to v4.14.325)

## Metric Fixes (compared to v4.14.325)

## Test result summary
total: 51393, pass: 43787, fail: 1208, skip: 6354, xfail: 44

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 107 total, 102 passed, 5 failed
* arm64: 33 total, 29 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
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

--
Linaro LKFT
https://lkft.linaro.org
