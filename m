Return-Path: <stable+bounces-89170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0D9B432D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C91F234FD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0652F20262D;
	Tue, 29 Oct 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPDBYGyO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FA202626
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187275; cv=none; b=bptiQ1IG00+zhZGYUtOfufw0sIHIqrQhqD6HpGLBofMpdNs+Dh6PzUBeiptyY5CifZc3Www5wYb1WdloI1cU8yJELIleGV5PHvDf8M+HF6YAwh5/6ujpVj3D2jH4OR5PHtnvEv3hbxd+I8ekHGFJAxdU5OtGUeo5JAanR1YGpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187275; c=relaxed/simple;
	bh=5OfryaVqe/7qDVCKSYnz2mq60YQhL4bY0IP5WlW8nXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/49o1P+jZMLr8fexOZPHFphX3Dc1jAoYukMriFmPCW8bwrt+P/zphaH3SfUzGzmqDeDbm8xAyLUA7n4+QkZYxCnULBw1CF5203eLtqL59ENmu3CsECDyOzu6zdbPUJrVN6OrgidmEqR9iETiJiDHAfvDu/Qwwd/54oyAeXwYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPDBYGyO; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a482cb53bdso1782998137.3
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730187272; x=1730792072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS0iMBhICcFdQ7QgGswZXvWgJWVKFrZg1DQxHYILa+E=;
        b=vPDBYGyOOC/R8KrCKBS7XTD+ciKsBhsgTL7dMpmMk7AhXQZbenEbfBJ+/AoZQ/zHr8
         8Il5N8KljCFeZFCqdgTYwsWlOtvfwy+2Qm32eNZoNGHKEjuV5rvfpOitRJGpMYqAQeHf
         LOq7UDIciA15ivrI/GB+i2116/hqE++g+CibocizcwAuxCMYo8LxNxAaUSORqn64NZsy
         2XKLjkF/MvLIY+3AV9RUF9dBnJFqkxIjRK/ZCmVS8qd3jGZ+DmpORRH9WAy1ZiCT7xnz
         CUXY/Qo3iYMNEOOEWEqlnF/gocQus2tmluRwYn9osvY1LUv3C2fVX8TwXfTpdpO92xZy
         MbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187272; x=1730792072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS0iMBhICcFdQ7QgGswZXvWgJWVKFrZg1DQxHYILa+E=;
        b=oXVS1h46Jy26fdXCo1o7mXDgd8vZMQs0LDGZxYlbY1SNoGopigSW85jx+1nUAALBRv
         6l2HuoayI4TyW4kvSPMAKo7zjoXf54IEzQNi/0NWTTtQdVo9vVHX/upnuTIkRazk8Gjp
         JFNnmjh98xEcgYz+s5TnzX50Yy4/VZjZqA6PnjIH/xmJcG3BedGO1WQS2xC9t0MsccxW
         cFl16D96olp1FeaONeG+EXt8MBilNZzkdRNrFSS9i65eFi/klQb8b9LVelZWdP0bVOXl
         EOnzg+O9uGl4SpM8yQuUrnAXepXyjufabVntkRp4vaYWd+WXWE+adQAYmGzFxGuWSsoF
         JT1g==
X-Gm-Message-State: AOJu0YzlK///iPxgxdfW9WnlYtLOfeR+5A9IyaD59JbOUxnVBX6KeUWe
	zhLtSxOCeC8AvfocHMtEvajkeu951JpZaWufaiVwMcr9oYM2eWz5SUTpud1y1dlrksj7FiRdFhv
	RrI9psyAvsyc01Vns77QZTH5Kf3+ACC209h8Xqg==
X-Google-Smtp-Source: AGHT+IHIPQQyza4Vs8m5RkTZ6ceQM7vTaMw8NB2Mj1CsFFSgoaiLpyCaWgB2VKizchlhCrVaX8asmpmcnXw0uGJ65W0=
X-Received: by 2002:a05:6102:3e92:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-4a8cfb2b0c2mr10071510137.6.1730187272352; Tue, 29 Oct 2024
 00:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062252.611837461@linuxfoundation.org>
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 Oct 2024 13:04:20 +0530
Message-ID: <CA+G9fYssH1ZMstdHPMGtD6+VmJnVYTZL8hPPyRWEEf7Vasm2Tg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/80] 5.15.170-rc1 review
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

On Mon, 28 Oct 2024 at 11:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.170 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.170-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.170-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cebe213d2a87dfac79e970b8902e0c80cfffae9b
* git describe: v5.15.168-164-gcebe213d2a87
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.168-164-gcebe213d2a87

## Test Regressions (compared to v5.15.168-83-g4d74f086d8cf)

## Metric Regressions (compared to v5.15.168-83-g4d74f086d8cf)

## Test Fixes (compared to v5.15.168-83-g4d74f086d8cf)

## Metric Fixes (compared to v5.15.168-83-g4d74f086d8cf)

## Test result summary
total: 68730, pass: 51797, fail: 1825, skip: 15012, xfail: 96

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

