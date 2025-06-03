Return-Path: <stable+bounces-150660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61DACC1B7
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CC316FF97
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963B280325;
	Tue,  3 Jun 2025 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPM5t7yA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F280315
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938051; cv=none; b=X9mceM6Q4JNxREKoIeZ9buT1tR6YTdaruxFqxB0bgmT9E/uacAP3q4Bnfutl89k4/8CeBnMjnslxsEebBDHAwCUOMPQ3vlKyvxClgYIvZeSQyjPpKE5Ky5Ao4kUH48aNQi/etGVnONnNXufMz/hQBlbXuGpTShqadCv5D4RnI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938051; c=relaxed/simple;
	bh=a0efNbPkFoFMZQuJlsXwZa0OvWZ5LKfKa8oXf/iTQGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp+w8xOFpXtIniaqVlt3M6dEQ9POUJej4352ESM3/wYozlnmVIE2WaYoBV92sINIFRnmdTwdaWf/gbf9PJeYBHW50i2BUU3qpCksaK/cfkpJYRsp9neiuMATjIeLlYR4KLCUkyoU0I1yim+qGs8VS5vYV93TOhVTzMELruPuaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPM5t7yA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87ded588c8eso1246951241.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748938048; x=1749542848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDGBSduyXbHQ46IAjI466E3jzdFbbBUSkhtvK40jR68=;
        b=hPM5t7yAAZuB2ayIUYULDnTRUOiTFCttHUSGROS2Muv5mPAIR9pSlHxoKC3vGOT9eH
         NAAJyxXH1N+4tSPkDSfoIFVCbBLD95PiR43r+7pHItIBUe5iJRTKsgaHpCwCe6vZmNCw
         nZWpLRyFINUvUOC+TgBTCxCAzavZoEdSgcJ7rqQmfKA9qJvU30Gpq9miJ+QIf8d3PbBs
         utwEq8X2GkAbNNpBHVmqLc+BRmgvSHvRu3qoOC9nXQQ7mbzS4VhoeU0lDDi0TRiaac/s
         +llVJt86Vhw6DLRiAimj2/iLNbE7S/5IISYle3ceIr5HGSyej15IHd0TVzrbNdAovqAh
         lUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748938048; x=1749542848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDGBSduyXbHQ46IAjI466E3jzdFbbBUSkhtvK40jR68=;
        b=t0ZrtPt8erfWwZzerMXliCzURAxLV3OxFMgnl0mLF3almmFO5HyDgk/bGD0oLdnp88
         W23kehMIxSXhBG9911MXp0WgKoxzv0bOBFNHVYeuKoP3E9XPsR5338+1wJM9Rzee7Uk4
         7ykfBbnjOzHyKeS6Z/5dpUPGzPFgoCzWkSnIcJI83ghxKV54OtSDv5O9TiupXSXLNjO4
         FgDce4k6tkKsYsR+LYcNeOHL6+Qih6vTVepNl/jKyhs3VnkSe/OfH3fu0EHl4Mo5nWET
         l1KgF5FYEQTyVgALjQeuSAyqYo4CplgFWYFUA6Z6oQkVStj8Xfffn1WayDN4W42uVIYI
         WiFQ==
X-Gm-Message-State: AOJu0YxSoE7oJWX9KvBfgBs4PJbnT6a10DUd6mHcDM4KmtLUjaYR5KcY
	k19mhQS260ibIuIFeGa1VQ4fqP3K4uzshpbdMlnfF75AcN0rRm0ilL/6rkuXoteBmrbruSXFViR
	mOrMGM+85IsuwO/eQNzlR0+K53W4vGhLZVPqV0yAEfg==
X-Gm-Gg: ASbGncuAVfxxe+yJLvNeYwfWGDDTFZPwoqCxfRXYWmbaq6Vetai8xX0fGm9euHs553Q
	R2FYPPZrXhulF7OoSVLcnT64LDQeuEULapylP4mw3PgrAEKhclUGW2FX/Iqi7NWj/ZVpfwtxihv
	16U1RWe4iXZMRH0GghHTldOmjaKMfuUbo1dJRMH+WDwqR/37tY0W33
X-Google-Smtp-Source: AGHT+IGyYkGVv3WmXmsTELKM5fLdDqlySf6QWUPXvdaCbaMbtPacfL3f8TZdtRnc1C4HVxQDJTCAbW/51uVvOY57VPk=
X-Received: by 2002:a05:6102:a47:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-4e6ece33e74mr11898093137.13.1748938048053; Tue, 03 Jun 2025
 01:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134255.449974357@linuxfoundation.org>
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 13:37:16 +0530
X-Gm-Features: AX0GCFvDqmMU1x0jRj0cXE5UtEj8pF1EDN8rIh8q3pvOM5Nfh8pK7cZocZqKyDk
Message-ID: <CA+G9fYt_vx2f+3SG4Y7RfXnw6NDMJJuP2Mt1fNCEBBCBbxigKw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/204] 5.4.294-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Jeongjun Park <aha310510@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 19:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.294 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.294-rc1.gz
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

NOTE:
As other reported,
Here is the build warning on arm with clang-20 and gcc-12

kernel/trace/trace.c:6334:8: warning: comparison of distinct pointer
types ('typeof ((size_t)trace_seq_used(&iter->seq)) *' (aka 'unsigned
int *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *'))
[-Wcompare-distinct-pointer-types]
 6334 |
min((size_t)trace_seq_used(&iter->seq),
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 6335 |                                                   PAGE_SIZE));
      |                                                   ~~~~~~~~~~

This build warning is due to,
  tracing: Fix oob write in trace_seq_to_buffer()
  commit f5178c41bb43444a6008150fe6094497135d07cb upstream.

## Build arm log
Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxMDrYn=
M37m3B0qZbAdLmnoeQ6/
Build config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xxMDr=
YnM37m3B0qZbAdLmnoeQ6/config

## steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig vexpress_defconfig LLVM=3D1 LLVM_IAS=3D0

## Build
* kernel: 5.4.294-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dbf9e583326d679bc41fbbee9302d2f0ec8e01b2
* git describe: v5.4.293-205-gdbf9e583326d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
93-205-gdbf9e583326d

## Test Regressions (compared to v5.4.292-180-gd5e62da0f6d5)

## Metric Regressions (compared to v5.4.292-180-gd5e62da0f6d5)

## Test Fixes (compared to v5.4.292-180-gd5e62da0f6d5)

## Metric Fixes (compared to v5.4.292-180-gd5e62da0f6d5)

## Test result summary
total: 45395, pass: 32893, fail: 2231, skip: 10140, xfail: 131

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
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

