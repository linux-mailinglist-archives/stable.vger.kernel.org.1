Return-Path: <stable+bounces-10861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101682D568
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40751F21B5B
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53045BE69;
	Mon, 15 Jan 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tnw5ofq7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C3C12F
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-467d87c90b7so1558151137.2
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705309044; x=1705913844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4v1AdI32Kp8Z1EODc0dmNDkAUnEI1s57YhrdMHhuH8=;
        b=Tnw5ofq7dMPkzIctKmJNqZ1GLMGCnqhhHnNmRYVERoTn7KFLVV5uIn9Qks8syrfKa8
         BRyXhV4gAgLsGobg5pCknH66rgDxuWzdu+K0oLg0dU/J35LRgI1bDXGtvIGMF6ozhNyj
         rTznATisC3AmT5PL3JyMFZDHMAsPxPnd5TkudVx7Xqb2w6FISqwMwDOGWUBDw3lwbdOi
         MYhnn7AxdHvdFXtP4u7jV0XPScHzlrzJLnvtU5bbiW5a7hSGgRYaaxJu/tH2XpwKJDTR
         llMvHEqtTbqT41FBESWgY2nj+Pg7yLGWbWqLhEwQfO9Q/zFJx53RL3EWHiRMf2cLv9n9
         XJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309044; x=1705913844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4v1AdI32Kp8Z1EODc0dmNDkAUnEI1s57YhrdMHhuH8=;
        b=Ri8kJ/2ZgpLeqP38I4S7TjRXwWrpBrBuKymAM0CC5r3yV5Csoz7QYG2s6Kmzuf5mo8
         eaTdmXtL2yK2IU9GQILAO5pSeOKSiS3L6gUqLgik9cyolXqjAnDtR42JI7oj05jnXWdf
         sTfQbz8SLZIU//I34l2ZoNvXsjMZEYZyj10xbfSvLXtOsUkjooGPXmizZ5KENQgTUroM
         LX8zlKUJRjWk23WQ0VWYMg9EtxRf8C/gZ2fSSOh3x5XZEwc+4ptVRDLfGDHNLT8nJnai
         iTZ4n3Rpwn407FK+80mH3E8PZyK/zEZdN7Uohn4fcMom9Mm7gOFqNyMqBbNQc5ihelvQ
         77+w==
X-Gm-Message-State: AOJu0YyDwNqqNdocRz5vlU9dNnkSmePscVW22CFEyWTk48z6Yt+zMANP
	HHh+qG48cwVtvws6yxglyUkYk/OKq8GONNX6R85VrOJOjlKMuQ==
X-Google-Smtp-Source: AGHT+IHMmYxzI3mAVJDcEJEplNVxfmygp9nd+wcU/5sYY2iOvEMAdLZZg203zoyPOGUGbPTazWIMJJ4PrLmYbvV5IGw=
X-Received: by 2002:a67:e9ce:0:b0:467:ed7d:27bb with SMTP id
 q14-20020a67e9ce000000b00467ed7d27bbmr3166740vso.14.1705309043703; Mon, 15
 Jan 2024 00:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094205.025407355@linuxfoundation.org>
In-Reply-To: <20240113094205.025407355@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 14:27:12 +0530
Message-ID: <CA+G9fYv71kU78tJNO-gZ-SRf4aOSgYveudKuyffq8N3-5oFvAQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/25] 4.19.305-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 15:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.305 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.305-rc1.gz
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
* kernel: 4.19.305-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: cb74230da5071e4cb54b342a0d079296ecc14a98
* git describe: v4.19.304-26-gcb74230da507
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.304-26-gcb74230da507

## Test Regressions (compared to v4.19.304)

## Metric Regressions (compared to v4.19.304)

## Test Fixes (compared to v4.19.304)

## Metric Fixes (compared to v4.19.304)

## Test result summary
total: 103058, pass: 89229, fail: 1698, skip: 12065, xfail: 66

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 216 total, 204 passed, 12 failed
* arm64: 65 total, 55 passed, 10 failed
* i386: 36 total, 30 passed, 6 failed
* mips: 40 total, 40 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 48 total, 48 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 54 total, 44 passed, 10 failed

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

