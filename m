Return-Path: <stable+bounces-18785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9AE848F81
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577B0282E17
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B3225D5;
	Sun,  4 Feb 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBjYLYfT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B324219
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066201; cv=none; b=cIRV0ujIwv5qhYKEz/rd0l/t09490i2EKyxRNUHBwHJjEioeW2xKVVO5ZQc/XkIVAu40OJsSdKpcx7L6GohxlB/H01H2ERzeMrPRzoSaOyouiTmNPIRld4IwT7ITL4RIdKB2cE7+z8m6XXygKoZzBtmqDVRRIde02FzWLRfsbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066201; c=relaxed/simple;
	bh=24sCwJLJUAwGwA9wjlLnpsqLaUYZam9pqmP0t3d5K50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFh+e9xVDSZsbCcL8Pszh9pM2pHaeMmUZBHxl10Qgrf0RJUit0ALfl0px60L7Bu9VtgOKDKn6MCUFNw519ZAQbc9HaLDdqHFyTs9YZVIVo3Y2RpHFpsJ7wmQs8s+o7cRnlo8qW3oB7LSwm5nF26cY0k5ZAAwt4cd2boSSg4Oik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBjYLYfT; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204235d0913so2209708fac.1
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707066199; x=1707670999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDn4K/wW/c8fSGRp7Mb5kBC0d+BPRzZbIs44N4i9Z/A=;
        b=XBjYLYfTLnQEs5D66aLFTRsSqkMGrhl1Yx9qgWWjPkaZzT4kZ12pynAuN397vGeZBy
         O4ffa1lSly6kwqkSUsYG8vyEnysmHwEYKD/imo/K3E/bRB9p0f+CVYm/AEL8Bq6R588j
         iH+OoC7gFoUpA6ux6SjdzEMtgPfG96v62zO2dXUKCtK+jB6WUsdMJahrj+nnXPkr4NoG
         gA10ij+Cqije/j3r5HF0DE/VYYL5eNzz9kQAK8OdM//FXjMzHiendW00JIfGkOZPZjVq
         M1kU9UbCsbicbj4zJK8dX8LCIeGnyNkkxiTEvMrqCfx1oGQor9kw0sztGbV/DfAYuGu+
         o4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707066199; x=1707670999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDn4K/wW/c8fSGRp7Mb5kBC0d+BPRzZbIs44N4i9Z/A=;
        b=X4fiPYvzGMmet3jP7SRmADNlfZhpzMbk4UQlQ6HPIjYoNlidAy3hZ1inYzSFnUeMva
         g2DidgIwBu82fv9jJ6AZykHGJV8432W+VU/spCZ+TjVE5xEax+5CaZUFa5mk/vBfXioi
         op+IuXW1n2klGzM1swxTmepEes+EXYN6G0VdjbFYCIGRuDm3gz3aRVqHElbSi5ejMEQm
         ERvvbvZGMJKDSPfbMusHbjMxKe+10GaZ8dlEotwK7T07xneohkLuNHmr3pFB4TiKQYIE
         3C3iIO1e08t6QFcSXlRneFAj/3Efp2zrGKLRID7ndWNIDtKzEB5Bz/6AJqO0wtCERaki
         rn7A==
X-Gm-Message-State: AOJu0YzpMNdcJgJbIfC1nMBOeotjj+emY2H29wsyG792EuQj93U31bXv
	dZjk7Jt6ojIn+3AdXRw/+AmFVmVBDzkJpV7jm7ZtIwrtImp+Wo8OTwwoc5pEmC57FcwPrVmj7kJ
	rJVi1LoyN4w3EceGqR/U+KC/lRKNCQ+dlqTvofQ==
X-Google-Smtp-Source: AGHT+IH5dfsWMya9IXb4QHHcqRcY5AtT4iAzFUMV7/nyEsn21i9BjqkWD0Tvm4CiLLjIlPqN3TV+fNogSdRJjIoY72s=
X-Received: by 2002:a05:6871:825:b0:219:2209:6448 with SMTP id
 q37-20020a056871082500b0021922096448mr6516612oap.25.1707066199107; Sun, 04
 Feb 2024 09:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174756.358721205@linuxfoundation.org>
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 4 Feb 2024 22:33:08 +0530
Message-ID: <CA+G9fYuCTuXYtL7wXpdFsYWD9+-pjhio3ATCFb8hA8UTa8Ki+g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Feb 2024 at 23:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.77-rc2.gz
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

NOTE:
----
Following Powerpc defconfig clang nightly build errors noticed linux-6.7.y,
linux-6.6.y, linux-6.1.y and Linux next-20240201 tag.

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[5]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Err=
or 1

We may have to wait for the following clang fix patch to get accepted
into mainline
 - https://lore.kernel.org/llvm/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-=
f24140e81376@kernel.org/

## Build
* kernel: 6.1.77-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: eccceff25f8274da6f7e7eb3d97bb4d41ddc80ac
* git describe: v6.1.76-222-geccceff25f82
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
6-222-geccceff25f82

## Test Regressions (compared to v6.1.76)

## Metric Regressions (compared to v6.1.76)

## Test Fixes (compared to v6.1.76)

## Metric Fixes (compared to v6.1.76)


## Test result summary
total: 136302, pass: 115762, fail: 2793, skip: 17592, xfail: 155

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 150 total, 150 passed, 0 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

