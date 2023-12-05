Return-Path: <stable+bounces-4728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F88805B40
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8421F21549
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F71968B80;
	Tue,  5 Dec 2023 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7iEbfnq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659AAD3
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 09:41:29 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77efc30eee3so109834085a.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701798088; x=1702402888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlsdvKux8KBjo1yORhCzPi/wYEemn58vl14vutNt5b8=;
        b=e7iEbfnqfZa2hMoNJJGL+ivEQQJ4YJFxYdcjzHlaPBKrUS+A/y6ak+ruOC/DjunpEm
         j5e9GNeW7JGNGO5AHbVP7+/mUQS98ZbwXJYDVh0ZfkllbYkSrG4UnRRIurKOnC4IDhNK
         7BpqSBuyFYIepjKtOVCjXvedsK5F94Jig0n+YuNmf34Wgu3s9istVVGRnAgaPN2DYVHR
         kVed13tZzy24+zMIfHnwD9sQ46XU9iS/+I05jVRDwdKkPeLiOPmYPDYbFkLES0n+JUn6
         ZfnkS+bxtwX+jNYuWAQ6G44UqdlTyCHxBca5YuEQIwMUssLh43yUe6D/LIYDvXnBmE/f
         krww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798088; x=1702402888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlsdvKux8KBjo1yORhCzPi/wYEemn58vl14vutNt5b8=;
        b=Z7VjOWnM/Vh+AL20Y+iiCjhn/OxkX0WNr69RL7vXJydeTSWZka8W+FsCvTSc8LsLCe
         /TSBN9lJa9jjnOJ+yBRCpXAVIv+k0ttGmrWB3IZpxAbSWXZx+GEzr1H+SlETq8CrYa4s
         Hl4r8tjpSqFsiNTtTJ0hvnVJXKcHs1wvlgE8a6Vvj0fkVRdb23+8ZwpbnqQQuP32rNHG
         BjRI8BJum6/cVEagz9PvM4pCv0LY0JMiM8TLaYg7bp8WzCXraLHJ/UWXRpjIfa1iylLV
         dUqnz+3kdx/SY1V4uvhdHjjwdVZxRNDquqGTSnNNu3coqScpRA63sqasZk/ood8fF5H8
         +TdA==
X-Gm-Message-State: AOJu0YzeebA1YznmXuBUz6R8i0EusOlV3Cr2y7IYaPGApdG7zv3DNOpX
	FPuNMraBEjLe4GK1z/KhHhwyfkuAFy52sBAWgv5w1g==
X-Google-Smtp-Source: AGHT+IFxKRofhiHifghODSTOLmVOMB2G7Zc0olaleLmeblEItlygcVU8ag+EwNQUW29QQ8ODXdmcuIsP04W3EjkQWXg=
X-Received: by 2002:a05:620a:888f:b0:77d:795c:71f8 with SMTP id
 qk15-20020a05620a888f00b0077d795c71f8mr1229948qkn.19.1701798088473; Tue, 05
 Dec 2023 09:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 23:11:16 +0530
Message-ID: <CA+G9fYsezgwb2W8ngoKELKxR7rxrOCzpxzixY3CojKrZSLkJ2g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 08:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
x86_64: gcc-8-allmodconfig: FAILED
 - https://lore.kernel.org/stable/CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_Z=
UOhF9QRiOg@mail.gmail.com/
 - https://lore.kernel.org/r/202311301016.84D0010@keescook

## Build
* kernel: 6.6.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: b0b05ccdd77dde3d5f44e6849679a2af2f3af0e2
* git describe: v6.6.4-135-gb0b05ccdd77d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
-135-gb0b05ccdd77d

## Test Regressions (compared to v6.6.4)

## Metric Regressions (compared to v6.6.4)

## Test Fixes (compared to v6.6.4)

## Metric Fixes (compared to v6.6.4)

## Test result summary
total: 144804, pass: 124361, fail: 2511, skip: 17803, xfail: 129

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 124 passed, 21 failed
* arm64: 52 total, 44 passed, 8 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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

