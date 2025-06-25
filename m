Return-Path: <stable+bounces-158624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7FAE8EDF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D354A0EF8
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE42D8DBD;
	Wed, 25 Jun 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLibMkTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8F28936B
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880526; cv=none; b=cJOQSIYwv4xREikYwkCEyizKzR8C5cbwjvbWYWnRVd9gQc70mlYFSs6NCLSSZ+FSkkF3bAocHyfb4MIK/bNLtpNRr/x3xw6Hhodzd/Rqe5CA9so9NkEW8mx7vPLQg4lHP7Hu+yqtIBAYxluZMpYO95nWomjYilPlh7fzODS6YFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880526; c=relaxed/simple;
	bh=8XtUwx2BwLQL5hkf0DSUr4YxplMp2dK1xZtzuPCx+6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8vWicPaYMPiu0b2R35mA7FCosRGylKJh/C1i4NgcX7SjQAeikdkOvr5HNlq2Ozjf8HkkDzTTl542BywETeeduMgh49DdHQUQPyaPtXNLkaqBSK28cgiz3wajf5bG4j3AHbLCzxs0x4iHUZyMYelzOAp8vbBIsH2ou1WyITJyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLibMkTA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so3148065ad.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750880524; x=1751485324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITnI0wy6+aC2aZG3lyBEjNmPitHxk8dkEkiBg5lq/Jg=;
        b=CLibMkTAwsVqyCP0Xs/6LWNy/zXW2JhUG6VL8thr0uwbgNpeJfR6lj/842w3Wq9UH2
         35htekcD5EP/Vu0sIkwPnHVSdY0EPA9VB/7TQOiv12LJNrWY4KDAWpXEzPz1XrDXYE6Y
         9kyReW21tgjylh+jC6xKq6TA3mEmh0qvuhuu20HHqIjmdKeL7Pk73pUCtoe10Y5Mjs5q
         i9rkyS/IS+DlXmDmlnbsm6OpMCU+/XZwvwvNGLRfGScbPEt4QQvuyP9V1y4SD2u5HBQS
         lt5lYdr+Z0hwT8Tou4Fnrp+qklpjjIbOM3YF6G7A7iBTzFdA0gn8UVjiW2G4nr9486eC
         T8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880524; x=1751485324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITnI0wy6+aC2aZG3lyBEjNmPitHxk8dkEkiBg5lq/Jg=;
        b=kuYjcVtZMNjXUQ01Pe80oxcu6M5b1HUTUMa7WvrLoL0ZBjGYVHMk5IajBoAWXzItKP
         18Li3mHDwQeY8KPdY6NSx9DKA2HmHMqCTDBx0FdRJqEo5lRUcsjoj33WSDlSpw+2ZFq4
         5MJTChzmrDzSVC6a4reWcjnKcz9Ho4tztS9OiAfPcx0fJi6Qm4w1uRffTyzzgqECxgQ3
         dQaH0Qitx1vxUBdoCmDGh++fLDWzZE6rMYdKtLPSEr+YQHThdPuoAeGkCv7f6rEcUc6v
         ucI0kT4omABTK1Tqy+B9yd0y3XzE+9eV3GVlzPydrrEfUmsBDPYUYYaFwEQ1LClGC+cS
         V9sA==
X-Gm-Message-State: AOJu0YxUFUqKKHs0qOdPK5+Cq6OtSn/gPYVlBT9sjBqGrqbOfeY8z2Hw
	K9ThM3FD1qFeFJcSQR/qwxoGTqaVK2cnXIcdqxg3rbvS6MSED6fowIfnRugqrkVqqopL23rnPAi
	cjeQBvV1v9gIYBORJCS/MWbtSUUNohFgMC+kYaNoXTEHq0AtBN/CCWwMj9w==
X-Gm-Gg: ASbGncvDHR+s0vvtCt0I64IDSnhx4Kib/aIDThF3ihqBHBMNanLn8MipKi9BbkXsl22
	Yln/Wq5mWqQuBz03Rsu+UwMf9J4JCCIBzcZXAo5LZBU4fTW/H/XF9Z+i5yehdaONd8xlyO5N5aa
	SHJ1U7+OMy5sTe+VJ8ytvcFLAlb6p9cRc17cbSm6Qj/yje9ilhu7lqpB3HoOct3pbxWMQxVC4dU
	mGS
X-Google-Smtp-Source: AGHT+IHI7fLEELCEdQECz4jvJ9vfnnYb912O9SMYpH723cQLFhWR/gkWTkcZd4ZK1gNY8Dl47Tx/LTqNtu7WTvEjmvg=
X-Received: by 2002:a17:902:e80c:b0:234:cc7c:d2e8 with SMTP id
 d9443c01a7336-23824062835mr66798525ad.37.1750880523839; Wed, 25 Jun 2025
 12:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625085227.279764371@linuxfoundation.org>
In-Reply-To: <20250625085227.279764371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 01:11:51 +0530
X-Gm-Features: Ac12FXyBZWFqQp_A-N04cBiioXbW9Ot02Z6PLnqwzoIAurmuEnCDQiactbZEcG4
Message-ID: <CA+G9fYt59B7zrOO3pzF_7c4ECCOcG3JQKK6kiKXN+AztFuDN-A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.295-rc2 review
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

On Wed, 25 Jun 2025 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.295 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Jun 2025 08:52:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.295-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.295-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1de5ce8d465e02df0b8d08092e497eb9636c542d
* git describe: v5.4.294-216-g1de5ce8d465e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
94-216-g1de5ce8d465e

## Test Regressions (compared to v5.4.293-205-gdbf9e583326d)

## Metric Regressions (compared to v5.4.293-205-gdbf9e583326d)

## Test Fixes (compared to v5.4.293-205-gdbf9e583326d)

## Metric Fixes (compared to v5.4.293-205-gdbf9e583326d)

## Test result summary
total: 39680, pass: 29163, fail: 2048, skip: 8349, xfail: 120

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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

