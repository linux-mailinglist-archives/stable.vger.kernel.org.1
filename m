Return-Path: <stable+bounces-15655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5D83AB0F
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531172885EA
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81077F18;
	Wed, 24 Jan 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrcpwFDR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728D77635
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103774; cv=none; b=lLuRsPWdfsGJG0f6aCmBVGQiBZgs0YRA+C0gy5iAzCxijeTwKJG/sjP/sA2vWUhvWTIG/S1E1AMRGTJ6KrU3MaTNQ2lkXu3T4ZWe65zUf2Ma7Yw4siaziPsobxGT5Qooz1YyorpkVed1XJIfHv5CKDmzvSctCoLlfVFWAryh7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103774; c=relaxed/simple;
	bh=HP8nxaU5rS3Y7akBagTf6CBwQ71I4mYNtI9RF8Xh36g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqOPgP/5W8e1BS/1HfozHLB9DfwR+ch7BKVwQZsoWF2mgXgg9TxzjXdHbtBlSHlcXG2UgyKM6axEcaEpB9KNnf2QWWqk6OL47T1IkjOu+vY8OKYPbv1sMpu6TZLtBKanLvj6EctyaPjwPdeidsVBH5je8VdDoVfoi9DWCbzm2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SrcpwFDR; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so1825252241.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706103772; x=1706708572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TrFLj4+exaa3X9fzr2uX3yAlSBmc6Hz/Z8VhWjlP+E=;
        b=SrcpwFDRO9nHjlJUvkxdl41xVeKn4wFTKi2KKzGuBl2lk7YrzoAfaRW7dYGpFVvpem
         ax89kl6shcwlo7da9HCtzPt4H44zfc9pTMT3IqacI2yEMIg7l41N99iFuRBhZ8/KbJDt
         OguyUvAG87Sjb75azxbG7RuOFs2QC8qn09LNkQ/PuegoD1It8WK+C6/eGK793GsWrXNK
         2qIyriTJ7xfQ0QRHFZxJjWfuoWHSC+WbrwUKS76xdZ0/YOiT0GaePqS/IjQ1GsfKm1Dn
         YUl8GtJW4SFT01d6jh2oVucb3lLV1kyErAWHerYwKc1fd+1ms+9+NcAM4nsr0uM5vK7Z
         3zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103772; x=1706708572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TrFLj4+exaa3X9fzr2uX3yAlSBmc6Hz/Z8VhWjlP+E=;
        b=RvGv2+dftb0fMNaF1zUkfJzzfUCmk/aYyXCnkJiDAMl38GD04H13ejLDKSlAIDNE92
         n+3vhkw6ztGCQbVREnT+bKMA7o+yiZQz3ivHqy8ARz/o18UKlxFQ+bK31zRqsLIVxjWe
         FDnN17fQGZ3QjVWH4X1wm9kB0GUNysz/iHjItOgkFhop27M9McRctszae8YI+ExEVR8t
         URjj86pq61lGG7e7OoYcYztsaqAuBEFa99PHElCkQ5qHZ6fQFcY0Q0d6Y6H54eFo5ymP
         FMhq46fv2UAmxQr1j/UYIifhKcChxINg+SlacgGYp7O3mt2IhJ6x+bgKCwoLJKUVjuI2
         2jXQ==
X-Gm-Message-State: AOJu0YzsH2fT1GRQgIFQArYQbTdKHjJlNcoWMSzgmJ6Hfg8/aeSJTISZ
	uGP6BvBaD5bKc6mGys87j1tf1+43+1MHQX44qs/cBMKG2Uo8ZxhXV+l3xyqTVLZMRY9Mw2Qs5Ek
	1rDwID/nxoRuXP1p3GePqhSyUEUpDxlC5nuQzAA==
X-Google-Smtp-Source: AGHT+IHcwMyxWT78OAzMCLr2qdVhvMuRS6XWYrMXxWbbEvDbczGsjz048cKKxGZ192E9nQTpVyjJWQqzOAyKI5BZx7Q=
X-Received: by 2002:a67:ed84:0:b0:467:7d9f:afa3 with SMTP id
 d4-20020a67ed84000000b004677d9fafa3mr4068481vsp.2.1706103771587; Wed, 24 Jan
 2024 05:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174510.372863442@linuxfoundation.org>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 19:12:40 +0530
Message-ID: <CA+G9fYuj_UnUoUPy0FAhZyrAkgSAf77AeYu+Ds3fnZuN8a4-GQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.75-rc2.gz
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
* kernel: 6.1.75-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: a7fd791e5c51cd002dca6309fcd6ab75ee5fa9dd
* git describe: v6.1.74-415-ga7fd791e5c51
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
4-415-ga7fd791e5c51

## Test Regressions (compared to v6.1.74)

## Metric Regressions (compared to v6.1.74)

## Test Fixes (compared to v6.1.74)

## Metric Fixes (compared to v6.1.74)

## Test result summary
total: 135195, pass: 114143, fail: 2690, skip: 18196, xfail: 166

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 151 passed, 0 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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

