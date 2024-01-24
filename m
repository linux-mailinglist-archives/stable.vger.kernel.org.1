Return-Path: <stable+bounces-15648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCD83A9A7
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 13:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773401F2AEC8
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D655634EE;
	Wed, 24 Jan 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4Z//HQg"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB9634E4
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099047; cv=none; b=lYpBkFpxoHE8NlafL3/6fGMSHLHI6X4GkH6HVJBaSn7GWqYnuvUC4QsiV8pw1untIukOKqaXhvfK7k+0vyL6AZTOQGKULbzwEy8oM85b9bQNukhVc3op7IVsESC2DbyFxkP5ouUmzGy0N/gcK8cK7rONbRktkSN+iRvjslDOKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099047; c=relaxed/simple;
	bh=rGdFk8uHaZxrli54fy00MBEoautph1gscqn+/tFyVKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLT94fM1MQl44fm2wnmIjrilXfKlxlpQZawGI9Ofw+SqNAlSJ7wyEp32KlmKd6wT0U6NtAm8TLgwEaGG5KWaV3yahU7hVi3ETwLvgX45DbFkAylEqGwFaPUM6UyyrBmHhBvklLK7pPrRMm0K9xQqAUd6Qqy9CmPIb38Hescuv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4Z//HQg; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4bd3dcee54eso764430e0c.0
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099045; x=1706703845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B/KKXJqlXiP4vwNoP9M2ztX30MmH6mObOLpZu8w8tU=;
        b=G4Z//HQgvOgOkQHVGkOJ1IY1GtNE4UxO39ePWuJeqYS5nfNENRSPOOoiP6TSezNcNh
         6CWlXren5o4V4+6nOC/koNUSqomrl6fizb+whHF4Ns/g7sPbmNq2nIRU0focE4o8Q1Em
         YEi0+yU02JIIhdBpQAxReDtTonH+Ez9fq7ldVHJ9J8RitL5ssUguWWrSLbVJGC0clwfi
         pHjyHzDgcqmDMMjxxwWKx22Wpzu1tLTL0FPbe1IKE+ZOQNJwYAB7ypMFF0xSIwxZPnRC
         crb5Kt661ibdfFtrSljjUEfkCK7KbHBRI81Be1xDGC+PAoDIupkVvBQUjeX3jxnwqrAG
         weLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099045; x=1706703845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B/KKXJqlXiP4vwNoP9M2ztX30MmH6mObOLpZu8w8tU=;
        b=WYrSXXU+IXev7PoPvv91eykOdYDu0ooOWiLr2d3aSRYHvODROsRmC0FHHg2R896vtZ
         Xpd5hUoquBbT23qmGxJ09C+a+OA9XMAKeKcpMoGagK5AHNFLtSq1GeoRpsmeHyd08hkG
         WqDH6SxqqTtPIoNrX1c6I9BW92gxLJmh9beCEs46I2cU9lx/R2WQb4xvkqrv5APgHBkh
         2DK3zxn1EipdAVi6l/+WY26bj69AqlnXS+KcSvvuAGg9YjyjsAihv2oPYzn/afJqy1e8
         JGjotIT7EnJGQfn1JsRdT+b+o3ejO8Eryea+R2/7Rjvj2pkmWcdrvWjhfloG8kjcCMtZ
         YHdg==
X-Gm-Message-State: AOJu0Yy5llCuBkczauNzuwr3+7hA5h8m/COlkCTeLdYX2voh9O+6K3wU
	/dKqIyzlTRhDw5zcQZkyyQ7yl1ZvtLD9jHnafJx+ryIeYVWkjhCwYYc3OXL2DoRjIrBWeJ4rS/Z
	vrNP4mzuW8L8RCAziEmdwIfIcOZu8QBGm/8QeYg==
X-Google-Smtp-Source: AGHT+IGku4y0SXA0K+K1f2yfKzalu4Ew+iZYDkbMtOJf/XET/MR7IHirdCrkQGkQf3c4pXRvooJ32OSvS3GM8KahpKI=
X-Received: by 2002:a05:6122:44b:b0:4b6:dbc2:1079 with SMTP id
 f11-20020a056122044b00b004b6dbc21079mr535782vkk.0.1706099045094; Wed, 24 Jan
 2024 04:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174544.648088948@linuxfoundation.org>
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 17:53:52 +0530
Message-ID: <CA+G9fYu1pXV_9LSn2T0PNaSUpH-WWtuhaDqj1h4u211DYXMT2A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.2-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: 2320541f64baa0c9f5313c2100809a2e26d333de
* git describe: v6.7.1-639-g2320541f64ba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.1=
-639-g2320541f64ba

## Test Regressions (compared to v6.7.1)

## Metric Regressions (compared to v6.7.1)

## Test Fixes (compared to v6.7.1)

## Metric Fixes (compared to v6.7.1)

## Test result summary
total: 142436, pass: 124243, fail: 1105, skip: 16870, xfail: 218

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

