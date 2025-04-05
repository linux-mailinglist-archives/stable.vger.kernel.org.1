Return-Path: <stable+bounces-128367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04773A7C7DE
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742B0189D089
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711421C5D55;
	Sat,  5 Apr 2025 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi9EkIXW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149222097
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743834568; cv=none; b=AUu9XrK6n2sapSuJT/IamnEVXOJL3bCEUIJrQGKB3FxzyzvcOY1qf9D8ZwH6FkVNDLUo1bBKpXPbX7srEU55+GwILYlpCMlBXrKvA0CcipB/WzsPP3zBXENCdro25L9FwWo8i9LmCekatiqhJF3YsbLtDUwZ/QElVMHANLVaL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743834568; c=relaxed/simple;
	bh=9vqzDp7O4j3L84uAFcZIhXsaZQIhBtiKkwykBM4JOPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/N0dVF+OeFNoP8MFhkxSh7wK08kzW04ZXRco1WWR9jfD+QOgdUHTiIpDFchSrQv7NRtSEUa8wbab8pjQ9EYyYjsqrbSzbTLl103pDjk1YSH/0kX55f+6F5ZXjB5OxYitYmKPxogpNSM5hZPfKd6tC+4z1uYLofJlmi6BD8UYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gi9EkIXW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso173071241.3
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743834565; x=1744439365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Utl2AdZNCkcBOhv0fIljE/ZFO1pXanNvtL1Clfabdg=;
        b=gi9EkIXW0vuxK/3N3QduQMHU3pNcc4ZH5GDezTnCNaGCAVRmclu9GM8vxRic1C+0ji
         wCNMRZGsKNHH7JQOglmYFd9SgRqwm9bZVIhLAF99zNUcdDgymmBd9KedUFrc87K1icuX
         AG6qLQgKuBiTzdWm00PFqrDeKjJ40Dg8QkrP4LcOyBhEdL5/atWge9/HjziiaP6K8pix
         IwSTteAVrRUHLOQRnT/gpd9gEWEFLsF3CSMQIh8REOYdP1aXBcd/ylkSWBqoIuqay436
         gE43cTVCIAfPgI9CWFuRTqa9aIw+13VhW25A7viJ/e1tMk+pZo9oap2cAf+T93FDz2ob
         IM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743834565; x=1744439365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Utl2AdZNCkcBOhv0fIljE/ZFO1pXanNvtL1Clfabdg=;
        b=Yk9fE3kleGiCRBpbJusFmPhqCZeP2Wyc/qmLg6Y/HEyNi2cMHOKuuZBp0+d9Hhb7qV
         0Fpo/8UA9gT+aVxKhD9XTgkWjIxMfLfW9+EQONvVgYh3sUg6djFddrBmHidvGnSg69U7
         WCACVwVG1JCAW9qwUkotFq3CbYpKuMQfVCuYDmkQrBqBs8LFgyXuNgL6nkpxg0Jp7fJ0
         ZaTqhEwDbA4V7eKyAHyRqiNT/PHVj8tGV5wXTAEETbXJNkyLdWPa6Gop1u+Xl3rN7oKo
         yk8XRAQVxZV7IpXf+a/O0Q3nD7++/GOTA3A7PQr0jbSyWWswPdll5jP1elPko1JvEM3Y
         3pQw==
X-Gm-Message-State: AOJu0Yzeolm5m97uNun6a68euboj3w5f38wHR/XpXxr5yc3XIQykcVdE
	jrHiANg+sAJnMbxXpuTYTTuNyRjcKIOV91rkJ6vozgT90raU6NbAhYl/y1i+IRB6/fhYyvtzBUx
	fCy1780GJzJoeGgTNiZoG7Puf0SpDVUSlwzJgKg==
X-Gm-Gg: ASbGncuM/e59AjKM7lQNtka5dyfA8YRZzDcnt6R5Tzxdvdx1/07f84cjOM2cCILBOZl
	2Fa5McNFb43WwUOdappLs+/WRyRXfLKyT4bN5lcFSW3R4tGXFeaeqPFRJTx2n23hS0OeKiNUJCq
	5q424sPb9RI9MxehLVvdVYmuMHRyzP6aGbiemQ6uUNFtrrhzzj3kbQUBDcA4G9
X-Google-Smtp-Source: AGHT+IHjXtMM0/lND/4C1YfN6pB+FvxG5xBPA1G5va8pDe8hv0DRy+KV2tjV00P9S2pdXpa/LiAKD8WE3wYP6F9oc10=
X-Received: by 2002:a05:6102:f88:b0:4c3:858:f07c with SMTP id
 ada2fe7eead31-4c856901e0dmr4370458137.14.1743834565101; Fri, 04 Apr 2025
 23:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151622.055059925@linuxfoundation.org>
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 5 Apr 2025 11:59:13 +0530
X-Gm-Features: ATxdqUHtD8sJUPfm4UnmmdIUVFWTMvUomKqZ9daRtLxETGEWitzM1tdtNWpRJ2E
Message-ID: <CA+G9fYvN1TRaX4Wdu2zWcJpTJ-2FzONKdLZsamXXXpufzenakQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/22] 6.12.22-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 20:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.22 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.22-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm, arm64 and x86_64.

1)
The selftests rseq failed across the boards and virtual environments.
These test failures were also noticed on Linux mainline and next.

We will bisect these lists of regressions and get back to you.

* kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

2)
 The clang-nightly build issues reported on mainline and next.

 * S390, powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

 clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
  - https://lore.kernel.org/all/CA+G9fYuQHeGicnEx1d=XBC0p1LCsndi5q0p86V7pCZ02d8Fv_w@mail.gmail.com/

3)
 The clang-nightly boot regressions with no console output have been
 reported on mainline and next.

 * boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-lkftconfig-debug

  v6.14-12245-g91e5bfe317d8: Boot regression: rk3399-rock-pi-4b
     dragonboard-410c dragonboard-845c no console output
  - https://lore.kernel.org/all/CA+G9fYve7+nXJNoV48TksXoMeVjgJuP8Gs=+1br+Qur1DPWV4A@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.22-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 03f13769310a6563393c6bbbf9466936b50d5b0e
* git describe: v6.12.19-371-g03f13769310a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-371-g03f13769310a

## Test Regressions (compared to v6.12.19-348-gf5ef0867777d)
* arm, build
  - clang-nightly-nhk8815_defconfig

* dragonboard-410c, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-lkftconfig-no-kselftest-frag

* dragonboard-410c, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* dragonboard-845c, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-lkftconfig-debug

* dragonboard-845c, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* e850-96, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - clang-nightly-ppc64e_defconfig

* rk3399-rock-pi-4b, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

* x86, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* x86_64, build
  - clang-nightly-allyesconfig

## Metric Regressions (compared to v6.12.19-348-gf5ef0867777d)

## Test Fixes (compared to v6.12.19-348-gf5ef0867777d)

## Metric Fixes (compared to v6.12.19-348-gf5ef0867777d)

## Test result summary
total: 126487, pass: 100173, fail: 7402, skip: 18837, xfail: 75

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 35 passed, 5 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 17 passed, 5 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-fpu
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
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
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

