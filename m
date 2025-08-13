Return-Path: <stable+bounces-169442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA4B25214
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C56084E5250
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E228150A;
	Wed, 13 Aug 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8pBvGCM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39325A331
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105975; cv=none; b=np7clnyCY10bp8T/hniaC9Oo66igSLCKtfFqFI6CMWtMxwrJplv2iMKlzGz+DsvncY2UExAWXoc4y+lYxpEmrfr3Zb6i+t5Mj2l/ZaViYme7fBYoUkHnGaPvBGVGOQBAwj3jAWzdHBSIY6eSQFX2yBMMp6QG2G9vdjgtvFYKpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105975; c=relaxed/simple;
	bh=rDETrbJk3fAL6TMAFhOUKPzKW8tVVoRgZczqS/dXqrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDW/DANonoDTHFzANJAPchhYQMtRm06rpZ/daGIXrszqSlaMVHCSo5fdPUcGsZPdDhqvJqeIJeDX4x86y6x6jK8QWwyzNeB12/d54abhCbAiWJI29fr0tai5ektpmRTOKxql/Cc6hV4hIFojPqlWhxqxsWYXUH+TeROZFFpQ3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8pBvGCM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24457f53d2eso169855ad.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755105973; x=1755710773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xxEaH3PT2IziDsC51uoaC6ApX/6gZJaUq9Qapk3Nwc=;
        b=O8pBvGCMB6mHJaSLhShcTdrUofsfElOjjrKUwkza9S1M4Eg3QkyWVRSEmys9DR5CNd
         gUyzoUt+h+6FPJrgyuDXlSskkiaYpUWHilQ3GzDV+am3c/GNUIIXim7YDXRGULhpypi+
         Js37CK0yebV0wTasEUe642dZLumFIBrZVhcPMoTK1n7cGf8AQvwL2dVSMbeHoa0SaeVq
         q2avn/ubDYo6Figcmkzw2/j4N4L8Hkbh+aP+vNC9KpoWXMAUOwessMn57+RbInBbnbp1
         w8JVb+Ttc7ZVS3VqyO2xbbuwn2uxGGX2un8pQkDxiw8GDWXr6sP03j8LVSkdtBIQU4MU
         w7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105973; x=1755710773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xxEaH3PT2IziDsC51uoaC6ApX/6gZJaUq9Qapk3Nwc=;
        b=gJ2BrQwuZx1ZBWF+cDWxc/OFB6YDeAxx+7oNvYxX+KbY7JeVv96n9f2htOyz29lPHH
         hj8+U2Z/5Lo/qF6Ovrp7GgrWMHaksPClVjuIhrMqeh/m0VzakUyBCXPkqKXBUMpOCp+4
         wGqINHH/wFwK6sv8+aEzcPM7CRwylzM2mHiL4hEv9N/owtaTlc2FY8Xsh2UA8m2XEP+Y
         JRrm/Nyk3AJ9jjrc9DSNHACcO5ybUtK48/J3hIQGrNGB1EWi1yZC9tVjg7xGcVTJBejq
         DRxZEzdD5OON0P/KGHg8GK+ey4V2TaHp0EOK1EDA5Bjpr44Ohnb8oTb+k6ISKYFrFQg6
         zVtQ==
X-Gm-Message-State: AOJu0YzgB8HZnMTl+WkuLDzLBorhmDaW4HiPjaNbWvzPmzls/02DM/cM
	NcMIlkOfuxKMtvE1fr6cacedGWSc1qQpZ6Lfai0eU+8jV7jbJbdEDPTklN4NiiWO1hG2zoV0uWV
	7gKxBnbRm78XNn3IUhJVlgAfswXQbOKj0FR9Qw+piXA==
X-Gm-Gg: ASbGncv2vzjqJQdj31944iN/pOqvrU6ANR3gEngbdbDUvl1EPLzTktwQgIznppI+LCo
	HujFgqnE2ZA2tgMO/lntLjVHAQ/mIFziaIVTI4Nsn1jYwcF7VvjBz2EOl0AoLfHIz9Pw18i7rTa
	EJ7uPs7RHjXByhbtJYNuzL2vLCQ16hzt6of0s5yTGfgoT/YkMyfyJ/EqpBOrx8T52GIBxhMmyFY
	To1RqH55Cip/TKwiXP6vUMR+YfqgLEE5y0tff0TWhAXG8Q=
X-Google-Smtp-Source: AGHT+IEOkUkmYC5N/J/vB64cbgQmSrvC9vCyxLSKaoYb2OP1VG5F4R/rhGmiI87mYKoYirIeiXdBHrdRGm8IHUx7phk=
X-Received: by 2002:a17:902:f688:b0:242:fbc6:6a83 with SMTP id
 d9443c01a7336-2430cf1c309mr65017485ad.0.1755105973321; Wed, 13 Aug 2025
 10:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812172948.675299901@linuxfoundation.org>
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 22:56:01 +0530
X-Gm-Features: Ac12FXzdf_Ej46tF3nV5G_5SGIOihaXG54zx8BtCQLExaOGHxY4DFkmbvtbwtTQ
Message-ID: <CA+G9fYvK-gORTTuFqsipKqCPrD-k+uZNrvwpT09s9a6NLcNMUg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/253] 6.1.148-rc1 review
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

On Tue, 12 Aug 2025 at 23:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.148 release.
> There are 253 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.148-rc1.gz
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
* kernel: 6.1.148-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7bc1f1e9d73fe5fd8a0e5a3b960f8d8f5aaa25dc
* git describe: v6.1.147-254-g7bc1f1e9d73f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
47-254-g7bc1f1e9d73f

## Test Regressions (compared to v6.1.146-80-g3a0519451f2b)

## Metric Regressions (compared to v6.1.146-80-g3a0519451f2b)

## Test Fixes (compared to v6.1.146-80-g3a0519451f2b)

## Metric Fixes (compared to v6.1.146-80-g3a0519451f2b)

## Test result summary
total: 219500, pass: 204027, fail: 4142, skip: 11087, xfail: 244

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
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

