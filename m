Return-Path: <stable+bounces-4688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97BF80580F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC9281B99
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835867E73;
	Tue,  5 Dec 2023 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z21uFAYj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AFA9
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 06:59:13 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c45fa55391so1771042241.2
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701788353; x=1702393153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8ly4PRrtbFhpvmMcAd/IAQqDN3hBgIZ/cSCffSAAOY=;
        b=Z21uFAYjL+KwqZAuLXvVpOHNQzTa0t8vqVVPApwNND7HOT2NIg1mReB/keeWBgM4o7
         dDrntGKFs9Tq3kd9aEwX5wmhuxrg1cXLmD0drMXwWzaFAM9LTMi0ZhbRHa3juFbxM+/C
         bL6t73/Ut13kCWdROzOY0ukApLWgk15Vyrca2YIBzXySwgMi+Cl79mV3/M4yFVYP0DvP
         T3sP47bJ/VKwqB+/mi/ZLYozSXWLXB0AL8MWU2flW2iZvU9tO3qKZRiSTO0W4HNZabqe
         HytE9+hxMguHm0cdgXpaEcJPH+/4Gowwv+6SvkthQCpM/C6BcmyQkIWgVwmRjbPn+IKq
         LvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701788353; x=1702393153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8ly4PRrtbFhpvmMcAd/IAQqDN3hBgIZ/cSCffSAAOY=;
        b=eCVGm8MoRiQWM+a7iW2DgdYJZZCQqOzLkZPFoG/rjHHFomBR+82i9h58KBT5CqmJFR
         Da1+jrWA7dlUVvOIvheve8ODO7TYSIXudFviCgrg1R/XYRwSB48AHnC8wPhegyD9+khv
         VJQGokAFz0M+mDki9ymCfwb+7n8+iAlqknyND8gpw56ubK01fw0RkKu5QjhYC422w7mx
         c+kt/oE1MaMGobBl6ATtlsC8ie2e0gbFFZckjz31d75keRdPDTX2QVD1P+zkCcJhqEq6
         +2EhtRz55SvgALyBtQRFYooC2IX6MI9dFgqiZQ6LbiStMooPyEzlE9QalpBfWek3VHg4
         Eivg==
X-Gm-Message-State: AOJu0Yx3FQjwiddkRgtNp3E0xpYBMod5luqcp2V0gHg/yq7vpp84UCaY
	y4Mjvm63sl5AfWWpwMY6yaBihnEoul6tXjQA/MrQYQ==
X-Google-Smtp-Source: AGHT+IFFmj78JXPJcEQrLiGMwcKHkteXoPlhwfKxlDXUl0UR6JNMJeAsSWdEyzJb9Pm+DqpCXBVKKSuv9pY1Kfvwxjs=
X-Received: by 2002:a67:af0b:0:b0:464:7b6d:2efc with SMTP id
 v11-20020a67af0b000000b004647b6d2efcmr3614145vsl.34.1701788352287; Tue, 05
 Dec 2023 06:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031517.859409664@linuxfoundation.org>
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 20:29:00 +0530
Message-ID: <CA+G9fYvZH1HhsznP1KxiBRoP7SbN-veMWKavdSoT4mGQ2_-2Kw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 08:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.301-rc1.gz
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
* kernel: 4.19.301-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 82300ecbea435bee3c53b97f701e530cac79b81e
* git describe: v4.19.300-72-g82300ecbea43
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.300-72-g82300ecbea43

## Test Regressions (compared to v4.19.300)

## Metric Regressions (compared to v4.19.300)

## Test Fixes (compared to v4.19.300)

## Metric Fixes (compared to v4.19.300)

## Test result summary
total: 54948, pass: 46304, fail: 1597, skip: 7016, xfail: 31

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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

