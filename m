Return-Path: <stable+bounces-184060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF48BCF263
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A872A427B3A
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20823815B;
	Sat, 11 Oct 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fK2C+Pq8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9620B80D
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172002; cv=none; b=Vme0LSTZyIgwiEx/5W+K84u1eJXIKksQZdCVnoL4JHska1VzE2TJUEOEWAi3nEFWO5iBTF24Oyg4kIEfEjqTrSsqvMomUbAAMLnLXwG0pJFl5iypccAx/J7HuPEajHnSHIeL3W46xfiXwvK6PHv7c6ZYuFDRvEh0Uoh7vqJs134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172002; c=relaxed/simple;
	bh=swXtNkDF0FL3cU8HnGgzyI0EVBiiiSrQRFIrdvPgPTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9vS10Mw/Y8rHLp7iRG6KQJIopIdUuo8fja1VvID5kEscq15btdJMe6w3aLRmOGkyoJPn0u3EkGZixZVlDiCKmJN55vIXxsKU8PFDpSt4b48R6VNkaKzmCBQubYyy5gjDU9B6NMlCQYc1Ksqo+5x/BrgrAEZylEQM6UoyYY0Xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fK2C+Pq8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28a5b8b12a1so26526615ad.0
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760171996; x=1760776796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVXSsfvT0etGlmUWNsUkD8HWlAPhEcr1Pl7r8v1EiJ4=;
        b=fK2C+Pq8lppVyjYNh/grF4e4dUhk20P0JBHlY94vVgn+IV77DpE2XV2bcHMFcq4MN0
         6Z0J+r9WdRHQP5BrMgljVJK6/ymxVGeeelPaVieT5ipUR8LIR021Ub+ij8qbYnfNiT05
         zYHVPhIc5Ifq3C1Q95/OHUg93dgdl5J9hsZ+mcVN7Z/v/mhPZBLD89VJQKhrCoqtye5v
         1fgeOaui/1LZNbfWL5ULD8tKidgdhC/P5W4in1lulaNNOWcBPqIK0FfneRwO4Rmusoro
         1VF4IM4E+IqzhfIGklRIAb4ZOSMWh5tr0flIt8hysdUeTzpsh/cuJUS1SScXZPcLF8Pv
         AfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171996; x=1760776796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVXSsfvT0etGlmUWNsUkD8HWlAPhEcr1Pl7r8v1EiJ4=;
        b=HGLN09E4E0LoDZQxuXj335YYjW5Yw+q9ukb6icUwwZwP7/hLxk11FCC0wfCmYjZMO0
         GWSPYmNJbAZovE/mq+fjrlb/lhQCPiS6CgyNye+CsuqYtzwYmixYZUPgYdrax5B1x3dR
         lFRrhh1neC1dKBgEcxlGSX1Y1n8Wbtix8dW9q7dPocKUX9ILFn7WmY1l+frJ/mZhpOpk
         a+WKh6UOLQDcwFytPlypIRLes0mG4DjuXLOHPiUOi3ivSUrKbAllYgjPCN95QBf28anY
         ItKYidptCg5+gTl/UKfEaGQ9daE2qPpaTQRDvYqBH+bhhLqRLWe+Pd8+sH9LQjlJEzF9
         6wSQ==
X-Gm-Message-State: AOJu0YwnSQYkUkKmpd3jIA8Q1vFEDbQPVWGKb0X99HuC9Dr9vieQkjSI
	76BurLRS2NkG802LCjx4dqGUPtbwMosKkv1w6cqEVG9xcvK2faVSIdvpN/gkUl/8knrW4MKHglB
	c/Haj+M1HiSwbknM6PnkZdv43fzM8v6b+MRLhl/QRnQ==
X-Gm-Gg: ASbGncvSkwmBL4bC768y8QqpJAK/DpLZWwM/Qz+8sjpsjvKWWrcqjfxRya3DRNbuIhD
	ab4tbKFhTpt7kheEPmwCGxryO5xQ78mieLkYwPypm6WX3H+Qv0GU4veetzRzRFlxx9O5NmIzyjv
	rNx76YJysmgt7RpZMcT99YcPjaAMA+iW36VtwE58mRbNK1+OzhFwVUn4vC0LHoHhrPshU2fQ7sg
	Ij9x7rQR+Xh6t9cMbNc4aPWHs043poxHrfWp51Yv1zTGV8SPDsw9hig47B0NS0BJNU3r7oQ06/d
	az969p+4Yh9IR1QdFPVpDB7Ek+Do
X-Google-Smtp-Source: AGHT+IEWSSNNR67J2Tri1k5iIkSgRur7iBrdXo0jF5zYqoAUkAI0CEF7pto+xF3B6vHgeUJ+4fZofUvRANEko+90ns0=
X-Received: by 2002:a17:903:b4e:b0:28e:acf2:a782 with SMTP id
 d9443c01a7336-290273edf3amr155968555ad.37.1760171996152; Sat, 11 Oct 2025
 01:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131331.204964167@linuxfoundation.org>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 11 Oct 2025 14:09:44 +0530
X-Gm-Features: AS18NWD-nh6ACoVYAo2FqFeMvXPVdFpklauhx_xomL920GlPKUaJYF10ev9HgC0
Message-ID: <CA+G9fYuMpQ1bskoCuteZYUTgMyDVo5EFRePDyQov77UEvURYUA@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
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

On Fri, 10 Oct 2025 at 18:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8902adbbfd36cec55ff7b00116d287c06bda347c
* git describe: v6.17-43-g8902adbbfd36
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
-43-g8902adbbfd36

## Test Regressions (compared to v6.17-16-ge7da5b86b53d)

## Metric Regressions (compared to v6.17-16-ge7da5b86b53d)

## Test Fixes (compared to v6.17-16-ge7da5b86b53d)

## Metric Fixes (compared to v6.17-16-ge7da5b86b53d)

## Test result summary
total: 164414, pass: 138312, fail: 4644, skip: 21458, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 50 passed, 7 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

