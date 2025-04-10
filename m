Return-Path: <stable+bounces-132071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E518A83C9E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7973517FA1C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD6204F80;
	Thu, 10 Apr 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLhY6sF3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51952054E3
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273045; cv=none; b=YTtp1/8hmsisiMjMQxxq29FkEUTgOnGsnCXsNGynM/F/ea0aeNGee7snMD7OktUUe+cYSAfgIx5Z46v2w2hlBML+CXYHfjOqdLx9DqnHO5gtL63uBL/W4RLaPb6HAFxMWz9Po9Vetwlbo8ZUdE/zy7c4O6HykSSwXn6oUKxO0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273045; c=relaxed/simple;
	bh=ZLcmmENHK9I78N/ZoLIYuu5eIALMt9hcSonTzDWpags=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKgIeFEXZmOFlCaH9A+TJ1Az/6bvBHCtCGlV6y5DyjJiGsw4Yj+3XFhOM1UW4JcYWBGnC6GVvSbNU7gHTvdIsO/wA9hkWAb7/TsBlt577mrdipk1L3SzzV//az6XlEYuQS/KhQu1SVNaZEl300wEWewDxjR+618nUR7MDbuVTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLhY6sF3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5240a432462so553735e0c.1
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744273042; x=1744877842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz2/30ujTnM2RywGQJtfm+6zAc4LPWg0AjzlYlcqIsI=;
        b=XLhY6sF3of6Mt0uOtcLbcm/oOu7ZQkYkK/ep07Mkt3cHvB88j0ekFaEHpA0xw/vfwL
         OCU1WmNlzH81NRxGKjJtaG5QisXu2GKYDFvHy8r82uiSjRuVOf6NxcFnr7aDIHRT7NWc
         q5HKUQSON7NAPWFS5o7k3Z2l1ln6Ua7rQyu+2F5VBOkkXyKTOZuZQEHhi+AfCBo0K+Tm
         MTeAG43A2QWDKQw/r2DJi/Oqh6QS+zXIf2hRFlBh9NeUr5URVUJiieBHhLTYrEOTe07K
         eVFBIb6Q3jeTE5qpRzlhr9aIJYTipIb0kZZP4E/vXtH+kTtnbDA+SJjU51ddGWVW9xpB
         6BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744273042; x=1744877842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz2/30ujTnM2RywGQJtfm+6zAc4LPWg0AjzlYlcqIsI=;
        b=Iv3y5MCshs+RP+SDsmmLhDNP3vobJruv0iwLqrblMfsDsBh7exAs4qGnTVUS+yl6F+
         R2YPiR5AaOzhXfUI2CRcWy8MX2PqxVMfgCLJ2y3Hnu7jmSZwCkCtmeeCSiVS3WGd42U7
         mY2SQIVlnASKRkoR9cJ5M+/icuAqvFiMqgGwfvyjb2sj7QSymsbIdCwaSQIgZHA7EbPB
         DOZ0CCqGF//SqkPxHv7VcmcbdWQevBytTJlMRaADWIXE03MMqet1n/P/DgrZidSEkUrg
         u++TO+DbQwMxalYSjbxwVz+uEEC/xEyIJlY+wgId67TI0kV8xLYvd1yGLZYuRMA+uvrk
         qeUw==
X-Gm-Message-State: AOJu0Yy5S5iAEiw0if2+XgioFCLJrX32XMveaMQNEJRVB2f98A1O7G8J
	ZwMPK37k04f8tnWAMXHXx9CcjzmQYzJfNQoavmJh5Duo52NjFSN+YEZ8VLtEXccPAM+/oR57S9y
	vitScnYvEGhxv47LdOmiltLPSpjtHNPivYJ0Ivg==
X-Gm-Gg: ASbGnctYATTRWQ6cE1OnQejt2tRnYv/OsrW/bIkVN67yqTEopgYiXJ/guXZIMpiHkuj
	F/T/AZoij4+QqIpPnh1SjTp32AvRlCkAJ+VjTor9h8UZ2y1PoImT8YAOa90V6BOXftDgEBvPNHW
	ghKfqBg9usSJbxNMgZl31yqTBhYBcpycvNPhV+aS/2p28LwJT6LpgetOk=
X-Google-Smtp-Source: AGHT+IHPpFYAe6A+1jMMPXw0/yyYAd7u/uou13jq78+PmrhjxYftImbCHegQjV348L5FGWikiPaVIFeeK7u2FWPsIDQ=
X-Received: by 2002:a05:6122:490c:b0:523:dbd5:4e7f with SMTP id
 71dfb90a1353d-527b5e9ff0cmr1050942e0c.3.1744273042466; Thu, 10 Apr 2025
 01:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115832.610030955@linuxfoundation.org>
In-Reply-To: <20250409115832.610030955@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Apr 2025 13:47:10 +0530
X-Gm-Features: ATxdqUG_owECl_MM0l9MR7VxhK156lg-AbsNKBugatEKoiMadE4h0QstB6tsPA8
Message-ID: <CA+G9fYsuLSobC2_MAHsr_JQtSwPEzhWJ4CjKavnBkmbn82Wo2w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/205] 6.1.134-rc2 review
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

On Wed, 9 Apr 2025 at 17:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.134-rc2.gz
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
* kernel: 6.1.134-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b0bb7355f83e01b7f94937c29b088febc825ec39
* git describe: v6.1.133-206-gb0bb7355f83e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
33-206-gb0bb7355f83e

## Test Regressions (compared to v6.1.131-221-g819efe388d47)

## Metric Regressions (compared to v6.1.131-221-g819efe388d47)

## Test Fixes (compared to v6.1.131-221-g819efe388d47)

## Metric Fixes (compared to v6.1.131-221-g819efe388d47)

## Test result summary
total: 86727, pass: 65519, fail: 4647, skip: 16211, xfail: 350

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 133 passed, 2 failed
* arm64: 43 total, 42 passed, 1 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 29 passed, 3 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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

