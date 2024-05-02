Return-Path: <stable+bounces-42954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF258B9598
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 09:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7151C20FAF
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7B1527BD;
	Thu,  2 May 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjruYvQ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46722EF0
	for <stable@vger.kernel.org>; Thu,  2 May 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636170; cv=none; b=c60VZNBuedviBhzmwAWjtqB5a6QHC4LpYM4E7HvMIAw3HjmpBAcDysg2nfglJ/V9G9slzVlqqoMsE6lSFqjFXboPDS/nlOP2cNaxpI98p0J6QRcyiMOHEsH7HrUzsYUkoYgo8oEgHNVKLbxiGhDAWwSPms+djCEb5YRrqHxh0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636170; c=relaxed/simple;
	bh=iA68F+rolBZJXO5nKHvOSs3bHRYMcxCkn6pFYHHPzwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhH5oC1hGc/67MHpNiUwDqkVWFG/UUVqtD4F/7ob8T06AK2mtdsLH5QolMGlMUrZf9NzL6iSB8+Mdi7ptmHyniPgzMGucBHY29xW8tpA9yt/a3kofCsMfAnb2ECMZKtB+MIAvVaaQDc65goWjPTu4gvqER9wkGKdIAxeLmTrF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OjruYvQ5; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47c303c7711so1211028137.1
        for <stable@vger.kernel.org>; Thu, 02 May 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714636168; x=1715240968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kYlRErK1YBUSRqRp4uQ5pB7GNRgpJXOvW08NiRbyrs=;
        b=OjruYvQ5oTNS07s9G/+unsRhAy5meQS5lID9gNz1/XQqvVeP9etQY5i7dIr5QzsSEs
         YAR1BujFE3PBdeErLsmsCJXIuQ7H5k1+nO9mWL53+1oC1hQiTbtyLpCvnN9Bl+QFDKxY
         Cae9bUcl03x0TyWutpMyAKIqyoylJlVJs5pXpjZL5hNsoZm+q4VAvviZTAueMvD3i8Be
         OjlJi+x+nrG64iDq6gFe9ddhN2Ifz5JDKhAo5jDDm2D/1qAbkM09DkcO15tG5aiym8DE
         JlyHDHiFsuj6mahTdXKV44phTbghNdYlZxfVONUGBnlfAmR+KnVmZN0IvRvO9Byp0Qp7
         5ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636168; x=1715240968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kYlRErK1YBUSRqRp4uQ5pB7GNRgpJXOvW08NiRbyrs=;
        b=JGhVOvRJyvupPQs+VfNBU6uF+B0l/Wtlcpa+jo6RglqPg3q4YsXqTOEnT7b7VhSaxS
         0ZLQeLlon1wXVrHvK7Mc7hSZUDTcYUqSYs1im63ebd0pQJ0B51wwPUtakwRkZwGkyCz+
         7y6lj61zZACaE1ooukmbWyh8kAqRgdAARpmeEBuUZQq79QiWWlOvynLWWyN1psTOIa6J
         m96aPU3AdQS1dtFpQJX0w1jjg0/uVT8AOzPQ+t9JiXl99LYfqyQlscRr5Nuj0gLNeTQc
         4SbA1tqpoU/QCfYdwEfv+o0+who6UGssErJbzPUWI4N/Tv9A7ZaWs4pIQULCKPj5p3yi
         eBzg==
X-Gm-Message-State: AOJu0YzUw/34GLVfhsuK6UA8jhdTedGLPHJ19X54sMD91Yzd6PemcCGT
	iqvcKEup8wreVy9xvwkaHBcPTTiWhcO2SNxnu7yv7yesNcIt4dqgQBXrYSE7AbQw30PqEZZRSy2
	tikc35hCpBDOlYuQ/kTRBgEtPDpNsXKzBHXNqvQ==
X-Google-Smtp-Source: AGHT+IG/WtFFdu70A40C+YumlSi2AtUlDf5sl3ZyZPbvCoeRfjJUwghUfhnYfNUoTcZEQV24IGGKlefR+GwWI4HOlWw=
X-Received: by 2002:a05:6122:c9f:b0:4d8:79c1:2a21 with SMTP id
 ba31-20020a0561220c9f00b004d879c12a21mr1367427vkb.7.1714636167735; Thu, 02
 May 2024 00:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103041.111219002@linuxfoundation.org>
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 May 2024 13:19:15 +0530
Message-ID: <CA+G9fYu=HarRpHDvZkuWN1vviKj88ZTZy-6nGg5tQR7Ans=p-A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
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

On Tue, 30 Apr 2024 at 16:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.313-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.313-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: f656c346d44e96711a4616bce8f1f313b63f9175
* git describe: v4.19.312-78-gf656c346d44e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.312-78-gf656c346d44e

## Test Regressions (compared to v4.19.312)

## Metric Regressions (compared to v4.19.312)

## Test Fixes (compared to v4.19.312)

## Metric Fixes (compared to v4.19.312)

## Test result summary
total: 58160, pass: 49914, fail: 1047, skip: 7150, xfail: 49

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
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
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

