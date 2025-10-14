Return-Path: <stable+bounces-185680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CFBD9F12
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE75051BC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EE314D2D;
	Tue, 14 Oct 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYKuC00X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE60314D19
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451073; cv=none; b=OLFb8gb/bOdiIgym4rSK+PCHsjikx0eJEKUwutS72QUiLpKP5uP0q92zi+zod/olIbBthW1X26FXoJV6VaRR8qOoAR3kikEz/7BU4jm+heGNmDakGICRCgpYzIG4v26mQ/ZgMXtCCtQdbHSZlhnsUbFT1N/cMpn/BUvjAv4UzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451073; c=relaxed/simple;
	bh=kGoX263RqUSA0Us4TMFi2bOCy/tmZMWLysxu0CI0aVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4/tJxrWhuiHUUETVHYdM6POnYzj7NZ3LxL2NIuvBknK5lRfNFQxeA6tjEkmDWETV+1shQmDqnHjSu5tLOEzKfJq5J5ZrgKhg2y2MvDMd8vxLFknqWZGPtmnA5EnZK8O/X1cPC8mpooPAHdaJQG9P75SOaAtJu1kqph37Qg8IKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYKuC00X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-271d1305ad7so85832645ad.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760451071; x=1761055871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMdkjQGuLT8DWGyEwUDOwwNR4ew8j/yyQFeLk39r5n8=;
        b=dYKuC00XGkmqihRfUW8rl1u0LJPLwB17Rnp4sT63c92ajGVWlBGS6EaS64eHax2pY5
         Dj+oKZlCcEkXrM3OwXZHgaqyyp7W3A3dV6ogdrr4m0YZ0nickfZEJiliaWMN1H6z0Ngc
         8K7wSMPj1vdGx577C/R6bx5D97pS4RpEtAMkDqFU7QnNWzU053WdawZdTCK5Rv/GDoc6
         12B1aIKiNpvY9riRwp4owqzdAdql64amlJws5kjNHVDvBq7JdyHjemkzcVXw9Anw8nWU
         bUlQ32x4awJWYxIRPqITQa45gSIXDLw7TeEIrNqunkSS9knNlGoGkaJesxfQtPzFAGZD
         +HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451071; x=1761055871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMdkjQGuLT8DWGyEwUDOwwNR4ew8j/yyQFeLk39r5n8=;
        b=R1KIpXFMDA5B9wBVMwiT8j1BRH+jy0Hun8j7sbxvdPxDOpApYHENFWjUnXxXAZib+b
         uOqiTELVI5VBf//labexHXpWE//5MDL9ARTWIf7jCyljZOwkWmMK61ncwU2xzAXFS75X
         f3XP+ZxlQvQMRpP2dqPli7lWm4OMeK33/L4LjwTupCEQ/EUENxOYiVEayP9gVShuTtmJ
         AnG5XU3i8ecWXCtsSs+V+S9skwKgADw506OpHDRiNUUMSC29+aTxrnqqHApgmrTyRbG2
         nRv3LVSvRTjGikC7MH86QCCDSYdz7edmgj0O89KP+nmRWZ6qrn8NMAuE1QBV6OxLEitl
         HSBA==
X-Gm-Message-State: AOJu0YzmW2MqlVv8g96jJOY15Es9QJquX08ekoy54nDPcHssn/IwwDTK
	sWsCFl3QdpmC3aB8a/wor6A43ftm6zVofZTO0AhWd6MSfK462n18v/cZxNrQusX/ZHCGVRLT/mL
	ct33IA3Za4N1PVTXvgQrGE5WRqe55zMesERritHLH6A==
X-Gm-Gg: ASbGncsHCbTjNYbwybDfuMYcizACrJaFnPmfjxIDMs687N3orGE2fY5b/+E9DETylyR
	DfNbHDvGHH3SvbtwoMLxHIQALxE+h+ML/fc52gTW0/mtiZteBmyrL/Cw7ql4aC6WXSKHayxPCQy
	d5j6+vjfG1obbHSk8tiMZF4W6SfDsIiM6oRDR+AmegbdQa8TPExY1mzKobmZO636VYpDqQeQgVS
	NKr39C762aRbbxnzlfPVXdQIpGfJAIRdlqEVzRH9vKiV5qvMUl0AA9wjVKlkxZQuJGUZY+uvzGu
	OUPOSnXBM0Zszl/wydg=
X-Google-Smtp-Source: AGHT+IEmO3Gx7kyNMt4swJ3QuKQ7vC+f+1MMBbTXoKoGxWLCLzDt+Rdb17spwAO1lz6MtUau1lMK55g4bVsaq+j207Q=
X-Received: by 2002:a17:903:2a8d:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-290273ffc74mr302431295ad.42.1760451070963; Tue, 14 Oct 2025
 07:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144314.549284796@linuxfoundation.org>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Oct 2025 19:40:59 +0530
X-Gm-Features: AS18NWASLVoxLmB2xetvxplEfjkLd1CWbBO3gda86sgaGChckjxYHNLEtw-8DeA
Message-ID: <CA+G9fYvYE5+zY6CiBx1KWnf+W5-4cbZebSciAuh+TAc-6oV31w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.156-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.156-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b9f52894e35f79b1ab1c988d4202ddf668e35032
* git describe: v6.1.155-197-gb9f52894e35f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
55-197-gb9f52894e35f

## Test Regressions (compared to v6.1.154-74-g8a8cf3637b17)

## Metric Regressions (compared to v6.1.154-74-g8a8cf3637b17)

## Test Fixes (compared to v6.1.154-74-g8a8cf3637b17)

## Metric Fixes (compared to v6.1.154-74-g8a8cf3637b17)

## Test result summary
total: 99093, pass: 82935, fail: 2925, skip: 12977, xfail: 256

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 1 failed
* arm64: 41 total, 38 passed, 3 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 32 passed, 1 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
* kselftest-livepatch
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

