Return-Path: <stable+bounces-59021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571092D3E7
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82426B22040
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A535193445;
	Wed, 10 Jul 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMEpsJTs"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EA193450
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620702; cv=none; b=ki3sbQl/CoIz4vYYZJRzyn7ehaG2gGHYgDVofkJxbNOeoIz6XgyxW2wL6SVzKHCWJIqMcS5nb/6+efQVa+xsU4AxRoFLI99xoYy5wkjcGaD/b7xdyhc2aQcHLHjc7FjJobdnRa+2AVu56TP7Hr4ArPVVKoUacv1XsHHcl34VBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620702; c=relaxed/simple;
	bh=M3NTlKufyjn+J1Tx+IElh5yRPH9Gd298RvqHaxfBu5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jei1Cs4yFfGixhlxyvrQQqwczS/8uQcNKbYB8TswCaFYj5+qcsN4LPRskp2f4NjSijlreZuNRqa/bUpo/og75p/5oqFiS1E2at7OxzGGOq4IEqHlaeDcCV1Z7xBPATp+Tu5ZghNVKg+3yhGQmqbduQ2BmYHufvsArIKDQF7iD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LMEpsJTs; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9400a1ad9so943519b6e.1
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720620699; x=1721225499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBHCfF+fRoODKJrxxIob/lIHbfhaheSYHsBiC/FGg6I=;
        b=LMEpsJTsmyOnMM7XtgCz2vMnGb2EJl8UHKaBvcHxZAEmF320y/DjeJLni8kNYT3mq6
         iJ4Wk2vGYeHQPTAnCOVinm+A1YwpzbnLzfVARkmto/KlLlx5ZvwNkqswMtu4NXr1tFim
         vAFqfbqh/sk7XYrtn0Z/pAYJPHGalannw0mrTasTd60N84vBLDIjoKOrjs7CQ2yAZG+n
         F/gaGGC0RLlVyCMTBiyUt8UsFsytkCidDbdA2fIjt6Jb36i9Ph+vAgeF3mCZFuD/EaZe
         aCu3mudMw8vp1S2833+FNC7UZLCN1weC5OgpUF3Gh8c9uV1F1d44FXzzScng9NyEBO25
         D+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720620699; x=1721225499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBHCfF+fRoODKJrxxIob/lIHbfhaheSYHsBiC/FGg6I=;
        b=JuXOdSC+JB7byPqAfNo85NuV0VELgDKGGodSR0PqQJJwqXXkLXTlHSkIUtDMB/3+AD
         dZbAGVj0IJ1AuJunNvAY6kTBmnUPvL/kVEHRQMqcb0U7y/QJL9ubKdn8NxVEuOTGbnq7
         QPjaXI1+pxJDOg6DCobKsXJuptthsKXwVL8pxqnaJCpPf8PhMlP7a2BuSu1DIIbt89Ua
         AWOlYt0Wq0MYc0v+wQGLMNYqDSHObA7j4P2e/o1dY/CQ61Gn+HJxF2hQccyrw+ohY+e8
         H49iNEyyHl+4yHDfQhEnp13W+IMRhzyW1suMazcSoLwzKbGPHpzziAM695ri/d6NC8Lq
         sluw==
X-Gm-Message-State: AOJu0YzwJWoXH3Xi7F+8q5anBVZyN8Cfot3oYosZVDbsE1LG9bbdVDU0
	0mGB0jBK/XN+ePS4c4vEHaPo66mbk7pUvi1QuetJOcXzqjfdQE3cjucgBQ22D8V0jYZSxnWL8z5
	KuWg+LvzY2ujpGGYEX6aoP7yDHkE62rUJEuYl9g==
X-Google-Smtp-Source: AGHT+IGGO+ZLAwaPKfnWP2SYubTBuh3R69ACSSxI1COqxyNqeSYnfTw1TktmrY/JAg7lP1gVC2AllArgIH2awn8ysXs=
X-Received: by 2002:a05:6808:1306:b0:3d6:9c05:1aff with SMTP id
 5614622812f47-3d93beda13dmr7079147b6e.10.1720620699166; Wed, 10 Jul 2024
 07:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Jul 2024 19:41:27 +0530
Message-ID: <CA+G9fYvTZvjcWL1KgQcQKX1-qn-YANGnAmy3mcvgtjAK-t71hQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
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

On Tue, 9 Jul 2024 at 16:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

[Please ignore older version report email]
[Here is the latest one]

Results from Linaro=E2=80=99s test farm.
We have two major regressions.

1)
As I have reported on 6.9.9-rc1 the same kernel panic was noticed while
running kunit tests [1] seen on 6.6.39-rc1.

  BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq+0xa4/0x158

 [1] https://lore.kernel.org/stable/CA+G9fYsqkB4=3DpVZyELyj3YqUc9jXFfgNULsP=
k9t8q-+P1w_G6A@mail.gmail.com/

2)
s390 build regressions [2]:
--------
arch/s390/include/asm/processor.h:311:11: error: expected ';' at end
of declaration
  311 |         psw_t psw __uninitialized;
      |                  ^
      |                  ;

 [2] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j0Y8vJ0DjSyCxU=
Fw4CFk1yTq9S/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.39-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3be0ca2a17a0142c600526e9ec5676d797ad213e
* git describe: v6.6.38-140-g3be0ca2a17a0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
8-140-g3be0ca2a17a0

## Test Regressions (compared to v6.6.35-193-g580e509ea134)

* qemu-armv5, boot
  - clang-18-multi_v5_defconfig-kunit
  - clang-nightly-multi_v5_defconfig-kunit
  - gcc-13-multi_v5_defconfig-kunit

* qemu-i386, boot
  - gcc-13-lkftconfig-kunit

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


## Metric Regressions (compared to v6.6.35-193-g580e509ea134)

## Test Fixes (compared to v6.6.35-193-g580e509ea134)

## Metric Fixes (compared to v6.6.35-193-g580e509ea134)

## Test result summary
total: 249497, pass: 213701, fail: 5004, skip: 30287, xfail: 505

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 0 passed, 12 failed

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

