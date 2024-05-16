Return-Path: <stable+bounces-45297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E495C8C7796
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103C81C222B7
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E71474B5;
	Thu, 16 May 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxZ/WkrZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489A146A81
	for <stable@vger.kernel.org>; Thu, 16 May 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866138; cv=none; b=InzXpDH0VO2Th/2nMm8iwa2w4vfUQPm1zYRinXnf5eAM8Sf0KhMLbcQTEBJ062TR9IOm0S1ggQtA3aYqbc+/zH5WnNMMsF9r/E9Rxx8lSwYQviSHNLvIj4fNWp6ad44rnCEx2Rg8tBl/iLCx8TmWkMxNgOKKV3vm67V4jP68SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866138; c=relaxed/simple;
	bh=iVUir/gLcWCFY7dIu7UsKZJERMiKnSaS2lO2UXu4iHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyHqJWKiDaH+APT6TSVhEWPghAYS4pybILPXfZUZedU6S5Vtz3j34nQlY6gzSQ3ckLVqjgZVew11fayTi8RY7TvaIgP6bi77jkC/EVVB39e6DCBxRbg/zFFlRejAbOF7s0268xFxip+fA2gideQ9qW5Eqzvmg3sFodrTUABHWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BxZ/WkrZ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c7513a991cso126643b6e.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715866136; x=1716470936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyjmRhpoF55A1ilLauDrV8RJGeR4fHgrsIYfzftwpR8=;
        b=BxZ/WkrZoM5uq0BP7CCxgsnkH3udZBwn6fgak9j7p1JfFS4QvXADC4Zd0bTPWc+zQG
         lQUpiaZohkzGzxgb480XOWV1dkM3MBrao+CFOYAN6wRBsX4sO4V+OewcnnZmGy56v/qa
         fZAAaHM2QeLgB5/a70DufWp9JnltDnMLo1eH+dhBEMekKHQiSHOelwQgOmqMxJnPL0gg
         WgErtCFwWCy6mpuU6pbPGOsrZSeKkqYxfcvyiStAp9j31yco/GX8YwEatTGWwsL+vXE8
         GeHOK/ApXDv9PTBT29wWw9KXGWPoNcybvEFeP44QiiTfPBVPNKwxTCH3EDJ9/aEbvDUu
         zprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866136; x=1716470936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyjmRhpoF55A1ilLauDrV8RJGeR4fHgrsIYfzftwpR8=;
        b=rSRLZxyfzfRdhOkwq0XgWllb5E+/yp5iEuKs2iQABheEbvhb17dgr1F5vMvPiT65AJ
         kcbNesKi0BkIXNYn5UsRpO89ojyyQyWsrGQP9sUsqTpBTZrniUxIs2/CWFn23ooDOe8d
         flQbkqQ6FsATPadRh38l1fB8+CtkN1kJ378dKTajIkDl92PRKOzPJUBC47nTKKUXUUxB
         rS0VbXwcr83JQqTWKthDnPx+bLrbwUkarCkSLOeq8EKM4DWPuNk1HEiMnVG/Mx70a909
         CHlWY9XbA/TD/aJJtwFBQsKTBsPN5PqsLRbR42UrbRn8brW7bbk9X6XLNDs+DkXjHPm+
         jYCg==
X-Gm-Message-State: AOJu0Yye9Hlq6H1LM8J+wxYIyXFBrl47Pqpd3Sd2OZ2lu3OJOZfW8gKE
	rLsvrzAue+JngEmD73QAPxCcV44wBPLjftgbJ4zMqa4NKA4rk7fEP41M7WAtEkv5/mgV/niPaAP
	OYsXBK3IUScm/JYpa9lR2O53OeFB5RBKu1IPWiFP2dbxt6N2e0JI+c8tA
X-Google-Smtp-Source: AGHT+IGiDXIu9aT5ycgGSk1DcOOJljD4YmEWzmMpPQM/7ewodG0RpkcgZThKwoz+3zDRZzSyPgFIUFKOYR1Q3zrahnM=
X-Received: by 2002:a05:6808:2006:b0:3c9:62e0:1d2b with SMTP id
 5614622812f47-3c997039239mr25210018b6e.6.1715866134714; Thu, 16 May 2024
 06:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082414.316080594@linuxfoundation.org>
In-Reply-To: <20240515082414.316080594@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 15:28:43 +0200
Message-ID: <CA+G9fYupaeJ_kx+c1b+M92=q-+EVHLGh4Wud0WfJbi_EqYt-tA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 May 2024 at 10:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.159 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.159-rc2.gz
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
* kernel: 5.15.159-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 1238a9b23a79317df7bcdecb6ef6d215d229ff3b
* git describe: v5.15.158-169-g1238a9b23a79
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.158-169-g1238a9b23a79

## Test Regressions (compared to v5.15.158)

## Metric Regressions (compared to v5.15.158)

## Test Fixes (compared to v5.15.158)

## Metric Fixes (compared to v5.15.158)

## Test result summary
total: 75453, pass: 60921, fail: 1828, skip: 12643, xfail: 61

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 7 total, 7 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 5 total, 5 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

