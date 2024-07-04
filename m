Return-Path: <stable+bounces-58085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85631927D0E
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 20:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62E21C20F79
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E16CDA1;
	Thu,  4 Jul 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElCLYoZ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870749659
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117875; cv=none; b=BgEQgTX/QOP0o40S//6rXx+YcBRfsoe/1CfnhKTuTvnouf6vs3gj6jkkhN/bEl4MMyqTIG0eOdfNeoEDUo/C2AjWIuFxZUITSJhbtAzDFJhP9mrbY/RxBNVwje+krj57GL9hKIjYOqnr9aQS8i2KUZ0vLpoAUqbSo8WI1ejM8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117875; c=relaxed/simple;
	bh=AgQS/DVDrI3+TiOXvEEotS5qwSgKZahU4Qq3oMYHwNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRJlFNr0pYmAFrXjq3JamPR57HkI3N8kqGfn1pBUZ/542Ql5nvLX6HaHd7x3N1iHUPTyntga2p4auBtr79Ka06mxwa6a3Q/ghxFol86Ks7xnGuZPra2uEupZ+9mOcfiDVh/CDPqBTraJBOpWaHyFs4t3Erj7WLKx6vKAANAkDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElCLYoZ5; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f2fb0c0fbcso185331e0c.1
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720117873; x=1720722673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74ZA+j1I1EFqnPAhMsUNbwVbUxlYztRDmLLqYaBK4kQ=;
        b=ElCLYoZ5H4QSZbHRztraoD36W2Uw6eTlKfTUcoI4eNb+zxKP/c+a6zY+f2UA0qbPk+
         mu3lxsQ2FIaF5uwX9ax/5AjjqcFRckyz4OosJUrZSZ87lvUGDKn9SpvzJ3H8SGO7PeT+
         Cmu8WLY22KgUQKEVxV2agrnH+Fs1+YeayqDPfRy4iiwDx4kAqQSx5E0uO/00UGafUekq
         yvEDSYGpocFfAOTGCTxhlzCWVJ4p4icSAxCtEfThpEtYWFsHawTq1lG2wi7RelHHbTtC
         CG+f81aZUfouYsGeDjUrMTzBYPKWTfrSpGrPdr6elvb0qfgSUXI0vz/Go68Cbp5+QKse
         I+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720117873; x=1720722673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74ZA+j1I1EFqnPAhMsUNbwVbUxlYztRDmLLqYaBK4kQ=;
        b=sswUipYkf9RHzoCFdYQt5tlzq595qmF3x0AvkIqkjHjxtxnencLSbCgSU/e/PF1A0G
         tj6MudGoqdI0LzpHrViOY/H/VTqSSM35BnE0ol99uhKqFMwWfsIvK+bQXyDUiHzI5dYZ
         WczGU5OlZ0c5SahIjHWF7S2WjKLKNyxCnWo1/ao5EEdyf5bvD4fQXJlY1Ssm1ihhEYnP
         QfEmyJBEkbE2rKCec55RKEXZAJ7mjPx48wT+GfKJUVCTk8QdfZTrbnz1OOXjyDmX9C1x
         q/qDtmI/7R/3n6SseRmqIzmb+P/zaM3TF1DH+L7gR7R+oDjxLxxrYTsiseM6//GHGvGA
         OsiQ==
X-Gm-Message-State: AOJu0YzLtLSLhrFQDTFeu7dQDDWxjmk2HwuKTcBFp43Rxy7ZWpwmiI9O
	osU5vubDbb3sNDK5w2JiiiB41+3jTKGlHlTao/kWH6OMTrxAqiZYSpRHI8OPdkxaPSj5C+fbtr+
	V08EHVdGzKC/8lKRk6LISX+btfjCXcha2xu/W1A==
X-Google-Smtp-Source: AGHT+IFHH4qjAo1Foyl2FUb4fk5DO3d/le7RX5bROz5xpVRaqmNzLEjPmmLVbIq6bhq14LQtW74/pb3csuS6bawJL44=
X-Received: by 2002:a05:6122:3a1b:b0:4ef:5e40:2cc8 with SMTP id
 71dfb90a1353d-4f2f4022896mr2884333e0c.11.1720117872889; Thu, 04 Jul 2024
 11:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102830.432293640@linuxfoundation.org>
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Jul 2024 00:01:01 +0530
Message-ID: <CA+G9fYurwddc360a=u5=Qr=Ys59Qy3PqrVYO5qoKvwGupaD2SA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/139] 4.19.317-rc1 review
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

On Wed, 3 Jul 2024 at 16:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.317 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.317-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.317-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 485999dcb7d90b9212ab9cde5bc707548f0dcd39
* git describe: v4.19.316-140-g485999dcb7d9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.316-140-g485999dcb7d9

## Test Regressions (compared to v4.19.316)

## Metric Regressions (compared to v4.19.316)

## Test Fixes (compared to v4.19.316)

## Metric Fixes (compared to v4.19.316)

## Test result summary
total: 66635, pass: 58258, fail: 354, skip: 7961, xfail: 62

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 27 total, 22 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 23 total, 18 passed, 5 failed

## Test suites summary
* boot
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

