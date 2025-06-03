Return-Path: <stable+bounces-150661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48034ACC1DF
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626E5188EFED
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6F280335;
	Tue,  3 Jun 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVOUcXeh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB31FBEA9
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938263; cv=none; b=BZRYYACovw21K6xylNaH6BXnDH5U5WOzphiMlDx7oDwdmPDZ40nwkRE1zpbsyPQVSNmg8i8Sn2n/aXf6JvI+KtDT5JOvahuBde+MgvRlZPa6riJMwkNE/zQhT+b45eG/vOQlwZ1fdM10eCS0zjOQt5bliG5+r6PqvVMS12mE3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938263; c=relaxed/simple;
	bh=jUmM6kwyLUdPbLKXSy2k6sMf1vokiKUNKs1IpfSBBNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHJ5Cf6g0aW/F+oF+kN9oY2dtTni9WYQvAOk0tGdUpf3Xx5aCTP7a4vav7fqdVWWWZ0nyeE6KM4e3mdAkNSy4R1WiXWbwWD7EM3NmXZXLwkX9LHe96yAPuYfaiE6PIyeFM9JA475qlBYowandqi3oTZZ6qHpPj1KeXHRtcfjuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVOUcXeh; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87dfbe139b6so1189747241.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748938260; x=1749543060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJvNtw55BnHmyAVpfP1EHOhy3chABBvF/TrseOesELs=;
        b=LVOUcXeh7ILkQMLU1An71mgxeJGV57ApJuMa7O6Y8e5P8P2ZDdBXgFQSFITff5jUZT
         IKN2il3YM1bNgJEvt9HQg8FYBIK6P00dXQ9/htTRab08rPQA1y/7nO0TW6ZDv7uw7fEq
         fhU3O3UFOHeQu8uoFcRoYngPGu2JdKPlcChiSm196yNhOEhsbN+wVA5/gEt85pdAmlzu
         lgytb0x0kB40XjYykx4PGGfpORtJxkwCrhb0CvCWciBjdQQhjuwYlWMINnwTD8F3/x16
         WCbO16Fm9G5LEw3oR5c8KaTEPfVKGk6Sl6iXnEoFUzU/Uznx76dO4BJr3EX48PxFlTWM
         w/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748938260; x=1749543060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJvNtw55BnHmyAVpfP1EHOhy3chABBvF/TrseOesELs=;
        b=g8/ieJgGLgcUVHxPpOrjiAnEudxfa0rGgZumf9bphPQsUEw4zfkvUnIU2Ob+PhxpEp
         Bt5HZyCAbx75Fcp6kBrOQl0JYYgpw2WbKwnPsSnmXMVj5izylPzzhC93jzJ92TIhi0Gy
         4fnD7rauGh4OtgGLmepsuwg+2Wci+ZZsSmu1rWfmhh9ROjtRmVkJDrvTOcxMzHoSaDzK
         mZKOSzV8aBsZHZ17pc6K4jyT33RXegABEZdZlxndYsnzjR9OxnrnK5gxUOk/oMRtdwaA
         a6IoEd/skTMz9U9L40gb4eOBsZYwkrTQSunh4qWuwbCMKS+M5T9G17YB2xuli7kudWPF
         5Z4A==
X-Gm-Message-State: AOJu0YxAIDhHKll5l9PcYfgNALMPNUTK1QUJJWVU0BQzvWLvx4+4q1Ro
	mrzSUUQ0beGOpW1Eywc0soKpUwvGfB0837pbLmvDTbDis5wS/qeeiO5D6JWwig0WnHtAzLFqVNV
	+WyefJFddWtA4JxKa8TB2u68pN+7rZ4H7RwPWlKt0tB3Mjcto6SSLet8=
X-Gm-Gg: ASbGncsLvxGB99FNZjZhkEoMkilnsgUcl6s0EDe0gVM8zMq1z2QiJjEPC7yUt9Uvtu5
	V2u5nDwk/B16llQvfVkaMTVtrTepOraZ1m8fZGlUOxHCM+QEH5XJ1LDYxiIeJSSaW2st++BT/5i
	k3L3sTH23yMDjsUi+DG2Kk8RkgMVB8vb8=
X-Google-Smtp-Source: AGHT+IGCjVs4dMM3MqoDJk9DJ8c8U+dd/1B+c44BJ3TUOdOFILG4zbRELFKWajaB/m4NX5D1opMnugTamOsgMmdpw2k=
X-Received: by 2002:a05:6102:290a:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-4e6e410aefcmr12879939137.13.1748938260246; Tue, 03 Jun 2025
 01:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134319.723650984@linuxfoundation.org>
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 13:40:48 +0530
X-Gm-Features: AX0GCFvaxqWfgagp1ffOVYDvYD0c_wS9sizPQ3RqMcYEeBwQFBqHVjlDChAbOcU
Message-ID: <CA+G9fYse-qFqJDg17B_syP--b60iHbi4jH7=E6c8R_=F2Pkonw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/325] 6.1.141-rc1 review
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

On Mon, 2 Jun 2025 at 20:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.141 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.141-rc1.gz
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
* kernel: 6.1.141-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1c3f3a4d0cca7742a95419a6c91fff4326a2de1c
* git describe: v6.1.140-326-g1c3f3a4d0cca
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
40-326-g1c3f3a4d0cca

## Test Regressions (compared to v6.1.139-98-g1fb2f21fca77)

## Metric Regressions (compared to v6.1.139-98-g1fb2f21fca77)

## Test Fixes (compared to v6.1.139-98-g1fb2f21fca77)

## Metric Fixes (compared to v6.1.139-98-g1fb2f21fca77)

## Test result summary
total: 219869, pass: 201359, fail: 3409, skip: 14877, xfail: 224

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

