Return-Path: <stable+bounces-103938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD879EFD60
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B30166CBC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50B1A08DB;
	Thu, 12 Dec 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPmaqjD0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5848DDDC
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035096; cv=none; b=DW2ePIIaUhWWFKM84GiIeWFsepYHbN9CVRlCi8OzXmP9DA8BHeG5IJhETKoELfwbzOmqImkAwXr1yVFarJ9ExRIVVG8emSHJv86QqGUEzasXAplfGUd7chvFUIKDNceBe/ZhzdCnlJyQsszhCe5JrhO6V63MixMl8+h8nHmxqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035096; c=relaxed/simple;
	bh=yV9T7CxTEClw3ojAbutwyowwYwyXXH8RWuHVjIqJgkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc16fLPTAPWj69mtg59stPJ6DutBOh1FWBJG3tFAOQRcPgVajk7nY3gmft/LnN7HGZ8aDpGZTB39sQWz6B+VUqw2my0vUHY/mSIqel7himqgzYl5MO1EJp9xkCzKNIfJARj1c4QPL0GvyCjn3Zxj9D+hFmEVrSbxkoSjKKG07CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uPmaqjD0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so518458137.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734035093; x=1734639893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyk1k1r2jAN0cLHaRGF2s0N18A+YSZ8gAxSbY2GuSVk=;
        b=uPmaqjD0lgfwFk62VYLa5kIxkmdI0JeCO3R7oQQUHOAnw0e16Pe1ktWcaGZgWnl6gO
         83yWMXASMyBaPE+pHKHATf8ee3/l0hvfm8ejTUVKSJ7Okpq4Fcrto8r2N4MA4VULhcRu
         pud3ISzOYJy1C0krXP4FblTMgalNDofUXfIiOmCvF9bUnfxS90VEh1p6KIG2ODrqgFLD
         lmsFzdYiZ5iMN5mgA6fUoLqfenq6CJO/RyMiPwK1jXOQKr5iULdTiUddl6hSjZ2swZvG
         qCxVezwSuRvqfdSuMhL0Idqh54dr+M3UC5lcS6aNmNbPwJXwCV7KqSRH49nm/rZpShTn
         ZPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035093; x=1734639893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyk1k1r2jAN0cLHaRGF2s0N18A+YSZ8gAxSbY2GuSVk=;
        b=w5N13Cbq1KISefrDycBXOo7D7nFp1Wylss9iL1cBo9SUoxbhuAB0+fxmz6HhQ0EWOR
         +zGK4nmzfNl4yhGO+M82wqZ4/fg2svXxCvDlSKjVGdQtGPHC59dDPw+6G8y2sJNW6xY7
         9FpqoB61nJRZEwubZF+ypbGINPCxHXMCXqTNWXVE9zNzR8j8WSgf4Fd872IYtfSRK+e5
         XVC+ee130Hl65ULgys/6UZ2HVzZsQD56kMNU1yGP5f16SmAxSMu/Uyg/+R9pnoAMKEll
         DV/FSp0VDxt5pZona5/LDxS7WEoqYP6fhtItOaziCz/3FWX2GkS/r0YPoZU/7KTOhDQk
         EnQA==
X-Gm-Message-State: AOJu0YyeEExiC6un9alCMmDKmv+ohlp3oH7Fafizv3IC1a7RmSvfwjDm
	zeU9/uTncs8tYS7nNpJMxxti1TGLrojxlLPNi7JkicFcIxb0sJdxjGtp7WA+8+IAZ+DYhJjVFXj
	GqTN8kifVvSbnb8VoMn4AM/4EpDrAS0jFS6fHxg==
X-Gm-Gg: ASbGncsPWbKBCkSSGyBDKEShj76yIPE0amZ7Z3+GAZqteZLYvaSJTqb4HTJY8RUmgHZ
	fLVbqu8vYZM5IcmAFdR8Gf1beGYVcF8bFgzvV
X-Google-Smtp-Source: AGHT+IE6vhYsuoPpswe0nSPSyj8CcBuRJJiRB+TTqVgTkTFg6/WgsSkujdn5pkuKz45a/zlvFALZgalThUsECtSfvGs=
X-Received: by 2002:a05:6102:3caa:b0:4af:3ad1:a26 with SMTP id
 ada2fe7eead31-4b25dcf59b3mr333942137.16.1734035093603; Thu, 12 Dec 2024
 12:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144229.291682835@linuxfoundation.org>
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 01:54:42 +0530
Message-ID: <CA+G9fYv+i=T0KeWvxhiCOFiMSmpUYeUOWwn_YunEaYTi8oA_Ww@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/321] 5.4.287-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 23:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.287-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As others reported,
The arm builds failed on Linux stable-rc linux-5.4.y due to following build
warnings / errors.

arm:
  * build/gcc-12-defconfig
  * build/clang-19-defconfig


First seen on Linux stable-rc v5.4.286-322-g3612365cb6b2.
  Good: v5.4.286
  Bad:  v5.4.286-322-g3612365cb6b2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
/builds/linux/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:173:2: error:
use of undeclared identifier 'DRM_GEM_CMA_DRIVER_OPS'
  173 |         DRM_GEM_CMA_DRIVER_OPS,
      |         ^
1 error generated.
make[5]: *** [/builds/linux/scripts/Makefile.build:262:
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.o] Error 1

The commit pointing to,
  drm/fsl-dcu: Set GEM CMA functions with DRM_GEM_CMA_DRIVER_OPS
  [ Upstream commit 6a32e55d18b34a787f7beaacc912b30b58022646 ]

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.286-322-g3612365cb6b2/testrun/26292205/suite/build/test/clang-19-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.286-322-g3612365cb6b2/testrun/26292205/suite/build/test/clang-19-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.286-322-g3612365cb6b2/testrun/26292205/suite/build/test/clang-19-defconfig/history/

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch arm --toolchain clang-19
--kconfig defconfig LLVM=1 LLVM_IAS=0

metadata:
----
  git describe:  v5.4.286-322-g3612365cb6b2
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 3612365cb6b2a875194a5f6d7bc8df7cc26476b3
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7we4wjwYp6rA5DbAHITARXUgJ/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7we4wjwYp6rA5DbAHITARXUgJ/
  toolchain: gcc-13 and clang-19
  config: clang-19-defconfig
  arch: arm


 --
Linaro LKFT
https://lkft.linaro.org

