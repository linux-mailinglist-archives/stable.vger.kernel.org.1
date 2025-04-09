Return-Path: <stable+bounces-131914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60102A82152
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5371BA7B2C
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85425D218;
	Wed,  9 Apr 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/mXTtzP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECD25C6F7
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192263; cv=none; b=VDgiua0dqrctDPy6ooRpnDlA0JDoJh/QfKL0lOgtUhc1KF6fHyzS2iX9BvKLq7RBmGwPh2yG2XZSilZSOeYKYcVd2xGn2SfX+mvD5hNsZxg2bZucVcs1OuFlHBhRdws1OTmrNtikM9j2sXzdKTbLu5HPHt440+gaCtjrVAauJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192263; c=relaxed/simple;
	bh=DpUkIKGDpIBV3cYAXbEup5OjKbfXtLEX/LwSCYEclE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrFe9YAgIrhrUr9kouEyhqCJ5tlIjhlJP3akNOBFgwTqYPEduRqGLFC6Iop5yXQZhVXLzoeiVyOX3W4KLgghzcqM/v5H8114NmtAo3mehCNkFY45ZEVMablg0OoBIdGgtXzHroong4JjDHv48p1wY+y66WEbvurfePiy2VliSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/mXTtzP; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so5527753241.2
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744192260; x=1744797060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1njNObE6GIJqOAUn6DtRc5r3V4Q5XV6eVkgK12erEv4=;
        b=n/mXTtzPLQGerKvlRcpBFBjJb/WS639fjIVNzGQUqR6egcxs8mSi7bbSGNJOAOQam7
         8XNaDo2tUGNhAVDE18HMejiyv8gvtoGnlRGZfhzUTXsJS9A7Rs+qXziA01kj9gD4IUXu
         UR4xV8Aty/ZfMyXlhJh6kTYs1/EG63m06nqo/gPrJFkJ1NWGrP7eYQpJn3+VOODaqWFl
         0rQp/WyuL47Yc+4IaBQwAXuM0KsynVc9kcrKnI/7zLPsT0LccxFq0Dwi+t4Zr5J8VAM1
         PGeql7h7+ZH+L3+cep4W/85P/PFf25CNLfbYQntJevEIZTsINhcRLnPUYkAcjuhL5wnV
         xg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744192260; x=1744797060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1njNObE6GIJqOAUn6DtRc5r3V4Q5XV6eVkgK12erEv4=;
        b=lKfMeDvudbg5cpgNDNYiyO7DLq1i1Dz8f4g+IR/uxT6Fw0yRIl5OZv9J2Fgzc21yoS
         OiZS4gkm88Fdn+Inb51y0sVjT8TMpJanNOLO9byCCfL/5oJg3D8i3oTNfvGy/zq65vb8
         jigvQTTpGWw9msNsrOu/SbaHIyU1ENh8wujTL7p6duhwhWLKxrcLv1pzgRN4uto4OYnW
         ueAYedLXl+aCa+2Igd7A6sb/NI73V7wELrg7ATLnrf58GldA7+U8KsKn0gt5uiu/vOqy
         94cWG98sPjy0Jmy3GCoTXxHmyEKT8VmXpzCu7J0pjh68rhK6oHRvykiiOK51CTYzzNyW
         85lw==
X-Gm-Message-State: AOJu0YxA4PnEfdeDhiXxHbO+wg/CaHOFUaQ/LSNwBzMpmmirSrdq+Trl
	N2Jb6nWqSwR7g/PlYDPlYOlHEX0j7148SfIh1j/ghXvrLqduTORqDpvJ9EUGAvqW9e7yz4WIV7I
	vqx8Kq7Zu2agUG3lvw+owLbNRituZJraqv/TMBA==
X-Gm-Gg: ASbGncuhhOh6FLMT9YGzCVaHHqjbH0Fnje+LcHZOr5Oh82/XMC5FeU53vZ8B37pTsJT
	WcKT4QYLfhvJeVFISY5fMU6z5tkIPlIwC71wm4nsZEfjJRhXFKYADSSQa5WnFQFuQrsQXrw9qJB
	+SvVOcdNwHfPgU2PmLx4HubQ64NcfyVaq7D2Ri2C3rqh6GqbPo8f6lvY0=
X-Google-Smtp-Source: AGHT+IHsG0WKPLT9y5IYgBaUgVr1z4LIH9R6xpKkJTuJ5byGHhHn7WE9slVfaWZ/SR14YCSc7WcOvPakH+olVCjROHA=
X-Received: by 2002:a05:6102:570f:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4c9c41848f6mr1465104137.6.1744192260230; Wed, 09 Apr 2025
 02:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104820.353768086@linuxfoundation.org>
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Apr 2025 15:20:48 +0530
X-Gm-Features: ATxdqUHXBcjtcqSTk0bz5Hn75TBoEbSUnr0VzKiWJ8WGDtcsvBL0fc7wW3KoqtA
Message-ID: <CA+G9fYty2+wHZUUVBWposQB1uDV+Z-b3+5HgsJP-a=z3pjEseQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/227] 5.10.236-rc1 review
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

On Tue, 8 Apr 2025 at 16:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.236 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.236-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.236-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 327fc1af5609fca2b091894de2ee904fa6391306
* git describe: v5.10.235-228-g327fc1af5609
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.235-228-g327fc1af5609

## Test Regressions (compared to v5.10.234-463-g92c950d96187)

## Metric Regressions (compared to v5.10.234-463-g92c950d96187)

## Test Fixes (compared to v5.10.234-463-g92c950d96187)

## Metric Fixes (compared to v5.10.234-463-g92c950d96187)

## Test result summary
total: 39096, pass: 26647, fail: 2806, skip: 9346, xfail: 297

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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

