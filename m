Return-Path: <stable+bounces-107856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E6A04130
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EDA1650D5
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6711F12F4;
	Tue,  7 Jan 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUm/5Vid"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2801E0DE2
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257847; cv=none; b=PvsaDAyMt1tw3wFC9P/dCmIHoQu3XYCC3sOVbskBfDjCw2XcMNC38oXyBPm/2sFUYNkk/P4VWaeyghzg6e8Kr//S/vbZhLgZqOerYK6ml+VwzhdW5k+hSJpGRryysc92x/W4bIvnAr7fWSmjjwzUL0zR5W4zYzd9+HfItomv/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257847; c=relaxed/simple;
	bh=sP4oWAvT//ozkGmUP0ZN4hVDx40Bvi450ckQOfqUwPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld9Ef6DVoVjekfZmCD1Yt+cR+suVet0hGjdcHBGcCFql/jvM01EKyGZTuQftzXUkaHiNwdBCq3MBOFuFGOrUd98Vokq3glu/YtmzrbcRUV1T6RNQ9SHLi6aD8YsZmv+tY14scrZh7Xct3eEmX/1vwnPvarkW14N7PLSJV2445Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUm/5Vid; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4b2c0a7ef74so8771305137.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736257843; x=1736862643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=164argy2X3LIEO31q1wNr10Ni9B3ViQtWgmng2fa1fg=;
        b=sUm/5VidoqGgLdyizpkdSm1ApWcZJaU26qiBP8fQrHa89DZNVspn1qcfvYAOLLU1WI
         GJ7fOas8Y4dg3YAL0fqGDkW94maL2BAwpJ4zehMEnT3vtPFMSFNFIPn5+Nc5BVWMBaYO
         WEybYqyLxlaZ1Q0y7airRQs64n/BU9XGUiw+jJpZnf/GiB/5dSSassFq0AmVKMapuN5Y
         xjb7TnBplVw/frlQE7+WtcuSD/9K92rP5cplCTjf/OEG3wztuKquKQwWZSsuYU/Crfli
         lFH4KlX4bqyBDZVkztLpviIfRBCGKqws5mJXv0iCbqSvS7SgoILo2ju2ROrH1PtHK05J
         pwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736257843; x=1736862643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=164argy2X3LIEO31q1wNr10Ni9B3ViQtWgmng2fa1fg=;
        b=HGh7aeSze451k3NdElPm3jgwbDzSQPrMhzqmKSd941UQZeoowK2ROv4i25K0FmYTWq
         95jL+oeBeVcHM5nCe8kO6Bhwxr1Qcd9wLAS49nVZT5LXWe+VJK++1pA3Bgb7VB3k+Fm4
         EFowrSbSA3KkTfjvcmIoLAS2KTunyrCYs+pGxSKdbpwxEHqbq9lSuzQKq4qbMMQE+GKT
         /dP0RXze4JT7q9r16l9DWDg5G+nyfOtFCzHedQOIkasjLU8XPY82Q+Ys+6E1tpg9ZnRm
         ML6OezoMoUudzVwpcvLbBq1s/6154bhxw/C+GTwi+sZO2RbfxLuG+C+jrGNyubiN5KkG
         BCkA==
X-Gm-Message-State: AOJu0YzPP8EGcuApXovHaWFDD/YPQWGIyybtuK5IhVze1x1Xu3RaLtYs
	/2z3OpfqZzg5FzehR7Da09/9Eb01S39VjHEG7iwnKZeKtgC1Iv6ejhieKBe0YXn+16kKbhaQTDY
	zc9xJcv+SzzbQVyfuQYgk4gx/4kUjJy88kZsRUQ==
X-Gm-Gg: ASbGncsx9BTtOPc9ICLfecUzyg+e1O4g0HreUUSDPlg4Bc8mlXhPG1QUHpE0hyvZ/s1
	uOL26SikqGFax3b7M2t5J6afBgWQhOSXe/4poaJI=
X-Google-Smtp-Source: AGHT+IHz+j5iVS00dGrFXWRq97XtpZ2mEIgqAwb2bx8/DzfD/TUJp7IDVfIlNsufhiZfHrvB75RSphZ3r1pe2EK4jCM=
X-Received: by 2002:a05:6102:d8a:b0:4af:c5c8:bb4c with SMTP id
 ada2fe7eead31-4b2cc3873f0mr48630403137.16.1736257842750; Tue, 07 Jan 2025
 05:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151128.686130933@linuxfoundation.org>
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 19:20:31 +0530
X-Gm-Features: AbW1kvamNNq-c6KfFtguRr11KHieKl-FClYg0LvmlYpiyBNWjOTcP7GiZthTi8g
Message-ID: <CA+G9fYt4c86Bf_+SVYL0tyafyJC6+3JcyA_vmrzSYgfmeQLuAg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/93] 5.4.289-rc1 review
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

On Mon, 6 Jan 2025 at 21:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.289 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.289-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.289-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0578e8d64d90f030b54a4ced241ec0b7f53a7c57
* git describe: v5.4.288-94-g0578e8d64d90
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
88-94-g0578e8d64d90

## Test Regressions (compared to v5.4.287-25-gb66d75b25fae)

## Metric Regressions (compared to v5.4.287-25-gb66d75b25fae)

## Test Fixes (compared to v5.4.287-25-gb66d75b25fae)

## Metric Fixes (compared to v5.4.287-25-gb66d75b25fae)

## Test result summary
total: 42887, pass: 27545, fail: 4176, skip: 11101, xfail: 65

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 136 total, 136 passed, 0 failed
* arm64: 36 total, 34 passed, 2 failed
* i386: 22 total, 16 passed, 6 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 30 total, 28 passed, 2 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
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

