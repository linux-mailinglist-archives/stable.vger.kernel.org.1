Return-Path: <stable+bounces-191571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A89C18A8D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEC284E7AD1
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28C31280B;
	Wed, 29 Oct 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvhtFQ4g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333530F93C
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722276; cv=none; b=faIs3nkPwy5WEMwE82+sFyjjNOL6+nJTORBattx8t3HcdZxNp0C5Uacmw9mGH9saYBD7Q1Ynu2XQ6n6g5WwB0N1o5o1v1jF+y0XIpxqpGfZ0mAjk4+pwvyWLYxTz4rZxFiANoMFYaGhoQyKxI96qvLnH2GTZbQ0RNAby7Kl+y7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722276; c=relaxed/simple;
	bh=ykaaT6YbiADc9d9+kOXprtiOstIf3n6+rKFwjMr8+qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8fXa6CkVMHUCaydw/He+vYvLlStNm5cQddPiPNe1RveDNi0afXItzzkGnfUIbKMBWZFy+pjMvezwDuGaFAJCekDNegrZQ0CtBl5Y05qx7FIRSsmL/dM9TJcA5eVZcgUwnr2y89Bj2gSLUZTQNHxpJSMlnOZ/d9O5/Y3u7sJqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvhtFQ4g; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso6385113a12.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761722271; x=1762327071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuUZCRhhNRXWt6XeO4ZvYFEtD1drRmJ0SlQlWn1fteY=;
        b=lvhtFQ4g7ZMWarCf6bjSLKN4afTlOomZGbOSgsOAoithWqH9N2S/a6Ri+MrNJyBj87
         1oZU8J/1rA6NBwNHYOXcl7gMe5srUGJRrzYCybQ9hsaBqZGb+2BqYmko6UmhKDiV55md
         6QQon3ZB8Kx52kUyXz8CdCfW+QTbXv6W9F1JaJZ6eMYlkL5xxnPjj/puQKTE1ctp6cdo
         9iNm5NTQADu4Hj7owcV5TVa/MiXvBjmeXLCXQXeK8WoZ/eMBs/QfzY26w6WyJNRwYfrI
         jILMigW7+hRSYDWGXH8QxOAF8YsCBPWjYdhbWp3srfYJRg+iFsV587AGlhYq0a9GgU5S
         mRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722271; x=1762327071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuUZCRhhNRXWt6XeO4ZvYFEtD1drRmJ0SlQlWn1fteY=;
        b=ZWTVb+Eq0+gOI8Syt13cnsmXMD5UyxkufEjsii4ANeixo++L15jCtK4intYccfWg5m
         QsW5PTqze5epymzJs3oSbbkYuQI+TlRAPMGvE+CxvdjrAw6WHM8PdiPu/47yDcTupF4S
         ihamcMZH4D/jnSx8aqa4Q2kdE5eWLB0vzX2QYhyfIXQjID0t5lR5pWIlglQNu/BPg7XC
         l9eSt5YcQAoFEUyKf6y8/MrOllw89/OoXgq+bKMXulRfY5MOx7vmo3MSrwX6f9TYvKhU
         Uy6BPodwbgZIA9ffzy5sjPlUBVvj+hcjDldX5J/c1DvLqP/CX83wRdhOqM5/MaNnxjgT
         6ivA==
X-Gm-Message-State: AOJu0YwsFh//PPRBSCwGkyt/MXWAlYYghF2KdZgwEbrXaNPCZLofT4hW
	CRJncOg9z58MPsKFjLeP3T2CzLYn2BFs7p/vzLFccn3f7HK52vA55eVXOy6IRFMkHr8LdU5AO8u
	pAxoJ+GWFQ9NpdU6nn5iYcgJ8wxIi9hjxJufiA3oVWQ==
X-Gm-Gg: ASbGnct5wVn8yKKBGlBT67gk1WCzdauFk+VXRzRvdqNjev6rSHHYHfj305kbE223XS5
	nKROqf9RYc/0Vykz64H4OzrO38i2BkL0UKVZgOFaTU7g3SB5lOXxb5jzqtUcaHQI4uWfU27hZjK
	wu1PWJMzL14yn57WYb+V0VzejyfMogk0o3ihkH4c9s1cfkeQXknVX2N14QnDY7da6y9vM3qs9Jo
	A+v+YlGyp1KDqkFH4gwR15Oe/UzACpzb/YEmy44p+YW7HvmTV7baojZBTW9a4CXQxZkmZC/ErL5
	rjUYE8wR+RIDorT5/CgWFIEw4na+DSi8nqSvt+ekmRfLgZp7fg==
X-Google-Smtp-Source: AGHT+IEvVzT4l6WFVgzJ3FSYoGb6uLgtVt2W5+fZOIl+K9OXMvI8F6nvkIt0kMi83P4QMS0RYXvro6p5vHwDzAUVI2I=
X-Received: by 2002:a17:903:18d:b0:293:623:3262 with SMTP id
 d9443c01a7336-294deec517fmr29410295ad.36.1761722271261; Wed, 29 Oct 2025
 00:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028092823.507383588@linuxfoundation.org>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 Oct 2025 12:47:38 +0530
X-Gm-Features: AWmQ_bkhsv_CfXE6-NmxcSUE1G28maRQK_zSuM7gYEAFQhEmOG1vtJliOgdNvmk
Message-ID: <CA+G9fYvNF1b+5u_ppt+9K4wDD_hNLNfDn9x5V+KnuR1BXDzG_A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
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

On Tue, 28 Oct 2025 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.196-rc2.gz
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
* kernel: 5.15.196-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 59a59821e6b5c0c51b329271616457c39cccc07e
* git describe: v5.15.195-118-g59a59821e6b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.195-118-g59a59821e6b5

## Test Regressions (compared to v5.15.194-277-g06cf22cc87e0)

## Metric Regressions (compared to v5.15.194-277-g06cf22cc87e0)

## Test Fixes (compared to v5.15.194-277-g06cf22cc87e0)

## Metric Fixes (compared to v5.15.194-277-g06cf22cc87e0)

## Test result summary
total: 62494, pass: 51282, fail: 2472, skip: 8394, xfail: 346

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 27 passed, 1 failed
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

