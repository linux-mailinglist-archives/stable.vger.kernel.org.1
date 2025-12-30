Return-Path: <stable+bounces-204232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4035CEA0CB
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32716301BEB1
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2C2FD673;
	Tue, 30 Dec 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBzIJNR1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D080269D18
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108085; cv=none; b=m5PARMmKzxUpCfEPb7K6Y/v6d6UolfxJZRH7UznapUZDZxk2DFy+iChSjaqTl9VmIFKhflwXo0Hw0qDFhEpiMa2a/Z19RHUS1hFUnBKvYqamlCZOng6U/JFrp61qDRKGnVGzZe05QTrcdtDfMrKtEU9+358wPZccVu+aDIKeuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108085; c=relaxed/simple;
	bh=nOgn9zgIxNV3+tec//KvqOEEc7pfkKxwJfai4hakGuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOO1d5Shi7y1MenhT5S80TZvGuWTrOrkHKfJMcQ06tCCPJNuHyKL+9rEOr0qkbK8c5z5eQHcbLiuwR7yUl78PIKu47eU8ttufZCOEBYAHopDz5fY2KbPeEdoi7vv+ybXS9rc9S1vk7PK+by7qUPOO3GOghEis/7Puzi0ovc9h+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBzIJNR1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so7751032a91.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108081; x=1767712881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH1EUHrGlfr/nAjb3VFlEXAHnNoURt3tL1CKf3VoEH4=;
        b=EBzIJNR1u3k7awPxtwK+CnQsZ2MV1d6TthiECgT2CUwB+DOsNQ4mOtC2LjEYX6q7AK
         TzALMOcND+P1Jlqj+sYqotvDckznTYgYtz8Dgmx84QoLWj2E11jnoEymgae7daMr97eL
         kvdLk6PKPn3VRl9YRn7fupAdMwG9A+ZFwpkcM/oUdsHw5UTaiTGSayy41IeDkASV8tCs
         NpyL5tWW4JSkJ+dSsYXZYZx0QrKg3GbuHVZDOMVdk1MlHnOTULdD9kgiMM+qYRURCDHC
         0MrhvpVO4uNGAPJGnjG48qnpD1fhAmNk9fMiGw3Fk0/U5ipSm+v45A5ENaGUz3Y9aaOI
         fC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108081; x=1767712881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sH1EUHrGlfr/nAjb3VFlEXAHnNoURt3tL1CKf3VoEH4=;
        b=BTsdUvtepqypjwgNoy94TIj6muIE9GCHqBNm6S0u+UFusMj8pyTPuNwnmtXETPLrGs
         d0/Zw3honU20Yk0KDzy7VgJeAHPQ9r0AmsPHe83WQJ8c7pQXXLiiCLGzHaduZ9bmykw1
         anACl23BsO7erFfSnPVTYsn0iDL54LApEJ4Sbkj5QRTHwIwk9c+BxWmRZ0T38ISJ0SS9
         mpx4bN/XPCkDnh3AaY1VN3ibAkVqMlzs9/l2fHyTKTTDbq1kzsaivJsVB2P3ohCdRT3P
         iLoKsU+c50I3cgv4EqfZRiJMEKiaLisWFPeLRUwARg9JvN5Rs6+knGlopZxZU2/hpqyv
         zt0A==
X-Forwarded-Encrypted: i=1; AJvYcCVeN+elvJdqIi2WYedds10q0gbTQ7nL9ldVX+Ayt7SMZ6Q9FlbiLMsle/Jt4oEqv9auB/2jn+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/bFeEbHynITg44bRm9UUtApqV0FHlb8w//bW510QLdODbn0ER
	TnfccPmImEAdJLWQUnqHsQR+ViUiXJEkOgcf20k6aXO/YB/efj+ZJsoj4+TFrfwsdaI=
X-Gm-Gg: AY/fxX7twIWox/Vx4eoF7t424EHSli8jgooPCs2dPE8BFXbpe8YGO6dmDZ57q4gFWkd
	+LeGr4U9BXaAVAyyb6RaCUozexBcEHr1FbzsF9Q1vkBNgiE2bXCqRCDJUJZi+e64QAYtyxfpCCw
	rjMRLNBPWcMd7U5stHdeJzn7WLp0lj65GcdmqvImy8qCsTuEM+TyIf9rWlpuzlo9efeKdX+oXaQ
	RPKdlOQqcnaauCZsW+x3spsirQLcpNUKcyByCRFNb+pdG6F6x3W1qDVSBklvZ+Keko00BAQdG6F
	9u85lop8YhvfH4TJq3kisQu9ZmZzXmPcOYDd+CdsgLQCkTG6wD6Ebct1vYpo2/wYxtY1Ra6ikcb
	5QTANlNaBqk2u7e4frq+hCHfhTadkg9zJk72Gk9rNSoNR/jgNOi2Sb2mAQ4z4eQhBkhq7plBDaL
	26u3tWxD7miUduiBgL2g==
X-Google-Smtp-Source: AGHT+IFrb+KXpf4nELheJV2i1itf2OZyMWPkGLgWEtUs9og/Vd4m2h29NT+CW7dlqJJtLnTd06XEJA==
X-Received: by 2002:a17:90b:3d4b:b0:34c:97ea:e4d with SMTP id 98e67ed59e1d1-34e921df30cmr27258260a91.28.1767108081468;
        Tue, 30 Dec 2025 07:21:21 -0800 (PST)
Received: from localhost ([2405:201:c00c:2854:dbd9:82dd:f61c:42f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70ddf58dsm33285781a91.17.2025.12.30.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 07:21:20 -0800 (PST)
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
Subject: [PATCH 6.18 000/430] 6.18.3-rc1 review
Date: Tue, 30 Dec 2025 20:51:03 +0530
Message-ID: <20251230152108.35370-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 at 21:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Dec 2025 16:06:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.18.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 685a8a2ad6494bf0b31b9421d98414225146b792
* git describe: v6.18.2-431-g685a8a2ad649
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.18.y/build/v6.18.2-431-g685a8a2ad649

## Test Regressions (compared to v6.18-645-g103c79e44ce7)

## Metric Regressions (compared to v6.18-645-g103c79e44ce7)

## Test Fixes (compared to v6.18-645-g103c79e44ce7)

## Metric Fixes (compared to v6.18-645-g103c79e44ce7)

## Test result summary
total: 136451, pass: 113600, fail: 4155, skip: 18696, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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

