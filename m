Return-Path: <stable+bounces-144514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29666AB850A
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C415A9E765A
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA53298C18;
	Thu, 15 May 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9iT7Uyg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776F298C03
	for <stable@vger.kernel.org>; Thu, 15 May 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308685; cv=none; b=oYVf+YH090HK+uyVr22afTH7Qn9AidEtXuvi5/8c6jRTVeVgEb9GQguNKyPfLM1+2znyr6i1H5T5W3PMv3lpMRdbpnakFOWTG0BTHvTOlbzn4srNv3J/rxYBIogB08C4eyviMNGXwuo51TTYFDA+k+CJFhHGvXwFU47TISPG/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308685; c=relaxed/simple;
	bh=qsRW3vbR+o2v/z4yaSsJHASPkM4MT6K6sx7naxQV6xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm7WX0+V7bQjnUrRWY2NPwWEs6sSx+Ne1mOb2am8y0sGjn639ZSZKfqDCR0fVopEJKUj4j0DnGQu8bi1T8RmzMaDrNwscMnTy6b8xsQrd741cfVoKizAOXWKWr7qDeFamiWJ9crn0tDsMquV7djB484ZnMTARL/Q9DO/UNHXyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9iT7Uyg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f54e4f2989so18396426d6.1
        for <stable@vger.kernel.org>; Thu, 15 May 2025 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747308681; x=1747913481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxEWoY+VW2OrREQvVPjH1SD5TqWAf78OGCNTGWqFpeE=;
        b=m9iT7UygszdsHwDDlGWLTO5DU2vH7hMDLIzQJYQJYUk9tkn+nO3Sxlv5pZ1q3W2F3M
         w1bu4pD9gFkKaLKoSGRIVI/7Qw1Qp5clTjE74X3SQvL64o0Wd2odzRTmxb6Y481vyCMv
         wNdsnP5H93+gvqOdVQl++QnT2ufx4bACnUxJFYkhhkKeJO+zbj5ixhZkKEWOqVbx0zIQ
         K8bMYkJGRToDeVf3L9xSsAsrk4W1YnAeckbe1VRc4AIgDMjUU9RYc8xNvNra7DyVMXnS
         Sj2Ixhsbv1Bx/xlaN+WHU9P9Ow3OIUEAb4Y8zox2Jg653h7NnNoX8BYf7EiomsRQ384K
         f+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308681; x=1747913481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxEWoY+VW2OrREQvVPjH1SD5TqWAf78OGCNTGWqFpeE=;
        b=Ri59xYnehZdiEMDdTJgv34UfixGYQi/JYQxL3B2ZT0T1FbywKv4oZlAuF7zT/cCife
         l+/wbWqaPHLVAievQE2z3JvcaiGbJc4V2Odl5eCJwLPTD3b1IkYdRED5G0IY1VSLI2SJ
         Uq37QinaBWv4alMZ4vFRIqPIOZnM+PRx9rUUPTatzgCO/qwuKBFuTU0RGqS/x6HiM/Fn
         s6cXvhylzQuAKLbC4c3/boKRQtFgtG5tENowdDwuqmiHaQvwTCu1dTLUzpNmvYcI94Wb
         P5K1pfYvAGJu3uPHWFN/3IbKAHkorRAjTUSTEtQPqRa+1Lp5Hbk5icDLjzm6aZzNbjqw
         72uw==
X-Gm-Message-State: AOJu0YyOl7UJlynV0GnHScB0D61wkDKGiJcNFjZFTYyhzLwn7QaMEY5d
	HUKLeyne8MXT5iNAGq+r3wSX23YYch2mKisnR7gxCKzL8qNnrBGHUcWfKWo4v7PXnmzNDr/M5B+
	MmikHht2DGWtLgRHWMoEJ8+gC5gZMQ+PNAcVbIQ==
X-Gm-Gg: ASbGncvnlQhOXiJekYBM/dIiWpUaZjc5BNzkEAr+KMC0I+afwZnHvSxoPQF+bIZJaVZ
	+RiwG7EwKkHcQ3A1/oIy7yw5CiAa4OybLeUKLBqy814BbRFnBg3un9S1zCBJqe72h+dZ8ElO44l
	rvqr+Y/EUkb0pfNNWW9FLqanoQvRRdDgk=
X-Google-Smtp-Source: AGHT+IEYL78mW5V6f0UBCMXnpjVvkevNNxPGw6FlGXVKZwLAMco8C8nI+r279fEjTclloL0MN9zBtHMl8DPg+40OrXo=
X-Received: by 2002:ad4:5946:0:b0:6f2:d45c:4a25 with SMTP id
 6a1803df08f44-6f8a4c3fa83mr29897206d6.41.1747308681497; Thu, 15 May 2025
 04:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514125614.705014741@linuxfoundation.org>
In-Reply-To: <20250514125614.705014741@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 May 2025 12:31:09 +0100
X-Gm-Features: AX0GCFtHAVDNN5xGothkArj26zibJHO1rUyFkXyYkWWTeICME1w7EGNWEafl5bk
Message-ID: <CA+G9fYt0zWzReEkj2Ys4GPrAg+Q43Ph4TxNW+yS2w_NtfZXZ6A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/96] 6.1.139-rc2 review
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

On Wed, 14 May 2025 at 14:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.139-rc2.gz
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
* kernel: 6.1.139-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 03bf4e168bff87c44b4f1102d5c743a14e71c564
* git describe: v6.1.138-97-g03bf4e168bff
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
38-97-g03bf4e168bff

## Test Regressions (compared to v6.1.136-100-g7b2996f52bc8)

## Metric Regressions (compared to v6.1.136-100-g7b2996f52bc8)

## Test Fixes (compared to v6.1.136-100-g7b2996f52bc8)

## Metric Fixes (compared to v6.1.136-100-g7b2996f52bc8)

## Test result summary
total: 98968, pass: 79519, fail: 3690, skip: 15516, xfail: 243

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 25 total, 19 passed, 6 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 31 passed, 2 failed

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
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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

