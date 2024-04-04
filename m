Return-Path: <stable+bounces-35955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82046898C42
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE001F23790
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69411C693;
	Thu,  4 Apr 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znyZghLJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850411C286
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248621; cv=none; b=h0wistgeq7sd5FmCeyK42JLt+emrgoed499iE4hVhsHaR7s5wD+InCFAYQj41kl0/z4eDLvZqdO8VpmBvZGPE8zcFg28c90vcTR/d3YtW3d8MG7rGlAnPFfwI2VvDu4Gzze7BB8AVj8By+V0zjKTuwXnPt+OvY+WiZQHaCyivfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248621; c=relaxed/simple;
	bh=RxA9yYFCilY5dxmQyD6NB24l+ixiHdRnI4CJyWiUqBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPmipc/t0cTRqFeL74761JeJ5sTe0i/1wapiPzDWas2QHY/a+hWA4TMq0VnJovhq6D8qj6hkHJZIFMyeFMpYKdG+dFGq1dlC7XUfiYtWDSF+Sb5DwHLfp2oXCjd8E5WE8U/6XDusU9GEkdqjg2ErpVun9tHKgdurk1GCgT3BioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znyZghLJ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d882358ecaso1279495e0c.1
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712248617; x=1712853417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQYUGCMQImaV9Z+lvySiwhsUlOBH+IYL8YIHyQv3Kjo=;
        b=znyZghLJUZ4ryPU/aGl5SrX20OWJLUExmdl36u9TmRv1U7S71E/VfHBiUd5A51T97K
         Y3C/ueatWp+7SxOdT6JqWqEC00WEiBfiU4apHRUHdlSxF8kkkYQ373YZ08BVozDohHqi
         q3fMoNV0WNltdWAKJteuipJWLLFmBLqaG4XwClifhUGyAaJQiF3ynOs6TZIMSCM7Da03
         ZkBVmstE05HRCgXC2TOSG3/v7iXMsqx7OjOYKHlkp4mJOa6FbosNpjTM4N0RqPqCpt5b
         DBK29ZvVY/GSl3UupOKpGVH9TlAYgJ9JCtdB0G6v2DJqpKdSd1hWeAUTdpxao/sU9Lfj
         xWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248617; x=1712853417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQYUGCMQImaV9Z+lvySiwhsUlOBH+IYL8YIHyQv3Kjo=;
        b=vp9T6LUdU1Kev4b+WgV9rQcB3gsFQv4Wu9S4sy1PZsLPHSPuH1Vp2nnzxKMzZ9QRfD
         EAgWLj4ncKeLEbv9RKhGSCHGOkd3LEtzw3zvXBruU+dMCxLJdKMkW9BCL3BkhHnGIM5R
         pmOxFOyAlTT+AUd6zlTX42BGmo0949+NZ+PfkGbzL+lJJhA/wnjGe9gQqo7BNMJLhs/A
         OAvyztEEWsDy1/2oK1X7bAarO+tsbj4KR6dVd8fkx+7LWnbg/B+RUI5s6NkJMJWM1AqC
         iWHT0Gto6HBvPpT68uKJOHjOKsIupLHqfIfBw+uw//5SpzNvkSW7sSuPhDKAWA842iT+
         ci8A==
X-Gm-Message-State: AOJu0YwLzS3v6xRPsmnvNgw8cvHGZxY2m4AtMnT8ViF3SgNNWlf2Yxl5
	384Sj9Qt4E6bIT4xNoZ5WNZuRle96w3Sk71lJle0VqcxM6pcfj6YwT0/JzDVqL+7Q6jgPIAF3wE
	iVFhYhTOaEt6W1gbddWlO9qrQCQhaLhE7Kio60Q==
X-Google-Smtp-Source: AGHT+IEB9OXnZlZWlV9PleCenI5Q0zAtZD2Kw/+SFx8BdfUpqKlCCn5Racdz3Kw/HfsDbCK6I8MQMETqmUG9rxjKzqM=
X-Received: by 2002:a1f:f44c:0:b0:4c7:7760:8f14 with SMTP id
 s73-20020a1ff44c000000b004c777608f14mr16412vkh.7.1712248617418; Thu, 04 Apr
 2024 09:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175126.839589571@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Apr 2024 22:06:45 +0530
Message-ID: <CA+G9fYs9XEgjM2M7G9kTGs34Khn=CWuBNhTZVMgnM1R9=Hc2Zg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024 at 23:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.25-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.25-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: e253a5c1b7de55d37ff656141e7001bdfd035d8c
* git describe: v6.6.24-12-ge253a5c1b7de
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
4-12-ge253a5c1b7de

## Test Regressions (compared to v6.6.21)

## Metric Regressions (compared to v6.6.21)

## Test Fixes (compared to v6.6.21)

## Metric Fixes (compared to v6.6.21)

## Test result summary
total: 121780, pass: 106264, fail: 997, skip: 14420, xfail: 99

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 40 total, 39 passed, 1 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* kselftest-ftrace
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
* kselftest-tc-testing
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
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

