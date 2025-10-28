Return-Path: <stable+bounces-191479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC65C14F81
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCE63B3AE3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB521257A;
	Tue, 28 Oct 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOyNuhZ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF21F03D9
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659153; cv=none; b=dxWEjhuU8ve9UML1ZgaY/LbjifDejPBuQ0ysJs4CxmiblLD1b0oA6LL4j/93kaZlNJPBvwSXy+PeichjHsEOhnvtGH4iG53aYDztKPYk2mc+KeffGJAp3RQ2t/Pr1pbCXpR0FvVbW2aOENCbrjOgAEqMl6Xcljfd4CjINJjhUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659153; c=relaxed/simple;
	bh=gAweIO9n8J08eHn9APdNJjAICf2I1cbLYhJ+XHIC6sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN3U3l0j22Sw0L2W+I3yNrrD+ApJazDygKH0JvNv47JId1df6prkfcD2UGIxzsdTHn5olMeBwc+c/SPS+n5d/q0gA+YG6nIvV1uIYKwoCUCcWFc+3A1nWirryVAVfu28tKKQOXZ/CpGHeZKDV0WbtFVZNSsQaJxf6WYEfd3FJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOyNuhZ8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29292eca5dbso79207725ad.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761659151; x=1762263951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXp3oSsESI1TV0Y+956qT+rO7jlyOrnA6aCow0zk6rY=;
        b=sOyNuhZ8oiEnJnzLYnAGrtaFNiFXnBVbNcbZSKznhaqP848j+2r0gPYhIew9YLKly/
         csCrJQtsIc9J/xF5nwqJNi56gotFNocV3nFpxz9l6lCp8a2na1G7QND/AmwViHplyxnD
         be8B1myUTZarWHIeBgbXlXny4U6IbSeasfYjBVWjpifd3W4VPho3esbUXs/jxmbvBWY2
         aEycaxoAsrCrzYyMxYkLTywA3EiqCk7VFNxaucFpigPk6b54wTTJi8kJF3bXmDB7rFrX
         1c+//ZkbnEvuAp3oHHOXCpKuHfCTLvubCBf1U4T8M7sn5vHTFK6PQ+5HQCR3GSafOfuN
         4kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659151; x=1762263951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXp3oSsESI1TV0Y+956qT+rO7jlyOrnA6aCow0zk6rY=;
        b=dMUzqPzBJ0JpfSWbVbsGgIOKSyNrrRr826UBKyVi+XLQoUXc/E7q479J1vYQEpu5s2
         1GFEcPu5tXskbE9pIzeuusxMPbS0+tJZgeHL9OSe0Oi60ZwtfDvxccky3TyuT+Lw4UJb
         7oI50XUcoswDVUb4a1MkJpcNPoGybkY6Y+EBau2sUJXnA+SxKKTf3enw8E6HT3nPSBvs
         5hbXXb/8fSUMNRuOinJ2Na68c5mT/0JYfZVMNrkdiFwqR9uqCYydOhJvRR+wVm2o347M
         CoaW07lUj6FBXfKp7CFvWsDApFr21PSe3kjiX1e6LwlH2hlG5Kw/Wu9HnkR9sZ1fkiMm
         UYLA==
X-Gm-Message-State: AOJu0Yzir/ttbR7hM8KBuFC5L9QwUBCHWdKWdZRL6XtYh0RC287aU6jo
	S6sIi1qzD12OCEFfJyQ6D7rja/DF0F3uwdXFTs2P1AUIg1eQYcDiolhDeqaGtPTr4U+m2FxeFXd
	NKBccU5gW3ljHwXy5fTNIXCpnk1XxkoIAc+dfZHhWSg==
X-Gm-Gg: ASbGncvLNq2uMtOVwcAe0NnMTNfxTwWuCO8fx2p534Dnvulno+pfA95+NugUimfquTW
	CBv087AnUDYVtlLfirXdhFcehbRrUbVZXSbND/HhtzxxA2YONWDvK2/CL0GYVSmA4NtFxj9+P8J
	U4weSY5iN/ubLEQSnGDpagTUEZtCrUJPV2sDpnX7s/wjuUPfVXofxwjQDVuh6Jg3JndXRER6vAj
	x1Lm6QXgLtG4zO4uaYuCc8wbF5iQo1gfysx4586scEFAzXv8Kfa5jlIKVVXTwNnYqW697iE0t90
	BXh/XxrkEpWUoeW9O2piGIx6HfT9SfbF1ZYefejSrN59vOhDNg==
X-Google-Smtp-Source: AGHT+IHxZ/1XB0XTooTy20gF2J6qp6ErSqlur+nLfC1cS2f0htQwqZP27n2jGLSGOe9wQ3S48YkxgzPbfK7mTrgqi24=
X-Received: by 2002:a17:902:c40d:b0:290:94ed:1841 with SMTP id
 d9443c01a7336-294cb51b8d8mr48988685ad.41.1761659151099; Tue, 28 Oct 2025
 06:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183508.963233542@linuxfoundation.org>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 19:15:37 +0530
X-Gm-Features: AWmQ_bn3RK4ifsADAyfT2YCeNyByQ1FJjNTINqrzgb0emwEGcjVldmM9i7J5uE8
Message-ID: <CA+G9fYsOAFpZfQ37Y=En+PesV+Voa80CQgkU_Y4y2Tpta4+2Wg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/224] 5.4.301-rc1 review
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

On Tue, 28 Oct 2025 at 00:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.301 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.301-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.300-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e1a2ff52265e4d85abb275e2930b92c821a3dd19
* git describe: v5.4.299-82-ge1a2ff52265e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
99-82-ge1a2ff52265e

## Test Regressions (compared to v5.4.297-70-gf858bf548429)

## Metric Regressions (compared to v5.4.297-70-gf858bf548429)

## Test Fixes (compared to v5.4.297-70-gf858bf548429)

## Metric Fixes (compared to v5.4.297-70-gf858bf548429)

## Test result summary
total: 43391, pass: 32354, fail: 2994, skip: 7851, xfail: 192

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

