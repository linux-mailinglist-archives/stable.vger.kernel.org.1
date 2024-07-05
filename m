Return-Path: <stable+bounces-58105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC3928164
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483DD1F23272
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D512FF96;
	Fri,  5 Jul 2024 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+9h/OfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDA1C6A0
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720156784; cv=none; b=B0hjp0wOSHduNCJ6V08ld+3R02SUKQ1VvRw4VIVaq8iQeQGVQyDSgMvHhrXmuP6lTUujcERVywbnY3db6rn6v0/oPmsxZZy5QWVXLHQWiWHuMiBgK0bNl3MMSRd7DHhmpfaPP75gb2eg3pSvGWCcUmsY6T120m9N6nlmCRc3/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720156784; c=relaxed/simple;
	bh=W5j6a/WBCFe+fGsj0N2OEWSozhjt42IaZwKXVEvzDIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLkfW99KutP/0lXN+Au9VkqmN1EW8I8KvLbjHF+PoGhrr9X+p21kbqBp6FObc+FIINnRcJ+Ji1UHvqSe6j8Oy4CGcOTZg06oYTiXkveY/jZo7kY7L1LXxJXdYbmztFyJLJiLUgqPsO/flPmQWcSfzrVFid/psTZl99uxOULAMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+9h/OfM; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f2e2795350so1071318e0c.0
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720156780; x=1720761580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Rbwslc1YUoORxX9xF6DoNOsXrVeWvYykz6W0DdakVY=;
        b=s+9h/OfMp97bFdhLBLMco7IrLrg3TLPI2aeFEbhssz3MXEol7e5RYTB786es+Y+AXp
         Nt5eeVqrTHsxtqCjBzwBJawmNJmw+2dX+lClnsJDZLBKaDm/jW3D2gRb0i578NwCNgnV
         9pZK8KiuYAdTEdpp/dGtoB7wXI7LO6IDrJbFKOzOnv7gLpyLjbdeVxGDziobtWSt6EK6
         XbZ3SxVojpUxEgEdR5n1Qpt83/XR8eLzvuxdFoOIp2EMEFl1CVh1lmltMjRaFPoB7kRj
         +oSqM8vklokS9mQjKyGvR/ToX8y5Gy8jBF6jSYB0BWyMVYIbwJOcFNvEuUqyEQrp/W5/
         KyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720156780; x=1720761580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Rbwslc1YUoORxX9xF6DoNOsXrVeWvYykz6W0DdakVY=;
        b=kDH28TzKEIjimO/HqMn/xbC3eeLFJXvfRlv9RAJXpAmIfcgwUa9bVdKusRoIKX21OD
         7bvfZB6UDF+Ggval9A5E9XzEWB19xxM1cuL9QEkrAMtQG/IY7/L5/AfhvyAzlvHb9JyB
         T9h7KgA8Z8iq9OCQSMn0sMI0Xei/5RWGd9Is2NEjIqS9x95coXFeYcX3G1lBec6rqaQu
         c3G1o/xahrBnG5KuqgKlvb9KkSflpJeHVPe3a7nKaxk4NrquUK8VpzQSjGB/Gq+RAoZQ
         rtX7+7ZC/hDch9BfSQF4zSksNab8yPPBKZMoR8xkkMyQ1wJqP7Gij7yOMNQep2EAW26t
         bZiw==
X-Gm-Message-State: AOJu0Yx+Y0VsCD2I1x48NSkLFqsbI/H7LfZPiCtKvANoLuy+nXtm5VmM
	ITDS4v8bof49wL4kjZado76/RcFCwbWLmj7WH8ZpwEffLeKmIRQJAAVnMTsctUWnVVfjIzrLvDr
	aolXsk0v2Xy0AfN3/wyt0QUBHZlVaxv5FmORhOQ==
X-Google-Smtp-Source: AGHT+IHMRf4CngznlnyynL/FplZL4zyIqzXKH4k86LNrfkWCGbFINlqeWFxDl3dSH5R2X9FxGJlmheib+X0zUJf5GlU=
X-Received: by 2002:a05:6122:4a14:b0:4eb:554f:20a9 with SMTP id
 71dfb90a1353d-4f2f60f95cbmr2318873e0c.5.1720156780551; Thu, 04 Jul 2024
 22:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704094447.657619578@linuxfoundation.org>
In-Reply-To: <20240704094447.657619578@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Jul 2024 10:49:29 +0530
Message-ID: <CA+G9fYtpctyKVKQUjNawKNSbsu_TrsNuoXKVvWtinBN4KHu+fw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/183] 5.4.279-rc2 review
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

On Thu, 4 Jul 2024 at 15:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 06 Jul 2024 09:44:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.279-rc2.gz
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
* kernel: 5.4.279-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: eee0f6627f7476f90ba9520fce5a25563c0c4d9a
* git describe: v5.4.278-184-geee0f6627f74
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
78-184-geee0f6627f74

## Test Regressions (compared to v5.4.278)

## Metric Regressions (compared to v5.4.278)

## Test Fixes (compared to v5.4.278)

## Metric Fixes (compared to v5.4.278)

## Test result summary
total: 135814, pass: 109531, fail: 2397, skip: 23766, xfail: 120

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

