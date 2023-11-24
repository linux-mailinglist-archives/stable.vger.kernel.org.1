Return-Path: <stable+bounces-2330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541767F83B9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8F5B21A72
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041235F1A;
	Fri, 24 Nov 2023 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9iPvhPg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5212695
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:15:35 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso1330147a34.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853334; x=1701458134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2MveOECZmWaMqUFClvcSgbtbFksGGBQJiQIt0r94rRA=;
        b=n9iPvhPgK9Rn3gKO+coiKQfmFKFeUwyYz7vlEoAO0v7qiKsoGJcdQM+5p9DhhzuPf8
         JBldxG8+5HTZvbJrydcl20vB8Eo5XcBy/SPvtOKfPoxAZpGVR/9Oni6R8dKhoiAxrmjY
         kiL/Xf0tA4tPvnRoqREuUx0NPRzAWWyCYjhalHWWdvoshhi0g1xEcexTvYgPvBhyMBvT
         8QwIDM6GW5xGRi1/IH5BLTSpDv2Es4UCX4G9KPLvcXyplUCSLYuj2MZULeLtQnaS7+dw
         3z2HIEnsM5rGlrscP05g5Fz2JBYn9InRmW2GUbs8rr/jkfycR5drodBTdLimsyS2hNg9
         Lr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853334; x=1701458134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MveOECZmWaMqUFClvcSgbtbFksGGBQJiQIt0r94rRA=;
        b=ZT4BVKa+egYxTuXEPptQGa0ELEBxdelRbJUoWGi2BIhIBP5SLZcA3QRJ6tGNLbkufE
         iV/Pp1O/UypKxZUg46SVIjWLybQydAB17YO8W8Yt4Vfd0kYRFxklFSJD0h/Mxatiq4Gd
         pQJCKxH5K4CqFbprjeflWXoTaQTmOW6yWDAszrjr18kQb6/DEI16cPARczkCzX5tUK1h
         J6ZxoJ4N9DM7OAsQHqYmkz3RL8BskUHYy/fAkM8tMLP0cL7UdtG4ik0AMj0ddEs+8nk+
         MJ9TLM59QyJO5WYznswx8AA6GiZF3LY7pffRUA4Q07X3TCT/FOb7e9LHqYp26JO+GYfm
         qSbQ==
X-Gm-Message-State: AOJu0YyXw6TY9sRmIpBxASJv4v2QUPBA3IbKhWRW+w/5UpcxxgCru9i4
	Vl0fbN2ZMY4f096Z9SHPGmt+z8kRuHXFn9Nn4QmK3w==
X-Google-Smtp-Source: AGHT+IEnWmBT7sz0OtChNm7SYIKXzLwrJzaYutL5Cr4YoEx+Z9lPQzssPXUErmDHSGOelffPe1qHLBX232hzer90JT4=
X-Received: by 2002:a05:6358:e48b:b0:16d:bc40:3055 with SMTP id
 by11-20020a056358e48b00b0016dbc403055mr4793780rwb.19.1700853334076; Fri, 24
 Nov 2023 11:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124172024.664207345@linuxfoundation.org>
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 25 Nov 2023 00:45:22 +0530
Message-ID: <CA+G9fYt27vXw5po2gtEqi8=hJSR7Ge3+XAS+fAHt4MiHbEXfpQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/491] 6.5.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build warnings / errors noticed while building the
arm64 tinyconfig on stable-rc linux-6.1.y, linux-6.5.y and linux-6.6.y.

> Zhen Lei <thunder.leizhen@huawei.com>
>     rcu: Dump memory object info if callback function is invalid

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:

In file included from kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YdNC69sBYUq3cp4iEDo4eom9RD/

--
Linaro LKFT
https://lkft.linaro.org

