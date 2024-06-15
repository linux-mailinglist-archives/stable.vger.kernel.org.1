Return-Path: <stable+bounces-52272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBB9097A8
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CB81F21EAB
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6AB381B1;
	Sat, 15 Jun 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swKFqJR4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7204282F4
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447598; cv=none; b=duU36XCX+7PQGJ5zxWPZtDx7eOJsvVOoiKmn4AobviZMC7KRD+ohdPqWfZO1VnlYo2Ypt7MGYolAxZ5047AiV3MzGsdPAGkoKx2d/wsE4j1IXIuxkT+AGVoGtJXf2SBVuR+8ofccQjoRwL60OO02heeynnbOboe08wSfJEeWFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447598; c=relaxed/simple;
	bh=EU1gnY2BkWspVSzX6qx6GxRxGvIBOpUKnTm4qkB7WvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzTVUSfldpMTpod4ctfVBga/Y+/MU2dTljFcP8NkLiKoueBpQ5o6isVuxz2gRSuUB/myt6rb5IZEmAW0R61URf6w1BcfC8phR8/Op5ZK3P48MXJNozEKzc8Q7vcDXHm3gyi+S3+QmedjIjvAS2mKxR5JM1H6UL6XSZgQgN0FUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swKFqJR4; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80b87c529f0so841951241.2
        for <stable@vger.kernel.org>; Sat, 15 Jun 2024 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718447595; x=1719052395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNhxJ8lsLsKUcd80cpqGpDxPPP4z5jSyvizVwaYRNvI=;
        b=swKFqJR4cbu4XNsL6lxAvv85OaNqkkV/KRiBEIIOrqySuHqLXGKwaBpwD2Mh7GtTsD
         plGGaIHsOEHsvTu1r+8WIEJZiDdxL+GXr8iCeUXdfCmrTcB6e4+OyuWP+gEee2ds1Dd8
         PEn6ZSPlPZfZuSzQbieEkFVOJMc7rYcUSztkiRjKLgqPYBDtR+cF9JWCz34xg/VdCsvF
         SaT0PUukbFFKn+8xCQwlVz0abGpj4r8WFx/k2LNeAwz0FAeHUo55wkBXQ4swCC7dvXG5
         pmFy5+zXWCIyJ3xkTsBZD1S/J7tJuyuvnjKQ4zgLsFQZCokQGdW2MOtpx6KBTPSFqPyP
         PT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718447595; x=1719052395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNhxJ8lsLsKUcd80cpqGpDxPPP4z5jSyvizVwaYRNvI=;
        b=GcLZ5kWq0TDXbIX0h0OmI5JwHmYPAEX4/AnaKl8ROWvb5Zl0xQ6m/vYwl2jr1nD0Xw
         efEEMVAzrCtl50iPLWfWiVJGP675EAaFrTeiOla/CTG04jQbziY6HJFPT1RBRj4AccAX
         tF9K3HCUFxmhR1RyuoydvN/VZ5xTZKlOlY+a0+dzgb/nN713UBDlno92UQAwtrvz1xyi
         Lq4TMwbpERKm6dLEszd+vcMJquiZHnYEdI9edGEug2vc1zPctqn6peSejiLOQSa4vhLH
         U7g3gJevhoWO+Qzkn+Rq/ivmnpDqXruoq9GKSYXtSr9AWR49Hrhu/5PR/F1BDhHfiMTy
         tdyw==
X-Gm-Message-State: AOJu0YwKzbBqnwfc6iCCsx+dyy7R9qpYLzaPc6la8PhD7+rbkE27OZ4z
	eieXM9RvnJ+ZT6teTHh/JSNaAZj8gUDJF4x5t+9+/W+nH38C4x3mUBV6jhn4RzzTBPVrYqri8uB
	wdxS0Jd+qaJAU87pX3s4IWFTgeqWs+UipPCZw8w==
X-Google-Smtp-Source: AGHT+IFoy+c7kUP3aO8IVTdrE+OfR+1MWmkP5LS3gnb3gO/yPNE0qycgoNhwrdcWokJHmP5uM9TdHffodXQX0LyhX7A=
X-Received: by 2002:a05:6122:218c:b0:4ed:682:7496 with SMTP id
 71dfb90a1353d-4ee3f7548f0mr5464427e0c.12.1718447595513; Sat, 15 Jun 2024
 03:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.969123070@linuxfoundation.org>
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Jun 2024 16:03:04 +0530
Message-ID: <CA+G9fYtN0R0=i_oP5ZfUxmBuqatTOY9XDfKCw9wjsQVo=YRAaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.316-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As other reported,

The arm omap2plus_defconfig builds failed on stable-rc 4.19 due to following
warnings and errors.

* arm, build
  - clang-18-omap2plus_defconfig
  - gcc-12-omap2plus_defconfig
  - gcc-8-omap2plus_defconfig

Build log:
---------
drivers/hsi/controllers/omap_ssi_core.c:653:10: error: 'struct
platform_driver' has no member named 'remove_new'; did you mean
'remove'?
  653 |         .remove_new = ssi_remove,
      |          ^~~~~~~~~~
      |          remove
drivers/hsi/controllers/omap_ssi_core.c:653:23: error: initialization
of 'int (*)(struct platform_device *)' from incompatible pointer type
'void (*)(struct platform_device *)'
[-Werror=incompatible-pointer-types]
  653 |         .remove_new = ssi_remove,
      |                       ^~~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Liks:
--
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.315-214-gafbf71016269/testrun/24321970/suite/build/test/gcc-12-omap2plus_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.315-214-gafbf71016269/testrun/24321970/suite/build/test/gcc-12-omap2plus_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hp7W1xcas5CN3psaeGX1n8sAj8/

--
Linaro LKFT
https://lkft.linaro.org

