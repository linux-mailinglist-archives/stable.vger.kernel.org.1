Return-Path: <stable+bounces-75972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29E9764FF
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C0E28406B
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F941917EC;
	Thu, 12 Sep 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HY98Mm4x"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B918BC23
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131365; cv=none; b=UZTONHxRZNBPTJr8ZdTTsmf+paTQL1EIkRsc/dWaQ/791Wg0C9ulnv7cyMx8HFytKuFiwGtw8OhUxW9lnaS2sFJvasJRvz8ySUu11uYIYwzM3Y1YuLFlmm78PU0PkqCCo8D5PJfkqvwF+gkHR5NQSUJR9xtrVWXmbIFkECzKN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131365; c=relaxed/simple;
	bh=qD1HhQH4NjYHBF0Xozf0rppz5YvlGbjasErhi8pkmOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVzXYYzb5TOv0bCK23x/ycawDC0/2Nqc/QuVE9SJ5tHEcKsssKkb8cpZI9JwN/DY/Qj2XvNKBCMIlQ/XGg98lWM9nKCn440mR7lDArKL+0RmCejCq5A5JShznpgBD4O+GDVscx8bxNeHpZCFnscqpK82FWlqZ8Ijoi0+bs/Y10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HY98Mm4x; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49becc93d6aso217967137.1
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131363; x=1726736163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcvRVOfTB/QaV43zEeZF3CiWZLcYosI+3Cqn2IbwOTM=;
        b=HY98Mm4xn1sydvexRT6xn24wcKvnzOf6xjfK2omvn85GG8rVL2iggcYyLEe28lbJbH
         euVa/VFsEoAFFJF25/LqlUndYmzSKMZUdZyj/0RebNgrlAE4xx7tI+BcDkjFV3PnZ9eR
         L12lqXudqczYyM8ZsFIjBtOYbqtYdrq8cI6Bz1MIAdhvC6mvK5WgrOG3RHrYq5c/TiSi
         4Zpdgt3ILe++qp5Cpm6LCJqifv0j6YmbSsspZHcrwS2qhoAtwal+IWCL01rRwtl1Cu+D
         FqpNgLRghFppAwBcGiotpPTNIEMwzQ+5PdR0F/7Y4dQM+aYPzLTYU3Dbk+Gd5Hh+0xVN
         Y/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131363; x=1726736163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcvRVOfTB/QaV43zEeZF3CiWZLcYosI+3Cqn2IbwOTM=;
        b=w5uXmTNGxl73lSGOXQKTLaZJaLuGDOkwrd7ToICum1DDCfqgtV7OLi8jgs5f9mQu9d
         HDJxIOJlwCGbvggoMOKgbzrPCnLRJS0lURmOmmZgnE4sjZTG1SKH1CTX3SRX/5vuI80J
         TNP+SQUQZD6LMb4jP+2kCRVvOpBt05HRgNwfe1NXqNx+vMs5Hk5g48NKYOGg34lQt8zp
         bObs63iBz4U2zlSdD3VKRvr7M1hotdIk3FgcCdkSUujbSMkr9xy+ebGSqfUZQcbRMSWH
         7Vz9PxcIF7Z5/0hTznDNYntqqIqvI7PuvXC1wwAqWHHKilfhN6MJJlx1/8C2dcgF/LjK
         ctIg==
X-Gm-Message-State: AOJu0YzjDHFjx+3pRM/0UTqLi3FNjJNFONnuSYxdHDIFptxgyKQvqpbd
	jK2wOGJVUfwBcaC+FxUkuOBsqiYXFT6dMQb6ZuviDBZxJ95yLqmPFV/fYeItWPbmvsn2mJXBT8w
	5NE3E9jdt8whdhwhsMs9twHxyKOtHHxU3lN5ZRw==
X-Google-Smtp-Source: AGHT+IGRAG2+e0nWCRhdPvid9sHsfU07sA9f4xus2JUHYoULnNUjW15Gcyv2WVYba67WuoFAKO5VLAEjL3t6C9W0ADY=
X-Received: by 2002:a05:6102:3712:b0:492:9ca1:d35e with SMTP id
 ada2fe7eead31-49d4145c022mr1387447137.5.1726131363273; Thu, 12 Sep 2024
 01:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911130529.320360981@linuxfoundation.org>
In-Reply-To: <20240911130529.320360981@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Sep 2024 14:25:51 +0530
Message-ID: <CA+G9fYsw_CwZT81J08ZzurfXx1aOQqHvVqro2tp2FdqU69U-NA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/185] 5.10.226-rc2 review
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

On Wed, 11 Sept 2024 at 18:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.226-rc2.gz
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
* kernel: 5.10.226-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6cc7ac2e6d7e0d3dded48744a235d6630d82caa0
* git describe: v5.10.225-186-g6cc7ac2e6d7e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.225-186-g6cc7ac2e6d7e

## Test Regressions (compared to v5.10.224-152-gee485d4aa099)

## Metric Regressions (compared to v5.10.224-152-gee485d4aa099)

## Test Fixes (compared to v5.10.224-152-gee485d4aa099)

## Metric Fixes (compared to v5.10.224-152-gee485d4aa099)

## Test result summary
total: 89626, pass: 73979, fail: 2026, skip: 13552, xfail: 69

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 6 total, 6 passed, 0 failed
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

