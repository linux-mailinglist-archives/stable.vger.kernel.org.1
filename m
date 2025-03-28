Return-Path: <stable+bounces-126922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C57A746E3
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C10176FC9
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09D215777;
	Fri, 28 Mar 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5Y4EiYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEB21423B
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156110; cv=none; b=qDwwPqtoV5tSeR7mMuWTrrna/yNWQq2x1ZLK1vLU0E1NZYjf4LA9TNcbhIV0nlCwwdsE4uy5xVts148I+qx7S5qT7OwObwEVZ92qZgyrymf7YvSMKdAzTjLZEVY9169IQTZEhgMmPcncfik8/LPgcvCAXxZea6Wox2En8UxR7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156110; c=relaxed/simple;
	bh=TAEdwrUyn9kPBfK7OOZcmsCuGPNnNLkqPPkNDGTKkj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHQT0edBI8056gxaqw2zN9SsPKAXZZ6BdiYBqPAmVuN0WutV++uZRb/mrCgQ0R10F177cc3osDvBrgNy6IlpuNpwHhkroHvHUcL2Epx2H54iX9+otwdsb+oQHv2ArUIfollz02z2CHMBdXOnN0iUBwEQ3cPS0tC21Se8AFiI0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5Y4EiYp; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523f19d39d3so1068766e0c.2
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743156108; x=1743760908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy0b3ef7tRBEX4cJpPaVoQh3iegxY1zj0tUH/YADkAI=;
        b=t5Y4EiYpssz1FNrQrXeG1sd9JqYMT8D5AOgv7w01mn4EjPoFt4X57z4br08yGTroVe
         UG/H5AgY18v2fNAryLK5y2QecShi/+njzlB7WYkkHmrAE/sUqMZ0jWK4jurqSsgev3oH
         TrNAvbhrLQCTGkV6XE/j6F7JgghwXfQyOwrg6t7l2PizKU8ZDyi5uGyM7IY5YoCLN7mj
         7btNz+X4Z/7A3r7s+hn4vaghXYyqHwdMNQ7D72F7c0LRk6FEjYyZ1/elKC2urKcvLv+1
         Y040reCV0QLCo395vQQ9YjGkvU1i7hODBClqPDHa3ToPYwrjxRG6UI5bu4J7nauO3tDz
         DrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156108; x=1743760908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy0b3ef7tRBEX4cJpPaVoQh3iegxY1zj0tUH/YADkAI=;
        b=vJCKAM3PpSnKXxZQ7TcUC2Lonc90G+RG8AlixCiEDd5EJMxzg/5Vg1q4aEDQgmKPWH
         sae+koZmH3iL0L7a3ZVoNctpjmvDBB5311whP+w3+7Vw9UyTwqhaJkiENhDal5d9r4CY
         GrsyLv14JIlfsBD1t+JW1HsTpsgBky80Z3mFIIbYdB3Pnjwmx7K7zABWcjRWCR7C74U9
         OirHCSFsssI3bKtq8Pqvf5qkKJVAO1bofSlgoZiHWNx2ZIISz44usLrBJ4ON8LeYCz8l
         fZ6GZlGCMPJAGc62uiTEgS0r5J/v9Al9BdccDcsjd5y56HBMv9bX0N00xsUocL0NCBWk
         e4xg==
X-Gm-Message-State: AOJu0YxWaiCmz/AmPkrpEXGGMEXrCHhPNRIiPVDJx23Pc6/j0VHl8ju1
	OOS4zkboc44RtClLKicxf/++iMkSEolN05BH5KQjZvQ2LUbOfRdPA608qKon/4pLUWMX0oKde4Z
	7UIp5UFcGa30WEb1MdIyDFhaN3nPb9STMRlYlWw==
X-Gm-Gg: ASbGnctW4nOIgDzy9PrsODLKtl4aUxsBGp9jXLVWqvfaMF8GOEMte1bKQ/ztcNh2FhD
	gVtpUdxikKL6AhJ5yfmomjmQp9Lelw3ZG4N3+3Cofm4F5GGN+WfpNCeFVqOwRXEqtzbEk7AaL8N
	OyliHFruS9Hukz+4N58DGdM0zWBcII5vx4mg0Jp8oMzm0j1rOYxaflObYh4+M=
X-Google-Smtp-Source: AGHT+IFtROEWRg79IGDLc0rRT+rbEMKi8ZlgwalunWQkzYQSnh9mC3YGIgViI3XB5GGoj5M99BwEITd7NGTa0RHkaLA=
X-Received: by 2002:a05:6122:3d0e:b0:523:9ee7:7f8e with SMTP id
 71dfb90a1353d-526009144f9mr5547735e0c.4.1743156107633; Fri, 28 Mar 2025
 03:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154546.724728617@linuxfoundation.org>
In-Reply-To: <20250326154546.724728617@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Mar 2025 15:31:35 +0530
X-Gm-Features: AQ5f1JpQB4dRotLGNTjOBzHAHFolf1GRaUeE_3Fa2NXTiSNL3tVJxULU2L8PMXA
Message-ID: <CA+G9fYvqdsfwnPNaP1rGoDV=KayU0ivo9=3ixPao01FSr-YGjQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/115] 6.12.21-rc2 review
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

On Wed, 26 Mar 2025 at 21:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:45:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.21-rc2.gz
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
* kernel: 6.12.21-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f5ef0867777d85f346f9f134c67999eda52c7611
* git describe: v6.12.19-348-gf5ef0867777d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.19-348-gf5ef0867777d

## Test Regressions (compared to v6.12.19-232-g981e6790e185)

## Metric Regressions (compared to v6.12.19-232-g981e6790e185)

## Test Fixes (compared to v6.12.19-232-g981e6790e185)

## Metric Fixes (compared to v6.12.19-232-g981e6790e185)

## Test result summary
total: 130475, pass: 107490, fail: 4077, skip: 18846, xfail: 62

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 54 passed, 4 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 16 passed, 3 failed, 7 skipped
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

