Return-Path: <stable+bounces-42862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D681C8B8866
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0558E1C2163F
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115352F6A;
	Wed,  1 May 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niLiRkdo"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EA524DD
	for <stable@vger.kernel.org>; Wed,  1 May 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558441; cv=none; b=qCx5OxHgEXTW7Nh2SqJ3XlgLVhN5HTUA95AUIcuNuOGRyKVKZsJ+c/JE9XmB+dV42BHYA4XQvYfp3CvnUtapxV82EhFLQzADz1nbJKRStekd+t59r1po4tX8zNXowXfEctMeB2FB6yZ6U2xNWrxezRjJ5CkYSTK0QmZJWnws5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558441; c=relaxed/simple;
	bh=R4fmjy+8hfGHxDfrhgKhaTl+RpHiDKixsqP18LZW7AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5lWFy8ECE7NftLyeeCdjxkWpG1w8XbFhkEOVtkcyhRsAVUO32R/dzs9SM2Lq2rljZwN3vIveM1ooZOQd4SWJrbF5QfCXtsOmQJb7O+ie7SB5etoaQZq7N6rBdMRkwMEzpw0fwCWT0UfjMzDH/wB11il18FkCfV7hNlQ8s3wt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niLiRkdo; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4db24342894so2381910e0c.0
        for <stable@vger.kernel.org>; Wed, 01 May 2024 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714558439; x=1715163239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbIjCKOEuz58/k1pZWu5FN3AtpqH/WknsKLnXxTqtW8=;
        b=niLiRkdooedgn2m6DgDsy3QuYbspmUovyfp6ciV5Bjtyg1nLolx4ab+C6MUqxeBFRg
         Ju5a0WIHMrJpsTLkVv/gNOM0eL2PDKjBSsm5F/oqO/xnHrCK43LqerD8Fd1FC8pec9BH
         CiEK8IjD/ExJx6JreEEWXvHWpcxXQ8ozCd9Az/jIlDeNiyCL5Dgc7eUAKtxLyle8/xSw
         J5kNFA/Hq7rEgJY1B9Mt9nH59E5uzBCxT6zPXVfqHFrLjub5NsO9RiD4R6wLycT6P31d
         3eS9xF9V0AEhvSTk72a0dQMaPig9rB/jV7533+6JK0mlQv3CQ1yUv54s8mZ2qnkZt7Xg
         D+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558439; x=1715163239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbIjCKOEuz58/k1pZWu5FN3AtpqH/WknsKLnXxTqtW8=;
        b=YiA9MnE6vJrUrIiTpZGZyO0z0Cb3kWPdlBJGo2y3Mnjz/PKiaOnDuGSkzbSMbFvRov
         1MGVv5/S7vPSwSQIN8ZYtuIDS9HPP5W9hVEZHQSLQfnq7HjLGMdSetICGofqwhx0X+ct
         dLCh13+Pj4WU9Sb+lzKxSkG2DcpIQAIkcpLvlBMebu9FbMur7IWnXAry2svM1tkrhYiW
         jJCX8nVoKkndTKD1uE/dRbT/sdTfrka5XsSpvkTNthc7ki77bU3A8dSHaC6+0UNmdarX
         Q8ucfJjqKZPS0Bo9Pt7WYyZaq+biUBmlXHJQIKdBo1YRk/78FJo44ESIJ4OkuCGhQtKv
         18sw==
X-Gm-Message-State: AOJu0Yxkllh16lsjfwaKXLF7oyfRAM2JAaFd/W1pOWWIkCnhlGsRJJzC
	/B61NuctMFE2hpzVjlZ558OaSfyJIQfX4Z54U1nYxLRSLl/lVpKm7a1nPn7WnXN+i+qarqzBi0Q
	IULXvXvIVtJwavf13gSOVZA4n8Bua3RZny7UjNQ==
X-Google-Smtp-Source: AGHT+IGPZVswxDsVKQ85QCYc6SsPa5oLux4hMYc+4nof+Quq002rktVnJ9FzL5fqHueqx254hm//pDt9M9EdnP1v8bg=
X-Received: by 2002:a05:6122:1695:b0:4da:a82e:95f5 with SMTP id
 21-20020a056122169500b004daa82e95f5mr2140942vkl.5.1714558439121; Wed, 01 May
 2024 03:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103047.561802595@linuxfoundation.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 15:43:47 +0530
Message-ID: <CA+G9fYu8cj_wEwWLeWwO5krCfnKbKbNZ=sgnZkAXSi-0XmbbXA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
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

On Tue, 30 Apr 2024 at 16:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.90-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.90-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b3fba631803defe65cfb1653433902b510db9330
* git describe: v6.1.88-113-gb3fba631803d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
8-113-gb3fba631803d

## Test Regressions (compared to v6.1.87)

## Metric Regressions (compared to v6.1.87)

## Test Fixes (compared to v6.1.87)

## Metric Fixes (compared to v6.1.87)

## Test result summary
total: 142192, pass: 121440, fail: 2635, skip: 17971, xfail: 146

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
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

