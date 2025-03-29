Return-Path: <stable+bounces-126990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF30A7551A
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 09:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8888D1890F06
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84A18DB0D;
	Sat, 29 Mar 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWQApzNk"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB952C1A2
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743236049; cv=none; b=KsR5w8DlH2co/D9ItCA+L5mJWuCzoMdnbVtJ6nkjypBp8XPia5pRa+gR00UxZ34mEKarTKgaIUP0aLSVrXldjMVRufKhrUQlFjSW24odN0aBO2oSMSAAMADbUOO0cZKRws8QLUWgEtu4Cw2GeQYXQw40gSSVljaKIBxWFH6crBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743236049; c=relaxed/simple;
	bh=8GiND8jOfRRGd/cKIqYAgbzQPkMK0kvc1rafMvZ3PM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU6rLohUFuG7foF/h8NWgXO8e4m6eQW/gGSajVo42ShkHEtEkElexj8eicMM7uQ1fbGloHTgBjUnjYILCvDgaxm65xNwxjCKvHyzRohzhFtYRswVw/6DUibTe8Cjo71+GLHk/ggCSYbqg7FpyoAgHUWQjk+7IqYpzy1V5gqXmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWQApzNk; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb18130f9so1447611e0c.3
        for <stable@vger.kernel.org>; Sat, 29 Mar 2025 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743236046; x=1743840846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV53tHVbf628erFwveMgJYR6DPNsKo+lGKHmW34PwcA=;
        b=lWQApzNk2+afaPWtdoqZPmh+jxgwEuv/iU1IvLVhjwWyKaMj5txKia94Tq/h8QPAzU
         w2yJGyC2vxXLfO5r3TRYX3G3q734lWBH/eTjTc58aQ6gMsHHx1yRZvbLvz96tVBorMi0
         ygD6hVbxfAYvvC6A/9VBtwlynHecdS8GVv1J12acqS1AdJ+YXdnIwMZoRVnA/Kz7BewV
         p92ZNlU+QyfjMmVDYh5SyRQP60DhtZR2+prPSjnZl0fhjYZC/4TSOPqnIsCfjvlnJhOC
         I8E2SAD8VAy4HtZLX/oOzLWDK5Ya5U2Mp1PSTFlRHl9eL4o3Usmnzl+KgrnMdJuosXB2
         yKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743236046; x=1743840846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV53tHVbf628erFwveMgJYR6DPNsKo+lGKHmW34PwcA=;
        b=DUhKfZ+iByOCPmUiEZssZ8g0oZ+r5uQnomU3Y7d+Cpgjhe1CzXWXl6ARfSRPzZOhaN
         dDF8xL5Jl53wRgHsiCpkjPhM0ipGb1g+ZHbBT9mUn6SnBL5X0jWiou9sFOkcYe1Bp8/O
         hBhKfmVqc06ckJiolO2SZDpKSn9WRc2/4aJYftTiESFtkCUTqhB+KeHAQyR+nI92OU84
         /vnb7WhBO8jdgZGsSMSJcEjAeo1Hsyrnl1wkP5T4TY4fiilKK7c5sM9bO0Im5omy7gjE
         P3O253RCCa7W1TwEYfg0vuR5/zxLemscML3tLyBl28ep2DrdE3s4+xCL/QF/Fyi4lU31
         DALA==
X-Gm-Message-State: AOJu0YwDTIbKGBYWG7wPIn873TBU+OPOGPDw6HBWHNfr7+B3hlMGZDFf
	dkNT9+Xk14sGQMWkiBGLEPTWBzt2+BjqHzWdiACEWyQeiAojnMn7UkEZbSpOxr+sA1krAn4vLhS
	IX0q0hoSp0W42kDTFU4jA1jh24YrpV5eFKYSi4Q==
X-Gm-Gg: ASbGncvzYPcIJEFSBo6zDDoS2mVe8ztOpTrB9XyuENE992zi293rBRXfMjZDTRjgQIl
	SuSz/F/Ef2qh9F45ZrfbDcbRwhqzHaik3tPaod7KXqu3UQMFwBXGH8xFxqNbXKLrAHz1QBJMPv+
	5FIR1PLqVHa8u3U4CAawmb2J3045dsKEedHCdo3pm3c2t5VlFdnac7EH+8VyI=
X-Google-Smtp-Source: AGHT+IHEtKCRNGj8GhmMQq+ZmsGVrBipDX2oWXka5tkbki1LML5Ps2Wrr39RT3XHXSBqLlr2M3yMmr17er9cOu8+i8I=
X-Received: by 2002:a05:6102:2ad3:b0:4c1:a448:ac7d with SMTP id
 ada2fe7eead31-4c6d3881b78mr1432023137.10.1743236045813; Sat, 29 Mar 2025
 01:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328145011.672606157@linuxfoundation.org>
In-Reply-To: <20250328145011.672606157@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 29 Mar 2025 13:43:54 +0530
X-Gm-Features: AQ5f1JrhUEGT2ZlSUHwliccXNJOe-vPWvTNmSHrnFCqn8yijxsLxRCCNICwZY7Y
Message-ID: <CA+G9fYuSxke1pLM2yPkijXuXQbyY-B3nQKa8rxdWxSL7nZ3YfA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/75] 6.6.85-rc3 review
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

On Fri, 28 Mar 2025 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Mar 2025 14:49:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.85-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.85-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1a8546896fa3161eaf3b65771fdfc55241cc9efe
* git describe: v6.6.83-243-g1a8546896fa3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
3-243-g1a8546896fa3

## Test Regressions (compared to v6.6.83-167-gbddc6e932207)

## Metric Regressions (compared to v6.6.83-167-gbddc6e932207)

## Test Fixes (compared to v6.6.83-167-gbddc6e932207)

## Metric Fixes (compared to v6.6.83-167-gbddc6e932207)

## Test result summary
total: 114024, pass: 92211, fail: 2845, skip: 18530, xfail: 438

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 36 passed, 3 failed, 7 skipped
* i386: 31 total, 26 passed, 5 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 37 passed, 1 failed

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

