Return-Path: <stable+bounces-37994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5389FB90
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA70A1C21BA4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5516F0C0;
	Wed, 10 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4HKHCtS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EC16E878
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762977; cv=none; b=dEdTCSiSmDCtaCm/GuB+GC4y4xn+Nbr3HRvDamxuaAEQpgS9cssPmzn3dywMcouCO8lfe2MuAnMmP/PWARBddA+NdolLHrXimnj3+dP3FzUaDuLg+OrPDRoogh8OfzSMJMz5LBc8wbaKi59JXaI4NyIztYTEq6VVt5PPKNEv/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762977; c=relaxed/simple;
	bh=Zv9FNZR+bIb/UqCTz1y4Pqc1wgk212CB0dJyjKzujCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjmLHQhjO69uF+dCXXC+zt/7wubF9U2a54fCNXcrkfcuXcgqDr0IOX6WGXaU3G97tcUuPuj9O478xKTIAb+PIxJW7KWvWMIXU5buz6EER/6yL6A8GO/VjVwI7lTAEyiczj8j7xFCXHDtdw4BvzddjZBippxZ7jMvcMc1MPhn108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4HKHCtS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479d6a85be8so1682238137.3
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712762974; x=1713367774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+HzWa398RYfG6hhKEMt1PRohWzxuVh//BbNzEQ8MPI=;
        b=P4HKHCtSGA6yzLksCt4fER5sFq4EmtyNzYgSIV9abnNr+c1GEfaKdC4qNa+iyDb0Q/
         A6IQUXa7EzP9Iw004EESiIDOc8FG56eJNPHePVVP9Juisow6v6VlGWwaeFqh5K2bAD/r
         GlvPGq6ie9lwdwR4jd28GYFvLxFKlRmX4r4fdUUjg6YoGeh7HEKvec6810OCd9+rKGNY
         hozPxWeuVqD9g9iC87BOVOgZxQf/cBUIzbGEZNlqAdPUTh3NkmQKHmIWkaXUJynuqsP1
         I7cugdvJdNYw70rs8bEBVzl6gq9PeThRsObaUlgFYg/F41Z5sIoa4OgpTyhdY1a40RBz
         +kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762974; x=1713367774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+HzWa398RYfG6hhKEMt1PRohWzxuVh//BbNzEQ8MPI=;
        b=aKL/AKp3luuFwNItbzbAXOf92/jQDBRpWBHsf41IEUCXOhic43nwkdJDBZFYJUXLYW
         0HTN9WPwA7F3CbcBu9S5a2pVNcRsV2wvtzlwJy8CBOeprhkJLLH4wAJzu9kJUXNKC2fI
         iABwk0jA4pEvq/hDGPeLWCW67QCiJ5NTTkJ5aYifA/+WypShDBZz0XtkubJmQwO+zRR5
         4vy37oGkp3wcBmdTlWUJd2CHW+6RrFBZnqEPj/3CtUmWYncuVVfyi8J24YVYkGquiCYS
         2Nxh4l9TXQcjfWpnuajvq6BT3iPWQlEZJfczAfXYl7TTlQH/1lhmxqDKKFswKc5tymGK
         BF/Q==
X-Gm-Message-State: AOJu0YzKD+Kyp0n9bgtLiLhbN6WXcrP2z32R3/r5Nw9jiupM8cdn6837
	0AlxNN+CJLUWmmggJQ/FmHVWqrqUVHXfh0UKhgzx3DmT+Fp0o+sLU0jGfosuu5YdOuTDgbhrNaP
	GgbfpqwQTvvlu1SYNg437G9scUr1xZc0+5Abefg==
X-Google-Smtp-Source: AGHT+IGXMKHhlaQ55/gMqwqi7OcIVD2Nh5ust1pQXvVbwHM8UAavjl35T9f1ieo3VMFl4c3cMhMpq+jSUBI/OofzVH8=
X-Received: by 2002:a05:6102:3752:b0:47a:2a5e:683b with SMTP id
 u18-20020a056102375200b0047a2a5e683bmr1590774vst.8.1712762974470; Wed, 10 Apr
 2024 08:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173524.517362803@linuxfoundation.org>
In-Reply-To: <20240409173524.517362803@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 20:59:23 +0530
Message-ID: <CA+G9fYu6j2J_yd1xaOhbAZCFkDt1HPiJdYTfNgeSWEGa2qmUEg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc3 review
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

On Tue, 9 Apr 2024 at 23:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.85-rc3.gz
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
* kernel: 6.1.85-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 9b31003bbfa73ce6dd6722b8b44180e2f2cb0745
* git describe: v6.1.84-139-g9b31003bbfa7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
4-139-g9b31003bbfa7

## Test Regressions (compared to v6.1.82-451-ga5b0d68e1b0f)

## Metric Regressions (compared to v6.1.82-451-ga5b0d68e1b0f)

## Test Fixes (compared to v6.1.82-451-ga5b0d68e1b0f)

## Metric Fixes (compared to v6.1.82-451-ga5b0d68e1b0f)

## Test result summary
total: 150133, pass: 127531, fail: 2598, skip: 19845, xfail: 159

## Build Summary
* arc: 5 total, 5 passed, 0 failed
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
* libgpiod
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

