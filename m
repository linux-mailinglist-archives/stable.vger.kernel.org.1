Return-Path: <stable+bounces-123176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D4A5BD08
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC621898BFF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE6231A5F;
	Tue, 11 Mar 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLi5tZwW"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEB22B8D9
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687187; cv=none; b=jx0UjLYO0UI0frRL2pYhoKq/HfrrFuvr7AgBVqOmNEBoeBJu9F8U0UyQppaEjy5biR5fdeiubkpoBk5pCUO5Wm3TC2/3fTWVBPMK4VwY5U6SK7Rthhdg0ILya4gCOjEHyc89tQXlGW5UtJ4U7yJ1oUtu6vHoijOrFsDAtyLk+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687187; c=relaxed/simple;
	bh=J6C8/Z6Xx8/zFFOEjzG8rTwrunoZ1TZVpwoUTteC8vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlP1IFRnG83qXjnqfMgFyXTlif7S0DFqZR5LlqbAVjLltj21SkvTlhN1+McD3fjFBITElRy+aiNpEpBmH9tXT6m4D4bsyS8szF6Hgj1DYs+DpYL/fBAgP8lcchoLZGRxUX3BKh6qeO+WBud1pAyNJxIZqSmxPxuwfme1Eww9z6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLi5tZwW; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so1671904e0c.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741687183; x=1742291983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgHHBhkd8eGrFbDvShJ9s51yYCl4gvLMZWScZVFv3YY=;
        b=KLi5tZwWKpK9DepepfEUUNBlNZnBK113ZGEcIp5STtzZjA+Sy6G6LjRZAb/doqeVYD
         dbT7cNOIu4VW4GqOBx8m9CUdJl8Z32rFIgxaO2oTGdsQ/QUQU1eA1NosxEpw3RAep20x
         ivawIVQQPOYN/YzU8SjBwzLVWuBvwzAMmMXXZh3MRjO5qrrief/wUAhZ+W6x6vXxz3xR
         74T7yfFVLnwtsuPaAC5sybp5I5z9ZtYd2N23RT9WfAIdgKtbn3noJOVYJeIYdCzPVq7W
         U0GaK5f8ibFzxYucFAB9++vfQkaVDeJ819p5CWrcYodNajyB2i72HNSTRoyrl0NzxxSE
         0BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687183; x=1742291983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgHHBhkd8eGrFbDvShJ9s51yYCl4gvLMZWScZVFv3YY=;
        b=LaYdMCQe4py7syOi18tHcpRULPVCgETxEriioNgvjgXhM+sR8LtViFz+EsM+CMYDiS
         C8PGW8VvBAkL9cWa/1C9+JgNyRydKkRASI3WaH8WtRSsx2GTn0AMMPPG39kADmXUi8RQ
         3aNk0feVuld9Da/pExikUoFVpjwujvLOwKHfR3bvVQARdcR2mUWVAr0fXlFtwcSrkRBN
         W3FNASI2fgG2UNFOvDncDDp4BKU3OesqsnIvE2aYB2ApFnlgYzddtQDiLmqCQC3JVFOW
         /Ip4pH2z+Pe12vDkpaAkB8adWXTBKsF37O1XPonZF9sqKvz2SvRBc+iQkRY6wCFsxmx3
         tfnQ==
X-Gm-Message-State: AOJu0Yyd++AnNwKCA/Vr5ubt2XQ3udAr4/ob5bUsSlUf76cOut4hJJeT
	NTMYNDDGF8dosXehkgF2eOr6NvL6D5Vz5wsCzCauyqc+fw4qOu8jAi+tXkKP9ZMYs8gk57OBzRj
	P+1+W20wdmTA9wYa1JgzXWfvWgheJGsq6GradR2uOMGT41ROhoeo=
X-Gm-Gg: ASbGnctMPiJSX2hooruhf4YnTbDcf8D4WLfU1gWkDQzHjwT28R6I0shjkQKk1hc7Xu4
	q+IzmHa/eo+9Bo0/B9HqLQmG+NEuQ8tBbcu9OCe5m7+xHtJ0L5LRN0Rd0OsUQM6DPHH3X2c+JBz
	R33VgdwRqKUR8KDvF6pgOtTgdr3MighuRetQJ4+uEjovOENi1jmHZZgI9BpQ==
X-Google-Smtp-Source: AGHT+IEW83Xnyj3HCDdDUXd2rQkKJnkka7mSV0uybfERQkgxMEzczr5vd28/ptt47EuXiJbo0OiVMm7z6oH6+1A7haw=
X-Received: by 2002:a05:6102:54a3:b0:4c1:875e:2215 with SMTP id
 ada2fe7eead31-4c30a534d15mr10077749137.1.1741687182836; Tue, 11 Mar 2025
 02:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170427.529761261@linuxfoundation.org>
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 15:29:31 +0530
X-Gm-Features: AQ5f1JqYM1OaGivq8FkIREmdHHUgpx2t5idwxKUVtIfiFKEINVp-cx4s8kAVB-M
Message-ID: <CA+G9fYtqPxzb==RHUbxfDuiABnJxC5pBRzGR0JKQF1voxRpqKA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
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

On Mon, 10 Mar 2025 at 23:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.131-rc1.gz
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
* kernel: 6.1.131-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 5ccfb4c1075fee3b843050158af9660c9489f04a
* git describe: v6.1.130-110-g5ccfb4c1075f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
30-110-g5ccfb4c1075f

## Test Regressions (compared to v6.1.128-732-g029e90ee47c2)

## Metric Regressions (compared to v6.1.128-732-g029e90ee47c2)

## Test Fixes (compared to v6.1.128-732-g029e90ee47c2)

## Metric Fixes (compared to v6.1.128-732-g029e90ee47c2)

## Test result summary
total: 72879, pass: 56029, fail: 3089, skip: 13542, xfail: 219

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

