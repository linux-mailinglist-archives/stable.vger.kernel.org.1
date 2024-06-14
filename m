Return-Path: <stable+bounces-52158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E490868D
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177981C251A9
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C218508D;
	Fri, 14 Jun 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnlZGvOs"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE61185099
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354381; cv=none; b=GFYuk6Qcd7TQoLNXXqVuyV3XotWuwDQhU1hfFHFqssMk81Mw1LTtlwGQnTlHXnViNzudkvceHGA060+X79up1TnNBskg+A00r09wcE0N3epmd+Ys4yuAwVCAwPyD/hJkhEHcwsw3Q10fXtk4bw8fmUgdGeQgGdW5kDp7AeAHw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354381; c=relaxed/simple;
	bh=noR/1BMvTzVYSrf8tR5fjTYvMtZKm759/PkznKK2bXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPtgfs+DHMwhh3iHQxN4scIi0IvCOIFqx4FquwVIzSuywYGQi6FzLDffJXI1xvMknnkRVGJUDevORBgBHnn2k/jKRryWVzkAQLAN4WmvYN4oZ6MrFUxiKorelq6YS5Ho4brzm0NHyc/tPJvEr/aP3dLwg3PF1TO0F/XplUcoIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DnlZGvOs; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso517821e0c.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718354379; x=1718959179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir/QAoQHBoCJHNX1sblS+j1ISo+HGKmrWSlo79nu2gU=;
        b=DnlZGvOsx7rBqTi4zHEmRN+9DUmzC6LMJ8rbgfXTsg03zGws8rLCusosPpa2CFJub9
         Cz2OMJnzvGIND+eaM4AHZ3FtrVQGxtvtp13gNnoHFdkmAMgWDdEjOqBdiYLD4XjPyWlu
         znPVDpuTcr6rxKzIZUqt5Li2FF3nJuVzVKshz5oW8O84/EIv47EFbZYzHlVbh62wo6BZ
         99iSIZ5qEDo0DdgCgvmQH3dJBMSRpjYaajtuoRWqS9NV9HZkbShxy1f6yhcM7J4LdNuP
         nEenamRJOC1b6iRw19kP0GctFDIgSj/vSNfjHGxaR34SRXMXMxjwlkAdlCpnyfnm1Uqh
         w35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354379; x=1718959179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir/QAoQHBoCJHNX1sblS+j1ISo+HGKmrWSlo79nu2gU=;
        b=BdLJXWCrnCWQwZ5y241t2cRQIS6dM1OAJ5H5jUV9XB6xNoMNF+cn/35c8Vcs8YpgoM
         Yx9FzoZSx6zfqlD00IM/cFEK/JkL0gfaeQx4e421oTj1p4mOG669Er7wENn+CbFOKdaM
         Jugz0iSXqvenOXIzrDhPtrkPDm02H3onTx/2bxUXs/TMb4he38MdTcEbxKVQl2rd+IXr
         LPb2taKqM92W04iLBClWcPjwCKJKSu9zap+hXxhXSbx7Ro40LmHSa8rBOm7lF61wY8Lg
         tMtQ1n4t2xhgy3Hy1MXwmhQhQkAV4np7Akm1Senxen07ldLafXkTXxSB7Rk1fmXPqY1/
         BmpA==
X-Gm-Message-State: AOJu0Yx4d6Xw4Z40mo/EgvRJ5Xx4Yz1W9UjjczmfR+Y9JoPgMbH+MwwM
	ELY8xkYSSI8zfbZFkijI0aWQ+o3OZ7O6ap5oMWU1z5cNxTDuysaf/8ZJHYQX4qB+joyj/4iouie
	CP4fc9dKS04Gvyh79KWjS6VgnPdhq9MGOg0n22w==
X-Google-Smtp-Source: AGHT+IGTQBRS9QzBmr/YyWpjkaZksUQtyI4an2FgWafCDTm+liAlDrd5evYeKtmqo3IMmj2HEknh124/H8HUrJMmL7w=
X-Received: by 2002:a05:6122:30aa:b0:4ec:f773:209c with SMTP id
 71dfb90a1353d-4ee3fe42550mr2397495e0c.14.1718354378898; Fri, 14 Jun 2024
 01:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Jun 2024 14:09:27 +0530
Message-ID: <CA+G9fYtj6+LNNfg=ds7_b5KLP2kKSqXwPOYc2bV1uL-ZGHtJdA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
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

On Thu, 13 Jun 2024 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Build regressions on powerpc reported.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.34-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 8429fc3308da68760efb0f6acfb80b41eb2f7532
* git describe: v6.6.32-876-g8429fc3308da
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
2-876-g8429fc3308da

## Test Regressions (compared to v6.6.32-742-g7fa271200aef)
* powerpc, build
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig


## Metric Regressions (compared to v6.6.32-742-g7fa271200aef)

## Test Fixes (compared to v6.6.32-742-g7fa271200aef)

## Metric Fixes (compared to v6.6.32-742-g7fa271200aef)

## Test result summary
total: 129650, pass: 112601, fail: 1079, skip: 15843, xfail: 127

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 30 passed, 4 failed
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

