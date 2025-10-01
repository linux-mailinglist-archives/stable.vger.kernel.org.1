Return-Path: <stable+bounces-182929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB0BB0390
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C0A18871C6
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078052DEA86;
	Wed,  1 Oct 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFpon0hI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349812522BE
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318986; cv=none; b=UpvUMVGpD6/FIs5bvfObLdGBWWFqzyEzyYPlVaKoq+XJyW4+DM+RQq2Q2RguOQM7lMeyjzH8irG8SNaITE2FtJfsfcysax4hARIpdOEunL+baXcaiXODNp85d3JXktvZYTawa8Zn6K3yYvHNG1hcpcLFOZn/cvfPqtOowvg7WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318986; c=relaxed/simple;
	bh=ICC1mpjBaX1fMrY45swyhJyHRGjc72JKuZEGUjPTJjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWZR8LuxcNvOsfD+ptqo0FFvdWhHchEgI3w4PwvM7hKLDlG0zZTz1FE/gZ08pxPs8AvmVJxM3O3xzRUF9hCdvVuZXMjFJFF4WfIUI3SxMkWsPtpMQq2eVZznIAu+dTd3VRlmpLmLGX/3Gw5y2hhJ265JyNBl8Iroh5pGpYxFTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFpon0hI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d3540a43fso78478145ad.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759318984; x=1759923784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M4p9D7lI+yLv3i3nD5AKMya0gsPB40iM48gCdLXN88=;
        b=WFpon0hIl3Vr1CpeTRHW2lBC6hNRI2KI0SuzuW71IHswRi/yJVvnA/6DaqyJWJRiAM
         ulGpbkkk+pt0Bg8JkZo/F/vNOcH76SY2RKJwqYGsft39JyB/taFWigcMon+mjz4EV/iQ
         e4eHfveA32ymH5FDa3nIoTua2f659/a+zxjpvgz4GC6mBH5enggv8UVVcFQ/W4fMYis/
         GUH+QHBTebcnyy5492EJ3YCJO4g060Rspfpw3431MB1ZWHqY/KQE5/geAsiDOOO5vD37
         EDEi9cEoQh0h11yHd4KE08rBek6Vmu9Jt+hQ9jxs1Skie4C3fnLVlQN66vhXfV8Cmj/y
         yI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318984; x=1759923784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M4p9D7lI+yLv3i3nD5AKMya0gsPB40iM48gCdLXN88=;
        b=rm/Btmp5Yd/Gi1LLm6QVjxS8urySViZBVTwKMtkzqfE/fIL4DvYNg7GmBmsaasf6pg
         Z1tI+Eywa9Lupv/BGgj4vFJSdFX3wSPhVE3bSRS0KetY9Op4KaOBoSwDFkFKx3QCCmHU
         tv8hxL8yhHF/OKVZ0Nj5EWwBhazRoYPhdc/BUg64az21Kp8bunXo+zZhGcbW9sU7LMKa
         9KAz1GDAiYwvqVdZsmyT3Zo4OTZiBAc1pcKmF5OqRbOz9Pqq3EkBLckVADG/0YA7/jWy
         7dHPJqkU9dyesXU7J5kKati1XHeufoGIUPFMlvIbC8sPtL6uFrnRIUJoQR8XSq7osRrY
         4PWg==
X-Gm-Message-State: AOJu0YzH2Z3vsD+Zh5/BVYd5TD4zYT9cksmV3lA2uQ4VfeotvUMKh4rn
	YhXVc5AfM4lk5CZJICckCnpo8A0zeaYlH/ToRwjNE7l9gtT71UB49utuRwUYx5rZDqjw31ryyEx
	2vaFy/j2liC8Jn+WBozRaH+62S7ihP8RxbM0U8FcqTQ==
X-Gm-Gg: ASbGnctfNvC79Lt4vV4kEN1tBUtGLI75dfoGlYVGPRs+I1bIc0qr4yxRgk/a6KKol3z
	tuml3FXnl2y+mjFthvrYQxWYA6N7f3SwiAA7AsPZGVT8sI6c6YqKtnfKLtUIm6X2201gltHfa3t
	+MZq/J4wZruHMEHndyEyxEtnyW/APq3r2YkCvyjE0VWWzzPs9Aqvv9TgzYN7FlK/m+jWQ+9KLvN
	NsQm/9nP6+0A0vX/if8BUnBsCmuegrA/FGbhklZN7S6Shn3aSDjof6/8jx1y8kt1iAW6jItqFcZ
	GxbXUF/yGqEuu2TrBdUL
X-Google-Smtp-Source: AGHT+IEMbx0M87eZESs9jldV4MdFM4iSP810cku0WLVGzXf8k/U5UFP/ypYIgF2u0SiTMZolotTj1uDJoJPKSAwtYQ4=
X-Received: by 2002:a17:902:f68c:b0:275:b1cf:6dd7 with SMTP id
 d9443c01a7336-28e7f32fe82mr42585035ad.34.1759318984443; Wed, 01 Oct 2025
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143820.537407601@linuxfoundation.org>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:12:52 +0530
X-Gm-Features: AS18NWDxtP73CATq2NXcRu79wLgRRf1DYlwdDx4ErrAk_jQ77dIgp1kcYcZyKK8
Message-ID: <CA+G9fYvrpdXhrUWK_FGbxXcTn3pN1-Hw=qJUjyD1k93C=g6ewA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 20:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.155-rc1.gz
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
* kernel: 6.1.155-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8a8cf3637b176b7508c3f109c6234a1a6e86d9d2
* git describe: v6.1.154-74-g8a8cf3637b17
a* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
54-74-g8a8cf3637b17

## Test Regressions (compared to v6.1.153-62-gbd7dff6dbcf5)

## Metric Regressions (compared to v6.1.153-62-gbd7dff6dbcf5)

## Test Fixes (compared to v6.1.153-62-gbd7dff6dbcf5)

## Metric Fixes (compared to v6.1.153-62-gbd7dff6dbcf5)

## Test result summary
total: 225710, pass: 209239, fail: 4868, skip: 11344, xfail: 259

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
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
* modules
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

