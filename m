Return-Path: <stable+bounces-200124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B3CA64E6
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 08:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A239B306E00A
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61C313E10;
	Fri,  5 Dec 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPWXn5Dq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F44313E05
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918298; cv=none; b=V/ydbUI4rJUYc5RIiZl8qf8/x+Xjza4qZakOrzmVl9xzGa0ecdYUUmWqAE63Zhgd6XQQafq3dCYb5UW3mbkyjtnrhmDcLR8OXNqqRRDN7V8YUwTvmxHb6lCeF2q5VEsJkA05XxpvANGbAcMgc8/HDiSV26oti6LB76sL+FM6yKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918298; c=relaxed/simple;
	bh=9NZuOA5zgfbHyZujREBw5YltA8l0zGHCFatldez1rEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9PUDncnVDZe3AvW2I+XwRKi4K7L9viNDIxyS2sJXguVOBtsYoV1TRPdrINyj4tB9Bfkh018dBKpLIDAIzIfEHDvOhhyjsA9VMF94795Hppv/9KdVTwLEM+99PNlQfwITQJcD8y5cKIBO8jm2KNcOQ5IRbJ2YwKhhFyiKhKimx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPWXn5Dq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bf5c7eb21eeso1782009a12.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764918295; x=1765523095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojOhCkjV3F9ysbTkl+h+IyemdK72RPe0eVx66QhDI5M=;
        b=aPWXn5Dq/yFJFFhX8Q66/b+oIc+6HLW0EUb5Ti1+88/chdHB+017TSowxrf/BMBPh5
         ltBo8OJuCDiczj0roCXaDUeHggTWDv6FcY9QX17fdM5Ehlxuwvfw9cCocFgVNR4hBeL3
         +TXrAeh6Q1G+aGSFnE+Gw+ZyJ0yfUOvlvzizybW4FjVKmfh4N8dl6eZINaspOONFPxsj
         lfqn3c1RvuLwbvsDuZL57im75zRiRvq5XcxT861spAu71/CC8n5D5dFKTo3Vy5nXiYwK
         uj0HAQnJuNharLWXrxQ4z0WUzyxhRBcHHsJ/hiuYooiniEB7HFwWaBvwhx2N+4IK1bMy
         2rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764918295; x=1765523095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojOhCkjV3F9ysbTkl+h+IyemdK72RPe0eVx66QhDI5M=;
        b=YBEGdfZmn688E8WLrK33150TB15wLIEPZdID/GBYzp0KSzNhTmorDq/s+zRGDeX0nT
         Qn50aLZFcK8ZN4InI2zIwg7gEzgHYCxOpnkt5xU0IWGWFiDVGROgBDilbS92tLTBCF9o
         JdDmLGgrOCmt6eDYYBfI1JAAZXgktAtPMQQxRc6X5fV6CKSiW+Cr6qf2ytfHpGr3/nhg
         2a5qKY7g3CfOp+Vtq5bVPa8OvObJkH5bFn7MzGrgd8qva5XM4fnCYGeEKx02/yDZqFos
         k5UFpNsaLzdr0EvN1Tk/E4RhHfkeOH5nRpHulYA+xT1iDb82zTZPq7Ab3lZyqgatKyXm
         Panw==
X-Gm-Message-State: AOJu0YwHaznsov0oewdvy2jpLkShVD3RxBJ5IzjL1HvcT9dIYPM37J3i
	vd/qL1xZczRipXx0dk0jYWMxCuXUma4plSqMrMtsWtHLkSxTV+9BVUwt0Z/hVBEG8gsJQwR2X1l
	0iwYosP8zaMgGWVUOCuiBwramYHIu237t/4Fb5ReaHw==
X-Gm-Gg: ASbGnctfHP/k/qcxjs00z2qPAD1fd2DXcXttXkEN/kAHQBOFV2CjW8ZepDI7c52MiKn
	HgX9+BgUcozFfTzjM+GUHDqVtkCiqdKqOZ+NY5J+9dB4TKoyx9R4/xSxsUW+c1Ey2Q7rmRsMBhD
	ncy61m9bp0l7/x7YViRQCcBQNJLBBxZS+9iAvywjkVcwpvtj54kNRkx5hZCUxdNsSgMQ84ceeUZ
	dA6riXEBOBsT24P8vRQogY7NZMMU0DUrTkrCXNLpr3zN2Uk+7mjyErSSKwu/zsoZjxhboS90lC7
	kBpkT8imuU+Gp6+l0xdqKjk5xz8PYCVGi9bE87o=
X-Google-Smtp-Source: AGHT+IGoJwhbGXUnSZoYZkh6FOz0cBLzPucKnRV7qZqFjuEF8m6wBNjsZOucWGLfHIpaPgJq+m4O5vLCwIVKoOlNi5A=
X-Received: by 2002:a05:7300:e42e:b0:2a6:a306:eff5 with SMTP id
 5a478bee46e88-2aba420e757mr3766256eec.5.1764918294925; Thu, 04 Dec 2025
 23:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204163803.668231017@linuxfoundation.org>
In-Reply-To: <20251204163803.668231017@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Dec 2025 12:34:42 +0530
X-Gm-Features: AQt7F2rTptRNbTdL3k5e8E52D1XEKqAVNE2pIUbGgrlmW25IFDd6auwDD6eRAq4
Message-ID: <CA+G9fYugJOr8uVeeC-Uza4kURw4HFAVSqaP7on6Pivs09AMjfw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/295] 5.10.247-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 at 22:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.247 release.
> There are 295 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 06 Dec 2025 16:37:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.247-rc2.gz
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
* kernel: 5.10.247-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce7ecdbcc4890807dbd45072edb3505e5f747f66
* git describe: v5.10.246-296-gce7ecdbcc489
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.246-296-gce7ecdbcc489

## Test Regressions (compared to v5.10.245-326-g98417fb6195f)

## Metric Regressions (compared to v5.10.245-326-g98417fb6195f)

## Test Fixes (compared to v5.10.245-326-g98417fb6195f)

## Metric Fixes (compared to v5.10.245-326-g98417fb6195f)

## Test result summary
total: 28657, pass: 21883, fail: 2235, skip: 4329, xfail: 210

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

