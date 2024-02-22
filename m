Return-Path: <stable+bounces-23318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31785F789
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 12:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA91C21379
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489904597F;
	Thu, 22 Feb 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWd/6cen"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA44438F
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602802; cv=none; b=uUTREcgStMvvp7ey4essmScW5T7ImMV0MNF9+spwEWCgwhbliIPbvCSVwT0ceI0R9TXnHbXZQjGCqnKB9/0Y46gc6m66RirmQU4err/PoqzCGpODKSuTgSCTLM4Qjqc/Ejp3Pq4u3iYral2VftFhLT7FVWnQOeZOdUjDWV3QSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602802; c=relaxed/simple;
	bh=DqtCVXd3K6o8XwOjhMFp+W2TlXwJY9ec3AL5OMYc8p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHJsXnRoIfkCGUTztoUdaI0ibqBlUvqLb6okqni2TGKbDOoodAbRtzsrDeiKUc6+9GwTpm7729Jc1B+0X2pwZhlRwNUzaoDlehyv6WBTxPSKdlrbyCM6wMebEX1tRobwqR75JAQYaDyRJyfvfKrA1WxJ8eTi2dDgpIpW7ziaFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWd/6cen; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b978e5e240so837359e0c.0
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 03:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708602799; x=1709207599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8U6oZWtdBlqxrlpBkHzojkkfHCgCtDDcP83kB8UZ02g=;
        b=PWd/6cen62NDE973eKHBGeOKMRkJdhZybl/HlkTxtdWu+9d9i6gU0p4E1uOJcl18Cr
         XrqBtTyHNCxXcaFZf2uwGpo73aZoLsqXKYSoi7p0cf3KLKw5dG48RMC9b0jbVfDjuQLa
         Ifbt2uFD2WbqMnR9IGAJjsXsQwgEuPL3I7Xr5gMMBsG5scHl5z0VQ8EvuGfsGRkHvP7t
         Rjb853HNrGBxx84bMd1nh2wNe7koTS90y14Y3RRopnlPqSxObuvUWnOOsYRszlIUQ1JD
         n1kowBKRHwfdv3kDE1pOwh7o9Y1qMgL8TqYsl1IpTb6O4a6IdJU8I3PeBkdztqW/tDt+
         aBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602799; x=1709207599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U6oZWtdBlqxrlpBkHzojkkfHCgCtDDcP83kB8UZ02g=;
        b=U4duOLLb1CE6uhH1JBe6RWZWy5htfHmIezqslJhNXcMpiHDn4qXjkLTdXEWSUYnoP8
         aTCxHKoiXJ0vLPGFhKLomd/0rERPTc+zJTv5oD+szLzxlJ/vXF4GRjvY9oEudD3PxI2/
         URgc+mW4OVNYTpwwaM/ht9TuadBH3gQq0hqTfvLIg07q3se0LBGovDfT7/VHcvqkWiKL
         Iscow5ogWUWTzjFFTOPI4/WufH598p95AJ/5da6QN/w3S/0WS4GW8LQ+oxFwzCuDmGLl
         +Km13OJ2nTwL29tN1dhAsTUUZ7uQ1lKNQdGy2fMgJw2emki1H5C4gBQGwy4tMbaiTzYi
         Ye6w==
X-Gm-Message-State: AOJu0Yym6S/YTZEx7TYKlK4MMHuWp2gVhPyNi1Y/Z/HJYeu0p2ySbPiG
	ifz+qIRqrTF3sSQRutDQhEz132znKtCbyh8Pf9lBLvsV1ykPEFDSVHd7Eec1tE77scM1nFe+MFV
	Dd8EVyqxHLl/VOKSAWcT1tZxajBKUQdyuf8rVzQ==
X-Google-Smtp-Source: AGHT+IGP3nsKeDdSkq6Krv45GcMwiPqqieAaRTPq1e3wSY46XuEvaAAzEwmjT1pNKM+4zywJhjwm6P2I+8S3jTvvYtk=
X-Received: by 2002:a1f:c742:0:b0:4cd:20ea:35aa with SMTP id
 x63-20020a1fc742000000b004cd20ea35aamr9444912vkf.8.1708602799232; Thu, 22 Feb
 2024 03:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125954.917878865@linuxfoundation.org>
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 17:23:07 +0530
Message-ID: <CA+G9fYvyOG+U1z351dafUXuZMoF1rgpGsvTHTFECB==2VZVPpQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/379] 5.10.210-rc1 review
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
	Mario Limonciello <mario.limonciello@amd.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 19:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.210 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.210-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.209-380-gd2880f0e0d6f/testrun/22797354/suite/build/test/gcc-12-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

