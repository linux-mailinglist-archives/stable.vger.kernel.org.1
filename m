Return-Path: <stable+bounces-61072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CA93A6BC
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A90281A35
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086F1581F4;
	Tue, 23 Jul 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pobr9MNx"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AD15821E
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759892; cv=none; b=UKW+vg3OZHrrEScxCK30o17l8MEYo1ByBWPr0r19RGOKckyhhwlOf3HoCyfo227Wsrs2hoajYted/a4fMzVlLn6Cqf7CPL/d190OR/uo7jz3u7B06wsY+h7ZbwZztxD3BZgkNDLsu4cIu7GvgCrl3dQgNhQIPUySQuwJh321cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759892; c=relaxed/simple;
	bh=Ge3WxrotjNrzL00XKRfbP/uNGGHiypyVh6q5S9j+248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Au1IILhLgzDDVH/D6eGORBKfKygkw517w07KjbEFIcT5r3F7CUBUzsXGOJ9AVv2pT5D3Jzc9qAbDzSAhFZQSsxWH3Xky9bm3wTWUeGBOtKQ79bSKf0ONiBOGRlsQetrqC5hE6chNOMXlNXyqRb6/JmlUz6JKBxv+/GBTKmFwmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pobr9MNx; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928e347ac5so763489137.3
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721759889; x=1722364689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipr0XcShgfcsyciYV8wkZgCrL02KTwzXnz9fJeg/Kzg=;
        b=Pobr9MNxjrmXPixvA29418nVy7xXP0NBOmBBraSXf49UXu/KqLalRNoWlHuj+VELY8
         jQvMSbqeB1CyZm3qOmebmvvPqVjZwxqHXok/7CjIm5fot0GFhVUYgQY1Dm4A0M6BB20r
         w2KFgTamPAexK6nJUJ579eK5/k9JOr+I7QQIbHqushgErlu8IZfAHJhymsPIRR198jIX
         VxK+GMtRue32UQedPkBgQCNbS6pEazfzauPkrIDvi3aNkidZ3tPHINtpSsQ98yr3AS/F
         fj7+cwfH1ZhCoIed500+9yV+PVNmVW5uJm/uqchvFy2VUF60nGdd4dHr0MuFNkPuy1jA
         j7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759889; x=1722364689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipr0XcShgfcsyciYV8wkZgCrL02KTwzXnz9fJeg/Kzg=;
        b=aONumS/y5sFQCMJIb7Ym+y/bzWzfvOjDwZ6Bni95sLUYQ5EuSfcwj/zKixEVBha62W
         d0CiEZxAYUVt3VELADiTp5AR0IHhTYee+x1FejZgiQafx/Pofs5zgRVcuOoKhGbKqgbR
         BJEgBcTF8uvMAFGnWmRgklFkHQGxdUbxkXwFCjaD3LtBig+/ParVh1HIcEefAF9wP8hd
         iz5Y3Q36R1ZC8sSjoaSpAQJKHu70Xqk1co1bUMVDfzPPSg0HrTbAvf+8PB6EV0ZZwreC
         02UDepG/NBaTbWa2KIBkdxN8TlwACu5hwFnR9US0CWvtW67mWq9Bnk/5nRF7gOenAXGi
         1aGg==
X-Gm-Message-State: AOJu0YwzSI2f5P28LhOHZAx2wwb+SQUg+d0ya55C7/OZzQjBxyTdYE9q
	VeSnXBtT8QVeqJdtSrP1Qb1ptFvXtN+yt7TIOIMGXXpbn95Pa9hKbeIB9c7zik6k4yWqIfBbudA
	krRhMAx7P03WEn21qROUZK2rY7gR0zYVGMRsJNw==
X-Google-Smtp-Source: AGHT+IGjStf1+gKYAOcRXL39zVgs/kvEBXG3k+m9YVlM9M6yee3F29SJBU/geneXmlXSl3KAjzJKDaacNuqpOml7o7o=
X-Received: by 2002:a05:6102:524c:b0:48f:95cd:e601 with SMTP id
 ada2fe7eead31-49283f764a1mr7019041137.25.1721759889383; Tue, 23 Jul 2024
 11:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723122838.406690588@linuxfoundation.org>
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jul 2024 00:07:57 +0530
Message-ID: <CA+G9fYs46y-MYAGFLMPuot1u_xu1Tm8y++MJ=f-sfBv485iw-g@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
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

On Tue, 23 Jul 2024 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 12:28:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.1-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.1-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e89ad42bf499062626c95bde62ab0b51d8d9e658
* git describe: v6.10-12-ge89ad42bf499
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
-12-ge89ad42bf499

## Test Regressions (compared to v6.10)

## Metric Regressions (compared to v6.10)

## Test Fixes (compared to v6.10)

## Metric Fixes (compared to v6.10)

## Test result summary
total: 197889, pass: 173134, fail: 2878, skip: 21877, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

