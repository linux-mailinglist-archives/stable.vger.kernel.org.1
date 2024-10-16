Return-Path: <stable+bounces-86442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B79A03EA
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62958288FFB
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2518B473;
	Wed, 16 Oct 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxWtPzgC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47318C01B
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066534; cv=none; b=ecg4s5pt33VnyjpPLNNe3aF9m4b+JCB0FNWoqbw3GVODmu7KTlLLm7N1vVArR9mn47woA3dKg66vJCVajomUfCpBKr43ScBYFj3In4Aq/jeG2kAdqVY/ZJw1hyJNyRb4NjRCfItKZ1zq/1U5kDWijrJSS29NJ4HSDgTStQWXGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066534; c=relaxed/simple;
	bh=1IuA3bPqqaF9ChAHU+88Fb58RTiFz8iAP0BqIuxg7OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q81AwjlnBVtbkCsGVVStCODutet5MU0HvOZ0IlgE6KrP9qH5u6uDA9XgNBxENrhc2zFkY5NGZ2elRYQH/QeWIw0e6bstkvnjs45hu5Qb1KB4YzPbzgHBnlmRW0teih+Cz6YXEzZeDNKWbq5AQ3iEPidqrQGAIR4TTCky/dTKMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxWtPzgC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d3365c29cso365437e0c.0
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729066531; x=1729671331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcI16q3sDOqKZecGXpjAdaHkVmug7qW5nF3fWN5j7Sg=;
        b=gxWtPzgCcKNNoGeX+LsKsV1X3wHOCrPxLu0ZHy5U0esZm74fesCEwnQ5/2/MgTJJxb
         4C+uUimXuvZmdnhQWj3lXYMCt9DnHcQcMcI6pdQGRtmHjFRDoNvZ9WLI0ebX7xyfYa40
         6qvBbmVfp9ag7x0ggd2c6gjXA5QCKQkMRKXhmAvcYXolRTH4gMUoU64tN56sxnyjGnVd
         Q5qOrt9DdlPAlVzgdUdKd13h5wuh52bRjmLF3ySOsdzs2INIjrfGidOc94LKRPLGgPSv
         hA2oYRZ5ldJLg34eb8RV4NatqlWkMLQtr6j5qTNRfWon75LYhDS/yLUB806JlFRUrVKZ
         f98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066531; x=1729671331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcI16q3sDOqKZecGXpjAdaHkVmug7qW5nF3fWN5j7Sg=;
        b=u/Tr4Am+wDYtFRTcSILywC9oHeoGJnuql1GAJla+FdcTpbnrNiz07p1dO6T83DdJT2
         DskxynhMakrKoAnuUBhekOH9s61uQhiwE86e23Q7rBM2MM6tVmFelAqsb72Gna9JO7wa
         GJIrvb6qIs+s2WvzR9EoORrYkA5O/bUTJ5UJ2IJvMjb43fbrVH7uCm+XFwbE+1HQ60LR
         7dd2kTVWIljVPBtuIDiJC8ct/fR0pfn7UlSjt3PVwuWto3HfpmzspZQxpSqnNlIAdjbY
         smBAXxdjrBa+X0yGzCBLVueTshE7gWNih4oKsVDxmWoURAPT70sE6Kf7AmuBGd+DUpZr
         0w8Q==
X-Gm-Message-State: AOJu0YxHrJBlXo0fIuzP40BaCLBOHWdzkjR0VcD1U2dl+XWtt+Uj8gXq
	F6C67FRI46xzmjtyDVXKLuIOhXCGskXD7qpv1rkg6ji4S/t5LfCGW9tdkumFkuGOQLnK9xjmKYm
	JoU/kBmHBoyAsbc1b33zcJjZq0chxinIWSEolrA==
X-Google-Smtp-Source: AGHT+IHxOwITgnRBE6TVGRHtx87wi7sbYnfJoxuv+8L8wixdpSdQXnE1+VUBsdANoINyaftmyTfT0tGd6kA6S8OH86w=
X-Received: by 2002:a05:6122:10f9:b0:50d:4bd2:bc9b with SMTP id
 71dfb90a1353d-50d8cbc570dmr2383374e0c.0.1729066531501; Wed, 16 Oct 2024
 01:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112501.498328041@linuxfoundation.org>
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 13:45:20 +0530
Message-ID: <CA+G9fYtqUBXiXPm1kzEabqSzQy41Bh-OieCgnvNi5jVnHh4dpQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
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

On Tue, 15 Oct 2024 at 16:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.113-rc2.gz
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
* kernel: 6.1.113-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7e3aa874350e5222a88aac9d02d8bc5a8ff44f80
* git describe: v6.1.112-792-g7e3aa874350e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
12-792-g7e3aa874350e

## Test Regressions (compared to v6.1.110-137-g4f910bc2b928)

## Metric Regressions (compared to v6.1.110-137-g4f910bc2b928)

## Test Fixes (compared to v6.1.110-137-g4f910bc2b928)

## Metric Fixes (compared to v6.1.110-137-g4f910bc2b928)

## Test result summary
total: 205815, pass: 164289, fail: 3758, skip: 37525, xfail: 243

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 270 total, 270 passed, 0 failed
* arm64: 82 total, 82 passed, 0 failed
* i386: 56 total, 52 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 72 total, 68 passed, 4 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 66 total, 66 passed, 0 failed

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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

