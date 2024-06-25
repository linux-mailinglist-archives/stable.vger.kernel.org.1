Return-Path: <stable+bounces-55749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F09165E3
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB713B25614
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2551474C5;
	Tue, 25 Jun 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktLqtgEq"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FA14A62E
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313792; cv=none; b=PO7LqaCpfE3S2cKeLok5jxcnC7/hZ5uSNcuVY6YT9hhS1Da3WQIyyfI+WHApKcJh8QEdRuyPrq6zsVyTK05x5tbvClYmdKLjgGHkBsWmOJBhNfoJqqa1/QYTtYr8dJ3oECOO18WQP9AarXLP+VeceZLckIHgovxPMC6q2INLdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313792; c=relaxed/simple;
	bh=Jqx5709BtugoJVZY8NxxbQN9lreP98TY5Wx/Ks/oQYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut+bZooiz0/OD4F+vyQ3R7+PFKa1Cpe4WQfHylofOj/RFK4OuIQlcrU4MsRFGUdRCDT+BSVk0dSI7rvN2mWFKmuE2zHX2VAn07QtqAslJP7i2c7b/tA3m6TbOssv1Rn027+hZ2/hr0DV7H+B2dLQQk8F2nr6B27x7WbN5rnGvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktLqtgEq; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso1976478e0c.3
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719313789; x=1719918589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7R5wxQYwGfaVqYk9QukhujZ0AZZW5oBR/ydEPdcFLQY=;
        b=ktLqtgEqTsgsLOw6wbl1i5nZj+ns2kLIfV3gYTu7GBQWXOD5DeiEzObL9uozmI1UzC
         g4EqnO2nbCVuFO4nBgNOoXj62gqfZGWRw68GgWi3jSihs2t/C/nzOf59v4r+D1uOfV4j
         +AILEFikozgn6ndX7m/r2y4F6r8llmadDA9cN7Qhiy+jfkyyvcpjfbt04cpsyMtuHAix
         srJwbSsY/5cMCZvejBWDP2635a7l6hG54xvEryAxk5d/Ckx/GkTi8mMNimYKZFoK9fQ+
         JsK+jgt1znZlAJJmLic7wbcuIdTGW2/bu9RwQjXDpzV3yLD21PIdua52nhfmBSq05DT6
         1Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313789; x=1719918589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R5wxQYwGfaVqYk9QukhujZ0AZZW5oBR/ydEPdcFLQY=;
        b=UIDm8ZYG+QCBD75cSM+CQczN2y3glWK6qDzYsmtee3AsGiBEkRTWcVj9Ykz6Dwtsa3
         +5tkweHTOePVVZeb9OZt2Veg4te7ENK28ibXZ1eXIsOx2UZOVEj/7FNjUPtofwITK6T+
         eMLy9kRwymI9aMd78oMpQ589eZW+0KCOBfvOxy2q7gviDX0aXi7LFmKP9FJAG480TnQ+
         USQkddeQozBdvaZ2SoHCWNerGnB74y/bqugjAHjcmN8X2gkAojTby0mqTYneFr8gb9wP
         aAo9iJ87uVwgazleE2188pjhxtvAqfO2FJNUCHjvIXNdYMAmFaxVhS7Z/ILlrXbENOqW
         wYvQ==
X-Gm-Message-State: AOJu0Yz/nm1LtPgJL66GLfY6Vytl3MyP/JXsjEALM4xfoDSm9HYQuWGJ
	/+lQbtfxXShGOuSkcM/Z2Vq8CoBwPHHwvBo/FiT00kFx8TiYIiNyueXzFlRdOsp4/BYsrfGC7s8
	IPhjUm/SCO1rIc4AlS66L99d0VZhBzlyHrIxCfg==
X-Google-Smtp-Source: AGHT+IGFPvgQg1o9LeRDhdQ+qJIJ+JQi9wNh81iGlEdpy/Tfa/2hvfiRTSb4TnSM/hw5l+hirYUDOyyZZbUacxz0ZYk=
X-Received: by 2002:a05:6122:411d:b0:4ec:fc23:7928 with SMTP id
 71dfb90a1353d-4ef6d892a1dmr5555079e0c.12.1719313789305; Tue, 25 Jun 2024
 04:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jun 2024 16:39:37 +0530
Message-ID: <CA+G9fYuWjzLJmBy+ty8uOCkJSdGEziXs-UYuEQSC-XFb5n938g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 15:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm builds are failing on stable-rc 6.6 branch due to following errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
arm-linux-gnueabihf-ld: drivers/firmware/efi/efi-init.o: in function
`.LANCHOR1':
efi-init.c:(.data+0x0): multiple definition of `screen_info';
arch/arm/kernel/setup.o:setup.c:(.data+0x12c): first defined here
make[3]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1

metadata:
git_repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git_sha:
580e509ea1348fc97897cf4052be03c248be6ab6
git_short_log:
580e509ea134 ("Linux 6.6.36-rc1")

Links:
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iMq0CHppQGxkVSsEPFtnw08bc6/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/details/

--
Linaro LKFT
https://lkft.linaro.org

