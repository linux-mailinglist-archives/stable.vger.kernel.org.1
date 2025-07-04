Return-Path: <stable+bounces-160193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F953AF9323
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC20D1CA5C49
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F42D949F;
	Fri,  4 Jul 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOBHUPHo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0C2D8DB1
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633491; cv=none; b=JV++ur4qwjybzNyka3vhJ9ZLDBGJkMlPRYrCl5eUaWg2puRTCnLsoiyHH/p8ZWYmwZU9vmfHAWe6iIchJB6CSbskfjiPbzm/o3qXj83ONCUVn8SsxMaqt3ijCi3CVD9wbUq9YQP+fQX6FzgoJrLOKyXi4Jgy7Ab4FyDjFNFDtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633491; c=relaxed/simple;
	bh=y/kbYTbXwrVINRik7S+tkYYYL4C0iQ3Fnbn38ah7j78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogo7wwJ+LHe/1LTussBZ+06hYVS7F26Dd2fIGhHJOJILG9c3KQUjvBamF9HLP5d/pFNOU4gvOtTcnkOiaem3XGWfVGtQU292/laxRHR4hwsvyzDumHgUpKVDLt0wYsUzO3+UP16owda/Oa+Os+4w1IzR44bmAU6zdV/Whc8Ruqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BOBHUPHo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313a188174fso1768600a91.1
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751633489; x=1752238289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzewkNlMN96GiZVrIk9GUqEzXm0VfOX3d4MoVRPtoWg=;
        b=BOBHUPHohcOmwqD3lpL91IFHXZq9BRR6/A7AwFtIBuJFkHnK9AFZxWwvG/6FVNOW6g
         JD1aUrwBZmJpXralxYdmH211XNqQSvKHPc0bIhawO6PUWfJYVR52X/c5kiNHMu2ktoCo
         xtnr3h/Rx4Uuj1sQzsuK9h35rtH/hD82eDRuORadtLOvXV1HrE2kP5JXxvCM8lbG5h8V
         FNTyVQjNexFjFVpPfYNmTLQxTKZR5GbEhLXc+a3nQVNVDg7D5Qa9kwdqHUHP4ysgjCWC
         xYv5x8XG2oMtNLKU1BJxHJCYgN0nx3RHGywcZ6tf4Tpa45e4cXv1UgQpLtBUiHlNUhBR
         SffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633489; x=1752238289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzewkNlMN96GiZVrIk9GUqEzXm0VfOX3d4MoVRPtoWg=;
        b=R+aHLyGPpQWh9sMaJv5GAoeL5ZryBkA+D5A8tGx5AxUGe17Lj75gjk2DAbCHiNG1I7
         OMvAp+L3T5/HXzZGayZ+wJfgbTjpWFlfXG/c3/LWVFkaZYJp6CgggBdYiQ8sBebEHXgM
         GG2X+TXrbueGf9p1re5uTPE+LY8fWkuL5dXdj3XsPjKmChJ2IyQ3mZ++JSO6RiaGchWY
         UEiVv+keoaCu1v9IY5YzIBzA+CuMGGUmG5M8zKTYaNCASyTEv9DfsftjAmCYmHCBUqgJ
         aQf1jwLfd+TNZKqGRSU6JltcdeqKyFUX4X3UDAVmGGi6XJJgrOpBBciEQqDcIMghS7oG
         EOWA==
X-Gm-Message-State: AOJu0YwryqwXqinh66uAK32/tIPbgYt5VumbQjnq32Hc3ij2PXUZhr1u
	jlIEznAEIUyA8rioVqx+Bp/a9NRJ1QriuVfwDiRwS1fKVpf0s31VJBsODnht5dIKfqbdDFeeTSi
	DlpbHGq9UfxUhV28Ko4eBQ48bnh8lQYaU54I9WIyhwQ==
X-Gm-Gg: ASbGnctboqY2oAjdz7jcvzNb0iSF3FMAmCbzTjKI6MKQP3+hwHjAWW73+HuY+9aeF+E
	V5KSDWzY6QMwz/t4UE9dU8XNh1XERC3tPrhb5cBO73LWHPDMLSctHJ/GdWeUo+lb2Bd1j2KhD0j
	tbkN0KJ1p8AJjKD7/iN6iRLWYRiC5/7kEfswvEMxyveJsnC+xNt4VJ35o0r8cM+ljjQfYvtYbvf
	sAS
X-Google-Smtp-Source: AGHT+IE+dot2yMfM7G74tn6pBGrGMaT/wjPZVf/oo+P5hOer7D8qLs0cW1oLs4J2BeGO40uaVcVvqD1O9Z/H7hvNNJA=
X-Received: by 2002:a17:90b:3a05:b0:311:b5ac:6f7d with SMTP id
 98e67ed59e1d1-31aab854e04mr3898911a91.6.1751633489174; Fri, 04 Jul 2025
 05:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703143955.956569535@linuxfoundation.org>
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Jul 2025 18:21:16 +0530
X-Gm-Features: Ac12FXxkoI9c359mtmkiGWYxMRrw6eIFnOiBA7xCFWZuNBOvGtFp14r2FRTFehc
Message-ID: <CA+G9fYv2CYDZGm_MC0F3pr8ia2E93epOoLOAoLn724YL6R8YCw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/218] 6.12.36-rc1 review
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

On Thu, 3 Jul 2025 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.36 release.
> There are 218 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.36-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 08de5e8741606608ca5489679ec1604bb7f3d777
* git describe: v6.12.35-219-g08de5e874160
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.35-219-g08de5e874160

## Test Regressions (compared to v6.12.34-414-g7ea56ae300ce)

## Metric Regressions (compared to v6.12.34-414-g7ea56ae300ce)

## Test Fixes (compared to v6.12.34-414-g7ea56ae300ce)

## Metric Fixes (compared to v6.12.34-414-g7ea56ae300ce)

## Test result summary
total: 254325, pass: 232385, fail: 5932, skip: 15566, xfail: 442

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 55 passed, 0 failed, 2 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 0 failed, 1 skipped

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
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
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

