Return-Path: <stable+bounces-61778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701493C77A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80334B21E0F
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE219D89E;
	Thu, 25 Jul 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6Dz+PSd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB119D088
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926711; cv=none; b=UbHSUoIbNRNj8+DSxq+XWTXxzgdgEjPELizoukcPh8LsayC//J4hndUweFzbueWR2a071p/iEDGLwqvxr3ATZWyGd6tbShbEijFGcrNB+fcp8vpsP732yjTsqrbhovpC8ybf3pOmxRkqnt29jtBODwjCFIlVSvNzqjXqT5Z8VTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926711; c=relaxed/simple;
	bh=Eh+GYj41EH2bfKgWDm+bmK5udsi7e7BfjyJqmvPoP/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0X6eiPK+4WFOd7BIwUj5M+mB8pKecuQyIv9nsGsB8sbxscwfPlm/iwZdrL07BOCvvbsMUmW56+yuVh6MJPQj3Els3qUUrP+C7aqlQnEhJVE7sWCi3W+8paE+2GGxU/qNLfLOCl89z4S/FBq8L9Rgy0COGcIpGDkgXpFQX1jtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6Dz+PSd; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f51c218396so363754e0c.3
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721926708; x=1722531508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDQ6s6CMG7gHp/w9EVEaonlcBFFTlypRMzTuMlEuBvY=;
        b=M6Dz+PSdFi0lgHU+SO1xPYPAvd8AskY6vJaB2sfZA2BZujiFnVezu8ikflyQREp7GO
         TppVhX2GhqxkgYUsi9ID7/B0dlYNvguMhInTg1QOdlx+F03gCCN/BxoZJeE48G7i+1mb
         iy3hbw0HvkT74PbOwmYcDhNOLDff/dwQwN6q9ElNUAy5PnR8ztA51eFqHtVkQIcX3fBN
         ME+zaQdU8YEvkP0oFr0eboF2xh/3kmv2hS8HXzF9a8CSmmSJhTW1KZYAZPVi7hInTVe4
         VI6ybHZlkH8c1aQuqHdwzIH3HH6qaHgdPU1IBCriUptXoonW/LOghbxoXRZcXtd489SY
         /hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926708; x=1722531508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDQ6s6CMG7gHp/w9EVEaonlcBFFTlypRMzTuMlEuBvY=;
        b=ANF4FiF3vVfzdw4TRTfaHDZ5/Cq/nyRGna21dozANkXTQ2Htrj1hziYKfb1oCUDSsB
         tTNP0ybVTov0uW/1o6hh/GEOpDNKZFL2E6fXDB7hUWezXROFYUU1PUrQ+dAFHb6BbwWK
         x8T1pb4j7m0GcBWR86F8cQMeX9Hq91bbVL4aVSyva0sIo+dy/nHR5KSUWc4CWF1ShIOx
         MjfVGK/qAfb//lBBICNyB3qfT/wvnnvSuZ668z530NoJqUn9kwNFZQfMKAD2n1cSAwUp
         iK8FF4J/TWzeSyKeRdVEse0YUANKAjICVIzHYeuGRE9kXh5Add0uuqNPgZXXbTbq0SoY
         g1fQ==
X-Gm-Message-State: AOJu0YxHrU8gv7TC3+xepK9Mv0cjhPo9WiwJ+MG8KHO8uMZXKYPKy0OQ
	oDewbwmhEAf3NDAWhdogiMjZaIS61Eaon+uykgACK3D1vo6U2fmOkLA55UrlzDvbi8jCM9ctTfJ
	bEuM+zPUVOnX36v3xoIerlm8uvr/8nGGxRTgzzA==
X-Google-Smtp-Source: AGHT+IEqzIGu6UGuRS/hG4Muuvv+ROC3+TMPz4G/q7GbQ1qVMcFVJrUiW/7L+Riug4rto673vTz15kixh9I30mEwN70=
X-Received: by 2002:a05:6122:d8b:b0:4f5:27ac:ce6e with SMTP id
 71dfb90a1353d-4f6ca2f4282mr2619326e0c.7.1721926708409; Thu, 25 Jul 2024
 09:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142730.471190017@linuxfoundation.org>
In-Reply-To: <20240725142730.471190017@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Jul 2024 22:28:16 +0530
Message-ID: <CA+G9fYsVD0Yn2WPqu3a_CYtDZ=XR4WctQLOyTdn=EoS-idDHGg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/43] 5.4.281-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ian Ray <ian.ray@gehealthcare.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.281 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed while building arm and arm64 configs with
toolchains gcc-12 and clang-18 on stable-rc linux-5.4.y

First seen on today builds 25-July-2024.

  GOOD: 4fb5a81f1046 ("Linux 5.4.280-rc2")
  BAD:  13f3efb40ee1 ("Linux 5.4.281-rc1")

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
-------
drivers/gpio/gpio-pca953x.c: In function 'pca953x_irq_bus_sync_unlock':
drivers/gpio/gpio-pca953x.c:699:17: error: implicit declaration of
function 'guard' [-Werror=implicit-function-declaration]
  699 |                 guard(mutex)(&chip->i2c_lock);
      |                 ^~~~~
drivers/gpio/gpio-pca953x.c:699:23: error: 'mutex' undeclared (first
use in this function)
  699 |                 guard(mutex)(&chip->i2c_lock);
      |                       ^~~~~

metadata:
------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkAGMFVlBW89jcWOIsv80LLLSa/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkAGMFVlBW89jcWOIsv80LLLSa/
  git_describe: v5.4.280-44-g13f3efb40ee1
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 13f3efb40ee1218ae1933c1a9f876c2a86c48664
  git_short_log: 13f3efb40ee1 ("Linux 5.4.281-rc1")

--
Linaro LKFT
https://lkft.linaro.org

