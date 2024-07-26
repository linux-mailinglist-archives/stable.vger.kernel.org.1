Return-Path: <stable+bounces-61913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44593D7B7
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C3282320
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221917D379;
	Fri, 26 Jul 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWjjHrQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F117D35F
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015319; cv=none; b=HdYBUuy/CrLZ7g004dh+Yjf4a+JOOyt+m94m8YvKTJWA+thTJ2VByQmWFSlE+JPQnj7h7owtfythJl4wjuxS5dbU1OSZp+VJTzWxCBwdcfg1ilyfywddrNrkb3OZp5cYn4WDp2TnTvi7n5a+t7Ccu3nfc930c3jUm6/FMDz1ksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015319; c=relaxed/simple;
	bh=umFRODgqfL2wwFCbNOhhOUXnZ3p5JF/AfwUxGRT2PwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4WURRbNCep23hFj/fzFCS4pdkpUMUSETB4bQMuQobuhnjTVd5rG8AGFMjOmlOpcdr+/SybdLmiVNlRIRW24R5DcnnKWy22jXz9sauti5MKYwQNKpFROv7A5ojelpEKjBwOasMq40kpHDUvsVSnJyBQC+KUiFh/CC+IrV2BIpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SWjjHrQ8; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-492a8333cb1so704289137.3
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722015317; x=1722620117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rmt7Th55qF8UK1cZPsKKvc1veoEjIw9kwV6u+0sda0s=;
        b=SWjjHrQ8f0i6vGjxu/Hw1ATvGB1e/vuCZ1gCmpWfv+EBxmLMeRZSK+5Vj23qCYt4nP
         LN5O0xh8xv8ok93P+9toyvi3ximDLd5LRICpyNLUkd8JpcrgkwRzRAvAVENADq1OiBgX
         4R9NtnHNkIOilHxTNr1zUN1gkDab3xhn7Krs3yVhmoFFH6LqaOr2IxflqUCTjO+0pvqP
         v5/lL5xyUTtxns67SR7ILdeAD8iNrIbSnomYD/d4MAzQt/eNstZZtjaijRm12/ycIulM
         Ly22wiITfi/iWtVU8LkQlZJ5qquBV5I5lt+qesIw0WhgMWBa6Uj/U/kmnCbhU8DHKeRT
         cCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015317; x=1722620117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rmt7Th55qF8UK1cZPsKKvc1veoEjIw9kwV6u+0sda0s=;
        b=QxLGPfoSz8dD6fz5cEqLYrzXVbKDM8Y3M0vT3S6Aa4i0lKGyxEhgpCvFALy/1st4pZ
         FdA0ZW2409OZ8nTmdeeL1iPOuoN2XuYBiue8aqpIkjZ5AV0C53rCDf1lQiT4A1MyyxcR
         azc13K7XF33GDJjRJqJg27VNBimAe1Z7Qts11gz3kxE7A4tZsllB1NzJSbkV8sudHTUk
         IMAnJf+36adGquk1nCTzuTcoLmjUnWqlIbsbQV09oY1lDGaG6iY21BxT4rdRpHp/trMz
         CuUFS5BTdvmew8RzZrEAJtHMR+fHCP170I440vPJTRQgRi20sWlzxFMgdnvMoYLId/0/
         dqpw==
X-Gm-Message-State: AOJu0Yw4du66U1tjcKg6A4SmbYxhzk+JYP8FDUWPlj93RgXlsvn1vUjG
	nJjdsaeDeHuzM5ih8LCDIk+C7KtHQb4vdONxocJTth8o0rjRgDIjpiUYmA02kDuut07t3SIC9uw
	mgp06+6dUM7Oxq1eSU821OcR0YoEyKocgFK1nZw==
X-Google-Smtp-Source: AGHT+IEvmTlba4BH+71ZAButXHtz6N8ddRW1U+8AFcX9FeDtloChwP1hzISXt1SxmhhiWmEj5zsaz2PxoEseY5I7yzU=
X-Received: by 2002:a05:6102:c12:b0:493:e66f:6bac with SMTP id
 ada2fe7eead31-493fa81b6e8mr507454137.11.1722015316653; Fri, 26 Jul 2024
 10:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.029052310@linuxfoundation.org>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:05:05 +0530
Message-ID: <CA+G9fYu_mdKF5hF3q=nENbLRGcsn=ZSYErHXcd-SY=Ow9TvXPg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
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

On Thu, 25 Jul 2024 at 20:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.102-rc1.gz
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
* kernel: 6.1.102-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dc0e6d516f8a1f3321312ba50a0750559f9dc526
* git describe: v6.1.101-14-gdc0e6d516f8a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
01-14-gdc0e6d516f8a

## Test Regressions (compared to v6.1.100-106-gef20ea3e5a9f)

## Metric Regressions (compared to v6.1.100-106-gef20ea3e5a9f)

## Test Fixes (compared to v6.1.100-106-gef20ea3e5a9f)

## Metric Fixes (compared to v6.1.100-106-gef20ea3e5a9f)

## Test result summary
total: 47994, pass: 37873, fail: 907, skip: 9174, xfail: 40

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-openat2
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kunit
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

