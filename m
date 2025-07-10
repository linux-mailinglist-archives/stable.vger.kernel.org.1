Return-Path: <stable+bounces-161549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369AAFFF4F
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2971887F5E
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6E2D9484;
	Thu, 10 Jul 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4l+f0uV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B132D5414
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143387; cv=none; b=UreIMAzWRAopycq5Ip9JsTblBjzP67lUva6cXZhcnYw1VgkwmO0yMvCQ9VDvZXzNbg59j+vC8Hr5wZ37Ja5VFhPGu9BBs0u4SlCxRSvEW1QC4Nq0b+KGlRG6cXPDF8c1z0qU/TV7a76AF4jq1LEAf5a2ADFNdw2HKq/KSC1VwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143387; c=relaxed/simple;
	bh=X4dWfCuAvC2u2fIEaHCnRGK8nxZGyEJAfZE0s2Z8LYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWtCXUHRugOWhNWaJDWuy8PGI6eKhyMvWp63yxS/mJdTtq4cgFkagafXv1S3bLdiwE1TmMRmO7QbzIf/XQ6qg0Ctm9WHOrRSLkjXzQzKCI428fpBRwq8V1i/nzrPGJghBBpP3B8XKqzngger922tLrLi5oB1ZBhntqQRwRFNBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4l+f0uV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390d09e957so938694a12.1
        for <stable@vger.kernel.org>; Thu, 10 Jul 2025 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752143383; x=1752748183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H5h9tlKdQd4trkg6e5cY1N3SXg7n3+0oZV2U7x4PRc=;
        b=F4l+f0uVNFqvSxhdvjHzPmBjaIMO1mQKAi7sg6HqjnJLMkWQm2I+7UvlE5luTHrpKj
         uh3t9WvkejVhqEmfMjCc/I78fMR/WoZSoeebCvQYaEUB1EOrglrKqDnBh91hDY9IDcEj
         crzNgwDsZ6K2deweKvZsX295LCeMfuSvvq2yJVO1xU8Ok2ZBEea/ijt4f2JHEpOBEChl
         VmX99ZBmOsmmYg+Mvnrqpzz7MJBNPGIFRhOROf5LE6mKaNufT9LRVt7gCSZWhHDacxa5
         zY7FpiI/q36fAuy9I9R9IIsImZXEKGiLLHGe0VFYVjemMbokPB+JfSVVxULDLCZSoEkn
         ZkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143383; x=1752748183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H5h9tlKdQd4trkg6e5cY1N3SXg7n3+0oZV2U7x4PRc=;
        b=ivOQpJP6HxXWULFW3gr7HXIPlj2cq7wufKa7jvCcZvoXf5K37LnE1cNVu9UvhGI3eE
         o9w9l7+pBPMtHECSiTpE0vigJvBIM+mR0qmAgM0gKTZSnyp5z07kiEjdeDz1D/qmGP83
         IqcfaulTPUmdpNkeqZY+IgqDUCBMKZcS05KsFVEMW9Efn5brXNWiJ31R99Ak6e7IIcHp
         4yo5jZ1BqijnvRg7ADYMeBDtlft1sg0HW1DKakiOOZk8QBMxbmPH/N1ry8faRnHB/Ax9
         HQgxnO3bfGG+algG6k/u1M9F5DWkvjMjVLVsd88+/plKB+G8lic5s3AFaOBSwrgHah6B
         1a6A==
X-Gm-Message-State: AOJu0Yy7adlSecnUlviKFnsIkGzD14B70QajECdMT9cxYAyEi263rmRd
	TTtoFu/WIeloHIBBGh2PPixAtEQKZmsCpHpVeldq3Eggao3i3cx8ZvS17dqt3zwJENY2EckwNT7
	zCRMwwCq5QuxPcSkPWaBC6kBkqeRd36RDHBrd4LBY3Q==
X-Gm-Gg: ASbGncvgEAD3NsKonsriecNPYsTUwceNEKVbq283+uR5Xv8wb7P/Z2+LLpuTmuWJ3Ws
	TIxYG2DUmUub/vU41zjSkycaElVm+LrVNb4xbuHIUzK/EAohSRjtqcHWU0CUGxeEeQ9YZBO887I
	72jLnkkqlgV5zIuOuisIx/dc31MmgCpYzorqKQIETAo6d2GhHTV0AmNOLNzfeCP9zpeFOnzsK4g
	p+K
X-Google-Smtp-Source: AGHT+IGTPRflc71ehM/erqtBSBvrbFlDX7EuK4Oc4DS8WHD5He8D/ywhaBNzOZQtlE1/7Ffka7swie+za5d+pVFLbPg=
X-Received: by 2002:a17:90b:5344:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31c3ef2308emr3235696a91.13.1752143383085; Thu, 10 Jul 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708183250.808640526@linuxfoundation.org>
In-Reply-To: <20250708183250.808640526@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 15:59:31 +0530
X-Gm-Features: Ac12FXzL-Kg4EgSJdYxYdn7rWZRJkNLFNrf7e6muOpwhA3-sOwMlQSSbxtPvCY8
Message-ID: <CA+G9fYv0z4NJxEyyB2mtv5f8GThcvgE1bbcvhQxGCkGAVDmt-A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/149] 5.15.187-rc3 review
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

On Wed, 9 Jul 2025 at 00:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.187-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.187-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 09eb951d49e58b88552e5054a2c1dc20ea1f1504
* git describe: v5.15.186-150-g09eb951d49e5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.186-150-g09eb951d49e5

## Test Regressions (compared to v5.15.185-412-gcab978569923)

## Metric Regressions (compared to v5.15.185-412-gcab978569923)

## Test Fixes (compared to v5.15.185-412-gcab978569923)

## Metric Fixes (compared to v5.15.185-412-gcab978569923)

## Test result summary
total: 54782, pass: 41945, fail: 1996, skip: 10559, xfail: 282

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
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
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
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

