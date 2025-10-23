Return-Path: <stable+bounces-189069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A181CBFF751
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9D19A639C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52C26E146;
	Thu, 23 Oct 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZ8B1DBO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B0296BA8
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203263; cv=none; b=mFg/j8Mm0oje3ZhoiNoNdSqpLCpgT62/rIZWrDL9uVgHUb1Jn2bkEfBGTR5cgUvaUNiJBsvsL/NmqDUpiIzUamhhRswIvDO/9yoAIHImWHQhCyN7f0YV96DFpyBemTqEuoNcUYl5fsEh8wXiWiCRQT6NfOMgUNF1HpmubuZQl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203263; c=relaxed/simple;
	bh=/mxlwluWA5Lr00R11HzdOU6uUoGVTmh9rsH/zgvcFLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9guWTUoM55/eYLSIituxBftpXd2gR6GSIJplSx8DZM4FSz6SXW4TX+ee6d3olztDpFf06qxZSG+hC5sb4jSxld1zmPWysl7y1YTvBJi99uME11kcdK46pMrp6rwcZMzfbICnNQRsspWYZMIie7Jk8BIWuEkaLKFO6xtymR2ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZ8B1DBO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-292322d10feso4117605ad.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761203260; x=1761808060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DujqLCJmQFaZ3EINhri++XH5jZbl7g7hKcnWNYi4ETw=;
        b=aZ8B1DBOAlHSyfrKdKe+uoJzh1mPNWeTeBEORh6WOoYby4PYCDzC5K8jKypIxGdtBJ
         iRbaKchAgp76bNZbc2l/gZ1xaJwC55+Ie2FyfwoN7DT58hpPN56Kibp7Mi1RMtsMiBjg
         RozzfVpiZ/2MvO4TCUqzbzYTPhVpYJvdZzRc+ECGaNJLhGXgRiiqQzPk4F/W7vmFPjdS
         /SHJAg+UO8S58JQpPJIUI4wEyPDzFphEDFGlsMiMV2e/iP6iKPRDoWiTv+oy8UUpd98M
         dS35YYWsrNvtbOP+UMiURffB5PtHcJpi35xYfQtnxb74dcfn/1N/uMtJLNJCYE8Bk3Dy
         C6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203260; x=1761808060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DujqLCJmQFaZ3EINhri++XH5jZbl7g7hKcnWNYi4ETw=;
        b=S0VPTpqVb2FFMjtHckvhPzbUlPnDjROhVKyJaxazfVeOyrYX8uQTYCFh4ANVPNkbWx
         qt3pGR4SB/RLd2s2LCplyPwtoRX1p0GOwblfEuKS4oHX03tPhsctaIC406HQzQ3piivw
         hPIueL+dayMKaKC4k7+LPHvS7OW9FHPD8WhnrHrz3aSM4gNTG8ZEnF2ECLJQNI+WdByr
         ECisB9HT4tU8m0prtVdxHkk9kK33JdS1x4bhXjLVVQleN1Epjq82WN6HEnpqK7gSSwTm
         IsrxRPSUneFBJvelGwZ98CTAMOaXu1DxUzQ21PRuvpMa282FIRWKGs893GeZ99rizEhp
         ddvQ==
X-Gm-Message-State: AOJu0Yw8vGt3LSrXiUOeamwnNJChUj2TzWf0t+RvqAhbVPTcWBXqY24S
	wEJMMJFp/QaO7vYUIeUF3GLBAYO/7FcWy55sJS08/ABa5NCHLp2hbMcFRhV6KdEL4OCJytBfdpq
	kwoOhpKvAznqOveoSAM5EwZ/gfxaTAfFoi4hCUqBlSQ==
X-Gm-Gg: ASbGncvDClF4OofaiA4xtj2cp7xZizf2b0ji8b8nRoJg8OZTjI0MrVNKEqlMRMCAvTw
	K7LX3soiNWFZQZi4T/uh4SV4jduLOX5rDbShvS3PloTkqv6fPWBTeulOZ9ZQ5Z4JEdDlOyenAUR
	fbo00Sen6UHRikKUXmA4SEvvem2Rwku1LDJ00xsHhUDXHg3QcL5iOzjpccYPFqJ1OLzCmndRy48
	8vpzAlz53zG+2G7Bg8RYmBHzyJwNak1uF4W5mz8wQirNar20p9HBrXczSOq5L9VOx6ujAtjCBG3
	Ss3olkhFgGdBdacoyD8qTFldLQladYUhsCq1jYts7qfqtlnbpf1Fq4HgE55T
X-Google-Smtp-Source: AGHT+IEVKClhgjdibSHjHuDv8+MSTBfokXQUNOCuEMxiQ2XQOZxNtM5tq3eXuW0OJmRpgx0Z9SIU6xRbql+rNC5mX4A=
X-Received: by 2002:a17:902:dad2:b0:273:ef4c:60f3 with SMTP id
 d9443c01a7336-2935dff6634mr53232415ad.4.1761203260042; Thu, 23 Oct 2025
 00:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022053328.623411246@linuxfoundation.org>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 23 Oct 2025 12:37:26 +0530
X-Gm-Features: AWmQ_bnQgdRMRzTsDLfS-gzQlMvKL6tN130z4WBOHnPtYJNjnFWNDOL8porM-KQ
Message-ID: <CA+G9fYtMUKg8uW6zefPNCU8VnHFMEy8G7Tb_WxTp2Da7uuJtDg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 11:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3cc198d00990d2fccf1413a30fa9ecfa9a02d35d
* git describe: v6.17.4-161-g3cc198d00990
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.4-161-g3cc198d00990

## Test Regressions (compared to v6.17.3-372-g396c6daa5f57)

## Metric Regressions (compared to v6.17.3-372-g396c6daa5f57)

## Test Fixes (compared to v6.17.3-372-g396c6daa5f57)

## Metric Fixes (compared to v6.17.3-372-g396c6daa5f57)

## Test result summary
total: 129304, pass: 109260, fail: 4449, skip: 15595, xfail: 0

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

