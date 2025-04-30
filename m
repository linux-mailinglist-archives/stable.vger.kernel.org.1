Return-Path: <stable+bounces-139206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1497AA51EE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1D83B0777
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BDD262D00;
	Wed, 30 Apr 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vO4hOzGT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743782609CB
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031585; cv=none; b=k2Wl3d6XHfSJMc6/dtR4qyI/6olMro/sz+3f01ue4IKD8zDnaSZJFiCbD7gAZkEd9wKxLP+T3xPdWvO6F1ByFbBK2yoyXr3hD56FBXEjd7MzpWeWI0xDJVwhBwb4UQI3dWBhPyOm95zebGSCYCvqHciYp2ONfMHK5nT2y8dZvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031585; c=relaxed/simple;
	bh=pMlBRncKSdCK24VTT995PN/XIsoTLwggdROEa0Zb3s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D21nHdRo6BxTOElOf3KsFtNXZ7qTX6tm4EfRLC+Xhzxe9vD6aYYNMid6xgNU6AfUY5hNEuaAaGAsLPLFUKk7VYbOLIQ9ywqZ1Q/y4tQJDyYqiLRf+knYyvtsAO7uSJz2RUu7GZWn6JnHcXFnHj6A2QGybdw8WGj11dAhJhunT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vO4hOzGT; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523f670ca99so21845e0c.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746031582; x=1746636382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6QQATCJnAni7lD26HoQnyvx3aPp8MUfzUYQFXvsgnk=;
        b=vO4hOzGTayZ3yaTaxnUhivygP4ecf1Yz9WYl8Vok5SnNUW9AqiBC/TaeHIfaQhDTWB
         I9ZDNqXJ9+GgYih3XbjPpUPmfVFYT7MogpInDTrvlEYJGZqqJ7g0HqQCvi8Xv1yGU3D5
         YeQ6Rh4uaN030jMK9D85jFMz8lhU1Jny5X+gfKSn1RE+UkAoF2L0KrRPTmRYpIcOL4xS
         OPZNRYyEIoW+u279D5z3m1AjfIy+ykzE2Un9QOqsyxPnJHWA3j65GAIMSAjaINdVT86I
         LCIHGZS3kv4y2K4ApadIe6vnlIICASI4qk1E7UO8sIggSTceAymPwwDAckPE4dpM/nEw
         T5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031582; x=1746636382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6QQATCJnAni7lD26HoQnyvx3aPp8MUfzUYQFXvsgnk=;
        b=TERQRkZLd3ICkFdRRqbu/prVGrgmF4+z+8JuJ5jYsvto287COg1/VcTC0JNgxGu5iV
         XMbvkUVKcQUHHDm6B4ZXRX99XCC6p3c0+DCaRL3n2j/25XklZavPR4hsY+mZfhjOqkc7
         cz92FOGKwOV8NKs2SgM2i5/9LSU5+W6wi+TcZhYqwReB2r6uK2inc3yVuZsS8z41JzFY
         Vz0rD3vq9ctsxbL+exAzpWg9WvUAFt+8l0CS6akCB8kSsWeUBpzIb0Jg/ZTArniFzWf+
         C+cTivAdAh87574zjYklWc9jUtt+4T78QD4X0Wc4LKlFABcgFQ+kNUBfhNhJ/ZANpAwm
         3C+g==
X-Gm-Message-State: AOJu0YwgKBozeTTjjuAx6vqF3iqKwPFyK7ji89wehhF8mmcQ02HgdWTv
	RKfCreM2lCqHSbAzWp6fg5uhxvbKgWQRJCg2zK1SWxm33dQv7LxbecQxFgk2egPIY7/ll3K8Rbw
	zVMox5Y6Uba2SE1p5AmgKTckMeFu5vqGGwPtvIQ==
X-Gm-Gg: ASbGnctAJdlQV1Cwp0b1+FskdktaJxbmFCqlW+NhXwkpypPiyi8NZZrpDHvnUKDVI+1
	8qPLX8lUrmT7PjfNZUUw2zkg1OEpkdowfpBvO7od04w6SmQYkyqMhaQu6m7laLPmGf3U6IfiCix
	8Sc0M4j5U/dI2LcWinQvLr7mP99wJVdiDKW9RAaS4kbO4D/c2HGmOIApI=
X-Google-Smtp-Source: AGHT+IHiKsaa/9PupeVMqWQM2qFCut1F3R06PIZ50WdJGmP1n5qFLKYdVGXrnFfD3AEl2/STGwJf72ayeOa3zrci/kk=
X-Received: by 2002:a05:6122:310e:b0:518:965c:34a with SMTP id
 71dfb90a1353d-52acd74d8dcmr3700062e0c.2.1746031582213; Wed, 30 Apr 2025
 09:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161049.383278312@linuxfoundation.org>
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Apr 2025 22:16:10 +0530
X-Gm-Features: ATxdqUGa_QPS1XzDQeZR0E56worKFlQ0tfYA7of30Zy7JIE3lz7xhvChppL1Glk
Message-ID: <CA+G9fYt-Z+4hhQFNCu=RdsK5A4AXWBm=_FANVdd2NziNjWWTQw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/179] 5.4.293-rc1 review
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

On Tue, 29 Apr 2025 at 22:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.293 release.
> There are 179 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.293-rc1.gz
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

## Build
* kernel: 5.4.293-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d5e62da0f6d50c9412ef6220500b5c0c886d081f
* git describe: v5.4.292-180-gd5e62da0f6d5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
92-180-gd5e62da0f6d5

## Test Regressions (compared to v5.4.291-155-g7a5af469195f)

## Metric Regressions (compared to v5.4.291-155-g7a5af469195f)

## Test Fixes (compared to v5.4.291-155-g7a5af469195f)

## Metric Fixes (compared to v5.4.291-155-g7a5af469195f)

## Test result summary
total: 53398, pass: 34036, fail: 8725, skip: 10462, xfail: 175

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 128 passed, 2 failed
* arm64: 30 total, 28 passed, 2 failed
* i386: 19 total, 14 passed, 5 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 21 passed, 5 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* lava
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

