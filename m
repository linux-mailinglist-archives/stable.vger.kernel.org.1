Return-Path: <stable+bounces-25376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB186B241
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931DC1F26DB8
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5215B0E4;
	Wed, 28 Feb 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQLxJfR6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1B3BBD9
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131636; cv=none; b=qntbFNi8aI2ilu+8uD5k3tzatHBO7cw31x6dN/AoI55hyfIfMq5Zz6OGf6KmGF2qEPmIJ4IRbkZ+XjToLw7820CM9YRa4VuEOUb5AWEprvCrKp8ys5yTYMYjmLGDVDoVPUgauGfGOGALSjusjyGxAeUMtcuqM3bbqLZedtbzqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131636; c=relaxed/simple;
	bh=GSUDTICY8C27ijnOdt8gTGfv1+oA5wxqKyWyUbVbLl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q94mvDZur/Z7a6BXaZOoRPDDH3vKd4Kogwa/6FWlfZnjZQOVk8PHOLFC78OSO+aQLbQt4uDhhJ3H04xrUcZBj1nkvtykexDubHwLC2IaGGV73VR4uqEV+BQb4vfIXUdKnvw9I0deQsGm4OzE23pCIGKtFVy9OfdytrDeS83Dzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQLxJfR6; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d33829e9ccso330401e0c.3
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709131633; x=1709736433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0T5YDBQ282f9/2GXVWlIN3H27ES4N8CI9531Muv6sQ=;
        b=IQLxJfR6vmmYWDTgRRq7O3FQmafueZtE2BzvHCNdMYMEAPWQksa1A9ftLwEw0t2t8r
         rsKS4yjMFU+Dm1804/S3s2vFEnuu/ZwiMDOWd3BI1gEWjuH+i9Nev4/fjEpxQbk30GoG
         YTk2xsfH8O67/XFqjclm0X2NU9uQe5Df0ZLDjms15LsZDautwQF5QqfqkJlew3X5UoS9
         EqCH2XplZu+G7LH6tBrkDBSmOrXFM3AAjiwl7ISk6AGbXWZt1tOq58LzWoUWX/ZvsLbO
         53VNARbDZcCS+dxu5bHjidF86dy4SzrCIqRyfGlZaHH5ISlN5U1OvYgLSiwgs+J41gTZ
         jU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131633; x=1709736433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0T5YDBQ282f9/2GXVWlIN3H27ES4N8CI9531Muv6sQ=;
        b=iZWzSFWMT0fKKkGyZ/QX38vVu9iiv9dDethgAZC77ZHPamVgNEkVB/6yG1AJ6uYrH2
         V8nyqGMfDn0x137ROF47LhVrpY7/9OUi4Z/bZZion9xD9OPH2R5nG9tzU8gkTGiEnzZY
         aQg8vTLumbij8fG5xx8ARjY2b7dN8p5dZpfs5QuiOCDbJoDQnCcIA3lVWi0N2XqweDUl
         EODpKUYT2KuE+ehZMv8vtzWUOmUP7VgRKrQYjBAGXxA7M69MoFlzXYHoiAAw57FyotBm
         aKao6upead6BjezRy3vvttSEUDBQQp2uxFyJqrUJ9vl+M/AaTQEvy/ePsVi6ZVALniKT
         X/vg==
X-Gm-Message-State: AOJu0Yy9W6L3pN9kV/PNsN+/MWCbNKAuSkSzf462J6mYbYcGCg68QiAA
	3VLzRkRQ2Iuj9CItwzhvx82Y9KPjSEOLkiyIHvviBRJraIv+XLU7cDS8uX0D1EHpwylkl+57mZi
	+hcEw7SDt2irldNhjlPtv/drhYJvLWoEcM2On0Q==
X-Google-Smtp-Source: AGHT+IEUFGTJnvQ0yWRemsmFVF6KnZXwWf015zjxG0AplIMTRp+lycSyzH+19ULfMMZpPzzciMODnQuSAtywiJBADHU=
X-Received: by 2002:a1f:c844:0:b0:4cb:56c5:5816 with SMTP id
 y65-20020a1fc844000000b004cb56c55816mr9250516vkf.12.1709131633465; Wed, 28
 Feb 2024 06:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131630.636392135@linuxfoundation.org>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Feb 2024 20:17:01 +0530
Message-ID: <CA+G9fYuQ53GqKnWU=UokDWzZV9Z0waH4UDLaLn6mrMRM4A18=A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 18:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: efce2e6615798a9e83b7a4798f3713414938ab6b
* git describe: v6.7.6-335-gefce2e661579
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.6=
-335-gefce2e661579

## Test Regressions (compared to v6.7.6)

## Metric Regressions (compared to v6.7.6)

## Test Fixes (compared to v6.7.6)

## Metric Fixes (compared to v6.7.6)

## Test result summary
total: 264420, pass: 228013, fail: 3651, skip: 32434, xfail: 322

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 32 passed, 2 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture
* timesync-off

--
Linaro LKFT
https://lkft.linaro.org

