Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA717A981C
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIURb0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjIURbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:31:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7ACA5F5
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:25:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb949so8059955e9.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317156; x=1695921956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlxydF8le7it9YpHGNLNEPIlTudRJihNNIHVUyHtnc0=;
        b=Vn1Or+69Rrv7m22ALMBNAMDnhzNFwmeRvKHfISBJGLwGLL8r973xrExm+W2GwgIWwn
         fFkEahw3H9RpQRn7mQM7nZucaiAYrXtceI39LCj+9PXTlD0g+8/KD1jgTE6Nwe+rlDot
         fXb2DHe21rC6oo2cjgDiL907YFjT3HcwnL1sh1EITWv8vFB6d7xPmc5B7FYC+rE92eji
         rEloj+3fk7QdzE+Vo8kdo6pTEkE5rNdLyMXpAEJImlP04hTW9JOClljSwFqXV8HmnRSo
         RCoAKevf3x3z2qc3mLvUxYYqKYmN4yNu+OV7dQQzuCJ7FlqlqjnnlXE7XIKSFGSqNWEq
         A27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317156; x=1695921956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlxydF8le7it9YpHGNLNEPIlTudRJihNNIHVUyHtnc0=;
        b=K8sjiHkMliT2YShCNwv6R+ULm+J32iQE/U2XSOwrAC8AnGqK4+QiugHLjRL3judtSx
         6aFNamxIdUecuHNTMUrzJBy5cBZpzQ+jHDXPOaqCY+3RgqKZ4yCy/3PrSaOpWw8FgMzs
         +K4/AI4+yS91vffQRulQgsb6BaAWKpdGo3BUVY4mT5XU1SKEypMaD0VblEo7uYSG025J
         gydEbYY5VtaYYZYjYn3oZM6HhzPV9dMOVp1cBp0edK2N4KpLRj6ntqpR7hcVo4VsVdV/
         Gb5liZpiPB+MKZCqBuA1b0xoHSMSiNW5axsFlbdzZ1x2bLXI0vewr5M37N1glcaRGrFM
         5QZw==
X-Gm-Message-State: AOJu0YwbKtalejxUNWw8qC1vFpRb4swsASHcAx6tgFprFX+RBqMIhdIM
        ygGTkjdcRXx0uqBR/hnTVKhLksBDQ+87fUgsUgv2lr97yJcYzG+ozm/OhA==
X-Google-Smtp-Source: AGHT+IGF2cvtTba86WdIfDIU3gmonfJVLY6SefqVJdddvwLJLTBmjRH9SaGtP+HeAhkkuKuCQYMl5QElQJBjGmSTwRw=
X-Received: by 2002:ac2:5e28:0:b0:503:b65:5d95 with SMTP id
 o8-20020ac25e28000000b005030b655d95mr4651461lfg.6.1695306687047; Thu, 21 Sep
 2023 07:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112845.859868994@linuxfoundation.org>
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 16:31:14 +0200
Message-ID: <CA+G9fYsSUZF3YZKkKQqSRJKmoVHoNgCkdB4WhwiwVz+a8uYh8A@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 20 Sept 2023 at 13:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.5.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.5.y
* git commit: 9e47a110b1b588900a2455918785c47d03dc01f0
* git describe: v6.5.4-212-g9e47a110b1b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.4=
-212-g9e47a110b1b5

## Test Regressions (compared to v6.5.4)

## Metric Regressions (compared to v6.5.4)

## Test Fixes (compared to v6.5.4)

## Metric Fixes (compared to v6.5.4)

## Test result summary
total: 127706, pass: 110002, fail: 1740, skip: 15783, xfail: 181

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 53 total, 51 passed, 2 failed
* i386: 41 total, 41 passed, 0 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 24 passed, 2 failed
* s390: 16 total, 13 passed, 3 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 43 passed, 3 failed

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
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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

--
Linaro LKFT
https://lkft.linaro.org
