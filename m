Return-Path: <stable+bounces-202851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97971CC8509
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8983067304
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688439654A;
	Wed, 17 Dec 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRGwPIQM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86D3930CA
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980488; cv=none; b=DI5MdnFKQRbrGnCD4bPXvXWvR4DAh8B89mM7uG+oVkl7hviHEbvR8r4DmKGrylXpzaFKCHWQv8XW41KWAFk1BuDjepaJjxm+l4wYMZ7pmuhcOmSFm8r5CY7qwevhqirVnDeCRo60dmJFHxmRaJVArSgNFsuE8uJfIh5W6b7tnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980488; c=relaxed/simple;
	bh=MBFms3xM2UNaO/eWDUaG5chC4ET5pBUs323KdSf510I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HixoIKlSaskDrbcx1YjSooihMT/Gv5h3Nw9PJwmbxV9NwFPr7nTUEPz95qgRUywlCwTHyO0/ylR8wXHitl/l4SgDiRUgkW1xri2FVoYE3ZlRH3aTLMBv+pWueGTpblT8VMt7HMUtqENLTrF11tSClKAZRil1Tl4MysnbHTCb2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRGwPIQM; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7f651586be1so316276b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 06:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765980486; x=1766585286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac+iHzN15MmHfh4/SEKIGJf2kaLnC6yP7tGfqO6xAZQ=;
        b=SRGwPIQM7kvxpVA7YWmRyfjlnikt9zXAEr0euRXrTQtP9cHmzA2ABwib1dmWGuYyXB
         IpwZXGcJvs7ORVPF3jET+MFzruDKCXfXp1c1UoPxV4sS8Fc8EJglYMS6ZdIaboz7WdhG
         pyktDRqvD9Q8YRYn9cbYPierQyDsarRMUA3bpJ3O0qd+PcrbKtQ020mmiLtKUfPH6VCP
         G0ey8DPo16AJGcIW6L6c/lkR3Zhc9SmUbLAwzJ4uvpXR7eTF6A4bMphZJ9fVQMLwU5m3
         vFWJ2TjXet2iCNfYZsfkvlNDSRQSzwY9xNfUvDKJT9PW7HmuaKltxllwNBh4Vg2mg/LR
         Ktug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980486; x=1766585286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ac+iHzN15MmHfh4/SEKIGJf2kaLnC6yP7tGfqO6xAZQ=;
        b=ooLYQvwO7+ts84KWtb28aeHz4+bjHROp0EyogptyUIhEgkJKd+LF5u2+0QYthQhAGw
         nmu2ifGxPe1GV3p8ZQZiNkmQ80pELH7H784pXCnMwwOxEM/yAr/uynzUN/FkZ73iTwZS
         C8PT4y88UpzHEXXNZvBQu7KG71JpEi/RBEsnefLqeFKpZRf/kQbrzzvdq8V90YugUNOX
         HasCv/FD++BFhYEgA1HVyTJCbygp+0fucvVoEbOiF5BqfmWu0oTY9LRXuRhZD8/AQHvK
         uGMe3T5OF9Whhv6/cWEnciQDAevT+B+DMfZZ1Jo0MEhcbVK/EkBH3b7kNFjdlgLjr1sR
         1IEw==
X-Forwarded-Encrypted: i=1; AJvYcCU45uHN24J8PxfQEC0xh2Glr1vsItCLkOkTzLhpuSOA3exZioToL5Xslq+2ZUiQzQAChp9XYG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx315QWE4rmM2ofSbFWlM2G1PNXPHHjh+hiW666dBmuwoMMRql8
	CZ1phvftICOYB4zDtSgH1NEI6eqzVgEFQ7tNF1tbKYxylNb2kB4R7TZhTqKpekaSivQ=
X-Gm-Gg: AY/fxX5JVtbRl3XxZqzWR0s46NLUMzf+rcLzejG9TqvbPcU1MGLh/KsXD3cOAj9/mNb
	7e9oHpkeL3Uq1BHH4XDD1btY6FPWBd2Z/Xs/4ZzEQOOrhPuHupV22Mb6yPjfH1UQd3+dYD/BSHH
	BEa4P81hlw/JSmXmhh1L7QsE8V6e74RJ/YmTaSDjAr2dzHc2R3dCat72HcxodPnrnViwntezzWA
	iwQiAhlc5VXfCZODf7bnusjdaJBwPHtv29lodWDVIYzI0Y8maAnVNnO+EYhkS86Ggzanz00XhBV
	Fy87lj4zn7WdYvS0bkc9dYP/Y/sswnUbTQ5xuGtvqN+yg8+srkA2oxcw6HGqJkIUE8veo0KK+dX
	RyVFIpU/RS/z97Ln30gdWIbdIBVRWcuD6tlEWeeUk5XiCNMEoPANN2NyKrwu/t8J9t3zyhuYqtv
	2LNuo3MzcsKOQabhI3
X-Google-Smtp-Source: AGHT+IGTUaCBmzAyvEvAdKj0QT8f22yK+WILp4fpU1FCaukHTnwGZaAIgHjLIEeFAPnPZPXUMrtCeg==
X-Received: by 2002:a05:6a00:6595:b0:7f6:e71f:c6a5 with SMTP id d2e1a72fcca58-7f6e71fd1b5mr12162298b3a.0.1765980486224;
        Wed, 17 Dec 2025 06:08:06 -0800 (PST)
Received: from localhost ([2405:201:c00c:2854:ecba:10b1:66e4:448])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbb6fa6e9sm2887629b3a.48.2025.12.17.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:08:05 -0800 (PST)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 6.17 000/506] 6.17.13-rc2 review
Date: Wed, 17 Dec 2025 19:38:01 +0530
Message-ID: <20251217140801.440784-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
References: <20251216111947.723989795@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 at 18:09, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.13 release.
> There are 506 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:18:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The clang-21 allyesconfig builds failed on arm, arm64, riscv and x86_64
as it was reported on the 6.18.2-rc1 and 6.12.63-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.13-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f89c72a532b507111acfe1b83ff4855dc6772043
* git describe: v6.17.10-715-gf89c72a532b5
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17.10-715-gf89c72a532b5

## Test Regressions (compared to v6.17.10-147-gc434a9350a1d)
* arm, arm64, riscv, x86_64, build
  - clang-21-allmodconfig
  - clang-21-allyesconfig
  - clang-nightly-allyesconfig

## Metric Regressions (compared to v6.17.10-147-gc434a9350a1d)

## Test Fixes (compared to v6.17.10-147-gc434a9350a1d)

## Metric Fixes (compared to v6.17.10-147-gc434a9350a1d)

## Test result summary
total: 108080, pass: 90577, fail: 4070, skip: 13433, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

