Return-Path: <stable+bounces-71321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515D961308
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E631F243D8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591C1C6F5E;
	Tue, 27 Aug 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cshmBU59"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CA1C3F17
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773187; cv=none; b=JUoeveIdXA+PBujzc17CYOHnlQNUEoEk6EnMNBNDafeNBaLA2PpxQKmKCzwpMy1lIfx09gisLHzRAS/TCjTrOrE64jlyVJE7RJcWlOhpH5mR+88oXxkOPl3eQ8f5hyQkx8ZIGD6J2Wj2SBG/uYVgQRX9eAr+28SgVHb5SPFzmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773187; c=relaxed/simple;
	bh=J8i0Lb2oWbc6JBapK1BY0lUoCq02D7GVagTSdbkqv1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdcsSRkM2zkOAZszb8c9SxJosYgnFKo54SIuBwzXJm80wWLJ5RXTLMxYfLGjU3O44MJEW5P05OHptce7L9TvB2ni/gxTRlBLp8wKJqWbAFthqgJolxw1SeeNW9PZOpk8ilN1Z+afILfCJxM2C2ZzTNT8jmiCcSdZhjyd26Nq2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cshmBU59; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5e1c86b83so4530374eaf.3
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724773185; x=1725377985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=cshmBU59B8Y5XavgvLSrMfF/g+ab0w0/qNjaBmPn8DOLpyzD5OfHW28NZoxO+y/oTC
         BrJSIy0yTwDQX7gSxm81rMLhIk1MTNjXSx51UHSRZuE8VxYP5IE4EeJFMOL4FR2/51jP
         6fejy1vw2Q1cIQz3hekKQqAjtD2xRdcfl0IdLNyd/fJVP+6hLH9D2bDNJFicZvbFF/b8
         jlxBTQdCHX43+sQ/2rGVN1RH1SY1RJcYYrwV1WQl+wdrAwGiEiVS8epmlrjbWSFnOJHe
         w/P9zdhuWd4r+18VLvYdph2jW4Ml7UYQXD6el0w4QvHnNdGBN0Y/NKFShBbs03paQD++
         dwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773185; x=1725377985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=iyoO+4ntOwYf2PI94nkvwXUaB8R9Kv54mqjzi0ZBc/qqwR3WoD/PZniPvpbxP9iPv+
         Je2mLNgI/RmNcdO2Jl4eJYBasxd8p78BJJn6Y4sh6G4Fa5z/kLTAX9E7tjToKevznogz
         yEZECAqm+qvpISI/n7tpeW/WNlZCbPFKBsr4JSVNuuBf9x8hi3rk3lriQhJWWiKlyn3h
         YD72AjbMVuO98SH/hEeHfPkb7cFiVUa1jIDllVnDhEpBst9nYOUramBui1Tl0RFB8HLy
         EOEWGv+yY3SGhvPs06c+1Ywqpg9lPgRjU1AQarMQAte/vtZf+0TuyAGNUBA5GlII7NMa
         WjRg==
X-Gm-Message-State: AOJu0YyM224Rl5RTK76MrATTWeofznQjtFMJZdIQqccMnjyOh3+EmZyZ
	9NE4KIdHZHI4SR9dp77MxGHFDYMU9JHkUAPZjYYg4i9MAVz0JJEon2X32bNnE9l/7jhUuCGA0UJ
	UpfKjXoZMg+ULcxYvqhLlbgXJwk3Z9c9ftS0nGw==
X-Google-Smtp-Source: AGHT+IE+kcBunpFXfOGpuNdas/X5FdTgaWsUmcSrsoP0VkiG4IG6IRfZg8+GgGc5TZDGinb+7wjme3MyFaQZ0qKWfPE=
X-Received: by 2002:a05:6358:430f:b0:1aa:c49e:587d with SMTP id
 e5c5f4694b2df-1b5c215d7efmr1740185555d.18.1724773185173; Tue, 27 Aug 2024
 08:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2024 21:09:33 +0530
Message-ID: <CA+G9fYuibSowhidTVByMzSRdqudz1Eg_aYBs9rVS3bYEBesiUA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, rcu <rcu@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The tinyconfig builds failed due to following build warnings / errors on the
stable-rc linux.6.6.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------
kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
/kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Build log links,
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/

 metadata:
----
  git describe: v6.6.47-342-g0ec2cf1e20ad
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0ec2cf1e20adc2c8dcc5f58f3ebd40111c280944
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/
  toolchain: clang-18 and gcc-13
  config: tinyconfig


steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

