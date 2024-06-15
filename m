Return-Path: <stable+bounces-52265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8599E9096CC
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0381C20E93
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FC1BC40;
	Sat, 15 Jun 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBTDLvZl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B7208D1
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439127; cv=none; b=mDLOVI6rRD0JDhcY0V5If3mS1Eqk3iVNIjZvTNv59nEOdC6jJrx9xRPp6f8lOnOmuoSoSFgra2srSnz9ApBu88iiyMCcjaC3HeygbeeNfQ/TM1+EozwNVj+DENG9R31tQWaR2iX1m2yMygI//seE+ZukvtWthU3tX1i4Dcsck9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439127; c=relaxed/simple;
	bh=T/MZPbZQgPKyZqFaOxXEYvsvn2SayXByQqpNuAM55us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNt6/hl/dEkTmMVQEX4ncx4qwgpzgrkFd9LnEWNhKCYOIeBhFsgQULHYnyof8vpBwKzFe09sickDmmnONiz84ke1YLUKzsGDNYQqFhrgQ7edP6RwP+gZ26PW8XBJCRSCajd/6+2sMdJ3iKyyQyExbDs0wqus9gQfUlw5WcsJOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBTDLvZl; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80ae49954d3so767022241.1
        for <stable@vger.kernel.org>; Sat, 15 Jun 2024 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718439125; x=1719043925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX/O9XayHzYV7cWWCWO6mgKk856aZ6rbvTGPWtOjZk8=;
        b=mBTDLvZlZ6/Y6S4WfugApstxaTJ5lpHSfHZB/24mpgfdftAaiy1iS70pDcgrKNR0MA
         3VuaiYClRSx/POw5Qtz7vydL1g01HOjbnvjERU6RBq5T9x5ArrrWxUsARrmdUzdWcHis
         G0+er/csMEN8SGZwfvZs2IBdIvuPhTjGX01xUjnzV38ei2eezZ3HV7lAmqRVBKbIv0CT
         zz6IekNuUJWKcRleTaEv0jTYs/CXkqjclv+ufMOszNMtufmif3uDsVOCu4u+10GK89r1
         R91bcn39axeW35284PO8C31AHsiNR1P06x2pe0lZm/KapT83tG+nDcD8IKBzK7Xp1CK2
         sTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718439125; x=1719043925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX/O9XayHzYV7cWWCWO6mgKk856aZ6rbvTGPWtOjZk8=;
        b=va+k+VFODkM8HLMmsqzJ9EbOS/GH8JV7YPII8yp1xn7uxGwLDwYDNAt9JYw5NNdglc
         1ID4/Ty+Zr9mt9soWmTh03/EsH6JkLhmjeggSooruEmpF1q711Z7fsUBFNSeSaoRoGcx
         4/PgMObhWk98IW/GALIP8cuDV4StBmTMeLMkHhupELyyL8BI1QkeOOT703GvWfr6loGq
         /Eq6CzvGtTEYrJKFtjoD3d1EqyqY1aJOqLYLiVBIBdpRMHn+3KLe9dgE/IcVxIbiJDmR
         yTW2xKhmLo052i64bAkravUB9+IF7sIdZExooWFIyekyuKoDO7WiqM2uuVx4u9vfxhWR
         jtuQ==
X-Gm-Message-State: AOJu0YxtTL0Jjd9QDr6m9+EAyjWTjO55tn1MNOmnVXpB5EP3hA/heI4Q
	WarCj/OxuXCQdyEOFAe180ZUHMQVyJLAog82O5VUJcbxmpwsRurLhoT9DqScu0NFdzmkQs1gi+B
	8eg8cLR8dJDBWgOamboiZ5gZ1q8syJpp1PoBuMw==
X-Google-Smtp-Source: AGHT+IE+FSgOidj7gD4O5t933BVOdLfDJrzcamX8mcRHcOSsAFXlr1aFntiKrxA2O0EuNqDWwXit7SM0N4ZTpVrmfJo=
X-Received: by 2002:a05:6122:30a2:b0:4ec:f291:2a45 with SMTP id
 71dfb90a1353d-4ee3eb78b99mr5746899e0c.5.1718439124819; Sat, 15 Jun 2024
 01:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.759341286@linuxfoundation.org>
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Jun 2024 13:41:53 +0530
Message-ID: <CA+G9fYuFsA_vw1z8d5cPiMw7GpW0Y6XQHGeJsNj=3_eda_00Qg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/202] 5.4.278-rc1 review
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

On Thu, 13 Jun 2024 at 17:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.278 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.278-rc1.gz
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
* kernel: 5.4.278-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: b5a457a9ff04a0bb90149f3bc8033a2a98d04caf
* git describe: v5.4.277-203-gb5a457a9ff04
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
77-203-gb5a457a9ff04

## Test Regressions (compared to v5.4.277)

## Metric Regressions (compared to v5.4.277)

## Test Fixes (compared to v5.4.277)

## Metric Fixes (compared to v5.4.277)

## Test result summary
total: 93744, pass: 75189, fail: 2023, skip: 16475, xfail: 57

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 35 total, 33 passed, 2 failed
* i386: 23 total, 17 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
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
* kselftest-lib
* kselftest-livepatch
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

