Return-Path: <stable+bounces-139429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BAAA68EB
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B14984F35
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A95149C4A;
	Fri,  2 May 2025 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLHmnzWY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B9AD24
	for <stable@vger.kernel.org>; Fri,  2 May 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154840; cv=none; b=cPeKZriDOSKzlfypom4VYTL9WcsJrhe27A6sFKatzUF+lw3TSktAN0vcetLwe55rXpcEi8gQObLsodcfTVOBIXjubztPC44VURE349dWwzXdlXPLAjqa74NSgQdZBWaRjgI3Ub1tD/cNuwqwVCFjN0u3b/7Y/gwBDz6vjKyD1ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154840; c=relaxed/simple;
	bh=k014ZJbH75IUGNzcKan/4aMX4Vyu4OdVx2CeRFJVYBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSdWl0zv2AZECNff4rDwRcNxO4/PNUsqYeGCN/Q0sBwoqgD9yn4E3LNs2+GPopuAXeIXaGIlnB7I1FvyjRiCYsrzaoQ3iT5rwFCO5agKE1YS8I7sK/DjiXvgNd+GepGj/WoRtNynVxKTJq8Y5y1muwt8Nu9U7ek4LbhE4ozFz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLHmnzWY; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86fea8329cdso935005241.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746154838; x=1746759638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1PS2t78B9gRb11lwrL4pK1GOwhHxlzwV1Gq8BXdwiE=;
        b=bLHmnzWYNJ5cgtZsC8UgXjTcZtOpnffTTsnmoheY4PxSfNdHm8dZQFbkIdFHn7KXgX
         ckHEp8PM2I7YBeC43dKV+oJDY06vlcPNWMFg5+pEzxu4JyY/O0k1PTGTdU+sMzImlw/0
         nFZXwLd+/Z7eN7lzsROJloCZ3kUwUukmTfp4dcWsQq9k68B+XGRG9rgpQXDmOLN5bP6n
         m9pdc8RG82LL65oerhAiG7rqUgdlwr0yH8njLJZJ3L3wyl9y4yjCyc+wcydpSiAdZB2X
         xvFjqFeHPzV841Va0qEDqYUJk4l17saAfVBiwad+bWCaiamb2rxJXxP57TIMMoYdGsMR
         808Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746154838; x=1746759638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1PS2t78B9gRb11lwrL4pK1GOwhHxlzwV1Gq8BXdwiE=;
        b=wV5rVSzWJSVLDTm2p4sdtpmuIRAEOOEB9OpXkaYFfDr80KlGQmQH6Cp8TlX0Zg7OGF
         P3GEH5sS+j21bgxLTcwSl3e5RPEX9RhiVJJkXo83z9sRf2xjo/NYpNMGtoBhqml2ffR5
         wo240tOwjpG2y/GKTmqneh8foWaTvy3bnaQQ0SZM/9B3jw0Xrsv+6zUebAMpEJviXPGL
         H7M8XSTR1pUdqPQ7ITltJDygxT6SG2QC6ld9VGDBKfbtrz8lh4roxRe8tl/DzzdhUaTm
         D+ND8CImC1JIf8UuaBOjCTltpnxC5tGnz29/2cjHCgl5tJAYy13zCTjb38BzgDr1schP
         zP2w==
X-Gm-Message-State: AOJu0YyA14pAEjfaQTpJ6uTtNJ9VsyRkSMLm977nz+ZypxnkIxVSp2Te
	ANpyUhq1l0WiBHUaVqZxcDrQGEjfyeHXHZB3GodlxbfBo30L2LQe4q9UBR4YvqEFK9oWrAz/dh0
	u4L9z3O3Fj6sFH1zENi7c0OVdm4zN0bR5cq2CTQ==
X-Gm-Gg: ASbGncuOg1CXJ4DFRXMWhlzdl6TfiBnhOxdr9I6D2bigCcE3wfJzyPw+lx5HmuTMmsd
	lV8phdJGIrcX6K6bkjhIkFcd6YYIsqEsVTIF0d5NOLfvwuYdswsIiXcmJQtmLhPJF3Ty8hH84CZ
	2LBrt7EcZ3Sp6+iMjArSPQ
X-Google-Smtp-Source: AGHT+IHsQ+ZrjY6oIE0XSqfawtONm4Cg81QK/t6x6nKs+OCH8QN16AU1JWurJr1ac3yBsFJ8xkTE9tDgQap1phpcUF8=
X-Received: by 2002:a05:6102:568f:b0:4bf:fb80:9429 with SMTP id
 ada2fe7eead31-4dafb4d27fbmr920149137.4.1746154838008; Thu, 01 May 2025
 20:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501080849.930068482@linuxfoundation.org>
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 2 May 2025 08:30:26 +0530
X-Gm-Features: ATxdqUEdManDFupEFITMpo_qfwatk-GhR4p-JJ_CteENcdibb633rUkIsBaJKj4
Message-ID: <CA+G9fYvmRr7yXeKFxRK86X5LK0htT3fb=hQVVsLsvfvzVrG0dQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
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

On Thu, 1 May 2025 at 13:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 May 2025 08:08:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.136-rc2.gz
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
* kernel: 6.1.136-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cc42c3189901bed8becc7b8d66d81bc863c10f75
* git describe: v6.1.134-451-gcc42c3189901
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
34-451-gcc42c3189901

## Test Regressions (compared to v6.1.134-292-gb8b5da130779)

## Metric Regressions (compared to v6.1.134-292-gb8b5da130779)

## Test Fixes (compared to v6.1.134-292-gb8b5da130779)

## Metric Fixes (compared to v6.1.134-292-gb8b5da130779)

## Test result summary
total: 117508, pass: 93952, fail: 5350, skip: 17734, xfail: 472

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 27 total, 20 passed, 7 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 32 passed, 3 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
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

