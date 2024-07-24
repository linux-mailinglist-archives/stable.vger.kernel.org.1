Return-Path: <stable+bounces-61316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51C93B62A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38C32856CE
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875616A938;
	Wed, 24 Jul 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cylgMJ7g"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A515F3E2
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843534; cv=none; b=JYjMR51EIk+blU00MrMt4K1c7S5aOHyXOPHBu47YNzltfFZ13Ttix4LAOKiv5br0CFKOI76dM4WYTldXLWzraHGWS7wZ7EfpeoOKcY7YhlCvMqv4UdKv+GX8qfDtnts6wCIa+/n8bcPgHZ8LsZOroyfMzSC2v2nUdXTYR7nJANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843534; c=relaxed/simple;
	bh=sDqEtWlJep7UpmEpWBsJ6/EhrdvHDu2nMmYUG7ZwuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6sIX4or+xDPl9xzDwcgsQQop18BWjVCRaSQgnXiZ9w70+KKDkL6agmkYQuIOMyy7qvlkerh2ANVuwQi0UB+iwUkoRTog66e4UrzNqLont55vEUkiHpQr2onYQi4yNQ2RjOuA0oT8ypiGM+ZFoLiZpJqYJQtow1cyqMKujyW3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cylgMJ7g; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e1c721c040so35281e0c.3
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721843531; x=1722448331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3adP2UhJX5T3M5okoFY956EupvDoXGJ8C47+StOUW2A=;
        b=cylgMJ7gVWClhMVjrYpnKqYr8HlqTUt5fNGn50vcPreaznMQ5f5mxR8J0APeVl6ix2
         /P1R6hBnsLtuaZDUN3nyQs8P0Ibxhr7Kili0Cok7vxGc3X26sEmp9cflpAvdI+Al1LjJ
         M3zNDtFv+v4K+EeI3aE6di+TOAFI8CpXgEezy6F3rOgEHYB9A62H3R0Q+fJGhn6esj7s
         AFkq7CqxHJakyjVVywoFxpwAjponz6/uf0fWnRQaf3TNChGYIPUlFJQSYdX3pyvwkvgu
         UEkOfI6QS8QRQLK1R423hNy/ENUQsNVSiecxdtYenHjNfymb6/2d5MDM3xmQPx8r0iZo
         OShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843531; x=1722448331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3adP2UhJX5T3M5okoFY956EupvDoXGJ8C47+StOUW2A=;
        b=g3pSWVsOdZsayH94OOPA4nVUsb1IozrDxvp8/w4FrlYF8fze7f9SK2FiPwEouPydYz
         hm++dbPllcEray5ICbI8DwYXpNKpHu0i8Fege1Ro9cg9ssQfzfIC+Wf3fwnAfJ5GOM7f
         w8bjVPfrsLFf99+4IekUPNpJqwmCLKSrr4B6Kc+JwoPix6reDGH8q5c0LQn3MN2kNs+Y
         w2sAvwbgOCHkelSAqtlrVx82mnJRysgN+gzaTIXRxwMWwdA4AMfrchj1rhiifyUhjZ+n
         n6h8Of+pGMuqhqBuPBtMv9ZIvKsTqJ6aJTsLoI00CboiJy2kPNaNAjfYSYlDfAs1dYq+
         vOhw==
X-Gm-Message-State: AOJu0Yy2kzdoy2lUFIUDg9L7D1gng/JHpKi1lpmKgTe7l/inEzKWcAAf
	vZJ0EEcBCFeLtb8C2YN833o8gCT75aQ8lsZUTj0vW0mrFC7Y7S1x0pstSNyPVV3XDiXbncnB/fE
	w1D+sWPADBgLVeWet2NcJp3ZTFYXCxw725wq6rQ==
X-Google-Smtp-Source: AGHT+IHDm4xN+JjWbVMfPd/q71cCC0mZwVm59ulmwBR9BIVHJjfHQ8SmfOsC5ukZRzHyTX2Y4vFe6RWDk3SgDvFSXQI=
X-Received: by 2002:a05:6122:4599:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-4f6c5c49043mr948024e0c.9.1721843531425; Wed, 24 Jul 2024
 10:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723180404.759900207@linuxfoundation.org>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jul 2024 23:21:59 +0530
Message-ID: <CA+G9fYv0KBij75t=mCJ82C8-Mzv_gFXTEqUFUZvtvCzA4D2d5Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 at 00:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.42-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.42-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c74fd6c58fb18e0bab49dfb540cb0a9b3bbddc7e
* git describe: v6.6.41-130-gc74fd6c58fb1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
1-130-gc74fd6c58fb1

## Test Regressions (compared to v6.6.38-261-g6b4f5445e6e6)

## Metric Regressions (compared to v6.6.38-261-g6b4f5445e6e6)

## Test Fixes (compared to v6.6.38-261-g6b4f5445e6e6)

## Metric Fixes (compared to v6.6.38-261-g6b4f5445e6e6)

## Test result summary
total: 220969, pass: 191018, fail: 3225, skip: 26302, xfail: 424

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 30 passed, 1 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

