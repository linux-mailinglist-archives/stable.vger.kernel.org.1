Return-Path: <stable+bounces-139428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F4AA68E6
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 04:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EA91BA5868
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC219ABD1;
	Fri,  2 May 2025 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3gwIvrv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC4199FB2
	for <stable@vger.kernel.org>; Fri,  2 May 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154645; cv=none; b=txW0lJyc/bfbKbnaTXVgNY1obt9JRcJqkkVf3/xB1sAoWYCUZ40bjJD3sdaWrToamhSpghMmQO4KzZ5wGd+6vzY0HuZCPqIf3xYKQmPGUjpq4BAspJFvCAk9bUl1VtFSCyAzKm7OVyPC6s+RGrBNAyQ90Xhy1VwE8W+ilMuGG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154645; c=relaxed/simple;
	bh=Xti1Q8NVpaW0SAekQPjXI4HoFyiGloMcGsvei40vPu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqxwcsKpCxRCCmsp7Z2gkItNwwI6jiILgsinmqw4AdjQlfk6qyFWp0qvs+2rnfOTiSEIh9tzoOCv9KiCOyL6A52o2y+WbF3Ea0J4P5iP9iQ3kQoB4UgptCqLhc1aAb8ro4109UunKTZB9XdV83c9UFqyIvv0NmS917YAeQf6Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3gwIvrv; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so1028119241.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746154642; x=1746759442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpv422QdHa8iuGl+dZEsxSBPRHtPDp9WBE8ZtLi4eok=;
        b=B3gwIvrvGNDn2gU5BKbD1bBISVY9dUxL3WGFpBQDdxT+c1j+aQCraDES6M8SdvClyA
         AedZ3nxrrKNDWDScHAIh09Wwsaxn+mkky+2Q29gaVRMeT9Pt7hiIIqqDbvZX5WMMX+L4
         Vmh0qoa3dZUAVg2QCDE+FUuhKT8TcIqNVLjA7FPbkXM4pnaEmvB8oxaACoSvt1328pXA
         c/vVRcvzc3rMqWmH60gvxnb/ZbnWUdI1cK2muu/T2i1isGePDf1Nbe3awhhT/w1t9t5a
         uh3UMOf/2PsId2nE8nUixwkjGde0peaxpEbUfMAGMHd7CdGXsILJq1Zb7PddjHHbtcFT
         ybcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746154642; x=1746759442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpv422QdHa8iuGl+dZEsxSBPRHtPDp9WBE8ZtLi4eok=;
        b=rfevkWANnL61VLui55IgG76pFLDiD6E73ZrxGz7dHypulXZR9bCoDSuIhxg9Vm6Mho
         pCO5LiwNmVb2mariU2V6Fbn8wZ3DZpPzfYpetXOJBChFgVdkayeH5c0VfQJWSjnyJWAI
         ve55kyrt4YeBOWiJZVzBSxX+dSPZLTmcpjmLujc7EOPZ1ULe9CktuH9fHPaPqpsAxRsn
         UNcLbs57+VbYjewwAnRiO+YAF0m+xjMN0s/mlkiX4ObOoptZ0nDitar8Y/x4syceJxqN
         9mtcw0k/LWASQDV8/GVmrpLdkag0Aj/23zdylEfBXK8bW5GcNYCO8FVMcdjc3BH6J/Bg
         v8Hg==
X-Gm-Message-State: AOJu0YwBKqRe8UoCEi1j2lSlmRJjA6SpRz5K1KQRqqZJBiK2EExbTKef
	25+zzpj3V7W5PirTqBJvz738rTM76gJ3QIaUk3ueKpIb7mOoe0y9Sqs3KPc/c/iQKwe1/B6/9it
	HRZpvQ1pwXP0564EmseIGiQ6ZEiMf8br18adbIg==
X-Gm-Gg: ASbGnct8usLRJvUTvZQey38yxbMPeYoREbJC2vg870Jhixi15M3j+S3llGVwYv/Vxbs
	BR2+JO5r7ZU6wNpGvYyDRrrrHgyHbdzqAkBrj85s1ARl9h2bBwxCVQrhdtuSuP6jpNzQ766Asyw
	PH3q9RCXMUM4EaQNCRVaMJ
X-Google-Smtp-Source: AGHT+IGnYlmTarH7APTfkjBdOgnxELdwGSUFkWrvBO+UOVEjMcvmdgBKNUyZh1FMsKVsTM/sryK4beIQOmF8+UuFkvg=
X-Received: by 2002:a05:6102:2c82:b0:4da:e6ed:19a3 with SMTP id
 ada2fe7eead31-4dafa71096fmr1216716137.2.1746154642592; Thu, 01 May 2025
 19:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501081437.703410892@linuxfoundation.org>
In-Reply-To: <20250501081437.703410892@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 2 May 2025 08:27:11 +0530
X-Gm-Features: ATxdqUHdQ5bvFT7Z7Koe-Ur1Vf9C3tvV2SY3HT9fNV_i8RmqYFHj3b3yFdOKGL0
Message-ID: <CA+G9fYv7jtmdCKOchbeCZSJhFkeV4Q7Ks7AX7+u4cn8Gr33HkA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/196] 6.6.89-rc2 review
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

On Thu, 1 May 2025 at 13:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 May 2025 08:13:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.89-rc2.gz
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
* kernel: 6.6.89-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: da7333f263c37f74e92d643739aac42787c70e79
* git describe: v6.6.87-586-gda7333f263c3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
7-586-gda7333f263c3

## Test Regressions (compared to v6.6.87-394-g2b9f423a149b)

## Metric Regressions (compared to v6.6.87-394-g2b9f423a149b)

## Test Fixes (compared to v6.6.87-394-g2b9f423a149b)

## Metric Fixes (compared to v6.6.87-394-g2b9f423a149b)

## Test result summary
total: 141532, pass: 117269, fail: 5272, skip: 18402, xfail: 589

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 27 total, 20 passed, 7 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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

