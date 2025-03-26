Return-Path: <stable+bounces-126720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D319A719D7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0C18896F5
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A47145FE0;
	Wed, 26 Mar 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uox5S6vi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CC1F94C
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001366; cv=none; b=uz0w19fzNo+nWXmvwdpaQGGbf0DPblo5Ze+XI4+qqkTzjxt1Rt97imzjdCrnwzFJjq75o3NZuFMo18qLdjy2Fqf/Q2aDg6u/VioyH8xP0Tnh0aVrBFRyV9H+4Z+cdo6vWJElCnAyXZavR2IoJPlLErwjPqsxBr1hJxqxD523U20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001366; c=relaxed/simple;
	bh=i5hMjU1U1CkBVthPy1e8u9OZ2c98Rx6n2+cQ6fD3/LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQbJ8N6XLA9UJ4HhOLM2DBT38Ixf9JlaGei2MGg1TN0M0EBJx02yBhdgPkEBCSS7T6ALZ26qj+b68zMGet0uxpmLim21ySIfujidoWdTUzyFoLtEnFBfz1VgP9YwAC7q8AkmZ0SNiy2puzAikeRjdCD4oo/4r5euNasCPlQ89KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uox5S6vi; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72bb97260ceso1651502a34.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743001364; x=1743606164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsQsH6ANdGylJ4qh5rKlnocfjpKm1sZHbMXP7G2f3lY=;
        b=Uox5S6vigTD5AJnYOiVhKHoufrC3S9Puy09KDkKYY4ChxMxk606ZWj8Gc3lqvOMfCj
         ZE9msCd7RYSCJHEDnNWmpL9dqJkmGRM0DHBU9s+9UwH50lZZ5lpJPjBHZNnvuJvHyan4
         2yM950BViAFhwbWS0AmAvCIKzS4jFrPZy5wm3dTbkiQr6oQYi9JVk7GhSrjxFHDO8Suk
         s1xUPR6hWhiNeAWuYIPmX3vub5gPlm48Qb73eN2VxtiqubE59WfX7Vcgi2Xlk3Bxipwn
         91FtO8zg9ZwzcTsRRZNy0mHQWA2lOayUd3I7b1NMMRCaMlVftp+7m/EjnnL/GtuBCnAj
         8+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001364; x=1743606164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsQsH6ANdGylJ4qh5rKlnocfjpKm1sZHbMXP7G2f3lY=;
        b=ftfd6c77FAliR/mZQxo3m5Z/O07jyfbI3j79Wo8sbDYwpptvF9FLVjWA7Jyva/Vu+o
         wJXqTnI4JXn/8W3M/awXmgTfEYgnz75UMtKBK24aNOiJ8Q7JQaJxk4Rwd9oattmsIBng
         7RWYxglfQ3aE4CwZZH49kiVuLoK4c4xeWTZ1PWKPCww/MFmIAa7MUERGsKNI1jG0ZSVC
         9VINf/W8jpmfZwe+JS25sQhDGLkAj0jD0aup0KH/jmWQt+augmHKxcCm573BmI6KuKh4
         gSxk3hTRBwKsr5LNXfrWFKPEECtbuH4pQk1EaBjn80NRHCpOI9T5lcCwa/pMJVg0jQg+
         coJw==
X-Gm-Message-State: AOJu0Yx4lPpavK+mljsXPrvjyvLV8gDTfSD11yQKJLSN5tt5JKkB9soV
	TElBdbDvy2FZMFL2JHhKF2NOHgKlF+8PE8sJhmnV4ZsLwLK1vhxSWoMNbgqetVURZfhaLo8/9ww
	9AeVNs88/KH5RDmAOdG3O3fiNEWdfh3RXXHj1yg==
X-Gm-Gg: ASbGncsSsO59XmN6tsGKk9/KjhcE6L/Z/MULnoFER0eec/Q5Kc/MFZCbGd/H9zlJej+
	haczQwmWp465DOrqGN4oyDkrtnsw+jcnUtOHf+Cu07YxNdbM1kmV5gRLpRz7MymFX0FQrhaNBDU
	Zz8TiiBok2vAVuniaEIJ1I3Pn1EJGuDoYAInFO4bT0A8ucSUnKlPGQ4DxondU=
X-Google-Smtp-Source: AGHT+IHdcefyjBpzy0SXc/gjf6ixzyEAvMSxlQARHmWO0KujbdT/yemJQiyccWHif1y+OoGvmwj/eDGDDvZ15smLS5c=
X-Received: by 2002:a05:6808:189a:b0:3f8:7c69:561b with SMTP id
 5614622812f47-3febf72652cmr12310211b6e.14.1743001363865; Wed, 26 Mar 2025
 08:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.058346343@linuxfoundation.org>
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Mar 2025 20:32:31 +0530
X-Gm-Features: AQ5f1JrWdvxkbIUeJHzGZu_R-JluYE3DALzZRXxu_gTDRsdp-_SvEVbZdV9RPOA
Message-ID: <CA+G9fYvOjHPg14GCU4kLQF+PukgjsXUAY2sLCB=dwYMTa3iRmg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
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

On Tue, 25 Mar 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

## Build
* kernel: 6.13.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3d21aad34dfa8c234590743dfbe06d6bdf633301
* git describe: v6.13.7-362-g3d21aad34dfa
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.7-362-g3d21aad34dfa

## Test Regressions (compared to v6.13.7-242-g14de9a7d510f)

## Metric Regressions (compared to v6.13.7-242-g14de9a7d510f)

## Test Fixes (compared to v6.13.7-242-g14de9a7d510f)

## Metric Fixes (compared to v6.13.7-242-g14de9a7d510f)

## Test result summary
total: 130921, pass: 107776, fail: 3814, skip: 19331, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 57 passed, 1 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
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
* kselftest-rust
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

