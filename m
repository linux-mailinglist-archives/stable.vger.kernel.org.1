Return-Path: <stable+bounces-46043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C98CE215
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155EB1F2274B
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196A81AA7;
	Fri, 24 May 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ms1eZXco"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175D82D6C
	for <stable@vger.kernel.org>; Fri, 24 May 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538393; cv=none; b=I+YWdLDGAjmcJrnNaQ1QHEevEByDWDg5wfZuZPJQ1J96ZVJPRwG/cjLZTlsoWXRHSC+aQtgJgg1oJ+L2zOumf4+K5t8/05uKMuWhVxPlnTGA8Z3DEmDxnIna8u1doMDDcPMsy47tJjuhyda8+xvNnGWoSBEDxItjgK6htImQafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538393; c=relaxed/simple;
	bh=iDZO2JEbL9dapjSXJbuqTSFdvFd4rrdn5qoCA+BDAFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+lEcsshkiXDkgYo1anvsHgw+4JPv1YelcoPsOcwAPQh13NsQVTsIh/R8rKk34Ga3smxz31Yyw4tqTQS3gFrBHsVNnXpfBykVhJI4AGpdLwRiiaOre9UXGpGJUoW00d7zbj7bs/6rRvnWAEwpZBQs3GMglPhGGqNTZV+TQqA6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ms1eZXco; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-627f3265898so26764797b3.3
        for <stable@vger.kernel.org>; Fri, 24 May 2024 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716538391; x=1717143191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/vZiBjXa6s1sOVi/WrPbknmQ7jkRff7AyHNLyA3ytY=;
        b=Ms1eZXcod5gDp2LrZ5psO1Od8N3SIEjPDN420Qsm3W6Mmi+mp9ekXUBCkiB+NT/+xf
         46ewgBZmKXAq7cAXkbLBiVm6SAGaQaCjDeKAyiVvh0cncaKfO3FA/UoVS1tSxiJVOos5
         pzcHATprZ2F8Ht/V50/uI6RBFf3jJpPaZMV4DOlnJ7KfhtHQcijScSgmF7XMxKvnvcRR
         3M5f8IqaUUZGuzkYwRocbWdQf9jalobcNIfEPj8Kp7j3m9sSbpjLapL3zERmTmrsA6lk
         0qL9Xk3HeJbJgudWnVxudDd1KcEOZnvDzqebzkAwwTJP/Zvt1zmOF8fWaEwcyywJCKqL
         xVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538391; x=1717143191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/vZiBjXa6s1sOVi/WrPbknmQ7jkRff7AyHNLyA3ytY=;
        b=EoEbmAf5PTjOpVUnJT43havoUhOZUNsOFXiB0yvkFaZ0m9tx5xQ1MaHwHgMQHUx0Kr
         AmJozP5G6eJ6hY8RRpx5r06ysv4RnD6qjtPuIiTjKAHQO/fd5Q2EOMuCGut8pXbz4WRK
         Ohxe3kTr/qGjDtsCyC7aIcYPvDQBG3se+hVKKNJObnhGThT4xb89ggBKZsYy4d4WUzOZ
         5g38AjfBq2Y0xeQsV2RXWplq0AS1iYBJyBv/QQdWIVKaJn0mt4ZfS/vS+7n0ytTtBQme
         mO57/NWriS7e699aW90KRv+jjcHBbcX418u2hi0MJvh5wL45Tr9cu43u8DXIbapraX1d
         7MjQ==
X-Gm-Message-State: AOJu0YyYL2yJSmzQvqCYNZnCk9r00v/EK3yz9XONO1eX2j2dRf0+5FL5
	WYmmrfg8rvGerDA60NkdSS5ZoWSxd3M2qcP48vKY8gxMQliEit2ePkL6vb6mhoYAxAJUNpLaW3J
	aHPtoLpm4kib82ulrztLQz1cjl2Pgq1ji/4nPRQ==
X-Google-Smtp-Source: AGHT+IFCajKrEg1yHLorioSNG5XEJQo8CoJG16SVt9J/QKpooT2g4jaTIDYwb+RVF+olXqUkqj7x97n5zEGdlOCGaeU=
X-Received: by 2002:a81:9201:0:b0:620:33dc:8357 with SMTP id
 00721157ae682-62a08d7eedbmr15040307b3.18.1716538391212; Fri, 24 May 2024
 01:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130332.496202557@linuxfoundation.org>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 10:13:00 +0200
Message-ID: <CADYN=9K9tbiLPSx9Xg+dMA1WsZNj4Z2cLT9LLYQZn+ckjJzu7Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
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

On Thu, 23 May 2024 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.92-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 4 total, 4 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

