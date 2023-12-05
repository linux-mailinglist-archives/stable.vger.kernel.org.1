Return-Path: <stable+bounces-4682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B831F8056AF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CED52811B4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388DE5FF19;
	Tue,  5 Dec 2023 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmvt/7yp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF7183
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 06:01:50 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58e1ddc68b2so2474571eaf.2
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701784909; x=1702389709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2QEf/lBr77RbAJvG5vi7959AaVxlYnauTCXxwH58FY=;
        b=Rmvt/7yphhKVxPhwRPDRJwUD/4ZdWq7lOb9/mHz4FJaSqfyeNrsW8G0BHd7jNloSWH
         4kkFlDrH72ZRHyztdhXXLNkXZX7EFjtfu61MJCDxS5v6AcIszcHHK6xLVpZsFdQmyFF6
         cgoANfY8s4PAY9ShSyZOybd1NSMfgFLxjuVdk6O0bjtdmdFOEtmuUleqr0iKm1wXpHc0
         IDzuV1QFykkkIpy5UtSnhav8rlFXZsb7sbbUD+wTdHcNJmZRZ7/oKckYJ54eV5ojtVEk
         Ol032b+SsjtD3nXNSIOFV6/ULz+GWxrDrU5g/OOLsaPIIbs2vsXMPnHSm98wnt9i+joa
         QHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784909; x=1702389709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2QEf/lBr77RbAJvG5vi7959AaVxlYnauTCXxwH58FY=;
        b=X9j1+H8suif3ScZfEwKdPeQYJquKtaMcdFGmrYYK6veOPED97CvmsCD1NXXvMaxF09
         Ng6fHHihSparsS4eOzYyUIO74y1kORMGdW8BgTSfmR3eQuZYZoF7fSsCoGJK3UfX09nI
         7Zq+bTltSDPz7w95QYhT3FmdOTENsBqKQYhwGU9+3182ekx0GF41oVUQgYM1Ioh/JcZ2
         SnauKFUq3snZE26mqrN8xW1y1ssp+eHc2B/w5x9CG9uloYWRhQfWqeF9p23A6rB/0Wdg
         fTIFGMtyPdxKW2rwK+Jt0DohMHgHaXW8pQy0x61gCqmg+EcbXKbrFZfgE+t82gekRrpk
         LhtA==
X-Gm-Message-State: AOJu0YwYmLJvsdiXc0RTZMI03n7BuFiVl5P2qdhVu3yKjDxDABSFFKxS
	BR+hgO3RD6h2ykILeuSyUaUvee5Hthd0NZb0aclrGQ==
X-Google-Smtp-Source: AGHT+IH2y23DiNViv19gr+3P2n07qqR3+HXI5Ll8OTrQ10bG9dd7fvVIWWaEEK3HDN+3LbzRokbZo1i9HVtKRs33mNc=
X-Received: by 2002:a05:6358:71cd:b0:170:3f9f:b367 with SMTP id
 u13-20020a05635871cd00b001703f9fb367mr2362102rwu.26.1701784909498; Tue, 05
 Dec 2023 06:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031511.476698159@linuxfoundation.org>
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 19:31:38 +0530
Message-ID: <CA+G9fYuGmAStz97QEyPj+pg6Pu0zmffx1Y4NWpd76Kt=tH4t2A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/30] 4.14.332-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 08:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.332 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.332-rc1.gz
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
* kernel: 4.14.332-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 4937f1b0d0b4f85ff80f69a662a98e03626a7005
* git describe: v4.14.331-31-g4937f1b0d0b4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.331-31-g4937f1b0d0b4

## Test Regressions (compared to v4.14.331)

## Metric Regressions (compared to v4.14.331)

## Test Fixes (compared to v4.14.331)

## Metric Fixes (compared to v4.14.331)

## Test result summary
total: 52878, pass: 44955, fail: 1219, skip: 6659, xfail: 45

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
* kselftest-user
* kselftest-vm
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

