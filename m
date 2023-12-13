Return-Path: <stable+bounces-6567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27756810A45
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 07:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE3281F05
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88324FBE8;
	Wed, 13 Dec 2023 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddxCIuoV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97BAD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:28:32 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-464808da25eso1738007137.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448911; x=1703053711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akz1Puzltw2De0oW27Kz6mV3Wu/LD2csUZa1D/sOJBk=;
        b=ddxCIuoV8mb2SzXggV1FEe4/vGK9tSPTWUtwyQqMtQxFKQ/vpcaBJkKfsCIFNcIra9
         kt98GfzBGuidze6sMEFSzndDUl+52eAf5kB+FelosxSmfD3l6jI1KPz+zfNAydkYO5ye
         y8EHjO9A0Tnk9JxZ6cUifQh4fBTV6iJig6lvgPGjS7mLh9ZH0JddvVrpLIuQu+CDZpho
         cZQim1tUQAM8wqqXoEi1Z4lFk3lh3diHwy5fCge5d+E1C2NN9pOPWppAry6wPy5IgoHm
         ns45AoxrZNFMSYMpJ5kK6KzDyVCQnferEG8GbjOCStUgsk7Woi1I9AGlnJU9huPA1Ifw
         dD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448911; x=1703053711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akz1Puzltw2De0oW27Kz6mV3Wu/LD2csUZa1D/sOJBk=;
        b=VneEHV94QzIA072XeJipY/Fr7F3Dm+u6bj1GmS99P0BjCfkma708FRtbcJyM++iUGx
         IuPy6gOo86AMam0nokgM4Iz295y8tihbTanfvOH1NYlx4u1+hf9Qp1+6WrpqWVCf6RFz
         CkKPW9WfeL7YGheGTNWQwIHdhdbQEQcLQ5dp5sUbmq+lbmk3rLH1y2djSytlBX2LhkYN
         k5BRn50M76/ddhD8/1e9T5vE+qAUxnpv7oviddF6AKOdKk4oQZ5Np1vmm3Yq/bqZFrpi
         rrc5We6J8inoXCo2S2y6+PWpn34U0t1nUyacK2KZrCJhngPHTkYxEW6zh6QkFon2icCR
         FkqA==
X-Gm-Message-State: AOJu0Yz5GmjzTi5uOpBEEMGI7NRtqshVlQ1hCZhaM7J2xC5h5aNpY+im
	LKdFERyDR0iplRbuVm+Irw6/5mgo2ZieDVk9HiHvPw==
X-Google-Smtp-Source: AGHT+IGQhg5JrLKCGBiXPF+aLsnGoxhgTZaQSJZ3CN3n6MyG75kVqb46vu3aGD3k4nEopq8fpUlLvD65tSfKaR4RA0I=
X-Received: by 2002:a05:6102:6ca:b0:464:8a32:d4d7 with SMTP id
 m10-20020a05610206ca00b004648a32d4d7mr5647631vsg.6.1702448911530; Tue, 12 Dec
 2023 22:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212120146.831816822@linuxfoundation.org>
In-Reply-To: <20231212120146.831816822@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Dec 2023 11:58:20 +0530
Message-ID: <CA+G9fYugjz90_tSMj3qBRC1R0vygybc-mV3tvcQ1TmcaNxkqsQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/24] 4.14.333-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.333-rc2.gz
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
* kernel: 4.14.333-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 68f9b81cad708b197a2f7aa4e293c2669590d2ad
* git describe: v4.14.332-25-g68f9b81cad70
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.332-25-g68f9b81cad70

## Test Regressions (compared to v4.14.332)

## Metric Regressions (compared to v4.14.332)

## Test Fixes (compared to v4.14.332)

## Metric Fixes (compared to v4.14.332)

## Test result summary
total: 54698, pass: 45675, fail: 1625, skip: 7353, xfail: 45

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

