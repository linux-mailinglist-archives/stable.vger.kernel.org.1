Return-Path: <stable+bounces-52180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7F908988
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 12:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D68289423
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950211946A6;
	Fri, 14 Jun 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWBbGW1w"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E061946B7
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360270; cv=none; b=TrNWwQP08m5Xba7B9MWPO0UrgeuOQ3iTsdgJjnKj9/kKHSX09cauXhPvFi+RRpZgQaZsiWv1gL0xHJlsRkoLPyjM8m7HtuYJfoiaYNaB2aOMMuavc4ntmzsbpa1OJ5YNB9+GedWvx0kWbGtjU4TAl20R/GCgCMY/tnWfHTmxtuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360270; c=relaxed/simple;
	bh=Eco+uTFOd7T/xAKCatko4+DsGFdalTigAJ8KBz1OuWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC6byJxAoBl6cFB1DZ4ik9yOI++NiDeYairzBA6Ca5HnyrQgubxxK7+WEVwSFnXjjWumkbl9oKuvkq296N/04sbwbZobe57LLw6N/DI/hB/uQcOhp9OBIhMMfRAHMldfypCUSVN1FP1oayUihwq3WdyTRejR7hEYG4X3nHNefhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWBbGW1w; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4e8a6159479so689913e0c.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718360268; x=1718965068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcR5jrPv9if9D/VgKJ9lEznZAKrGO1SQqzzBwmeikFc=;
        b=EWBbGW1wjsRS5NgoRCfCYAgpKRMDU10c+lanVqgarCYniAG7KHrmJ/3Xph2CVzHlQ7
         YqERuygpyV720qDqyV11GIeyVvdbw3+aw6ap/3Vp5d8UvbxEQNtiMZh3K/4o9NG21ev/
         a2syljWZ/ynrl7m+vlCtdMRIFWw8fVuGjkugpiCp558kC+s4Zbs7tqv8DJZCYJWqusf1
         IZ/AVA8lMFpix7Y2vqfqgf/6p9RJhK2BoU0u+hSKZ1L+4P4y+aN5J5l6JBJT50vuuzY0
         oQWPemlgWqpG3MvV0zT3lD3D1rnjA6VL764Evgjq7Aj6qM/a0FtXrwpZCE2OTuOrRa6D
         UMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360268; x=1718965068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcR5jrPv9if9D/VgKJ9lEznZAKrGO1SQqzzBwmeikFc=;
        b=tAvPBY8Z4xvMq0D5OMVl7o/Dxt+KPTAb8NIhz/DtD8MV0GNantAJnfs/9mKRb55QK8
         aZrqSffgte+WMZOIydx56mlNasv+UN8XBttmhJHsV8A3gsS1t5L4VLp87s6LuRxocGhJ
         kFlS7X+R7/UpLkzOgPMZ5n/4idjcB2ct5zdH0bvWdTVfter+SddNI97srltj5tqldhON
         AWKnHsCj3kJnaPmA1LfxeY2O7UzaXVBMYyWxrocADCkcygbaLdaURv1ZJJTSa6bhUEZc
         POcDrAtn7ZzwXIoxymUq3zKLOh8yeJL5APz4dwPONdCZYJE9+8AQVy1nc0Q++Igbq3gT
         BKtw==
X-Gm-Message-State: AOJu0YxpcJf79D9tBraULH9XERnP27/mFCmpEZ8V4IjY2zCQudcb0j+/
	6fzv0pA1lV4w3yx2EFuHhbUAXOy6q6W3tj9I/Qd8qIbqGm7nJNmnMfOiAAT2Fa3dC5Smhh2txSA
	3Zl9WzS5FIMO+MzbOaAIj5+UDa6cIPrpjPMBmHw==
X-Google-Smtp-Source: AGHT+IGfhbk9BfzTUsPQeOVCsYK0iSSQsgLO0cPRcXSDGtgPfz427B2/nASsXIWVdwFXCzmxufZkQEEDdmFmrGc4ArI=
X-Received: by 2002:a05:6122:2a02:b0:4ec:fc54:9f86 with SMTP id
 71dfb90a1353d-4ee3ed7154bmr2990174e0c.5.1718360267647; Fri, 14 Jun 2024
 03:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113214.134806994@linuxfoundation.org>
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Jun 2024 15:47:35 +0530
Message-ID: <CA+G9fYsheVmFnvf=c7dXWeXAbqgDL4E2JcLszx3XB-t9v4Z5MQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/85] 6.1.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 at 18:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.94 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.94-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.94-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 0669369075405ff8a9c8fdbcfdad1c10babf44ad
* git describe: v6.1.92-558-g066936907540
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
2-558-g066936907540

## Test Regressions (compared to v6.1.92-472-gae9f2a70d69e)

## Metric Regressions (compared to v6.1.92-472-gae9f2a70d69e)

## Test Fixes (compared to v6.1.92-472-gae9f2a70d69e)

## Metric Fixes (compared to v6.1.92-472-gae9f2a70d69e)

## Test result summary
total: 133520, pass: 114013, fail: 2055, skip: 17275, xfail: 177

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
* kselftest-mm
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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

