Return-Path: <stable+bounces-54754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC2910C44
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A03281BBD
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD20F1B47B4;
	Thu, 20 Jun 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVy4dqoG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2F1B47C0
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900635; cv=none; b=q1o5Y2wHTowXmGxuwA1BSthFuFBKaijf1j8/ly8MH7/mcYuoMUPuUhxmAMoHeiADEC5SEcLNYXP7ikIxKJ4mNnGFeaiGquZTaHLYDK4X/H2oNQcgohIte37Y1OHHfCkRQCpMzMPKo3/sRDvhN8TrST+j+dcKuePVDdDhAWLbuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900635; c=relaxed/simple;
	bh=Fx1smBOU7+g5gN1krwDVwIdwdPcrGDOEe1sKrAvkiEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEuA1MagxZf595x3nt28ykt0ZIIDiC6LZBtKEw6sg0M3p4FvxBGnq9EBnzhQoGqRYraGcOGRtMUJZ6UJgW2LHv3Jm4Iiym9d2drbsh5AYh446ziY+lbk6dbeKgzTR8tqgGIlfnWY+ZsGlDoWYr37K7sTdw1pvjrM9VTtJiJB/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVy4dqoG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1348179a12.0
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718900632; x=1719505432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlwMIJz/BLrmB2WpkXjrpRTAkcL0lyiD4VvvoeLE5V4=;
        b=jVy4dqoGz5c2AQMRQ+EDk9ZP0lHrRSM7yVcgWsB6xM+nc23/sUwWcuggrsHsQRCSQX
         FvItdD9fuwFrx0ptO3i+X9cgqIWpkkkRQUC3GU9jn3g3mOk+2gnEe9Jin6i+ZBMYweev
         pxnDTfm4sp7MZg1ghc9OAx/LjfA4bXM4eiqGLysINJXlO0gn2s/9m7ihKKC70Iwzjmb3
         1iFsq/Fsyd7xA9yB7m8hWuXhHk1wZ+lIjPU9WrUSHokTwXKixkfsEirPJloCfqydzgbd
         fwVkfKUMfY2tmjDWrddKQYyTC/7gnutHNEGTsZ5+xhfy9pls2+O8yUqol0MvcJC3WI/0
         BFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900632; x=1719505432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlwMIJz/BLrmB2WpkXjrpRTAkcL0lyiD4VvvoeLE5V4=;
        b=fdrU9KlvqZBgnyp4RFO9yBDoyFFAE+5NQRvzz+uogGFVpbjzHTmUuXiIeHTt+FvDi6
         7RdjN0cBXxZHMtIUzPDt6vSvb7z3Gebv+LoOTyi4IFsQk24RyQhrKHQRoMiRKkmTT2R9
         koUC7QXB3/3v/hiFJAfNtP5fTwenXqotG5nkbvDVPfOAwKwqm4mwFfw9/9hlS+U4NaRw
         Ad05b1pJy0X0ZW6ubkYRhx2gq+sweEI8rij/LpegmDsiV77rgaTWBR12Pkt7KzLbQ8eu
         0Z65wiEzptptisjpSHpH5fhf6uDjv+Qsbh09Mo7LoHMv2E/ifg3DzSEci9I+cdJu2Xyc
         nS7A==
X-Gm-Message-State: AOJu0YyLk+2QXOAuhamsuzHECIwkLdV4ETIn4ZC+0/LRNsepMAnMUDSF
	C3RskP9wuFkzxH4cGtbKAx6IP1w4BQSJXq+usL2lE/nw2ykCqO84Sg8xBTkBtNkYacHoUOuGj+j
	fVpDITksWCFk9gHfN575EbkBE8zxAKSSJVnZzWw==
X-Google-Smtp-Source: AGHT+IEiUurqA8/vupAfbQYgfZXpGG83X+0xfR1yK7bM0GHwHo0LQaZYIH41GdenK+O+unfb1dHXnKUo8wy8Glq5Rs0=
X-Received: by 2002:a50:99c2:0:b0:57c:ff94:c817 with SMTP id
 4fb4d7f45d1cf-57d07e7b28bmr4498282a12.16.1718900631856; Thu, 20 Jun 2024
 09:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125556.491243678@linuxfoundation.org>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 21:53:39 +0530
Message-ID: <CA+G9fYsnxHwaPb2YvcLJXrgPRkqJbm7w=cF6b-Ap1mQ7jHHMsA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
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

On Wed, 19 Jun 2024 at 18:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.95-rc1.gz
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
* kernel: 6.1.95-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 0891d95b9db39ae51c0edef73f56d41521be9fbd
* git describe: v6.1.94-218-g0891d95b9db3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
4-218-g0891d95b9db3

## Test Regressions (compared to v6.1.94)

## Metric Regressions (compared to v6.1.94)

## Test Fixes (compared to v6.1.94)

## Metric Fixes (compared to v6.1.94)

## Test result summary
total: 171975, pass: 145682, fail: 3002, skip: 23038, xfail: 253

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 33 passed, 0 failed
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
* kvm-unit-tests
* libgpiod
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

