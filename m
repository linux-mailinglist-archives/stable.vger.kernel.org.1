Return-Path: <stable+bounces-139191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA9AA50C9
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05C7179E72
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D022DC760;
	Wed, 30 Apr 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIQdTAVB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0B25DAF0
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028258; cv=none; b=maE7/++JKzDA4qprpPZyRJlF7RJYd6MhXYNZ43n8BSf95s3S92uxs594jqCZ1AZSHutPFO8TpfGyrVJAx6fxZndpWewsPr9ROtjqqaOGEH0n0auTqFR2UPF7v6Y1U0NYkoyVQUxA0DShDMYeLhcQpM8azgwtjz65v+WCZJ7jKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028258; c=relaxed/simple;
	bh=1mCRoSl/WXj9EpqFdvrhBKzBNrOH0XyKXi5WpfLxlMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm6OgzIi2a1/squ+VF12gbd/iferWC1/JqZehtFDBMcSlzFWOrE9u2HtVCf25LcOxM18f3IiwV1eFtuB/mn6AO8fXikdzLaRR7yIG9VDi3hufkxheN4T92nk2kTya41nc6wVc0GfGMbDzfXfhECs02rUzQxwpbYMoQTt86VRwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIQdTAVB; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4ce8aa3113aso787187137.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746028256; x=1746633056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJAx/WqHCy0T5aZ2CQVyjJWgqdYiF6JZTKOjqwwgqJM=;
        b=VIQdTAVBtDVI7YIZD3cKaQhlGq0Js46Ssbf+QBafTsrXlJTy4017gCuFPrky/NHyi9
         5Fx1H/KgJLAvuzqj5x9W3cUWg5u1wFbKXLROg8tWk0kBfhLPBWVxuEYrbccG6qI7x/jN
         iPulFNnRKGB9h3ys/OxhfG9McnW/1fyc3AoRhCS8w5Bg3Q7yF/O76Ji00mbpQQERPgqz
         wF1LepOvQAMhtdIf+3f798BcjVQLnu1coI93eBocj1z+xpJwRUcpptNQxEhejTPBYOxt
         OBfJTzciF+YhYLwrRH56NI16t6/g9RSGGtCubSQNvGpmxaqaUQC2BGGO+qqCUtg7/C7L
         HXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028256; x=1746633056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJAx/WqHCy0T5aZ2CQVyjJWgqdYiF6JZTKOjqwwgqJM=;
        b=jLSRlweVLC0lHiHUeip+gJ6Dee3KqMwdeWqKcc5+XTwAMtnevOtjqW2V6GryQf9tB0
         mtx8ArvswMJDxZeoLpmtvjCEXaXoGj1EfsanYAa+UUcG+BL2a2ogCMALJADILqND6na0
         3RDpIeV2y11Kyut+AZkz8W37IWvvnm7Cp6P4dOpa+hWODgfSb0L8WdHgWLJEJ57YwXYZ
         98FlGqTCAuwrUjs+Hq18dlgnonuLomRmXscDmMsHclQYwTuuKUgh+UgF0Dr6FyyoES5O
         EurPp/sqUPP9yyvi2OBqlacDtrMP8/xFdGy+w64IEW1TgqaO6kon3G1L3n2wkVRkN1XV
         sfcw==
X-Gm-Message-State: AOJu0YyOlOCh/aV6ryDpAOHFQA+b4o5vLi34saoAr2pc+SKDLx8/5lhf
	uqQwbWXI9vOaBzyxDit9f+sX0bQxy/JquuK+uJgZYvlZQT3AGKl+g9u1qvGCCVJBCumkk+QlJ0/
	w3UKWblgaMrn2o4fHjBVP9UKq9W2/MRkAUEJRoA==
X-Gm-Gg: ASbGncuy4eudx6lvoH7jZG1Mbys+63OgpmRNv0AD3QvxeVYHPrg9qQBjngxq11DdtKU
	3HPKiHK4AmERDVrlBfHSzn+59O3vVQJVegf7SdDDIbPLnXPnwjg5F0nXj9zHPbVCW5svM4vTpky
	MGKVmYNQMA92iUIEPdDOhYW2FCPYSEM5sXxJ7xmIo9rqAvKkokDCLO+S4=
X-Google-Smtp-Source: AGHT+IGGsdPw3RT8avgBXabu5//S4MiovS5cVHy8pMESNsoOOlpTQkhJUXpjjxf/3yA7TyQdDfUlJPcOKqFKVhOhzFg=
X-Received: by 2002:a05:6102:2ac7:b0:4c1:71b6:6c with SMTP id
 ada2fe7eead31-4dad359944emr3077320137.7.1746028255694; Wed, 30 Apr 2025
 08:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161107.848008295@linuxfoundation.org>
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 30 Apr 2025 21:20:44 +0530
X-Gm-Features: ATxdqUFMXca-djiqqc25Inw-41HaeAOh1iaxf6BhFyDDx8VbrmE3g622gxZ0Igc
Message-ID: <CA+G9fYtGFVgM+RFNZnOWyvkCq3iZvOj4Npo6Pxnt=5f=EHhgvw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/286] 5.10.237-rc1 review
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

On Tue, 29 Apr 2025 at 22:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.237 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.237-rc1.gz
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
* kernel: 5.10.237-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce0fd5a9f1a4e7c9d2c59cffe033ca7d1d7e1688
* git describe: v5.10.236-287-gce0fd5a9f1a4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.236-287-gce0fd5a9f1a4

## Test Regressions (compared to v5.10.235-229-g5b68aafded4a)

## Metric Regressions (compared to v5.10.235-229-g5b68aafded4a)

## Test Fixes (compared to v5.10.235-229-g5b68aafded4a)

## Metric Fixes (compared to v5.10.235-229-g5b68aafded4a)

## Test result summary
total: 45273, pass: 32910, fail: 3086, skip: 9042, xfail: 235

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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

