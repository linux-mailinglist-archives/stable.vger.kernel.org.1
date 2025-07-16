Return-Path: <stable+bounces-163165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB9B07978
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1885E1C24E4E
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76428A1C8;
	Wed, 16 Jul 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsvrtQVi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D22F2363
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678893; cv=none; b=Q5UyrrQJah3qUFxqHFqY7zagv6hjJ9JMogncIbtmFEbA5R2VmBg/ixDFNfQlYBEZ/82i0etHLAwSNPAXjCyOSfba2YQk2m0zYPpSut8vujIKv26oQPhULbv/sf/1DryKKyPDCDBrcg00Z89RgfTHGIc2ltMKTS9MpBithbQT02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678893; c=relaxed/simple;
	bh=sJ9F1d7Hm77TJIAltAZf3WHYV/zaIkRNhhbrXivEKVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqFyUX7/GE31VOkZH0FCZK5b8x6PUUfPnwDW/2yDM1JE8/eWGHtKnE6RRubzhzUyqQzaJrULoQojggVb2NBsJVszYTvq89bS2l+WMftDQzVVlQ0T7vrIzAAktbO42oJY34KtoPFdee4HmoxyscisFbc0NaBaTc4a3cYZzgcDRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lsvrtQVi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23602481460so64472525ad.0
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752678891; x=1753283691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG1bKPX3a9pOYPMo36U/kpFDDPKBd3jz+ZJQT3BD91k=;
        b=lsvrtQViR7DNZhsXBcg2C4yfc81m4sJSgL0/LM4YsuAyjU53MFqiv6v2nERFXM0ntg
         Z4jcnq3QzhEb2o563TGKM0LqmCp5jkYkWWIBe8p1nCQ2au35bdRpZ2AvQlZpM5ehbhty
         hrkGIyKxo3REQ4RxFpoTD5XArtHmKP+0JXcOsp+UBstYrLd3DgOzptyJdTaY7fMUuA2u
         nZgHv/muzEj5Kim59lseJxY/Q62Z6kpRfliWjkxupgGYSZKwEhY3eYmWUY5q2CDUHfMR
         NXOkJZ4S8dbl1SFfm7P2r3+iR3l5iChXKPJFMV/pd3aH1naYCmi49bwTSaTFhpaYGzyu
         5ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678891; x=1753283691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1bKPX3a9pOYPMo36U/kpFDDPKBd3jz+ZJQT3BD91k=;
        b=m9fuIypPw8yh/dItMBPthyLVTOlPu4M27XVVX2eO6RVVDMWZqo1dOxaFz22vnSh/bi
         cW+0CxqhRvFVFHugBnsIGrJVxEQhzYtbl1YFkdoIEsid3cfPvzHMvFSG5yXmJvnD4r6t
         LHXFnxttO5p+2pbI0EhYgAjC7mrwgZ49f/ezDG3uBgK8Fz0n564tGRDetFV0Ku+0mQ4+
         fDJiB6WcPNyt2POAxbCi8OFwIO2TTCntAAKunUayeHannH2V5dqPfbnqoNm9xG5FwjxV
         hx7zI7vICkDS8bbf6IKjKQZYzamvXsnpJg+e1m4MJq2Qva2TAaLeuroWioPlPqoZMKVh
         RQBQ==
X-Gm-Message-State: AOJu0YwN6aU0yRH+E3rcGsEP0u/QdssZDmbOhIWo7qsG8Jnq8q4Gwkpu
	8UExbFrL/+S6uobxjzPuzNcg8OoyzYCYHy5XvBqzuy5TAOGU5cen4XS3q843PC5Ca2oj41+d8nd
	wQE054Be4v3bPvGbh8t7qK/tIckQwL+5l5MnrNOqMgA==
X-Gm-Gg: ASbGncuVwYCLsD3FozbiiVXyhHWxaXZ/vpiakmpaRIBQa0Kzy1jd8vsp0AYDaY/ghQj
	pnWjdvym5BolvZqXf+3OvFs0bLaMgAu6vOsJWsFPehurB4jEUs5zuM/RA4Iu+o+MCjodQL3s9Dn
	FDsN6NIfw/d8nrLigrMtkint+e8ihLp71vDUB5DmRqG61PNeLQj+FLqahNiLoqWrXwf4EwCg9IA
	KN2Y2zecRvUcCoU5w7BRFPrYi11XWyVQCDshJrv
X-Google-Smtp-Source: AGHT+IFN4fuIIiulZ3MRb1paSNqs6Z2BJ/Xj7EPl0koyk36NfWEbtV/zpTDUJl+uQQQOsVLtU/8WYBy+WKPOX8mi3zA=
X-Received: by 2002:a17:902:f686:b0:235:ea0d:ae23 with SMTP id
 d9443c01a7336-23e24f366a9mr41690455ad.6.1752678891055; Wed, 16 Jul 2025
 08:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163541.635746149@linuxfoundation.org>
In-Reply-To: <20250715163541.635746149@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Jul 2025 20:44:38 +0530
X-Gm-Features: Ac12FXxuAFuQkORwiuMY8JC4Ac2ZwV2xrsQKTzOurlwV1lEs9CHp9_WNBFMoscs
Message-ID: <CA+G9fYutkaN005d8hw17+i-F+TR7M0FOMNDhjMYEvkpsrp0+Xw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/89] 6.1.146-rc2 review
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

On Tue, 15 Jul 2025 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.146-rc2.gz
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
* kernel: 6.1.146-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 33f8361400e7e0f415ad8f93fabab430397bc2ba
* git describe: v6.1.144-92-g33f8361400e7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
44-92-g33f8361400e7

## Test Regressions (compared to v6.1.143-82-g10392f5749b3)

## Metric Regressions (compared to v6.1.143-82-g10392f5749b3)

## Test Fixes (compared to v6.1.143-82-g10392f5749b3)

## Metric Fixes (compared to v6.1.143-82-g10392f5749b3)

## Test result summary
total: 222917, pass: 202922, fail: 4848, skip: 14938, xfail: 209

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 0 failed, 1 skipped
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

