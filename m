Return-Path: <stable+bounces-118711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF61A4170F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781EA7A4144
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DB86346;
	Mon, 24 Feb 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiGqBVpB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918A17548
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384953; cv=none; b=ihaNanZxSl4nARyibX8xcdoSRZjPuHb+kkO3OQRqy8M9M/RxLwsT101OH+THaLoIKqEN0sAxGy/nUZ6cniaf9M3xNmaBXfbZZDz6ekVgOHYhfXhTN8yzHwOs/QJWosWgJ5xfszGhp7dfriKqYtSU0AxP1abO8NXdn6FN0EFn4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384953; c=relaxed/simple;
	bh=GWOmq/SU5FvkARyYsOTefg//x/uWpGN7kXITX55gZVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrrIQVczwaklIZcZF2sa5PBXCQ1JH/Y8tWZG2Kpw6MCz9x8IbR4Aiy92ayVqzTnGxsLMWuXo2UDKNd7cI672mUDdSdz0B9qcESY6B2I9RecHlpj6v955LxKuMrv/xjOHtOg6/RiwqgjxSoGefLKg9849+vwP/MDU9GC9i0S88Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QiGqBVpB; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-868f322b8dfso2575450241.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384950; x=1740989750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfaExuEzw+yi+UhF0ndMdtO6v5AbFoFgAvWAoNTpMdE=;
        b=QiGqBVpBucbY6AY5tKq6DDYg+NqXoSE7vEmYQXgYiMBTYs8V67DbTmdV1WFoAwvrkW
         xBOFiAV4g2OKGfsQhlNk8OHJzvMOimfVSiV/j+6BY518o+E0i2qU2DeFy6c5haI2PX6e
         r7RVfdQLUcAO3/t2IGnTHD9+lX2TaQtGVh952Ys76/tcIEAQtSje9aGVgCIz4RVcZTSg
         Rioh8y6EHPW5ucsw13HXe+9GsyJsD6PFFzRF8vtssbYUib80kF9sLCM6wCVAplwpnMEt
         WcnnhzEbwDOlFFx+LtuBGAG4dpAzCoG3Pae6g5ZH/DGv/VIp3oNVj+j2zwsJ21I5JqKh
         jQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384950; x=1740989750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfaExuEzw+yi+UhF0ndMdtO6v5AbFoFgAvWAoNTpMdE=;
        b=vsWxgfUcy8aKT/AlqE4VOkNv+LLLJZPWvICaIHnRuwSkRtNZ0yn+iy7id3fEh7vHb+
         XkAYx0ctmoO6ejawQyk3h/ozcCT5OrKYYjncVp/5FHbnFxK+TuM9fKrIh+38OXeMNzPm
         hi8qVxsV2ebEg8oGRayMAIbi0RJXyuJK5Bguh9ogTGU9yhKO6+Luan12O0JLEsQfEbd0
         wYhlfhtaNFz537qQy622lHOu95SOMx0ebL+Nxh+RfqYhoJKIykuLe9nYP4GSeWeZOeJG
         tSYG3C0rTu+411KNEIdNERpsnI/0hGmVKqaklylp5Au77bfIAfrmzFt5hGQzrAb5FTld
         LFMg==
X-Gm-Message-State: AOJu0Yx/FxNPobE5q8N6rCKs7ri2B6kaUH4XpPtLTBtK9DNrCayBVPVe
	8JKDqHUGnoc2Mt22CO7qBaGFPTmicDfYpMrtRco3QbdHwTwEdwnpWdzZKxYtsTwnI8TgTtgTyiy
	12EwDp4fqhif99qY0Xb/usBP6f1zUMixDulbTdg==
X-Gm-Gg: ASbGncsaasOI/u6IXxp7SKgOMNPWNap0QRsd8XBa0MInUuTjRWW2zcaBjsw5vieZhRw
	YhZ1XfhbaI5NL7nw5yMpp35zbtvdowp7MuW25ifv9ScCbD6uusVugVrvoiO9PPcFsmvKHEwFBmi
	UIicGjdgIqfiruFNJ7otPh1HEpD5fH/9Lv7kPVPL4Y
X-Google-Smtp-Source: AGHT+IFc115RJeH5JT0j+3w3wvCrq/AUOfV/8I4K53IvbnOg1TsmznhiEqqpup4LggCT7+8+VL7ZRrGjE2PExyTSqDg=
X-Received: by 2002:a05:6102:370c:b0:4b6:9ba:72c0 with SMTP id
 ada2fe7eead31-4bfc0d99c32mr4822022137.1.1740384950049; Mon, 24 Feb 2025
 00:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104454.293283301@linuxfoundation.org>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 24 Feb 2025 13:45:38 +0530
X-Gm-Features: AWEUYZn85dY5ySPbnb-rOAoLV4jXZBzx4as3Ge9fLIUK21jmGyMeitK2qFepA6Y
Message-ID: <CA+G9fYuokw31OLwLC11ipPZ153PT7+mEddA3vF=KmPMF=ajvvw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
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

On Thu, 20 Feb 2025 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.16-rc2.gz
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
* kernel: 6.12.16-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c3d6b353438e989b2ec07730a3454b583937b796
* git describe: v6.12.15-226-gc3d6b353438e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.15-226-gc3d6b353438e

## Test Regressions (compared to v6.12.13-419-gaa95ced31609)

## Metric Regressions (compared to v6.12.13-419-gaa95ced31609)

## Test Fixes (compared to v6.12.13-419-gaa95ced31609)

## Metric Fixes (compared to v6.12.13-419-gaa95ced31609)

## Test result summary
total: 126820, pass: 104027, fail: 3980, skip: 18747, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 20 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
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

