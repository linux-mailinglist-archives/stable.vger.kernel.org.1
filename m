Return-Path: <stable+bounces-182930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E62BB0454
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AF71940855
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4C46B5;
	Wed,  1 Oct 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbsonAAm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B106221540
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320343; cv=none; b=LrPwZGNIBaueqDujpMr4eHcRHKC+aQx2UKjk+cgCpFF3Uh6n+nyfy6h5SA46fqoOd0j2us+6kpvCukDWtS5Y6dfglTT8W/DtFKrC3C/GVNuV2xAI++Iloo583MgVhV0vafM1hEtCTbmXWinF/XoOPLNqU+PJ9ZmjGCGF/wRI/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320343; c=relaxed/simple;
	bh=O6vKQTz1eSAv1FTPz9NfRzTKW63iKa3lMOgQwx7nkZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS1D62eou6ZuwFgcMkehvU3wVoQs4xUhOnGqZYNA5PsQZhBMjtXi4m7OSOe2l8uyqz1j+USM+Mp5hk3GAt2dsE5RuGEwr0Lp2rH9GCCDMlkPSh7Hp5XPyOo/BGcZFv0JPk2DCXj3FBDh1SMlATNppPZv+IvU8epNgjnJtQK8UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbsonAAm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27edcbbe7bfso77041475ad.0
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759320341; x=1759925141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg1GfvybsU3QtTfMcHFEjVchBGwucMjxi7dlwU4m9P0=;
        b=GbsonAAm4IlBqzKMZAMp8NDVc7M2QwYAyLBwQmRGkfyW+1b7KB9ZErGiXAFncxWFY3
         2KxesV0pn9qjtJO75gKC+VZwjvsoMTE+s4Dz1dmQbt9pPw9HvgOpGBIn9Ckrsxi14hpd
         QM7B1UGYr6MnW0lvXPo6HE4+ZaOn7mbJDNfzMl0FFScM/6b+2bhmmtwG9NxbNQEMf4a+
         bpOLUnq27obTfokj8gF39dLcqp8aL4gf2hBK4cY0Aj0AxxRe7TwIzgGDDHWsPfcrFsuB
         qBKpluvlT/jljTSyZLLdiuffHCgWQRBt8diMgRB8ZHnyLIBm6BuNMfaF9Nyd2bmLNi77
         OgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320341; x=1759925141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg1GfvybsU3QtTfMcHFEjVchBGwucMjxi7dlwU4m9P0=;
        b=bg+zOElLv6IR+fEc7Rzg8AwFhgsYwslBHQaw8KmmS3jD1v+d27q7lWjXDnKfrEr/b3
         2+degRSVoFyFZ8+47GKdDvsM0DTkniwLjlaCbcVSu+rCDG/GfUiMsOGno5P7S1j1RRdu
         RPLKgJYCyZSjUOQkE/RUeF6xiH+2ZXVhAZ3GHnSrGgXdAkvphoicTzoxFyyHzsagVgy/
         H0A9DjBUKUGPT2aHELPylyqsdN+uJlB1sCcdv+3cG2YvBT8ixkphHkHew+5NpD5ErDzC
         388NA874sYVGS51tzemexP7BZgJO3qsGmmTWYLtxptUIIb63AcrJnhRZ5QRbEQBoMoKJ
         8XQg==
X-Gm-Message-State: AOJu0YyFAo+IaFwif/R5NT1mgyT8qfSzAvH4izUe6AoSd0cPs4LA2zqP
	qnqgHaDly5f0/NByD7qgSBKiS5mvrVdAEsqiPqV8IBylA1/A2R/hqoc+UQB05mix/8zipMwnTzR
	dDoVFHGDQaMa17wizjC3E7t4uol1Ik2hz0U1+bPeUXA==
X-Gm-Gg: ASbGncvfRcODVIDV7AW0NA7qux8iMFzQMoDwrRhndZ34rE9vx6/4sPWTmb+127Ol1AE
	5gk809wGSdMArJruCw5Fr6RJcbD0AzMzJa1Ce9KxHkg7D5uamZ1gclh6Bo2VoWSOh5mNxBCpFn1
	HJANVI2Tdcw0358oveVKyUjtsn7R3FtUTa6T7+bx49npaddQtWRcChfMM6OKddV90n2jj8GkPy0
	FoKRGw7Ea8dSdt3Rw6F8AMCrPsfYaYcpR1ZCg8usoEZIvh4h2qJ2QHqN6BktL9XBu9E9jlmQsr0
	wkN+6uRLjSRjrywu2FZG+wqNEPgL21M=
X-Google-Smtp-Source: AGHT+IE+69MJlAegp6HNoWgT69FNLBCWEbG8GGLCgCE5L5FpcTX3fcSAL52w5RW24lGOU0JtgGcawYpVHiKGuzYHrGo=
X-Received: by 2002:a17:902:e78e:b0:267:6754:8fd9 with SMTP id
 d9443c01a7336-28e7f3284dcmr41559095ad.39.1759320340797; Wed, 01 Oct 2025
 05:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143827.587035735@linuxfoundation.org>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:35:29 +0530
X-Gm-Features: AS18NWA9XV18Pou9nUNt_ZdVA85rILDAsVyiyN_bBk1qQqHPGQaNRQnhWQ2ceJc
Message-ID: <CA+G9fYstR1tuG3bQ1MhE8nvqzRmg3bvd9k9xnLXtPJQOcqwUgw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 20:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.194-rc1.gz
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
* kernel: 5.15.194-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2e59a3f5f54406d7cb71d75a55df3c9ab93cab18
* git describe: v5.15.193-152-g2e59a3f5f544
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.193-152-g2e59a3f5f544

## Test Regressions (compared to v5.15.190-99-gccdfe77d4229)

## Metric Regressions (compared to v5.15.190-99-gccdfe77d4229)

## Test Fixes (compared to v5.15.190-99-gccdfe77d4229)

## Metric Fixes (compared to v5.15.190-99-gccdfe77d4229)

## Test result summary
total: 55742, pass: 45195, fail: 2492, skip: 7695, xfail: 360

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 30 total, 29 passed, 1 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
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
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

