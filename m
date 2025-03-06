Return-Path: <stable+bounces-121253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A0A54E47
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9873AA6FC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36F19AD48;
	Thu,  6 Mar 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yxm1Pk3q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB541898EA
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272741; cv=none; b=NKIZ80iOhInWRlekq0JQXAMPdRvQBzx9wOanM1kVD2wUdUeEHNaEoM6zpdzUqZyTueHDjd52Ocgz/RKOmBMMzaIqZAn6C5xOfjOmTZAWP9Qfy20wli80Ursoeg5WE4hPPCv+XVPWQ6zK6NEHHjHLlnK9xHHqvWiW+4gbYJ6JuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272741; c=relaxed/simple;
	bh=yUu+b2vzGVtm02aX2/54++X00P3YWAnG4YmO83c4ObQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uybVcR08umCbiGrrEk5q6MkNvChWJaA4Y56n97fCCwsOroevkz1SIlKmbYVodwe0c1qlFGX0MpVtwENop4/c4j3exnhleDtNU8LTjbvoiRl8ukmHJZ+hg5Z3w5BVxzuoGEWiX1FynRL3j8z/7po/pIdtHkovVSRAwOaD6O6N1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yxm1Pk3q; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso281661241.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741272739; x=1741877539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++XXHmZkM/4heXDc+pXKcqrY45A7F6g9wZ+G1XbfvUg=;
        b=Yxm1Pk3qwOpMRKDMBc+EwiZeoHB4+golpu1oQyBLEThc3F+xDLZfqni+ckCQXADIvH
         RDcqJCr8WpUdAX93OYjEIt0mM9S1tYCA4wtq3QOB3OW36sKfv/tvvsCBNzxP+0v3pkGr
         +W4Kar77sIxhfMHbYCTqLhSwAOgzvWsTgRSQmRIWXAo1xliQD10Izgz1l6Swt5JOoHzM
         OJqmE/qQWO5xOYg8GK+oZbk/fSeFXahO0w2y7+QOnkapaogkYCo7AzfMtKNri6N+5My0
         rq0Povpmvh2hrJUFPBVPZfGeFPlaZkKVfWf5Y59/15TeWI7YXY7v8rE8Qpzai0oYRR1j
         xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272739; x=1741877539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++XXHmZkM/4heXDc+pXKcqrY45A7F6g9wZ+G1XbfvUg=;
        b=XqEG0fsGdzuQW96iHjwL+YIbUqYF9K2se4t+CkM0BHzAhTL7/e2285nZnqUwwUu1ix
         NZEPOKoNSBqTveNs7IouXgxqjybhacP+eie0VfhxRt2xejoBsQTniCNRvXc7UadytHWC
         PtWbWkRAbMR0FAnwgy+mppAZKEeFDD5zGrJfzbnrtIYhLVHCK+k2wAtU75Ov2k21eHKg
         VGRfirx9iFQjRSBz017TEjE8AYI+Zy6rLyM7DvUMEutoV55gPpnXJuq80riLleuJaCJG
         UqDyw4Mcv2DLDQWBg2nwGW3iM/RRUuLwaKgjMudG9S82j9mm7prUY2NXI9cqccgMwQ9o
         Tbtg==
X-Gm-Message-State: AOJu0Yww4p36Dnpxr9jqB0LAMay1qEaenxXMoYoQrKaeKP7sOH+DHGZv
	X7zH4yDOLJlbJvgkBx3Pp2HDZ6oqx3z+Tg97ps7T+3/OUnCK9y9LmOslzXk8Ft1s7v98QRwCHU6
	mkPZCWiK99VAhJT75uchNuIOUKyjmo68a8O/pAQ==
X-Gm-Gg: ASbGnct/TlyFWT1KtPs0T0iLGTfCJY32d2kALTuQAgzhdrueCLnUPN0FMLx4UWF/fpY
	BfKz6sa8SlMpUWz4ak4262e2PQIkE5BMNEzGC6LXNzWxVKYt/Gc/KfwTU+Q1WDOp7WPgaPdiljk
	OMqr47HIqdgpBDRt6UEH9ZQlyEg4kfvi2p+81OxXvaeVStzafKlnKcTAQfPTU=
X-Google-Smtp-Source: AGHT+IHqKw0y7gEoV2UPp2JTXAc45pxenBD9EVRnJ3CNyJRZgT0EsDiICwm8oX0iHkmbYK+jllnu/+N/IxUM9GPv2y4=
X-Received: by 2002:a05:6102:4193:b0:4c1:86bc:f959 with SMTP id
 ada2fe7eead31-4c2e27a6eb3mr5045988137.8.1741272738910; Thu, 06 Mar 2025
 06:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.437358097@linuxfoundation.org>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 20:22:06 +0530
X-Gm-Features: AQ5f1JqyKMYONNiG8qjjNgx2bFmT-sq5eEAlVlJjqLc1GhF9Jjc0gVpKZ-epy90
Message-ID: <CA+G9fYucgzxXxrTBUJcgRyJwXk=14S6tL9G-jd4Wm6fM4VaMkw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
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

On Wed, 5 Mar 2025 at 23:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.130-rc1.gz
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
* kernel: 6.1.130-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 34da6dd4fda1d2daf1b0df768fe6224d0993e050
* git describe: v6.1.128-747-g34da6dd4fda1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-747-g34da6dd4fda1

## Test Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test result summary
total: 75778, pass: 58508, fail: 3115, skip: 13933, xfail: 222

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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

