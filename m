Return-Path: <stable+bounces-136529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB5A9A468
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B038E9228CF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C920D517;
	Thu, 24 Apr 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKGa1ROO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DD21CA04
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480073; cv=none; b=hN3QfuUl1gb8el1YEocaYUsynpvRPFM1VWMnK+TPbQh0qsBN2ZDRBWkBvhh2PQf8e70KO5GHFdItdiw5uiEhfX4ScRK7tSWUYjxxbr2vZWpo6Fgj814qjA6OBdpso3CBTFaB7YkGv3XFkTBHWTUjmRuOyilmDsNZdJ7352aoY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480073; c=relaxed/simple;
	bh=Dj1Lv1vYfLYfue1RADdfX9+Lvh8P7qLve8owX8a0Zq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHAbbWF+45SLbRm/YyidAuwFUFjXqTMa/sxRb4JmjKUm9VnNRp9rz377VgQVyoGptfcan6HyAR/9WNkb1raja1qWEUKbVLzOXn34JLAvBWkHdSySWFQImCl59Ny2h2znbea6ZnO9DFjaGhkxJPyv93CaHNDYcb5KDtt9dmj8ujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKGa1ROO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51eb18130f9so384339e0c.3
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745480070; x=1746084870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg1fJUqFPUmaQAIOsB514eMr/+6dxVQ5q9mfZaUqhwI=;
        b=GKGa1ROODnysSVQ4zmsUObNjIU8w1tiKFlKx4ole+tgDlSUFroaNivVQrAzl+6d6zY
         racDe/XhMUQnUH1CiW0nEw8WFYwUwhej+fEZIp43mY/jfzVjrmnA9SgbJJ5qMUxNrH+e
         iBQPT9d15G9rdipVJLMCrgtWHHx3q335rY6QIWIqq7WtRJrKHlZtDk2Rv4qILtRv+n3D
         NCE5AjscL4tJunumOeZVF/0ZIyZaSNeuqpO7z4aaMGvcfWwpkbzu9aliIXvXAqg7WXlx
         93YxTxb0gs4vEb4aWIccy81ATsBhWaPDf9aBhFAdKRigvRnQVOP7iEywCd5+KV+h8PLM
         1I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745480070; x=1746084870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg1fJUqFPUmaQAIOsB514eMr/+6dxVQ5q9mfZaUqhwI=;
        b=GpOUgYJHNzXSuuj9C5jiIPwhOEWAXPl35C6/TRYaZcx+E2MoEUAifQW4WjimVMiePM
         /KeOe0jPiLcTx3QupEJy+uUG3qaIAxrg4o7MA/iI7nHi9d4SGVHFBqrjYqqcCq+KdOUC
         mgSt7P80iA2Y3aVyd9JZm2GNQBTVsZloVjw+FLQ656hhGAyfiUdbLioBnxSgh67hbwBA
         CvTziBV2kPSa7JwW0TxjhFROdYvPZ3Xbb6fxVRrSiIH6mzZXKVfqLSY9PGVQ2XqJN2X5
         7Ji/VzzKkGdz+L6UyngD/r5WFeV0ZPXpxtNzsYLyzR9u3JsczXlMF2a5sX/UI/HeXfop
         Xgmg==
X-Gm-Message-State: AOJu0YySLvJMTCOdOAON0mRUAoSfGTQ1UxMUEUyJUazv9TP/Hdohqe28
	W5Irj0OEtG+pJ4YRg30uxUj15jBkHoHtx8bLRJFcv+z/iZ0XaYvqxvnqv3VQj67rlzumZuOJi+Y
	FqLNQURzpeDsd6NzSNC8JxO7XO5zZVCj9EROHsQ==
X-Gm-Gg: ASbGnctzJUtmUSZ0KQWSubqceg6oQ21KmY9jzK1XtE7YsbwTBOGagrUMP9TQ1kGN0ec
	7qR+VhTN1/m1OapGZDi/URf6fdTSxy752ODQHiMuaBY3oA4Cd7Q7UYjtT15Gcw3e0u5h+/YAXqZ
	SL+Ex9tocxN/+SaA+6Y9C1SQ9CTmjpkIcuW7NJYrncFHXS4P6pwY/FaK77
X-Google-Smtp-Source: AGHT+IH+AZQn/RXsq4aIiZBGFx6kcOfNTWST3Ud9lzCO1h/OKWqCizwpNOX6zINAICkkJCKhYFL2SJd/kzv5SZujIxg=
X-Received: by 2002:a05:6122:1353:b0:526:2210:5b64 with SMTP id
 71dfb90a1353d-52a7840b1e6mr978639e0c.9.1745480070478; Thu, 24 Apr 2025
 00:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423142617.120834124@linuxfoundation.org>
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Apr 2025 13:04:18 +0530
X-Gm-Features: ATxdqUF7KMwodSuA0qtPO12X0tglypY1DQaBNL6jLImWiASW8rwygFekJbp9zOU
Message-ID: <CA+G9fYtT4eEO8Bz54gsvhA-rLp2yP=LDFV-evO2Dacm45zHX9w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
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

On Wed, 23 Apr 2025 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.25-rc1.gz
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
* kernel: 6.12.25-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 56d2398227a26c9827858b438ba125e54ae8b9f2
* git describe: v6.12.24-224-g56d2398227a2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.24-224-g56d2398227a2

## Test Regressions (compared to v6.12.23-393-g7b7562936f80)

## Metric Regressions (compared to v6.12.23-393-g7b7562936f80)

## Test Fixes (compared to v6.12.23-393-g7b7562936f80)

## Metric Fixes (compared to v6.12.23-393-g7b7562936f80)

## Test result summary
total: 126085, pass: 105995, fail: 3148, skip: 16539, xfail: 403

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

