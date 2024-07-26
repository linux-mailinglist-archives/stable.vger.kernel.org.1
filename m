Return-Path: <stable+bounces-61916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111A93D7CB
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89761F209BA
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0669A3BBF4;
	Fri, 26 Jul 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSDSl3Rp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA318AEA
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016117; cv=none; b=OvwysWQqEM09RtiW7PEDBrJZxlj25nxn7htOmIKDcoSJiEmjksMXGsQ+xy01YxXYcfPeQKGq0nC7L6MZAVGaEJsEbXLiQKDcKHFQNF4mRH/1brrK/SSPylVIJDT3oQOAF3DnhvI0MGFqYOSItMPxtfRkpU2qPWZWMtosI0oy5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016117; c=relaxed/simple;
	bh=otPRFuTabGDQ7DAsdpT0OWXU/0cXxSp4T04CdGaalzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt+VGwzUZ2P0B5Nz+vj56xwoDkiVK2MyI/PlhGdFtPv99HH72N8yWCL15Zt5xpPSihki+gh09L7W8cavth6OimljaZ777qUDKDsJ4h4TGIX326S/5GCiqDOWD9wn+DemjvTKjqVUvXAI2yafYiV2d7MzTrlUvTjiS4bGe2c6CQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSDSl3Rp; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8318b4d9539so257936241.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722016115; x=1722620915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spa65CuiZdVRxM1p2T1rZfFElb+ut95jd1snNIKOAkk=;
        b=qSDSl3RpPj8roVgsn1EoqemIlk9ObuWpUId/lb7aoQBVgZzlVfJeNPEFDJf/Ohvwmw
         SiWleJVty7B6SBFbiqOOHCUOGVySG5m57gPRnAXxiNxJNyNjIt7dmEJbRDY3mDCK0Svk
         bnteSH+lDDPdp1OuJjrPWBFeZVjFrPobEBoebqtfePknNQna9wgSlBTbu8Aub8bckRaF
         E6Omw0HTWgcZ5qwd5VRXvmW4o4BkxCTQKEGQt+T/JV6jAFJVI36nWCncQ0JrOllLNxmx
         rHIzojVGb0lwfxxTJDb5sAeUddO+OSz7in5TSZGHOtQ2O24TnPOR+qhNhVQgbU2lxniI
         z//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016115; x=1722620915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spa65CuiZdVRxM1p2T1rZfFElb+ut95jd1snNIKOAkk=;
        b=g91CkDiB8eqaRp8UUni22qjS4ByO3C8A2s0HXOV3X1y+yaKk5lGWikVq4RdxSjogiB
         +YsDhX2CI3KBsoKlfRo1OvSNCWd+lrRELCJttPDTkgD/lJoBYCsiH+g3a3O0BGSgTr/3
         I57n2QRzcHgIiThaF9wCviFIDuEGl0oi7m/O3OkuHyz5PYghXADc8pGou0RTSr60HalB
         EKURhgn2IFsGquIdrNoXLSB/d9yI4FDyQZ0IsrHhoOQ7+3c38wBFrXBi5uMzKuifi0uH
         JMJXwm4e61dRcAzMVBvpnuAKRjdQ5bA+v37UJ0sJ9X3WDk/61ZHXhzp19ud1fBhI1Ixo
         ZJPw==
X-Gm-Message-State: AOJu0YwCFyvoc3HsQW/NUoL5nZgQoXvxp2JU4tj+1WsEHEZyI9Go7OY/
	SFtVGf9UzDAuuv6ZONE3aEnZ0F13ND6XCdsf3ws6SXmhVCoMDNlEjbSBqOnIGiFLbSSIrKdtmCY
	sM699pM/eqvDBK7w3l/vRR656lVYvPV5+FBH5hg==
X-Google-Smtp-Source: AGHT+IFRdvMqwnaaR8cmizGpd3HnNZS5sihGiiwBkO1giU7j3tM3LeR+KNWh/P3+PouzbuRNKJYHM9i+w74yRiGMJL4=
X-Received: by 2002:a05:6102:442b:b0:48f:e683:7b46 with SMTP id
 ada2fe7eead31-493fa15eadcmr656628137.3.1722016114971; Fri, 26 Jul 2024
 10:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142731.814288796@linuxfoundation.org>
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:18:23 +0530
Message-ID: <CA+G9fYt-NsFzBhULi-JqQLXSKO123pAvrLTyGqx2eXeLyFJ3yQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
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

On Thu, 25 Jul 2024 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bdc32598d900724563b4f84ff564b8b2273bf298
* git describe: v6.10.1-30-gbdc32598d900
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.1-30-gbdc32598d900

## Test Regressions (compared to v6.10.1)

## Metric Regressions (compared to v6.10.1)

## Test Fixes (compared to v6.10.1)

## Metric Fixes (compared to v6.10.1)

## Test result summary
total: 257000, pass: 223352, fail: 5079, skip: 28035, xfail: 534

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

