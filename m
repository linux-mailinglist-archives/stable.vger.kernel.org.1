Return-Path: <stable+bounces-202734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED54CC50AC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 20:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6AA5301E197
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A156432C95A;
	Tue, 16 Dec 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja8s2KLI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FD145B16
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914784; cv=none; b=nwxewV0QAR6oPEG6VvgiPOrDSajGwvF78Y/AcMiXB+FcaJNnCF8SO7Dz3Pj1TBB0UnB0PvrDeAkYRJpoZc0vFo6qoLz/At75hzD3Ep7GwsGRECdfZmiyfYFohJ2vumeL4n/hNv66ODBm7E5JPxKSHrScMSyk7MnEdlF9wfR5Rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914784; c=relaxed/simple;
	bh=iyfpfta9T3ygezPPDfJaAAlV1FmCLLJlERf9Bqj3wl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZV+1PCC45JgIY0KEn0OGjpAkr/aqWjM8lVZ6pepg5ULUZcWJxr/EF7CWn+Kcgdsp66J/Z5QlWlfEuUUKAM1Jb5oCR598THdxvqGHRjYnflpj/kDDMZxvgrczTRR51i1tfK9TZtJObvX3xQEXJrtjbLMAV0wNaDQP5H0Eq9AxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ja8s2KLI; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a081c163b0so37307705ad.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765914782; x=1766519582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMv6aJNeWeKxyQePqdx7Y+0/5WaZPbWRmp5WC5tFCto=;
        b=Ja8s2KLIa/kJn2VJ21n1wuUYtvYomLIVCQwznAxKxocZJmhr4VbErQ+9wo0CZi7yov
         svl9n64/JIEMR43vBXUXaiiZFt9lE+rfiJLDx+iOj88P/9Jv0ZuviyYCT5jluoO2a/MO
         y1g1gOkAbtGMvtxbpL9vXSCb6wcHZQiOHFBdeWnKogqODXiMrq7mo3in7IGxFK1Nk1HQ
         YQeUrSi4SzKXuta4rN1wCsSndS8ZxbM/nIDiZ1iH5wtx2MI6cj+oLq7tuPoL8s/gTnQM
         rByDCr20PHDMSY8nKk+WKCpBgScoNja8QQ187e4BiPO1S5LMmgBwjvHBdR0FaIpxS1YK
         EH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914782; x=1766519582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMv6aJNeWeKxyQePqdx7Y+0/5WaZPbWRmp5WC5tFCto=;
        b=JNSnO98Fk5QMPQ0a3CQbS+b3tC+G66hHAGblChA1e7aNNlc+MusEEnyLfexviFeSgy
         2FxX06QzbmoW5t1HYXLHhovFGdinC/xJS2A14GFSAj07sGi3O5BFKYsCjSieobQ8rBix
         aFPHUKc5SrixSgtNl2Mn7cCZgqbntE7jeV+5UUw7IFlLU+zKzZIpcmWTkC6PnpInJrWM
         npWSHfZza8yPkN/WnQm/0oR6X3w0XsWV7k24Lkd3QdbVEkOfIwC4Su/XqPkCkXhVrXWM
         FNgD4BlDLEhY0mo03LBkXbfLED+ys3DW9ojFvddZnXYLTK9adcSkUbU7oXpmkL9clxUG
         5LWw==
X-Forwarded-Encrypted: i=1; AJvYcCURYg+0jPUo1FVjvEQegnUDJ7s3xp6Hgb0x397XMghpd1eSoJKF6bdI6m2/DOGqfNA9rlxxcJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZs37FIpa/9ZXXhLx+XA2DL1tZM1ItZvvWcSGI9NGakYn/He92
	IvwjokYm4nXJqy27GOZPLot3iacIzO+PjCkpQTTpkzZvNO+HhCH5/78yATMgUS+ZWWo=
X-Gm-Gg: AY/fxX7VeN0jO96cb9G2AgEfLdn4scM+1kOb4pPYJD7mPG9lOMnDp7YhEzIHDWMVVcw
	aj7oWy5hlcFnrUDjzPWqGqYB2sdpsM/DTYWJwYEFQDtrW6jC00E9AmkLLzQ2NG/IH72HYYA/BO5
	B6FPDWTrwExlGi1+GFvxnaVpf7Jy2XSnbmy8iqciFbO0ZczGG1ACbN2ZLp5xkA5lsNzsqGpQvKp
	4WK+IqZJMnw9FGYiIW4uCvzyc/jUI88YztzotaAB6/RoJt2uba3EcxZi9Ty42IOD4J9a9df3wO/
	t+JkVXQFkLQAqJ7n98SkQg29cJsSXB/+ZpIs7/0AUYxbkqqQMt5+LBu7NTplNez2YYAVCPZz31S
	3xQr9SrtZQ4ardQQL8MALGA+t0n8XfuyMGfq0qet1+CSxngJ+0HxNnbegr5Uc/tTxPTx8nnIHWa
	mF2RlCxy6Doon8KL9YGLCQ0cSO7T8D
X-Google-Smtp-Source: AGHT+IFa53l16N+qvvGO5QmppAyhTeWx1VKPEgvjQDDUEOhJfhKgosxMkNqOmyEm3dPYC+8Wd+jHsQ==
X-Received: by 2002:a17:903:8cc:b0:297:f0a8:e84c with SMTP id d9443c01a7336-29f24386514mr158443655ad.52.1765914782008;
        Tue, 16 Dec 2025 11:53:02 -0800 (PST)
Received: from localhost ([2405:201:c00c:2854:178f:356c:b77b:cfc2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a13825b9a5sm33850025ad.9.2025.12.16.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:53:01 -0800 (PST)
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
	dan.carpenter@linaro.org,
	nathan@kernel.org,
	llvm@lists.linux.dev,
	perex@perex.cz,
	lgirdwood@gmail.com,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 6.18 000/614] 6.18.2-rc1 review
Date: Wed, 17 Dec 2025 01:22:55 +0530
Message-ID: <20251216195255.172999-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm seeing the following allmodconfig and allyesconfig build
failures on arm, arm64, riscv and x86_64.

## Build error
sound/soc/codecs/nau8325.c:430:13: error: variable 'n2_max' is uninitialized when used here [-Werror,-Wuninitialized]
  430 |                 *n2_sel = n2_max;
      |                           ^~~~~~
sound/soc/codecs/nau8325.c:389:52: note: initialize the variable 'n2_max' to silence this warning
  389 |         int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
      |                                                           ^
      |                                                            = 0
sound/soc/codecs/nau8325.c:431:11: error: variable 'ratio_sel' is uninitialized when used here [-Werror,-Wuninitialized]
  431 |                 ratio = ratio_sel;
      |                         ^~~~~~~~~
sound/soc/codecs/nau8325.c:389:44: note: initialize the variable 'ratio_sel' to silence this warning
  389 |         int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
      |                                                   ^
      |                                                    = 0
2 errors generated.
make[6]: *** [scripts/Makefile.build:287: sound/soc/codecs/nau8325.o] Error 1

First seen on 6.18.2-rc1
Good: 6.18.1-rc1
Bad:  6.18.2-rc1

And these build regressions also seen on 6.17.13-rc2.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.18.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 103c79e44ce7c81882928abab98b96517a8bce88
* git describe: v6.18-645-g103c79e44ce7
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.18.y/build/v6.18-645-g103c79e44ce7

## Test Regressions (compared to v6.18-30-g7d4c06f4000f)
* Build,
- clang-21-allmodconfig
- clang-21-allyesconfig
- clang-nightly-allyesconfig

## Metric Regressions (compared to v6.18-30-g7d4c06f4000f)

## Test Fixes (compared to v6.18-30-g7d4c06f4000f)

## Metric Fixes (compared to v6.18-30-g7d4c06f4000f)

## Test result summary
total: 101371, pass: 83553, fail: 3486, skip: 14332, xfail: 0

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

