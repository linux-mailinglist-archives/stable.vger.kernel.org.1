Return-Path: <stable+bounces-111832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7CA23FB4
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E853A1634
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8821E2821;
	Fri, 31 Jan 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu5eyRaO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5DA1CAA99
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337690; cv=none; b=F0R55wSLOHM0LhbJQ7+847F53ETCVqFH6cfGNZ7A4CzKmOQv9jdGgleVS8zCqwb+D6T6G9PytM3Y+o3rfFRuskI+D9E/fMmWPn3rJRuvznyXYb/YTywiLmgpS2hkq88jkRxPiqLTPVY+WwfubE5eUr1ic+nYhlqzrqkEYCV56Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337690; c=relaxed/simple;
	bh=qNsYthABkFQQSgwYIQHT21jbO3CPtzOZZjoN/bl36Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5n7eghM6CacCr2hZ/yoLK1umDEQHzTQGNEkU8Kei0s6reOvnHVwMmqL/O+FdLut+bs56JCgENP1G1BcjVcYCderg/NeKEu6SiT/3SknkECCM4WfJtvAhfLFWkvy0IAUOR1OGNOxwrnXaFHEB3dZbEmI64e339pnJbQOIxkQOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu5eyRaO; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5160f1870f3so694329e0c.0
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738337687; x=1738942487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prgxnisBvFfnEWdw5tyPUtrfBlX1TpjjhLA4brULRjY=;
        b=Nu5eyRaO7CV+l8xDgh+d2uYX35TIZYe8sc683iuhQtBrFxh1zcF2tAcgFEVpPQUb92
         DIPu02JLBto9b3DC9qaiPfODRNMB5VGJY+5p9uLqWtulcnNZFVbgldeos1hL2nKaSYMg
         lga22SoTSFvrRw8Y3SGeJ5k2qX1jHyjDKOPrYwBKYFD3DXbOoyOiy2MjuwWDYiCitdbS
         8+cUACAudAAyN1xGV9QH9m4qAoDOtrS7q9x4sDg9WjYDD6GpKa+3yztp4VZ8YFq5PsHj
         rIqIoVF8rCmK/O2VA5PdqRHEW0gDMyg3j29DNnCqdmyM8MkdMaBLZpDXJQtRe8Iscf+N
         ZxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738337687; x=1738942487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prgxnisBvFfnEWdw5tyPUtrfBlX1TpjjhLA4brULRjY=;
        b=WiBLW6p2spmpNpSByxYt9mXiMzCzCYlW3yMwN/G9vWyrPHCek/2fQH7magNgf9CdxX
         A/7CQm2E4J4sv+2m0eU1Dq/DA8KzGr772OUEe560XFjAcaOf4E5xeH7IskTxxj7LPqrQ
         ox66o0knp2SHmZE6J1RjOzAmbn2N7asazXF3V84YG8jk6lEDI9+LNiFkDiXRGDxNc9n8
         Ubla4fF24xWFCXGtMuP+8+GxarsRrxYgblgDxCkxNWx8Cjr6OyWip1ME0qBWRly5suwR
         1LifQRPd9n/NPFIwtrCfPn/716ww4QZoxQGoX4m+0r3l9d/j5deQvI5vFe2VevgXjE2K
         Nu2A==
X-Gm-Message-State: AOJu0Yz5ufPBpIMnVtSl4PpSYXFFHlPnnx+GarSJdU8nkS/ZyJHIrHUl
	DT/DWlBPuPh3isIZbMldiVWB32TNcREaWrBs4JnKhXYt/cVdcIp0CNrczyMyjXwnci3UW2kRA0k
	mu/AoqxgZo7Wveq9fcR0HTjTMN/Y8kdfov30Fgg==
X-Gm-Gg: ASbGncvg+LrLLWQP6s3zsnsktxg6VAZLRArqozv9jY0uimiAKa1zLtyBRj+MmeoQdKP
	gDxcjpL360bcRTP6fvDWgWl4UOJ/1qcms1caI1DKzmKjlKu5bWSbkgoN6bFbNsAJH3XzsclfDqf
	m+rxiMV9r5ByeHN8lnk3nnXOa0aaAH8g==
X-Google-Smtp-Source: AGHT+IEcuOjLHChntviHsLyxu1HHbE+nT93cERhYpqS+zXeePjyRJ4FeC6SHl5QPHU+jGeBW7A/pjPZDIy8u0ifh0jk=
X-Received: by 2002:a05:6122:6609:b0:515:3bfb:d421 with SMTP id
 71dfb90a1353d-51e9e4fe79amr11782098e0c.6.1738337687295; Fri, 31 Jan 2025
 07:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130144136.126780286@linuxfoundation.org>
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 21:04:35 +0530
X-Gm-Features: AWEUYZna_5UTEAqDsa6Zes8ttM2Eyuaf61E3lIwkRn4YU-BA0AEgG6OZbMC_U4A
Message-ID: <CA+G9fYuWfSwyKLugpo3WsU2gvgaBKD99i8JR1YM8oUZ8EAdm6Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
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

On Thu, 30 Jan 2025 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.12-rc2.gz
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
* kernel: 6.12.12-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4d14e2486de5514e8267e9061685a372056a2b94
* git describe: v6.12.11-42-g4d14e2486de5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.11-42-g4d14e2486de5

## Test Regressions (compared to v6.12.10-122-g0bde21f27343)

## Metric Regressions (compared to v6.12.10-122-g0bde21f27343)

## Test Fixes (compared to v6.12.10-122-g0bde21f27343)

## Metric Fixes (compared to v6.12.10-122-g0bde21f27343)

## Test result summary
total: 137811, pass: 91565, fail: 28303, skip: 17859, xfail: 84

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* kselftest-livepatch
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

