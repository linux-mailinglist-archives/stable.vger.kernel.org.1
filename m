Return-Path: <stable+bounces-144200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311CAB5B16
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296031B43849
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9102BF98F;
	Tue, 13 May 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPxQA2q0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AE2BF974
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156781; cv=none; b=d8PeXvFbPlOK/aCDvaaQqoOZhJuO+HU7alWxTPKn47lYnDIvNEWBBatH5Hf+b7QZJPaaYSLzq/9M2brnkbr13s1I1P+YTWlSpjOmYpWaY4fo4ODw2BYsyaS1IWPI8mOkY+s2Bh3Bcq0FrO0SuJksHfEj1+YCKcGzvIhO0tL9Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156781; c=relaxed/simple;
	bh=tKnzglOUbxjTqjNWOorvM7J2sUaowqzLBzWcmVegvcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY53hMqyk6z6JyWkk3zu3/yDwKUeU/o6o3ErzhXtvXsOj9anTnEKf3pWolspBUSJ6JUNO3BQhkfDau3C8eLY/NKQbzbgzK0LYHtvcND3bY0ACd4/paYmZQZY4IAMRnjJQrzYbfJ3dWX6bRfSR6DH2XJ4Q4wDS3Dhiv2EUbl1t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPxQA2q0; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8783d2bf386so1565074241.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747156777; x=1747761577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WVZtZgOj//5jxHTLtKRf8BjEquu6XdJr3DYNY96xG0=;
        b=MPxQA2q03Q2VsBf7q6hJduIJ5nzwQUCHnInYhHPk10PL1gyvR2W4QHdqL5cSLrcMXY
         kKidt2Zgya3hwokFtCkbp+mNRPMIh41F3S8IxlD7VXunJmcQoda+GC7yzTnqZey8pm0I
         rz9uHJ1F08pw9eUHlSQSoSitJ+JCflLsTEES/k5N0/NxmwCmWbSnuwyBUYwJFiWOm5SX
         R4PFFkITnmKwByIdRjyrYCUasn+oIYmqCt13mdOdkUPXfmvhS4GlG4v8CJc64GsG5MSB
         IoxosEZ8R8ErwEhiEhAL2g78EVBOHVomjZLvETHFUnUlS8rCu1+y6/LFT2+0+MvYhsMv
         pyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156777; x=1747761577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WVZtZgOj//5jxHTLtKRf8BjEquu6XdJr3DYNY96xG0=;
        b=vnCP6itRWt9GqanNiAVwMemMzxuEWN45/OkorWPsHSp1pzdv1Lv0qa8SC7Ev/3tx3+
         LEXmNoY/abyPEi8r/v+hfvfRg65Bfrrod2h4vFvG+6pNMy5gvj4VPggpnBfoN9X8JZie
         zPGST+xdNOFdqIEqrBl/XQHYQkm0tbQ2WnudofH8e3FGgrDJzczb8nog68Z2Ot1S2MFG
         cRExaBow5I9y6kaZxgfG4ZSMVzdaIlmcRFKZ56UuvES5qhClHsdJPgdausM8M8DEc9P/
         VBHytq38LRaRgP6L3FJk8gXT7SlescmwGZgYOka4fn0BhAvUxR/64dxyvsC47wYzt0zq
         XeeQ==
X-Gm-Message-State: AOJu0Yx+oStMaqw9xXOJKW5ro92wS283inr95F3y8xeWyuEnljCgMU7b
	hclmegXTasu0OnxeYe7NcuBe/00qwZEzTjPE6yGLy6NEBhlGCRD9kbYf2y1Ra0enKGdNqF3jLpE
	JcsPmzKEvDHo7M+dcuacmyTl9cak426Ugq2CKeA==
X-Gm-Gg: ASbGncttKE0xfAXuI8rHm3s6JCzPVcbrNV1PTEvICupfxv8cCA0aadwuCblhAidvOdT
	2UsBRa4OpqiETsRt6ds9j7Htv6tRvwHntrahLqOl60p7Ll0WNTDEtHun+gc6BTUx2pVzDYGyebf
	Q/W6o26/YQ74pwLrE6FN4HGCFvSrn/Svw=
X-Google-Smtp-Source: AGHT+IE7SVN4f0UtH0PQNtPFy8g588fN+A85zd+IU9uAeKM1aPz2rmVoENJpTwIiBwisipoYFwbTKfFOf1DxGMVshD8=
X-Received: by 2002:a05:6102:3e1f:b0:4c3:3eb:e84d with SMTP id
 ada2fe7eead31-4df7dda5483mr356685137.21.1747156777441; Tue, 13 May 2025
 10:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172023.126467649@linuxfoundation.org>
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 May 2025 18:19:23 +0100
X-Gm-Features: AX0GCFu7eFv6DmFvFsrCDFVNU1cnMtQjsu-NkieuGgoCmhh6HwuDGcVt7BF5brk
Message-ID: <CA+G9fYu=z3Bf9zUTjUPWdSpjehsqKmxwH4=Xtjz8BHKTdcvYYw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
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

On Mon, 12 May 2025 at 18:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.139-rc1.gz
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
* kernel: 6.1.139-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 490c91e6621e9ec53a2bd0cced0bd27018fe8597
* git describe: v6.1.138-93-g490c91e6621e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
38-93-g490c91e6621e

## Test Regressions (compared to v6.1.136-100-g7b2996f52bc8)

## Metric Regressions (compared to v6.1.136-100-g7b2996f52bc8)

## Test Fixes (compared to v6.1.136-100-g7b2996f52bc8)

## Metric Fixes (compared to v6.1.136-100-g7b2996f52bc8)

## Test result summary
total: 91883, pass: 73707, fail: 3346, skip: 14630, xfail: 200

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 25 total, 19 passed, 6 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 31 passed, 2 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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

--
Linaro LKFT
https://lkft.linaro.org

