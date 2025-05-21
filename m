Return-Path: <stable+bounces-145831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9035ABF477
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4ED81BC0205
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86925F780;
	Wed, 21 May 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rF2tkgVu"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C301E87B
	for <stable@vger.kernel.org>; Wed, 21 May 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831183; cv=none; b=MwoRml+KBxvQBCUmGmTql2xPUY9Kb5OneJmDEXwI+4QimMpKqnVK9WXWMdPlWWqyN2vicrZN5eyJVmeazZT3Fmzttav12N85uzyUKekGykQiUcaWfud+4x/7TMuR/Q6YqbMyuPz6GsucDqHMpiCn6rLlp7oi5jqDf4AfwNfB+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831183; c=relaxed/simple;
	bh=Ol3SYDgilOShW+o1WFJFj1f/kRmxH278HUmeGyLC5/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE1R3//c1Gsm4xRdrJ/lzyCE7KUfoLBQoFPoKkGYbBR1/iw1e6hGsNeoBXUOiG3/2lYdfoN+HjkjnK4bFO+z3SW/qflvsh27zKzv+OPbGtQvw+Ez4+Y/Dm71jk1MdemPEJGR1krj7WZ9Sty/QG3Vl/hFLXdNR0OHUWlCAarLvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rF2tkgVu; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e14dd8abdaso1763097137.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747831180; x=1748435980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKupp8/Fu+Q/fXSbeFEKEO8KyFhdMTZOQBPN0yqnh3Y=;
        b=rF2tkgVuNlIGuPbc10/0hEZqnKW4titCvFI6AbVnRVo0N9UypDAkK4/velMZ//mW1L
         P8WV5RDPUMM2vK+mwq1HnIMCA652uMWPkoz5uE+OXKTVTepI60TzXJe8rcbJZF/IF6D+
         8Hmy4kk8IB0FGhuh/selvU6m73tjlTLUZ57jL1ul0Absx7aUpUl0Hn2+nxeF4dX++AvN
         mjfloecx8P6cn9706sVE5BjDsdM7uLZVcNBtXzRVBV5CRpi++uXZx9Cg46HxhSSVnQCG
         lJ0A1ix6o0le7u2khXMxJNCVwavT1I2fOFGIMAnr+XqO+2iL1GypFpO8CeRdfayf9JI2
         kMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831180; x=1748435980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKupp8/Fu+Q/fXSbeFEKEO8KyFhdMTZOQBPN0yqnh3Y=;
        b=cG04dOi3Dr+my3QVLJiq2u66LbvVOWllIitQyQ9vwpTi7WEge+qoTFoS0O06Mx+OYQ
         QulARODxTNlwKeFr6YzkyBn55/P5xfTKomha7fpRoakmaiYMHKV4SJoFyrxSIqNiDJdS
         9sSK+JJDwxTxxvhwXzgAypontuTQbG+8SLN8kFN/cHQGgUnBvdCwtK4XPQusfszRz3zP
         jYUBeida8N55T0FunS+TEONdS0FT48aCdV+jEXVa6oJPKA21C61wFFOzfgRRk2wfSvMy
         IsglGsk7HJ0VZ4NoAaoO5FrrPQapQ5MOifQO/H6Juvq4fr/7ezOIXuEBU68jiXvYL9EI
         V1DQ==
X-Gm-Message-State: AOJu0Ywf+kYfyEFYdNXE7BPhvpnoEfjgg2iKE08dLbSuheO9cxhwVmWc
	zupLwlNuoCb5XjIL4GbMTbVfYltyZ4RO4RoLYKQ5JejDugaBvldM8j34dYWgK8OVgRg9onQYf4k
	b9VDy3CfGuqoohUjgY/Mtrn4zhTXJYcgSRmmY7lyMhA==
X-Gm-Gg: ASbGncvHPMOqSKqy5HOSIF+7xhyY9eotZmxOyf6O+aV+jkApU0V91eEpYx+Eltzxn1B
	EWZBzsEl33/MjFFe+G3vvbJjS2yJDAQ5+w65XM3isFTU8qrc9q5Wd9tef+kpDxQTR3OLUxJAqjm
	lUB6Xsbmq7zVNciufr7ftgczjHlyvLCWgqncF7TOvlsSqh33ztywPbjtR9Z8tekp/ICw==
X-Google-Smtp-Source: AGHT+IG+EBWrQ9MFOPu2a53gcTca8fxH4g1iNDKit/DXzpT0QHLt9dTkLmNlN0hCtGWDXBUx7uKx49arXcF4HdQ2RIE=
X-Received: by 2002:a05:6102:1593:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4e049d5c1ecmr20292772137.7.1747831180485; Wed, 21 May 2025
 05:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125753.836407405@linuxfoundation.org>
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 May 2025 18:09:29 +0530
X-Gm-Features: AX0GCFu6fLUPi2-ImLv8oVSMddRz_eslZAtfN0laHVarrqF2gfvQcjhr5N7sgAI
Message-ID: <CA+G9fYtpC-uB9wCf=ZYRDF-YrP5WGMU1Y-4TcR+PKjNa97o5Ug@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
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

On Tue, 20 May 2025 at 19:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.184 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.184-rc1.gz
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
* kernel: 5.15.184-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ba6ee53cdfadb92bab1c005dfb67a4397a8a7219
* git describe: v5.15.183-60-gba6ee53cdfad
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.183-60-gba6ee53cdfad

## Test Regressions (compared to v5.15.182-55-g5aa355897d1b)

## Metric Regressions (compared to v5.15.182-55-g5aa355897d1b)

## Test Fixes (compared to v5.15.182-55-g5aa355897d1b)

## Metric Fixes (compared to v5.15.182-55-g5aa355897d1b)

## Test result summary
total: 60301, pass: 46648, fail: 2204, skip: 11039, xfail: 410

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

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

