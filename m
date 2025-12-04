Return-Path: <stable+bounces-199981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF33CA3158
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1900F300A736
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608F335BAD;
	Thu,  4 Dec 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4GcK4nw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDD230BDF
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841825; cv=none; b=jFs9K0hPCFsfjDkSLffYxZJzYdJWJne0zYjAFedOAK5nb2vCTjzc20zFCNpEw5FQI48PimlO7tL7J4XJFQ+SoGwrweBoPYQAM1pet+Ri0XEE27ghYA3giIpR5UPN7egXBkbEgbyvoNHqoGIh+feWIEJHsyXDou7uKHC0IrIrVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841825; c=relaxed/simple;
	bh=paEnSubsEM1IlX4Fx8BGns84K+slnryUulk62N9zV60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHndoKjpazzR46e63h92QW2gzcwIwXS00W+4qVRMFJeZE8tb41iACdpds6iM+EA4FuLaihDjYWevmFKJj6k94ASjyT2StbIr+fX0bUPugwiS9f+FQDYnmK+5OIwM3Mb32iKBW8DNhx+CJ4gZgI6/wyXVHrJ84izNsWH88HbXtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4GcK4nw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2953e415b27so8408055ad.2
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764841821; x=1765446621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xQCdKxxIzlGDW/pad8bOskN9bo38tocSPqJ0Sm/bO4=;
        b=i4GcK4nwphXF6/XKRxdBNqX37UFyGSTJCOtVzD+i8E8bbOfcY3t/2wsIiK4cKTG5dj
         oMiiKgw2DUGJyfZlVcjqy9mKxGsgAV1X10WGS8PQBoNUARG9NseTHVA+c8HevcuCDBYr
         ToIX4DaqoaxFmBoX3jQin0t61SKOAuhcC/ruFYqh7flHxeSu/i+HQS0dElIzHBIl6Pv+
         sX3V8LcFckTk0YS1eEBzhLWT1cTVRx3SSMPGR+h0CPqMVTPTFARt7jKY8vfbKX+e690z
         BWHUqicy9cNwWe2/OykqXwj7C9E/TxgZZwJ5h/J7zlinEXUAQVQVs9hUSPjYqXJzlRzG
         2nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841821; x=1765446621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xQCdKxxIzlGDW/pad8bOskN9bo38tocSPqJ0Sm/bO4=;
        b=NqJrwcqreip4j9v4/WZrxdEKyubJW4Mpqje6Dv+flBDRH11JTQYLQXLa66djAcncDy
         Fo31r8OPsKErXGkpFkrpAv8FEz0bSFCQ8O2cNTHfElciU9TLAdsBHIOqpcv9FDMLGTqF
         aLT8EebzXD4eWhyr2Vtxkioh/qjQLrvkf7B7iubrBhL80SZYylZsDpGizrGgwHlezC9I
         /1tw4pOiLOiszGv/UpsiXvUzmOKlRS0FFb9IVDD2i9RJG4oLFCUBj6mbkJ2NzpQVl1Hp
         I+LvHaGRaAkEwU9CvbK/+3yOxE0hi9ZbBCJDRpuqLf43+9UBZI+sTJLYsH4I33u0JHQy
         F+mw==
X-Gm-Message-State: AOJu0YyriGfMKJ7raqrl7iCnAlvAd2/k3h5BxwMxwSJeegCvSdbbOm7r
	fJ+4fAHK2EYua0Cdbi20bHUNHVd1nn37K3hqVj3UnAZDhGql23e+Gcn6nx4ApLacgEfqyzg0ESt
	Gu0R0h5ukLiiEcD6r0+afjmLxOCd3ahJAEdrinbH06Q==
X-Gm-Gg: ASbGncvSbsSVQ0m1FcSJdj+0gfZAIfYta9s1+aLlM2NrsG6MRF+ungrOHvHrh0Hpfje
	X+hBFrgJhtl2i4fLtQWCYQs5hC3g5SIX2eIxzaL1GoZsRZnhnodlq0jFXdQ8uMdbVaDPkjkyqR0
	9m1L9VVSfzSqmFUj04WH/KghaL1Gb1sQQhpIa4F0PWj1yTtebUvVIf5pDX55NPqCkVAMNn7hlH2
	Ibz1GVvzBQmt6SFqs+Gsox379ErAdlO+caatLQ/U+BswO+E6r6dIhuM6o3NCUgcespCBRAnWdui
	dpXzEsIUkTlYLUQPBZalfvFSER24
X-Google-Smtp-Source: AGHT+IH/MuYsoPNwU3yqMF6glHHl/rGRMPC2ltPLwOqcYJ5es3WIKFs3Nw4GaKMGeFuySPMsiNHb6ZwWyb4dnOc4Mvw=
X-Received: by 2002:a05:693c:394b:b0:2a4:3592:cf74 with SMTP id
 5a478bee46e88-2aba42fe05bmr1983435eec.24.1764841820649; Thu, 04 Dec 2025
 01:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Dec 2025 15:20:08 +0530
X-Gm-Features: AWmQ_blZgGVdRz_MNdiWwG7ey1yZJ5o0Yjq-9lxTgtnmoqzXUZJVXJa_tbKBRbc
Message-ID: <CA+G9fYv+7+8r7Gqv2y9LTs+JOzzOP6sCsNZ_3oz=EzgZUkKN7g@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 at 21:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.11-rc1.gz
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
* kernel: 6.17.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c434a9350a1d08ea6dff3ed87c9a6104e0641ecf
* git describe: v6.17.10-147-gc434a9350a1d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.10-147-gc434a9350a1d

## Test Regressions (compared to v6.17.9-177-g6c8c6a34f518)

## Metric Regressions (compared to v6.17.9-177-g6c8c6a34f518)

## Test Fixes (compared to v6.17.9-177-g6c8c6a34f518)

## Metric Fixes (compared to v6.17.9-177-g6c8c6a34f518)

## Test result summary
total: 123996, pass: 104773, fail: 4209, skip: 15014, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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

