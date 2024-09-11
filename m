Return-Path: <stable+bounces-75810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAB974EFC
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD51F2212F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32461176FB4;
	Wed, 11 Sep 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr1OaIIB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80914F105
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047983; cv=none; b=XSLhK81pYsZzxWeEorylVkelrl9fLS9VAXza8JqCrxwuluW4DmfQAN5RxRtubJNO19SgJORx4y+4uQjwUVJkxs6iSdaPuiYtaWknzPLQA+AaIv6UHc1zzoHM43nA+c0I5r4wvD3XI3W+Q/ztDRpaw3zKBZb1GahOqqUfx1ftQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047983; c=relaxed/simple;
	bh=1NeWTQO4fhP/uhmEe7D6MlX6xH7VJap7lh0UCmqhZnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4bCJCE6LA3WyyfZyPTKgihG0w3n0fwutVUnKXFXLipwpJ5yv+8rkpi/Rt6mN4THXGCNOHb8vYkGplsV6ruuVmn2nLPsdx0wSE0zWNzDsSKdOm5KEpteAmHXDwLBKdRnHn3gVPo2f4aZyd69HYu5vzxiZHDdm5CrM26C/UVuKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jr1OaIIB; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-502b6e2a0acso566407e0c.2
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726047979; x=1726652779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcOo3tuGr0UtozScsPE87l+eoYX8cvfCEcAim6sDdg8=;
        b=Jr1OaIIBvLzXF21uBy9OtVbiqdDqwr/fqJd+6lpCFCi3uBq5MxVJuucidDeieyY/Pk
         /sWBHJjHImpOTUSevZdTOopbxhAepq4fvXDO7EJgq6XCcrhMJDR+pQbide60AnFnEoMB
         Onr3b9K5XNZ3ro/ao0aM3eMgd8VbXDtxEoGsfr3RyoRrslkbzPeqcteDUrA1qH7QqMGi
         +ORTqCiQiQovNkWyjN8dbolhPGIWhz5GLdA4KvL/dyr6iSEJLl/MAedUPXKFdemDsjZt
         H52mIZceF56x0CRDTqAPNYp44Dooa0JA1ZbSponDgLqXHvrUu/DSX6sd12LUgqqJuCBz
         X9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047979; x=1726652779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcOo3tuGr0UtozScsPE87l+eoYX8cvfCEcAim6sDdg8=;
        b=MfdMK/c4rcxiuy4W/TYwxqNY5kCFAZG9Pok0IUECoGenTI1qP+7b/I3AgjuZEsOWSK
         VJsw9IalYGbnrosCMrv+1cVk2WzXYfMFtpeFKsRJ+6RVWrX0u8aW984iPx4cZEO31BpJ
         oNxWVjjWqPZaDDZ4CjvgnP45uKfSqq2VCcF6nyeD2+57tMC/uTRMERyXiF0EYhbagKzc
         XZGtNBxB8+CuGUKaQRxCkhL7b7p/Uj60GkTPlxMEdfm/iIpEi2bhGWpM2q830DAngaOK
         oRxMlC9UU4BycbJYnR9ZMgD36yLj2BAepnAc81YDXz/3KvRRmBcKlZmQeLYjAxestklp
         JfYw==
X-Gm-Message-State: AOJu0YzLPndVxfiAbc0dXOzxn0AyspYQBNEm/5xrjZZ0P0428VA32d5S
	i7gKC7R9YK1umjgpS78WTQ0O0O1ihyDgXXdlM1MC3cR9PQ9U3X3E0wB+zYt6OfjDjDr0/8RQfH7
	RLArle/8v5IezzLQToab/IZ7p0lNo1vdSoPMQdw==
X-Google-Smtp-Source: AGHT+IGAAa8jLMGbkJOKQv9oYg7tNnKl3SSJR3fkb4ZM9ylosYa4V6EylG8mfxU/d1Durck2UuGoa68MIjpkCfsujfE=
X-Received: by 2002:a05:6122:3125:b0:500:fa6b:b878 with SMTP id
 71dfb90a1353d-50310f0f014mr1880497e0c.3.1726047979146; Wed, 11 Sep 2024
 02:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092622.245959861@linuxfoundation.org>
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 15:16:07 +0530
Message-ID: <CA+G9fYt4R3YDoF6F1eLGTYKtUH2ucoSjDwf50sf0QZF+fx2=OA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sept 2024 at 15:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
------
The Following crash noticed on arm64 Qualcomm Dragonboard-845c board while
booting. I am trying to reproduce this issue and have not been successful y=
et.

Crash log few lines,
---
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000040
pc : genpd_runtime_suspend+0x30/0x2b0
lr : __rpm_callback+0x50/0x1f0

Links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6=
.10.9-376-g8f68b409002f/testrun/25108009/suite/log-parser-test/test/check-k=
ernel-oops-oops-preempt-smp/log
 - https://lkft.validation.linaro.org/scheduler/job/7854632#L5549
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6=
.10.9-376-g8f68b409002f/testrun/25108009/suite/log-parser-test/tests/

## Build
* kernel: 6.10.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8f68b409002f98fb08f212066a88c4b6872799de
* git describe: v6.10.9-376-g8f68b409002f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.9-376-g8f68b409002f

## Test Regressions (compared to v6.10.8-184-g1f09204bb539)

## Metric Regressions (compared to v6.10.8-184-g1f09204bb539)

## Test Fixes (compared to v6.10.8-184-g1f09204bb539)

## Metric Fixes (compared to v6.10.8-184-g1f09204bb539)

## Test result summary
total: 241491, pass: 212928, fail: 1906, skip: 26158, xfail: 499

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* log-parser-test
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

