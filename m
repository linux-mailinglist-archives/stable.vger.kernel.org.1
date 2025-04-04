Return-Path: <stable+bounces-128320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E9A7BE87
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994157A7F20
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB461CEAB2;
	Fri,  4 Apr 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZn0YbpO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB61F37D3
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775123; cv=none; b=UslxVZcALbAnZEuOYDmG8o9l1GhaOwBbFTD6LnrcZYvPYBWiEy3FAcbswPn03640BU3LikbUxRbmCJ3HZXBDM14ZenZUUFJYRYOFaBvjoZu2oTo8saB5ayduMNZ80Sd0viLcowrW9b8eKr0xKT5bjxnzPNZ9a90BkwLR8a9Wlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775123; c=relaxed/simple;
	bh=Pfj890P5IwbfTQahPjXr1drdBQeTDyPSELB4bM0oU9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxQOgwwG6XrveqNOWYdH5mXEqhSttj8hn2uVv5/dhZiSDp9p2a+1kJMg94rbloL4OGhQIeBg9bHukaXWXOBgL80DRLpa0Y8jqy0hzrjXcIOOHBZa2MrxjQguYCQPVqiyUHBnbrJ3ZWk839zBpZMSFLbygT+lkpO1GZbPydEN9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZn0YbpO; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso921692241.1
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743775120; x=1744379920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB9/4tnJAtBLw0ZsGKRcy+CITdDU2AAS4m+EOvznbRo=;
        b=mZn0YbpOkvivRmzb/qUSB3sbDjRxkXSChEkbxgrHMzMaTcFXXKswsFdcwWVf2nUGfl
         rzvmbxEK/szrUtfV7NdqeHrLZz11iV7c1dfNYNKJVCgfDBftu1KR/HNzfu8STz/q15+q
         bt2rtfMGobd3+4jLfp2biuCFr0sbz2xN40EjvYNq8yKwz5q3rsuYF+vH+IqQG4tAgwUh
         OtFx+7H1hBMUqLFHuWz9vMjIAaFc8dFnB2JeV/FYudvQraSjE1deHOyTT72Lg2nol5lh
         4FJ6QO010ErayqkSkNLfOgdnkpsKUkj+fv/kOUwrVOupMH3tpCWT0ia+IAghDPljQgNz
         uWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775120; x=1744379920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB9/4tnJAtBLw0ZsGKRcy+CITdDU2AAS4m+EOvznbRo=;
        b=d7WXs9m1NlYLfFH9a1l3ANhFWZxQzqJgnXJRqzcsmVKFuWuY8LwUPrwFEIDa5naozX
         iYKipRNJ5NC2TSRFu3TvQR3C63p165DU0thnbeR6Bj0ePrBIYlcnfs1zUyHXItlCMRvg
         LubHW+xcYehQdqoI42MDRCo6qzKwvjgElQfNUZPmOsZ5xSatKfodYsEVery7ogQzoQjM
         sLc2Zg3Qn0gd/5zzUDSsJU6XioOM3i76hL/5U9P+DJSLnQJc66lMfX1y7EQlMnC8e+5T
         XD2xRa3Mr49awaSAQgaGxzngsHw0htB1hsjiIlyKTuyLuO9FnAN4w3YimZBgkM6a/j2Q
         Kw0g==
X-Gm-Message-State: AOJu0Yxh+FOt6zJHRIEhAySXqxS68Evu+7JWFBeK/WVu92rKivZA3dig
	j8CXf/ERC7tdezKJ2vVW6shubRmHji+24DYpZ2+nZr7dTbrQ4HuHHlTQSCWV2T0x3jxSFGcUpCW
	BW57UetgsbY2U0Ofp0Yo6g0dBHRIWIkiGM8yGQw==
X-Gm-Gg: ASbGncsL82YZNfsM+DZBqPEyVC+l6lbnq1KOUh+uuI3aKfwSh6lob4ESlZu1AwT7WdI
	YzEUScWh+VRyNljfPCCWK/BgdWbNu3I3JttVqMr1hnoqd5D++6KmLDSbxhYxW3qJmNScA3Ufcnq
	LVtkAgvWFvHi61UMbDEdBTnS4IEx7P9J0jJ8RHrHT+sk0Dp//DjeqRWfF8t6Y=
X-Google-Smtp-Source: AGHT+IGDDltg5ObO138k6zzOYL+wykiXZsnKn8Vh0cMA65TQ3tUMpH1ACOqRfxeVBXNWngIamyIeX+2FXG2uPojaJuY=
X-Received: by 2002:a05:6102:3f42:b0:4bb:c8e5:aa8b with SMTP id
 ada2fe7eead31-4c8554a106dmr2484511137.22.1743775120437; Fri, 04 Apr 2025
 06:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151621.130541515@linuxfoundation.org>
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Apr 2025 19:28:28 +0530
X-Gm-Features: ATxdqUHv-en8o0wookVpU3iUOk9afvCFPma7LGlR77epx5goUvKncGk2Siry8JI
Message-ID: <CA+G9fYs22cxdKD24MzsBZnjVtHx1DpauDyKvLzecBaFjTy3G=w@mail.gmail.com>
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
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

On Thu, 3 Apr 2025 at 20:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

## Build
* kernel: 6.14.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8dba5209f1d8c122539b8f9f164a6ed44c025bcf
* git describe: v6.14-rc6-492-g8dba5209f1d8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14=
-rc6-492-g8dba5209f1d8/

## Test Regressions (compared to v6.14.0)

## Metric Regressions (compared to v6.14.0)

## Test Fixes (compared to v6.14.0)

## Metric Fixes (compared to v6.14.0)

## Test result summary
total: 114030, pass: 88585, fail: 7464, skip: 17981, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 57 passed, 1 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
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

