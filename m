Return-Path: <stable+bounces-87633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3B9A906C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32924286FF8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFE1C7B68;
	Mon, 21 Oct 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="terkjER9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E51C9B82
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540649; cv=none; b=HvDXAsScwj6xxNqGjNgS7YAjPrf7fQiZLLqPgBNN9H5ws2YctA3bVbMX1T/SWvrBXsMOf9FKU5Q1m2cjI78sxLvQ44Kzq3CLRISA3eSbXEy0YxL7WVIC0sDsi2mpzVJK2hzZkte64OXtG+u9MOVvvY2SSIVKDHLMBcIByE2MsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540649; c=relaxed/simple;
	bh=qOutugFCpepW8u5UYINmN7xH5gJdHqlJntLv8cxtA44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJIsz1ERH7yJsGL/Rhl+byGAhP759l+HlxxmDG/gxcWXihrGNMzDsC7hjKInIxAGLLCRNeBdjFMU/q/vl1lQYClR2CLgap+YRg3acmBNcf8+R7q/0fDhEalqBframx5YiFqe8BM83M9yHXJeFnQxrQWP8kVIPwDAXqKAfbn0cXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=terkjER9; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d3998923dso1604748e0c.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729540646; x=1730145446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH/iMGwmL8zueR5LtHUH4E+NzMcpI4d6jTgQKxN0ldQ=;
        b=terkjER9482u2PmNWP+wabj3BeFcvIdYFGJAiNf4FD+O/iylMpvlcEx5aqai52pdXQ
         pa6zJ3gMzUryrWfOKB1/5BDIpMl09/QZs5lYHSN+fTXeO+9XDRLJc8vZOkopetsZZA6d
         5ekr7VK3TobGtUcsKTaEftzLjbF4bEKHWP5IO5BfI0d7surtiCWlVoB6tgC/8nDQMM3A
         B7p5J93HWMuFktNELj1eQ6YdophQnudLw2kKe1AhTiTuUl3eEhSdjCnHeKrIibs6RvpB
         ef540MpSmr15nDlK31/5r2PiKtXk+WoM+NI65ysBawLRIsGJswzh5sySKjZMy9pYm42Z
         1FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540646; x=1730145446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH/iMGwmL8zueR5LtHUH4E+NzMcpI4d6jTgQKxN0ldQ=;
        b=BYJBenp7tHhJtXdqb4Ec2lkdyDsj+YVgkI2krNtLVVnJtmsuYkIzGAbFocarfcDs5N
         vCH2t2ZeD/RRNGvxKHxIO1nqqJNq86jghHEo54TQusRNJ1VVgQQ1M2NvGXCRHrNz/DOA
         0MxM06HoPWoqzFPTBJ61KLx6PnEDsW78qu/Nt4cwPiO7mY71uEQ4xzHqxYWoW83qk5eu
         obW6E/nJ99nJJblvbHc3cc0JpCaktpb8RnvMF49SJGFyuVKyxgyIFhPo1Au5q0qGjbw+
         csRm7eDU8qx2V2WqcNP7XmQfXuujbZpFj0ApIMW53cS77tpYyqymfWscwMntpzdaqbi/
         e4gA==
X-Gm-Message-State: AOJu0Yzf97uNHiwm1GGoAp+qySK4rnq4Pl2CC+fBbl+OYFbq76YT988y
	mhakTknSz4aI334DA9kU+PQcmsTfj4J40cXyIGhGAuO8wgC9GuTN5vraFtpnqesx3prNv2VFw8Z
	5UDaWyWlKpCoGFSfwji8QUsiR9wksL5T6VmaJ9g==
X-Google-Smtp-Source: AGHT+IEAxK901tOLYft3Q6FSmittxptvWwx8UI67LGet/0+2dqQn/zWS1SdC2S2Ep467Qgo3yOephfFiNjAr5nswFs4=
X-Received: by 2002:a05:6122:65a2:b0:50d:2769:d741 with SMTP id
 71dfb90a1353d-50dda3a0fe4mr9320092e0c.11.1729540646150; Mon, 21 Oct 2024
 12:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102256.706334758@linuxfoundation.org>
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 01:27:15 +0530
Message-ID: <CA+G9fYsZboqX-V7-uyuSHH9FpOQXX4ZKH=0hXq0nea61tPNN2Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.58-rc1 review
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

On Mon, 21 Oct 2024 at 16:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.58 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.58-rc1.gz
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
* kernel: 6.6.58-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6cb44f821fff24ed5cca1de30a2acc48ec426f1e
* git describe: v6.6.57-125-g6cb44f821fff
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
7-125-g6cb44f821fff

## Test Regressions (compared to v6.6.56-212-ga3810192966c)

## Metric Regressions (compared to v6.6.56-212-ga3810192966c)

## Test Fixes (compared to v6.6.56-212-ga3810192966c)

## Metric Fixes (compared to v6.6.56-212-ga3810192966c)

## Test result summary
total: 111049, pass: 90448, fail: 1389, skip: 19120, xfail: 92

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

