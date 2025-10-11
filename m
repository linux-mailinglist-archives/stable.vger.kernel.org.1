Return-Path: <stable+bounces-184061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108ACBCF2AB
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 10:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B664E3B5EDC
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDF238C3B;
	Sat, 11 Oct 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quE98vCn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F570202F9C
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173015; cv=none; b=A6UCP6xwkfDYsBYko7fJp/J8eA7Y3ygnwYEH4C4qJ4Y2QZvJCPK5j4DnqenCkeuuEyBTxcreVZdGszq0Y4JNniPruwP3b/eujfS8CCh5j4TcVa8auGabEeFxry8IHKdx8Ipc3z7Pt36OtlcyySLG+HxDiLM9CttLrtw5a4kIIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173015; c=relaxed/simple;
	bh=Q84Y22WpyJXzt9iWS/zC133vZ5OYVYmhlkD71g/ws3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeOwr36WfkDUQieps9S5I/cotOt55378Sfa1SjleUSPsXHARSCCobXzd8DzKEZcTrP06dD0plTM74fojjvYiZVlhWeFdGlH+WUhq9XmyibWhSuZJ8eXjyp6w9TkvFqkGN6rBIfMmQwWDRh1+OccvLxFM3CoRlrtwuFNb9riGVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quE98vCn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so2186789a12.1
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760173007; x=1760777807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZkqoAYenMOoLgUnvzMFIL5K5C3oJ0apuih+rVEe5zM=;
        b=quE98vCnVUHcNjcDgnOPPCXSzB8Bu3S6OROMydX5nHpFC8omIZzuF1xPzgSP78kXbS
         raxyPajS5NQtVy4D+Xu9YXHdlCufaKUrtPvul+Rcuep6kMt4WiSo0n6kBivc78NgaCmH
         5k2AuDGg7zO+n15r2jior0KyY8rDNtKRHxC+0s9buYswdWRA1qoFY7kAOEBaB5hNOCxJ
         xwer25JsWRp/jE2ETJKJ+uMfZIVN3inGBnFQsp2PmpcVteEshukaZ3uXbYrvoq2GSibC
         I82Hf0r4qgHKXlXzf02nWiQsKw0FZ2A53DQR+tuZCQEJNgBbCUL4hxju8rKZMXFpSKuQ
         dGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760173007; x=1760777807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZkqoAYenMOoLgUnvzMFIL5K5C3oJ0apuih+rVEe5zM=;
        b=Pq8ZnnnsauxD2dtj87QtRXCt0flFkL3E+WcObsFIjhRBXy4nMD1UXmpczuAkjSi8cg
         VY9bqcWvL+JZPKAS8k1c5r9zWF70W6AmetYGY2ycIIfF/5JPR0VuERYbLPz3vwm+nzZX
         tTxGLUI53d/8Ci7sETYdVrQc0VMx+OqPOlDByXMKc62gH04xofkLCO+fR51um+AoZLsW
         oH+ieZYixJPBSnmJJPlOrweZRvATYJSIaMWXYC3T2F3JLERofKenem7ztFJfy8kTRZDn
         xeVe1AxX990yJft1m+JBrUziFl5ozYT/aubcsRz4PuX1GaxSMqYCzXCSd8kyiw2FyrWN
         44UA==
X-Gm-Message-State: AOJu0YxwZJFkdsG4BLv6jXfzMFgrmO1gHhA05lEOaRNFrFqhEdLG40ku
	ue9mPR1tIuFXDlVFz85vlOwL8CMjiemH45xhp0M1LmZc2dVsZHvkRJEAHvKVm8LPY68h+r/94ey
	YTpyMiN7lP5PdR9nlKEsHiT5E/nOFswH1nbyl+n1urw==
X-Gm-Gg: ASbGncs8oX24HzSbr4bIahaFufqbZbQivRVkAUVQTY39kN6zhhoAf9b8RoljkAjAbW0
	a0JHpRgY6+m1ClCr03RzdlFPQrQ+zA82tbveJq4Ru7e2BLAHWegL3m/kKL3efgNPQ8xTxT5tbea
	rbZVYg4QCsdhc7jKiSuAZsl//epjoSa9DsEy60pr8k8aCWTgNFVLEK/6k2ReIdY7Z2HTYBiO6Vq
	dHJ4gnOHwlmTD0r6XQ98AApiNRgZo9RCVRUSXjGNPGjGEzWuvxv8wsxwxQO5XHSFw/hbugmmNlb
	CLVj2eSxaL/EhtLRof4DCC0bpqMJ
X-Google-Smtp-Source: AGHT+IH4aGvIBP2bJ9+QW0JQJLsjmcgQxlEsHkanAzq5vTqx6NRHHgIQno4wEWY+WHR6+SBn1LZANqc4KSd/RDe0qdo=
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id
 d9443c01a7336-29027418ecdmr195663335ad.52.1760173007557; Sat, 11 Oct 2025
 01:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131330.355311487@linuxfoundation.org>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 11 Oct 2025 14:26:36 +0530
X-Gm-Features: AS18NWDVp8xoME8Wr3vMHaskDzUO7wibXF6YelZ4zKm_xPeASpMUVNthsWfcn5k
Message-ID: <CA+G9fYvFgAOu=8M5LH5yBca6FyZCtrFEuTiEw7RzPoGp7Va1sQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 at 18:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.111-rc1.gz
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
* kernel: 6.6.111-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 65af00078567f7e13108e6036a6bcba7f2c26892
* git describe: v6.6.109-37-g65af00078567
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
09-37-g65af00078567

## Test Regressions (compared to v6.6.109-8-gc901132c8088)

## Metric Regressions (compared to v6.6.109-8-gc901132c8088)

## Test Fixes (compared to v6.6.109-8-gc901132c8088)

## Metric Fixes (compared to v6.6.109-8-gc901132c8088)

## Test result summary
total: 133027, pass: 113628, fail: 4440, skip: 14481, xfail: 478

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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
* kselftest-mm
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

