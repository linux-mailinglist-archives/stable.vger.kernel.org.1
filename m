Return-Path: <stable+bounces-10866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED8782D655
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6529F1C215A2
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375BDDC8;
	Mon, 15 Jan 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbdBcxA0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73305F4E7
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7ced36e0f9aso618296241.3
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705312299; x=1705917099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA5lJ9wJk8UhO+0P3ejLOIssUp3Ur0EA5ND4sM9FrM0=;
        b=lbdBcxA0fdWz5LyfyNpsPD6zqshCDhNuLu3PcGnMV4c1xS38okeOvPGAk9nyezQhH6
         ju/uYUTrFSwkLTfk8Lmh6jez/bb+aRBYAeyl9hncNixYtoquPd0JMI9C486Cwi+XjymN
         nIvYT/nN+vbbUOXsGUHLte/p2fI+Ln/g82JzeYw3S/s1T59a/lylvjgJTJD3+BZSFkGB
         4yDcqYV+9Y7VGyYVpvDJHdN9tJhT3px1yZPLFC/j+3TwPmHH0YcR03dAUb7qtbmnEm9U
         z7Cjmj2/1Azi1DRkHBrBwIV05OPaYcNlqvtWEpSfkagwZqE5q/GF5Y2Yy+rMRtvb4bh/
         BAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312299; x=1705917099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA5lJ9wJk8UhO+0P3ejLOIssUp3Ur0EA5ND4sM9FrM0=;
        b=dlaAhuPQenQrPZ4+W3KXa5mSsUCGUZWacPZE2qxPQ6fL4LvoY1HjjNLR4kjwrXulA3
         s3EMSB0TNQ1jJG/4V8/OF8bVqMV7V1jxW5XXNWNmjFLWXyphZvoOT6MnQV8PdM2JrcvG
         CBSmSGRVT+mM0oALzfbK0qmiPltPeshiVie7bLZ+vLEgheTLa5DwspPPQr8a5+jNik/3
         lyhZwcaRY6P3PVoA64ZD5wmbpl4YwBU92BA4/D77QoY8Azozsae4HawaIDIvje3K+0Dd
         z+W0yMF2IFjM4FmsxAZRnbhT7HMV+k2jNiGXPSUpr1oy48sLbRLGAuvoJXi1VPKiRkwI
         qiRQ==
X-Gm-Message-State: AOJu0YxuKVx0zD6a87mTSsFn28/GaAFpjygJ1QMoqyvsQwo4pwexHOaE
	qbmqhzfHqa2Mkn1nw/Qx3trBJcxzbXjiRfWVwLuwBpHEWBZbsA==
X-Google-Smtp-Source: AGHT+IF9L74+ZtLSFFSw6v3QZjCBTRN5oABKLtgsb37VYGttVKjUPyLhRFOYDKt2Zbe/CBX507JkdzEiHbCLkWACdz8=
X-Received: by 2002:a67:ea44:0:b0:468:d56:ab5 with SMTP id r4-20020a67ea44000000b004680d560ab5mr3259054vso.8.1705312297861;
 Mon, 15 Jan 2024 01:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094206.930684111@linuxfoundation.org>
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Jan 2024 15:21:25 +0530
Message-ID: <CA+G9fYssTTxo2Z2MuKdOs5-iiJu0QiohvBw1=eQRALyd76wLLw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/43] 5.10.208-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 15:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.208 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.208-rc1.gz
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
* kernel: 5.10.208-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 7884d82278ab66374f212a263f44664a0da4c76c
* git describe: v5.10.206-52-g7884d82278ab
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.206-52-g7884d82278ab

## Test Regressions (compared to v5.10.206)

## Metric Regressions (compared to v5.10.206)

## Test Fixes (compared to v5.10.206)

## Metric Fixes (compared to v5.10.206)

## Test result summary
total: 177915, pass: 136401, fail: 5687, skip: 35672, xfail: 155

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 222 total, 222 passed, 0 failed
* arm64: 74 total, 74 passed, 0 failed
* i386: 58 total, 58 passed, 0 failed
* mips: 46 total, 46 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 48 total, 48 passed, 0 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 21 total, 21 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 63 total, 63 passed, 0 failed

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

