Return-Path: <stable+bounces-110160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A2A19126
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC81888E95
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB1212B37;
	Wed, 22 Jan 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FS78XvGZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE9212B1F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547590; cv=none; b=dYENCJrxzyVE8CAU6IA1JMG/KIcyOM0XHsO9zfmE3HYVf8azg9xM9CZ7YTQrCUguXmLyLc+hfzu5fIPBkmSIAe0FOPwN2Kl4uOVpE73nf2qtkTXK2haqaesQSIP/aEOeOz4Y6zWiY3QKp0lcjJH4hr/2xsW/5ZvxJogtDHsLM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547590; c=relaxed/simple;
	bh=WCNAfkguun3M0jumq+PaEvAdNAQXoOs/1O+m+YxWaZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrztZkkEYixAgCzk/Ds76wv77gdJIEzdR8t7DKcHCQEhNYjzQHkWyl3etlRCt+GMH5OBD2wT4e4Orb6N4ENtzWq0RQR53yEIU9ZV6QLniAxeF7byeuXYlyzstoDI+ahHGP0wBNxEGBcgKhw+qX1JuaF3W+ppXzjW+/24cSzJ3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FS78XvGZ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51cccafb073so2248702e0c.1
        for <stable@vger.kernel.org>; Wed, 22 Jan 2025 04:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737547587; x=1738152387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHk7NAaxf+oYEbpjS4HQTJJQPTECTeYKL688RmbnOtY=;
        b=FS78XvGZHFR+WEgNj8YWJIxcTQIUDHR6ZFbjjPfXkv0XPd/Fp8HN+d8YqkCOs1Up9I
         ADCADz8DbGOrkrV0JzWv7/+LpoHpQNYKmlZ3EcsdCqIuq9yhhdVZYNLIRH8a39ZrADHX
         5Iz5hxgIxJIErXJD/hrP/UmQCKuOQ0wxgvw9TpLWPzYT+Tx6peNGoc3BPkLXc9zZrnxL
         uLc9TSbsrY3vOszz0xanR68UrNpbJMfnH8IMQNZVIjHOUGGGh9zoN1mDv9d5ewBsR4NH
         nQvYui1Z7r5bkHWwr1ygj1fylo4tu3jZk60V2D/6AUssY1SS7EevBh8My1Wpcv1jioit
         AFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547587; x=1738152387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHk7NAaxf+oYEbpjS4HQTJJQPTECTeYKL688RmbnOtY=;
        b=DWUSV8rYdDaIbC0U36g4HWWd9Aupb3bz9GxA7PH2nPPL413vfvNIk8X66ExYhFVp6P
         zYZrnI74kjw6lTmh+fptoC92LRxHIarevjipH8DUHa4tLowvqBKYbX4uhauDywz8WFx4
         jEAI+5E56jW0QoPiE4f48kuOp68IDibSm3Hnzb5kUIVbt9pHTPimEyT5SRxnDDpP7qZ4
         y1kCR9cjLggtl1KyvB8AWY/JNr1Dc46t4XpgCn8hxOWcyzvYCgRqoQHoNmHtgvJfw2Mo
         0H3ca+VYEPd2tMu9sPrEEyQh0Oj5ftx5e4F35WXys6wefh6lfkGOSpYxzBfaLpDKEgkK
         dgrA==
X-Gm-Message-State: AOJu0YzGJkbC6e7z1Wgo/oVHN5qaby4n0s3+kYMHUSUNv5bVkWmIGJme
	pc7vyPhFd4ejR2r50DfdZH10w+UdFamPEBHH1TPsVhzwKVsrQaLylqedhnjbwQ5kaOOG1aF9loJ
	bfto4j+KsSV0GrA4Tr8zuZIhnr03ANPb+TSP9yw==
X-Gm-Gg: ASbGnctjWr2hy4YhW5r+CzPpFnsuszpeHBxX85/88btjhbIicfCMcASxSqfsDera6YX
	Bj+DBIazRcwI+5cjPQsGjLfhKUjYveF1X9oS7yNExim+ScRhNW2rEljptTgIzSPh2MWfUCcrp7c
	f1pzYAZeEQYQ==
X-Google-Smtp-Source: AGHT+IHzpAWnMUS264HCJunu/dak/42/IkL0+dKu4p5++YpVDJ0kSAmxUVpOud7wMUU706HbIDdRDxy8ENHJL2XPOjs=
X-Received: by 2002:a05:6122:d87:b0:516:2d4e:4493 with SMTP id
 71dfb90a1353d-51d51b77f17mr13625599e0c.1.1737547587074; Wed, 22 Jan 2025
 04:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121174523.429119852@linuxfoundation.org>
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 Jan 2025 17:36:15 +0530
X-Gm-Features: AWEUYZnRLDlTPlW6xfmSjYXS8mferD-ti_06kwJgELSii21yl2Eb8b7oQ5OxO4Y
Message-ID: <CA+G9fYsDRXLsE9KnxDZ4tNKfoBdqozOZfEkVo5b2CZaeDD606w@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
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

On Tue, 21 Jan 2025 at 23:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.74-rc1.gz
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
* kernel: 6.6.74-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 429148729681ff93db022c19a17ce00dff9c04f9
* git describe: v6.6.73-73-g429148729681
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
3-73-g429148729681

## Test Regressions (compared to v6.6.71-130-g6a7137c98fe3)

## Metric Regressions (compared to v6.6.71-130-g6a7137c98fe3)

## Test Fixes (compared to v6.6.71-130-g6a7137c98fe3)

## Metric Fixes (compared to v6.6.71-130-g6a7137c98fe3)

## Test result summary
total: 101573, pass: 80919, fail: 3206, skip: 16985, xfail: 463

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 44 passed, 2 failed
* i386: 31 total, 28 passed, 3 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 32 passed, 4 failed
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

