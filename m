Return-Path: <stable+bounces-85104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108999DFAA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC851C20D4F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5C1A0B15;
	Tue, 15 Oct 2024 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pq9sqDIu"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC2189BA7
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978619; cv=none; b=U2mYJnn2HYsEs1+lUhO3pObsQQ3fchcG/78FKb7KpIxX4LIfxOKT41iF1XEY+iBdNeQuapCb0IxNcY795dl4dsIw661zJ+WJ7VTbHXzBuORRyGfUhdChRY3o/jx1uIJUg3oz5xUCe14RC9Cq7vXb0qm/mvdLYigUPcxxRIhq/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978619; c=relaxed/simple;
	bh=vOa6EcRUks3vJ+gN4gguaBuawT8MdWJj35kDikZazRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS0QeDUfUNhH4F5L1dCsxtjV4bZ2QjKOreImKsfWYEiekiTlLqvdJ5SJ4JuHWmJLfVWgyi7GFmJHkM1k8/NoFux3xPQgIgCNLBVb+pS0FPNSXUXumrZNVNNsak5+UPSPOp9B8V+iMTsXoJGNbySLFYH+Na2DhBMBwxBiJc4HZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pq9sqDIu; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a487a7519fso539563137.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728978616; x=1729583416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=pq9sqDIuUiCN6CgXeF98QqUKUiofaqMEh1s8GRRWDBQn1FKcLaYnpBvYsEWGaCehxq
         V0yGJLFFXrIr3MTAQCQUYhjaJyfrjsOA6SqU5kFQKlgJJbA90nxQRZic9loUybr2cNSV
         jm1t3xppD7nyH0a783KUfnEfhv8rmSQtHsk6bELkOthOaF50AAi5hcmNyUB4SDOsWfBe
         s6Hsp1mLL2LzkwtnvJMYRsqFW617kDDsScA5SzRy6Q2tQIcYW5JTytelx19UBLLW10af
         CsabWjARaCKqIrWoq2rq0PCqiiO0ZBBEunmUzAjUfl1hsxBieQCFsWhHCfmwnq5j/s5p
         eT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978616; x=1729583416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=kc/GoEsy89uNGi4thA0H8Tzk+48GioVm3J8IHQ5jLSzOfiZv9g4R5I0sdvTOC3lOUn
         7yRqgnJ4YYOswIe6Ycix007R5kOvH9KBtDTdtsYz1CWMyM3fJ8OCEVx5Jc9TrFKqdjl8
         +cUt36SCB7SQhcpCvtvxSm79sj3C5A0ogRV5vAAvn8TAWknKP9/Y8h9oWx/IW+e6Kr4A
         4gRM3SFFY5xlLE2GqNZ/rwlg+YyP6v8RrPS17sox27H+D+XOporZ87YHZcx5jWAYqnBk
         y6BvRydnxA5Y5MtJQMj2+nB8AHb25C90rZgCDRgddxL/O8aN6y8z0hSdnbRndMsu2QlM
         qODQ==
X-Gm-Message-State: AOJu0YyNPrwZiDVIT/iC8LirLgYuopIhsmLccvHkQ/Ir6szll4/nEUpc
	qRlGDXGHcMk3KcKLLY6eZJuvzrodZvS9EVhxfhRR9WGzZYu6z0xC0X+Cr2FNTBPt4Xpl9MzO8hh
	pSFk7fyyBgsfesTrobThdHrRwEjtnq1s0ehoprg==
X-Google-Smtp-Source: AGHT+IHJTQgMwy07yt4Kv3cxeA6jaDdGJW3Q76nXmTxUbWPQyJERX0qrCdD9zyui+kZPBA1VduE7XrCzaRDLLhLgFV0=
X-Received: by 2002:a05:6102:3913:b0:493:bb35:d8f9 with SMTP id
 ada2fe7eead31-4a475f0bc31mr6236860137.5.1728978615788; Tue, 15 Oct 2024
 00:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141044.974962104@linuxfoundation.org> <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
In-Reply-To: <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 13:20:04 +0530
Message-ID: <CA+G9fYvpCw4Dh5BhKjS4bsWix=i=koK6Kw_jU=9zSOFu-UePBg@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 14 Oct 2024 at 19:55, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.11.4 release.
> > There are 214 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

[Adding Reported-by: ]

>
> The S390 build broke on the stable-rc linux-6.11.y branch due to
> following build warnings / errors.
>
> First seen on v6.11.3-215-ga491a66f8da4
>   GOOD: v6.11.3
>   BAD: v6.11.3-215-ga491a66f8da4

This S390 build regressions are noticed on stable-rc branches
 - linux-6.11.y
 - linux-6.6.y
 - linux-6.1.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> List of regressions,
> * s390, build
>   - clang-19-allnoconfig
>   - clang-19-defconfig
>   - clang-nightly-allnoconfig
>   - clang-nightly-defconfig
>   - gcc-13-allmodconfig
>   - gcc-13-allnoconfig
>   - gcc-13-defconfig
>   - gcc-13-tinyconfig
>   - gcc-8-allnoconfig
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-tinyconfig
>
> Build log:
> -------
>   arch/s390/include/asm/cpu_mf.h: Assembler messages:
>   arch/s390/include/asm/cpu_mf.h:165: Error: Unrecognized opcode: `lpp'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/startup.o] Error 1
>
>   arch/s390/include/asm/atomic_ops.h: Assembler messages:
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/vmem.o] Error 1
>
>   arch/s390/include/asm/bitops.h: Assembler messages:
>   arch/s390/include/asm/bitops.h:308: Error: Unrecognized opcode: `flogr'
>   make[3]: *** [scripts/Makefile.build:244:
> arch/s390/boot/pgm_check_info.o] Error 1
>
>   arch/s390/include/asm/timex.h: Assembler messages:
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/kaslr.o] Error 1
>   make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.
>   make[2]: *** [arch/s390/Makefile:137: bzImage] Error 2
>
> Build log:
> ---------
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11.3-215-ga491a66f8da4/testrun/25429522/suite/build/test/gcc-13-defconfig/log
>
> metadata:
> ----
>   git describe: v6.11.3-215-ga491a66f8da4
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>   git sha: a491a66f8da4fbfc06aedae9a8b0586d11a51fa9
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/
>   toolchain: clang-19 and gcc-13
>   config: defconfig
>   arch: S390
>
> Steps to reproduce:
> -------
> # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
> --kconfig defconfig
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org

