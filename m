Return-Path: <stable+bounces-183366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EDBB8CFE
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68934E4349
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B092271458;
	Sat,  4 Oct 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhQde7qv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB3257836
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578807; cv=none; b=I/pfArJ5ahMbs6qyhWyxRUcaKo7wJKH95+dL+07RxLbDS4YkmuGJEwDP4+EEEqJd/m4b/mwv+xD9vP0+4OiyKpKY34SBPrWllFASLqj+0+GVEyoz8OHLLUPz9RTiqQ34fmszNx8+kMausJNeUILs19IRUFGO4ZpMDGvY7Z5hgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578807; c=relaxed/simple;
	bh=B9tTfk1UJrqtbI8dqi8zA4lNiTZ56E1jxWKUD90jNiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7oHQEjgzYF3HrkkPtvAKD+i3QhpWQvOTla0LIa0q0k0NUxQVA6vPnjAqcv0lsUMPvFJRY9ERqLdgJdjzpPXpMWhRwPP3ACAeWWcegi5/05DS4pUp3/sZ2EsWEKPIBO46ySvn7RMgitbuBYDAyDbPfAuw72DYzSYhZzyUnagMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhQde7qv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso33547445ad.0
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759578804; x=1760183604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7RU5qyXjwxmGdqEjwRKr3R2CKcBmBG4HiILh8Lpt7c=;
        b=XhQde7qvbQ7wt+NmscWLt7qmM+GuJq4aCEOx/f363KlWY5UZpCamyVK4ZRRV5un8vm
         PYt5OtC8FprGWRg9qmi+cL5StXGlYa5n8pCSUvdvWP7SrP13NmNePpJa+o0IW99sxNRx
         ZJAOpyRd0/0vRqaL0HRR1RMR5Z3gq+XZs+a9FdYTu3xNE/xSL6BGCm+sCdDl604a5ZhW
         q8wfp3oO/c8DNTi0Z8AaiQ2c1Tge23hZHSW4SpMwrh83jN8G5AyQz++Qe164PWMd+9CV
         e+4q+BR66GmcO4RBE3Uw1NyhF9b9q9l9qzvhseEtyAkU4MKGxVCy0w0rXqs8Hj0gnYyF
         b97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578804; x=1760183604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7RU5qyXjwxmGdqEjwRKr3R2CKcBmBG4HiILh8Lpt7c=;
        b=rsL6elU6FFdV9MD+cgmlts0aVQ/fsCVz6k4EUydz3L2tzrgUh3LKl0yCOdmV0+kx98
         hAS/mNFaexM9TS9Nf73mDJiXFRBIUSMEf5/mfomPn47QT77p8INF8ushsH0zqlFwMWqQ
         GjGaSFwvMnIad7Z9TjxlyYkcq/NA2wXwgBWkj6n9OxKnfil9WAwDrsCSiuG02z/Hekrj
         B4fo658EhfFHUJnTaOaZFidepIclwGl7N46ZaPYWbRKI6IXRiEzlax/RNUwyzOKvlwDj
         4fn5bPjql7tP+yb7k4xbU/82x3Dq8xBHUzto5eZAPnYBH88bS2iW5IBsb68pMGN4M2xI
         9bmQ==
X-Gm-Message-State: AOJu0YzbFKW9cs60W1YBtyGqXA/f5Pam7b3UIQ+tBSFSn/nYaXJMzbFQ
	P7R61XlSiDJTTmzmKAoOhS43mjcXFtKUEmnee6PElSMi5KfK9MoKLF/5CODmv1/c3Ueg8FhaHgs
	RH3r0hh5d3srDWe3ja3SFQWvoSfUw8DxE8sbhlqJlSA==
X-Gm-Gg: ASbGncumlaQgXipPrHOT/zf2OJmzULuNAGg6jYALmfaq31VyJZBENWXSiTF289vBji6
	hD0sCmnJOJlSACZIf+QXn/Ym5Fo1ldXD4nclt0vkTC6K/fQU52ggzvR9gnDMKcAIilCfi+1YEwx
	2C6SPNJZ5BLqPOMGIzcUgNUeECVTDLxKvDr/sWwwLknJh2sw8wVQolAovJit2GqQXodHvDNqsGS
	mNmQU1jY38XLXTxoLACv1pznx2MJ3N9w0fjuNrTuGgxqAAohR5bdO+qiTzj4Lcagav5HLHJ2OtU
	Janptr7g4eGV3lO9p0xjQtu3
X-Google-Smtp-Source: AGHT+IFZuYOS8pBjW/z3NN/ZGg/Iib6xrjJwYtDd9JtCupYMpqrEGIPYbDOeRWKCmqJAPlb0kBXf3I+C7fQhjl9tF5M=
X-Received: by 2002:a17:902:e549:b0:269:8d16:42d1 with SMTP id
 d9443c01a7336-28e9a65c0demr75903205ad.50.1759578804572; Sat, 04 Oct 2025
 04:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160331.487313415@linuxfoundation.org>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:23:12 +0530
X-Gm-Features: AS18NWCKTF8Nqz9apGR7FQ34u8mKsa5_l7wIj6tAIQFmJTUC-xrCwAENy2HEogU
Message-ID: <CA+G9fYvvXA5mkkZp5T1UNU49VovA0LJa0hdGgt3sKL3hwMfNqg@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Oct 2025 at 21:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.110-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c901132c8088afd41cf7eaa3298b62c8cc5874b6
* git describe: v6.6.109-8-gc901132c8088
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
09-8-gc901132c8088

## Test Regressions (compared to v6.6.108-92-g583cf4b0ea80)

## Metric Regressions (compared to v6.6.108-92-g583cf4b0ea80)

## Test Fixes (compared to v6.6.108-92-g583cf4b0ea80)

## Metric Fixes (compared to v6.6.108-92-g583cf4b0ea80)

## Test result summary
total: 121371, pass: 103471, fail: 4150, skip: 13306, xfail: 444

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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
* kselftest-ftrace
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

