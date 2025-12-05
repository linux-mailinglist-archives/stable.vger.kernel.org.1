Return-Path: <stable+bounces-200142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC17CA7270
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A3B3301458C
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218831BCAE;
	Fri,  5 Dec 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im/b7/M6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB16311C37
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930369; cv=none; b=RZyml0rq4mmnSYYXhkbQ5+iaEaEg72ONFHTQJbUxhkQRGrjHiQeUSfS2mhx5GRGbaW5G+ngGR7VbKS3dQNQvfORNagDivLLSFTp37UZAZlhmlxJsWixEXlpLF0GjErF81awDrDM3+hVbZAa42dWGr0raur7hdC0a40RH44S9bxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930369; c=relaxed/simple;
	bh=0X44rTBFoZxC528+irDpQ7IbGw+Sw+8vgkxtYkeRM54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw/lhr6TKTQ6s7/mlMe5we3Ki4ExWcnPaGvqZo2wQHyJ6buTGDptCLpZJgJPeXHk9O8PLhEaT8bNhEygUMwK2DLr+Gmc7tjPBXTDNwO4Q2Bl6zOA0WrUSQL5Mh1N3bcWssfvdvc/V1S7eOTFSV8rbRGgydV900ZN6angqNV2x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=im/b7/M6; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2a45877bd5eso3944550eec.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764930357; x=1765535157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdDYSUXbreK3nnvrwRaDva3mvj8fpQE8bz0YdLVbpgI=;
        b=im/b7/M68WbdekfVyXVko0/yrv2ijAur4kZyef5PICVRbJnuU7C4IX31P5TntDH4Vp
         UxlSiNv0B9QyhlDjWug0222H690WgV22YC9rtoa2FKrljO7Rnpz0fB8KvwP2j4nAxmCm
         4HJQTWKQijNgyExSzEJnH7hObGe4EQlFpFwoL5I92emgdZ4PfjAVNoRb10h69Inyh5k8
         /pGPUPDsEZ9mKTD8Hw0XogFKPwM6AFY8+oredjuxdecpjNc415hNi+G8x7uRjlE7vk6R
         VOctOep4nRs67L1Zk6QSk2USXJz1UNXRBn2EsbbHBAYB5aFN+un/4kYBBEygp+ocTGCM
         /gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764930357; x=1765535157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdDYSUXbreK3nnvrwRaDva3mvj8fpQE8bz0YdLVbpgI=;
        b=jSR2IPvSQB81SUJ9/D/074mEmTttE6tDn5tDVhLiyHzTWifzlhIN3eK6cGDZgOfU4A
         72nUjaolmZVVsOIX4imr9iYsmQ9ApgG7FUeqOMKHB7ovJ8RXUKXQLm0wEzAZDPtUiLIk
         jk2S6+0L9jEK7qYMRE/2HGgvHWjswfyR33R5eqVI9ceioijent2zAo5dRf8lrQgPSrCq
         LVjXXLil/akK1q9zEwlaY2pgRlOASbxiCMLMoPP5pw0BZRVYrcMbeJUjoYoiEsAbV9GP
         Y+tDB6d0T+O/e7XHz5APNNZmyzU4p6EcSfnqOtEsHS7Cu27ziDOMsYjuk8o3rRBxPN2d
         iBGA==
X-Gm-Message-State: AOJu0YyTYZkfDy8PC42CVFe0FR0fVi6nPrr45YMNkMwAt8klPj94D33d
	1Ml9y+Pz8whZvGKmbC936jz+Ks0bDHS/7q6BTHsHhphaW9bsgCiof9liOIa0i6WLO4agBDCCh0p
	hDcMOddOX3oZOQG6YIEYiJu8s74Y2Wq/Z+kr2Fxcd3w==
X-Gm-Gg: ASbGncu00b+vDXTG3hk975GcLuxoFnDjyPwPWNYmFm3UqwtZtCExwqRfG0ghLbnBszR
	J0JyG8lR/o9b6+KYkzs5KTDx9fatKBnyzc0HFeLuc+z7ki2aMnIfci1tGgKuxLnLbSr3y++QL0l
	2mFtgyhHqQRzAw2QrFDL/SsjoPIHTt7XSqLKmKzouDpmxlq+/H132xRWxMB4xBy6xvaYbY/UxC/
	B1buZO0z/ZQeM+bernIfPy2NYKsAFZMfW9ucJpBA1Ocx7Keo6mgAT6qkZx5IM/iQG+yD4vK
X-Google-Smtp-Source: AGHT+IGgJz5h9CNdhQnno2YzTuv99mFlBnV8wRHbHHIQaHsCuf7EysXn8e17W7rmAS+9f2bw/nXBejCaiWufe/9G7ac=
X-Received: by 2002:a05:7300:7b94:b0:2a4:3593:ccba with SMTP id
 5a478bee46e88-2aba33eb71cmr4631451eec.1.1764930356732; Fri, 05 Dec 2025
 02:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204163841.693429967@linuxfoundation.org>
In-Reply-To: <20251204163841.693429967@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Dec 2025 15:55:44 +0530
X-Gm-Features: AQt7F2pXdOQvj13bd5jjoOZPeEBtuzEGfrQaH4valfbj9TAZee-tH0PkAeLKvEM
Message-ID: <CA+G9fYsPdOY3U8rMcBHOvKz1JVjApCfZxry2GvO6bE6sKGbedg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/567] 6.1.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 at 22:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 06 Dec 2025 16:37:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.159-rc2.gz
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
* kernel: 6.1.159-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2ee6aa0943a7e281eb5db51475b9c7e47d30be9f
* git describe: v6.1.158-568-g2ee6aa0943a7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
58-568-g2ee6aa0943a7

## Test Regressions (compared to v6.1.157-158-gf6fcaf2c6b7f)

## Metric Regressions (compared to v6.1.157-158-gf6fcaf2c6b7f)

## Test Fixes (compared to v6.1.157-158-gf6fcaf2c6b7f)

## Metric Fixes (compared to v6.1.157-158-gf6fcaf2c6b7f)

## Test result summary
total: 87788, pass: 72727, fail: 2957, skip: 11908, xfail: 196

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 1 failed
* arm64: 41 total, 38 passed, 3 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 32 passed, 1 failed

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
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

