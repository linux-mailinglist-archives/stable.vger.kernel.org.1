Return-Path: <stable+bounces-23315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D938385F63F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 11:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF531F2657B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984EA3FB31;
	Thu, 22 Feb 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgx2pUFU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C773FB2D
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599350; cv=none; b=BSfJ+hGwWZL43ojbPCFIsQSXb6HiorNuzMyWCpH2Tb4pz9662ZhvFCpzal8DauRn7I6n98eHkDAbhGaIp8EquJYUNvkV10BDGilKQ+7Fj9zVoWtZDbFr0tC3lA5vZxree8z0kxUwGlJFEYsNQUj5Y6UbBqRzv7LY5ihsXjywvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599350; c=relaxed/simple;
	bh=439y0CawLDEh5lyhHpxtilezXhVvm/Hhbvki2S2xLNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCzvkHDRrWz/EyoV+mD5YNGXfpMcpNKwjwIXohkoj7WwasKqzAHdoBxyo3/o/Ik7C+XWhuGiVurWA+Zw9lijNn1VIAvnWTtFsB99PF2hUutU6L5FCdeUSVjQgBjFD5BEJPDrKeSRsQ3LZBW6UsnihUixXWTTbztu4ofknemf65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tgx2pUFU; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ca4a173209so679348e0c.2
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599347; x=1709204147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4z7DIQDBcuDFxLdD60iofNC7omQneCJjVmeyaqoak=;
        b=Tgx2pUFUdSF438hTbEscveydfeeumNfyXxCSO+sFQeVNfr3ZB6EpguQqC/u2CZpAox
         p+wDR95AYVDVpJWBdEvNaH/RAAz50jevE0afOYQ2r/5MP4aMy6viE7xDm6ILi5s4nABV
         R4iloNk4Zpf60AtQ9Y5hCWwqiM7tH6Mcon+eaWRx0n1NxlWKlzjSaWUN8KhVvDVwoQZM
         o0Pj9DYcmkbWGyukIu1Ti1IZ2VSWc7krgWAWsqIWSrQhRb3IjM8pPK9LyMhYpLBae5ih
         ZClyum/b4JE3oNF0Fl0zgPMxECmeE477rg4DIM+vSjAT97njZEKRJbuEXPZsBNk7IZMy
         vXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599347; x=1709204147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM4z7DIQDBcuDFxLdD60iofNC7omQneCJjVmeyaqoak=;
        b=g1YskcnLqxi62rVvpbjag29OBMcNayzimaszcxOx6pJGLYDDqFOh5Oj4TW44m/seXm
         y3hHko7/Kf3x3MswFAd/MHNA1xr8Pm3cCfhmmu5n7LLhry2FlU/FnLeYLcoPpbMBTd9Y
         XMppty6VJHdoELpaF+UlvzsBN+tLD9OklihIB3nRVECqQNBDxlceyA724I3QU+mrCeW7
         ZwA5YT704ClaVnplYGI26rpLbEzwC/xxoQw3+oTc/rOIbNKSV26zLphsBigmNminOQfL
         IYiDH8yWDbbFuJkdFIlLIyROzYGkJGzfW7Ho2ltu9DYubpYjoo91v94cgeSMv2wmta2r
         I5kA==
X-Gm-Message-State: AOJu0YwbPWMA4FVy31GUpEKio47PSOtYi0/KH2bxFUhIlFjdm6mOAjqM
	4ayNFrqzJStnD4MIScH0QyyTVuy1nnkYYimTwtJcAQNcxxBINIOaG9Wlhq7bzzlFegmclnnkKJz
	4iYZbCOgfOapyz1bP0U+RA5ggF0coenpPcitE1g==
X-Google-Smtp-Source: AGHT+IEp/h0CWwA7NPsOW74oY68F34eSvRnb+Q+eHPYZkQd2Rfzkx8nC/J+bPgf3qu+051y3j5tLOkn3980LYQ3YEBA=
X-Received: by 2002:a1f:d447:0:b0:4c8:90e5:6792 with SMTP id
 l68-20020a1fd447000000b004c890e56792mr12587102vkg.7.1708599347459; Thu, 22
 Feb 2024 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125940.058369148@linuxfoundation.org>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 16:25:36 +0530
Message-ID: <CA+G9fYua_rKjdmKMgYrRY_HRyMWPdJNz5=O0K4+M9P9wBWLPcw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Beyond <Wang.Beyond@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 19:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The i386 allmodconfig builds failed on stable-rc 5.15, 5.10 and 5.4.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:133:
modules-only.symvers] Error 1

Steps to reproduce:
 tuxmake --runtime podman --target-arch i386 --toolchain gcc-12
--kconfig allmodconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

