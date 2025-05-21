Return-Path: <stable+bounces-145792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E074DABEFB2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C777B7043
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC012405ED;
	Wed, 21 May 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVzBGURi"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8423D2B7
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819501; cv=none; b=OgHNeI+VYG3yY+Tfb/rGGE3Wrs1mOxssiWtvsrxXZULlj6c5FEP2jXGNeFO2/wK0NLa24HN4VR+U80ynxOYb3pqdDvn8SXW/UElnBYzy255q7sgqpHgofY+HWGrPTmavsrtZ6Ym4H6n9m9bvLZL4yPrSqfvplS1BVu9UiEshBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819501; c=relaxed/simple;
	bh=SavTODshLkzYqwL86QGyu6EkUkeSNhbB+u+NcCVLQV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+G4qJPNIKgMV0BA3z/gUrjB/LJ09DdOixqTdL/wkbT0lMZXKh0jvX2v6LQc7dTUmmFgFV5+5jmmsrm2bGSCydyR86fPVrqwGOq+/0wvaZsYfyJqC3HE4YR12+o8HwfMpbVNvCtB3hWaJDXPB+6pxRuj7jADss1bWa/XzWTYcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVzBGURi; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e15f5a86dfso2861285137.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747819497; x=1748424297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3hWC1VK1BIw070IJJezvDB/VqZ9aNqLVgo32LJ2soE=;
        b=JVzBGURihtaTNHo49WFRic1f06Li1PnLlst0nBxdCXcUpneC0KTds+UdVeDLywlH/U
         pP5cVPSjOCSsr/2HfmCszLit6Pz/kNurwCvXlFYs77v5rAIchWEBwo5n8cTh3BKKh6Ll
         6YSs7OMahVTSwmoTxlfgd8HJ0hqWXwNNzuLvo1JPVAcJbxyeGGRj6k9+3TPK/DB6OvbG
         L4paxdYmQPpmdsUuGjWjOA1bnIHcZblhZ7CEZjmc9x9ZFoVsYITY9shdVeHqJ48BuegO
         RKUAbcs1wt8ykxYfk8bJBluxJnPEby3U+MtwyqPmiqOrC++TiO2eh7A5ptMpo4n11QVy
         T/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819497; x=1748424297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3hWC1VK1BIw070IJJezvDB/VqZ9aNqLVgo32LJ2soE=;
        b=Vq7skCzjCEgliuNQQaCzkvNYh5ZbiRJPJjIcePQjeSqrQBFyuy16q81gRSRJfxIN3+
         n8NGdGRee66HJuyqllZaV8Khihtt4N/vdALa4JCY4q+clC8P9BoHlCGievuuqZolsm2E
         vCSKa9C1PzJe/ghjFuhb9IknYr8OZdVh2vleTHz+xF/S6aIk8Qyj+LqBnOYiO9NxiqZu
         +Zy76PprNhQDd8fonR/7KjJK2NjrMWJhYcyzPJS5VofXxLslm9Xlf+GlmJieyNK+RLVf
         8nCY+1nefDKjqAY8M2yBIVri5nVvCkaAJTkuut9cO2rnKQ8jy46Q2irUgZZrWKi8LSzK
         8UZw==
X-Gm-Message-State: AOJu0YzJJleSojw/7240sqAvssZ7z1+5X9jAChP8MGCFJU3MeqHZQtsT
	A4B8gesGEM0EQ8DVrOQzRUTnPe5t9uVnjuTR/DescG31wiMVuHS1d+T6WMz+gZqNCJcLsR36S00
	M5CHQqdT3wm54zBFMt3qPtVIgQdQWcYhsihaCAkz/mg==
X-Gm-Gg: ASbGnctEV879/stvtNv4zmZx0eCxd1hKMf079/77NsE1qSfTSgV48RBT9qjgxrECROl
	eMTOWmd1ghHZvEjxUmNZDZ2H0pHzYPt4PnyBP0dEA9F2qksAL38Ks9kMGE2yDaBsGLCQYFUlVyu
	vLmgluOLCIIO3bjNkgMgiy71p/sYtFA4Kd
X-Google-Smtp-Source: AGHT+IHybR48EbvrBa29y9puviflM6BTRI7N0qtLYKnfE4iwghlm6IPecE8XTgSi4fNgHyd9vdOk97NIcw1zz+FQxY4=
X-Received: by 2002:a05:6102:370a:b0:4db:154e:ad1d with SMTP id
 ada2fe7eead31-4dfa6aa8a8fmr19845230137.2.1747819496744; Wed, 21 May 2025
 02:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125810.535475500@linuxfoundation.org>
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 May 2025 14:54:45 +0530
X-Gm-Features: AX0GCFskf24dlsDWbKHkhQN63sjnMSpcZ3dtlC-TQcODUS0EOjnNNGC3AAtyqw8
Message-ID: <CA+G9fYuQf1dvNFru8dtiJnvJZjfKuMwN1DhN0EKrCLCR6DNbnw@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
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

On Tue, 20 May 2025 at 19:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.14.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 75456e272f58170ba9694debd95bb643fc199e6d
* git describe: v6.14.7-146-g75456e272f58
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14=
.7-146-g75456e272f58

## Test Regressions (compared to v6.14.6-198-g6f7a299729d3)

## Metric Regressions (compared to v6.14.6-198-g6f7a299729d3)

## Test Fixes (compared to v6.14.6-198-g6f7a299729d3)

## Metric Fixes (compared to v6.14.6-198-g6f7a299729d3)

## Test result summary
total: 238113, pass: 213864, fail: 4515, skip: 19096, xfail: 638

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 42 passed, 7 failed

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
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

