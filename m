Return-Path: <stable+bounces-116536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3328CA37C86
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 08:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DA16ED9E
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4A199921;
	Mon, 17 Feb 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXlyb1PD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7718DF60
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778626; cv=none; b=No7EbBHJIYC3m6mezVYQNhynLbHIP2vuMk5QSHDbaqxMh+lpamnNsBe3KSUFBKZTEP7aUR0gIOZHqXh9+TWwls1ymy5DznxiW/J4GLYRDnEgr8uQkPg+bO0hKHnWFt9Uh7x3OhrAzGlFdYrite7tWX9s2RW2x/83GG7hcLUx8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778626; c=relaxed/simple;
	bh=vp4a6t9+gatjenBKfvBoMVmONzCQscQ264+pgS+okNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7xgy47mkTHmzjjYM29K5QfbWbqJcdiy6ioWG84+ZN9vcKOYScAQMtU+BwmLTRAUGW+hzmISUUZr+23TPSYq8Q1s7r0arIwSNrZ3KgSc2RMYs8H+c5YKUkXQXXu497pWPth/J066hDPzxD0oNwwAYx6eIRtbXrlO0IqaoeTEYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXlyb1PD; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-868fa40bb9aso830862241.1
        for <stable@vger.kernel.org>; Sun, 16 Feb 2025 23:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739778623; x=1740383423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sb9TESano3F0qRs1VfUsEveKaGPiE/3bY+CecfKRiUY=;
        b=fXlyb1PDXWud7cxIGkOmCUS8P3tBJ4ZFec3DUTumsUjWN+NTYJSgaTHiPUeNChjCEk
         p/cuMRQxxleCMQM/Bwt7blntKwHuP/aUvWmxLGpT7WSttoL+y3Id8S6CcoTkvynWm7yA
         UXjSCPGhoPcPIx/svpMpTrA8ceYEa6UsWN0W3RpI5Wp2A8LkPKPIjeU8skVrfvxXDS/N
         DvvLihOtj5DX+KD+hFmaKGB8AFUrg6NQSbxnNm+OEKB6cGTz3ZkkPY4VrPne/S4F7FKA
         rJkOLHh2HRDTOg1cyA7Gkhc0qWhItGDktu+y3N8YY9bKBeKqSdv0oIgA705vPwQBdm9J
         nreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778623; x=1740383423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sb9TESano3F0qRs1VfUsEveKaGPiE/3bY+CecfKRiUY=;
        b=pxzS3f9MHcHKfCt5B+AB1T21c87WTbs7hgFo9uv5xciIJOzSnjisYRHM+1A9XKZn/e
         tUcYBaLCHMzvbsDc7OCk+1KdwTdzxzNXpnytSw/HNctOGpd/7JmH+HQ9VmYADqK34mme
         m2jpCI4M2d+Yp2Eq7TQvYzHrbHjlYGAOb/H+M+6BxTWptBmcLykFwEGI69eu2kNOFQ1Q
         qxpliWTh3P9WRIpufewhcim4On44RxP4lHzeJqJQzEuLyPp4mtZxRQxuYFbtaE3LIqPx
         BXplvUVlWrkm5jiXTJVqRJbQI8JhjjYDBrC/hwxLdbyjhwT8FbyfM6/9TyR46W+S6aBa
         RJwA==
X-Gm-Message-State: AOJu0YwpXfftwAOniFxBX4gfXKscNRBSzMODAiIvyZN/ihR1B/+ZA2ZA
	6MeB68aafoUXhewxQGyGdkV1k8IcJci1SSDdptNne2gAz4d1ik5aEe5ESmKoZ2Tp3j8x2Ze+5AU
	JC1SmLW68GgsulNSms9JDdo8Fruy7yKudaNEWoQ==
X-Gm-Gg: ASbGnct1KsDwCL5gAzdAXNKQNUlpoNo0MwlpDmmJ2PhU558G/aVoMRde8Vkz4CF4o8q
	Y2BCLLugogsFpW0eePre3ImiJq2MoHm5nS7KmvF79tYDwyNyLzH8A8rWWLuICIju46yDFZqYXRt
	U=
X-Google-Smtp-Source: AGHT+IH7AA8lTvvKySDGMR/9+4pfIcZZ0oEGwwCKuY/vSrQj1o5zY23MVYJNqtGjpMCyHJPVzvbKMkBJGAYr8N5YT3E=
X-Received: by 2002:a05:6102:150f:b0:4bb:e36f:6a30 with SMTP id
 ada2fe7eead31-4bd3fd24266mr4376412137.15.1739778623321; Sun, 16 Feb 2025
 23:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075925.888236411@linuxfoundation.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Feb 2025 13:20:12 +0530
X-Gm-Features: AWEUYZk9MdnW6iQDFedg0wdqGA5Evc7ByipVWqb3l0MawRNhfY2MpewuEd52Crw
Message-ID: <CA+G9fYv8VcR6Zj1PmqJ-zxUuCvJthO08BWuZo4uWdUbVvcT30Q@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 13:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:57:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regression on qemu-arm64, qemu-armv7 and qemu-x86-64 on 6.13.3-rc1,
6.13.3-rc2 and 6.13.3-rc3.

We will investigate this and get back to you.

Test regression: arm64, arm, x86 selftests: memfd: run_fuse_test.sh

* fvp-aemva, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-armv7, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-arm64, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-x86_64, kselftest-memfd
  - memfd_run_fuse_test_sh

# Test log
selftests: memfd: run_fuse_test.sh
./fuse_mnt: error while loading shared libraries: libfuse.so.2: cannot
open shared object file: No such file or directory
not ok 2 selftests: memfd: run_fuse_test.sh  exit=127

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Source
* Kernel version: 6.13.3-rc3
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha:  f10c3f62c5fd43a4dea41a460937f2c1a6a412bf
* Git describe: v6.13.2-443-gf10c3f62c5fd
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.2-443-gf10c3f62c5fd/testrun/27311246/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2t4N3DOlWsCre7mv2YlTKUyEFri/config
* Architecures: arm64, arm, x86_64
* Toolchain version: gcc-13

--
Linaro LKFT
https://lkft.linaro.org

