Return-Path: <stable+bounces-98295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B69E3B37
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 14:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C5D281833
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1CB1BD032;
	Wed,  4 Dec 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWxOs2wZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B91AF0CD
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318715; cv=none; b=SM9l9CwtWTZkKGr7riH817QtflJKB/WqdcHvSJMtvNbDD9YLNgluynU8/Rf7BfbPrxpU9l4cw8Y8bqQ5hNnha4SCpE6T+1c8jsF32KFN4kzfIhpubbewCYIZGslj1tlL2NRFeFM5HOK2uwhpsgirjXTYaxCgyZx3VlSf8vgykq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318715; c=relaxed/simple;
	bh=heJcFJZ6wGpaq7N/UtzOsXHKhH2gA7eWMGRP8CzCx6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7pickGyGuqTH347E3Hp46WjfwqpGTPqq6OFvNE0J4plOeT4r06gLl13H7vMNDcQd+cdwy9BqsCPyP/qY8HZ3i12f8WdLx1xQ6uwEluSsqfG1zyUKKuZ3gPkY0aRNf4etEdJ3FZA+3EpzhW3AyD30J6oD46eQ3+PMq28DlYUy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWxOs2wZ; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c0fb4b437so409781241.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733318712; x=1733923512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyRVQVb/zI9kJmYn91wAT9zCQ5BG7fVZIEQs7VqoMNo=;
        b=wWxOs2wZzXB0N7zRkUvyforSHbq24OcGECtpV22iq0aJU31G9SChXZhQfNrOd/lsht
         2wQIv1p97MZtin5+JXGjpA66JqdigoKJBCvQ+aCFfjCZUMe2Yoe320dBGThXYJbMa2tS
         HbL6JoZSho71jfN9nvSSaAxWPZwZHZfWcVkC+7KRZ0aLMpOTTTA/OtYmxS5pir/y3IaO
         9KiMqov9pxv+THHr92cgw9rJCXIjI/KWK+UJmxrfIqrKFahXvkGOU3LBIDdXaUTNMesH
         NniIDO4njPgB7xp8hPYPKh6t55NnVJ8FWt+VzsTL4uYqMjhpZHXF6qs2DwrGPHM+qtYZ
         TIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318712; x=1733923512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyRVQVb/zI9kJmYn91wAT9zCQ5BG7fVZIEQs7VqoMNo=;
        b=hFkYfRsPxzphSu52eFxrPtylB8TZ2r+V9gCaCzBwiFWPJfvI5OqjhdYks1axP13yPh
         Ceu+S/oMUyBPx/YfXgPxJIv+0qbvWz2vYKKnCnvScm8MzIas1P6kYNm6SG5ggok2yyAy
         J9P8DzYUXThsAoyjgR1wqcvPSM9h0ipIQQE5kDOd8N1FWlsXF//kh17qyP+dYWtYlAjX
         dJikjhcqjfFgmKB/AFeHhPxT6d99I9+OqGcpqTYI94mQ8Sws+GOofhwY1SUHHVC+hhNf
         uAhmf2TySB/Dmg/4oX6uY5nbgoDH8yFPFAoBpBhL/ORDxqbbn3TgNz7lzf0UQ4IqocIn
         /I3Q==
X-Gm-Message-State: AOJu0YxLr44TxvSIRvM1G40UBGzTovXSOawCYiVb1QwLAh8JuLHNXNjs
	Eo5LxF4bXCRVRck0OMGKASw4j/x5oE7hHl6AcUU3hINOJq7SqczQrtHbDwDv9rplYN+ALvPHoDr
	XMU3WpVl09zHwHlmJqNWAPNIaEy1aGF1Fx3mYcw==
X-Gm-Gg: ASbGnctWxSujHPK+wOiyFy6p5LPd5a13Gla3+jsTrMK9Gmzk0G0dh8wC111M6Lh/zTD
	2nxSDBDo6gMhJs8koZ6MsxZeF76X06s8J
X-Google-Smtp-Source: AGHT+IF5Gr6rLMtOlq5rot61HhOPOQXJX5OJ6mgM08z0lylqA8xx32FyRxPhrJvcFQTp4nhCNYedeZJgiB8KDOM4SZ0=
X-Received: by 2002:a05:6122:620d:20b0:515:1fde:1cb1 with SMTP id
 71dfb90a1353d-5156a8e0b02mr24861742e0c.3.1733318711875; Wed, 04 Dec 2024
 05:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203143955.605130076@linuxfoundation.org>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 18:55:00 +0530
Message-ID: <CA+G9fYtNvEDcUEuv=QFC84y+pXY1UszoRYOitJztCApLV7-psg@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Michal Suchanek <msuchanek@suse.de>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 20:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
>
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, riscv and powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The listed below errors are the same as reported on stable-rc linux-6.12.y

1) The allmodconfig builds failed on arm64, arm, riscv and x86_64 due
to following build warnings / errors.

Build error allmodconfig:
------------------------
/drivers/gpu/drm/imx/ipuv3/parallel-display.c:75:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
   75 |                 num_modes++;
      |                 ^~~~~~~~~
/drivers/gpu/drm/imx/ipuv3/parallel-display.c:55:15: note: initialize
the variable 'num_modes' to silence this warning
   55 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.
make[8]: *** [/scripts/Makefile.build:244:
drivers/gpu/drm/imx/ipuv3/parallel-display.o] Error 1
/drivers/gpu/drm/imx/ipuv3/imx-ldb.c:143:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
  143 |                 num_modes++;
      |                 ^~~~~~~~~
/drivers/gpu/drm/imx/ipuv3/imx-ldb.c:133:15: note: initialize the
variable 'num_modes' to silence this warning
  133 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.


2) The powerpc builds failed due to these build warnings / errors.
Build errors on powerpc:
---------------
ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

3) As other reported perf build failures
Build errors perf:
----------------------
   util/stat-display.c: In function 'uniquify_event_name':
   util/stat-display.c:895:45: error: 'struct evsel' has no member
named 'alternate_hw_config'
     895 |         if (counter->pmu->is_core &&
counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX)
      |                                             ^~


## Build
* kernel: 6.11.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 57f39ce086c9b727df2d92ea7ab7cc80e89d7ed2
* git describe: v6.11.10-818-g57f39ce086c9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.10-818-g57f39ce086c9

## Test Regressions (compared to v6.11.9-108-gc9b39c48bf4a)
* arm, build
  - gcc-13-lkftconfig-perf

* arm64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

* i386, build
  - gcc-13-lkftconfig-perf

* powerpc, build
  - clang-19-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

* riscv, build
  - clang-19-allmodconfig

* x86_64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf


## Metric Regressions (compared to v6.11.9-108-gc9b39c48bf4a)

## Test Fixes (compared to v6.11.9-108-gc9b39c48bf4a)

## Metric Fixes (compared to v6.11.9-108-gc9b39c48bf4a)

## Test result summary
total: 130907, pass: 108166, fail: 1524, skip: 21217, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 127 passed, 3 failed
* arm64: 42 total, 40 passed, 2 failed
* i386: 18 total, 15 passed, 3 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 27 passed, 5 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 34 total, 32 passed, 2 failed

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

