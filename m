Return-Path: <stable+bounces-124209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BBFA5ECC7
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AD83B0643
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CBC1FC7E1;
	Thu, 13 Mar 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CK2PzlFw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE1FBEB8
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850379; cv=none; b=IUjc/E/tnKR3Sjb5cLrwlXVKuTxdGeQ8dl36w8ltzMcuGxyh3INiXbdekTN5D1Xiz5VtzM2S8AnFEr0y+uO920dUWH53PW/hWKJTVSvvsmZ89LDf7bir8xy3TlbcLQn4125Oiv45IiSUQrWhg59TNn8EZ6J8Fj5iNYT23xB6f8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850379; c=relaxed/simple;
	bh=tvrIWAJJ2tNps0LjZcZloUQVbHDHX3SZ9LzINjvttfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRZ2dMZfD9zzyVeJsswzOZ5O5woV0tNliqiBOKh4PKxuCiZfZYxV87wF+MnHHtJKLEr3WnK5TjD/Qj/eqBD6pWcXrbu0U0OG5UML2HezkKYRwToN6zVeIBMVVAZJ/j27N4jCcXaRyH8763IO5Tjx4uRtNLeayUZxI4dM1Twf61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CK2PzlFw; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so269143241.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741850375; x=1742455175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAZsZ1wRYrAZzl/Zgd8kqSQ9r3vpzwVRs5a6xcEHCI0=;
        b=CK2PzlFwbwaGPbL0BZ+OLVIRMuND+bMD0SLGvDi5mW7eqG7NGsuj9XlKFVv6powb4K
         gIK+doVhY/Pnq+VDQm+j1f9RMPKF5Oo+DNns+Za+bTFDcSGdKrgWdQsxN7yZkisqI3h+
         xFc16y9i9UE6xpXfaVA9gcuEyrOV39dMaEqieKcVvrThOEBT/avR3mFnH4VL/FHpGER0
         FVX894lrL3c08RKlEojFwVqkWxI9Vf7ONiB8dE96CVMvRZ7LA7snI3y6jzI5dINPrj8J
         RWlQx17RZes9RISXCjaDA737Dan2XLn3nn65eGqcoq6QiTm81hxh5RlTQPqzaCQb6cPo
         Rc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850375; x=1742455175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAZsZ1wRYrAZzl/Zgd8kqSQ9r3vpzwVRs5a6xcEHCI0=;
        b=ZflImeQMpOkodLmHPylQZqND2OJVdXnLmvzZmWlR5++TF3OrlaiA23PpzOf7nnnmhM
         AvpJKtTU6oQ0RzX1I7dCLaNPpQW0hGSnED1NsEs6pGVCRBbWWkx2Ubbu1uXimDDYfDBZ
         C0LOUhNb1w0Fwe/YcqPdCen+7BzBAqp1MfDqfC2lFLwZ20IWoPMhSojTdlK/tQai5Wqw
         0Zsm+0Je7pc9HFeXWHffKwHNSqNo8RbV13diZsb3ZIc+VmYYLceLi0jlnoOKN26SSfbC
         WT2JGN/IehbRzTVtb1K2rkN+LZj4Uw4aXmMDCHjM2OIglKbsgeUGSJP5hcEoLZdrJunD
         oCBw==
X-Gm-Message-State: AOJu0YzC60GppFwjLRepWZzSRGV9ivRtTldDMLoQZv6lnD2aXmKd0/Hm
	0xtIq2QI5wmwr9AkY35wbg+lQ+G8QmJhMFfrqBL6oUkVMCRq0G/R391EF3DNMVppolZBW71MGxU
	9oCK5pbmlPm3wS04maL5wpTNivZjqhv5/M9OpOg==
X-Gm-Gg: ASbGncuxn8yauOP7MeVCPo0nembhofFchMfJ2EpJRwzKrvmcG1eScHXH/0tag8lJFlP
	h5B28hRL24a4lZe/bblBa5KrGmOI9IvJZIfnH2gbCSlpk3WBHjOZjO16kgyNzFlpmBd58iJjupd
	CUvx16MYf/Al7ZPXMKd68zfnwN7wgus+ljajz8WR2k1SrKxH/9qpjEmW89PgU=
X-Google-Smtp-Source: AGHT+IEV/rGOaoEuK3zniqwPgl/moqYdxmVdVff00QTaFe19FzRCQOIbMxDf+H94F4ZKWQ/VkTHqVRxX6Wom9nlJVLw=
X-Received: by 2002:a05:6102:508e:b0:4c1:9695:c7c with SMTP id
 ada2fe7eead31-4c34d37b464mr11680214137.24.1741850375129; Thu, 13 Mar 2025
 00:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311145714.865727435@linuxfoundation.org>
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Mar 2025 12:49:23 +0530
X-Gm-Features: AQ5f1JpCEAGT2FPlxBRj2m9Ee0zjW6ymNv1xOATnxXBPZ3MffwHeWFUXuP9Bz9U
Message-ID: <CA+G9fYtG9K8ywO4w2ys=UEuD_r1LgOuZhG4cg62YKAX0qK35cg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/328] 5.4.291-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 20:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.291 release.
> There are 328 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.291-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The following build errors noticed on arm, arm64 and x86 builds
net/ipv4/udp.c: In function 'udp_send_skb':
include/linux/kernel.h:843:43: warning: comparison of distinct pointer
types lacks a cast
  843 |                 (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                           ^~
 Link:
  - ttps://storage.tuxsuite.com/public/linaro/anders/builds/2uDcpdUQnEV7etY=
kHnVyp963joS/

## Build
* kernel: 5.4.291-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fb482243c16ebfe8776fcd52223351b4061c1729
* git describe: v5.4.290-329-gfb482243c16e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
90-329-gfb482243c16e

## Test Regressions (compared to v5.4.289-95-gb4cc7cb40189)

## Metric Regressions (compared to v5.4.289-95-gb4cc7cb40189)

## Test Fixes (compared to v5.4.289-95-gb4cc7cb40189)

## Metric Fixes (compared to v5.4.289-95-gb4cc7cb40189)

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 37 total, 35 passed, 2 failed
* i386: 22 total, 16 passed, 6 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 30 total, 28 passed, 2 failed
* riscv: 12 total, 4 passed, 8 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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
* ltp-filecaps
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

