Return-Path: <stable+bounces-144519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938BAB858C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D91BA312B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789F298CBB;
	Thu, 15 May 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7BFBt8T"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F9298CA3
	for <stable@vger.kernel.org>; Thu, 15 May 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310503; cv=none; b=NguWoazDNCgTbtrW/aivUaJ0W/+z2bz54lN/o5i12l4AYi9748ZDYTgMN10SMWppYgaFeov3JuFeqx/W74SStLihGGNw9tiIe6fU9hzHF74qoDPCUfRccm7C1tWN6/KkmSED7ImO3yI3TnEi3OODVeDwHl1aUhcqgbPpJWCUtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310503; c=relaxed/simple;
	bh=YDFUAr5da8o162aqbI1K22R9rw4a228pKAZsAnPOScs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVMii7JiFQg2N1bP71mmQ1NDgZ/mO8qZ8C9o+fXjrwUvGeVdItnZhfVjLs8WwZ1AdWwkeNggurIB1Qbr84eE72sv1L+bgMgGWYYUAF0yDottwKVDIM9npxFvBEfKRiSHEyEb8OlbOjAxiXDLc4eQRpAJzlKWW599OfBuJNco0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7BFBt8T; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401c43671ecso628018b6e.0
        for <stable@vger.kernel.org>; Thu, 15 May 2025 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747310500; x=1747915300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boeRSL7ymM1MdGqgj1pPiyPcUbQz9mLlHUY3utY5hEU=;
        b=D7BFBt8TBo+q3xNeq+hvcPzjlx7reYSDJVqIgh9zd5mcVyZwwpoHTDTJYEKXgsx1t7
         TMaUs8cEqVRvia7r8Z2beBCdzzm80xAWURHyhx1BLfLeqNguuTFoXio8+L3mOQqWSvVQ
         hx+oSlveYUp8q3R9/s5D/ozJ01aWQeMBxkymp8j1kvtYjXOoemeTY+4cy6H0bmUpTzw7
         fenJpxP5dk2vGcF/8sbHp0/tfaGXfDVUOXEWIUX0rnihFhVy9RhVDrJVDHMLogB/Pin+
         XDXQajhdDuNOEb2nUnuu9TC42ZWkJ88HtsbyO/p/H2/5JZ6yTfWepyL3B0xnUwXDKSXD
         oFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747310500; x=1747915300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boeRSL7ymM1MdGqgj1pPiyPcUbQz9mLlHUY3utY5hEU=;
        b=nPoDUz5eVf8nyWnBwQGvUB7dOh0lNWFqA6TUsQo6lC05f5rRw0iMEZHrJ2UJm+cj9E
         Sg9cbUAIMamrlg9uAjCnrh177/qZ8NzeUJkqbJ2jP8XgQkD5z9SJXaEY2QO7/s1N05cy
         H+HqJnm3fxa0jkoppVwjCwU0NDPRMWJQK+iCuYWMs1Mkm27r7nBwM3e1rmC/BwfVNseF
         nbQr5oSw/9ZbkekkdU2v624XXuUx9hK7mnWGnyTATIGTTc6xfTfMtG5/T8LtmWBHE4YQ
         ucJXNb2H+WpFH4jPfBxY0csecgQtnehvcsiooa+gncj0s8UAeJ6B2nsZrLdj6ewXEKUy
         OvXA==
X-Gm-Message-State: AOJu0YwR6AzskMAVgB0M3YOPFU+CPGo7gh8NTphriqZ00To3XKxakFze
	H4AZmXizvqfbnszx3KHftNIVC9HPY8HGHKIf/kAtE4HsOykpkCDwZNb6XWnif3PD5RG1CTbcgzd
	gHU2o+v/AHVP6mQtJsVDn9dyVg3PHOjp1GZGvuAi6WLGtENaskimt0g8=
X-Gm-Gg: ASbGncvOZLBGEC5ACEzx9Ja+wa0ZWXzVPnPBsZDTfjdJrSck2x+N5acWzfu/3yXp694
	PqL+Zx5cvrFzvslWpVTL3zJc+Q5tr+340TB1ocz2FBgDA5Fqx42YfJdtIiI7/Up+rsIQlhWYemg
	pf3WNkz651mMgphJsa8xWI5HbpxCksmtk=
X-Google-Smtp-Source: AGHT+IETIm65Gi5hUcwxtimmfoRGo6nkKMju25zlIOBCd5ID+1gOQSmy0JIluClS2ct7U0vOo+cZjdB0S4KBMfqMcnw=
X-Received: by 2002:a05:6808:ec6:b0:3f8:bbf3:3a18 with SMTP id
 5614622812f47-404cd76d68dmr1460990b6e.16.1747310500195; Thu, 15 May 2025
 05:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514125617.240903002@linuxfoundation.org>
In-Reply-To: <20250514125617.240903002@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 May 2025 13:01:28 +0100
X-Gm-Features: AX0GCFs0FjaKtpOVN9UBOrrKADANFFyaTrwzsOpaTJ31mj22VjLsndjuWf_epr8
Message-ID: <CA+G9fYuFATLbTkum_UhZt6u6O=E58ZfkYnPPJUn2f503WgPWAA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc2 review
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

On Wed, 14 May 2025 at 14:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.91 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.91-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.91-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 477cfead3566d334186ce439760204bf288d2769
* git describe: v6.6.90-114-g477cfead3566
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
0-114-g477cfead3566

## Test Regressions (compared to v6.6.89-130-ga7b3b5860e08)

## Metric Regressions (compared to v6.6.89-130-ga7b3b5860e08)

## Test Fixes (compared to v6.6.89-130-ga7b3b5860e08)

## Metric Fixes (compared to v6.6.89-130-ga7b3b5860e08)

## Test result summary
total: 134900, pass: 111038, fail: 5345, skip: 17956, xfail: 561

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 27 total, 20 passed, 7 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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
* kselftest-mm
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

