Return-Path: <stable+bounces-2085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751067F82B7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D3285FB5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E6364C8;
	Fri, 24 Nov 2023 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mN0Tsh3/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB62D66
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:06:00 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c451cc7fe8so1327403241.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700852759; x=1701457559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNyfHMRrBzIt574Bt9GDCoLKWnWTa1vAH4W/mLYLces=;
        b=mN0Tsh3/XHYL1XKmGy0x6MsXPgIJ7gy3XSWbEF6OOXa8gtc5zQmYRZQkJyv7R8tvRH
         /ILNU5zDg4se6Njd7GigErtLRLlguXSyQEBmSbtm8WDSUOb+Y3ySwHn5JSfJ8tVBEcb+
         4GYg6S2WeuKjeFx20rCkZQ8KHP4Xp2EzOjWCDQKkh29S7TIuXmZUW47+SmX73yKv+E5O
         EopplRtHh6vPkniijB/CT5KM1fMtP1dLN7Z1/yXOVzNrukK/YmyU7VKcRi7ndZeSSL0M
         eT0pUfx5u+JcqJkAI8I17rHwXzmJqalO9OJ25W1vla860ol0vmsvgjBw/eIB3IXse9Ha
         +ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700852759; x=1701457559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNyfHMRrBzIt574Bt9GDCoLKWnWTa1vAH4W/mLYLces=;
        b=xRc8m7QW4Cfgv6dEyVa4FwmL8x0Qrti0m+7lOw8/EvWQZl56Ytoc6LWmDrePyHwjka
         2K8G70OoUzVi/9scHRdkk3qKo/ozWvNrRHa0sGNnEsm0Be3k0UrKa392tdua0IePHp/V
         zLZq+mRtUugTQ6gC2Cx1AY0Xfb4KDy8fW+cgDJ4/oDFAxxncxBvJ4cmZ+35VimtIP6Dd
         u2kYDgxIedcsbyajmPHmOehCmV4zcYZETMndomjOnaV/GCL/6Pn4dZ9ugsovncf4Y9N/
         ZenNTaqMzdUeVtWrgsj7Nwj8cEJyHboYaw1KdHBRs/S3hJbGdHofeE6R0WhUUIg5/Reo
         msPg==
X-Gm-Message-State: AOJu0Yz0kYDGm+yKHKrJ+yYCJcmTuxW6aggx/hfdkm6UwZnhT3NGmH9l
	KUN/qFkZfHrBWZamNdnkxQU7nUHkVskJkfDhBhqIue8uteggt29eJqU=
X-Google-Smtp-Source: AGHT+IGgEKPztEosXm9/H1kGq+JZEFdW00hbUz3Qf/fuM0hwoW0eNL4uztgDJFSz9DPS80w+JweeHhkk5qO8D0/fxFk=
X-Received: by 2002:a1f:4845:0:b0:49a:9855:2fbb with SMTP id
 v66-20020a1f4845000000b0049a98552fbbmr4456731vka.5.1700852759253; Fri, 24 Nov
 2023 11:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124172028.107505484@linuxfoundation.org>
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 25 Nov 2023 00:35:47 +0530
Message-ID: <CA+G9fYtrUpJ_+-k6dBaX0yZX-dkkrz3Qg-1FRwkG83pZvN44ow@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 23:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h



> Zhen Lei <thunder.leizhen@huawei.com>
>     rcu: Dump memory object info if callback function is invalid


Following build warnings / errors noticed while building the
arm64 tinyconfig on stable-rc linux-6.6.y.


kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors


rcu: Dump memory object info if callback function is invalid
[ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]

Steps to reproduce:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig tinyconfig config debugkernel dtbs kernel modules xipkernel

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YdN5Tb5NAFPo7H9WWQd0APrWu1/


--
Linaro LKFT
https://lkft.linaro.org

