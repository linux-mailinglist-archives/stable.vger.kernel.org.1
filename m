Return-Path: <stable+bounces-154651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4FADE92A
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 12:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57EF189E737
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C63280334;
	Wed, 18 Jun 2025 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NA+DMNPn"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F3145348
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243118; cv=none; b=ok6POCJkA4b6YmgwxV8KyrNLfRufqA7a0UOVdCvpgYrN8omivQyegQ0/BoM+UmJ0wkpyZ3gxUCcGPy74D+ZfWQ4JJtZoN8mE93+9184X662OIMdfE6BMdYTCcIzFdtu7rxibUVFhDC9tDjBAu0wyWR3qIAozRp6wa2/1WPeqHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243118; c=relaxed/simple;
	bh=9a+VL3V5KHa28e7NmLre1sNjbdQBiWLNlPZSaD9/wgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yn7yW3L3owxobMe09ExUKiOfHceTUUJChbbS/g673iUBTI2hesJHDK7Io35fqqABZZV3fBbxXiSxprbtzRa/XvlSVJpEYC3mClhwiTUyu2jkSK0FSLz2x2sM4ToiymMkWofC2xuzlth7wmnzZ826YLf5dA3KNHjY/KESkF9JeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NA+DMNPn; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso4074583e0c.3
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750243115; x=1750847915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg5xtbe/WgT7FmBUSQgT2r9SiVEXizKaw2ohyTbpqFs=;
        b=NA+DMNPn50aCoDB3FZs45WkbDmtimAd1E6cBJ6K8M+GNoeg0nwrdGjRoTiAtLbjnAw
         LcMtOjek5NALVQpGAjM1cwHh2oNWsAx4IFjl2o6SkLz0FhbtWVS1dBJFphhYylMUbeZm
         8R3BhmlbobTc/bAW1aGZmT+RHVs3uTSLdc5shzaVl0M9RoSw5Y5WfkWoCnWmZluTg4qM
         frTkCVaPPRhaLOqPafHVdRGfFGNkyRh5LN2q3zwxJB47e1bkrD7AKg5NBRAAWF6v0s19
         jtRAGyKH8hYlY3hV/phydEnC0WtFy4L9LbW2oqesUzjDGbQvjrMd2AAW6SG2gCns1AsE
         ZaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750243115; x=1750847915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg5xtbe/WgT7FmBUSQgT2r9SiVEXizKaw2ohyTbpqFs=;
        b=pVElhUeAQAmzq3FYIHQ3hkdyJHOWq6LKXZ16iS22MMnXQaS98CGJ6Iwu1HAQwtZbfX
         tRs58OgTT5wUldhhG606s6WWbdvXgQHVd0IfJ4n+CNN20PObyjo5N1hqqz7tFXuh0y3S
         pPcNKeqvuEbi3gK/seKwCmNTwRRQqxY/DFatfrL9tsauus5bgKyoONStby86Yyyhj24X
         8VAH7NH482etmMLUn+ucsw0uCokX0SKiMwE2t59qTxybN2n7tjUVRyedB/C9oP7jAW1Q
         XM9C9bP0mul8dlACOBsb6FoJ0pFlKdOERkYbXFMReLeXIAqvVFVE+oc54iq9l5GcIsy3
         kB8Q==
X-Gm-Message-State: AOJu0YzfNLLzavwaTR+IMkX7rYzzI9gA2T3+nlzSDCjs3mVLFyId6NPm
	pgLMiP4W96sQKX3GAhYQnOKC6Cbxs7+VbXzBY9pTWeMizgR/+p02Jb7fMkjLoj0YP/xqSFrHI2+
	tlVWh8zmyuNIJ58SrTh3qR3LnBq0pZRkcjh22YBbpzA==
X-Gm-Gg: ASbGncu58t4p0ovwJAgXdB2rTITHxHtpNl3gAmHbYRif6Y7eROIfJGPWJXZ3tM7u0UZ
	XtDCQKsCW8qI6QMNZckvXjYiSaRDUJ9EW7gR22PUIZYLlqPJ57FSqcKdtwnoiQF+a0WhVZgqVw1
	d1X62xEpoBlt4aAAEdOOWuqAEnk782dHO7UDg3/emI8Fs=
X-Google-Smtp-Source: AGHT+IGlfaQhICcEzYKv2o3Stujza9qvdQkGO403DqHMwBxcjQFicmsVSifd2BvFEXZCY1N3yeldnIcDuwCKvObxQZ8=
X-Received: by 2002:a05:6102:5109:b0:4e7:be09:deef with SMTP id
 ada2fe7eead31-4e7f6117f97mr12455145137.7.1750243115354; Wed, 18 Jun 2025
 03:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617152451.485330293@linuxfoundation.org>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Jun 2025 16:08:23 +0530
X-Gm-Features: Ac12FXyOvwAA90cx5WybGNFeuMmnrzQzZyMyRWHnfy4aD9kitOfgrNhzgM3cmZY
Message-ID: <CA+G9fYtiuoPfpv6wCtpBhD4h3iRf2n8LLBpqCi5FHP67i-rS1g@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
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

On Tue, 17 Jun 2025 at 20:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d878a60be557cef27d9897a1c5269b76e3269603
* git describe: v6.15.1-816-gd878a60be557
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.1-816-gd878a60be557

## Test Regressions (compared to v6.15.1-35-g04e133874a24)

## Metric Regressions (compared to v6.15.1-35-g04e133874a24)

## Test Fixes (compared to v6.15.1-35-g04e133874a24)

## Metric Fixes (compared to v6.15.1-35-g04e133874a24)

## Test result summary
total: 256017, pass: 234795, fail: 6773, skip: 14449, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 54 passed, 0 failed, 3 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 47 passed, 0 failed, 2 skipped

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
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

