Return-Path: <stable+bounces-98293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A99E3AC6
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9455164253
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBA1BC08B;
	Wed,  4 Dec 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uG0rJY64"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EF1B6CF9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317273; cv=none; b=NIz+Xhz/6XI/bkBYYzxCUCS1lvdKm5PrIL3lOTWw2bMGICflifS7tugGzxXK6A3GsJoe2dJ5N94fRdxj710A1FM6ZaxtzFM0ehbIJLWB5/bZmZwSrlFhTAywNUDuj3GHg6F3RqeyzKFn4WtcIBWCUt5YuBhHub1lMr6FM66JXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317273; c=relaxed/simple;
	bh=5ILmEqTiQzWMOMrrhvDVYhyp5VUJ3IUTTE1tEB2Ycdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUO9MfC+ZVcYDaP1SeIpAAbMlofyk5ffztb4zmFfNwdIg45L0Yomfa2lxmS/mhixvDNWxKRquT3ZLpWtdgtlMloM7zA0cWxD6TF0eKfFtpojqoiL0nsMacIqHp1886zSEf/qRgiw8kgVTeIFFSKKh8QLe7fJmcT1aoRVUWIQn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uG0rJY64; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b65d1c707aso488055385a.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733317270; x=1733922070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpV0x8eY3pglXksgasLFNdR3HbZHXmyjX5FpR9r0Yfo=;
        b=uG0rJY64Q600BACGASWqTsnuWkY6v5Z/9EuNvy3FHHzZr4W8FoRHrsHQb1Bts25V2J
         1H96AnBWPK3VW+LtFdVzQSXmv2r1ojVl+xwu76Wcw2aqDpnUZlip3eruuyVwGb0v+r/d
         JbOMUMGXDAjlX8eErKeHXAzs0eOV1gYzogHc40z6Awo7rzyNhVN7OdZcChy3gBZVh5XR
         rPfg30ALQufAAI+BvPVI8jbRRZcq6IjBymc0cfAgiWk+bDmGCEEN/vwRXsD/dQT18sAq
         3f1IlwS6deldFtRvtrMlu0B6QtTumv5erVpKquFnmIiQagK/0stbSQ3K3evYCl1sKvfm
         ZIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317270; x=1733922070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpV0x8eY3pglXksgasLFNdR3HbZHXmyjX5FpR9r0Yfo=;
        b=ocef7YYVvucE0rT2TaRLoESbIFFm5Y0GHSP4sI6w4anA7LnZX4ZpJ85mCpoJQQgWqh
         HmnmyaVDxiAGEGtxoFhbh16ZHn1O0n+nTFImKDF9261MTwvTCI01othFbUZNmG3yHBgK
         PaozCvUC8tThw7G7sSS7FKSP53/lMKRWqkv2p6mLyRwAkdPnDAVBk0yJMqVqdnR2bhHc
         i4rPSxtBXEboH84Zf0R8JUC+lnGk3OfRv5SX32o724qFshdUg3rCwGNcpVI6MtYloHVE
         s6HGk+tztPHk9jja3za6c9nnu5rjzqc/+I6OtesrUuXSlBLJ2gv9W1EYYnYd5N6EHnRZ
         4S9g==
X-Gm-Message-State: AOJu0YwLNUrv/uYRAEKIo4ktQKld0+UYsExGL3Y389manJLJyFONDi/w
	oXuJX5swJDussN/xTL8vz/n05jBAWiW7aLGlWCrPbIuw2Ffv5PoRTTuVmc7HkVxXohGRii+meuZ
	xZ1SnryUR+rvDhsQcU5DyrUhxyukpFLFpVMrtWln8Ern2EdcBbEE=
X-Gm-Gg: ASbGncvzqjMEQHwUXKkGPrqn9obcGDagIpqaxpS/dpmg3oxxkfFPDCHjDgGXeE2+BVc
	S04PrhyqiBTuQcGmbMkxW/46cVwXMwlBZ
X-Google-Smtp-Source: AGHT+IH+iTIPjsJVLJ1TxqzWa1PXd6bsGmH6/EGI/vqgJHKP761HYaMPr1dif7uYa4ILxAw1c15EM8Qscw23c6n3EfE=
X-Received: by 2002:a05:6102:d93:b0:4af:b127:6742 with SMTP id
 ada2fe7eead31-4afb127685cmr756838137.21.1733317259252; Wed, 04 Dec 2024
 05:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203144743.428732212@linuxfoundation.org>
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 18:30:47 +0530
Message-ID: <CA+G9fYu21yqTvL428TFueMJ1uU1H_u8Vc470dER2CTrNK=Js0g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michal Suchanek <msuchanek@suse.de>, Nicolai Stange <nstange@suse.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 21:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2024 14:45:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 riscv and powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1) The allmodconfig builds failed on arm64, arm, riscv and x86_64
     due to following build warnings / errors.

Build errors for allmodconfig:
--------------
drivers/gpu/drm/imx/ipuv3/parallel-display.c:75:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
   75 |                 num_modes++;
      |                 ^~~~~~~~~
drivers/gpu/drm/imx/ipuv3/parallel-display.c:55:15: note: initialize
the variable 'num_modes' to silence this warning
   55 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.
make[8]: *** [scripts/Makefile.build:229:
drivers/gpu/drm/imx/ipuv3/parallel-display.o] Error 1
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:143:3: error: variable 'num_modes'
is uninitialized when used here [-Werror,-Wuninitialized]
  143 |                 num_modes++;
      |                 ^~~~~~~~~
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:133:15: note: initialize the
variable 'num_modes' to silence this warning
  133 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.

2) The powerpc builds failed due to this build warnings / errors.
      ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

3) As other reported perf build failures
   util/stat-display.c: In function 'uniquify_event_name':
   util/stat-display.c:895:45: error: 'struct evsel' has no member
named 'alternate_hw_config'
     895 |         if (counter->pmu->is_core &&
counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX)
      |                                             ^~

Build errors:
---------------
ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

## Build
* kernel: 6.12.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1b3321bcbfba89474cbae3673f3dac9c456ce4b9
* git describe: v6.12.1-827-g1b3321bcbfba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.1-827-g1b3321bcbfba

## Test Regressions (compared to v6.12-4-g11741096a22c)
* arm, build
  - gcc-13-lkftconfig-perf

* arm64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

* powerpc, build
  - clang-19-defconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-defconfig
  - gcc-13-lkftconfig-hardening
  - gcc-8-defconfig
  - gcc-8-lkftconfig-hardening
  - korg-clang-19-lkftconfig-hardening
  - korg-clang-19-lkftconfig-lto-full
  - korg-clang-19-lkftconfig-lto-thing

* riscv, build
  - clang-19-allmodconfig

* x86_64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

## Metric Regressions (compared to v6.12-4-g11741096a22c)

## Test Fixes (compared to v6.12-4-g11741096a22c)

## Metric Fixes (compared to v6.12-4-g11741096a22c)

## Test result summary
total: 157764, pass: 129957, fail: 2971, skip: 24836, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 135 passed, 3 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 18 total, 17 passed, 1 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 27 passed, 13 failed
* riscv: 24 total, 22 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 44 total, 42 passed, 2 failed

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
* kselftest-watchdog
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

