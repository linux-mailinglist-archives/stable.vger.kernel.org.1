Return-Path: <stable+bounces-104185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8519F1E39
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 12:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A47188634A
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87327188733;
	Sat, 14 Dec 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+wQRzou"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C115C14B
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174986; cv=none; b=qIRyOMylTzsjx68ZvA20EOTEwGdM5WAivHztx1Diq9/wGLUW8558p4jkIwe2xOZa4aGHVxYrn1OmHnNZVYMLK7XcOIk2e20AONJ41OlB6+ipd1Q9WHoN3QJutm+2N2ttCe+kV63kagdPvvdiYEzQDz1x0kGM5uiknj1nWcql46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174986; c=relaxed/simple;
	bh=Bq7EyBCrewGf7WfUYPsT/2jbdKTtf6N3GhCPqzaRkWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myW1bAIX3GqxdiLLuhJ20SvJQqUHozWYByBluHgEBJupVXrQV4Qm5WYHk4ik7SsBjEpW51NpyIve1d7czZoOYT48xzOGdm6W/pLZ129lZVrFcxvnh0d67nKUW66UraeSipLbX7lZZXbdLtGQ2AB5/M7zDO2ss7kTB5qul6wfy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f+wQRzou; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afe1009960so656961137.0
        for <stable@vger.kernel.org>; Sat, 14 Dec 2024 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734174983; x=1734779783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTzKYRBN7u7k96cZPNQrKsCkmmERoC0Jn8Dsq8skyqo=;
        b=f+wQRzou3gyRtOV0fZFJsMFYpYhLjR5fOzCzIs1N1WeQCjJ2hdE6UX7ybErwOr30gB
         cIop4UrLITKiA1zpJBtF9pztziX32+Whf4MH+tbxcNGnQmhRQKynPKrDe6wgfXY2wIs0
         ln0eBkHMQb7hMU/dKh7lnB7hI/UHZ7cK/mYfMPD1uBUpByChrdKRvdIkL5FGGPtOZEg5
         ggelCd8D7XCcQ1rwNvGL+HLfqY1A0C79iKLjfE2LevK9YoDKkv9pXwq1Ypi2tObEyK/x
         UelUOk3H5QDCS87XjRBilweBylgL9X7ZNdUtnAuyQzS9OdPB18NkI6JO5RRndxP0myqO
         J6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734174983; x=1734779783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTzKYRBN7u7k96cZPNQrKsCkmmERoC0Jn8Dsq8skyqo=;
        b=XkoNQKVh16gqsOG7/8WviLTsq9+/IgE4BOgDwpuhHxw7K1IDq2+BLOKdVJzCMOyFjZ
         EMmmKIie66NOHpY9QPGO2oemq2UhrRdQgPj+94SaR6mxrlNTXp03PtZrIkwF7c9CoCTB
         1wvHVUqRo8+PvH4pQxPcJDo7hJ/eQdKgP+aQavVc7BTIm2L/jGXrsa6LEnx0moAyPDjy
         8KzizwpZYk5OEhuxKsSjR4XU7TQ7aQqASgN1ZvTbm9U9W7YEqZgzBlSbS09+wjEWYqMe
         evj2Ot3ZPzvX8av2qgRq6zReUcpdJqYMNrTOdKehuxmv7/+Gy5pGwE4ZUNzPxcuRVv7L
         Gzfw==
X-Gm-Message-State: AOJu0YxTaHKtRbNJaDMAUTmg4BGqDoTRjxyz3ug1ZeNrx8bunk/ssMvX
	wcqwMEq56J43440GZLWqLUFNtgawDKzwviBPXtlpzGYlXb4eZd0pFVgtW6S7pNzeNQQxOlrd5PI
	JekC+Gxyu4oQLJA2mWQsR2P5RSzIYYffE52Vp5W8GETkpmYI86Gs=
X-Gm-Gg: ASbGncux7I7C0ustUCs2ADqKOYNSyYLJziSZ+vOSbsu5yWgAx75KTCG6jP4NBCIwIia
	0lJgL0JOSMcaAyNTGscM2vQOf7KNjhp8B1eizSKHg6kQJt0CSKICkTUfLtvVRdtVDFP5M3vw=
X-Google-Smtp-Source: AGHT+IF0zY/G5VOaxPikTt0DPkKqZJjwV1QHu77sXbzO1ssmJoEODDm+y9fgDuh1dY05j8VxHlt9+0OKE5ho/wRkdQw=
X-Received: by 2002:a05:6102:3587:b0:4b2:49dc:44cf with SMTP id
 ada2fe7eead31-4b25dc619c0mr6694176137.2.1734174983455; Sat, 14 Dec 2024
 03:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144253.511169641@linuxfoundation.org>
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 16:46:12 +0530
Message-ID: <CA+G9fYsERkXC7u13A97Yhc_iHup-5uNsFDz_d41=NVpX+QdOBQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
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

On Thu, 12 Dec 2024 at 22:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.231-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
-----
The following build warning seen with gcc-12 and clang-19 and
clang-nightly builds.

Build warnings:
--------
linux/kernel/sched/fair.c:8653:13: warning: 'update_nohz_stats'
defined but not used [-Wunused-function]
 8653 | static bool update_nohz_stats(struct rq *rq)
      |             ^~~~~~~~~~~~~~~~~

Link:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7sxmkFm8o6GI3rp=
D4gmlFmbVj/

## Build
* kernel: 5.10.231-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2146a7485c27f6f8373bb5570dee22631a7183a4
* git describe: v5.10.230-460-g2146a7485c27
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.230-460-g2146a7485c27

## Test Regressions (compared to v5.10.229-83-gd7359abfa20d)

## Metric Regressions (compared to v5.10.229-83-gd7359abfa20d)

## Test Fixes (compared to v5.10.229-83-gd7359abfa20d)

## Metric Fixes (compared to v5.10.229-83-gd7359abfa20d)

## Test result summary
total: 49631, pass: 35698, fail: 2910, skip: 10999, xfail: 24

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
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
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
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

