Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88960740B86
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjF1IcK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjF1I1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:27:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F935BF
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:20:03 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5707b429540so11046427b3.1
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687940402; x=1690532402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFn/Do9jN3RPupZVUJruVQkAXpC2rvNpM+OVzSO4M6Y=;
        b=j6kHicAee6GuMlkMgCi9yX7uNCGEKvmSNcjAP+AzAqUQVk/LksYC9gBFNAyZbmLRPK
         aWfJibZgL/bC6aD+FeVYu4Et5aefv4uhVPNFZYLCJcdhy6+YgCD65uMrxFacvnPN0kiA
         XvCeHTCisWYK/vn1DQaFOHg3Q6ykCHH8IxDKKI8m6BeoTT5fQmzsUiv66Q2H77WCRRsk
         nplXXGMkoQE9L1LEqw9Munk8oFFwg4hIaa5+MkylIMfCFbNiB/qIBjNi5Yz51WBePmoh
         tpr3VZmsVlFgtUv2ugyHSLZ+kt4LYtsFKXEOwZFLEH9R5e/h13Ap+ilxdcZKtUP1lIQx
         b2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940402; x=1690532402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFn/Do9jN3RPupZVUJruVQkAXpC2rvNpM+OVzSO4M6Y=;
        b=c93XwbLz9Wyo/kNOfJG/mz/yO16aMbYBsmSKSBew3FHaz5YjwxFoNyl4gtllFgDzMk
         t7qC+Bw/ykZr6dldbYDeJPodsDPZH+MApCKMPckXy+T+aXLprCcxGq6PF7ma/4U7HZk9
         aSAYVW4sNBU9WLygk2dgyE68YhZjdEexRgDe6l0PvhBDqWK00V/FGYhB15h3GCmxjvVx
         Ht/sKzPISM0ggf21yEVqI1IxHlUlAAv4ZUlgGIr90UEXszAwtqSNAnCYMdLtqY5k4CZf
         KXJY11T8dh56ZtAp3Z6TJuah/NaM6S3pBAmVG3LBEgLj32pM5E30EqOkUsDeN1yzAqtu
         WTvQ==
X-Gm-Message-State: ABy/qLZCsJCHEomtWfpjOJtfnRplA7rYCCEa6eUTaNXW8erbksFCi4pa
        kdYOQ5UTZ0i/iZMbygV6lt4agu3ren6nL9k42dmT0V2FfdwO75qaZceK6Q==
X-Google-Smtp-Source: ACHHUZ620+ut1eAZaT3bcrux1OZzch2BmXZiVR/JAa5o3q2SNMYljDhjnw86jyAORwrecq40xjDRJwSnfOiK5+6IE0I=
X-Received: by 2002:a67:f9c2:0:b0:443:681b:c8ca with SMTP id
 c2-20020a67f9c2000000b00443681bc8camr165293vsq.10.1687936638913; Wed, 28 Jun
 2023 00:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180733.699092073@linuxfoundation.org>
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:47:07 +0530
Message-ID: <CA+G9fYvkRm274Sdk-06dbQuKV-W-mx7K9KM9BER9i_+HH0x4ZA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/26] 4.14.320-rc1 review
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

On Mon, 26 Jun 2023 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.320-rc1.gz
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
* kernel: 4.14.320-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 11aa1c2697f51ec92ee0c9033b8bce9e13b71787
* git describe: v4.14.319-27-g11aa1c2697f5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.319-27-g11aa1c2697f5

## Test Regressions (compared to v4.14.314-117-g854d9237fbd3)

## Metric Regressions (compared to v4.14.314-117-g854d9237fbd3)

## Test Fixes (compared to v4.14.314-117-g854d9237fbd3)

## Metric Fixes (compared to v4.14.314-117-g854d9237fbd3)

## Test result summary
total: 61334, pass: 48370, fail: 2047, skip: 10872, xfail: 45

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 104 passed, 4 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
