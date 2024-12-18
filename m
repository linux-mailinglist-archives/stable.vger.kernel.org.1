Return-Path: <stable+bounces-105162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F359F6754
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A606E1882F82
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7A1B0404;
	Wed, 18 Dec 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aza+dJKp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A371ACEAD
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528771; cv=none; b=S/vhLX4NVSRLxtcvAVeZT3gfnCU0kToqTHAA3E4PLZjupTCOBqOYvewlS/CYuB3KOLyKPrsx93XEpZToUSbprfnGXaZmlwTuxcuGYduJX70JMMej+mpVLAGbDZPQkGO7al2eE/D/xiu2XB9h2vLecmGNjh4sYc5E4AnKIhmF6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528771; c=relaxed/simple;
	bh=G5/soJifnSaX1ND1QtoXn3IjtMRSp9uGdN3QmqPu4No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APEvFH4KOrR5y0hAjaAegzBIV2RhDI2wY6O3sXvNJbgJ0M7wAzHbXw1mKIL5OJaMA3mBoflJ8V3gUU6nD/j4m+RdpW3S/RpiXUAfextns+fxf53iCeEbSd8fp8phKHvsajoknDPK43/mg3lcFuS9WseqEF0gnCOPeB+8cBwXhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aza+dJKp; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51889930cb1so1779750e0c.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 05:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734528769; x=1735133569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUnvniu6hhiToDi2KkXkauo96l6qkrj1MUqRCRa1hWg=;
        b=Aza+dJKpgbD7xP56LvDz3pfclBoJExb91Grp1tUQTy3LLpW5oon6XlrjAHCJhdsmyc
         CQUsAPx+NrebkI8yhcOOiF2rsK8ftxT4JpVzwsjqNJ88U8YqR1ylVymXSO/kNzyf7JMM
         yeW8RYRWGOTpdM7gE16iKbMejgyo/PT1t60oeA8Wk/nuiwVsXhIUtTWdWLem5jQpVdVE
         +hHkt4O/CwP+Xq3kNm7kwpHnsOwhqX2j1Kp3dUYhdW+1CY86hYnUV6/PGzclDlQbrxr1
         wcHWou8JSEefa0IqyuJWKsz3TMu6Op8diyN2fbJX0BGBfvVLb1Qo+EpMI1wCG9MB3E62
         dmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528769; x=1735133569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUnvniu6hhiToDi2KkXkauo96l6qkrj1MUqRCRa1hWg=;
        b=M6QeKdw5JTSo0Hsa1IL4q+Bz/J7zPYwmktuutERHzPsbXx9g6adnV8Mk9s1WkJFNER
         hcTzkaUQvPF7nXW4VY3gsQhvGQzK9wsDHjIHp9J6NYKYLozmrLBlXaNPJ8Uxr6Vdrb9P
         LM38dWhReVN+ejigSchOxnr+hxZWGKQNZ31oYNrMvjBWTgGTDs0oIHVbEQsmIZsk/4z8
         kfwToxwsHP2DBwdmUJ+3ZYfvAcqvZ0zLSVUdJ6SNLaDwi9MBb7kwWJX7VmcV5Blchy3Y
         VoLijk60xQ0NKWbeiaqQug1bIzYoYBs433WKnrzJnmylNrhYyG7HytdLtlrKS7rGyO/d
         u80g==
X-Gm-Message-State: AOJu0YwefCJZrgxGmwh+Yj/yBJCnlAxJmWlcjJNS3DC9rMdAIA8ttQEY
	JCL5875ivGZvmQBlVo1JKkYhpcEiyyRj4F+nu8HXmDmd5XXXZKFcaHKSUwaUoFj3CiarrSTr2JN
	dJ38LshqjlBm6ZouKOKZ1u2NYY812bhwTReMzRw==
X-Gm-Gg: ASbGncv8jamUBTPwNnR/Tb8zeKx3kilz+lgbkbGdCmaS2XIxI37AmWzckA5CrqFXxjG
	fyZFy/30TyngXNldbH/xtwVxlg2iCl+M4jMP0qbw=
X-Google-Smtp-Source: AGHT+IFrn3WMYPlXHzUXLRGTfPnAsmK0F390EDdRR7M3D7ArWGAYU87aHLoNK3kNirhAdSej02oJOftv/JXTu7CbCWE=
X-Received: by 2002:a05:6122:d0c:b0:50f:f21c:4fd0 with SMTP id
 71dfb90a1353d-51a36d4c76cmr2707332e0c.8.1734528768665; Wed, 18 Dec 2024
 05:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170519.006786596@linuxfoundation.org>
In-Reply-To: <20241217170519.006786596@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Dec 2024 19:02:36 +0530
Message-ID: <CA+G9fYvTZPHivc_QD=Y4o=3o7OBCqa_f5BHUpT-FGjBJnifsLw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/24] 5.4.288-rc1 review
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

On Tue, 17 Dec 2024 at 22:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.288 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.288-rc1.gz
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
* kernel: 5.4.288-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b66d75b25fae4e086d9f581b37104ef233989897
* git describe: v5.4.287-25-gb66d75b25fae
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
87-25-gb66d75b25fae

## Test Regressions (compared to v5.4.286-317-gce5516b3ce83)

## Metric Regressions (compared to v5.4.286-317-gce5516b3ce83)

## Test Fixes (compared to v5.4.286-317-gce5516b3ce83)

## Metric Fixes (compared to v5.4.286-317-gce5516b3ce83)

## Test result summary
total: 42127, pass: 27773, fail: 3201, skip: 11132, xfail: 21

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 32 total, 30 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 28 passed, 0 failed

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
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
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

