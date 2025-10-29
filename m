Return-Path: <stable+bounces-191573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A63C18B11
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27521C867FC
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6058230E84F;
	Wed, 29 Oct 2025 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiH99c5n"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24430F93C
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722502; cv=none; b=QRHMqChQb1eaJhrcEW5lZnk7OORpVmF0INybRwEo2LCXRuJaVlUCMC8ijOwPh6fIAc9trWslkElP/f72ES+p0OzApUCG607poJUATqREuFpxS1FI57WDs6Jm0oswYprPWKeyjbaUb5rSGhgioqcfqHaruVZzdp9rtQXA9F1ejds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722502; c=relaxed/simple;
	bh=82h/49PYzpE5xQ22tmxCOWMryIrsDdu6pWVR50htg30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtzCGBLOHoZixr1hsQZiF7uT+LpPwHss/jR/glSA7Mj0e3qUDNAlccAd/h9iYtmO71s6z3BkoBCkj0xHcZ9KhIQcWQdb2bnDgsXG+HZbB3l4hkURRXLhl6HWGu61mv5xKq1wuVzpT2phYztitIGx978wihPDnPzysd7HWxM72Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jiH99c5n; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63cf0df1abbso7769084d50.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761722498; x=1762327298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frg/0nqceIUC3qt+WffkLD7GwnU9kx+yGwPbsNn3Q/A=;
        b=jiH99c5nXpibeXkGChGlUeuUBSCmDaDjN8RN2swzMGfppWGdcq0/bl8s8X8HFbHzta
         phCYmOt1v2K0i87zdZeqNHYZpMq+ZR1IctMqnGDpERcaU8Coh0+TZ9ISz7RfkPzwcjls
         yf96kyfaTS3zIPHV9GKeejZlQGzG9vvmTbVY/G4nMKZi0vIfZNEcj7uEn2lBUdTYTN/Z
         OiHuRJnedba114fp1WOTbfseeuTnrmj7Mh2ZN8gZ/DyRv2Ujx7VzKNHt9YivLC9RG21C
         iJmYT2oPy5Q4g/SAKAwZjQqi2u4Wl8qLwI3IlzkacHS663AkyYg+jb5GGqoq5SfpQFwU
         THkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722498; x=1762327298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frg/0nqceIUC3qt+WffkLD7GwnU9kx+yGwPbsNn3Q/A=;
        b=MwNLsZAZqkPdfHvd3USRDOuqqKKM7JyiU84hY/mHCwzqXQPWitkuAMjE/obMPnhAwE
         vDf8jXI/06JaxFM14ntE+x+R1yFovulxwwyhoLFURLB17ViLubCIcGnK5OUJYfXS9IN+
         xMIxFC9hj6K2kqFWa/KIuYXYnRVWWp8UG7mmxg45Jls4FB6c+XI2Cxk353aHZM6sbofS
         rEaPH4R3/CwuOrqHvf5mweP+onFkH8h+/gvZHO8AFAMxTAiSFiwqmTRAnAgMPje1Xamz
         DUhRH7Embk1g1UY6i8gsnlKNV6Vn/yRMNZIvql/+NtET3703e3ox9cbe9UAlAlbwMi2n
         KEZQ==
X-Gm-Message-State: AOJu0YyA2m0ghybxAFerbrIgTD4RIkwfIsx563iIXVA99bAGev7ZBEQa
	qAzHXO1xVEcaF2AcQCVwZRELw+3CcV5c+01YQU4gdJBeRnUnilv4oMLgBysC9FotWhZa0DemFqd
	CxVCMoUeSt/vDxhscQKCLvSguKy8AtRXB55egNrvqgg==
X-Gm-Gg: ASbGncvJSj+s+SBMaivSD68jkKQPOGUnU85OCPgT/u3v7r5YsjQ0yNIP01I1NG++Vi3
	jUC4GgbhP/jrDz32I87ucZVmRtGGu4wb3kSUOvu3qJzkDesfzqu0kXc2zBfWRTtfg7JWrhwvJxO
	phv1AKyD0nFDN1ZwsmSP6pXBeVxfNa9NKxCghJezXBNpVccOjgsbicanNwjlc95U67lc9YlxEKV
	sGsVRZ5Bgoqxl/VaPEbfKmvwuCLd3KB+0rBjLgiOIUAtydTyLDlfpY3wq36Zx8Er0wDTjhFLBny
	aHC9rKNw/bn+knibGNXlKFf7Vz7LgltKIPHIIt/c98HFyltuuQ==
X-Google-Smtp-Source: AGHT+IEXcM1mqw1ZlJaRGUx0zSWPe47Z2BK9WBLcgt67RjOAutzpXt8R+IIXitPeSQ55F/RJPTqwxSBBB2JtLUaXCe0=
X-Received: by 2002:a05:690c:3510:b0:739:c8f0:a151 with SMTP id
 00721157ae682-78628e10856mr19151357b3.14.1761722498288; Wed, 29 Oct 2025
 00:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028092846.265406861@linuxfoundation.org>
In-Reply-To: <20251028092846.265406861@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 Oct 2025 12:51:25 +0530
X-Gm-Features: AWmQ_bkC9ks8cuQ5KHFp4abqoySRrGFkhZ73SET9Q0VBFDKbJ2lMUFjdw6TxZ04
Message-ID: <CA+G9fYsk9qL_BTDmHaw=jXrUXV3VuHwLv+R+t3cFGQh1cLtn_w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/325] 5.10.246-rc2 review
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

On Tue, 28 Oct 2025 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 30 Oct 2025 09:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.246-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.246-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 98417fb6195f935428760a5fab4912492685ea1c
* git describe: v5.10.245-326-g98417fb6195f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.245-326-g98417fb6195f

## Test Regressions (compared to v5.10.244-123-g9abf794d1d5c)

## Metric Regressions (compared to v5.10.244-123-g9abf794d1d5c)

## Test Fixes (compared to v5.10.244-123-g9abf794d1d5c)

## Metric Fixes (compared to v5.10.244-123-g9abf794d1d5c)

## Test result summary
total: 38069, pass: 30748, fail: 1930, skip: 5243, xfail: 148

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 100 passed, 0 failed
* arm64: 28 total, 27 passed, 1 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 20 passed, 1 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 8 passed, 1 failed
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

