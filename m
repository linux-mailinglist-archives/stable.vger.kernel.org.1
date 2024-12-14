Return-Path: <stable+bounces-104182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8F9F1DDF
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 11:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485C0188B8D5
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A6161328;
	Sat, 14 Dec 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXoIvhLC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2213BAE3
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734170503; cv=none; b=BZVxYMTWCyRT1/8E/RoSgovNXnnp7ixZpL99tbYDrrtKicyhUCBOdihAEYkC1G93L8NZJIyYbo6CCR/ZpslVIOnT/7tiydFiIRCWubyA4TT6Kykucyhxyco+4OuzB+C28y46BxQhWph0jUR4N3ZiOPMm2+ggGAgD16Is7h0oqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734170503; c=relaxed/simple;
	bh=L3Ts2vR1tGcJOhL+7WA7EXHct8W4/evMCyaznAj/8PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVc246+Ay6g/UtywKsUo5hD61+9J/FNn+hFaWki3FXB/PhD7HFvzcBc4tRXimJTXV/h9wAii1oYnOrr6IhNLhUc2X0lQfqQD+xAwuGvmFjBPD/eE/USKUU10zGB+/KymNnsuN3oDH+WWAQwpH3p7b/o4f62WIs4tvzjFp3OgCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXoIvhLC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51882748165so745041e0c.3
        for <stable@vger.kernel.org>; Sat, 14 Dec 2024 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734170500; x=1734775300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6iJmqCbGDdzurGz1nq3IkvqP7Qanek/ZA/cXhzDn70=;
        b=hXoIvhLC27RZ5BMmf9zDZz/h06EjApbyHlZSOVgioyf3jzrIa/dSXwTBWiQ9vuzH+M
         +2r0nrHz2aT82PuZoxivlbS2ptTgM+h03GWdyPsOp7eeTmdfS31iEOnugee+RWCDqpvD
         hF+DT71v3kOf1U6AtVGEGBhnAnpk5Cv9ESy+V2tNGIDsnizaFOFaDCQ7AlEY+QCYuwRJ
         R2vUPq8W6yl+gLTn5XZ0wHI9D2J9Ju69n8Fnir8w/mUOrZyXB3l/hi810mgn3zTOwHVq
         bMgJM0Dfo7z8LQf9FnTTaIBGV3b63GJ5yJfiaf84ZIAtSrRgYjUNwDog+Rd2QwXW4y1n
         3jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734170500; x=1734775300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6iJmqCbGDdzurGz1nq3IkvqP7Qanek/ZA/cXhzDn70=;
        b=jogOP07H3t3pZtZzs3Of76TazxnSpTvR6KL+C/4jUNAcbGb6LNFhwqaHeZI584QbNS
         DuXc2nLzscIyYt6Zu6vgo8jSQlvMhNCkLLNfco/YLv7uTc09/tyEr8eNG8CVFF6GOrXc
         9q/viW5g2rhMJ2msbbcZatOG0dPHmVi3Uf3f5bUPH4/gzmLiDL56QanpsAhX2K4cDlgV
         /tIsjR0Is32XMWricnWLW0SSQGbjoZuQ8fD2+shb8yc3vF0i8sSzBzMaA/WEPiohGH94
         xLCCS64IhehSj63Z5Egcf8ziu+RXuA6R129D7c8GWgZAP8cebvxKYUoi6ydWyUR3tAJG
         7yXQ==
X-Gm-Message-State: AOJu0YzuKXyyArevTlfqLF/2Y2UGQ5Z0zp20X+EiG4ZZ4c+lgksQQoWt
	J6NINEhtqgBLx1EFUk44DomKS2ba4rDhyPqoOnnZNC2pfh5MVfZU1Xbi42p8RiYvM2HUtYJkTIn
	YaS/I4lO72/3YsDr6+bilUy3XNwaL/bDWZaLkpQ==
X-Gm-Gg: ASbGnctgd0+PFRO6U3v3WjdeZzGMgLmKkVpZAPDeoq8YsxxQTWj7Y3zngv9NeejvGXp
	QwX5vHNIrWxQv5PlHa4+buMCvfL5ZyF0qMzTd+70I070E0Tr5T90QmijYafysJgCZcy5zv8E=
X-Google-Smtp-Source: AGHT+IHO7/jmhkLsHDBV3zjlqLwhzO6luE30zeMTItXQRQKMazsXibRYrA6dzCFh5ymyTKClcwpgIAZ6Isq71zlxAg0=
X-Received: by 2002:a05:6122:2a05:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-518ca251874mr5900037e0c.4.1734170500545; Sat, 14 Dec 2024
 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145925.077514874@linuxfoundation.org>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 15:31:29 +0530
Message-ID: <CA+G9fYtcVtLEWtv3N1e0jtycdSomHEZ8+LV0k-P8weZUnX10dg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Dec 2024 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 602e3159e817475bec9784ba359147d8351e90c2
* git describe: v6.12.4-468-g602e3159e817
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.4-468-g602e3159e817

## Test Regressions (compared to v6.12.3-147-g91ba615b0f09)

## Metric Regressions (compared to v6.12.3-147-g91ba615b0f09)

## Test Fixes (compared to v6.12.3-147-g91ba615b0f09)

## Metric Fixes (compared to v6.12.3-147-g91ba615b0f09)

## Test result summary
total: 115288, pass: 93226, fail: 3813, skip: 18249, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 54 total, 54 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 24 total, 23 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
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
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
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

