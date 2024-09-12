Return-Path: <stable+bounces-75973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0F4976539
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC24D1C228EE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F901922EE;
	Thu, 12 Sep 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOXf2y3b"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA15188910
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132187; cv=none; b=PS66wz+hc0RkXnIx6acqJiCiVPaulYcVxoOsj6l7fCSx7MA67/sdDuV4bB/682mxDS55LgWN9x5L2QteatSz31bKF3s78cC4UVZc5af8CEFBUd75R8ykei9+KTjm+k7lP96evbm9kaE4GvaUtfyo62P+D3ThrFHLaB7E2Tx4WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132187; c=relaxed/simple;
	bh=CtjNbXIYcgh5YBZ+QQZwKS91eTGf5pyfKKmAeEYnfWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lojcda4ttAt7aHtz3mYM2yzwWmDoVsTJBAH0myzEw0YbdW6WliulN9SZA7eFNfQvpTCCJY+Jqzo/Ihw6xJjG9zLWCFFJ7hf8YV5DzNypzPXkcWyyTOA/uA4qeIRgF6Q+vqFe9BB7isv7sR/mPNm9gKcLVLJSMj2Zhr5GMl2inGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BOXf2y3b; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bdc6e2e2cso297299137.0
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726132185; x=1726736985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UatKUvp1pYDZvjY6oNaEb1ql1MN49sf3jLFsiNrWAGw=;
        b=BOXf2y3btsoSchFChkNMrR+4erwOysLffzYTQa3MH9SEcTfagOLVIAyVDwdT28Iigb
         kUbPNyj0AUYj/hpLVjC2Imvpph150oha8y8tzQVHD+ejsjnjjeE2f3ZBO0TOyAvnJyJC
         WwGlEM/YOKh7Y0Lzb36eYl48P5mqt6BnzLGvY84LF5sajHNx1skYPoa/Fgw5JWJk8u5t
         mFcOr3EjvB+u25d1hG+fjT0AO8G+d7gn4sFTnyCq/bLkLhJcDYGyUjcGVfP6O6jhIAOB
         csCQ8UHw4L3/cGAL6FwAI7vO22TURVGkIvtsjCpTmaDn0aLu11bUaNoNo4XgwbUm7f9a
         w3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726132185; x=1726736985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UatKUvp1pYDZvjY6oNaEb1ql1MN49sf3jLFsiNrWAGw=;
        b=lYqW7cssHxw5ZecF6ODh86hG/JSLXmWVrznDhXPIj1D5MRQjTZ+hMmkiTvJu20J6Cr
         Ed3n0hP+S0GUzoAkE3Kcr9ngkE7Wa9tgWezCLueixhZpzn/CC4e9oZR1fTUJMwLuq4hF
         61QSLjrCSjfcijNRTNxcWfS6anKmjiQ6NpoV6BhapYTDH3LWl0fJPByKqXudtxNfF3FT
         FmpT3EKTJ1tUTNmkZhfMofsngM0QeFvAifZDH3Pn1Vmavj0X7REAXp2ntohf0MfIvr8y
         JDYliOSXvkBsFldaptnKTpujUQPcANvSe1vueszlISNKTB8lEZRxYgwLHKQGKnZazpA0
         YCmg==
X-Gm-Message-State: AOJu0YwbCkYZ0PxtMpEU/d18ab4tgBk5IJHuvQm3T/TvChT7NZEQAHNg
	KoGOrarZ6k+N37r0pOfqEqD26e3TyHujU6xnAIBgXnDeSBSfZfke/h6kIpkIPtpdMItk1om1krP
	gSYPh2nM6f2+zYJJeV3nS/lq9ziySmLi7YA3hsA==
X-Google-Smtp-Source: AGHT+IGz0PbkoIwHKO0L6/298IeFlNf+Zwku+KeXskvK1GrqkgQeXRL1qLXEbBOqObscNX0b2JOvIPDn+Vxpg4ujjps=
X-Received: by 2002:a05:6102:ccd:b0:494:4fdd:4b7a with SMTP id
 ada2fe7eead31-49d414f314dmr2517039137.17.1726132184946; Thu, 12 Sep 2024
 02:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911130518.626277627@linuxfoundation.org>
In-Reply-To: <20240911130518.626277627@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Sep 2024 14:39:33 +0530
Message-ID: <CA+G9fYufxhcw_+22TEMu4Ae9V7JbGbK38UZSE39+vB1Bf9vwaQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc2 review
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
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.284-rc2.gz
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
* kernel: 5.4.284-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 10d97a96b444c199de9b2a768ff73dcffee34c46
* git describe: v5.4.283-122-g10d97a96b444
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
83-122-g10d97a96b444

## Test Regressions (compared to v5.4.282-135-g6561e7052c34)

## Metric Regressions (compared to v5.4.282-135-g6561e7052c34)

## Test Fixes (compared to v5.4.282-135-g6561e7052c34)

## Metric Fixes (compared to v5.4.282-135-g6561e7052c34)

## Test result summary
total: 99812, pass: 82217, fail: 1355, skip: 16161, xfail: 79

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 6 total, 6 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
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

