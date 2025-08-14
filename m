Return-Path: <stable+bounces-169524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F63B261E3
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A31D170C6D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B02F745C;
	Thu, 14 Aug 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/M0kQoe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42D2ED14F
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166264; cv=none; b=ntgzbLYTA65SJn6+k9K3fXak8yL0UuGP9ccdXOK8Q7WT0HKuFQv2lSH1ZrdByOf4orIFhOt9kmNCLyf39tzZYZCj6BZ7wR8l5jEpfNqHLVvU52NsSxQJUFTFylYRrPSYJ6mkFenVDkYD/hXSEwcEC/0vDCpQwhwn1lXbv5o+V+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166264; c=relaxed/simple;
	bh=3lgh8xQ26jozDiJYVvb/a6YneyTFrSwzHoOPM1g7Lwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxAM7nvxvP3/CgKDg23NuJBhP9gJA3gzVJHJQlY4KMzvMgFKHT93TspgsB3PZ7Jxp28ZFDfN8FJ5UJez8exidAGhBbWTaT5ZhEI3DRmyEGbw1ih60MU9/ZjMui0K1nl/QyLjruJ1FiwwwpI2Dg01Ei7HQ+eCWRXRCtoj57uS4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/M0kQoe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb2bf30so862930b3a.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755166262; x=1755771062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fX785wkBJ0IdNPwEH4B6np2Zn3mGDedo7EzvKxRowo=;
        b=A/M0kQoeBhLgn5cmxrlR1K98NT/OpTnmeo0o4WAp2VZwQfPweU8+8O3aTlIL3/57Gh
         LaoR5aQqEKIGHLziMjGbKMsECmCzkSZKuJYi3U3/MPj/tFgJDr7Zv+izT77yAm0MXwjr
         gCElk4i348HB/+dcLI0ee9z1gyFktFj58u+HDdL+wAbAxoYG4iFMK4o5zi/67uNKvlZr
         s2rqkZierI3N0WZiJhP/7Zz1I2zlRK0W9TSMxESqiW8ZwH/g4xNe3DUAHyi+D5J+9yyO
         XWOvmld5Du8pWJgwR/8AxanJ6YGk908Srj535OwWPmpMMAIHqWRVyGUdgr+SZCWkUHaC
         Tz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755166262; x=1755771062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fX785wkBJ0IdNPwEH4B6np2Zn3mGDedo7EzvKxRowo=;
        b=JzHy7w3VWrlgnTluSz36rT2K5ii6RE6zLwgm/sGkngc0FX8HLLgE9jpa5R9dZ4LjXF
         b7DmcLl5iR96DRQybCfVs3rKQHSGhw0zKzFfPs/hcLVGGMdkwhDEDPUsbTMFUzhuGhej
         h36DpTz5XHWfhRxhEyWiLdNqqMr7MTvxmAEWr+N2u7y/UEjDqjWo+Tj85qDN0fJyHnqR
         ZJs0eA7TB3ZPtZIz5tuwjDwr9R0WSbJlvlLS3uMNv7by28s+rhcCGC08YaipZnmix7SZ
         zWU5Ky3I6Qd/oa/pz5ymg8athF00qkCZ9nE/SFYecjzxLuYv9lbQD/bWKmNQEoO9gw23
         nP2w==
X-Gm-Message-State: AOJu0YzPFLpQN51BSgfCfatf60eU5PCT7TmGqFAJJr20Fhf8PlKQKGtw
	qKlnEevM3s4nbSW8LJqSeEqnwREJ7nAjgE5Ho8UbiqLlqD87Ka5rWsaolfvarmyQBKJgq6roo5v
	LbQkmjLLvUZZQtJfsCEhLXxqs0ookwT4nqS0wKvxASQ==
X-Gm-Gg: ASbGnctEdCUpfVRRtG4VDS+KbMYVkdvOSnECXnCRxGTgW9eGE1fHKW1Urn+Hc93CVWb
	3nJenARAeYzgENE1tKtwq7ICKmORw8rGinHXsealG5nxrlLdjcE99GxwdmHLdQqqmf+Tpy/qGSx
	iWQUYFTg7hSAxbL/ff2+uRpgFrao5Up01N9ZF06MPKXdt7GpQGRxqptSCe84dR0vRQOwKbydoEN
	8XR/ZZ7a7HcY1ksjPdtpT9UHStCs15TW0gY8Q9XH6IjGBdRpWox
X-Google-Smtp-Source: AGHT+IHb4ojkdA7zcslWWamWR1QUnn8TXopVuG6YgtHfwA2nc45FHARLYsJF9iFveQxGypjEoJChOlVWGf4q9ywKLhw=
X-Received: by 2002:a17:903:1b0f:b0:240:3d07:9ea4 with SMTP id
 d9443c01a7336-244584ed15cmr38835865ad.7.1755166262424; Thu, 14 Aug 2025
 03:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812172952.959106058@linuxfoundation.org>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Aug 2025 15:40:50 +0530
X-Gm-Features: Ac12FXyZ1RL-JNvJ7CwJU5ih2TvRDng2iKqcJ0NdDKAOTzZYTi5fCS_1BEm7rUM
Message-ID: <CA+G9fYv0QfL4vF5hJoSzd-kQ=BdcH8toAMhvEnhqem8og_UQjw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 at 23:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.102-rc1.gz
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
* kernel: 6.6.102-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7ec7f0298ca2b610c71e74b76d032616fe2cbaf5
* git describe: v6.6.101-263-g7ec7f0298ca2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
01-263-g7ec7f0298ca2

## Test Regressions (compared to v6.6.100-77-g1a25720a319a)

## Metric Regressions (compared to v6.6.100-77-g1a25720a319a)

## Test Fixes (compared to v6.6.100-77-g1a25720a319a)

## Metric Fixes (compared to v6.6.100-77-g1a25720a319a)

## Test result summary
total: 279827, pass: 261488, fail: 5549, skip: 12412, xfail: 378

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

