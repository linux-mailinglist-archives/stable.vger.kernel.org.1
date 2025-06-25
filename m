Return-Path: <stable+bounces-158529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CBAE8077
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647153B303F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140622BEC39;
	Wed, 25 Jun 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4fCyjnQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673D2BD598
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849084; cv=none; b=CobRl/+k4vv83gx1lGMfUjPcAwKvaOHrUOFAf4J54TssDJb9KQ4fO6VGgC3Ikzr9sEU8y0E3IYKGMWY9rKcvbr9k6FPXDIkeJa4cysm6dNUhKCdBH65j83wOQybBpB73PWLjjK82C4GMqEWVh705E7f8HwcWkivEvnERWxO+WNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849084; c=relaxed/simple;
	bh=D72mDsP1erYv+cbvWDuoheOFU4iq9ltrX5rHkzuOLfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qulD1rKsg5kwv/S9e+KqRTawFWhVe4riNsNjfIAurFtnE5YXpdvTQCo1g+FN5CcP4exZ/ZpbtCFyrra0e8Drl2V5z7kK9iWmMFQ2+2cUnVwO8xw4I7saVmmkgm0RsFoJfRn8b9rwCOaTHmil/wlDhVcdnYRp+euoROfUZ5mcKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4fCyjnQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d489a76dso5840783a12.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750849082; x=1751453882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ILAX6gSRE6kdPqfm5GXpanQ56vn1GjYg9ehEVWFYiQ=;
        b=M4fCyjnQAKlXjnmRn/DwRupjoo8gMO/AfRBPaJgisrOyDs1p39DAA/3s9ZO+6W7Rml
         SxOis94VFQhcewc4+qb2PUHIJMcQI6wJ2i80TYfXbtaR51247xmrKeJSP7LxN6Nv6/G1
         oL1yS6cWDDQ+uAKy9j5kZBEjD/ubKcuDnFarfQ6kYJRe7FNJOd9RXUPIu8zXxDlYcKA8
         f8TYHladTdiCsY8QmYkOEwNYgXr3z3qxfJQwB2Hlm2P4QB/z79yxgCRI9HBJTQIX+NoK
         2XRTwNEAsI+Q/TqvBhL0QqKy00s9x4DWHiNDNPPZWpL91yHxKXeYpwVeL73cRk92ngoU
         uirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750849082; x=1751453882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ILAX6gSRE6kdPqfm5GXpanQ56vn1GjYg9ehEVWFYiQ=;
        b=Koi2y7ixRvubrB1dS6AxQqfifvLOrHr7D37svM3oS6S7J/wgCYsgJmv8UWTu4K3zAR
         ITvShdtF7CkM3AovGDwGIcAMtI6X5Q4PMAZHKnuY9fGAEIJWMQVbpAhNnaCakT82UdD2
         CVQmBZfkBwix5wytf9+AHn31owRVEJltA+a9VzYFMulWoQhgwjr/73wjzpYetimzSLL/
         YMayKtPPcMKFMjrVj9LGoSxaXq1SudV9bBw0YpJZkrxs8JY05EfCsuaJWSsMXMuDebKO
         Ah0ggRseaMKGOMJ/j7YeHSvF6JKNWp4z8jEnbYTZH3dysslP57vpJtnI4+AsXyTAdg2U
         xgdA==
X-Gm-Message-State: AOJu0Yy1x1sWY22cblYVmSwt6YxM5nrLR4CrPc3W2btGcXPaSBDdpAo+
	DwKdRmyDcEUerXhG3PnIzX3leYjllPR2MuniTe+QsAOCfZWmXmTElkzS3Qss/+y0A3acXzffTe3
	xGuukrwDDCmeQXG7dzHf6CqvENn9OEgZR1QaGxAQ/JA==
X-Gm-Gg: ASbGncsB1IhyMHGWmZWBItMIl+xy/g5GU/WgjEdgkHhxsrOWuUZn0844+taevnVePVp
	j0IZRfUCE9mgRCuDiZXDhAxd7vP46JpHDe52ctY0JDmshfa7iuMo2z3/twwWyhTKBQxv3N0qkQF
	oCk8Ve9QhFryEcfc9y8I7/39NQc9a37B3/i/gfPIqWAkXvwH7SmzBPvSaick1heNlR4Uwc5GOCi
	YeB
X-Google-Smtp-Source: AGHT+IGwRsFj0UhDLAKL9Lzvr4zJw7vlaSrihVLKeOijg8pRtuJpuGoGsVMTxmEHUYJc8eXh0Y+cl5E9ZF4JKiRvruI=
X-Received: by 2002:a17:90a:d60d:b0:313:f6fa:5bb5 with SMTP id
 98e67ed59e1d1-315f26893d4mr4206266a91.18.1750849082440; Wed, 25 Jun 2025
 03:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624123036.124991422@linuxfoundation.org>
In-Reply-To: <20250624123036.124991422@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 16:27:47 +0530
X-Gm-Features: Ac12FXx3_t-mGX_V8J9UvgTrbHLe7MKYtXoHtEecv2RZNbjg-T01cSYHtYXBEO8
Message-ID: <CA+G9fYvY-KeV9yfas8S0ZU46BwQdk5pGEowLVkEgXo-9BTXQEw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/507] 6.1.142-rc2 review
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

On Tue, 24 Jun 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:29:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.142-rc2.gz
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
* kernel: 6.1.142-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6d3c6e22f526bb03b148d94dc2848088c4a89c6e
* git describe: v6.1.141-508-g6d3c6e22f526
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
41-508-g6d3c6e22f526

## Test Regressions (compared to v6.1.140-326-g1c3f3a4d0cca)

## Metric Regressions (compared to v6.1.140-326-g1c3f3a4d0cca)

## Test Fixes (compared to v6.1.140-326-g1c3f3a4d0cca)

## Metric Fixes (compared to v6.1.140-326-g1c3f3a4d0cca)

## Test result summary
total: 134454, pass: 118781, fail: 3766, skip: 11722, xfail: 185

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 131 passed, 0 failed, 2 skipped
* arm64: 41 total, 37 passed, 0 failed, 4 skipped
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

