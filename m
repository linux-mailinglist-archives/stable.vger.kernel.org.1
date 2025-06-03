Return-Path: <stable+bounces-150639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C124AACBF09
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D41C3A5ADA
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3332C19E806;
	Tue,  3 Jun 2025 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqHySapO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54719DF60
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923358; cv=none; b=LKuFHSIFm3HiNGhFSG03aEfn7kTwnLDmysn9wqkU9D9wrzC+TY+E0oqxid5SKCfB2E9xNtZQqO4sCWtgQzPdMuuSurUOX7GK+gJAhDMIM/XPXvEoVkBaqQWTJhuHxBLLSNTlP9m37Aa5i/zylZW/SI+K2gQjKa1VtG2n0yYjf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923358; c=relaxed/simple;
	bh=jCNGG60p46LaPYgfFJ5QpGYJ+h4VGB1FBMJKm5y2Qlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZownJLgxC2jSbuXZ4J2nguvIv1vHRtfw0QuWC09HUNk2MeVOqKVIM127V81GFNrPvMfL6ZAD0gMubVTbbWzIZJG+JRSHSiHe2dyvmbX+aQnB1TGyQsNpeqzoQvMlZ9cFCHOmhFmEGb6EBSI5ksfevjQsrT/Hwd1eyMBnvTiVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqHySapO; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so3626315137.2
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 21:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748923355; x=1749528155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZSYANcoh02egzStrY3RoKo9uj8NAmebnQzKfityk0Y=;
        b=fqHySapOowOglf5FDYRSKTQLKikokvcisMMXo1SSVo16V5Sw0stGHepO8gDs9xiCe5
         ZWYno0/BlTB9tn3obspMgwtAFQH21V47R4XOdQzPItW0+KKa8dp9BszGjaXwpqLuJ6O4
         R9L0zS07xqv0Io2nipYvb6g3UVf/N6MfliMToLOStosOarlmkgcvnDuJOxKpPAdicEqM
         iG7MRKWzTSF990PNBJfnQx8zFw5uh6mTYk36xAPrbEkkthy7GX+K2rmbpSwvfI395Mh5
         Jz155plEbwoDCgJvABQSeaB0ovWA34MPa/Pln0iv82xJTuJMmODsCoCcI3cZkkjONjuO
         X3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748923355; x=1749528155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZSYANcoh02egzStrY3RoKo9uj8NAmebnQzKfityk0Y=;
        b=CHNuYTix0CGrWawdoxnCTsJKy4jET0XarIJypmGK8NQbyR6F5SJjEufbi+lV+BXgwU
         7EsJJeKUltFZK7MSY89QG27K1sUVRpHdJXKnVSf3iU8rbCb5+2KfDjycBD9IjrD3SnRT
         Iw1LN3HNxv33Kcui/SUgwi/d7/Z8fcvE1lPqqXwiBsS/ncGyic1LYtyFoS72mABQIWHa
         n+LqsjvB81y2msHNKiDpY7BSHAfs6VEiBLlvhmw44g57Zn9+3eyKbqYX76hiogDIblSg
         315HlJitpLmsFCfFqbc9P91mEkwT8koaLR8qyDY6k7MaGL/Rk2W7+TgdIl6Nch/0TtJr
         pRQw==
X-Gm-Message-State: AOJu0YwXgOKr5MEFZpCg/7Gux+EQhmBuDrWEnIqn+LpsbrANQn+6IkdB
	snuwp3xYtaF/rhb7I85KFODt18ygUXGKnp3vu3s8RYTw9dhhw4rMFiOs89S0kdL+FFN+82H+ezQ
	Ury5DYrlObZ2zy2b5vlM+i6KPls9DyCrvavfFLuQX3A==
X-Gm-Gg: ASbGncuTXduSE/G+PUHUkgoQuLgs9OmWexpZpcCnhgaqvwtig8/9DZxHp95gopvqo4E
	KT6pONN9ryD+tirU0iJ2rhSD7QLeCfmWkgmaOsBK+R7/B9iEIBBIsUptQwMrBx7vQSusIbAj5EV
	cxdN+q6YdhJJ37Qd75+5cxyqM/4RX4Ex4=
X-Google-Smtp-Source: AGHT+IGkOetwlNnX5s8zn15GQEFGskzIFZQZi0/612ZECsIcqYmnwLKcrK2xZfNc9zdTQogG+rVr9fN7sa6upW9SCoo=
X-Received: by 2002:a05:6102:2acf:b0:4df:4a04:8d5e with SMTP id
 ada2fe7eead31-4e6e40f71admr14095821137.8.1748923354768; Mon, 02 Jun 2025
 21:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134258.769974467@linuxfoundation.org>
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 09:32:22 +0530
X-Gm-Features: AX0GCFvenA7GD9lGj2DxjtvBcXycpF-ABe7XpXNK4CElwwYaFXsTFnpt3eZB3Aw
Message-ID: <CA+G9fYt12w2ZvFdGf-m5d1y4BKd6rZXYya_2-++s1qLqZT=Dcg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/207] 5.15.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Nick Hu <nick.hu@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.185 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.185-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on riscv defconfig builds failing with gcc-12, gcc-8 and
clang-20 toolchains on 5.15.185-rc1.

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: riscv defconfig timer-riscv.c:82:2: error: implicit
declaration of function 'riscv_clock_event_stop'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build log:
---------
drivers/clocksource/timer-riscv.c:82:2: error: implicit declaration of
function 'riscv_clock_event_stop'
[-Werror,-Wimplicit-function-declaration]
   82 |         riscv_clock_event_stop();
      |         ^
1 error generated.

This patch caused the build error,

  clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
  [ Upstream commit 70c93b026ed07078e933583591aa9ca6701cd9da ]


## Boot log
* Build log: https://qa-reports.linaro.org/api/testruns/28635911/log_file/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.184-208-g5f6a7d9dc0f9/testrun/28635907/suite/build/test/clang-20-defconfig/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.184-208-g5f6a7d9dc0f9/testrun/28635907/suite/build/test/clang-20-defconfig/history/
* architecture: riscv
* toolchain: gcc-8, gcc-12, clang-20
* config : defconfig
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPvfQW4MFgulEP3Uu0GG4r5ra/config
* Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxPvfQW4MFgulEP3Uu0GG4r5ra/


## Steps to reproduce
 - tuxmake --runtime podman --target-arch riscv --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

## Build
* kernel: 5.15.185-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 5f6a7d9dc0f9396244df99f4b257b066f41d1f4f
* git describe: v5.15.184-208-g5f6a7d9dc0f9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.184-208-g5f6a7d9dc0f9

## Test Regressions (compared to v5.15.183-60-gba6ee53cdfad)
* riscv, build
  - clang-20-defconfig
  - gcc-12-defconfig
  - gcc-8-defconfig

## Metric Regressions (compared to v5.15.183-60-gba6ee53cdfad)

## Test Fixes (compared to v5.15.183-60-gba6ee53cdfad)

## Metric Fixes (compared to v5.15.183-60-gba6ee53cdfad)

## Test result summary
total: 50016, pass: 38348, fail: 1860, skip: 9551, xfail: 257

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 5 passed, 3 failed
* riscv: 9 total, 9 passed, 0 failed
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
* ltp-crypto
* ltp-cve
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

