Return-Path: <stable+bounces-198169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183DC9E060
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 08:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB17934A90F
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0A29BDA4;
	Wed,  3 Dec 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ot9JMckg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251929D260
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764746114; cv=none; b=WjP1WqtwrBsrvzPyLILaDn2x+vIKZWsYeQQ1Vwfw2TbFx6p6KVU27zFmeH3me8sBshfvVNfKdO2CXFVa2Sd1alTYPSjJFGWK0uPIbXDk8Gi0doarKBfpFWQH7S5b1nxXhUTMKAwVzEMh4V1J+tKeJgu8eNY0LODah76tw+hzTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764746114; c=relaxed/simple;
	bh=hhYimVu64Jhzi0NwwVUu2hKUQTleXM0vwg56OYBPvRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ9GsLmwvlZzGCQWTN0yk0I4mJNjg6qKJ4tnsaN8hJEpdYafkmBI96ERGaAQWfh88Pbq9vpGlLqPTPDvdgD7icOsb02Z7VWl/j+Vc6smMr/gxYCcv0t4Seu2ExVR0oI3v4tzwTeeX4b6WKkkrkdFCz6c22yUoY5TvMoi4HwjwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ot9JMckg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bddba676613so4003767a12.2
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 23:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764746111; x=1765350911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuaqeRiXB2RSHvZmjA8H7YeoSS8/bN+aXc/eV8k0YL4=;
        b=ot9JMckgdkHmqAqZuSYMALYDk4zogolTrWiY0MM+ckGda4MWcu5gB77ZRAf4b2orvG
         ogBr3OYk7jg3LsmGjSLk9XtgJDaU30fibNc+MR8dk783ZPiBT+ChdsK1m+dlWkqHxxId
         kC0w8Gz3pnMGLNzAQ9TvXieY3y7ZDBNx07qgQzMrV+ayTGbCcXvPfiTZORsIywYUX+12
         cUHyhetdcpPScA44WAZ6Po/DUs/YNF+eIKd7N2osh0V+4bIIY347e2xht5vpHA70lmmv
         I6Q559BNIXaXfx2R75NxICmQIJvgzXOpg2yrxQI6lJu3SGUrTJr5RzA7nhUyX4MDmRBk
         s95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764746111; x=1765350911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuaqeRiXB2RSHvZmjA8H7YeoSS8/bN+aXc/eV8k0YL4=;
        b=kkTl9iUgBhVVe0HcL90Fei6VnZg2Ce83ABFgUQZAEJ4lE0Mm1PCiCTrLf+BwX3qatY
         5XYjlpF+EqVODrlJKi0A3JyHR56QG0AsmUGf8pcoSlfokfz6eSDAi0SDT8RUXeZe4ypc
         zyanOjI2dejuX5gZpjtC5BJEadj75od5HLSHQqBRrf9jCU5Uj3iTm+cXfNc2+hrjGbv+
         wYn5g9kuR1Ufl4xfmQUZnl3h9+jxfJFJEtOHGEUynzEv7neIM1G8cS4NL5NSDSVZX+5h
         JpPSJa8AMBWi1Yuprnt4cJMq/IPWoHii/hCMOvfY/hpdf1wKPFf+YsfapSovTPTXVn7C
         smhg==
X-Gm-Message-State: AOJu0YzgNyBxjpUkutzRHveLbjW4En71WkGnx9M1NqWm+1e5cKSYXLEa
	A4vryAQTckE8z7mVbmScwqD1BxZQAqnKf99PjhUJ/h8GcSfqojw4U3C1y5HYLP/a4grDmVQzT1j
	H57RHISy4+0rZ/4IH+tpXY7ftcOhMOL0G8AhpJwm7cw==
X-Gm-Gg: ASbGncuiche2A55yFBW6UBF0NIOQCnrNQmhdvieUEuYU7ZjMyHOPLS73XAnsJttrSFI
	cdEKVxuvTR2V8Iz6av8NDulWD1GOs37oTf8W3UFy+v1BFy1ufbo93Xrdvr4M5bcxaDoFDCXsr35
	mhXjglTYBxHqI3mjsEieU3Kz7ITZypHTJBDnrxUB3tPwF+pCqHNjyAqhgyEzsMbRhfSS28ieeRo
	q/bM/Ha/PoUsbvUe4Vsai/BoWL3ucRSF1HuAlHZjCySTnkW16i7V1yOrjEjyUMR5PKbrYYHrHM7
	9Up4aVLZXdS2piZMJMflKlqPRx9J
X-Google-Smtp-Source: AGHT+IEETnb54HbdKeTiuWDb/Lm7b8afZhTKNTzzH0LI7UTbYLqKJsp23LG3WvoCfMvvkbfrzU+7EYOG3b5zJPTCWxc=
X-Received: by 2002:a05:693c:2c94:b0:2a4:3593:c7d4 with SMTP id
 5a478bee46e88-2ab92ea4736mr969734eec.20.1764746110958; Tue, 02 Dec 2025
 23:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202152903.637577865@linuxfoundation.org>
In-Reply-To: <20251202152903.637577865@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Dec 2025 12:44:59 +0530
X-Gm-Features: AWmQ_bnUN2qyQc96l7jqt-7SYMj2rnFyyw2W-5GaA3sZoN7Dn6CHN1uhUQkFwtE
Message-ID: <CA+G9fYsut9v7pNOEMV=xt1NeGoT_WhUcgvO5+vcJyTHqjAV45A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/182] 5.4.302-rc3 review
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

On Tue, 2 Dec 2025 at 21:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.302 release.
> There are 182 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Dec 2025 15:28:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.302-rc3.gz
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
* kernel: 5.4.302-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 95d4a5c8c83fb774f7103574166d0190dc839cdc
* git describe: v5.4.301-183-g95d4a5c8c83f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.3=
01-183-g95d4a5c8c83f

## Test Regressions (compared to v5.4.300-225-g4e89a6191515)

## Metric Regressions (compared to v5.4.300-225-g4e89a6191515)

## Test Fixes (compared to v5.4.300-225-g4e89a6191515)

## Metric Fixes (compared to v5.4.300-225-g4e89a6191515)

## Test result summary
total: 27636, pass: 19070, fail: 3006, skip: 5408, xfail: 152

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* lava
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

--
Linaro LKFT
https://lkft.linaro.org

