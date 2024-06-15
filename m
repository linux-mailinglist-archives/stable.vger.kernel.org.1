Return-Path: <stable+bounces-52263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851F8909676
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D383AB21267
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F817BB6;
	Sat, 15 Jun 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdTmdUfU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D317BA9
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435190; cv=none; b=Yqs0WnYwHRYW/99XdbfCBKG5+CAaJjMp3IHz8tKzesxObZ4Udm+2jfjCeTQLRnECEoNoxtYe3njQcKg2mF3+NP6bBtkYOXjRF99HoYD9MMbtMC/OP30fWdL9+Q/1Jq4jHezduTAD6r92958T4RfkUV4CyzaWacQzIuCvzmjJzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435190; c=relaxed/simple;
	bh=D/n8NdTYy/LtcBts6BZWE9HrFn7Kex349SmugLLwTDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuVfT3NSOopzH5R9Jg2giYwOMJvY+lw3VhE0knT3QxkoUQ77FkwErQpcDUXPlW3QkFcwnWSYfhuWvF6t9IAYUZe5bGZ+u8vOAA4kIa9iwPHlWO8yflSA0rC1+/pFDBsXVWxFA4y1LDNpPH2SSMQcc1f/gG3QpkjasGCG43s8hoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YdTmdUfU; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80b821f3dd6so723566241.2
        for <stable@vger.kernel.org>; Sat, 15 Jun 2024 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718435188; x=1719039988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTIboxkmSqNDNHQ9BibBHTyoSa0gVfS8NZcrGuuyLT8=;
        b=YdTmdUfUI7d4BaWeWUQ+sfLvoVAwoVzw4c9GIThZ/a5HSczHaznLLyf2hEKlMW0vaO
         znejzj5i+40gTkxWSnw52UPG0zGTNIR7zJO3lOAtGag+M/YKLtLO6A26fpwngEE7ovYB
         Z94voMk9o+0qQM3XG18obW+bnBaN6SiWwLVn6RIt8ivE8Ou2wwWDW7TeD6vw06QRbbds
         M+6Rp+FvM5JUKTuJxwJmVNkdNfhQRKp/n9PrzF8rcns5vOIm7WvC+mRhvtlnSKrjvqvM
         Uq73ZOIwGQSL/ZSmjvvAL2KyouBksHOnzz9veyC5R1NgX/+QmnwiypHm5oQJrpT7c3i6
         FMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718435188; x=1719039988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTIboxkmSqNDNHQ9BibBHTyoSa0gVfS8NZcrGuuyLT8=;
        b=Q7DKbcTGkgm0pKx5oPHbGYSRvgcnFFAku+njez8RIxYUFOKkvutNzwqa0pD1QdcZNr
         n4brAx6ztBLZntRn7AO96Qdh4eQ6rnRZca4lGpUFfcBrgjowVu2LWUuixXbcSAnOoYRD
         DXvF0/HGRcEHhgcZhL5SbLfjEdceG7XnWvxxtfsGPzdImdJxbMLCfk1YhvlpNpekbgvB
         FPhr48fpAsPLt+UThKmStc337lYyeSNUA3GrzfqzOoltdnY21a9wu9u+E4ApCvEqR4PP
         ET5u9tT26+aLMyjIRZG38xZNsZeFp+EaVgaJNC7tmBcJZiAGOcijdOrX/aTORCUGYP3k
         O/uA==
X-Gm-Message-State: AOJu0YxblT4Gt6jigxPQqp6ct6b0W8ukK89+TbQdI9DH7HT2kcrH+Kib
	7yjnJruVDSOaffzR1BuaZpAuli/7HoHDYyB3T9QL2GeCXnD9vwE0+Dr08uhnAbrbvhX3dP5OvGb
	38MxBZd09CmB8881J8Hwba2mIiRQEb9NPAUmU9aaQvKnwrdPVrdk=
X-Google-Smtp-Source: AGHT+IHeRnOR5MHTUJT70ETG+DjnILBLUrZTj7u+VAbqxt2l3kMOz3CUqJfQE3gpBQBZcu0nN/Ah0LaOxGCrycuemyE=
X-Received: by 2002:a05:6102:24a7:b0:48d:89e2:8ff6 with SMTP id
 ada2fe7eead31-48dae3b40b9mr4334638137.23.1718435187970; Sat, 15 Jun 2024
 00:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113247.525431100@linuxfoundation.org>
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Jun 2024 12:36:16 +0530
Message-ID: <CA+G9fYvLoT=WGZvUjp=oHG=g=o0LG-JaYC+ku+m-e4BH9epxyA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
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

On Thu, 13 Jun 2024 at 17:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.219-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on Powerpc and riscv build failures.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
----
Following new build warnings noticed with gcc-12.

net/nfc/nci/core.c: In function 'nci_valid_size':
net/nfc/nci/core.c:1458:9: warning: ISO C90 forbids mixed declarations
and code [-Wdeclaration-after-statement]
 1458 |         unsigned int hdr_size =3D NCI_CTRL_HDR_SIZE;
      |         ^~~~~~~~

## Build
* kernel: 5.10.219-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 853b71b570fb6a0cfe358e0be3b638c65c9065ea
* git describe: v5.10.218-318-g853b71b570fb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.218-318-g853b71b570fb

## Test Regressions (compared to v5.10.218)

* powerpc, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-mpc83xx_defconfig
  - clang-18-tinyconfig
  - clang-18-tqm8xx_defconfig
  - gcc-12-allnoconfig
  - gcc-12-cell_defconfig
  - gcc-12-defconfig
  - gcc-12-maple_defconfig
  - gcc-12-mpc83xx_defconfig
  - gcc-12-ppc64e_defconfig
  - gcc-12-ppc6xx_defconfig
  - gcc-12-tinyconfig
  - gcc-12-tqm8xx_defconfig

riscv:

  * build/clang-18-defconfig

## Metric Regressions (compared to v5.10.218)

## Test Fixes (compared to v5.10.218)

## Metric Fixes (compared to v5.10.218)

## Test result summary
total: 86688, pass: 68564, fail: 2978, skip: 15098, xfail: 48

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 9 passed, 14 failed
* riscv: 9 total, 8 passed, 1 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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

