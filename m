Return-Path: <stable+bounces-119635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E40A458B6
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD983AA97A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D901E1DF3;
	Wed, 26 Feb 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q22NNPjU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AB258CF3
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559556; cv=none; b=IQ/HYfGbZAptJhPsQFkZ/iTWgyXGmIoeZlZbh9JGPkyJ9iKgWKnEpVLCtUD/y3rOHeFhRGe4OS0IMBnJ1cpg4hIxy2wNB3A+561Vc/Z4XwL8skmuJV9rhb3tnvXHCOu25PpdaY3xy5Eyq0MsUHMx2kYECv33juQtorY8GPqLdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559556; c=relaxed/simple;
	bh=UENyK6nf1sqkzjJ9uKX6c6MBHZH8oAEzlZrBi/B3ayE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5gq192as5pzqXKHTO1w9ZTXXEA3vR7D4YPZCTTW4vl14itlsrS9DP6MFF3HB3t69ZIjaCV4JZAfsQiW9FUwlE2+ZyBqhBNNSHf9qAgMTicdas/+xiMVgP6vJzpekabPUGZn/TSxQ+rwiaL65f4aQlQxErTctXL/vrYeXSSe1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q22NNPjU; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4bbbaef28a5so2132988137.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 00:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740559553; x=1741164353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaQtfK1ctsYhz+bqcOdbV6RX9cgXfU4dyosRcNQlmSM=;
        b=q22NNPjUYiUNh3+5VP7QaJdCWnz2v/HPNSozkb2uEcTJB9mN3HeZwms0uInzxbd1Mr
         Dlfn6jete5W/wwfR9jkouWcsj5c+fS/M7AOXWuoQbLqU7XpUDmQhMLOmwN46ANUnf9Mp
         V7ImPWrf8UQE7gEeiW7XtadTmV9Hzwr0Ez5aAbLwj3t2naWRF2jWr/KJu5Z6emXgrsEQ
         Q8VgxCcBh8vaiPPy7XHMO/KCAmYHpJX9Pq7oDMZxUGYwulLWkMHLZJ/j2veMw5xiHqlB
         7rbOmVuYyqzmPYFlzexmH6vrzK6B/J41yIBZwvrYNd4qiRDLAaetgAfs10ExPDB5RmVR
         7dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559553; x=1741164353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaQtfK1ctsYhz+bqcOdbV6RX9cgXfU4dyosRcNQlmSM=;
        b=FIu3AfYHI0DRW9dVpyoG7rTLQCIf+RQLOn+Zoc9J940//Wc+PuzTdxiDscNgHoG50g
         ch0WWsz1EhpHnJ7tqkK1m4dPAjSc7vdv2sDLqBMgK/xdkUkOvtdBrUqy1ON7b7siVByK
         OaXBwLJoUiSmYxQcVYgyVGbdqTtipwmYoyzRpMC9T/5EPPQje88PHJZtp64lEUTZwwIs
         c1q0fabf/hoIyV8Pbp4f6ckSc5H5lhFMKxDKuP9Ej4HZTxgGxD/nRCuxAvqsC61tr0Fo
         wEq47SaiX0ubNKs1pmDiEWw4zFSEnljOhDnsRBM+ylcSvKJl3F9v2uzacJuWS4383fDZ
         sE+w==
X-Gm-Message-State: AOJu0Yywp0PQqY+GOhgyC9PF+hTy7gt3f07FjR57RkJUIwKecsHWi4Ik
	BnCYuPAloDBzvrLqtsIkuvbJad4zYg2ErLdNR6xRCln4qs5L4f5+J3a+vxLjMkookhpClmVOzNm
	xwwP52zBpGMmtl3X4O6sQbPNJjxY1w+Ppmi2J9A==
X-Gm-Gg: ASbGncuRytwbv/KqIn58qfMbDL3kbALfBiAsnY1ni0c5v7Cqmxs5h8cSDCW483q82OD
	pSaK4mYXhQrRrmTzyPaZ1Z2MovLV59r/uvD695P32k+SVUk+KBWisvfw/o434IaXcxr0+uW/DOp
	HhdwI4caSBYaQUblEuYdg9XScDRyxtIYFZZ/OncPAC
X-Google-Smtp-Source: AGHT+IHlTWHmx/PR+pAg6v0zjV4nAI7mL/7+NhbjnE90ZG7dJ3J/mJSI9AvKQBNoL98EdaRoCDlUqdYVK0tIYP4I298=
X-Received: by 2002:a05:6102:41a2:b0:4af:deaf:f891 with SMTP id
 ada2fe7eead31-4c00ad0bf53mr3858141137.4.1740559553235; Wed, 26 Feb 2025
 00:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225064750.953124108@linuxfoundation.org>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Feb 2025 14:15:40 +0530
X-Gm-Features: AQ5f1JrJY6iKijR8inxTrQ5QwIT5PIXgHcc5gyMzNTXahEI-z93knUfSfRHeZtA
Message-ID: <CA+G9fYvH8nowEkm9td-HZi0C67i=uChzHC7BDt6AhQFNGGDJbw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
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

On Tue, 25 Feb 2025 at 12:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1a0f764e17e372bfc20424b8e79ca2594782924c
* git describe: v6.13.3-397-g1a0f764e17e3
* test details:
https://staging.qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/bui=
ld/v6.13.3-397-g1a0f764e17e3/

## Test Regressions (compared to 6.13.4)

## Metric Regressions (compared to 6.13.4)

## Test Fixes (compared to 6.13.4)

## Metric Fixes (compared to 6.13.4)

## Test result summary
total: 125711, pass: 102863, fail: 4064, skip: 18784, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 21 total, 20 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
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

