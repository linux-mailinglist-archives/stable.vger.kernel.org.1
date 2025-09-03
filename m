Return-Path: <stable+bounces-177569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DEDB415C9
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00301B23B8C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F212D8764;
	Wed,  3 Sep 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+en6jzg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54B2D877A
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883028; cv=none; b=lQj4V8K15ZcNg9kHE0Cd/tXIFN9LJHufpiYZIGgs5LmLLp2pWtGta2wbeNKbKEau2+64QTWRdnkYt8eZ6PeQ/5Oojf9QgSu6wlg6XbCUs1jo4H6z8r2Z4y35o3O7Lm4pq2hsQsGEO10drI2u1YgUQc98b3HATdDReWVupDK8DUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883028; c=relaxed/simple;
	bh=+CzZMuJEXya7F5oV21pY4l6G7TTcJtH9gknq/TQ/aTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6TZhPb4+guNsRZ40K5VP0Yyz7FBAt4WrjmZcyryliU6Im7Cigm57njQlQgtXWKrO5lU0ACghZHZEjbzv+MZZR7TmaiKzbmpN/AHUYkT2jXHeI7O2u61KtInJuCHZyAsLZ245UqWdL8rdDWmlnZ1KGX5TOcS26024LhKd7DrPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+en6jzg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so3176240a12.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756883026; x=1757487826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL4SkVrTJ9oKe7qs7sANkBC9i27TXliw0xssBarmLsc=;
        b=i+en6jzgbJcI1EgytFrX3QvBvWuf7sS+8u4snV43r2jZ9yBtDGKNpGv+MnpgIDIuD7
         0WxhKxniQPtdnt9cROzjxHN/TLUAvZxJ9JjMokc9Q5oYEabPzL7N2NaLSV5An//30cxI
         ErvePIPEMPXJdZeK+DpSRYHI6e2GiQmt4dMLJPD/v7o8oOwFaFBZOyd5yGoPE4iq2htw
         WlzvE7ERxtF0ZYJqvT0dv3vMsAKq02yNevxHs+jKD3buHa9LGqhmpDa0R/hxLMzOfb8Z
         qxNVMxT+nzcdNsDF3AUhCZipj+uMnun3fuFw7Fbc+zde6qJKdn3Wu2J5bwhvcyIEzWex
         K3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883026; x=1757487826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL4SkVrTJ9oKe7qs7sANkBC9i27TXliw0xssBarmLsc=;
        b=AkZ5sohL+rwNlpe2ex97snhzv8KgPZateCuTv4ZrxudPRz1N2Iv1jRKihCr95FeRcv
         Ytvz5SBpLuC3uZigZwMXeCHmxIi5lNjNbQQZCsexamvn/u79f7P8WPugzQb+LNQ79rvJ
         qe6NCZuaWHCLvqizWCCa5Sr0saEPc9HC8VmIusl3qVuKbvua5BgKYwG5OSH/7Bsjstiq
         8ZC4vyeHvHkMaNGiR+EkOOzsBEE4yc0sq5L/eFit1DylC1dSrRra2k+KQZKPM/aWEMwO
         CZWcfJuxssNwdEZpalpI1/lH49T9YKgdptlPVtOlZX7ZKZ+RBbFO5WesIBulbSeQjVXv
         F+PA==
X-Gm-Message-State: AOJu0YxzO08zJchE3jgQuOwG1w02centSV5GYYaXZuMDdmtfe9UNcggv
	c2lq8jVX4JF69yJwU7Jn9lWLd9FbPFwUprtB5rgOH01ZWC08aUZq57b4jdLYkaIRnPgXDuLNYYs
	y8a2IjxooqNE3TBd1Yd99xKSJsv+dmMiO/9Xo97OMbg==
X-Gm-Gg: ASbGncsgq4XC5k456N+1AYQ08NSYxH7hRkkYY1ySqTHXJzE6B84LUMBHqoA9j7PIcMW
	TvJ5zwmZt/LwnUWSrBsdw3pmpsZohupEH213tQLZiDjpivJmBIbHrABk6pSdGR433QgKo8IpQJ7
	QBHMDNd5YbIY19bBm5EqxrxGZyygOelc4gBTB9yer8nHlhwRrJs9f2nV67yzH8LGuAu8wwy/pY9
	a/Uq0+tIvU/dsMhCrsaYTFyvOhSjZ/AYnrlrfGU
X-Google-Smtp-Source: AGHT+IE6Gxv2TMCJAdKOWCYjEhj7lI6inwVBs9oUuCCbiTP1CtDGKISOowssI7uYiatr92QpupXT3zdopt8oyZ18daA=
X-Received: by 2002:a17:90b:17cd:b0:32a:e706:b7b6 with SMTP id
 98e67ed59e1d1-32ae706be21mr3502062a91.11.1756883026133; Wed, 03 Sep 2025
 00:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131927.045875971@linuxfoundation.org>
In-Reply-To: <20250902131927.045875971@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 12:33:33 +0530
X-Gm-Features: Ac12FXyKfC_-aqYgJLlTgXqXUoZh-SGrsO4A4Lu15UJtjPsYwvrVGOG4RJwNdq0
Message-ID: <CA+G9fYsHzdo8BqxV9yLs_NeDE3dB6p6GE4H6RhHWGL-oVMyFsw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/33] 5.15.191-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sept 2025 at 19:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.191 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.191-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.191-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 29918c0c5b353baf87a2bbc3e2a4256c99430dba
* git describe: v5.15.190-34-g29918c0c5b35
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.190-34-g29918c0c5b35

## Test Regressions (compared to v5.15.189-645-ge09f9302f92d)

## Metric Regressions (compared to v5.15.189-645-ge09f9302f92d)

## Test Fixes (compared to v5.15.189-645-ge09f9302f92d)

## Metric Fixes (compared to v5.15.189-645-ge09f9302f92d)

## Test result summary
total: 55718, pass: 45636, fail: 2304, skip: 7414, xfail: 364

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
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
* kselftest-mm
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

