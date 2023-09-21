Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FF7A9603
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIUQ6Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIUQ6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 12:58:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3FE43
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 09:57:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4121f006c30so6887811cf.2
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695315443; x=1695920243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9XA+JBraCda9eBva3Lypt3IJDPDw9JlxvkFOYuewBA=;
        b=DyWqQ6/TvltyNd480gZd/f8kczGw/wrC+5hzH1nH2lZVSn7En+TSY+W8zWbOa1gaJ/
         OmAsfJY6EKL1agsyn1+7WzEn7nvFRvwXj+0t5DDBensqVooPwsfxv/Zm43zXd03lIs4v
         Hev7SNLZg9KIv6LOtFxRzPw6QLd7qM4oZW7do1jDQPUnftc+nJ2D/D/I21+cfgL+OJ0B
         DD0+xzj6dPDWVy7m2upN3tOMUts6r/JpEWnAofPm876btFNY5qb1yy2ejdnNtnaESlwQ
         gd08RcnIiyvbp+mvH1jP+AP4CPyk+EwvQVdkCMI+dSa3eDdIc67z2I+pEzc/52yVD9zE
         9/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315443; x=1695920243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9XA+JBraCda9eBva3Lypt3IJDPDw9JlxvkFOYuewBA=;
        b=oAoSqU2yV46uYR7uhoYmYZF1YFFr5xuoHm2HLhwt9efiVJI/Ko0uNmXFQb3kSNyEP0
         HUle5FpKkHLycSNNQW2QJ/TfqWdTSCCdFtQEwwAMArfy9FD/ksdN9Fi7Dpqe8ne5Tbqc
         2NlhaEWaFmv7wFvl9LLx7Ay9OEPV4JRSFNpRsyzxv3yjKwOq35IXiYze5Gt0zIp3iZeq
         kcTBzDmoQeOWPOjdz/hm73Cq4hkeDaOOqJPlhIi7Utp7yW17x7AcfT8sPagMx1uN88qX
         VJmgMyLL1JWlD+9EHT/aGzuZnF0vvkuZICVil3zObtf0eKnK3etE1s6OILFZ7mzTEtpo
         Lg2Q==
X-Gm-Message-State: AOJu0YxYI6B+Kuw8PF9duGxTepeXYhhgj4rDkxUf/ubNjTznbBiC0XPn
        X3E4q2m37tUNf3p+Qw6YijkGzgA5njT40V/yvaoaIkhvVlxAT/VWI/Z8vA==
X-Google-Smtp-Source: AGHT+IFyUPOELrhW7Z+XSfDYSuhUZcYQy1NdI5INSJe1W1E+2AqewKf3Am8KYOt/k3/4unEl85dxvZZ1koniljIGRFg=
X-Received: by 2002:a1f:dd44:0:b0:495:3d9d:535c with SMTP id
 u65-20020a1fdd44000000b004953d9d535cmr5450821vkg.4.1695304533825; Thu, 21 Sep
 2023 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112830.377666128@linuxfoundation.org>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 15:55:22 +0200
Message-ID: <CA+G9fYuLmUQ=f2J7vdgDM54urA7muB3NpjrnZ=PTzwkGh48zRA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 20 Sept 2023 at 14:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.133-rc1.gz
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
* kernel: 5.15.133-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 634d2466eedd8795e5251256807f08190998f237
* git describe: v5.15.132-111-g634d2466eedd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.132-111-g634d2466eedd

## Test Regressions (compared to v5.15.132)

## Metric Regressions (compared to v5.15.132)

## Test Fixes (compared to v5.15.132)

## Metric Fixes (compared to v5.15.132)

## Test result summary
total: 94047, pass: 74238, fail: 2610, skip: 17099, xfail: 100

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 117 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 35 total, 34 passed, 1 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 27 total, 26 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
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
* kvm-unit-tests
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

--
Linaro LKFT
https://lkft.linaro.org
