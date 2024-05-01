Return-Path: <stable+bounces-42847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A738B854D
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E8FB22058
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 05:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB87481BA;
	Wed,  1 May 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StNcsZf0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06E46558
	for <stable@vger.kernel.org>; Wed,  1 May 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541122; cv=none; b=dAnnxdMd278su7gEOiLqgkG2dgnNAE3fql0q564EzgCoPpJEq6nLuK2kaM+Qisx+pnjrlZ2/u234RWr2fVgHdK0K3Nuft837/rjhzLgsTOp6CV8ppf1b499gQoA2JQ10ot4kUTY8bCwPbyqcMuW4qDPFn5xWbcpwNRPix8ahJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541122; c=relaxed/simple;
	bh=XYEu0XIuOSc0LaJT7C2brLowA3qUmNusleJOEIspl+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSfkJAvuC6aM+5JWHKbzveDA/HpiwlGmcv0icDLzFU29zq/GY3ygYxdd4z20lvJ54ZChgd3ThkQwV0374vVQPMTAYZcSXshS41dZeyxeXIPgrIhanUy3Oi73ueWQlVROJ7VsTIs995YKx0kZspNdR/Xe6EeMDOPyN4afreoN3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StNcsZf0; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7f3c389c04aso4280241.2
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714541119; x=1715145919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKAyEdFLTMYMkl+qSVoB2MJ6thzzQhoOyIz3GNSqdnM=;
        b=StNcsZf0Ktqqbm4weo57gONo5Nc/yfhKQh9tXlOIqwY7JMriixep/lqKqmm4mwGIsN
         Ikwl7zqzjpW8SnQQfcXMm4vUt3RkTnzBowsUkqKc4KGLCqs4XJ1F44g/FpBXxBnZbO1E
         68/jzeC1Fo7MQULKdeRwU84prqrTluqq9YjRSEyxIbRt2SAOfW6mynmrxZ78qkk2U6HF
         FwTT3QbKO0V9+FE89Rq9J6DfAxxgRwFohMWHrylNESNp/cR80VS+NQqqfShOpJ61rofh
         oaF6H7lhVI/NepUXptLm/TDQEdYDbV0ZaUQ3ndGH4KYW+z2cQOzXy/CQiIT2Ns+uD/UF
         K3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714541119; x=1715145919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKAyEdFLTMYMkl+qSVoB2MJ6thzzQhoOyIz3GNSqdnM=;
        b=X7/hJVeka0fe8TiuRwoeuRExy7Z3VgOYrd9dYO02ZCT77GXS+PpNuRnz1V0kIbNlrO
         luk5iG0J1/pn9Z29kYuoBcyCVCU28Jo7eM6OgauWe4fA/9KsERzel2v+P0EiQyFJW1xk
         E6Kv9ZuqOk8qRHgUoND07WOfknEENJxAAN89H5tPSk5J/zRxXjGBGlATnhDXmsY4dZjI
         YjidhCjCb49QjfDab+41WBYMTbB3VQBY7h0pwEBobCImES6Ou9RHxZueKf7dvCephg9E
         Bw7NEFjqdFivLY7h6x6Ac6dE7C686JZNAl9cRfZ6MrXHEsg7vhCUr/yySo+DGrv68n1x
         nDlg==
X-Gm-Message-State: AOJu0YzQXxX4Z9c7U/FrzvLsSvxjEmf8J8VJVnMbUU2lY/HZUJVDJuKb
	KpursoC+gmSJZEem8rBeVZA0o2+eRIvczPRryjWPCLVUv3IRIf/daqRmdOSPfnZB097TSQSZ/Bq
	aAKmuBz51yx61Z7L9+G1PTJ3xbCeWmm7GNR0W2w==
X-Google-Smtp-Source: AGHT+IFaTwbAOGGQgTMTWh5C4q1xJ0CQP0io+qNF6sfe6mCxfRvM40+XEe7ALLxyceaH9yvTKgHEi63DC1Eqs61SBzk=
X-Received: by 2002:a05:6102:364f:b0:47a:2f1b:f54b with SMTP id
 s15-20020a056102364f00b0047a2f1bf54bmr1860316vsu.22.1714541118704; Tue, 30
 Apr 2024 22:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103103.806426847@linuxfoundation.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 10:55:06 +0530
Message-ID: <CA+G9fYtBaczXNRZuCRc=_qVs5Nd_Je6QP2uLi8p6Rw9hv2ue8A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
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

On Tue, 30 Apr 2024 at 16:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.9-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: f9518a4bb35acff7e26782f5951a06e7b8fd18ed
* git describe: v6.8.8-229-gf9518a4bb35a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.8=
-229-gf9518a4bb35a

## Test Regressions (compared to v6.8.7)

## Metric Regressions (compared to v6.8.7)

## Test Fixes (compared to v6.8.7)

## Metric Fixes (compared to v6.8.7)

## Test result summary
total: 262953, pass: 228626, fail: 3434, skip: 30557, xfail: 336

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
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
* kselftest-livepatch
* kselftest-membarrier
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
* ltp-cpu[
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

