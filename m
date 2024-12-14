Return-Path: <stable+bounces-104186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8769F1E3D
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3274167C28
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4D186294;
	Sat, 14 Dec 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpE7uABj"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8A16DEB3
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734175867; cv=none; b=Z3V6W7e0dc2fY67Vdh8+hCbdBSeRfHw4R02GCxO1Ze3LMibNA9gDndPJMiXEl5XvyqGqXQT00U+1jtl048iHZaHEPLrQMbco//PzHmmJqUxfT9rw+/75+njHJMTeqdFWZf7UJ2DA4XXnTs80DFpLj+fFnUm6+A56BnzGe6aFO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734175867; c=relaxed/simple;
	bh=43KipVF2Pw9z9cbEu8cqB5aRcp1OXj1CCOXfSA/uzxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxTu0s746hWpeZx3cmrbsPAVNftlQREL+LoWgl1YvdHSBDG+A6vacg480sgB2wJPduDSPaVGopGq2FTFHW897IHUz332BTvOZ/8eYPHYpp6t6Hzw1NkRMoyDcS8V/smHSHQE5VkvXaqQCuQLco7KsExFyCEvNLxriPNaRX5AkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpE7uABj; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afe2a1849bso1510333137.3
        for <stable@vger.kernel.org>; Sat, 14 Dec 2024 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734175865; x=1734780665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wINs/DBTC9EuYVviwDfcguB0KxOhCrZVx41yGsRcNl4=;
        b=bpE7uABj+TNsTfSCvSlWunO66JtgwhhCPDxD5gIxsTFVhf+amrwZowE3kQcMPgIOww
         bYg8DDH7qZH080YdeDBAX4bgHoKjmVizMtOtJnqqkyGz+LbseCblkQaer1hlb59js5Eg
         ZmqSqD964c4MpzeM5CUvxjxgGL5mK4MCWNnvnQ6YbKyEDlOPXplSa+H4jea5u0WOFTrQ
         OyDwhLoDXJSgAkAnrMLXOLjkStENTwpwkklnOnLEQROQ3ebNbBfejgh5z8qmYcWIShxw
         IgpK9Cj8LoVOk9cIldbbgq8OMF2RICW2AL3uwyMDa6fBaTYjkYa1dKur22Gx1Mg3HV0u
         9rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734175865; x=1734780665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wINs/DBTC9EuYVviwDfcguB0KxOhCrZVx41yGsRcNl4=;
        b=OZ8q5jt1Wfc4CKm78OkUvumDsu1/MF77T+kVJvEW0IlEKhCt1defENSQYFxLdTOyeX
         1ywe6erwjtNKghlOUXSxI+mxMnV3RjsQFA3Yj3936hp0njF5e6kk2ve0qK+4Zl71lQNI
         tXtpVn8K1MRxFutFc/uxiHXZpSDWV7stjdWWWJkUeLQZysEkkoMPMnqWSsN+zHvKzVEU
         QE8LoSheuQUE5RoQlvPPO/fziEVCUZ8D1uXhy7ebKHMS12qo56Ubszx7udCf43ePv+z+
         Ux0Yjpck9Ib0syAK3syRVjelD+kXzvLCmv+3DnHpTaouDxNrVV6ZM8jHvlpu2cllbvpP
         Sv6A==
X-Gm-Message-State: AOJu0YzgaAmrvgrkGP9dabFU+xhC1YhelEZCYBJ+0fV8uhZDlnWj59xr
	ffHhOWpElv+SVQlGcaYursN972z8QDGIyD8hye3xIzFzDe8OcvYUZhdg3OpTl6Y0tYMEPwQccq9
	HWnpIahTcqpZXiioM5a/VtXyWBUHDSLEyjIoTJQ==
X-Gm-Gg: ASbGncubQMywn9/YGwXIRuESvRAmd6MI3vYm0EZyHuVUm3STKiB/FvWBa4dOekQz6WM
	RvNQMCPVO4SrLciOja+FwGfke9r/uHdM2YlK23C3bHQU1kX8bwxZffUtePDpWCWB3LEiWZ5E=
X-Google-Smtp-Source: AGHT+IEwYSeSwQnKxUnjb0hVBvPLVZybDxCStSvKb6yannr0dzdp2jqI6+z05U/J+Az5fkcBa9FGHXcxZrNj9a0n4ck=
X-Received: by 2002:a05:6102:54a8:b0:4b1:1eb5:8ee5 with SMTP id
 ada2fe7eead31-4b25db8d319mr6446493137.25.1734175865046; Sat, 14 Dec 2024
 03:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145847.112340475@linuxfoundation.org>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 17:00:53 +0530
Message-ID: <CA+G9fYvcGBDRDqY7KzM_RrsY+G2n-nj9S5GT6vKYn+MYxNGmGg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
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

On Fri, 13 Dec 2024 at 20:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.287-rc2.gz
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
* kernel: 5.4.287-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce5516b3ce83b6b8b6f21d8b972e509420b4b551
* git describe: v5.4.286-317-gce5516b3ce83
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
86-317-gce5516b3ce83

## Test Regressions (compared to v5.4.285-68-gc655052e5fd8)

## Metric Regressions (compared to v5.4.285-68-gc655052e5fd8)

## Test Fixes (compared to v5.4.285-68-gc655052e5fd8)

## Metric Fixes (compared to v5.4.285-68-gc655052e5fd8)

## Test result summary
total: 53416, pass: 36691, fail: 3492, skip: 13211, xfail: 22

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 32 total, 30 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 28 passed, 0 failed

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

