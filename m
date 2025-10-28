Return-Path: <stable+bounces-191425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F1C14162
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22EB9503FD5
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA6302152;
	Tue, 28 Oct 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlzpthFo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408F1BC5C
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646833; cv=none; b=ZzFQ7LbNloUyVAMWHSdC3mQHlWOgEnUFMfSFod0W5EZNuSpKJdSNKRMscPyB4suv1QhbIKtbDzbGdTBDi1LTu3SBqUeBngsGxYkzuYQmF9A5b2qpv/ebkVSoRYenvZedjZOi8v/0czcyjR6p8UFSQSS6fYEUmENzuYEsF+kinP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646833; c=relaxed/simple;
	bh=eSFNiXFx43S3A4d+ejmP2xbSVcwXKr0EzyNrmVQhHKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aryJOmS4xMnDUySNsJQA6iEKXSGAiAcMScLQZc74ZuIRanltYC5FjAnGVZ6X/fqRu7/R/fRJ3P/MA+YuDBIMY9OLA/Agrv0txKdyp8Hd0oxHfrsB/0A2uXUZIkvLlo/zEeHlf3LkcOmWq0Yu2BwwOiNIhOc7WHHbZO4eXwzjZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlzpthFo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b62e7221351so5082774a12.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761646831; x=1762251631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq4sVnkdiYdepHbDyI7xtiG1vW7SU8QixEUbKdub3hY=;
        b=vlzpthFoKskHFPV5ONM2aTmJqawhUFAuX5EHpIcMkKuLCZ79x3gaf/CAzyWAbFR9kh
         3PfOk5tOKeSj3Oxcp56eYlDOIW2k5CWZnJgyBNnwxuVczAj1qa0ZIKylLC5M4edNeBkJ
         iWv/URg+HwjBIz+8h6Elhjs6ponNtw2N1HVIeQAyuhr7tvBiaUhcsw9ojvcQ/ErRxYLW
         sR1ggpqixWLdZCah9kZuS2cfXm979Vx1emVHaPoz+LCFdeCOZMGzTFRgymMEfGOhmayb
         mlR3NMJEKFPA6yjBRU/UGCanwtYohMQf23+FdrfW5hbHlMO9/XOi74wvLs0xcWkbKOLy
         iGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646831; x=1762251631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq4sVnkdiYdepHbDyI7xtiG1vW7SU8QixEUbKdub3hY=;
        b=LDh4WQIujOBAeXkKItcnGSITZH5LDyKrovDD1kTeBoO3zszVaQAgJf2rW74mjPcJF6
         EpsYw+1lWjvqve9bG679B5XwKGBC6q5wI9Y4tfnRCMV4XpaZX30qkyU1PEkpQgjaVPw9
         VaTsrssv5LXUmjGG4M05poT7Hp/8N0+9w1qMqDIO3QBX5+exHw3xMDHk123UsKRzOFp2
         OsQOmVeFau2g+/CAvsp8q2fD7NNIV0Jd1GTiSHhriQTU2tq3EO4ojVMC+ETdHRw/hPvw
         QsTMb6K9THEEsSCuU+QkSvZO3Rhck+F7CYwkuKY2Y6uP0/Lk2R/4c8QSrLPSphuJsM6R
         m2sQ==
X-Gm-Message-State: AOJu0YzNhiSXOj/Bjqc6x5lWowygZMKs31W9Q2q3WLIyohA4vXYLkOmY
	bNVINv9PFu2sngS30CfVZVlpqPWd0FwWifqLabMdQUJZjlFHPorPfM2pzZS2233qpgpICQ6NiuT
	8gSGwie9p9e/hLk+dMYgebBXAhhTi49sHsE/edifdQw==
X-Gm-Gg: ASbGncvu51zA49uT5pU1ydW3xXk7rZcKIxKpCL/LsSnIdePKc3RgYhv7SRHWPj6VY33
	4v59rzZUPOXic2Ck8tFep0MhZ5+OublQx56DtsDWHGSY0RxITYQJAJNVrqpspYLy2hoZhWdRbHA
	tzR58GgutseflZ0wwAEWaDhy+ugelQREBJST5y11o75zzJfRs5DuBOxDbWpW/+20fvwiEwSma4O
	Sbjp+weRao+UhotNIvmOp7gJ2h8d6euM9pOpiGre+H8LUG1kQ9dR4MwbyXx681x6kRHK7P/6dlm
	W+s1kDIUU3LeAQLKeonzAz2vvKfNKFLjqHuQG7k587cJ94KJnQ==
X-Google-Smtp-Source: AGHT+IFldgoZnTYpegshPt3WhgAJkKOgC2UfKDSM7I9r7rEprRzETX/+HEGXS3kOWvKcTAnMGtvDYT3HmFJ22tXW93Y=
X-Received: by 2002:a17:902:eccc:b0:270:ea84:324a with SMTP id
 d9443c01a7336-294cb507cdcmr34772335ad.38.1761646831072; Tue, 28 Oct 2025
 03:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183501.227243846@linuxfoundation.org>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 15:50:18 +0530
X-Gm-Features: AWmQ_bmdgCG3iPCBh-32nnzF4A8j0YtwyvHQpjYBoywaDuWUqsbGxGX8tLliR6Q
Message-ID: <CA+G9fYu9EFx08rvnjceS1jNhfjB3BPDtH-ceLuXYdsPtfntibg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
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

On Tue, 28 Oct 2025 at 00:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.158-rc1.gz
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
* kernel: 6.1.158-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f6fcaf2c6b7f6ed4e6ee10532555e1e16764c435
* git describe: v6.1.157-158-gf6fcaf2c6b7f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
57-158-gf6fcaf2c6b7f

## Test Regressions (compared to v6.1.156-169-gec44a71e7948)

## Metric Regressions (compared to v6.1.156-169-gec44a71e7948)

## Test Fixes (compared to v6.1.156-169-gec44a71e7948)

## Metric Fixes (compared to v6.1.156-169-gec44a71e7948)

## Test result summary
total: 86941, pass: 72310, fail: 2561, skip: 11898, xfail: 172

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

