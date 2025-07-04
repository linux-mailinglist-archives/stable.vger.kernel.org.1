Return-Path: <stable+bounces-160194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0AAF9341
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316BC179C54
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B62F7CF9;
	Fri,  4 Jul 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KicpCalK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA02F7CE8
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633793; cv=none; b=XE6HibM6uGapeaVSYB3sZGz/n62O6aeVrXl0mMe19QGDWAdEXvRGfwSzg59G2h91d0o9xYzYoIwUvyLJzp727fwKS8P/Y11ww2xRPr6A8CycRnJeTzSJQ2+L3BYHC9E+6bG2uu7q8Vbcycf38rWvZrWJug4FJL4J5ffbYZCNHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633793; c=relaxed/simple;
	bh=xmYMifisU3UCACBD2leKDvX3VJcHEDXqgkueFEu/YiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFOuLDvD91yy9Xia+YQCtUM3+VkAiFiAjDlKttRxa05GChS5vUyXy5qcEqKb4B5u5Pfy2ES7c6mcLABk2n7Cs/HI6Jmu/FX4psbzavzXvHzOfqIvT+7GJwung8WUMCqP8etcVOzDSEg9wfQMIz6EVBC2qiM0UPBe2FqacKSweLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KicpCalK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3220c39cffso889713a12.0
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751633791; x=1752238591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53ijbolrIGV94MONKE1Z3H7DSZ9JfeQihGO4V8FR6X0=;
        b=KicpCalKjNRkk9vkFUVE7l0S4xcxpiDVe1khXZYj/MZ8xPFKo+Ud2KoLCWDhX1bJwB
         RttWwMFVr68tY3XWiKoVR2TzOdnqtKVPYNxlY2j7xgcjMVlAOCohjjOxlqTy09NupmCM
         xoLGFl/F6OTZTC8OGQY5WPKtAHUy+xaYNNRMseYSxErGJ1ZJmhX14aD/NhK7ASw7lbXm
         uJ8Cvx5mZJTgTiCGOjgpn8tX7eIvrB+EsQM+ElREFhNvGnps0gYn/ncXm9iJSRQi/xjK
         GU0QLbw/jbxSYg8LNxYd76VTbQ+LljLHH8HIiSWs9DZipzyk/bxJcfLbue/cSeP8ieSj
         J3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633791; x=1752238591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53ijbolrIGV94MONKE1Z3H7DSZ9JfeQihGO4V8FR6X0=;
        b=FgruX8L+dwx2YaXVj4ix5bbm8xFGYdLvDVBrZ7PDa0DzHADRxr2PMg3koCjFPaGE3+
         rSbLuwkLcFmULm5BCEkU3RMVGYFjYziwgo2Pog5ST4uUqxJYCnpHtLvqj6yr9lT1lVN0
         oF2S6Kx5+AdtjyBAMpwCFulbENXKa0InXlvjz5Z49zSGXeV/VB8Id3JpHP6WfXX41oEA
         VA/1xoOTmqe/ZT0gShj93AXW0HEUoddI0sEZfmJdrMY6r7xl6BEz6h14APikaKh3czM4
         gQs35slWpdNQczhmu4axeWJqM6laTXPzDPFL2cK5cOaTPqnV6UMTAO7uNGVlfLmBZNZA
         gIiQ==
X-Gm-Message-State: AOJu0YzWoXLHmPCjPO7gA554x/Ufplsxsq52plN9uN0xvxBnoVXfIncZ
	lqJ14TIi+uRAQ3yvy9ITWXW5UdJmr4T9rvVtAEtbUlrDQVj/VcP4tGr9aL5Jo1YjKI7e09zTaa8
	Fp27AOZUEEVKnk0Y6YOuNA63M5zqfOubag7U/6ck0qQ==
X-Gm-Gg: ASbGnctpyJyOBjXu4ps376TpyB2yuGFeY2cCBheLPuSLnOvKwXenB5CY8KmA0nzJVoi
	ls3CwfSudZJX3sbRCPISJQVvKdCPDRgGAi89u8dDvD2nChXJykShPEAZgs4BhP4j+VTPfGxKFZp
	S7LZKqRvWSdKzPV+eaCYMFlrkYuNhmTAEmLInnM7vpHHY1/+GaeKoaHagpS/xcT40wBrtczYXzN
	SGJ
X-Google-Smtp-Source: AGHT+IHCC19tlq/mxugEabtlhBGS3FlTu0no8iuCYdPEnR6bzs/APNIibs0972qf4+yiF50uU5zoRc2r3l7kph+66f8=
X-Received: by 2002:a17:90a:d604:b0:311:c939:c84a with SMTP id
 98e67ed59e1d1-31aadd3c253mr3418900a91.15.1751633790678; Fri, 04 Jul 2025
 05:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703143939.370927276@linuxfoundation.org>
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Jul 2025 18:26:18 +0530
X-Gm-Features: Ac12FXzktStP7ltVpOhJx2NTN-IriMAsaKefYnF9CrPTpQRC83-9dyCQlMWKGEo
Message-ID: <CA+G9fYsJh3duKrK5cwZmXVRYEgS60pC3wfyv139V-5sdOjO00A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/132] 6.1.143-rc1 review
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

On Thu, 3 Jul 2025 at 20:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.143 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.143-rc1.gz
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
* kernel: 6.1.143-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cef96cfe5f17c92183187befc6b682fd16cace0e
* git describe: v6.1.142-133-gcef96cfe5f17
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
42-133-gcef96cfe5f17

## Test Regressions (compared to v6.1.141-508-g6d3c6e22f526)

## Metric Regressions (compared to v6.1.141-508-g6d3c6e22f526)

## Test Fixes (compared to v6.1.141-508-g6d3c6e22f526)

## Metric Fixes (compared to v6.1.141-508-g6d3c6e22f526)

## Test result summary
total: 156857, pass: 141500, fail: 3804, skip: 11388, xfail: 165

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 131 passed, 0 failed, 2 skipped
* arm64: 41 total, 40 passed, 0 failed, 1 skipped
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

