Return-Path: <stable+bounces-45371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD68C84CA
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D3BB22F44
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0936B09;
	Fri, 17 May 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM+EgeZI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C5374F1
	for <stable@vger.kernel.org>; Fri, 17 May 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941559; cv=none; b=s93nVoLvxYZz9zMWDneyHGPCK4MVJKKGjtI3zYyuSdgYqBbYq8ako44joiI96+1L59L8QMaXqtP3pcyXUyrx0DmHTj0d2BrEUHkAP01VLTxO56P7nJJDVRMwQmN1BqVCfSo8WsfoDETVLJUPTH/TieH9D5+cKKWTv/kxUXrT4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941559; c=relaxed/simple;
	bh=9RhA9rC2oBfCPn+uO5IsICYCEmPPeGE/qi2FoW4MRAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku2Q9R6SZq+EpTkbjkWPyrSRV/fhfsGvTwNUnTlUcLnCWoU7TCQ2QSGLBBYh0PKrnpxFA+x7IP7xV6Koiz92JNWf9ZfSIJxy1Czd3QQXnYrs1kuP6V5bQT3EwiE1WrRNMkFgA8E2ydun9MupiZMo10ATtB4afDVY4kz/tveFxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM+EgeZI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4df32efa5baso219714e0c.2
        for <stable@vger.kernel.org>; Fri, 17 May 2024 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715941556; x=1716546356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2EE4f6Ufhb8Htz2MM1zuJ6IR23b06+w+7Yn1lBm9zs=;
        b=mM+EgeZIDUojioei9ZOW/+tdtiNVyhdosFPJXGxE3WCeubiP65m4U2UtwcgNFFgw0W
         JZWyEhC3wS1a6eBpYQa85hzNPoXCzKc+K92vKAWXz2jJhJg5hkos1AWOnWsV8ou0tkSO
         FbgNLNW4U2JNP5/wH8lI9rdTO6PhpO4EW2pLmvpDZ7ehtUGNPu/fFZOc/+ZNED727gXj
         eCDNUM7qF0gOfW2CGhsj6OwaN1/dYGAY+IDGko20a4ziFbfMibR8DeDzhrl/8epUrOXL
         EkMOsBOWdfCv5/d/jdUkDgIIsjTEIGZTYPOvi4lMCBsHDea4Rh6yWYU2EAHPPJ1QAYg4
         EOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941556; x=1716546356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2EE4f6Ufhb8Htz2MM1zuJ6IR23b06+w+7Yn1lBm9zs=;
        b=q+YvMl3gATWZrBgHTHMrslpquS25bAaSqzAk1P37SufEyVI2ovC4u9bgrCkatWrhlG
         un0BZL3Tnr/7ZkpV9+o9atkxl8Tq1ZqlMlcsc2LbsuVUhtEmvvtltJbxH1Flju0Osob+
         VJ8vx8UM2r2yOSwyabmykh578Kx2i4X23yUb5tP6KCznUSIZ4blpEO7GBWL+JNzSuzxi
         hipNgk9t42WISlHkNDBhRcrqFIrHPt/oZB6LAXNIBQv0j8OeGPOIkp/eYdQSVvTyzb+l
         a5mZVmdflLn9rrAtb10l7zmceDl+P4p2w8kBjmIKsG5HRp/ky1diwrtXZANlKVilA6WE
         QckA==
X-Gm-Message-State: AOJu0YzdZpQfEOXyyjxGT6gEanYdmUuoeik3zu2ie5Dxn48cane8dWNz
	K4MBgM3YHc/5eb6WTzGOGcuRRqYfcM6aQZ9Uok7DcbpQKUkKDVvOFL0HP69IQfL2G9lXjMerSZj
	zy/tEVkVGpRPsRCsu2fbKGG7SW2xgIGZHMQui8w==
X-Google-Smtp-Source: AGHT+IF2tN/OnuYVBEWw9H8Uq3FIX0i6X/TqjD6J+rYvndB4eu6OkINyLYAnQHjMTw8SGUoXLHRkpAApYUL+3+7ScAs=
X-Received: by 2002:a05:6122:a10:b0:4d8:37eb:9562 with SMTP id
 71dfb90a1353d-4df881807a0mr20998642e0c.0.1715941555685; Fri, 17 May 2024
 03:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516091232.619851361@linuxfoundation.org>
In-Reply-To: <20240516091232.619851361@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 May 2024 12:25:44 +0200
Message-ID: <CA+G9fYuVnf0FjnZVT0jXMVQiQPfnSOY-2eiRutT64nkU10CNPw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/244] 6.1.91-rc3 review
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

On Thu, 16 May 2024 at 11:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 09:11:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.91-rc3.gz
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
* kernel: 6.1.91-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 68f58d77e6715a5ff610e494b147f4111109355c
* git describe: v6.1.90-245-g68f58d77e671
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
0-245-g68f58d77e671

## Test Regressions (compared to v6.1.90)

## Metric Regressions (compared to v6.1.90)

## Test Fixes (compared to v6.1.90)

## Metric Fixes (compared to v6.1.90)

## Test result summary
total: 141267, pass: 121511, fail: 2604, skip: 16980, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

