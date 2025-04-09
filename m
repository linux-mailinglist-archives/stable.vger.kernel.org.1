Return-Path: <stable+bounces-131911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFBA82070
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C823C3A929F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1025D1ED;
	Wed,  9 Apr 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhLFnkQc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB72505A7
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188292; cv=none; b=MB6tKh0qYfwMda3/NrLdWhJAb1yfh1zlRv85JPLXbkxyu20iAjhqB4OH4zq3CMqOb0t6xMyWa7jrA46THUwVAn7P/clrG1sxxnX48JRWU/HBVlB+d9rDlpIKyHNgC4Sr6TqpIv+VuSge6dtT0/Ipb/iXRZfIlMfg2O7myRpCezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188292; c=relaxed/simple;
	bh=UcvtGqHftKcHDySqW5lny9qK57wRwrXMss3CirE7KYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+9rf4ExZhR2F9BkmTWfi/c46HoTdriH047dwdnwqxlbyTNlC8ETY1BMuF/h5g/h1JvUs3acjMGYwgCjMjJCZhEaEUCzpAnekuKSGPUs6HDl2bVCsRl0sJgu2r1SuA4pjMnNiH4b1E+zj2bsLCRBM5GpJ89V08FwmeItry+2TRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhLFnkQc; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86feb848764so2679338241.0
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744188288; x=1744793088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sATv1P8kIDaxvXmhiWDZnHa3AJJeCbV8agMtPDw+RK0=;
        b=KhLFnkQcdfv9Hf84LX23dHvmWrp3P9ej+e1vSw7gHIQQsLdJfMSBebD3v6l3pkx2Rz
         1Ua1DGcSBjxkDkZPrTtpceT+TqiektoC7wZlYBrGRE2AkS4gPSpGPXuR/cPFmeTXv0Rb
         qqiT/Ow3Oy1m/KeZ96M6qHxeLLqasMpTOoo+aADZmfkmr+7g8E1S6c7/VDexoWPP9hrV
         jctfqf64cCsAoYGh5T2EC/RzEDxAPfhhV8pfvLdSUFtRAT+QUlqQkD4CuxOQ/EkcwChi
         9qUVNc4P5Wj23WhjzcHBWfPhOqjKjedbG0hpVFFX3jWt6Kj+lAyEdh05OvSULmDqhzIg
         MTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744188288; x=1744793088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sATv1P8kIDaxvXmhiWDZnHa3AJJeCbV8agMtPDw+RK0=;
        b=B/QfOaVxejqB2dTwcO2aJYqyv0zdfnsKp5l2OHQQ76kC7TK5HhIbAKHBo5p+AiKFQW
         j2xEX2BVDHeKfHG5zHhztkZiidmosHs+KzcYITHhTpbfiIeAW9Fx0fv9micWiUt0G7oR
         VR7ImqPlizXORCKdTCAyrZQjOA0KghnVBct1SaE+jn1K+gnkvZTmqnM74y9WTwsTENgT
         J1vrU0D+20WvybMBivv3ZjO0dbT51N1xonvAQgsn+S64a7pOAxfC3ZYHjWnH92W3jfq0
         k5Iyov//GmlVhzjKqlGyZ9AJjSfXuyZK4Br+U+ZcIZJh5ZHKCisa4z7bKVOCRW6PVvp3
         9aiw==
X-Gm-Message-State: AOJu0YwGSEp3TloTdy2HpscAGt5p0Ey/vPKpvbe9Yxij70JQ3IRBc4Kj
	NQrQXddX5CE+G8htU9UCSwbQKDrIdpMSfYshnBUnW0NXYxOrw4dCLogyoU+j42vzuq68FyG4UcX
	FgvYGb3YO8BhL4q6h2s9xBiA63G3FZhbgwT4/8Q==
X-Gm-Gg: ASbGncv8/3hZqp3FhEnEQBjEPNtq8ClFQgbm07GIDSjpgIEzpZlTr5JMMRxzXvmZL/y
	M4zzPP5hMwkNOhcP+ys/CGY6hfBTlJuyJaxVpMNEP97aMF1OyyrOtAMuc+9QYUr02TJqZsLFVad
	71tNq6wHsfMI/CDewBPk5/0IfbUz41UNzumUnKPj8C2G5PK/g4NWY+3JAYfsZhVT9rpg==
X-Google-Smtp-Source: AGHT+IF9PDjhz3U36sr0FPKCEjNWE0KhBMW5VnpWdv19NKllNss6oXXHmudrq06C4RiYlOViR38uV0s61R7zimmsuhU=
X-Received: by 2002:a05:6102:5687:b0:4c4:dead:59ab with SMTP id
 ada2fe7eead31-4c9c4139f4dmr1382352137.5.1744188287694; Wed, 09 Apr 2025
 01:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104820.266892317@linuxfoundation.org>
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Apr 2025 14:14:35 +0530
X-Gm-Features: ATxdqUESOUek8Y77NxlUr1DELbiAjzQAVXUxD6eVLLLehUNSHSoPSk49XX2dSlc
Message-ID: <CA+G9fYvgLrfNKgP0h5fwOu54a+kNVA0652aGey+A7xVzyjwe9A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/204] 6.1.134-rc1 review
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

On Tue, 8 Apr 2025 at 18:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.134-rc1.gz
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
* kernel: 6.1.134-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 41c273b7c6e5686866a063a29a03f95e3970fd7f
* git describe: v6.1.133-205-g41c273b7c6e5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
33-205-g41c273b7c6e5

## Test Regressions (compared to v6.1.131-221-g819efe388d47)

## Metric Regressions (compared to v6.1.131-221-g819efe388d47)

## Test Fixes (compared to v6.1.131-221-g819efe388d47)

## Metric Fixes (compared to v6.1.131-221-g819efe388d47)

## Test result summary
total: 79336, pass: 60518, fail: 4593, skip: 13917, xfail: 308

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 133 passed, 2 failed
* arm64: 43 total, 42 passed, 1 failed
* i386: 27 total, 23 passed, 4 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 29 passed, 3 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 34 passed, 1 failed

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

