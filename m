Return-Path: <stable+bounces-124211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03319A5ECFF
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B237A06E1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25161FC7F6;
	Thu, 13 Mar 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTBOAUyb"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDDE1FBCBC
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850904; cv=none; b=NtiX5+EXYQUi6tVr0Gw7W8RjRr2kPg08ZXMtGjWw816p+RwKF/jxn4WKPGVEPqRba+FILjFc0TRNVxMCN7DUDyZSMeYAfWPEps3Z6lGBqSAjayTkXXIg6ER0u82qW9SrbReEC5d7PYAWk3W8CDV1ts7iE3ENPv/TM/vmbaUZacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850904; c=relaxed/simple;
	bh=JJokp/CKQZLqokfC1w2VhhlIWaQHtkolCqS6Urvxxko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaB3KOimvJAcwb3JFnOdlHscB6P6ywxY/dQE8/jcmIyOXFVCvgMXfaRXCjIut8eJH5xR4pTHTLZaY2jLLWdnk7rQVbw8K+LD7VSxOeLkzeBXGYNvlJrvLExTDr7ZPLyu0wJOhLh/A4fGJ6tPDB3HWz+gO+29hUfYybibRmYDXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTBOAUyb; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523b7013dc8so285516e0c.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741850901; x=1742455701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9GsaOplAxyko9C5PtdLfN/NTW4t3muSEZ94FIoQb5g=;
        b=lTBOAUybxs3a4n1SlxvBONF1imvABIVCRVUdDOl6QxHfMBqzfG6WV+DJwJkXdLoL+e
         wGqdAWBlmPAgsw62EZAwD7uoZnG39NiPpyYEah3mNjCu55Fs1GfrMZo5rJsOuSIph2Qi
         h2MlvD9lXHwXkhSJCcBHV2KkrvoghKRMcMearv18JNT4yIgWZXy/cu7WSTSUzDDa/yTC
         lnHH2jK/U/AD90xyjzCfhHLUwPFlah1UhBUVPnjk0bX6aJtzYOr7/jm95rSJNdeECxlP
         ozMs+xrzVQMNJB1ijHsKvb0LCu6hjjeR52j3WmJ12vjGGk4gSYENyhxS9fCC7wV8rBLw
         A70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850901; x=1742455701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9GsaOplAxyko9C5PtdLfN/NTW4t3muSEZ94FIoQb5g=;
        b=UQ5c1UeudfUjDX7V56aemi6oSUZGF6MDO4k3K/R4IabVz7xrqig3OWY0orFFjpcZRO
         aIOw4Msy2Be4oEd5MDi1NsKBietqOrfSyypMEmJVMnc8s8EkcIquo/WEJjTIhmMooeEm
         gwWyuCNqFY3xOK6tydKmumLQx1cg8kqf1z3p1XhkOBmpYfGKD7OnJJem1abU0W1eQbjm
         9kVtG9rs9qCF+ncAXvqX1qJOaKQLWpsXnOthEAjG5Ti/5iZWU/GzQV2aWCzhKLOqAa3M
         4UHVLLDs0UTfZDXS7npVNontNEaEGuEfZYd50np9kYiCc5V46xY9sDOkc35wBdfvQ8fY
         9lGA==
X-Gm-Message-State: AOJu0Yy+lJiHA1FwwQx5FTkCAY0Y9sVqMTAS4aeDRLVvq+r67/Zh6K2e
	QmLHgpSEDGDMWg/9g/e7tIP1+0oeYsObENl+7hSUDnc/uxtw6EYhUOYsChCUaQ3Y7fPT192Tl1d
	hGWPeOXmvzS1Ge0j2XG17ZxSLc3tI8RvEmaX5dye0cUY41qYUg7c=
X-Gm-Gg: ASbGncuTEGilHdgbyfRFt2YXMQOnQWUuugTdIQ1ROlrCNMnyWaltSR2f3+TgH9gOxTN
	ww77zElGb6WzynyRC+TQcgjax9iIlDY0A+xK7Bpmpv+1HMnhIs5YqBUwsUwYsDJtlP1MECikXan
	GgHrZ7gP2dLYhrqROS4r4FFd8nj10nWfAN8FRllecSEwbz9/50wcVygEQ3onh3A/RWdkTJHQ==
X-Google-Smtp-Source: AGHT+IEArvJAZ5UguwGcppghBvPRVvfpId0PIyf+pFN+dOk18wNGtp+xcG06YxdIEMdaeCM8A6U4/JtgkmueEDLNCAI=
X-Received: by 2002:a05:6122:910:b0:523:e175:4af1 with SMTP id
 71dfb90a1353d-523e426529emr19254504e0c.6.1741850901634; Thu, 13 Mar 2025
 00:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311145758.343076290@linuxfoundation.org>
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Mar 2025 12:58:08 +0530
X-Gm-Features: AQ5f1JqaWd2v1fXzfup4wZKObpDD9kkTyqWwE96rDq4hwaFSmi5SULaiVlr9Qa0
Message-ID: <CA+G9fYuBvqPiiuXfd3yZaK489KCwoLt9Sk=tR0jMjSp70YxUJQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/462] 5.10.235-rc1 review
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

On Tue, 11 Mar 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.235 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:56:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.235-rc1.gz
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

NOTE:
The following build errors noticed on arm, arm64 and x86 builds

net/ipv4/udp.c: In function 'udp_send_skb':
include/linux/minmax.h:20:35: warning: comparison of distinct pointer
types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                   ^~

Link:
 - https://storage.tuxsuite.com/public/linaro/anders/builds/2uDdzxpnkQaVOXP=
setXcyEGCkjq/

## Build
* kernel: 5.10.235-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 92c950d96187151bf683889647407b8869ea4641
* git describe: v5.10.234-463-g92c950d96187
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.234-463-g92c950d96187

## Test Regressions (compared to v5.10.233-137-g99689d3bdd98)

## Metric Regressions (compared to v5.10.233-137-g99689d3bdd98)

## Test Fixes (compared to v5.10.233-137-g99689d3bdd98)

## Metric Fixes (compared to v5.10.233-137-g99689d3bdd98)

## Test result summary
total: 49601, pass: 34341, fail: 3928, skip: 10994, xfail: 338

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 24 total, 23 passed, 1 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 11 total, 10 passed, 1 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 29 total, 29 passed, 0 failed

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
* kselftest-x86
* kunit
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

