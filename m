Return-Path: <stable+bounces-191981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E66C27A97
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E52954E150D
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED22BE7AB;
	Sat,  1 Nov 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uzjm36Bb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429E2BE643
	for <stable@vger.kernel.org>; Sat,  1 Nov 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988216; cv=none; b=oJWpQPE/so0p61638IGzzQFJDuxR3MuhMxIV8p039DrkNQnncPXOXmNQtvGD5XdSKG0i7WeMmfTSaXakAu31vgyOV+lr8RzKjS2WYZW4cfy4gEHrDfMjK6pGez0S2OUCabUSLrNUY145pRzK6NlmljNbmUH3qAjvwkK8bfEOwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988216; c=relaxed/simple;
	bh=Dp2+LlrmkGSTKwtwAHJEz8oBvjgRnxxMPvMMXnTMpGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqM9ksojX+qseV9MwFTI2vH6eKEou7xhVxjGZzf7kqElp7fi80XZhQMZk+fgk0jnHEYn1by/050X3bgaGCgBR7ew+y/tE+5TzqhJk2be4asmXDGjpNWTK7bcRiAO4DfTIdiwcvLcEUVDLG/+YK0x98D1allqzyvkCykeRNsNmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uzjm36Bb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2953b321f99so10065225ad.1
        for <stable@vger.kernel.org>; Sat, 01 Nov 2025 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761988214; x=1762593014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjy8DpaTk4xM2lcsRurqJM+HB6H2irc/jMu1lfXkZyU=;
        b=Uzjm36BbryBEWFC/R5XN2WXT0GRfRU0fw8DiomaofNV23VpZE9VljizfF3+3joSaNY
         E8lpk+cIpNrZw7FsLOp9516nrzDij4veMBB1VjjaIQGmQCQPUJwmOTQNLi9SGn11VqCL
         KNQJmK1bvLZaAfN62jqv4RtF2W4FMBC/q2CCyJ2UDTm07ai1M4phnbNf5LRsM8OGfjv9
         sc9kHrIfx4BD60Puc0dGt8d+qgUIACSLgswabnWHe1nL3ofcvZ3GXLNvc2Siaax9eRsU
         VEXJIT9FhhFj8pRnYQLpeIuUw6w3BMPHJMEyW0D3ZBp/eMxoG9oLRBiXn3i9N89Np4N6
         eLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761988214; x=1762593014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjy8DpaTk4xM2lcsRurqJM+HB6H2irc/jMu1lfXkZyU=;
        b=qnyYo0WvXAUouhCC6752cCp3rj7y/MF8oPxPxGkMgCsWQiuhftudaSGUTduwhLNcNr
         WVHG/sfjkIICZ4fFEWPb6b/HXA7dzrrZySYFw5jyMXQ56WXIywKdzCCixzmeAMeBJkFD
         4R1ZRsVknzxEmEYSuRYrnjqLraB/5KEQlgiPS2Sbp3/UXuVdL1kGk1KAuhK/qFjfU4nG
         FWN6rruQAdxR1VPlWcl0rMYRJsjiyqC3YR8dD9UY+ezP0p6R1V3HNJyE8d1w19g28wOA
         ZeyOjV3PAWUubdwYmjVpXWEFOw46HVFpx4qsRmd4DS0Y+x5Lp+WxnqOH9BfH1M4b2wQ8
         oORg==
X-Gm-Message-State: AOJu0YzT3UnASd7vvC/v5p5etkHzr5C6QuUUYFIDzzsNSfG7Y2+KBwte
	6iyILapWHwIHcK+UJ5fHFYL/FlcmGkslwjTSn7PH15BRVk/qmJbRQapE1/VpZngtGlN80tVgusM
	dTYFaE4Pijj1G6ZoAbikCf+9gI+1GLCxlo7OmqFV6RQ==
X-Gm-Gg: ASbGncuqYp+UCNF75pjgU3PvPTakBxen/rSt1y3txMoPhSJF/CRr/l9FbRo4rRxjm9p
	7ckEY8pXImHtuLWT4xOMxuxUDJBb4ldbd7n9uWvY9T8Lw6yiWVH4YYdwyGzfH621WkiFXTAwnQB
	joGpNWtk9Tq/292AuxZRCxev9xfW7RMvaHOhtMhpaKRPU1cj7+gG9UNvzoZCil9mwK/fNt0RbGJ
	MekpTVS8HFdEdWk+6DYOpv+3P/wmE7awSLLMxknlFLSye/3gjQ2FUR36Qbv1OcMQmMxyTuvd0NV
	4XO4v+4Gjf0bPS84H1rSDTUxYurfErbxu9i8kovYRkW8PJjoLVtC7z8wG+gP
X-Google-Smtp-Source: AGHT+IE/83P0PCPiiJybb9+6zHNoa/A2vjnRPupEud97zgL56fm2RzORpcZVk52SpVD1UIWKuQlELJKAnLSFFv96QWo=
X-Received: by 2002:a17:903:1207:b0:294:a827:851 with SMTP id
 d9443c01a7336-2951a37a48dmr87237605ad.17.1761988213917; Sat, 01 Nov 2025
 02:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 1 Nov 2025 14:40:02 +0530
X-Gm-Features: AWmQ_bnMvHfcDTj3Sf0J1WFQ_EMmx_jBUTSCbGachXza86m83JFdBgDkQLmkckE
Message-ID: <CA+G9fYuCoXiue1eS6XV+cyB+pDH2Bdhkdo6cc9OCt-8F9nXkng@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
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

On Fri, 31 Oct 2025 at 19:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7914a8bbc909547c8cb9b1af5fbc4f1741e9e680
* git describe: v6.17.6-36-g7914a8bbc909
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.6-36-g7914a8bbc909

## Test Regressions (compared to v6.17.4-346-g10e3f8e671f7)

## Metric Regressions (compared to v6.17.4-346-g10e3f8e671f7)

## Test Fixes (compared to v6.17.4-346-g10e3f8e671f7)

## Metric Fixes (compared to v6.17.4-346-g10e3f8e671f7)

## Test result summary
total: 126960, pass: 107190, fail: 4404, skip: 15366, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 53 passed, 3 failed, 1 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

