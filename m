Return-Path: <stable+bounces-94514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EB9D4C16
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA91F21D4B
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22181D173F;
	Thu, 21 Nov 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skISQ7z6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298D1E52D
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189108; cv=none; b=sd2jGh3dFtm1Lvk54VBB73GoUI1CiX0WCGNpepxWV44TV6DeuF01BkE3d6h9/KOty0W1jaFB/otEwQeQ37HwukXR5WOnbUQEAXk8c32A75wm1Mrtx4S2afkoKhzIDguL+NNYolNpqqIS7cFsn9E9H9pU+XVVPeHVNrmFMltTofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189108; c=relaxed/simple;
	bh=GoTq39iPiD/MsBXuMgTX/y+bT00dhL9Tn6diA5FsVT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ/bJZ+H/pBq5hJfsULQGtUxnjOjLebT6wlrZ3s6gSg0wpGkEfWkkzr6do16FLwVDkW0xQcdFzY+kTMWesvAQyxpI+nWU/2bdo+YiJ03Zt8E3NVqOVxpje/xC3GJ6+qUUiQVNhAOZFwor7B80w4B/dTWAGDTf+9bN4t2QnPBaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skISQ7z6; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5139cd01814so388841e0c.0
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732189104; x=1732793904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ukX8ZlTj96KIQhfZzpEJEoiPzLwIJpbM5cfdfMhxs=;
        b=skISQ7z6dE8itZoqKWTJDXxDCcYQbP46Dl8EdiRMNDG4UyGCEgd0hPjCTcD5kgm3fJ
         ssy33UZdHwr94FbuCJFspS3p0GtYNbwR+BEj0467tSmhudwgXpZrEyKTsGwaq1OiPpfS
         sXwr7n5ccnMAMpvtQgnRC15n7OWodjxwRjCafjd/luW4MdhE9ggRkMYfU40dnrRcXXUn
         jEoH02i5dYQii4r/rRRjSNCOPnQsH9DwrI+c6+zhyi5mTuo/ls0ZzpzdjTbEWmmIdsAK
         TB3UQKHndQ8ZBkS+phtcvjd1f9q/ri3nWQUxUTD0AA+hldVD8rBZJ4plK0mxMrNRdI+k
         SjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189104; x=1732793904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7ukX8ZlTj96KIQhfZzpEJEoiPzLwIJpbM5cfdfMhxs=;
        b=b12m78St+1RUBVzP/OQ3KwZ7PrxeYia7Q0HthO3nSCrPxxMTmRjetrXbIWlQC1i1V0
         LUNKI2ATXp39cfxHqPnY+1tAWPfORJHDBi+r8tM8Yu5LTtoQO3TjFIMrCvHN2kCnRbF5
         4nhj/TJ+UV84Uwg7SuwbKJG+kLxIASkiKDZi3Q9BvrNxNpLdIGU8WQQGcp5/z2uB/sKU
         7IV3kKUAt8F4pZjLql373A/kzf9+Y56woRMojQ4tzP+t9WpyK4ZDlF78B48W0kyEOgiv
         tPX7IV2v9QkMy+Gg5+FYWvFCzKuGO/7tr0rQcnXB734Kmrfxj3fWRySaV0GD7VZHjXcR
         tDoA==
X-Gm-Message-State: AOJu0YxacGGQtUAASFL9kKzMSlyGhs6E/JaW1BbM97ArjLDdhm58H3wA
	kZgUi1x/axQB81eAyLFp4XER9HWPoUCf/DZb6f72lQO7eu7KQBG/vtjFQW/nzkkPENBpXCQ/7Yc
	sWDTqUULF6Bd+Ryd/2zN8m245hEp1oaii3augKw==
X-Gm-Gg: ASbGncuymsn8p+3ZBoGmpRq9aiFNA8XUD6ko3PwxaP8joseU1Ugo17tojwnkS5uCzHy
	vbsart2Btls71RnYsAeN3n1/l9fX9guED/zLDLR6kkz6ZhNYaruqUHw2CKIDr0vjb
X-Google-Smtp-Source: AGHT+IEmTnYwUS/GoFS5lHtmsk6MPCKN7/BBErYWheG+A2g8DHXNCtrFTmlMdEgbpvkK0+ZlnzCUB4v1D+drV8T/SYU=
X-Received: by 2002:a05:6122:640c:20b0:514:ea11:4ee5 with SMTP id
 71dfb90a1353d-514ea11529fmr708139e0c.1.1732189104384; Thu, 21 Nov 2024
 03:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120125629.681745345@linuxfoundation.org>
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 17:08:12 +0530
Message-ID: <CA+G9fYsaZNm2VKnm10tR4dy0DfnE3_FQtkj-E9-SPR-RacXxcw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
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

On Wed, 20 Nov 2024 at 18:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c9b39c48bf4a40a9445a429ca741a25ba6961cca
* git describe: v6.11.9-108-gc9b39c48bf4a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.9-108-gc9b39c48bf4a

## Test Regressions (compared to v6.11.7-249-g0862a6020163)

## Metric Regressions (compared to v6.11.7-249-g0862a6020163)

## Test Fixes (compared to v6.11.7-249-g0862a6020163)

## Metric Fixes (compared to v6.11.7-249-g0862a6020163)

## Test result summary
total: 154549, pass: 128415, fail: 1847, skip: 24287, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 128 passed, 2 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 30 passed, 1 failed, 1 skipped
* riscv: 16 total, 15 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 34 total, 34 passed, 0 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs[
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
* ltp-tr[
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

