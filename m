Return-Path: <stable+bounces-66078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41294C34C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2D31F228CF
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400119148A;
	Thu,  8 Aug 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIUvtK1H"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FF18FC99
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136604; cv=none; b=Kc/S57HpTxwHfA37MDSlL9jL8IG0aj29WOpkxwSWR1EssIGHd118MEjR31mAtFm/juCW+NhEUUIMvqqMJkRzlJGdTTSyqKlcKlrLPWyQjOPJUVW82gpnqYDLpsA+ear8vE4PHWxtGMmCaoqR4hYVPpgKGJOBqAu/FK4LiCBvV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136604; c=relaxed/simple;
	bh=lUIo6oiQqZK5O1iQi9Ew80iJexWTxa4LW10DgVsgQfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r13Bda/PDMdIPgaaR2oYZvHvfhl0FL+UIfXFEeG0tAA0UOmt3QUTxxsPgE+34PuazPbiamJ9vYPh8tjgxWVPabax/rMmrDKfr3G40BndjpSAXWH67hVbid7nqQiRk1Ok8FT8dXmv2CAWOvu+Mt3BTdFAmvKcelfMGvEbxP711/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIUvtK1H; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7a4668f07so6310566d6.1
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723136600; x=1723741400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Kn9FeTQTB0XeKhPb+Dnbovz4C39z8Mc/z6dR8N/Dg=;
        b=IIUvtK1Hom2mMHkKreWcDcKx0nCHsCrs/VEmrRa4/8EdmEu+eYjsc7i3AOsL33Jrh7
         g50DZZ90xL02pDLdpDxg4PsDlU2+C26Iah7NI3Ef3f9anuEGjGntL0oHKYGk5mq7YlKq
         dPfThHoLX7/jNNduKxwrlG8Pi2oHwvYUzMAxB9X3uDn/+RwiHabHl6c3MyeXaViYl1hJ
         9JZJuOpdb+Ye1g/kMfo1zv1YcxEccW+bOfVUXtcvWLKWSPPBski4XCwvxVc2mSBTMzuZ
         Gevc3le5mBZoVQ8o3xa3mBRy5WatH//AS3QLmq0B/E7jEuc3I2BbidxOm1NeHPHb8QnI
         ru7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136600; x=1723741400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3Kn9FeTQTB0XeKhPb+Dnbovz4C39z8Mc/z6dR8N/Dg=;
        b=Dji/DRu3xcuHmT04h6YuQdgQcpLr0aLAjPCh5qJ/JXxYEIEsfqKIyU7RgXW28fSzai
         lokz6zGF1OFI+DC8PCo0YFJqV90veY/HJxOsz+BBqUwQYTeR40fZNa+XHOp5qXdJnnEH
         OpJxLsVFWmB1WgexWSxPug175Hv5RggGL+8yn/bJ48bOwG6wBOtGZKm5N0G2ZNHeDbx8
         gzYfubWp2VkdNOiKVjB0Hx6g0tynvqltecVZveKhUhaw8gRS/RdyQPpUuKKCt+1vTkCn
         j1QAwv/KTsLWkQOzTyEaZNdLFuC8fXs8b6ESvl1kUpGhIvThpSpdkVaOLXrUYNTxcbHP
         Ev1Q==
X-Gm-Message-State: AOJu0YxkGfVaatuqCCgLst+ytB1hMfXiaXd9HjlmhUtMfKQzMubzK1RL
	Z4Fs/HqzZjEsWcrBiZWonPj+vOGvrBa/xqfy985YzGhfBsbQ3THQZJpd3f3rrS+5ffk5mNTk2jt
	PzzYjTXHHHGlA7Mki7bEGoFYnkTbC6eoXVX6UOg==
X-Google-Smtp-Source: AGHT+IFjDUaYYSyQivtnc/qZepRTvoD/qVoK7yZkNmzYgvZXacGVlug0bjBLL/TbDDwlXws31s4fImRRGLs56AiTg4I=
X-Received: by 2002:a0c:f410:0:b0:6b5:ea99:bdcb with SMTP id
 6a1803df08f44-6bd6bd745aemr30909856d6.42.1723136600096; Thu, 08 Aug 2024
 10:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808091131.014292134@linuxfoundation.org>
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 8 Aug 2024 19:03:08 +0200
Message-ID: <CADYN=9LA_eMtMjyyyUNyT=Rsr030HNK1J1u9qYtuHvYApK4E5g@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 11:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.104-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 54b8e3a13b43747af658936db1fa59a365d52997
* git describe: v6.1.103-87-g54b8e3a13b43
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.103-87-g54b8e3a13b43

## Test Regressions (compared to v6.1.102-441-gdbbffaaee188)

## Metric Regressions (compared to v6.1.102-441-gdbbffaaee188)

## Test Fixes (compared to v6.1.102-441-gdbbffaaee188)

## Metric Fixes (compared to v6.1.102-441-gdbbffaaee188)

## Test result summary
total: 219072, pass: 188702, fail: 2594, skip: 27408, xfail: 368

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-timesync-off
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
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

