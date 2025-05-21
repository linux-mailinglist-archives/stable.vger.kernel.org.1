Return-Path: <stable+bounces-145804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1279DABF217
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A54D8C679A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413425F78C;
	Wed, 21 May 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4d35caX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB511241682
	for <stable@vger.kernel.org>; Wed, 21 May 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824590; cv=none; b=slvuUseAzziBgVY0izzAaVbQu3JGyKU2+Z6y2Dd0+Y8dIyl2RNmQPWPKqDt9GihFFeyCeKyYDmUerB09hOlAnzo5ipn+MVTwmk2NAXcx1Wp9pdWiZn6+C6P2o9AFn+A2sxBbe99Bk6OCJq4y8SKifFXqpwfpj5nNnmcxBk3tU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824590; c=relaxed/simple;
	bh=L+PKxNtAqKz4d/PVyTJfhGDYmbcAOUZoZDkHRkgwMHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDHCSlIN3+Lvs4WCwJ1S5UCLAC+aL55u8Tmm/NLLt5oDJg5aw+T0iGniYjoSUy1JazEQMDYODGIJjSG/58q/N7QjMaf2U2AGvKk6Fyt6QMYm194vjLwk/EFLa3/taqXM1FNTfTAp+os91d56cMYbTaAM7FeFVtnffRoNFNmI4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4d35caX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso4487786e0c.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747824588; x=1748429388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY1zsqMJNQl1/s2ogWzn/IUr1JVs4jZNJPWvtMfHcCU=;
        b=Q4d35caXsyOyg9jiXMQGaxZ3coOqZb7QGQYQBzC+X2L9AonsYNHD5vd0n3lpaFC56d
         VhDdPrMQyMkj/nLBLKRrrmxXvOVdtqy7J1ijE41KkKJdAB9mGEShLaDkROC/3J8x1b3x
         gkAlnL11Fo4C0qfLYNjQRi2xOpmZRUxeNds0COvulJSio6xdtDo9dKMfbqVvIx3S8JFq
         qGShN6xUGXOis7GsWCVzWKhC45doz4f0e8VG8G8r+DW8BDWXcq4R4rHuajR1JzrQOmyl
         MpfM/jzDy10tAgea+gK4/gqhY/z+li5q2Ym5st1Ffdh4IDV/SU5Bgkk6jq+SGDks751a
         QnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824588; x=1748429388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY1zsqMJNQl1/s2ogWzn/IUr1JVs4jZNJPWvtMfHcCU=;
        b=VCd912clCoW1V8RuWNucYigWibZR9nKQ8H69pUZbWGWcAD05iJ1C9QgDUZ1eHpAx8x
         Y1trYlLv6RaMSbQpry7mNiAfWIJwy+a7M2DZt8v4lhJ9tVg+ni3Cz+AZCkF4grluVcGb
         eXlaZVcPbEqUTvMl28vAGMNIl1UgHClIY1XiIjLF1EKS3UV6BEvkG4tskWv75yqrpQOG
         w5rvqA4DPvQq2+qYZBoonSnfWCu7zGF0e20Vn9eSnuUea3qEnaBCSbK+m6Ij3mfG7oqW
         Ey8vHw0dOW+LvIYHGgFroHvVXXCfPAZtiUWURgKNQ/lVdbYOYrNW7FzIW1nEZYUi7fLv
         yCrA==
X-Gm-Message-State: AOJu0Yzs+U5eH8tWLWYntMRD8OlWVBYvBFm7z/f+EjPylRpR67n22hGW
	Xl10MWXoJhiMKVOE3cyaB3t3q/qmkJeloAToELtSXFAR9D58exFXwnq7q6nKrZ81ujH8lYloLV5
	uees7tGQei1MkLqf1prf9kH83r9lHVlD74OgkVcWTkQZB1vqmochTjuo=
X-Gm-Gg: ASbGncuQu/yPSwbxy3n1RJ5O9QTuicR8UnyM7AcZfscHJuCvYO1xRF25v+W30MnKeIR
	scDqxz1BMg8tLDCTDO6J5Tggs9tWH27d8tQM/a3Ja3LckbSly6M+p2MWIW1438Kyu4Ys9n8E4et
	/dUSGAOCEqDvgPlbgdxMjOjme7Y8QSk4CgA9s2GVs8yGlXS9aU288pPOhfmg6G1bXe4Q==
X-Google-Smtp-Source: AGHT+IHloLMePp6sWWE4Xo3eQmWI+t21lVM52+Q9AX1coxhLbG/AnIIKZEse9z+JfaZFjoBTA+i/FaH8xl/qzjJqxj4=
X-Received: by 2002:a05:6122:1d48:b0:526:2210:5b68 with SMTP id
 71dfb90a1353d-52dba80aa18mr19788493e0c.4.1747824576947; Wed, 21 May 2025
 03:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125810.036375422@linuxfoundation.org>
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 May 2025 16:19:25 +0530
X-Gm-Features: AX0GCFu4hsLKVjzcZWhZSqXry2FJY-ngT98VU3nXK6UsgeB5lVCyUWpJ4CkM7NA
Message-ID: <CA+G9fYt_T6x8RHUwNRUvr7qkwq1OYz4v9EE63UyjGCG+1M27+Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
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

On Tue, 20 May 2025 at 19:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.30-rc1.gz
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
* kernel: 6.12.30-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 28ceb2ca31640d8e004148ecaeeafb40c699d02b
* git describe: v6.12.29-144-g28ceb2ca3164
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.29-144-g28ceb2ca3164

## Test Regressions (compared to v6.12.28-185-gf7cb35cbafc5)

## Metric Regressions (compared to v6.12.28-185-gf7cb35cbafc5)

## Test Fixes (compared to v6.12.28-185-gf7cb35cbafc5)

## Metric Fixes (compared to v6.12.28-185-gf7cb35cbafc5)

## Test result summary
total: 232613, pass: 208395, fail: 5026, skip: 18571, xfail: 621

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 55 passed, 1 failed, 1 skipped
* i386: 18 total, 16 passed, 2 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 42 passed, 7 failed

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
* ltp-ipc
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

