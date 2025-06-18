Return-Path: <stable+bounces-154650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F1ADE91C
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625B13AB0FF
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC4E28640F;
	Wed, 18 Jun 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSSxlVFE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CB286409
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242783; cv=none; b=NUrdIua3t0kvaIW0ZpGifJgPt0MtxcOAEb6cEupru/5mC1G2SvLL6p8w1sxN15gFvjHM1xxBd28uWgh1MXPwMW7ygmHMN691ZYtFs1sLsUjltr/eyJW113a7KXuhW9TkpPsDj6vmVQWIePfttH31l2qyhtAJzoEckSaSNexLdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242783; c=relaxed/simple;
	bh=UrYSDfsSo8jbAtRvRzWzGL/NZSe82kdFNONR7gB8P70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxl8zkt2/1j+n//lGdI0FTmTvsBZCjgbon7DJogRONbGvnM0R/3pct9Xh4Bq2m69+Spn0LB2tQLMrEQ65/t5XwhhtQzIghR8SIDrxz/adPiOJKTsB/LATKVKQT1p7oK2lXXUzSaDoSC8v+RwEYoS9N/5+ubvGJbOgtdsbOy4gE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSSxlVFE; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so1084258241.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750242780; x=1750847580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aITcoDBlN7uXS1VgjgbrvDBeop4ua9noQuKy/Q4cyYg=;
        b=cSSxlVFEHxWVfvwEvs9Ote8+yUVI46WKKLLl/j/Lu/WYr9xBXAUfWaW/AsqD+E3x3O
         zvUt8ouI5kk/tusiqaKolQljkrBb9PeBoZfExPM41gpBENFDbhxgh6C03vN+WWhdRvrf
         sLhkLB5qLmpIrk9oNSEXEeHnjIY85tRAwT87kFctixK5J/hJRL0ohk356gfxADjn84F3
         zww3JY495eCkHFMHxwxlgHDiPit8+D6kl+ecB0iwmMnwsQVDHsgz10DtYcZ+c72vUaM5
         JZF+biZOh9thTZts/mNs5t4lbc888Qfx8sywIcvFZRjsaTG1RMl5FkQDNcQZt7+Dnov2
         I1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242780; x=1750847580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aITcoDBlN7uXS1VgjgbrvDBeop4ua9noQuKy/Q4cyYg=;
        b=As+xm/7paYzddkdHBX/5sDOLhXA+1fruu+esQW2Hvfd0wVVcb8BwSCLZE6+aefGzW0
         ZBmW2WVcrqXtZt+hsWLG2wJdy1nr11MULN97fcGaZZjrLGkggLAc7ZyvOqb8ABsVv6IX
         tevrXIH/tYk7snkkeP9IK3gGBWKPwvoNZdtPH2vrMC2mABTZb2QCb9qroOma+0uJW0Tz
         5NxBMkFrBfKAAUZxfirpelMXmM4bQhxdm6CpbUTu7QDJgKlOHLVz0ZwfBu7BPEdqBvvn
         71h2aOXspHCnDe55iKpzv/YyJvQxjXREdFXKdrl74m89+1tydxxUwqDkyV/Ub9mDbTb5
         hkrA==
X-Gm-Message-State: AOJu0Yzm2GPS1LWeT/PXvJRi9mnl9HXR5MJMbK3W4D28EdOJOJwfhxqu
	4SuWEwh3z33tZyhM2v5JIUH+mJUPqnGIu9b6BSQoeuW+o+bmBZuar3cArztMoi6qttXjLTxCRl8
	XDQbnLPIV3e+KqiOWUOjYPS+OvzPzJvUonIb70jZc/w==
X-Gm-Gg: ASbGncvkrKAX+czkMe03LdBoBYiAkQ4XEQz29OlpLgh6VPaFE9ajsHKI4OzuW7TBNJ8
	dzLk7OipdXOjqE1sT5jxvcbRhfakUEEIEEmKwTbmza7nYScMHujw9GjHdqIm9bGlqfkGF/52NMi
	HryVF/4N5beYRW6GUwU6WmTJg1qGqQvR0BVHByIIynjiw=
X-Google-Smtp-Source: AGHT+IEOhMxcalcExwDVkASvmUiqj8BpLqLOJHPINNMBGhG0xRGGjlY4gMGyxbaf8vTC3PowQvMp9pc8rPfXoq8SPoE=
X-Received: by 2002:a05:6102:5985:b0:4e5:9380:9c20 with SMTP id
 ada2fe7eead31-4e7f60f55c4mr14046287137.2.1750242780042; Wed, 18 Jun 2025
 03:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617152419.512865572@linuxfoundation.org>
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Jun 2025 16:02:47 +0530
X-Gm-Features: Ac12FXwvCnSSJUeypLbKfrwr_IFThfVnPumtJ2s-S0kqzXU_38IZ41IQZmYKQXU
Message-ID: <CA+G9fYsiW-qzcJgkooTwU2YzQydit6jW-C1XyT8VOUQCcBK_Dw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/512] 6.12.34-rc1 review
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
> This is the start of the stable review cycle for the 6.12.34 release.
> There are 512 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.34-rc1
* git commit: 519e0647630e07972733e99a0dc82065a65736ea
* git describe: v6.12.32-538-g519e0647630e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.32-538-g519e0647630e

## Test Regressions (compared to v6.12.32-25-g6fa41e6c65f7)

## Metric Regressions (compared to v6.12.32-25-g6fa41e6c65f7)

## Test Fixes (compared to v6.12.32-25-g6fa41e6c65f7)

## Metric Fixes (compared to v6.12.32-25-g6fa41e6c65f7)

## Test result summary
total: 254275, pass: 231555, fail: 5974, skip: 16209, xfail: 537

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 0 failed, 1 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
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

