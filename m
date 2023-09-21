Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B047AA1E3
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjIUVIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjIUVHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 17:07:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A956CCB7
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:10:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c268676a9so15697257b3.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319854; x=1695924654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUBffOBfeC4iGfE0wxrC0Btm8jAtr1Pc1HT4AAEfzTE=;
        b=k1R8TTaFYgCEb0p9jpKWOHzuvu547lvhNQCI8bz4zdXYz1YN1LwQnVuydJBL9iD25K
         F0kqqHIkxK/QzkYkNK4DzxNHGQsGO8rGceqz6kgV1hU/ptH+3ztFiD3thlu+iChy4oV9
         SRq7N0WYRgQK2EWO5DmIr/JrXVgBGlyuAZZ7oYFMdfQhlxQAOdYu2rtrQya9Zgv1EUwX
         5b+CgXwojAidnLZp4aHjkTsCOdc8dsvcMBZQ3rq8MhLP5fjgLbjIbgXnYOskTNfPTNoq
         lzYb85HVGHcplIel4oidZ6tV3jPVfRQeX4ZBa6zrKmrL9xE40mfkthdqq7l1RFmPEkT8
         zRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319854; x=1695924654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUBffOBfeC4iGfE0wxrC0Btm8jAtr1Pc1HT4AAEfzTE=;
        b=OrhtG4CNnxvoAzaDaIWwSta9jlti6FfWA4Ks8249u6iX54U3ryH8V9PF9j6hMRL2EM
         1M2cZP9yB8yV2xC41+DCaHogoQFEGJZ+NfPFIDEpPULDDHhLRO5qe1RU8M7B768vezyA
         Uz60Nj3rTvoTTWyIysSe0RENzbUqeXHCewt4+F48f5Forbtn3YPF7OdP1SqIXl8SR08+
         N14oihVIIt3CT6TDHlkBz0rXOASnLTV1RfTz2l5RlRIaJpiu2B5TOb+gZYEJSvG0Ni6m
         F7E7J2zIFG01uBwMV4n8sefBUsBvaGnhYCcceEjiKs5Zcu+41sagSTkUCIxVpdUeAveu
         1Yqg==
X-Gm-Message-State: AOJu0YzacIZ5X4nwfGSLRqd6B3zjXsLUYJSDLQWjFkksu0gs/XBHJklz
        yhvEL+MRAVlj/8w+VbDjU6jYbpZkGMYiOX7Jjpw6uCKe3I4iCDz+jfkJug==
X-Google-Smtp-Source: AGHT+IHvvzJ5FrOBVxuU7MJlhhXjUqpDEKLo7haizXBfU6s6ceBJbpHRnsjrEsB19ulthb+AD7V/9xxV7AFl676QuJM=
X-Received: by 2002:a1f:6243:0:b0:486:de54:b11 with SMTP id
 w64-20020a1f6243000000b00486de540b11mr4378052vkb.16.1695303136171; Thu, 21
 Sep 2023 06:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112826.634178162@linuxfoundation.org>
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Sep 2023 15:32:04 +0200
Message-ID: <CA+G9fYsCDqeonuM3Z-RHmbAyJ4w-UMwXYTevdKwHXEk2JhN7GQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
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

On Wed, 20 Sept 2023 at 14:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.196-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.196-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: f147286de8e534b063d97de0c66a4a5895bfc6ad
* git describe: v5.10.195-84-gf147286de8e5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.195-84-gf147286de8e5

## Test Regressions (compared to v5.10.195)

## Metric Regressions (compared to v5.10.195)

## Test Fixes (compared to v5.10.195)

## Metric Fixes (compared to v5.10.195)

## Test result summary
total: 89352, pass: 70107, fail: 2413, skip: 16770, xfail: 62

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 27 total, 26 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 26 total, 25 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 12 total, 12 passed, 0 failed
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
