Return-Path: <stable+bounces-181463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE15B956FF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EAA2E5E80
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507931FEC3;
	Tue, 23 Sep 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0VAFkZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9426E6FA
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623431; cv=none; b=hisQWC0oEaaUDdOFKilaS0j6qeOVc/Qttuj5gKxgpRobSStFxw4J7iENccvmG6/n0hWsIAAhIC6vuIe13STrOTS+h8Yukx1v/wFzxdipeC/0RNGwunbopveW7CA9GHkEU3H/vxmaHDdVQwyyJsdPwLN4xNuY7RBpHdSZX+n2oYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623431; c=relaxed/simple;
	bh=nQYDG7/ESRE6NVpQ8N3MVFRC1NTmVZPp0DyEPgDS3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv2vEJmnHKSD+wdUAw09Lfzp+Hv58kca3iB4YumJM380CVbep4KfqkJLImKw4zpi7Iyk3QZ4+DTQvaNpgAiRT6ISVYqmztVUFnekopP8HeDQYZqLLGbHBn1WC3Gyky4O21wFI6fv2rIe7a4PnltIQsGIaX6VvySjWl0xnqNF4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L0VAFkZK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso32922855ad.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758623428; x=1759228228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMRYr8OtOqO/HFrezWjaR8f9pLA6E/Ty5wzBOjw1mXE=;
        b=L0VAFkZKYADuCHGrwacw/T3ZPmd7NmGjvJpkskxYCaZaZSssvxrzk6HC0vikqq0Hhq
         Ulr+WKxfMGQCDM4I0FbbqPccU7gLjf0OWl7i4tY4VS80/o74HWhecFQOS1FJCAqRf3Li
         q4rxPNdt9AC9HIFCHh3OVVAs+akJDAHjr+fu+KHPYCKbMUkauZlQja1Jhlxfx9zkN4dp
         5CGzo6FgamGwyRcE2d5DU7d7KRVTndj9ZekbOpz+5Yl7mh80te3yY7H0rET4qLhgP38D
         opf2/1K81A4rQiLwVEvbagspfRJrIMARbMU1aCAEakwqACWOSeMG7OAuMOIBjtO5BUl0
         IiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623428; x=1759228228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMRYr8OtOqO/HFrezWjaR8f9pLA6E/Ty5wzBOjw1mXE=;
        b=h47xvjda85kVQZE50cqzFQ5mBfeeVLn8szW9Tf+IGz51Um7UkSuoOW8qkbaWad2gcj
         oi2jZC1kPUdSueb7ADh36lntoy1MaZvBKQU1hFe6AowGd1Ybbu8QeTHUE8SqXdsF077D
         rXhVeTLIVT83X7JhHbyz2CryUeSLs98vzu5gOC+oQ0canAkgDg5DH2xqel1ERsD8xJLR
         X0OlaWeTd/px1jBFBcxT/Tb4SBaeO0ne9eJhEMrQGaDWHz9Amjjg8Fg1OBC9FcINNc88
         HK620JAd4OsFVe5ALdf9VTpjbAqjYPZAA8ctZX9SuhEGvAyQzCn/FR7iBNFGV08YiwfX
         af5A==
X-Gm-Message-State: AOJu0YzLrrpZaBOHg3KhY+wy145RyyaOspWePLug3jP2A1zc3Cerivjp
	waq4fiB8v1O0goWIsMpzhev5VMOvBGMsP6i5vC/yF+q0RszQAvEfQj8gwSYAMWKf7gYcAI5Ul3E
	WZCpFetinmXQFIxcekbGz9YmliOMNeCkRzz2l277fDsOZv0kgpTEAlN1x0Q==
X-Gm-Gg: ASbGncuH9NM024Ea4wTtbio/UBOB8LqFY7pVRo8O9NcpzSzLzL93925ATyz9+rSgacC
	4R3j52YBLPwGRLF0h7s2SQA5XHRSAcbLfRjRtKNoEzhcxRamywTLJ2jh6jJnTplmISdMUik+l67
	XYMjfInDejgIG+kEEbTYan2Slf+88ZtO4GWvCKkahZHvkpqepRLTTCRKS007qQRZBoeyl/u4paP
	27JGkhXRuiuLusU61+KpZH6FOJYPWaD+ftWIae7
X-Google-Smtp-Source: AGHT+IGCbLaovnWzmpLxnAHxOBtwxFY93rFcE1czzzxjsg6cIsdwcN546zJG2Fui5rFNOkdh8TTlG2kvVI6evYMjiRY=
X-Received: by 2002:a17:903:11c3:b0:267:95ad:8cb8 with SMTP id
 d9443c01a7336-27cc874d3edmr25011055ad.44.1758623428016; Tue, 23 Sep 2025
 03:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192403.524848428@linuxfoundation.org>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 16:00:16 +0530
X-Gm-Features: AS18NWBtNIoXbscRPGhjJ8JgJD1DACVC-p7XxDGqa1-ukOiEjaqrJ9qSh5X3TZU
Message-ID: <CA+G9fYujv6g69Pmpr-yZ8fy-P1ywrnhwe7Tip3X1HPPjfP=L5w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
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

On Tue, 23 Sept 2025 at 01:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.154-rc1.gz
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
* kernel: 6.1.154-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bd7dff6dbcf5b16eefef05f2750607b70bfe727c
* git describe: v6.1.153-62-gbd7dff6dbcf5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
53-62-gbd7dff6dbcf5

## Test Regressions (compared to v6.1.151-87-gb31770c84f52)

## Metric Regressions (compared to v6.1.151-87-gb31770c84f52)

## Test Fixes (compared to v6.1.151-87-gb31770c84f52)

## Metric Fixes (compared to v6.1.151-87-gb31770c84f52)

## Test result summary
total: 227967, pass: 212169, fail: 4614, skip: 10926, xfail: 258

## Build Summary
* arc: 5 total, 4 passed, 0 failed, 1 skipped
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

