Return-Path: <stable+bounces-118397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2EA3D45E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920C0189AE56
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807B1B87EE;
	Thu, 20 Feb 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEDp4uJ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6641ADC93
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043006; cv=none; b=hbQLsQFCBCWfcYtN/c4FX+Nh/pjtk44EL7K2SBgnCsbo7aVRDQ/cTiCyTy4oKfNM3i0T8XJV28S0b4pc25PdXGwFBgA5L39hw0JIX+RQRpejVTrGBOJknZwQska6cfSVXGi/jOSCp29HxiUeIi8SaOJ9IQiX8cAEN+ZdManzc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043006; c=relaxed/simple;
	bh=GiVby10/n5I0HseZQxln2jZFII0SHsV7bW6nsEeMO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0SHf1JGOXVV9dUjCfOmukKa3SxsUWZuxITb0/lIxNr9iDhfMihFx5LoUeuWret93oRrRbEf20AP/PllQfuG3qhNnOG66EhLhN7wXdXf4ecsok9qhZ5da5bbw4fnoheh686ru9v3Lnq/EUyj0hAS1VURrnqbfm7ez2jDqk2QAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEDp4uJ3; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-869440f201eso398014241.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 01:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740043003; x=1740647803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Hs1uVDCX7uer7df81v2kpXaM9YWnPM+ecXbZIv9js=;
        b=GEDp4uJ3vXUYymbTOfrztVUKCpRPQn+zFpGGGFV4F3HPGMC2wI3MGchSJGcCp0VkDm
         G7hedL5/rqNb85k2D93jBWj/nj0w/U2WB6PHkFXgI5BXAlsp8KIdp5IZXvM9a7P466IP
         XecpkteTvZhTaU5de++zpFujaB16EiKVr//RD8hk+C0xNWRKvPkXHNC6FF1F3wXkns/U
         OGFuDjUYvlkPXvAlgSbp9yremyrDZiUdlIEuC8OTJWsiy00kzePVZGUesITgsHbm1hsR
         jUWMrjmKdAcA1xi3RsrPauoGcufTtSjKMOyMIJJFmVbVljHNyF7OBSC86tzcQ+bV2uPK
         qJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043003; x=1740647803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1Hs1uVDCX7uer7df81v2kpXaM9YWnPM+ecXbZIv9js=;
        b=HDNS64sjScQh8cD7cAZlGJbkob8cPZW7FRhq6fMS6VkjsdbJuVSc0c37OV9bRxB3a9
         3VDXQkbzQJ2FTzWSarDU5ksR7Wj5D+WGQ9kXPHRKkXmwGn4JmN0y5g+aGn4zzSsU/lpb
         +oTGYMcrIcOfM/n5EOWS/fuL+wea7X9MEpV1Fx6hjQDH3uZwf64VnBxrscDhoRdNkHht
         IucBBmNRuiuqV+NtK1FZig3/Ls9Pubmx0BBUq45IDd7Mrz417K1eu8FOAyrWO7R29TAf
         JWLXUWEQNwjsZ5xN0YoA7RhasvXZMX/S+Ayp/NLpZffFFLbiqHgiv+wc1o9jzOuQIfdL
         70Pw==
X-Gm-Message-State: AOJu0YxI0C37Aee1mFeGw/vOnWwSpQo3nGN5PmEMcQBc/3HLZ8pHsW7+
	c5RADSpv1NeqHjDhfNdoNFX++4yvhHoqEBFZrsmY7yEXoHUSZ/7Om+VbEqB+1pQkImunDXKrv+Q
	f4rCpd5nhfD5r33wC1dnqnFZul7VME3X2BCx/RQ==
X-Gm-Gg: ASbGnct/2oC0u+YA/8j2NVXbhsePK9iht5BoBL4+F/sAxsJfCXBF+GCkjyws2aDFxIX
	6XcXi8NzQ5jwXsgDMnRTrACv6bS/FySuMqvNa3qnOFlU0grAhm06D8/ilLE43XzwfwwyrrtflwU
	Q=
X-Google-Smtp-Source: AGHT+IHN51X9i9ID69Sau6EJlrF3CZlU38cZaUyFXTMyP5JUk5iZqcTT4IRs8ij0yVhX/uZt7PciZ4+Br0p/8WTkVEI=
X-Received: by 2002:a05:6102:d8e:b0:4bb:dfd8:4175 with SMTP id
 ada2fe7eead31-4bd3fe4661bmr12751371137.19.1740043003403; Thu, 20 Feb 2025
 01:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082652.891560343@linuxfoundation.org>
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 14:46:32 +0530
X-Gm-Features: AWEUYZm0xgvwBNk_J2j7sQxJRc3ijLg_s_ZqF9tKim_dp149oEQ08mclS7LaPr0
Message-ID: <CA+G9fYtxS_kC06uE9koOUjJQYOeoMtBHkkGdVC6oHGgW4pzCKQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/578] 6.1.129-rc1 review
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

On Wed, 19 Feb 2025 at 14:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 578 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.129-rc1.gz
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
* kernel: 6.1.129-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a377a8af64e7b08203073eef8cb7633b9c1b9af0
* git describe: v6.1.128-579-ga377a8af64e7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-579-ga377a8af64e7

## Test Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Metric Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Test Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Metric Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Test result summary
total: 29597, pass: 22716, fail: 1253, skip: 5516, xfail: 112

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 20 total, 20 passed, 0 failed
* i386: 26 total, 22 passed, 4 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 31 total, 30 passed, 1 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
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
* ltp-crypto
* ltp-cve
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

