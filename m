Return-Path: <stable+bounces-91907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BD9C18D0
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860FA1F25F32
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAC1E00AC;
	Fri,  8 Nov 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7ltxyM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04D1D356C
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056993; cv=none; b=mvjx0G88SUjP0+ND4FWCrXf3vZltykGiI+qEzYO8f7tdwEGdJtJih32S49MeguG6D3fGma2hlAQ6pF/3UU2agqCxfwpByU05dlFjQg9FpJqvhtYeuWTo1KUf62ad5CF0gupt1RY+ZQV6bqPMewbk3M0dqoPSKPLNRJp4/+7paQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056993; c=relaxed/simple;
	bh=6KyTu3O9fQfXvsz503x3Dgpd5/g0spE0Tog+jn1Fri4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGj2Bupu6XrFE4fYIiL4jcXweiEoSvmv/p4MHFTUJJ0fBI3Rg1Iq+MTea9IBv1Z57yjUSGQyL4BygE1MZhQE4iclPH2py0Ld2SunvceWVYx73dJKEkznOB2hkC/5ul/R8zh2VvuOpilFkkQFE2bbD9sLlCogNEQ0zMoRxyCV3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7ltxyM3; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fc0212a60so664873241.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731056991; x=1731661791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rCuCRkF0AD6qgQEhq9OgaioP0iDJV1z0RS47lWOzG0=;
        b=l7ltxyM3M8QCW50cpUsxb2IHedUM06c4saWr6EsRWefOuLNF/4SrW2H8+9U0Npn+Lr
         AV3xyIFCc2629sREL4sLOAID3OM1NVseXHTwZguDvKOGfu4ucGKkxKWzr3D/BFfu3ptr
         gTVrN7vZ7rlrts9IT09Dit7N/fKfeUS8WEZOu1XonnqVU7DtEad06JHP8dDohpQZeiXf
         xclYS+8qoLaA3fuQkBeUJuFed/YfDwtlwc3k8NCBzQQYlEfyjd5jZYRqInozVayC67WN
         21Lf+K6FQzAXjgTXAYKbV2I3dVcPxi8ykj33SG3YE4PrLb6uhUlgmCB0i8YnyI0rdEJk
         oOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056991; x=1731661791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rCuCRkF0AD6qgQEhq9OgaioP0iDJV1z0RS47lWOzG0=;
        b=Q+YPGFb90AxJbQsoe6IDidEa3cY3obVfpdm5hBAQmIqQ7j2vhAEioZySlWgQm8k+uG
         eYvNnDmlRT3WQzJOAH5iVWI8Ft6PcVop9p2VyZGeNf269W1kbFVhP/xnIysHfsOEvxR0
         gWEUMpgOVNzNepV32phfpldViFnyElOFREvJBviuI1svftBvdXkP//RIf7CRdLvIpBcD
         K+O/Ncrgu91p3q8D4OqDuf83XivN8PrrsIh9uziMhwtRBWxu4aQQs2UW5ElBPfKStAHy
         ve/QTpB4BGDi13NAauMMdxwDwVBLVtvmof3fFLFg+VcNLv81Y3Pxpj1APiXuOSVzFqU/
         SUJw==
X-Gm-Message-State: AOJu0YxBJXSdJglo51QteZ0dLQ5VnoCYRl5NLhn7Ff7DRAnxG7VkSts8
	4WVQyGTUrp4pGVpZVPJwji4o9wPRZuv2grGt2XX+r6h1iXYWuClOl+XPixras93SW/2xSFRxYDM
	DTJHL5tuT3+ZxX8QlggCVzn5WEZ4jUvuny0ZBnw==
X-Google-Smtp-Source: AGHT+IFQ2rzdsFULikcsy1DcIOj/oaXCux6Um5MzvHa4kWe+1hKya+Pibd3ha8YnWK2f1twBBu+uljiRcC195WGdV0g=
X-Received: by 2002:a05:6102:3f09:b0:4a4:8651:3c2c with SMTP id
 ada2fe7eead31-4aae1686ad9mr2324623137.20.1731056990954; Fri, 08 Nov 2024
 01:09:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120303.135636370@linuxfoundation.org>
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Nov 2024 09:09:38 +0000
Message-ID: <CA+G9fYvi8fy2muefm9GbpO806oTSBQjmoEQriWD0OyKU4s_K+Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/110] 5.10.229-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 12:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.229 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.229-rc1.gz
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
* kernel: 5.10.229-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 5d5f7338c1ba5235530d3a6b68406996feb2f021
* git describe: v5.10.227-164-g5d5f7338c1ba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.227-164-g5d5f7338c1ba

## Test Regressions (compared to v5.10.227-53-g11656f6fe2df)

## Metric Regressions (compared to v5.10.227-53-g11656f6fe2df)

## Test Fixes (compared to v5.10.227-53-g11656f6fe2df)

## Metric Fixes (compared to v5.10.227-53-g11656f6fe2df)

## Test result summary
total: 59570, pass: 43633, fail: 1918, skip: 13945, xfail: 74

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

## Test suites summary
* boot
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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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

