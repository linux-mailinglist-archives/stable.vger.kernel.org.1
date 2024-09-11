Return-Path: <stable+bounces-75814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3F974F6E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A317282110
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AB183090;
	Wed, 11 Sep 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcH/PAYq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836213B580
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049522; cv=none; b=iqHtIMp4WvVEYhmhyMctnhjic29V+sultNsjDsmPOLBrRceY61tNMtHb8pd8DCxOBE1wXdOC20jtrgdOB0ASvS8XmKYlstTHSL4O6GLwvMRffUWNq5amJ0ASzWNtX81LZilGhQ7OirRHeRMIQ5n7sTj61tQUB9G/EWCLA6kKLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049522; c=relaxed/simple;
	bh=3sEkgfpHqduntg6RFgeF+3GTSNXSlv6Xw1++UeZWWec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqxJ9r3FUVFeDXCg1OmT9pBZytJjG7h0+w41dNe2h4h9mRRjoXf0KRwSTihCrYsK5pBhn4AZ+1F3tMcNRgzLqgGtIUMpszWznEne0kboBiSPJ3MtCTh8c/7wNwvqtEwUfqP9CjW957Lqx3dG1/o4kcbgNg9xoskbk8oWIXvDIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FcH/PAYq; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-846be74b299so1653098241.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049519; x=1726654319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGukwIE6cAR699ZYbN5V3VRAP5k9uAR/UmdbxaN8ew0=;
        b=FcH/PAYqrVd83SvKr2NKOUMoRaq347wfms6xwMwwvcYIQ/JcY3qBJBQ+tG1HG2pIC5
         j9dnLdfOjwkQqbwE3G90dfQqYpRP8K2DU3Bjb7PrTgalxPibo9ygMCsjpEe4GN5zUxvf
         QjU6W2boNKZqUD/PN1OkeaHXgaJUizB9jSNwUoRT/5tkN90bnyBGTe8KfO5Ohcr5HuBQ
         B9WutMr8AwuXRUMfnt5AvrXeyGOwAAW8zM/K2QlDnHWjMaBcLiu1fdXNwh9OzysaUkFN
         QnRQf/pvHOzXzo6NbStiqZPhGqCb/cdApy2kHeEbEaoV+fWtCQ1mb2CA48sk8ffFnpZF
         KJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049519; x=1726654319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGukwIE6cAR699ZYbN5V3VRAP5k9uAR/UmdbxaN8ew0=;
        b=ia1jmkFAJhTOYkht5ay8PsOI1MU9ayYyD9lnnrhaC6WpN+gdZwHYaEjgqzW2uGks+/
         qAZKe6lFthH1DdEr7Q9PGeSNDKvTXVrk4Zd4R/jWwMuZxOFaraDDBpI/hd+uFphRfVWf
         avZxJDP3dNUKUbih/2fWZQ+HaONfKpmQjwyGZKq2/nJyGlKPYYq0xaU+NlPeCeIngD/Y
         LsgCiLBQioYz6v+BFE+faUJd28sQlLtE/PL7xUARYvl8wJCCJZEEb7rsRt9c29FJAzBS
         J158KCpkmbDgBWnsFTACbZG/foUwOBt1pPmVy9JcCGSwScgvNlhs9+H8N8bSJRxrGXNT
         0zWQ==
X-Gm-Message-State: AOJu0Yyw8bEVJD+9A3Cj35J/nSTjrQENhUzapbO4s3Am5lvRR5lzLklW
	eSg/bQ8RYXVXbmvKzHK0YSKhVwx0pa86J7nNg3+GaJScZwb6Ta9Hhe4LODNIA2f6P5+q9NSmm4Y
	2A00XeXYLjT4epzDPQ4W3MH91AA6O3Pl4aqjc4A==
X-Google-Smtp-Source: AGHT+IHRN4JqoqecYOHU2H9OFVhpfgeJvKKrYv6fpeH1guztQzOfvPFcs24x7GWZWm9uOMxyFjtddi3otYcynPDQJuU=
X-Received: by 2002:a05:6102:3a0a:b0:48f:ebc3:a006 with SMTP id
 ada2fe7eead31-49bedbf6adbmr10542424137.15.1726049519036; Wed, 11 Sep 2024
 03:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092608.225137854@linuxfoundation.org>
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 15:41:47 +0530
Message-ID: <CA+G9fYuJF11wVcMyUX6HL6T7OiMf3X_RFrMgpv808KH=UYGA9A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/269] 6.6.51-rc1 review
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

On Tue, 10 Sept 2024 at 15:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.51 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.51-rc1.gz
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
* kernel: 6.6.51-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 415df4b6a669c6801631bcf697d2e0d8dc171476
* git describe: v6.6.50-270-g415df4b6a669
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
0-270-g415df4b6a669

## Test Regressions (compared to v6.6.49-132-g89740cbd04a6)

## Metric Regressions (compared to v6.6.49-132-g89740cbd04a6)

## Test Fixes (compared to v6.6.49-132-g89740cbd04a6)

## Metric Fixes (compared to v6.6.49-132-g89740cbd04a6)

## Test result summary
total: 232275, pass: 203695, fail: 1992, skip: 26335, xfail: 253

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

