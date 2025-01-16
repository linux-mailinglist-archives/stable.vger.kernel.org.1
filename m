Return-Path: <stable+bounces-109236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64556A137C5
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB07166D69
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00E1DDC1F;
	Thu, 16 Jan 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqm/gYmv"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01386142E7C
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023167; cv=none; b=izAzHESLKQ/TUwCgn9QBFuVpeJol9acfeC8RXxuT6bon/f2Nw9GNTjeVlWEQIXySxfbn9/KS6/ciUG9XwJ7u2vy/1Bc4/zeA8fmftG8aaxRKAKF/7yaPBKzy9tZK5hyTS2/LrXZql7QdGuJE1b36XkJ498Pe/Oj1V5M24d+QK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023167; c=relaxed/simple;
	bh=3FhcqilcbilCn/lJYai0SA5bMXuTjsXBNywnbgdXFfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8L7791nrhOxc2GlOyZyIFGf1R1iaYkEhYmu+ALrWRSc+KTwIo3Jirc/6/4400rblUgAvGo+WTEKeTs1RiY16aW+m3BY3rZCk3zxeduNwt/iQbyeODfpEaEYQI5XpU3F8x/yqkUtlJUojbkYeiHKDKD/xFqlTvFLdrIJdawdFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iqm/gYmv; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aff620b232so156762137.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 02:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737023165; x=1737627965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvcLCVaXPyBO71qmkpEFfYkIMD9XHMHUK9nSlKkhZH8=;
        b=Iqm/gYmv9QRuNvdnTdgjBkIGPuDkMrV6W/qjBeXBlb2O4DHnpvMJRs/JpZw4n6M3FK
         CWBgtk3r/So9JVWEBDsb2N1cqjMIMIF5KmJEsFWgaL3UsyBQNLP6IU2O6lU+NGKY5A2h
         jWgC0KqoZjYV+cFgUBm9UwThjR8VBeoH/vtJI7+4DMnmZh39KkmVMqFfVIppVp5KaR+B
         zG/9JJy1ACN62FQtYbKOMCfGVC4qfvI/thPidttZcvt3HUOhJ24DPdRNBW6WYMpuO60q
         v6tp4boLPgarnLTCqw//F875Ezqp9/M6noYe3dnVgdFCl5S9T+iq0TjpYkyFddpwDy8/
         +dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737023165; x=1737627965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvcLCVaXPyBO71qmkpEFfYkIMD9XHMHUK9nSlKkhZH8=;
        b=psZuA9HH8tUMu4nEHo7aXU6UruDDzZuzXrPoGzvIItESFRKELIp0EW0ZatLjn4Gv2/
         Kn4TKyDx8ZvoUv1u29bndXxQMSQuFU3btcL9ZA34fht0YDT7Ia8fq713hr17oEboWiVX
         9Le9/EJJKSpHMuOt+hhKH9ghi9toj8PjapWnBamz3BWeQJHqce3uWvVrZgioprcWilF5
         LhhvoeppB4tw0sQARqvF/u4xlOtJEKpVBSNKWjmx0B3Uu6ExNvBkaMRsACXcsb695IaN
         xuWQT+CJxf+HgLgV7GxIcZbyZvfJTj3PBdztheNJpsuIAPZ56LA5oXerrZ3R96CKOooZ
         Ed5Q==
X-Gm-Message-State: AOJu0Yw6HyBrM7kuf4v8KIL7reJM4g5EAD+3SSWzOIzWXjCPhPOI5Rpn
	CxTY5Pu8TRs534kvpmwsYx4kdj+Tc7h3Ue0IvQgxgA2isK9BnfDZgR8AxlFKcW97yntJkerSfjK
	OtIRmYGMmulj2Cm/9OtDyVZsGtVUpqA43KDRMWA==
X-Gm-Gg: ASbGncsBJ/6xXvK3l7kKJyaLuq4Jb9GbO/oiPSPntwLwiXvkUCZlSJ/0x2laeK9CyRb
	xFNxnBo0NBgbaDr1n0ieltNzJ8fNOZ3FlaEd4iPk=
X-Google-Smtp-Source: AGHT+IFas+i17ggODnCZKEXX1zs0v69tG5R5KXmuUrlRbhzq9SwCWQsetJOesOaYgRWPOGePsl9ovKylLLm4ma5TZjw=
X-Received: by 2002:a05:6102:a47:b0:4af:fa1b:d8e0 with SMTP id
 ada2fe7eead31-4b3d0fc7fc9mr26349966137.15.1737023164885; Thu, 16 Jan 2025
 02:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103554.357917208@linuxfoundation.org>
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 Jan 2025 15:55:53 +0530
X-Gm-Features: AbW1kvauvc4c3OGr_lb5jyExRKFeSsAMe6PW8vKWbdWuq8cCNQx1iOxCSETNdRM
Message-ID: <CA+G9fYvubfVfMAONWi3Pqt3RoJJ2hZT247yQs_d9qqenr7e+og@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
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

On Wed, 15 Jan 2025 at 16:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.72-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.72-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6a7137c98fe395a5691fdf06ed53c9b1df1fb3a3
* git describe: v6.6.71-130-g6a7137c98fe3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
1-130-g6a7137c98fe3

## Test Regressions (compared to v6.6.69-223-g5652330123c6)

## Metric Regressions (compared to v6.6.69-223-g5652330123c6)

## Test Fixes (compared to v6.6.69-223-g5652330123c6)

## Metric Fixes (compared to v6.6.69-223-g5652330123c6)

## Test result summary
total: 96734, pass: 78107, fail: 2971, skip: 15248, xfail: 408

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 28 passed, 3 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 37 passed, 1 failed

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
* kselftest-kvm
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

