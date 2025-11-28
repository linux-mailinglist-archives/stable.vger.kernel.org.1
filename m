Return-Path: <stable+bounces-197576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C69C91968
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 572A24E2424
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5C3074AC;
	Fri, 28 Nov 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2tQBVQ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540541FF5E3
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325025; cv=none; b=mjwMXA5gogMg/r/j3oWqlEjg8SyHBybfw6fFUFKCfSMlLRSlmqsRCDCU4VevLHel1ahM4+eNBZWQGbMMunM6xbZ+wAv9Bndk4ctCkxdOwHLryvPd95BnBYHPFEluXIZ/xZSrCQpOTCrUC9EoAYgn8WAXZoKIgi+ZeSVH36Fznhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325025; c=relaxed/simple;
	bh=QquRktftMDvcyPma0rgUuwljbaz7NC2huRrDAGenAys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED+BjwmXBuqtQk0DmPBQ6LEFnEJ+mOtdj6zSNyCjdN9hPiVPlcSo9x9ydOYRW6SbCvy1eiRSt1OvTLSgyHZzmBXJv2GRkncaOZepk7U9td9JQrPKVLfH7mrQofOO+PfWEBNvJJRxgxwZaKSSvytvdKqfRx54J0uOhRMM/d5NM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2tQBVQ7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so1101955a12.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764325022; x=1764929822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PZx5wsg1ZjQV3drbiLEd5LuhaofaILeLheoeksBG0U=;
        b=x2tQBVQ7QWilrKqT6E7Uk6xzX+mfp2IvwYcEFFyrtzlGcDLpFcfTwu9XR9mvZlS/Rw
         bmKcCgAJN9tdzndqCm6jRRu83mSgIJXp+PpkGBWAO6HGQWllrKkpkFd8rT08R5VimFGC
         DHNZINBseZFopHmR4ZIOIh9LN9C7SJ3/y+5M2zFTBJv0PWSf9QWHOg8zYcvHnh/GycS+
         SQlXHB72Z8lGgbc+PiPPE3rsRkVN9QIIju6qmnwJeaEXT/HExfXaLEJNR72Tfn5j4sky
         +5hyIrC7i09M0ewq3GXESLsIaeZR5uGOXaA2ZkfQqVW9IYAouvwT4cBIXI3X/jIDBJDy
         bDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764325022; x=1764929822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PZx5wsg1ZjQV3drbiLEd5LuhaofaILeLheoeksBG0U=;
        b=vIRoBbbGD3zAS/jTLCyJVT5i6o1DqpItKxm8UraJTptQDbpuJf1jy/GanIlXYN5/vn
         GXYhurXBz7yV0efSqcrtGT9+6LEG91nUirfz/AxJvgOdYmNtOBJyozXGCGytAKX687fa
         AYmsYra+SjocljNPsbWmgLVwVeNac8GItat+kBV9jV0/UB8CjPMbT5kdZjlPajq2/7sY
         HI/tdDoYrEN9eUefLuFjvAreNqMff53/JAS08vhKfLItUaX644DMuASDx+dNoJW0QtMA
         FE65fhK75Tnb7GoXqOnBqQow5JR09eceUccka9KDayzrfy//5xquiGL5DauDgGYQZ3jR
         SCOg==
X-Gm-Message-State: AOJu0YwfzV6heHmr2aDdgxfhKmglXUCsmoJhC040JrnTug1W0v2KOF4X
	6NB85WpRyU1tG0gJyTw3gPpLTuS1P72/1ECYpCFvk5BRhunePCYFNAOHdYcGQg2WZo3S/TQ/4BW
	OdN0gpy24uIF4iRKTGDxj3V2cIn85YF6+ejibm+Hyog==
X-Gm-Gg: ASbGnctSwcrhs2v3SfuSG7+a20txsepTl07NWiuJSM/TALthpSgQU4ptahVM8dxuIyQ
	YlSYP0AySLmCfh5tCM9BUw63+h0rtJaxKOhmolTQunh3ctG3CZm6k5zvzhiVtVmP7uhZhXDwG90
	hTCrtiW44mQJ3V6olPgm9otqj4XkVyjFGELGtpWjZ3LrCBdsY/gvHb2GiT6T/SkGlf8ccQZlWbd
	KJ4BBCNF7bVYx8jgwi85AMLazrmH+x1aE9UqxB/IfifYMGBGhwz1krboY/lNh42UxUFeX+SRbW1
	IgAkKRTl3aoFAJ6BY1SJcQ8p+NWd
X-Google-Smtp-Source: AGHT+IFkfDhWTIRrzblzepZhf2mvoytgKEvlWQ48hoDSQZDK0BMZE9C6ONFjiW8+oMVF8PBppQiFHhVZohcSqMDBwNk=
X-Received: by 2002:a05:7301:454b:b0:2a4:3594:72d5 with SMTP id
 5a478bee46e88-2a719097d14mr14878135eec.4.1764325022285; Fri, 28 Nov 2025
 02:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127144027.800761504@linuxfoundation.org>
In-Reply-To: <20251127144027.800761504@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Nov 2025 15:46:49 +0530
X-Gm-Features: AWmQ_blc5AuX8Px43jTHOo2pbTMLgPe0X745nDEbFhaJtbWb4C37gjUJknNf5Ic
Message-ID: <CA+G9fYtzvOZcMhSq_X5frUbQpwO1F-pBhLgOPSQfgvFn2HaWRA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/86] 6.6.118-rc1 review
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

On Thu, 27 Nov 2025 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.118 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 14:40:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.118-rc1.gz
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
* kernel: 6.6.118-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dd9a47301c80082e76fc28ed62e244e42f43a772
* git describe: v6.6.117-87-gdd9a47301c80
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
17-87-gdd9a47301c80

## Test Regressions (compared to v6.6.115-563-g69eeb522a1e2)

## Metric Regressions (compared to v6.6.115-563-g69eeb522a1e2)

## Test Fixes (compared to v6.6.115-563-g69eeb522a1e2)

## Metric Fixes (compared to v6.6.115-563-g69eeb522a1e2)

## Test result summary
total: 104988, pass: 88831, fail: 3183, skip: 12696, xfail: 278

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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

