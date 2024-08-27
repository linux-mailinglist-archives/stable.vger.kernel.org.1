Return-Path: <stable+bounces-71337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C9961670
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F541F24907
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22071D2F48;
	Tue, 27 Aug 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynzGlrWP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E51CF297
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782077; cv=none; b=qgYruY9Yoy4mw+gNwiXvl2aWB8h9CtT1b4a9CuzNVGJobjBZPqkCo7Zg5Tu5SbVI/v1pl+OD02sgOCxu69AK8MAkqjSO+FU1trM894po0F+Evi9TvFN0NsEoXjxQDqiZcLCtBuZqc+PsjrP1u559WztmIXWLgO+pFN20VSAi3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782077; c=relaxed/simple;
	bh=lAhAeqgjNAY5g+GAszam7Q3K2oVB0wyj04I9ekuclp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P90sU4mSQ+nwrn2yam+EADYnovKmqJMKfZhJIXVBYNKoRrGe/shZKmiC3p4A2Ib3OjD+kMBEGpam1sLeIffg67K+vDa03gsMUBy1VNhAXBxBPaH4xHGdrBPfnT1PCX9UO5Qie3bG6yX7cdfVUvQl6oekWIPm0D7J1FILnV0CvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynzGlrWP; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dccc6cdc96so3168503eaf.0
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724782074; x=1725386874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/b4dRpNjGudpEwl7Acu5bLfC+npGjFhptD2B2uvvIhs=;
        b=ynzGlrWPuoahcUR55cqwmA9KFr4/KfHyxS8m029Yp5LyuNxc2yrlz8D3wlqcRalQzm
         cB2VvKBZEro8WpT27VIn3cc4t/I9doesblJUY3gGL9tSdPEimkSCqrim2mdqH42rzXPp
         XVqULua6JRwgj9EFb0iW8ReJCPEcHpnzrgkbZCnBQR/PjtctCrHnNQCaPYaAB636gNUC
         FxVL8RP2XcQY4dn/GDfKyaGxyco5X3O1AZHdocBG0czy/nGLfMs5hWF2t7sfmIlNJ5Fj
         YPgAtlbYWposK8xMOBvR9tfx/IP5A2L9BasOlttkD5pLb7TvpXKM9kjohG0F67TcNLs1
         tLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782074; x=1725386874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b4dRpNjGudpEwl7Acu5bLfC+npGjFhptD2B2uvvIhs=;
        b=FqLZ7EBijN9/MBeSUIdlmyramQUXWXvdPXv0erAOwlD0BABT18OPLyaNB1yOHO73EU
         RXv2XpPiAnQUWS7q06RaCALtJm7ZcxnP3YBHbqxxf+0byZSenuzf9vGajQaHcgfTnikQ
         lyBcjOFf75g6TQnfEMTW1JA3uBK0ezgonA0FIrlHXx4VXCjleMhYwkbPPLVg6Wj+pO5S
         KMjLh+Ctnl1g+NsIwsBuaDSwKpxkVsY9Nc4cLU0GBrj4SG5tmIWy6mu11J/V1kI0kZFp
         T/pK3cdXHotneMW0O1JymlJPKeCwiZb7ybFpb8K34cvsj0ys2jwLU8bgeHfvlw5PL6zd
         3Y4g==
X-Gm-Message-State: AOJu0YycDe29vvS0SfyUBgiH3gXY+YjbY++Th0G9HPeUT84dIFENYkF3
	jw1gxbVsqlKeIsgXyKQ8HbNHjLg+f/EEuvstwUa3Nv6DKWKZAnavbGc78Ut40+WjfxpqunMGI6e
	1+k8PaebFiHn8yPJil+MPA3S0jnRSjMl3M2ulFw==
X-Google-Smtp-Source: AGHT+IFR8RYrS+3AYHKWfyfd4ucpXHOPlxyO3EUNWmKH5WtItwGtOhPVzmXRV9SuRNdjiJdFwEX8Vni9ZUK+S+bHf/o=
X-Received: by 2002:a05:6358:724f:b0:1b5:a043:8f43 with SMTP id
 e5c5f4694b2df-1b5c1ea9182mr1595275155d.0.1724782074350; Tue, 27 Aug 2024
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143838.192435816@linuxfoundation.org>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2024 23:37:42 +0530
Message-ID: <CA+G9fYuS47-zRgv9GY3XO54GN_4EHPFe7jGR50ZoChEYeN0ihg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
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

On Tue, 27 Aug 2024 at 20:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.107-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The tinyconfig builds failed due to following build warnings / errors on the
stable-rc linux-6.1.y and linux-6.6.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------
In file included from /kernel/rcu/update.c:49:
/kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
/kernel/rcu/rcu.h:218:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  218 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Build log links,
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/

 metadata:
----
  git describe: v6.1.106-322-gb9218327d235
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: b9218327d235d21e2e82c8dc6a8ef4a389c9c6a6
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/
  toolchain: clang-18 and gcc-13
  config: tinyconfig


steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

