Return-Path: <stable+bounces-26906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D389872D9E
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 04:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2922DB251F8
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64A14263;
	Wed,  6 Mar 2024 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7dh/sgg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D081426B
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696752; cv=none; b=f0nlTuTMac/yF0Bq4MgRW/VIR82SBf5wTHg0ROlCi5BSN0O16IL40DRLNySLOh80gU1o6SPgZjG9U1RpNZ6kcg5nuMe8YBDyJmbfhjSVW3f8bQCHP+qBo6zYvUPnF23PvJMOxK7dVBetcpVSRUBn4+93ZfL8OeyknqzGGbar/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696752; c=relaxed/simple;
	bh=jBAPuRGdRlyLec/G8hWJrmxIWweZDNQGFQVAySUpzDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVtsf2fksQU3gGI84IQ8H2r+sRStuqLIBzn6nCD3xVLw0arAhlHEQx/Wbe93wnyZE0qsGQ2Z1WRLmHeFKOcasZRlxCJVJQ3W4GI4wfuwmJVIPCneO5dnFLyPj1QB0LN3Bcs1f72u4JvVN+B7Z4CkArH4DZ9arHkTARwxOLQp3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7dh/sgg; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso3722701241.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 19:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709696750; x=1710301550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5tvqqOLlp/L9fDdgXTeavKp6GslrC3c7o5kKTJOuGY=;
        b=o7dh/sggH69N6FSzl5WuV5uPBLURS7y/K2nTJ6xB4Jy8RkqCM6NJqFlMFc93HSmUF0
         bpGoOP5bQTMTU74dHsjzbEIYNUtIKWNKrvQAQIEAwPzJx931YX0x/YA2ew279vVqinWr
         bK1KBcYm40gJ2aSNS28sOyEWFL1uQkoAvs3YUXYC1Zks77PUPy/oDYPLP8ayyR9akDF/
         Gks5vQMpz4Etw0Rez9d2rOBmreJxOVXaciJqM3vFwOi8x4tIFfMmpWFLRBCb+ppFRK4j
         DMx0z04Iqts7jMTL8bGqyfWwugM+Dbiv86UV0A5kqe6a4H93U5pngCpZT2gEdg5kZ7Jc
         xcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696750; x=1710301550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5tvqqOLlp/L9fDdgXTeavKp6GslrC3c7o5kKTJOuGY=;
        b=hEoKo1qzN0nEy5CecgO2q3kw4AcR+TZozwWEw9kiI5E+qhjRSqqEhTGQJh80OxwXW2
         M8Bu73Y69USFtv3ye+vqX1KZQ9l0xI0OPhRTyQdQdxr1LN216tZCUqR5loyBRVehN8iw
         UK5ru5X4c51vRMxZF4NIeDCDGeocPF5zQrC/tOLmntnq/QFNjdpmd2b6I3PDovyudPsc
         UZAfl3PS8g21Jtqk7fhba//NNbQhoHWX+e2B3hM0tn2Z8vWHZ6O7PwhtKDUDD5zzNfi7
         Ac+mowmre4VYj8aSRCXgDT7OzbmWFNouOMN4tQDR46DSGsrnxdO20S2Y2OLjuooDBG32
         8MJQ==
X-Gm-Message-State: AOJu0YzUSOwKBBHj3rK1v6h68HlIxxdnpduenIfzMAXKJQFwbuKV88vv
	EpoBJ7gUTGAu7j/mJvpxULTAHmRPd5lackrC0Rw62gKdIfMDRNiyGIbzOso7mJE/i6Qs457QERL
	VtsvGYn2Z3xl+nGuN1P4pdtWYuRZIPfWcNpRQcA==
X-Google-Smtp-Source: AGHT+IGlgYy3++WxEbb9Vbw+tVFeATrL7uP+/E+8ROLUn4LkrKLrXnX8dPjsvyriAp4nhB6XfBccEoT5BRDkmmdMhuc=
X-Received: by 2002:a05:6122:3214:b0:4d3:4aad:22d4 with SMTP id
 ci20-20020a056122321400b004d34aad22d4mr4786922vkb.0.1709696749951; Tue, 05
 Mar 2024 19:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211534.328737119@linuxfoundation.org>
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 09:15:38 +0530
Message-ID: <CA+G9fYuFg=5Thx50TTt4VSfzjwCoPe5oe-O8+74-T+KBtN0AEw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 02:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.309-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.309-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: c854e1c772c4f07a8856c0867118ce064c11fead
* git describe: v4.19.307-70-gc854e1c772c4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.307-70-gc854e1c772c4

## Test Regressions (compared to v4.19.307)

## Metric Regressions (compared to v4.19.307)

## Test Fixes (compared to v4.19.307)

## Metric Fixes (compared to v4.19.307)

## Test result summary
total: 51688, pass: 45911, fail: 287, skip: 5449, xfail: 41

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 106 total, 99 passed, 7 failed
* arm64: 31 total, 25 passed, 6 failed
* i386: 18 total, 15 passed, 3 failed
* mips: 23 total, 22 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 27 total, 26 passed, 1 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 27 total, 21 passed, 6 failed

## Test suites summary
* boot
* kselftest-drivers-dma-buf
* kselftest-net
* kselftest-net-mptcp
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

