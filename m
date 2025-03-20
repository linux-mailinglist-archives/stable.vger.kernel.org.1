Return-Path: <stable+bounces-125636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28111A6A4CD
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D6C7B1E01
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3421CFF7;
	Thu, 20 Mar 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ljb+D9IZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A879C4
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469627; cv=none; b=JeFIpFyaXvjOfWh2MAbqfRaTReq+U3SQTM6dwjW/U2lkSw0MxlxTRu5ZF9l1j0+JdrqO1VlXi1UnW6cmMOuRH2b6I2+aF2lk5SeLiyAIqTSG9qYcEVaxQcYM10YAbylM62EmqkWjcLMiFNFIsLCJUVnaVufG11EPpxIfmXwWWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469627; c=relaxed/simple;
	bh=qqDEyNubMPJ7zCt3oPa0x/EPWryhlCvZzsA7+X0AY6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGK6h56MDd49hVF0sRlTMCDhX4S8OZiCjIh009URDYCCiBdtNB0wW49bGu+gD6dHCRRVNbFrnTXrCj8NzShSyJ53pE5/ZNmkgeEGwRwveplcVyu94DS5WP0COFaJuj8soMBgPedvc9ujow9+nMSPn+9bbv45+jXUoRXh+bZkGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ljb+D9IZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d42f08219so238182241.0
        for <stable@vger.kernel.org>; Thu, 20 Mar 2025 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742469625; x=1743074425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh/p/m1A+uLbYaQNcQdnHgNl8J7Dga3etgiuxry0OWI=;
        b=Ljb+D9IZU03Q1fbuQ9MBsmmkVEKiFLjHYwAzshQ3qGqgQI6JfzWPc3Gvdjsl4aRoLL
         6vGBujJEHWF3rHg9bWOEq8RfuhglMHHGHY0nYLaanapbGjMPXTuQu/jdO6OD3ngoU3/d
         vWFj06VQfaZEuC4DqfDVxrNXzrv7dhQ0CCgpX7GsKTq/vm6S8LgVXeNhsObz3j/6RS1H
         6qXr+9mETFNOEOQZDXOozJAd4ULZNwAHYlHbvyeU1U9Dp2VZNV11sEPoZ0xgKwMoi6Ax
         HP06ALMnt/DiTV43szwy83BQX5LRZJGA6cCFVuKlc62PTIVPZ+hsaKAiPHMX4blOtANH
         v05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469625; x=1743074425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh/p/m1A+uLbYaQNcQdnHgNl8J7Dga3etgiuxry0OWI=;
        b=ZABUiv1cNSqgIUlDDQRqBNo/H8DJxuO1h/Acj1tSPqogPMZdFcg/XietEC9YEypDTf
         HH6do+v1XBnW080OcsWteJ9nbu3k/DQAjErBqnnUNFHb5SyovMJnENXaKISPrzPC00ld
         rkve6RNnSWUEfSS4q/BwENO+OBE9eSyfW/coOZn5eyP3XY+t7DY5r+8TNVxF3GxzG5/u
         A1JdvLHcRqpaWLsfL3K5ooZFlOhLZp8TcxrEYgi8l53jTRH2XC996oSnVaaKNWMDaBHr
         HvMl4OhKhOiwstXrvuCBdswST+6zrO6H6Sq6+Biwhln6AK2HQ8TB3vCnJVDAAmqELdCB
         RyWw==
X-Gm-Message-State: AOJu0Yw/odWumEBzQ34anoXksQNMMgXKxFAu+iz+EUUlC1Hna8+M778x
	WxPuuGHXKO+JVpPydwVYQbdW1A++xOW37He94+BziAiybJYvZLcpO0/LnuNBjwcDqr8Htd65EZf
	m4nWuyguUBpXPCsi19f2GbsaE5LZjcA7NMhOwJg==
X-Gm-Gg: ASbGncu1wzUDKtW37XnlFvQdKfdiXWERG0fccO7bf0WIRY2CffGpyT6LIED0ErsfvI6
	sMs1sDVfLLcB941HK5DI9mqxm4195r3tpvWDIiMSzQXSpV85KCG5tbhzrw+4Nhs3Y2eC2cP51nB
	/2gEHNO8QlqZvZIrd+CIf4/KmlTW0oly9ZS5RZW3D34E6T9SMOtXV63Gc=
X-Google-Smtp-Source: AGHT+IHhoWEXjjkxBLRTLTkbLyln8K0nbCDcpvsOmze6EcD+/4wUp5mfy3/ws4QE+x7mPoXIwZZfiNZmMAMtkvdtLUY=
X-Received: by 2002:a05:6102:e13:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4c4ec681b3bmr4855483137.15.1742469624927; Thu, 20 Mar 2025
 04:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143026.865956961@linuxfoundation.org>
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Mar 2025 16:50:13 +0530
X-Gm-Features: AQ5f1JpN-3B-OZ8yl_fYlt8BRtL9Aj0UDSUVoLXufJCRpVuMPh7D7U1AFDJvN1U
Message-ID: <CA+G9fYvsOJVK=7FD3JwuEVm0oVgLWNCWBc57X9RjwFBhj54U4g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/231] 6.12.20-rc1 review
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

On Wed, 19 Mar 2025 at 20:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.20 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.20-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.20-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 981e6790e1859469af2f2d82ae3c22581fec7ec2
* git describe: v6.12.19-232-g981e6790e185
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.19-232-g981e6790e185

## Test Regressions (compared to v6.12.18-270-g53db7cb59db6)

## Metric Regressions (compared to v6.12.18-270-g53db7cb59db6)

## Test Fixes (compared to v6.12.18-270-g53db7cb59db6)

## Metric Fixes (compared to v6.12.18-270-g53db7cb59db6)

## Test result summary
total: 127126, pass: 104122, fail: 4097, skip: 18842, xfail: 65

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 54 passed, 4 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* ltp-filecaps
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

