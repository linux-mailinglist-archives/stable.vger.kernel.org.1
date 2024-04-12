Return-Path: <stable+bounces-39318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544608A3212
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C224E1F22B20
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759914883B;
	Fri, 12 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRIpeS3N"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F914831E
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934874; cv=none; b=pmwQHuY96nmXIC3jged6gTrt0iy65IpC/UHwjgPb/Qc7Kch/mI9WHTVi1IYaZVDZ79ulYTQFxBUQb0rjK9Am648uCDqtaBLxJHeg0lnBVO3HBsYXVcCtF1Ww/+fOySDMsL9aKCusKrncP7GT8ndH0HdLbvmrEEvhNSKVzeTb4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934874; c=relaxed/simple;
	bh=brEje0cHPh78nWmZ49OAC1Q54MURkbmR/oXropLUQlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDboIMBKzK6k07OBlhU1sx6zAi79bd5hQME85eDrD+H/Xp5oLv3IPExc7dteLA2wRreoQfOYd3hSjvT1RMwqLdjmkqPCvt2Ybak/BUYU0Qzpuwb2nHQLBswBst9aPKkBkVgqG7io/XWSun1gj5ZD03fjq/RuxMsOfNQkKvvytcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LRIpeS3N; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6164d7a02d2so10393977b3.3
        for <stable@vger.kernel.org>; Fri, 12 Apr 2024 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712934871; x=1713539671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLvO4O9yjxcuvv/qAn2Shyb8mUKKY44bwVC7r1AMAcM=;
        b=LRIpeS3NzedOks3PDgsh2sp5dijm6Jgp6sJe0ftpjyic6Jxjw/0dgw2oRzDnBbChlw
         Q/Wh0y0ZuhP57raoRbNhc+1mJ73IB9YQqe/MV/pH6wMQAGdhhHKhnFwia3zOVq6qqKas
         6RhNVkbG1yeugZvdS/2CFJbT3Fp6CtKGZDPLgd6CwhebhSBa2/O2O9i7PpXPcPdxh56/
         fL8KXiJZoRoOde/8+zHxGh4s8OgXIi0QvYOR/Os+LFz2TyaohwAh4TL6cTOTrsp/1jf0
         EVTmFgRDMGdcmfwFCz+AOJg5qQiHdPLf6Y3qgdTEWvwoRD4y9tb9NDbGp9L4ZDJIYD5H
         CVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934871; x=1713539671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLvO4O9yjxcuvv/qAn2Shyb8mUKKY44bwVC7r1AMAcM=;
        b=EsFckz65kl7VwBfhraMCXS0iVQm4U4/yWAx2Jwx686YIm5zKHs0Y7Uwb9zxz/7wbjD
         lLyNwt4LcCO9tVl/Zow3M8pckQpuKt8x4roDDvLsWO/G7pv/i+lkClq3fC0k8gvxwCy3
         atm/H33mjC7LJPtSlnSls1mic9oIiiq+mGJptOsgto7gYHLSBTPDE/yTWDza2eT/rK33
         Y6CObmapo8nNttIO5aImtrstL7xXcmGVncTaQhKdtTgTNmLzx3cC5ocNFAzjSqPRcPNt
         UuzxGfTh9I/ss0d6kTiKCKqBxZat/fcRyJrIfXMhLc37n9tw9aU+Q13FTYC7yxIDL2GH
         b9Iw==
X-Gm-Message-State: AOJu0YxZ0/vIZfEhn4YwE+Am/an0TxdHCndZNBBR6HIP4hs899AGAt08
	Nlp3jQUA5a1Is1O9HKi8h97cNU3XAwsJdz1V/kp8MTQYjzSy3jJ3d+Rt5ZUt37EYv3bXirpLETB
	VmE3Q08Y7T2mocfASuBNFPBi97baARkWxbw03ug==
X-Google-Smtp-Source: AGHT+IFLuEDQPZPdafjpLdhnG+r9Ye8iEmmGE6muHcR1tOSBTmu8a6ZSPp1/UImrPk4NjhvsWI0E09D8nDEHmcvlq2E=
X-Received: by 2002:a81:ac67:0:b0:618:66f3:818d with SMTP id
 z39-20020a81ac67000000b0061866f3818dmr2705737ywj.16.1712934870543; Fri, 12
 Apr 2024 08:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095412.671665933@linuxfoundation.org>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 20:44:18 +0530
Message-ID: <CA+G9fYswXLb=gN9SUxqpctWKyDz52rsrXqynPWy=uUAPkKCUFw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
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

On Thu, 11 Apr 2024 at 16:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.86-rc1.gz
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
* kernel: 6.1.86-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 2cacd493e299f82c489b78ba1de45da451d02bb0
* git describe: v6.1.85-84-g2cacd493e299
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
5-84-g2cacd493e299

## Test Regressions (compared to v6.1.85)

## Metric Regressions (compared to v6.1.85)

## Test Fixes (compared to v6.1.85)

## Metric Fixes (compared to v6.1.85)

## Test result summary
total: 161977, pass: 138152, fail: 2686, skip: 20976, xfail: 163

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
* x86_64: 37 total, 36 passed, 1 failed

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

--
Linaro LKFT
https://lkft.linaro.org

