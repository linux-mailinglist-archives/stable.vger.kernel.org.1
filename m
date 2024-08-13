Return-Path: <stable+bounces-67425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B694FDED
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310532814A6
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3D3A8D8;
	Tue, 13 Aug 2024 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zalPNQyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED8433DF
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531061; cv=none; b=YsG5qODCKqgh44IruNc3SRMY6xPRXPe2vHl7P0VgP6hOu1CVtd3/G/2GvOvc7/mtW9izpeeMjj7bvHoI3vbsoUjw+SdWTX+/G6KXBj4/e04zG4p1QNEjp36uH3ktQxktQPaMiQUa35w9I9WwjW9Z48XfMZ+IG592GQ1HZeEGKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531061; c=relaxed/simple;
	bh=575e9iWW7nVzsNnISGsVET3xlrP7uHg5pfRLkBr0wKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjAf7vkiQdRlOV3ORg1GGl/yjImSFwJ62IKbGZ6+5vbTHV8Kd74eVtw5jyXbiNq981d4TeEJtyvV9ph4BEtGFEhTjLMjAIL0nX6DEqsqMNdGEYHjIph2y4+OXq4HcUfyEhi3Cl+FKALXVIr8KtoxT9FJ6M3HyatqXYCmg7e6ZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zalPNQyd; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-492a8333cb1so2044706137.3
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723531058; x=1724135858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uz2Jmkcns8d749Zb3uEheyiW3HdBXWgL66GZJZE6ys=;
        b=zalPNQydwUQhZc2NPVV2lUFrfBWJ0CBbv0J5AYk0yMCrygVxumbbipMXTzy3D8FBL7
         x0ZeWJHgdUJ5f+i64cEFdZyi+khKObCPPMtulFD6wAkzXdr5yeSzc18QeHZUWMCmmxdk
         FcWDs82OtdVbKixH8WaqCM10wW2zAVVdxAGzCOQOHTGjmSCYLaI0kbDfZCGI/I2HsKKf
         Uwxs4Agkbsdn+ODhVgLy1X5Eit1HzLnP7yAbuzbT2njDUJZryRjSAOQWyjgCDclub6MU
         AZzPAt4SnXVtrGxYQrzYZdJyLFGqkp2u8GERIuCmkPJxDwztR/DRrHI/L+HBatY7xi7E
         gN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723531058; x=1724135858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uz2Jmkcns8d749Zb3uEheyiW3HdBXWgL66GZJZE6ys=;
        b=Rw6w5oorJO6fWwGQ5bttg84Tg9qewTQW6kpTYBHT13snFvPaZ4mi6siYwPmR20rfUJ
         ysQqISfXRK0reLwx0s70QQL3CmaxRRQyvu6pFLB/GFfYZtlI2GHinZfizVkzTHZmqW0r
         NMWR9hNCwSEecyEwscwAU3UlK8Sgo43ssKUMzYxRqU9F4b4Pu5y0EZZCfE5PmdZIA/8l
         iL7f5cDnbrvvBpjOmk7ZnPSllVM6jqJawGLKImK1iNgkwh7PazsjwvLE+U3hXiYmkBqi
         JsR8Fa56Bu+e9kGWxqp4zkgYari79LuDTe+RQuiMwXX0tlnqtjawt/rlMNF7RQ7L8+vc
         fnYw==
X-Gm-Message-State: AOJu0Ywt7RvB7Gzo6ngU1Vv5PdQHSpnvT0IBPChaUgpxWeI3dnt0ni//
	7pXVouLhCxfMV1xATPe07GnnM+kdEjyq1S6Bg2UJm86Hjy5uObL/awhOIAsr3+n0vgtXp9YiUmU
	VLT87i/G4dOlTGtJFScc4JMKUCbr3HcIn6Sh2lA==
X-Google-Smtp-Source: AGHT+IG2ESwnitTYkOo+FWcD0VMQpDANASDmAv4xD5kcE/eORlZ/8BV827KZrPu2hYKcoCO7M7t0/kYVHpLcMQxKyfU=
X-Received: by 2002:a05:6102:f0a:b0:493:e66f:6bac with SMTP id
 ada2fe7eead31-497439bd960mr3103700137.11.1723531058330; Mon, 12 Aug 2024
 23:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Aug 2024 12:07:26 +0530
Message-ID: <CA+G9fYsPJQ_fFjrr3tXCeByq+jHG9yHbwC6W66eo_+J8vmuiyw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
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

On Mon, 12 Aug 2024 at 21:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.46-rc1.gz
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
* kernel: 6.6.46-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a67ef85bc6ceebaf7fd3d7159f070b823d1dfdae
* git describe: v6.6.45-190-ga67ef85bc6ce
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
5-190-ga67ef85bc6ce

## Test Regressions (compared to v6.6.44-122-g272b28faf61f)

## Metric Regressions (compared to v6.6.44-122-g272b28faf61f)

## Test Fixes (compared to v6.6.44-122-g272b28faf61f)

## Metric Fixes (compared to v6.6.44-122-g272b28faf61f)

## Test result summary
total: 188519, pass: 163267, fail: 2264, skip: 22632, xfail: 356

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
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

