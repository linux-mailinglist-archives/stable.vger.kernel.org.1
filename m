Return-Path: <stable+bounces-163220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA03B084A4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8908A46BC3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 06:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62844207A0C;
	Thu, 17 Jul 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQEaPAdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED112066CF
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732685; cv=none; b=gvrw4ymFe9hpBKS6q8HW8ERwbRVkhsS/I5pE8ZAhX/s620RAxdSSySJmuXh8CooeIp5ISDkfHy3klbE/tggum34o8cGikNhIddFYDNTcvoI7Ld8kEZvnX5uD9SDmyaiBWrU57VMSVWwU9CpLHsH07CUaCgUi0Tshb/JvdudcXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732685; c=relaxed/simple;
	bh=Zbe2q4+4Q8Fqm1aid0Xd8atXSKo30Ypwn/3kMQH3t4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE5aFkEMcIGz4b0Rf3XK3tw5pCzrRzvsSMtMWBsQQFF1sQaVYOoDQ2hueb/UuUHp4P5VDQUjL2aVaLUxRNQbn+vnA1zTYZiQ2zMvaHjOnc5PtQtN97fLHrKbKBK+J4InkhMk8XvfNzNKvIBpJhnsGs6alHf66PAxfVhKy6jOYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQEaPAdU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso683355a91.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752732683; x=1753337483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMtB2Iw9WAh5wEW52PdaXvpNvOwsz07gd2TiAfAFZrA=;
        b=NQEaPAdUqUB5x8Wna4YyuTGyt8SoKJNbtgd0uoXkfEt5G6Pqh9zUFHEKgHvtJDouSI
         zao1wyJMz5PpiPrcGNyfV8pWx5R7lyACP6b3rxtu+dPaCaE1RfmoB0g5OqBUEO8FBQZb
         azrmjtly6PaWxkbAloc1ekh7CME8bYI80FV4hB3cpRZKOSMpVA2R1IvfXQBuQoB9J/KU
         BoK8kl0lUfbgpzbHz4hG5BKG3/YKV+BivKEpxKFriQtRHGk2unxYKcuxRtqCY47YKBKW
         qD4NZ7PcT8u3b5ADL68CnV+XbfqC70+FrUexn/mPmhdyb8dkghWjyRdo4OeOOWzt28bH
         PcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732683; x=1753337483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMtB2Iw9WAh5wEW52PdaXvpNvOwsz07gd2TiAfAFZrA=;
        b=h6AjmdF8zPS/AAaiTOMZx9QCe4LwRYPKn3NnrxKioT13zdpsWh1REvSueV1V3Ug3SA
         FZTsBeavy8zqXjqA8l/PiHlJhTvb5rkP658TuayPz+nvZjBQHUTF0w8iz3HmdNbchifx
         pmCB4kqlKk6j2N0ItH9GpizRYE6+OW4M1lQx0eYYKRrQNo3fyI9Pam0XX0BgKrlrDz9o
         PWew0UVoR5WffmcXz1F8d04V9kmxIQUIEDB8D5U8M7E4Oiv2/SHbTHLO3Jz/009wC7WU
         3CxJHRub9TReDk4kyhJlAVtZOJRfHUV3sXtv7ICxWYt4pht1CJxgtkhdXzunk66cSTY4
         fl+g==
X-Gm-Message-State: AOJu0YyxfpXmGOi31IcgcxYodF71ixa6K3MicKgRI96Utqu5RDpyIP1e
	+QRrJSBlo7GnyWbtkS2382xyqjFJg0p2VV37++l7KBQpVEd8QqyN2svPWARvc5Xqq1MSjej1aCD
	eiAkIGkYfdaqgpZu/wfFz1JnKzma/CnF0zXYXzC+cWQ==
X-Gm-Gg: ASbGncs+eKhdfALy7DtkmoBNQ5Jr/FYNNnYsXT4IYH/9LAVFm8b2Dnn+CL4H1CTjyDa
	yjZAovFBOxL8dlxUZxdeLPIGz2rcco8SelWPSUSwoeSD94Ps/fm5i8No6DQhuTMY6ruh5Mqc8ak
	ZVojoGLWqjrQZ9wtmeHa6WZhjSEqvcKAV7Ofr9Hau4GWKE5N8RdFnGxudkRorUcW7NlIdvW7CpU
	icRwLRuJsoXyuQxEEE8fsG8mAiO6cdanjt7mj1i
X-Google-Smtp-Source: AGHT+IHkOgqSndFh2sn5u8Ze2RN4Z1jS3DnTq8InFCNXwPIB0SZm0lju8UDvvs9PhDnkwHDrfHsBKvuEZVHdN0jLg+Q=
X-Received: by 2002:a17:90a:ec90:b0:31c:9dc1:c700 with SMTP id
 98e67ed59e1d1-31c9f4376ddmr7637603a91.26.1752732682713; Wed, 16 Jul 2025
 23:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163547.992191430@linuxfoundation.org>
In-Reply-To: <20250715163547.992191430@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 Jul 2025 11:41:11 +0530
X-Gm-Features: Ac12FXwQuuhnkVAKH0EW1O6mL8kt_EcvovLTSe1kalni_rKC64UEWjM9iv28KGQ
Message-ID: <CA+G9fYu88hqRGioGLQX+b02xLXSm6HjtRGYsVg1Oq+SOGykoBA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.189-rc2 review
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

On Tue, 15 Jul 2025 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.189-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.189-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d21affcc10e6929cdbd116012aff62709982dd1e
* git describe: v5.15.187-81-gd21affcc10e6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.187-81-gd21affcc10e6

## Test Regressions (compared to v5.15.186-150-g09eb951d49e5)

## Metric Regressions (compared to v5.15.186-150-g09eb951d49e5)

## Test Fixes (compared to v5.15.186-150-g09eb951d49e5)

## Metric Fixes (compared to v5.15.186-150-g09eb951d49e5)

## Test result summary
total: 54868, pass: 42016, fail: 1984, skip: 10589, xfail: 279

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

