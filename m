Return-Path: <stable+bounces-172569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34DB327A3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CBD1C81283
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7B23BD04;
	Sat, 23 Aug 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFSzcjtf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B794135A53
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937982; cv=none; b=FOUU7EOIc9DuDvT56eBntZaveWeitzhgq9mITFe9hQIztQ8hWiVQNAMkocIAUXPOPm1W7hNUPQDETX+NUVgY8J5+uJuCWiju2uu5g2pYB9BSVD2DyPlJLbU+o9GH7D2u1sBWBzvU/hyGhwTU2Esbzi0FbK3YM7aTAzjvneXvAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937982; c=relaxed/simple;
	bh=cC2R7dIC+jmKJ5KWCAUHe4UcJxwQJaOLa1CkUnwlYEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Yi/rtY8fvGNIiUJ1GNCjPrxiZoAbER2c68leM5uuByL5wKaiIMWYhOTZ7N/y89ZZPUgZaqNEJgA5u0/stofHNoRvzYwV5teDNKGfxQHbvkjLjBavmnaA8dA5v+6tS0AwAH+1LTgCiTMU1tEZmLzi0eazztG000dVX11Thh5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFSzcjtf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2449978aceaso20536175ad.2
        for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755937980; x=1756542780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upHWeEzdtTZrqoNSv+NWSJs+RM6eMBq+4oXrZP7WELw=;
        b=OFSzcjtfPvEHPF7nu3sGzvOVIicJu4UJR1dw0A/B33umW7Wfpi8623h2t5Xo3N9P5z
         wyPkU5wlGkjHlLEiSHu6JuuWJm6juYCc6k9tA7yZbgvN24NawL2zS8cUVAo2tEMNdhMn
         eJL+rcTDOBqSgC2wogitjf3M0oCyvURlrf+NvyVtIiXpzB+Mt4CJM3gsJ4oNfGb1Zv0T
         7JIZ8wSYvKVLBUZHAnVZtXqD5S74Tz6ZxpbVolHeQYs2E/SL+zKgTIrTxJJQexK2zhk7
         Ld6h8I2hPP6PPAN/LZ4PuvNJDLpzBYGvAuMgoQ9Gb8/ajHBWuXI8YshFuo6D4MBN99HW
         12zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755937980; x=1756542780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upHWeEzdtTZrqoNSv+NWSJs+RM6eMBq+4oXrZP7WELw=;
        b=QpL92tAy5mtP8UTWf4qL7gk25hKhEZUWIbzfECsNA2WJKw1Krp/9hzFXwM7JIz4UhH
         EFJubjfoCbLyGjRUoW58lH4pHxDan35R56shjuefEr9aRkDbYtgoFzJIPWUqRMU+ogcg
         1Ovv2kWKf5rctZMNz4i6I6P+TPyAGIJ9u0j6epIJY7VO7EA5SV8jQLFz++pr2uHV0Dvn
         /8FCN74dLMWfCwmeAma+KoMYGq5kdMnAUSAsu8PjeqZV3cHHqvBdO7tbPPZyOlQx7S5h
         RQdeqx1+gQmZLVTk1BY45L+Q/NiVZEEmmykz3w/58xVg05grMrp2ijysLlVmAfEkQQce
         1aqA==
X-Gm-Message-State: AOJu0Yw1EULYJhPUriukd0jy0fTIsVxN1i5Jtu0iak8Vz0NuJT5aPiFh
	YgznCUDzhx8YpBiHxjdrM3WMcn82U+i6NfzYbD0c75AlRBGzxqnkvkIA/X2TmMRqSiddg/Q7Z59
	QS+G9jYYfOTjbgGbHAnLdebQTeQeZCz8UCFjPh5jYgA==
X-Gm-Gg: ASbGncsUqT4uN34vLUfrd06JSj5PHfm6hCVEdn1iiPeRCxdtdAmS2pnrOehIe4bMgbH
	EqGkXKqYTEEFiKq1nTt3HMHAKVn3dz02FN0NM3Z1pNskJO/tQ38X+0s593kkTqcO8v5eGLTt2Gy
	g2pb8c/CQsHADvFwQ/GYFhlfau6iZSwp3tMnkeD+220zzVZDyzok/BDWE8G96TEEcdPs/lmlW5n
	f8yWBPWCCm0E3EASAYCiUGEWfTJlOokQttugn/7
X-Google-Smtp-Source: AGHT+IEQN4YSKtPymn606DVFVKKtzEvavaQRMuxmngqfsot0SA3jrZ9khNjbXYGtoFrClXENcn7IoJUJduyhb8F4KS8=
X-Received: by 2002:a17:903:2a8b:b0:240:7753:3bec with SMTP id
 d9443c01a7336-2462ef98a97mr61538175ad.51.1755937980301; Sat, 23 Aug 2025
 01:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822123516.780248736@linuxfoundation.org>
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 23 Aug 2025 14:02:48 +0530
X-Gm-Features: Ac12FXydinZ-k0JFp2vC7EjM9psfTWKA5t0I3ZApJXylszGwy9_XUiFZWgGwYX8
Message-ID: <CA+G9fYsNyR2RSUFEn=1v157mtJ3vrL=__vWidYfWrbaYHe6JoA@mail.gmail.com>
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 at 18:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Aug 2025 12:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The reported warning has been resolved in this review cycle.
WARNING: fs/jbd2/transaction.c:334 at start_this_handle

## Build
* kernel: 6.16.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3fb8628191b4a7d912baf880840804056f3f44ad
* git describe: v6.16.2-10-g3fb8628191b4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.2-10-g3fb8628191b4

## Test Regressions (compared to v6.16-1186-gb81166f7d590)

## Metric Regressions (compared to v6.16-1186-gb81166f7d590)

## Test Fixes (compared to v6.16-1186-gb81166f7d590)

## Metric Fixes (compared to v6.16-1186-gb81166f7d590)

## Test result summary
total: 348595, pass: 321612, fail: 6867, skip: 20116, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-mm
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
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

