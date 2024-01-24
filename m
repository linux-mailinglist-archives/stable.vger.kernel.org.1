Return-Path: <stable+bounces-15644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B783A86F
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 12:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7255F1F2160E
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401EB53E1D;
	Wed, 24 Jan 2024 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQHJ53T5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC451C39
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096626; cv=none; b=Rzrn8QGGrjlJ32o5SOyju29RgGcjEGCbi3zJsG+Mvf28OVkVTjyCV5D+rn9DZsSE1CcOS9Huv9bn1cIrStkVuwLA29ffP8tD5tsebIVWa7JL/DLQmVBHkVfZez2+pJOmaQYPwyqAd3U+B+XKQLexvSx4iO1POQ+gYNKcDcSR6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096626; c=relaxed/simple;
	bh=u0KLfkwWP+Lg31vE3tgGwd4ZG6bVY8KlgQ/9qOpecDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiUsFEY0ft19615coitXhMsu66iL5J3QNN/7hB5ssmhIQkfiwNo9QajB9kIkJyyJr3e2+oylYJu0sqqJYseMW/G6g85dX5a5WpHn/nAc3XOgedKEc2i2bxHoZQLsAx/fnHBrl7Zh17B1laFKNed/hKa/RV8QREulXHXvtCy70S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQHJ53T5; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso1849312241.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 03:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706096622; x=1706701422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j23tgf87CycJmX/TcWEaHJGGJZBbkUa/bGeyrG/mu3A=;
        b=YQHJ53T5psEipiLo82SjtCtNwi5NNmb6QlOkHjCu5/syBDrikieh837VlFocLTie4H
         BNo8yaZMg4zdDOXQx12BuVui4pYl+Z31WqKpk//GivBR9EU/lzu5XEdO1ssO39RHi9ce
         eMj5usch/h9I0WxvIOth/KYqI+UJr3o+sPYZLhFacP8RFeuXEiuvBd+akFzABd1WfEeo
         Y9CxIpncmcVD6yVCYUYE9oGBjWcVlhaWe+SjBuJhN1mAVrxpqxlz4mXKUENHue2h/EBI
         3NfosJp1CSh+qzCD/1dkZC1oKcbjVvak5tOoKs2lxZ/zhk8IuDMP6OIH1OtLra5/axV6
         3JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096622; x=1706701422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j23tgf87CycJmX/TcWEaHJGGJZBbkUa/bGeyrG/mu3A=;
        b=mMnGl2zkMaAFr6Xc01ExlkeVDfwev+/cKf3zAbSoayzbJX0sXMVodL7OGE8Cl9jcG8
         VbX2PHMiqip+nWbDUHqaNNSRSy+KBZWs1UvsqRuvP1XP1Hidcc8BPKRxXKypqtEm828b
         XSdct97m3p6qaYS+btemIMnBgMl6qq097RxSv9zBJcEZ+30yaurJ/gytKASRRNVXTh4J
         IfgwoiObtA7SXhOMgfIZoNAkvmzmYEeu1ETuNEgF3bd1hoSQbj3HlpqnU+kGD6p/3/60
         wtIXDUQysNKGhLJDNSLhlwi0Y93q+g3HI95PwUBzG+9fdr177XTnEsUbjFtPBU4RBui2
         5yCA==
X-Gm-Message-State: AOJu0Yyei+Gzbjz3gPPXZg0b4O/LlE4ReVrIHdxKbZCra2Gh4p8OS1+a
	vCgur5X10AprjPMi9uR7qtb/l9xG6jrTHJVKexV2QLDsRkELMareFn+zVSYwKILALYOBh4kvcHy
	a4uR+MSn+Q1WUvaisDWMx/FmQXRIY4vxptbcosw==
X-Google-Smtp-Source: AGHT+IG1VyRABlWUuTj+0/1BPvPY+dfwLQF6vxQs78S66G81VlsN2AtNoNgb/XWiWLojCT2WzGX0xLLau2J/P6gmEv0=
X-Received: by 2002:a05:6122:147:b0:4b6:d551:d4e9 with SMTP id
 r7-20020a056122014700b004b6d551d4e9mr3245112vko.2.1706096621786; Wed, 24 Jan
 2024 03:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174434.819712739@linuxfoundation.org>
In-Reply-To: <20240123174434.819712739@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 17:13:30 +0530
Message-ID: <CA+G9fYv_YPE-43_h-fCN-04te3DmG0H8cGOS0ZDAz8Avv6XX5Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/193] 5.4.268-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 23:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.268 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.268-rc2.gz
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
* kernel: 5.4.268-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 6207e0931754e4be20272a062c996b9dc9e68d62
* git describe: v5.4.267-194-g6207e0931754
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
67-194-g6207e0931754

## Test Regressions (compared to v5.4.266)

## Metric Regressions (compared to v5.4.266)

## Test Fixes (compared to v5.4.266)

## Metric Fixes (compared to v5.4.266)

## Test result summary
total: 91245, pass: 71240, fail: 2458, skip: 17497, xfail: 50

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 148 total, 148 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
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
* ltp-fsx
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

