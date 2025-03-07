Return-Path: <stable+bounces-121371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41106A56722
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483F53B53C6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527421859D;
	Fri,  7 Mar 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JammGEHU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168320E302
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348415; cv=none; b=LjYIuLpuR3gWacF0n91RvzROI41xrrDADlQxallw3PsFAxf7HK0WA9f0FbBfynT05+1UkHiImgJIyYEgtexJ/x+3q7Z07kC2tKuSizYpalJdsudT3MnVUmezVyuGMvV29NevT9nKB3kSH7TyqSIA84f4yETklOip3qKD92S5+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348415; c=relaxed/simple;
	bh=xE747tlTQLAxgh8NtAjUgxI+rHa9+PyveNJeB4853TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRYbycDoNtqSLdE5dmBfIDUsUE71Zif2J9HinhADgiTklUuMXuTyCJyuFmFJmvkAGYWXQ8UyRxlcNs9UYLtTGJIzMR+kgHfq/AAKXD0zxjntB/kVQJqRNOEgFMvm5G3sCZd9RamlvrlbWLW4+XuoaUWgn4USHXGDVnB6Dl1Hqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JammGEHU; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so1517654241.3
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741348412; x=1741953212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WD9jmJaU5i8Pw2RiIsBAgARfcboGYACiY1rTXf4iik=;
        b=JammGEHUzouohNIJniaLOBy6qBE7IkGJp7HRGnhGl2ArJVV0P+kryHItcYaqpWtL1m
         AxGcP6k+DNyBZwCIvPHJ5zzkuBT59BKGflpf5oMODMZh5Uc1bIOwi68OgSWCEuQwUXNS
         2MtVpJTDz4zlbVah8kcj9/SC2152FnA/fkFfEW0r3QOqo04zLaBQEmFAyd1DLnVo3eR8
         i3W45+K/ab/mvDiy1GP9tZR77cOjq6Mu6b+3+Gv+0uZAuct+TiYcCWhGhcgxp9mK1/2/
         mjJdfeyaMn6A2g8ocDGjv4xTQbQhu0K4emsFZ8f49/FFsbLtGlUFdzmX+M5h4wIOhsgc
         jOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741348412; x=1741953212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WD9jmJaU5i8Pw2RiIsBAgARfcboGYACiY1rTXf4iik=;
        b=pKoxKNJMjQ1+u//Y4h7aAOcT7xpehO1IEHIpfhZhvr0dWC8GuKh+8aX1mbLyhnlN3R
         ZzheeKPBredKk7mc1LiMIUqXm1/eZrV/1IHSUY99IlTz9n9ioPNfo/ZAJZe6hgUhrO/7
         txe4oHzPR5DZO8TyZfmPdZWfoFZkbBD6PRtXhTZX73cJJ7FpPttwApEXlm/w3L2cZkdQ
         X4BpKSso0ERq4QbuuOBOOH9czgq5ul1pdhtUGvxkiU7litU93x7i00iPnh8GsFXL1Wds
         a5NdpAdi00rz8W4lhHeG+tkXuF+7yr3Jk7DUnuQyGmkb5N6fgQGHWuchd4hTWwS8ivhg
         10BQ==
X-Gm-Message-State: AOJu0YyJlFxFFMcvMHhSiNaE/Gh2/S0KLAzXhn0IUgo8VLQKbToMgS97
	FCXYzJGKqvvSjoqyLcnMm5jDydBKyz4f5BzGSMpe/WduaL7CCpaoYioEtw5xwEP1nHMH3spa1Hg
	HGMrS3geddK0xhXDYGwGmD58jSBpM144SoDO10g==
X-Gm-Gg: ASbGncvhfetim4Qqa9xAkqSZIOKfjTXtHbBuqynQw4Vzzyn697iI9cMKcHZEfWPB8YA
	EJjRfCTqFN83SfSf8rfQBBpTRxJwPKrWgO8coMQo6TcZ/AxOCvlnouIg4f3K8KAf1+WOJTwT5oq
	Cd+TsIDGl41optJhJxm/t6TVMO6vSPGcO16kHRq3l5275rZrlG7vc/fVa6nW8=
X-Google-Smtp-Source: AGHT+IEok70NVqqxgLDMVhU3m5iaGPJbZFbySmXavI+i0nsu6a0PolvKnH3i/MkXFm3c1wuurNezwxl6ZQGmpGANcr4=
X-Received: by 2002:a05:6102:3caa:b0:4c1:9b88:5c30 with SMTP id
 ada2fe7eead31-4c30a6ad49emr1719230137.19.1741348412369; Fri, 07 Mar 2025
 03:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151414.484343862@linuxfoundation.org>
In-Reply-To: <20250306151414.484343862@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Mar 2025 17:23:20 +0530
X-Gm-Features: AQ5f1Joffh2sqUY2oqDqeKH0v9gxxZrKALDccy4nN82WMvdcgJzBgWa4l53hDcE
Message-ID: <CA+G9fYsOasubSbr1G3p=zu7vVGSCacEK-fJteJFSK_3NXUddkA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/161] 6.1.130-rc2 review
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

On Thu, 6 Mar 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.130-rc2.gz
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
* kernel: 6.1.130-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 029e90ee47c2263f170d2a45370a7785d00ca34f
* git describe: v6.1.128-732-g029e90ee47c2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-732-g029e90ee47c2

## Test Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test result summary
total: 103810, pass: 80922, fail: 3936, skip: 18501, xfail: 451

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 34 passed, 4 failed

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

