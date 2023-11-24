Return-Path: <stable+bounces-2412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050367F840F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF228A2B2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038533CCA;
	Fri, 24 Nov 2023 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNC/9PE+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC9A2694
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:18:28 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5ce8eff71e1so4226917b3.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853508; x=1701458308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y5EvPm+dIyyxToEIiLBN/BUv/oh/7CgG9QocWi6TRY=;
        b=hNC/9PE+RveNcuq7uj8Pjjsxh2AmR6SnhyEtGUh5hg8qwztS6A1DGSmN8MwIi5cmem
         O8WPdjAG9D28Npd+VL8H5yc6dp8C4R+dN0o4pBrFqjRyge6Kqqxb6qPtODnVcZV2AbfU
         yrDHEopYseeLoI4jn3stUfx3plEc0EtAx2h7YjFNTLtzxVmjd7uUgcqeOFwTkL/M0YK8
         oGVsL36CcN/rhD3hNGmzl8g5im4vj4N9DoZ4SSbb1ND3uy64EJtiV7y1idoULH+Y41x2
         0vLwyjzUL+Q96OUAHY7m1krSgMm2K5qlcFhaKVnDN2NKpqnclAw2gHz2x1V/ZX56rP6J
         Dq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853508; x=1701458308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y5EvPm+dIyyxToEIiLBN/BUv/oh/7CgG9QocWi6TRY=;
        b=knw6Gxji0j9MwRec5vVpxM9JiFyJcp6HqdHVsuPKP2TnO0h53L73KcFX7on93dUHHP
         b7eeVB5kLrkQV5WmVQISUC6DjON7SgKJo3nkFtEhEDq9IG9/5D3q+rarfj9p+ZJJ8rwU
         m70ImJDu8CE2jCRQWcij8KbOjdvk9lBZavdNVnoHxcSGQT6mQNXStr8+wXSFzIxAEBXD
         aYUpB1ltyFwEcTOVZZ0tZz5gIRTmRSZTELNlY4GaNQ5naGuQxpBpmAXfEzg70E4OHoP6
         0oyL/TElJbh3vuEXWFDXnWcxgLw8K7/lTDslzR0u81zWPzXG5A8g/S5E0mxuSaUJXuj+
         11qQ==
X-Gm-Message-State: AOJu0YxD/CQriF05UuNmT1zpcCbJDlXskPweeIRN5hUemzyUHuWA3v7i
	KAaAgpB8gkSCdJjplg3KO02aYYZJ3dV9WM+uVAxA6g==
X-Google-Smtp-Source: AGHT+IG0J+CigbyzoWqpfwOWZHGZshBQ3BB6VtNdolTpxujJlcObsE89jrok8amrqDkQvtpvSn2O/PyFKR2BHzwUbio=
X-Received: by 2002:a81:5e43:0:b0:5be:7046:b2f7 with SMTP id
 s64-20020a815e43000000b005be7046b2f7mr4634734ywb.40.1700853508071; Fri, 24
 Nov 2023 11:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124172010.413667921@linuxfoundation.org>
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 25 Nov 2023 00:48:17 +0530
Message-ID: <CA+G9fYs1QwVjKK0wBcm2EtDbSbvG7fu7Ca=SBAZfGDAsEJLPZw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/372] 6.1.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 00:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 372 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:218:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  218 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

--
Linaro LKFT
https://lkft.linaro.org

