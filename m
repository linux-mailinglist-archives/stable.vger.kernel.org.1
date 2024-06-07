Return-Path: <stable+bounces-49966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193690022A
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28F21F26629
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A27190661;
	Fri,  7 Jun 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqD9Njro"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E8188CA3
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759836; cv=none; b=IfsFb7GA9qHWcT4X1x5Mf7itUnhhPdFAX9zfV7+gkWKXjplX5IRfoGgWhavFv+fysdGuiPgR0Fzl11jRgziwAPYDofpIRdvmoJDjuHlKnlnTKyjKagTay38rdy6PRAnZ5x9V+KvVYdAtIbKW6iXuZSrI1glr+WO/94zQEJQfK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759836; c=relaxed/simple;
	bh=StGaEF7Uc4UFGk10SNqRzEBaNDnxrd8+sdjkMk1BlgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIN60H1yu0Ls0svMSjnW6K27aEei9htqTxEeCQEEhcmocERsQTynWk81tDq57n7uWEGB0bKt9Zn6nKaPYm+1kMrIDBCD1eth9WvaQy71q01LP37skJahJ67NlhJHpJ4xGpORX+RKXA4UxKxLHAjADJDNhAmrXyvDAKWqjrO4Krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqD9Njro; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80accea5cc8so583586241.3
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717759833; x=1718364633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2xzYY0svUoPJkXHA3ANkFOIm7crXu/iU7zTBAmDKAE=;
        b=qqD9Njro0AA0rQOv3GzSTjw1IQsFcit8Cvy7wJ0CzfZ6peO5+O0Uk8BgKJlCvxnoE4
         m8zbcyGJJGnqmeJB7cRJNvDdthHVR1wqzb+I9CYKk4W3uHP4N/uH7d8DirAIJEfTVQT+
         8yAd5CR3oob6aoWnQiBB3ps8Q75Rpd9BL9XtBGl5v/NcATtm6NMG68kk3lQVpEw0USeG
         Cc2VE4jSEKol7l1BDyjOJvfwe6XXdCx9nQSclMmNSGd4+xZn4zB2/ROGBX2g6hB7gtqC
         JLMp7Mm5kbG4DFo6oD2wrTAEEXB/skS8cWqxd/EslTF3QqA5j3hajlQ+lJqIIbiYW6mv
         0kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759833; x=1718364633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2xzYY0svUoPJkXHA3ANkFOIm7crXu/iU7zTBAmDKAE=;
        b=piNxNW7FhLsZ+7g2BVqhaBUTA/BOZD7lJ0GeDah9I9YDsnC1vFvXTGz/7k6dr9MDEn
         rXJNwbSbGTJ4WHfGFiZZQLpuu3ViSx2kjrkPYuXhC8DPFQT8Ndn67NmqP89XirX16dwz
         AEGCHEHZB2T83h3YLHB4+5mvtT57hUQ65Wh2n9pahZUOs9Q4F8Bl040tZW3k72U1xRhW
         RYbWc2gyhIXnvmlyHfC0aoSwHvHhlz4MPyVAVz1VXSRDoECejql01XHElFu6tLOwfub/
         7+CCuvuPZEoGqiVmkSLZT7aNfD7Gsf/8t0gxqLqJdegahB/aiX1OoOPQh5dMcFTL+PF7
         a1SA==
X-Gm-Message-State: AOJu0YzIoP6yHQzLATgZ9lGc1hYQtH0S040RESi6vu/XxapWOUKG9Y23
	IzUehcbHZmm1Fs3z1OVuFFmoEEle5e5DIpjd1a+klTbejHDqPwqL/T67M/TqPobapCGO4ZGAuJn
	vr/BI15NIyQvnrIkBiQEv3CPoupY56QgblDDN/w==
X-Google-Smtp-Source: AGHT+IGJ5cRdJaVJGpRXtDfA4+hmK7e78lIlYOpxeNoT6q5c/FGNN2WFodJfhF74Z8wqG4iqthsoDesIUVns4SN4bKQ=
X-Received: by 2002:a05:6102:190b:b0:48b:b9d4:2420 with SMTP id
 ada2fe7eead31-48c2759b7f0mr1971951137.8.1717759832991; Fri, 07 Jun 2024
 04:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131659.786180261@linuxfoundation.org>
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Jun 2024 17:00:21 +0530
Message-ID: <CA+G9fYuWn7Pn6rQR5EsQf9hPuTB8i6VmBSoYqEbZLLXJjjDUhA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
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

On Thu, 6 Jun 2024 at 19:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.93-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Build regressions on Powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.93-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d2106b62e22625dd85dc50e14677b07b849a13d8
* git describe: v6.1.92-474-gd2106b62e226
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
2-474-gd2106b62e226

## Test Regressions (compared to v6.1.92)
* powerpc, build
  - clang-18-cell_defconfig
  - clang-18-defconfig
  - clang-18-maple_defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-defconfig
  - clang-nightly-maple_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-defconfig
  - gcc-13-maple_defconfig
  - gcc-13-ppc64e_defconfig

## Metric Regressions (compared to v6.1.92)

## Test Fixes (compared to v6.1.92)

## Metric Fixes (compared to v6.1.92)

## Test result summary
total: 148502, pass: 115326, fail: 15709, skip: 16872, xfail: 595

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 22 passed, 12 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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

