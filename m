Return-Path: <stable+bounces-9974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94524826A0A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 10:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1C91C21D75
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D4C2FD;
	Mon,  8 Jan 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0N7SIRX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F411715
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b739b49349so146103e0c.1
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704462; x=1705309262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFjCzv0wMwtjh1YuQ8FxsYy2UVS53yTu4+7AY0ZgE1g=;
        b=U0N7SIRXoskWNte8UCaK567PIlBTMwxnXS5qI/Vkmu7yorbhhuolX2QzQNZlj6YFzM
         DLbtFT3Xu2qU4cChIUmiJAdcL9OL51vHz2d+OjrDIrcrcFlazVyrxmEXIv1Zn1BR6+dR
         hLmwCSLD50QCgENL0fEtLOy0M4t9OMCQAOlOUwoAG48A52ygqkvdsWd+bkRvinp6G9tP
         7KcA6XxxZzQ5VzmQ6eAJtw0l6j52Q0ELdJXOVGia1U57xkKrLt/WUVxi6VRpxhcC3l9j
         L4tvbfcP1j0a1t87L0b8S5/0+Gs5tsWobK9JC5cFzPa7KK1Jb4DUEygV/yJQt+CC19hX
         5CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704462; x=1705309262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFjCzv0wMwtjh1YuQ8FxsYy2UVS53yTu4+7AY0ZgE1g=;
        b=EJKhSS6J8Q3lvRaTdjRF0ifzyXAV+DSLl990d5mvacOjRu1H5Cbik9prNGxS9LpmRL
         x7nMpzUuWWfIMQB8pY+N0cjoGLXam0o82wO4yI9v1m5eDr+tv2+yC+EgD4kFLqsT/cHB
         KxGbyRpGEplILS3D0Cf/uT/M17nrqtWGoljGdqlkptdnz2ZK0ijCQYxMUqsDYJa1HYsT
         ob76STtmDvXEJFQ4SePsgENLBQt5Svzzcg/aaNDraIMNZdSr9drF6ToNotCitopAvctP
         UNmQw+4XgUcte9gh2cjMSFp+uMEFzfWet4ZRWPd1YWg4BgToLkdy/vDE02ZwOany21HH
         CcBA==
X-Gm-Message-State: AOJu0YxWjdGiI9Mf7kj3j3Y7Wfj21dtUyVsncQrIPcSk3G3Q+eE5NjaC
	lOE+97exjRfImQHx6ukwWm/ciJcXeypYhck8O3sw+1tpb1Zv2w==
X-Google-Smtp-Source: AGHT+IG80yfhqGycs7SKTJxvgdfjKPJyKrWvjZqGjXKguPsR36dAPkp845OCnFOxSxMXRSUZQDA6d+T/QGsYxAHwmXQ=
X-Received: by 2002:a05:6122:181d:b0:4b6:e848:bf1b with SMTP id
 ay29-20020a056122181d00b004b6e848bf1bmr687292vkb.29.1704704462535; Mon, 08
 Jan 2024 01:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107123823.571931307@linuxfoundation.org>
In-Reply-To: <20240107123823.571931307@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Jan 2024 14:30:51 +0530
Message-ID: <CA+G9fYu1vV-wiFPX-m-8qnuEtQ53w2exp14mY-Z-Xwxg31j+XA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/19] 4.14.335-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jan 2024 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.335 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jan 2024 12:38:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.335-rc3.gz
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
* kernel: 4.14.335-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 58efe9e4bff401aa96c1be73b8b05fed2437b3f7
* git describe: v4.14.334-20-g58efe9e4bff4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.334-20-g58efe9e4bff4

## Test Regressions (compared to v4.14.333)

## Metric Regressions (compared to v4.14.333)

## Test Fixes (compared to v4.14.333)

## Metric Fixes (compared to v4.14.333)

## Test result summary
total: 54694, pass: 45673, fail: 1625, skip: 7350, xfail: 46

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

