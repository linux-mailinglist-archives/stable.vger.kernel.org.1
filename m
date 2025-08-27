Return-Path: <stable+bounces-176478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4BDB37EB7
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F3E1BA0A26
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE03164C7;
	Wed, 27 Aug 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiOx7qa7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB31D7E5B
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286593; cv=none; b=gdNPGyNZ76RhzrQI3mYmL7LJJrZTDbJvoudtoAKIURD2WLOeUf1WebtsNZqILWqk+itIfIG5x44PZELi8FUR5SBatAFuh8i6IzmABYRf4U/xnWbWnz+D34coNgybfu21DcfaEbJBplcKZQxrfcJq5T8cTFP7khZtcm3D+/pNK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286593; c=relaxed/simple;
	bh=bwgOcihveHo1IHnUEhXEtpdi3wHT9QoUfXh1TGK/7DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rlgc6aB1+bFvIg85SBEwcAqFBZfqgFxX/X/1aAbJZaxTRMb2jeV+XmPmVPGOz6FAPibotL3T+nnxihY3ELSJK8r9CtDFPfbZFky/Eg/ja/zwE9cxdZ2k+paj32/ZEOY5r4FUIj3Z+pJS8pfoG+CRkeo95noEBof4XoQSInx+ki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiOx7qa7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70de8324efeso261986d6.0
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286591; x=1756891391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy53dfjoHVrP8RNMRiWCawaGbeGl47u9vCoywHsRB4o=;
        b=YiOx7qa7NIDNnXaGBwXU9ndbbZZMeX4Tq9JNZJcIL38ByMYXjRUPuMY9DU+WzG9JCo
         3Ljvulxndx7rfdQkxWIjoFmFuBaEXEl0LdP+2yiUTNKIrmTFBsVXHSAE1flfVLkVoD1r
         T9RFhF4OccpPJEUFn3ei7ubNxyKTq4t3tLeEfQxMlmNkuDJZ2hwrt/5M9ut+pgyiigfG
         iQszXkjMPQcGJqnkWiqdLTDvNR8/MeZIUlxFzW+MS8yaXtQOJLP1+E6bHv3nSfsSXJd5
         qQNsaQuxip5W6YfZ625sWj7ljyooWAJ8y1rzW/VdNGgBwf30bfYW+ClDdIzgYUg716Zg
         UJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286591; x=1756891391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy53dfjoHVrP8RNMRiWCawaGbeGl47u9vCoywHsRB4o=;
        b=iuzmqEsYPMVw6Xv+DKkikHaJVYXnDEc8Vh1pHgnC48AlA7oXYuRSqOzRYe8Y3NH8hs
         /cuZgvdrUXci6zmhtw1TkBy3nw2dcxaSNejYoc/jEh1mfx+W8q9EPBEXkYoMV6XfPHJ+
         R1x78Wk8WLYue4qlm2W81HZtrN8TNz2prwA+4FUxjXirjIJgRUXWCWYLTQV29g4xQu7p
         9bnHMKuIdyrN2YzIO6BmGn56IMxzKdHvlKJ+T4ghQ8WQX+ZPHaIA2AmNWnv2Rpog+dec
         QG8HsuUwi5DbCuneP2YBw/N/WiqOM2udcaplu2Q72rgYLO+lMtK7A7J7W/IchZ3nicHH
         N02w==
X-Gm-Message-State: AOJu0YxgXBkzuDU/3iTSDElAR2fBmfqEDnSWLinV4yJi8JHXBehnrJnN
	dfzsEs+xBwTHHOxh24RejbhDUd/tAYZquxcjTtPlsigjCCvmi+LmacB0RqA5CPrNyF8iaYB4L5A
	CYSu5l+j9UTh2EOSrILbwj407r3NM+vZzcZo17u456Q==
X-Gm-Gg: ASbGncuEdcwu514oxg5jC81x8QXUVhGaAyQ08UJmZsgdoVAEyNxQEB6Ia5tLfEgiM8h
	EzecCwdfJG3B+LivfQ1+NR+UFNtWMdCqtVQjeQqYRdhoRa8zlOlLjvW7AjoqPAcfIi8V144Tr1I
	BgIzedRIEF5Sbwx9fUvSSMjobOn+bai5GVFyUx8TKW34a+vzP4sygpt248/pvZtiNULolHHaSMw
	n4gIVZLXa1uor4y
X-Google-Smtp-Source: AGHT+IEfOA450mJxRrc99VUf+eR6gCbzMwJPgmzNiqytpGVEC9y17SY44iovOMWF7glIDdN/1KXkJR5caySfB5IZEx0=
X-Received: by 2002:a0c:e34c:0:b0:70d:e501:1f90 with SMTP id
 6a1803df08f44-70de5012309mr4016716d6.6.1756286590954; Wed, 27 Aug 2025
 02:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110946.507083938@linuxfoundation.org>
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:22:59 +0200
X-Gm-Features: Ac12FXw6Z8mjq6c5HZ8ZGdhYEx3nZq7WNG2ZP8naHTGP5anPZsnrFM6a1FWSUIY
Message-ID: <CADYN=9JKN_r=wHa_OPCENT3zW2AFe0ana8dP88fowgjh4-NqqQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/644] 5.15.190-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.190 release.
> There are 644 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.190-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 5.15.190-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e09f9302f92d6e366e40ce66054adc57d2bada85
* git describe: v5.15.189-645-ge09f9302f92d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.189-645-ge09f9302f92d

## Test Regressions (compared to v5.15.187-81-gd21affcc10e6)

## Metric Regressions (compared to v5.15.187-81-gd21affcc10e6)

## Test Fixes (compared to v5.15.187-81-gd21affcc10e6)

## Metric Fixes (compared to v5.15.187-81-gd21affcc10e6)

## Test result summary
total: 52799, pass: 43384, fail: 2145, skip: 6975, xfail: 295

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
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

