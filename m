Return-Path: <stable+bounces-158527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA12AE7F0E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C961899598
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369B29ACF1;
	Wed, 25 Jun 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiGP9DgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF95291C31
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847000; cv=none; b=hP20vX2N+UQU3k7Mz+1XnYB8f1q5MOIMiMeAHrS0KiNPWjU1R/X/7VpLWFiYuL1AHgIajqnITMV0rPadz01XmJlJ7gT6erwAEQW8uIzwgAu8I9tpvy7ykzhUCnHbQYbvNNZlHScM9e0oKhsr1xssuPNYFnZuWciDQTdPLrHbheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847000; c=relaxed/simple;
	bh=sLOlO6Ct98dqJEhk/xCShrWRV5yesUPYrAQDpxALhR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXWVNVROnzpfLQnLm+Sc3ffD169nhR7Hqooc8g0Est4izdQARcasfApJaf/B5kTQjLZlew+y4ahhUaZSUqpkTCKmRY1bILiGsVk+TD44f2PY0Pp2xE+FKx9fcY7An1SZBQnvo9Mv6r+t8guzlD/YNwbVIoltXkltsT93zQeUVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiGP9DgZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3121aed2435so1732268a91.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846998; x=1751451798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lov9+Zjt7YEZlzXRaxLC1dZ0shHTHM8AduhB9Li5azE=;
        b=xiGP9DgZC2SU9JfhZYywZ1eNvzpqic6ftLKPCEFNO7uTNt9K9BAD7j4vc90tOHjId0
         g35L5FOgQyC1v67IbBTqcsDbmCrirG9/E55NrlJ9WhtDGps96sK8UcC2J0ydvSOWeYCD
         TIs5XVJDjVA/DKX7ThZw4vqYKg0VdXMt1aDBhxG/vdDqcvRrG6/AOQjUpegPF1fc+U1w
         fHr6C3vSBrDkWg702Xi4SIzNKVlTtYdqGyk23FVPOtLioOEd1cKnhHIOF9v8eQm2WaWi
         q6Tk0/Lh158M60g7ULZheL2c7oHs3Zd9owEOV/lZ0EaWBBLXrkL5T9JTkk5wPgd8Fvb4
         MH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846998; x=1751451798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lov9+Zjt7YEZlzXRaxLC1dZ0shHTHM8AduhB9Li5azE=;
        b=ahWa+4RjYVeN8dAMbPmHbeTjWAtzPcDLYgcoYa9fWttyI6pJTvx54wzA3KWBcBv9tD
         h8TXcYZE2AUrL8MCyhbR0kwNwlrNu9ogk5c5N10noSRH4huPB5yFfIY0KwFI21aWpA0I
         kWahUPEDgc7RIGj0QJTN85rCh+WprjVC9dx9GXk1wmxd/NhWcsRGk3iNbYNjdx58hMTJ
         18KBECl1Ipc2611NpvhgtI0Sc1A7Vd7Q+a8Ni75KjFd9fBP9Kb4Ggybrdu4W3E6fB6cq
         TD7QdAOWwZEgAtctyuEnN8BksNzvGP7F3synAl5uM+y9LKZUyovvN3tupuB0CgJPXrQO
         ttGQ==
X-Gm-Message-State: AOJu0YwzzqvKdVNq/XglDbTH1C8u/rmreXiNcqx7hE4uuuyWfIejxdDx
	xcpJ8/sYwCaLukHzwXu+VoxEqvl51Chm1w95om2lWTxtSyzLgIrLEZ+UnRYtlrqYR4AotcImQW6
	xDq4AtF5UFnyxxqbLlN92MCL543EMM8IEgRkq4HoTfQ==
X-Gm-Gg: ASbGncvcmpEVlrCcyRkKi8MhCebIkNmQjrgLii+6N5dr0gayq8L1kh+mIh+jEHyCjqR
	x/R7kJmZdm2ts0ZV5a23ci+BanQ0LqY1CGRZnewhADqnZKA5+T+P0RcMX9eldSKsTF+eyN5AxLz
	U1Zfnwn6u29MWJsDursNb4Ph/JY59l0uCvRHyaBiEYRyJkxvmomQgzzYpHB/BcLWni17Aqok/I7
	KIk
X-Google-Smtp-Source: AGHT+IH8cFi7RC794dO0rUm/Wn+Xr5iwFFDk6akyxaGbFcCJoypTD1oROTeezbQ4/XAXXAvVlHuTWvMZwirdDT+JzDc=
X-Received: by 2002:a17:90b:2c85:b0:30e:8c5d:8ed with SMTP id
 98e67ed59e1d1-315f2671f79mr3611427a91.19.1750846998623; Wed, 25 Jun 2025
 03:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624121426.466976226@linuxfoundation.org>
In-Reply-To: <20250624121426.466976226@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 15:53:07 +0530
X-Gm-Features: Ac12FXzbsG8H9f0gjBaNzcKx6GHqgVhEAS62P31OdpnQXr-HJ4E-WlndR7XAnXE
Message-ID: <CA+G9fYuQBPF6C1oJLWrrcjvn6FNqjh0oxcJqJNxe85XtrDNSjA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
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

On Tue, 24 Jun 2025 at 18:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.35-rc2.gz
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
* kernel: 6.12.35-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7ea56ae300ce5b67804c356ef4c7dbac6b00241b
* git describe: v6.12.34-414-g7ea56ae300ce
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.34-414-g7ea56ae300ce

## Test Regressions (compared to v6.12.32-538-g519e0647630e)

## Metric Regressions (compared to v6.12.32-538-g519e0647630e)

## Test Fixes (compared to v6.12.32-538-g519e0647630e)

## Metric Fixes (compared to v6.12.32-538-g519e0647630e)

## Test result summary
total: 218983, pass: 198252, fail: 5262, skip: 15116, xfail: 353

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 134 passed, 2 failed, 3 skipped
* arm64: 57 total, 46 passed, 0 failed, 11 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 21 passed, 2 failed, 2 skipped
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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

