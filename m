Return-Path: <stable+bounces-114279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A83A2CA49
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A5B3A9819
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2392199EAD;
	Fri,  7 Feb 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLjut9Wy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE6194C94
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949803; cv=none; b=nvDex/wmz5FgBYFLyQU2kVGw9tjlAYRFFhp1IB+ktHvCBqOoDCpVN82DSAM3tbVLtSGPCchl6sx9R3nzeXtf5wlPhl/GI53WPB+PrwLqgOxXWSMLQNdC5JMYxtqm4FDy2XjpM1MiJrXUSKOeVoB9BlcHFVJgKni9ll4XCRBwuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949803; c=relaxed/simple;
	bh=21qDGjiVABfPAamSl8+lYhl0Ac18V5VkNPgXfqK6F1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYwhHl4URIkNrP0NT+TodOm+hqPCi5koPKmEsqMX0nSKDjcxaDF6ug2XQTG1RmPzQDYXHmrZ+lEhE05CpAWt4S1XKr4iKTVbQEz62DQ8Wsz9UKMCxPZqqE1DpWgNFjv+m3BHk5GDsOIBO6Vv91NiPL2HUEgQCz+0NNulCoMejRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLjut9Wy; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8641bc78952so584897241.0
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738949800; x=1739554600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoM7ay1yUEu27qZg6xqFFLuuGJrp63sCtx87CRTaTyc=;
        b=jLjut9Wy46NrROp3gSuUkMqw6/jjt32HJClP+o0GIqmJXb8qsGKEzi+nDGizmvbxKu
         9JCv3ksXPPngc0StmiAxdWHE3oTEiLjfPRKcJfJp3b9/cJ6bUwojycW5JArY0F88xJ1r
         vi8fZNFfv6C6QRylAF3EeJaJrJltooVDq855pr1VB0vT9XuIFCXXP2FIYYSeO2QZ4jdv
         7BkFh4OA2g5LOvnYY6ovO4zqud6nikIBtOWIi9i9xZK8bLtIU07IW8tWK8iCTEpk5pzr
         HDZokPll01wRHqSsjEow1FhXg24StKzR+Pm6cx+anRt3kJMXAsb++Dokdo0o5mLYIvLJ
         48vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949800; x=1739554600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoM7ay1yUEu27qZg6xqFFLuuGJrp63sCtx87CRTaTyc=;
        b=AFR9tod8C9rBnNBj97yx7H71gYzv4nBLYCLjJXHiTY8h6D7tte74D2knuoyljp/P5u
         FV38wqHZnk1ZvNDphll9m5Z+OKgqyg0xxCYCceyD75Fma/PPd6ePyFj9u4eq4o4Ad+JL
         oN5PkY6O81vaSPQ+q3drgPhGlOMxHTHXx4QNyDKppIjL23ZiwxAitsSkOFhky7+D09uC
         Y5D9rMJGogFJnkDfOzTJc3xu+SN0Jikyw3HgKAgPw5GQmu7lzY75he6RAcBaCp5yBfw6
         GKHgVCyjOXL1/D2/SJmqnaaRgsSyQpfbqta1tI7z/WdhpOLxfEGASW+xvXOZ/eR8sqJ4
         vurA==
X-Gm-Message-State: AOJu0YwGb1qZKDTB4gvtVRyHH60ibhvkaDYJ5ns6tYYF7aOi3irwX3AN
	gBY01p07FmEr0HRFlKzQDlbYGunPJbVuPzDH9heD1WHBPsXHxNvHWE9XQ7DO0X+MfSmaPVbxr8w
	L+ek6cv6F64GLg6nXyIqV6U4phiSfymj1tta95VQ/kxQsf7yXFPo=
X-Gm-Gg: ASbGncsJzaAY0VqD0mmRJfyGTMPBo/MjDAMSiSBgj1RhchsOE2hmXz6a4T9cL7XqGXZ
	80JX78yx2G10pFgd1vcpAFBpwfTeLJRJWaKPJVGTRu8heHVCk2NsTTi9Z+s5KezhPlVyWr4enVX
	0N0UnPMo09IvigPGz9oKuEbWaAu19H
X-Google-Smtp-Source: AGHT+IHD48I2AMSpA5+mvtWHG2ePtTqKNvefiIOSowMRXyVSROEuTDkAlvM1BbSf+cJUy+TNOcgESamf0qrSTV/WsvA=
X-Received: by 2002:a05:6122:4986:b0:51f:306f:f35a with SMTP id
 71dfb90a1353d-51f306ff9camr2275253e0c.5.1738949800534; Fri, 07 Feb 2025
 09:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206160711.563887287@linuxfoundation.org>
In-Reply-To: <20250206160711.563887287@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Feb 2025 23:06:27 +0530
X-Gm-Features: AWEUYZnVhjZv4-Pyf-2ceZaRTfyWavFrA0p3FZEzdjxW3fcO1g2Uupo5JGJYVpU
Message-ID: <CA+G9fYvs9GUK25mx-v+Fh-E55v2F=he8v=pSbPa_r4Zw51CNuQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/583] 6.12.13-rc2 review
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

On Thu, 6 Feb 2025 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Feb 2025 16:05:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.13-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c4de2ac60676d8cbaedb6e7a4b422c65b911f12e
* git describe: v6.12.11-627-gc4de2ac60676
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.11-627-gc4de2ac60676

## Test Regressions (compared to v6.12.11-42-g4d14e2486de5)

## Metric Regressions (compared to v6.12.11-42-g4d14e2486de5)

## Test Fixes (compared to v6.12.11-42-g4d14e2486de5)

## Metric Fixes (compared to v6.12.11-42-g4d14e2486de5)

## Test result summary
total: 1335, pass: 981, fail: 267, skip: 87, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 113 total, 113 passed, 0 failed
* arm64: 9 total, 8 passed, 1 failed
* i386: 14 total, 14 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 33 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 20 total, 16 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

## Test suites summary
* boot
* kselftest-rust
* libgpiod
* log-parser-build-clang
* log-parser-build-gcc
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-sched
* ltp-smoke
* ltp-tracing
* perf

--
Linaro LKFT
https://lkft.linaro.org

