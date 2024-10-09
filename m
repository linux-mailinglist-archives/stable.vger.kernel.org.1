Return-Path: <stable+bounces-83136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2652F995EF7
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4625286BCB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB2B168C3F;
	Wed,  9 Oct 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5JruwTr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C115F3FF
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451767; cv=none; b=dUQ4e8sKffM8NJ97JyNZliajNCCIQssmdu0x32c/dx3vcspL6Bh1o4dC+rjJ+o0FNthvrWjqOAWhebwXmdYEIHik12jo+iTNgTIgCsvd2WMprgei+ecNhIakJXSLbVOOTvDkzl2KH7a+xUeg395cXWWLj4CyR4xeJGt9qU/ftRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451767; c=relaxed/simple;
	bh=OBoCzZArSFPgtY+XzpCWy7XGfDqTIIl94ILCcqhCr+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca5aBgX+1ZH7Hf5u8sYgrfzbmdY3dGZfBBxRrOY4r+oLO3RQbfVKx1MELrwikCyc27yejv9NZG+BLaQOzhtTPFG3TyzEHftL1y69moUvj8TgDJBexh8txrZR06R/R25j1pFzON6SXEMQgP9Gj9TO+NfuvNLb3GP+4l0y+gx+lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G5JruwTr; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84f96178a08so762130241.0
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728451763; x=1729056563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCiKLx9rR66lKJZ0yCzrSNrW64yAvgeD84o2+iatpFA=;
        b=G5JruwTr6yAzbJ+rxUOBzQH9mQP/1ZpV/1PVtO6LgscpPoZxsekoez33g2LdUw7v15
         bTkVVnJR9ZVWULELwFBOk/haB0qs3oH7MCnrg1D6eTY1yRvK1UlPx1cb/NunLyrgUT9R
         WZvOqPDwAqE77BZSnFsC9dwsnArCIsreoDOGez7/l2TAm5cbIyChFXGfImTXUXh3PbhK
         au0LgxxPh3HbPiwbp2G3fIxKpNjjET3Ai6MkXU3Kva4OWEqqMfXq4Ou8W380XEhrlsRk
         1wSjm1VxInOSeThzx7WVqiWsmG/L9Cz6EK5+o+Au5X/hpDSXpSa4/v2xOf6St7SurtvX
         d/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728451763; x=1729056563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCiKLx9rR66lKJZ0yCzrSNrW64yAvgeD84o2+iatpFA=;
        b=uY7TWz6lE+FXkmpF9c9DEyWNPOLW6ylQdEIzNRSjlPQ2PHNgte/jSquKnOWfppUbVW
         XVQfImCd8cECeDsKEj9gWVjH3ZOOh8ra3F7rmYepxoMY0cGYDCXazYfbvejlVwX5faDi
         tLv8eCtBlpYzJu24cEZe7mabDykRQO6SZ7SZtBhEAfz1Z0pFcXnAC8jVPlczbhWji8oE
         hg5Q5EBAQpwno0gZATY0PIgczvQe73MDHV88lkz93+4HRE2FcAeEKZ12FOmjd3WeFbBh
         fWlrivUu13tzQ6b/D+r0Q9WVSZ4SGmBr3mrJG6MEHagg5Jg4fqboMl0v5xe/0UPl4vFc
         Oq6Q==
X-Gm-Message-State: AOJu0YxbDQlBkay0aOj2t/ZLa7DzwXPaMMk14xCmODljdfwcI0rO5xwo
	2mhyjsJUD7vP3h9ZyGvMD20SlGShdP2aGwGej/7nvaJQEEx8LMwzBY3+CF+Yn2aS2AHNeybRdDA
	fAy3IvoyIDD/p1vwVW6Oab2KqBvk+CU+g6lrJUQ==
X-Google-Smtp-Source: AGHT+IEcGCHgN/Nj3U5qhLD6lgrzYU7T8ZcxgAgJFS75WLUI0nZsy/ZitTpWbJ/jXeNp0bK1KTTXpLFNuIpFI+P1egA=
X-Received: by 2002:a05:6102:e0e:b0:4a3:c7ff:8263 with SMTP id
 ada2fe7eead31-4a448e14dbbmr1647756137.20.1728451762845; Tue, 08 Oct 2024
 22:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115702.214071228@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Oct 2024 10:59:11 +0530
Message-ID: <CA+G9fYtKrtzVZve=R_QiUUya5KUpAYn2R5andSk+ghPU21z3Dw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
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

On Tue, 8 Oct 2024 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dd3578144a91f9258e2da8e085a412adc667dba5
* git describe: v6.11.2-559-gdd3578144a91
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.2-559-gdd3578144a91

## Test Regressions (compared to v6.11.1-696-g10e0eb4cf267)

## Metric Regressions (compared to v6.11.1-696-g10e0eb4cf267)

## Test Fixes (compared to v6.11.1-696-g10e0eb4cf267)

## Metric Fixes (compared to v6.11.1-696-g10e0eb4cf267)

## Test result summary
total: 229679, pass: 200671, fail: 2692, skip: 26316, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* kselftest-rust
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

