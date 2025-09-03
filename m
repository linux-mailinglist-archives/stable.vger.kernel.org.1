Return-Path: <stable+bounces-177597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E004B41A51
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33692562B70
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18342EDD5E;
	Wed,  3 Sep 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgHqXa1j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E322E8B85
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892656; cv=none; b=An1rXIz6ZXMmc546os6kK/QRCRQ4526vDXzPUSoDTlGD37crS2a7c+X7Uk3a/tIvEHBMicVJqTDA7AsWRe9E/T4oZTxTvWOCjiELXg7+cTRe5bzaBxsEmtZ5JZSnbTG3WSHTX1iNtuJ6uYCc+xxPL3AVzZzb5Y3b7Mch/hYhNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892656; c=relaxed/simple;
	bh=4DO31URqLOlIMCZRzxmllm/LEhaNDOtfIDJngVNU0gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mob3PL6M67zMvSoEOuSaeXNnvd+eu6eEm/5x/N5rvRtMtb67a07bjyXz9KCcPzkX7WE4QYReD63jcb+h8UGJ46LoID3Y+t9+4YrD/7PxMB93IHihV38LrexwPbS5a3v2MixxJypne5usZDlV+bt8KW4t9hfayK4sfmmYmF5sqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgHqXa1j; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so3106497a12.3
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756892654; x=1757497454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtzzda4QBQAaKKzF6sjShO0A4Pr/KXZhT9QV7iIvqZg=;
        b=lgHqXa1jx51lEQToyotxVi67zJk+zp45ZHXkDshRl2jLzdyZzNSR442oBCM2DBwoMX
         2S0L4msGoitbGsJe6CdSmbwJkByRo78NDT9jWaf2r/VJIHz92j4qN8j6dbZJGG5yZEd7
         haDRHdNPnpKME4i+/t7VPb0LO6e9Z1NK38ux+qe14Ey5sTpOrd7IS+7b8ZBplayPdyeU
         nNIKzpXk3BUQvvAASUajCVW7GOoRHDm+HmcKWyy5q9UBA9cpuvBKtiq+4nPBqsNsD8ou
         AMtZJtfscrkCwJTWFZs6EX11m8wL+Vp8me7Gou2f0rveMf3ho4ItbcyaU9wmpzxwmBEa
         OLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892654; x=1757497454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtzzda4QBQAaKKzF6sjShO0A4Pr/KXZhT9QV7iIvqZg=;
        b=FS8FNrihn+JHLrCAaaKCLV4CJSe+6NM7TxeqllVzdklkBH0EYF1CXKlYp968+Tp4zr
         nYASaaUgkrU/J2GRqf+FNkK6QxLprPrkzdInx1Mb5RfcFFB8GOTLBrfPJxEmo/hCF3Tu
         nVLxtvNOINjfOXEj3boWRVl6OrBX9++gHEubsDrdrLxxTy2Jf9mSvuNZFrfOjXUzbXXQ
         6Q2Z5OJDx2wjHHz5t6zcyHU23Q+baDca7WDmI6hDm0C2LwQTEI7eUxx7nr/aAgzHsfVM
         Q3XsJrSgL0nVYCi5lK/30A4DLDOm3i4gKZfXunFZDyoSyP/QgFqSfoG8T9Lp2zRmdjmB
         s+5A==
X-Gm-Message-State: AOJu0Yx6JNaCV64QDXguyiy6/eiJVt6UqHQFeOdeNX/L5uqZ/0JVkczE
	Ee/55NkjEZwAjiqMHwi9MG2m+HN5G+yo2rVLyr5nsZnT2/1Bf8qzsXG1J8/1vUceNX9a+NAKiQe
	sT1Mj6yIMbUv1FIusVoyCtujnnFOMc/3a+4Tk9rJUlg==
X-Gm-Gg: ASbGncupDpf6AbObLatD7WcY2oG2MMnhoTU8ORFNwNYWI1sRfR115Ai4H5UJlA5pl6d
	/cRHf5E9mnwlKAcYdEhNsV+EDxp/DvQF3etgEoYXHdKxE+sqCK/k6XAL3VbsC4oBPBG99NzKOmR
	laNMTrrftQ+eIlY9sK/cGaoZB84rdhOkNKVibn/GZVoiqW6spRY2jPszqVnyU1v3pSHieyXc33k
	Zj4STXzNf13VKBEkN48K8U1YcWXuhxYSFD0dBbqE7j2seuScDBvWNtXFMbwog==
X-Google-Smtp-Source: AGHT+IHi/AIip1Etp8O6tE2+9Jrulbj7mZegJyFHVes3qPLwUuW5JJbcwOl3A+MkyPFMk+GbxU0Nie6sEeU80s96Wm8=
X-Received: by 2002:a17:902:e88f:b0:248:e259:16ba with SMTP id
 d9443c01a7336-249448f9912mr160615025ad.4.1756892654045; Wed, 03 Sep 2025
 02:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131926.607219059@linuxfoundation.org>
In-Reply-To: <20250902131926.607219059@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 15:14:01 +0530
X-Gm-Features: Ac12FXxnehF-f0uX9uf1w98xh_zbbMgvqVVos902X4S572K02cR0LhUNbnaqGvg
Message-ID: <CA+G9fYvSa6TioRgDLT_KtYdWYLz4hUbNroVjg9KiBEe6niDr1g@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/34] 5.10.242-rc1 review
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

On Tue, 2 Sept 2025 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.242 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.242-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.242-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4576ee67df7a1a73a4ec410a6c8fba6afd0238a3
* git describe: v5.10.241-35-g4576ee67df7a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.241-35-g4576ee67df7a

## Test Regressions (compared to v5.10.240-524-gd8db2c8f2fff)

## Metric Regressions (compared to v5.10.240-524-gd8db2c8f2fff)

## Test Fixes (compared to v5.10.240-524-gd8db2c8f2fff)

## Metric Fixes (compared to v5.10.240-524-gd8db2c8f2fff)

## Test result summary
total: 38282, pass: 31263, fail: 1860, skip: 4969, xfail: 190

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 100 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
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

--
Linaro LKFT
https://lkft.linaro.org

