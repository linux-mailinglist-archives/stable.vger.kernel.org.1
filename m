Return-Path: <stable+bounces-49964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8A900142
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23661C22ABC
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB1186299;
	Fri,  7 Jun 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIq8bJrR"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7B15DBAD
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757545; cv=none; b=mI6p1/zJXE+uDnu1RPvr/u+MLRzf+Yp3eBmMUvztWCewd7fvucWA+Dr+A+GNTUy+6+4V2qhW6oA3lR2KgWRGaxR0qkjDcXkVXrlJnS8aDGabSqxh7ehZm81oRtgDFL3WAETqh3Bvo+MmiYcg9seqxBrQFB9ERONNtzDty9HXydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757545; c=relaxed/simple;
	bh=gSWSP+7C8UOKUu7+vq+El/x9kf+z97qTlQ+ZsMnmONo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5heDUchoelKV711yJQ0vdMTM3FAKkSJLjNfku/+EO6jzkjdubWph9ZORCmApj3fPXZqkrs8ca9Dz1J21o3eXY1cDswbb3JByYoJXB5c01aeti8EetYBOiGu5Oys3k9PUKvl1xd2qEmyIjyZhFWK7ggO8VSGD3k1czZsFY+1ZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIq8bJrR; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4eb3e4bdbb9so662219e0c.0
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757543; x=1718362343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPbSPneHT7Jvjy5REyHR38Uuhd6bNow/3VWxu5TPx5Y=;
        b=tIq8bJrRHvaLq2zc+PpaXwrjpXJ+G9pHfTizLsRXZroHEm4mxHNKhaN9Ioj/Hjeouu
         ymGmlJpL6kxThdVxj0XWOOb0+OyIPOpg0q1NOR2uy2z6BMXzHz3pZi4IAYoZ3sBVeGz0
         /x5I9lt8CxIPoLOxtEzFkXaxZT36dCUR1a1BCZgFvr3nOyBUdPCfRsmdQctPX5ypRW3B
         xNDNOa4uCHbt/t7Q6KMVQ1R0AcL5u6g+zpOL9bN0gyN81tOGtwm+C1QsDdx8MKdN3DLh
         IHqU6+1fDB0qOWTbSaZrhyzUYH/68r/0DHRm5rmD72ZVw1N+WeoNE5zqmCxiQGCOyxxE
         LkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757543; x=1718362343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPbSPneHT7Jvjy5REyHR38Uuhd6bNow/3VWxu5TPx5Y=;
        b=nBmXPsZdVcDilz0DnTsZmmzAKWmTZTgOF0Q3JPUVmd/gUgJGNItnKbobdqIzWei+Ye
         iARVFrtSHMJ1YqZ47eCgr8yr4vLGAi5OWfAyR43VB9df2eAYhHPrQWBs9/K0KXcRFh1L
         sjmGLQllhi2a0sDiPacJo/K3/H075zzVeTZO5yAIlHHC68CbPxZ5PJVJE7PIH5eEoUyt
         JoTXAf229U6pzS335UQmgTWTiUfF2DPtwr8qpn4Mp7Wg4Dy9GgojhnRXV7dRkW7rTQIu
         bUZJF5t3ZBDwrcQTZA1FHyCa+U2ZqMzTZO8rRpeed7NMUUhLzatWGPtDdsMiqDgfvBb6
         9Itg==
X-Gm-Message-State: AOJu0YzDeND9U1Ez3RMlM0Yyn7+mwprKf0nJ+hOuqNxuvfbpa4jBnUDq
	7VLEwCJ1h7VlgzQuTKxE//rxGwbrHG0U8o8c75lC6oU8HoJBuS6F23juUOgGetqzwK0L73ZvOfZ
	d7Arn5+FU7J9/9fziJJWSAwpgvAzJbl3jxnnsjA==
X-Google-Smtp-Source: AGHT+IGZgoJBNxvF0IqzZ76RjN/3DL1M26P/4+jxT3RGwhtV8AOnkj8ddXuo2lmlwYIZDVnndDCRiLv2h7nduOcdfRM=
X-Received: by 2002:a1f:7c05:0:b0:4e4:ec86:4240 with SMTP id
 71dfb90a1353d-4eb562a4b69mr2327968e0c.12.1717757542953; Fri, 07 Jun 2024
 03:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Jun 2024 16:22:11 +0530
Message-ID: <CA+G9fYsnQh6ydxf3asaEvoOE8a1oabcoUp91m3MJRyR6caKJ0A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
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

On Thu, 6 Jun 2024 at 19:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Build regressions on Powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.33-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 39dd7d80cd65769389563028553e9ec89a8f88d1
* git describe: v6.6.32-745-g39dd7d80cd65
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
2-745-g39dd7d80cd65

## Test Regressions (compared to v6.6.32)

* powerpc, build
  - clang-18-cell_defconfig
  - clang-18-defconfig
  - clang-18-maple_defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-defconfig
  - clang-nightly-maple_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-defconfig
  - gcc-13-maple_defconfig
  - gcc-13-ppc64e_defconfig

## Metric Regressions (compared to v6.6.32)

## Test Fixes (compared to v6.6.32)

## Metric Fixes (compared to v6.6.32)

## Test result summary
total: 193993, pass: 148173, fail: 25962, skip: 18882, xfail: 976

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 22 passed, 11 failed
* riscv: 17 total, 17 passed, 0 failed
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
* libhugetlbfs
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

