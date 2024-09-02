Return-Path: <stable+bounces-72734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AE968B2E
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6010D283B4A
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27819F105;
	Mon,  2 Sep 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbpgCgit"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5519C563
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291739; cv=none; b=HRhDjLC5HlLP69Wl+ugVyGAZXKvLclo1SPiEMg+tEydbLsk7MmQ8C1IYHyF24Hy7jY55qGQkKZnpuiY4rmkzZMTWb0KYMa8SZuYlu6+dDPKX3KunLbHKy6YSNsIlz1TdZi2FZOeY7+xx8K8egH65+7wKkToUdXaNGSjo1oSj/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291739; c=relaxed/simple;
	bh=lABA3YzICpkncJQbNddt+/lNOx87kqfXweax2APi0ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drRU9Ubs4ObgkG8Uf53pGDhmIszMsIHZvMwu4EX2Ntqf1wOOyo+b6vEvN9A4sd9Pcls42CC03cnyajRW+NcWIbjXPl7/d5fj/xFmLw+N2Vbf38DVv8h57z4RgZso6/ylt04CiOWJlPs9rAP3YoPQ3jlqRsolLLPhgiUKey9nQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BbpgCgit; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso1343318e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725291736; x=1725896536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5/dmVfHxRGHNMTJZnAIV7TVo2AsaFh/Woc/rAPg2mw=;
        b=BbpgCgitdV6eOPQtc7f9S0TAIVudp9VDxaCXPOT5b4Bx9lapSjVvnA8vQkB0xUnhnu
         kHiTBm9J/GnM2vLbl81M2O+THyqiJAJnKYEFeIS+heEhLS/CBUwH/7zl75U0AYjOUyCE
         8tQ4Aq22DWNa1gudSjAZzOz7ZfsBX/8SAvAlDcmoQjnTCE9Q73oBBkLAtYNG0DemG/RP
         t0vGfAONHYu/ywKST6iqMS0Ttl/h0Rb6ZL/elaQNO1a1oTuZJhHMe3lLsTfIyQh11V/k
         Pbm6asntOe4cxoP996s/1buDWfI4WUQof66ht8vQHb/mYarCtcwyB92K9W04D2QQfw3y
         9IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291736; x=1725896536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5/dmVfHxRGHNMTJZnAIV7TVo2AsaFh/Woc/rAPg2mw=;
        b=Exvd4vrw/5y/n/bWK/Cuu7cnFn5mSLY43Gl6fVnoQAhtaJfOs1LF0sNr82P6ELDmv3
         NJYS0IzkfenyOgXfQA3y632ZAk3hD7ytGS/5HJeKt6pI5jpdPPFDcrey/8D/njlA37ev
         SCSvs8b8S7SyBwb1I+AG5Nz/0c9i0QV4DXKdQNKciYbgT7l3OqxS9wSDr80F53LZeToG
         LNpPWxSBWL97w+W0cjM6wWmtH1KuGBced/WlM5mt7ApF5zjAoRokrpzk4cZhnFcVdkNV
         qJ/scpNhtSTAttZj5WMkhSEmXt3iA2wsL4zODgohm/H58pnw7So3+7hpPvluT4tVIAkI
         tvBw==
X-Gm-Message-State: AOJu0YxCoY0Zq9vvKxTlZn2UQonw1/TRJPlu5v72M4vl1ex83hMPlPT3
	gBwPdv+og+96blwkJlu3Jxp8tbwSaV47KIwVuXxgBAhSuekPjeXL+IVc6I6LRZyYQK+9icQqqZE
	Hmq2sKAuWr7G2Eh7SQckbU8VHieQPCwegbD9qjw==
X-Google-Smtp-Source: AGHT+IFO3hJIhz6L6Xho40w0YwGvSC5rj10Ot/OdPzNf3JEsAeZAK7czgI5AItxJUDBdRIkaaIaxYsTxGpRTrb3FAHM=
X-Received: by 2002:a05:6122:1d04:b0:4ef:678e:8a90 with SMTP id
 71dfb90a1353d-500aad17027mr6105127e0c.3.1725291736275; Mon, 02 Sep 2024
 08:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160801.879647959@linuxfoundation.org>
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 21:12:05 +0530
Message-ID: <CA+G9fYuyyJO8hq-s0Fiygmdmu0_SaNQouhPv5o5mq3_oAeT7pQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/71] 6.1.108-rc1 review
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

On Sun, 1 Sept 2024 at 22:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.108 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.108-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.108-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: de2d512f4921c4dca7994119b4310089266a546d
* git describe: v6.1.107-72-gde2d512f4921
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
07-72-gde2d512f4921

## Test Regressions (compared to v6.1.106-322-gb9218327d235)

## Metric Regressions (compared to v6.1.106-322-gb9218327d235)

## Test Fixes (compared to v6.1.106-322-gb9218327d235)

## Metric Fixes (compared to v6.1.106-322-gb9218327d235)

## Test result summary
total: 157741, pass: 137087, fail: 2107, skip: 18325, xfail: 222

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhu
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

