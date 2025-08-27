Return-Path: <stable+bounces-176479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D0B37ECC
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243397C6F48
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C0343D87;
	Wed, 27 Aug 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAMD0AvZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF5276028
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286781; cv=none; b=pckXcUwDkdG4oOTeGapNHnPqtXvkUEQDp0Jn/tH/ula+n+q5rTF0dgOFiGhxRJ8lAxDR7cSFMq4JO+jUF5p2rTnStuJL6O3HB9T/ver6J9sFxIgXXzH7Rp/tdt63YvdyCw2xvqkwZi7cL3iZ3vg/Yc6dNHVuArP9KdVTWgS9rXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286781; c=relaxed/simple;
	bh=ijsvinMsyvw0y2W3RvJVA/LaBuLCajMeHEsODWMvu1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9zJ9pR+PnI1t1dhtyBxX9rZ2U27BkMojJscpGfs7YGi4xQm9Fz5Dt0skYs0Xr1NjkTMcKIsDV5N/8O7xx8f7b7rvxBBoTtxAItFhoY5anD90TOtauwcVcVaIPnmP6zKQ5LIxIkxqfQNqSJiGA1IapLm+rP9xPnRpU50C49mPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAMD0AvZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70dc6d81b87so4959526d6.2
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286777; x=1756891577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RObNvhRzj14YrAIax+dM99xs/Xf3Y4EHrFUMEOiDAYE=;
        b=bAMD0AvZvmcnYtReOREyVyexQYznTXl5ZkID+GSTUp/bD/q2t2llGjzHsehmR9RE/t
         ifSV3uugEwddHdcIOly7RINEvACk5sW+7CMv12vSgzff0f6owFvdHbRnGYDr3iAfUd9Q
         fQ2puo2wenC5G6oK/yFnHnNDoSZ4gov8DtmBkHF1Pq7FHRhMI95dYYnT/3QQR/BpCbfL
         qn6M26zviwMekdl8uo1SXXBC63gyNy/TTuuCVaBKOtG1Di3YwL6nYWu5w5P5PcqaTfEh
         lZUzaiHvzvNx8zuQblw3XuCGGX0t60GWV8pVX8n7LJJd5fhED2FWKXPD5Y6HZWJLeuVw
         RM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286777; x=1756891577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RObNvhRzj14YrAIax+dM99xs/Xf3Y4EHrFUMEOiDAYE=;
        b=duvNy+SjOAF/AYnpJVj1WgKHkYDmlAIB4JsKOHW5vRQvtrRQM3L3phDiYT7cH5qiRl
         sQ9MvUKrmQGGtLnzZYcWCmjSKwzQjqWuFvLEAKMyJ8jvTy6MhW01bCRkLL+fEH9xLhhV
         ZuRfHQy0Q53CgejbzyqUOcwFNMLtxYomFJHnlqOFTxFxIH9K0GPoYLzQNvYoHmeUfQtO
         +7hCkgmylxOcNXcAadUzgtWfRgiZQ+XHCbEZf21MLNOtGYHyz2Kn6AtPo4/LvjvZIA+T
         2phvjbpPHVFas6l/FbnniN5oCuj4C76i0HA9wEtZQnULVViWMRXdG28cLI/5iIuLUrc8
         BVrw==
X-Gm-Message-State: AOJu0YwuZd26v87MUINOkep3KN6K3th0+RCVbXThQ1PwSoLixdAKWcZm
	WrJbXsihltyGVRI3oqOxY/ofi70mRyr1vF9qNjUERNzsNCPMW4iWTubpVlxNj5pc78li0D8la3v
	xypsxcrAiHPeZJQzwP+NUTsjQUyxNoD86PF6KS7Lw+A==
X-Gm-Gg: ASbGncvCBZfjLbL77wyRk2NQR8LiLb0166yovY5oGD6Br6M8LG7C5N+zDA1LGha6RIa
	x+Nvg9uKR2g+ubKTSW35TdaLNf/+4Hmenw9XXz4BN+Kp+Pt2kI/M1NDKf8hK1f5zRVgBNrALcPW
	3OJX5He+DSZlmzv+lErQ0DkvhfEUh6Ds7kK9S2Cw+AMqZkXr9I2mccYnENlsiTWOqLgTpqCN/S+
	MBoJXIToDeE7OsLpycvUCv5ZMA=
X-Google-Smtp-Source: AGHT+IHjJ8ojfehejC6rUtG2n9YWVWEdlo8h3+JG4hp5aDstD/xNsnAnq5uvb/MrWZkcfry6UfWdzDOZp+dxXTeBdvU=
X-Received: by 2002:a05:6214:4c86:b0:70d:9819:8799 with SMTP id
 6a1803df08f44-70d98198c61mr126143366d6.6.1756286777207; Wed, 27 Aug 2025
 02:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110930.769259449@linuxfoundation.org>
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:26:06 +0200
X-Gm-Features: Ac12FXyfQSMfovOH5u8fKvG_4IT8L7R8HIzuMNFjhYcsK1bP_QGHDLPsal_-a3A
Message-ID: <CADYN=9LgcCC-QLMpQNuKq4wW9iOqZqPrNovEYY7r3=TRsidbgA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.149-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 6.1.149-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 3c70876950c1fcf1008baf5be67b598127de7679
* git describe: v6.1.148-483-g3c70876950c1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.148-483-g3c70876950c1

## Test Regressions (compared to v6.1.147-254-g7bc1f1e9d73f)

## Metric Regressions (compared to v6.1.147-254-g7bc1f1e9d73f)

## Test Fixes (compared to v6.1.147-254-g7bc1f1e9d73f)

## Metric Fixes (compared to v6.1.147-254-g7bc1f1e9d73f)

## Test result summary
total: 226713, pass: 211004, fail: 4615, skip: 10850, xfail: 244

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

