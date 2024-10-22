Return-Path: <stable+bounces-87671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118769A9A33
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7993BB21D0D
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4013D509;
	Tue, 22 Oct 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9Epv+u/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371F12C549
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579585; cv=none; b=AAOPdLHPhziICfdxwoXgti11gy1kbR7AfuXxOq43JS0HiafXM0RMe3Port1xFuA1lIl/WCZIJTqPydDiFOpEInzCR4ydMrco4FLaNfg01CmSCw0DKxWS4EqsoV1RSdAltJxI9XBO3RaoW+EyrDH40QXeTn2sH7Zq0iy7u+raBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579585; c=relaxed/simple;
	bh=UqVn6pMI3tQcLwCHW0AiJNTo/yvLYcGLPXrQ5ceMbD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xd74vdTYvHD95Yp4u0Gu9tBheWw8x1ZTqIfXpzzga9hWqiRk1mOafxr5MoxPgSIgd1GfmNs4AU2ijRDgg/g94ceiFsQ2zTjxGAFKqLrsVvX3n5Nib2wLlkunGel9SnGcbX53oVgHIdxD6yJzTt75zgDls7FP710hIpe45XTlViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9Epv+u/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fd01c9defso1612544241.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729579583; x=1730184383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdFazzegJ/WNfhSBmiwyDVArjBaCTXYW6mDxPc7wy70=;
        b=S9Epv+u/u6/BM6A/dPuZS8/YPj098j7D/+3b3htAyYwzGRcodXT3wT+qGmTChOosDN
         IBRURIAi7ZSnX4wYjQKo7rmvvhIqEVDUCNJymH68apF++y+Phfh5B/Ol9Nf1knlF4q25
         FJ0/jpigy8nsjUf49CJsw8FeVycRYtWRDiqQbCXnBEseY1dfjsxf2CMw9EBc6mKmBYjB
         7uGjPl0kORB1+MbsEtJIIpbUKKWVH71NCLSMSgJ5+fFbMNc4Qdxv3fyAQrLXLz++bo/V
         NsJD+/SFu3kXTnJ7B1Shgc3GQCzov4ybYRmOTO/HFRilHhRcjGtIK8PERk/BzkatG7H/
         Hkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729579583; x=1730184383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdFazzegJ/WNfhSBmiwyDVArjBaCTXYW6mDxPc7wy70=;
        b=LV5PIqIMLy25fcAVox74dOq68jAgt2Si0CkwD1dU+A7Qk/EU45D60uxP6vzSTCqXQ9
         kGi2TsvaewufpMHTJjSAlstrChx7v6NAW+gzscEbKjArC1U4HACnFPDoV5/rzSFSwNPB
         kAZkaAcs3WqxHscB/cB0JCGHoelE8NceGmCLyIgpNKS44qIkUu8g9ysx8vtu/5eZsZYk
         AmdQ1eLEaU8bfeScH4KcarCYnaF/POl9LUV0RI9pXGtVFxojkzL/MUkOAsaYZ5UdDjMN
         dwdFfpi8XTPmyGGyo7ohjmmJCKjkSatC8h9Cfv/NIhn8uW3ryUYBYKuizJ7F2iuqOFFt
         f3rg==
X-Gm-Message-State: AOJu0Yyffr55CeOyNPYdu/DJenJWyOBTGlWhXOkW59aB36iLYntm6rh4
	L/+VMYd5BDmcFCIiU06GnZMBHVsxDs9YO4CQB1SJVoWL53dFY/RCch/sWkHjhxXhffEACdDtj5G
	Pa/gttVFwsvKpvdOVPrF2Xevy+g8xHYXlI7u3JA==
X-Google-Smtp-Source: AGHT+IEJndDCSfgRiJSpRxITuC3UkI7W3S6FWzHL8/AurrOrJG/3IoPI8nn8tiT/NIRA9MwS6kbOy4Ri9AaTUdlWUFM=
X-Received: by 2002:a05:6102:c11:b0:4a3:ddc5:37a4 with SMTP id
 ada2fe7eead31-4a5d6ae08cbmr11836034137.11.1729579583199; Mon, 21 Oct 2024
 23:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102241.624153108@linuxfoundation.org>
In-Reply-To: <20241021102241.624153108@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 12:16:09 +0530
Message-ID: <CA+G9fYtbGC1caN27L6V=NC40o0oaPCzfgvDtkb8o6qPSaiKMNA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/52] 5.10.228-rc1 review
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

On Mon, 21 Oct 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.228 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.228-rc1.gz
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

## Build
* kernel: 5.10.228-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 11656f6fe2df8ad7262fe635fd9a53f66bb23102
* git describe: v5.10.227-53-g11656f6fe2df
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.227-53-g11656f6fe2df

## Test Regressions (compared to v5.10.226-519-g5807510dd577)

## Metric Regressions (compared to v5.10.226-519-g5807510dd577)

## Test Fixes (compared to v5.10.226-519-g5807510dd577)

## Metric Fixes (compared to v5.10.226-519-g5807510dd577)

## Test result summary
total: 59318, pass: 43619, fail: 1978, skip: 13654, xfail: 67

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

