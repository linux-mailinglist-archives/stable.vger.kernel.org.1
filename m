Return-Path: <stable+bounces-163219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A4B08490
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB25643D1
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 06:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417EA2063F3;
	Thu, 17 Jul 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr/HrUbz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7C2036F3
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732401; cv=none; b=irRos/rdjkL/4bsH1NjFsDAoYPFJsumHj3LnfgYCLg2Jd5os2HfRe5jNAFq+BWM6vAvEePsZkuKuyM99EEW+pQnUT5TLCyvAK40XYfcehgELoIkLX+Wead0cKqBwL+UV/t14YAgt+OceeX6cXMJgTF7lteWr8/b02HzRxDwkcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732401; c=relaxed/simple;
	bh=w/XNXA0/1Ho+Fsc2IZ/94LPEGGsUlTvRDCA0izkaS2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVYWfYgYsUq3pBp0AcN7xzUY9D+JwlWVF9ftSY9QyaXG+1f+gWeLw406KdcgdiLoRq+I8N/wZNbnDW82wDDdML7FwGHrvDPw47huGiw0PCJeZPtBrAzMgvrIuGIMSgIz2aNTYD9eAuGmfk9X75NjnpP6enOry5MlToTjGMfTvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr/HrUbz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3226307787so437213a12.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752732399; x=1753337199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IV5c7k8FkRHMfVKUwEzdiWKabmC2jryJUoHOy4flaA=;
        b=Dr/HrUbzj3gKIkVDRXX3V563dsvakYaM7cpXbxtts71ai2wLK9rMMa4P3jJtaEzlu3
         1NmfN0Is+KO6l2JAYnKSHZZika5SPPG5BvjYJit2QLiUV0qyIRWYHC97FYq9jtMFnhTT
         P658X2INGOLcd2uJiErTCbDCJmbVqub79NijT06jh6/iuDiy1xZ7tTcM7Zd/CB1uPJJm
         UOOV9hykZENKe83vvswfgs06OWjE9HLReYwzfPBlS13JrTkFY3iisBsTJMGUxdj6jJBo
         9JTbU8mPjkCzQ64wRU+rGF0zQ3hVNLY8kJ/9On42lznhAu84brwq1UCRQhhLSY7zhusu
         uK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732399; x=1753337199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IV5c7k8FkRHMfVKUwEzdiWKabmC2jryJUoHOy4flaA=;
        b=TVx6Okqd/pCygz5QUrCo1tz2qheYKfk4rlXlwe1ZdXBUImSiD31U8sF72XHS4C+ffG
         jYJfnoKYuIViDrL/l64f6H+b13SczqLNRO63OKsNgRUm9dsOzSt6Bl9IxJbAmi0t39Gq
         ajpHsHOi6wqgzGq178Nm+Ebk2olxdNDEOhfncrFxDQfKgJ7M+s4vjBhNenFC4z3CxUjL
         QmqtKt2yfv6Npok4PmzgfrsFkxG+aDh5EimCcKVcZn6Iy4xGbcpZN/fTGewNotMk3BBj
         nD+N+xbSL94dSHP80Jii7M1NpVBU9AZHOnRyqJ7p0vS3sK6GsHXX2VntZp/1jYjf21Fo
         674w==
X-Gm-Message-State: AOJu0YyKz3GC5S+JtrB8xzfQ84nMq3XbqsrYdMmnutyTfg7hC5U8SjK0
	6cT0KWFIp3cdsfPJLoqWkrUQIqKohXv2ZpyHRlRdBjOPF7HaRp5bIVcI/xYX6nMWLc4+u7BQNLC
	XilglxmpUhyOjRrV7aDKduJQ7MvMZdhV0fVcf+tIx2Q==
X-Gm-Gg: ASbGncu4ldWejY1bepFCZmAls5dJlkCrBTUsNq8/9UkWioVr0c1ZQe5Fu7a/EU4LX0x
	rb43MaM6ZkI7fzI2yz6qKfdxqSAhSsPc6ryQGOwFzMfHoi78xnSFBAik0kAmojRIim7BGh963ty
	qf7yHGJEm+tsA7TCV+zzo9rrGHp+RZmZH1m8hEpozMwHk4/DOwK9mtQASZMX3wJY3dvoKLx3l1p
	D7iN/H8psn1PuzaipTz7YO+xt1Ir9Hk4QGn0KqQltl4ecZQONI=
X-Google-Smtp-Source: AGHT+IElD+hWffueY9O2l5MlqFuqIXzGyCKBnFzcuaWJr5IbzPpnXRMfFI73nz6+ivP3Lmv0Z3fyQZbpDdsSYxJ75Ro=
X-Received: by 2002:a17:90b:4985:b0:311:ea13:2e63 with SMTP id
 98e67ed59e1d1-31c9f47c919mr7014030a91.13.1752732398519; Wed, 16 Jul 2025
 23:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163613.640534312@linuxfoundation.org>
In-Reply-To: <20250715163613.640534312@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 Jul 2025 11:36:26 +0530
X-Gm-Features: Ac12FXw75ij4GhIMb8FWW5TzSpjmuX_6qgN5xYsecfajFGkyv7O_tsvhp9A2AFw
Message-ID: <CA+G9fYvnLqHYteeXiucdCJzpcxJ=w7v+RFn1GE2pa_LjFSNV9g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/209] 5.10.240-rc3 review
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

On Tue, 15 Jul 2025 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.240 release.
> There are 209 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.240-rc3.gz
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
* kernel: 5.10.240-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2067ea3274d013cacad86f86222ade38d0f51a7b
* git describe: v5.10.239-210-g2067ea3274d0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.239-210-g2067ea3274d0

## Test Regressions (compared to v5.10.238-353-g9dc843c66f6f)

## Metric Regressions (compared to v5.10.238-353-g9dc843c66f6f)

## Test Fixes (compared to v5.10.238-353-g9dc843c66f6f)

## Metric Fixes (compared to v5.10.238-353-g9dc843c66f6f)

## Test result summary
total: 41250, pass: 31019, fail: 1800, skip: 8248, xfail: 183

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

