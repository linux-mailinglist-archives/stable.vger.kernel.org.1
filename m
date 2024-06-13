Return-Path: <stable+bounces-52062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2C9075CB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9341C22547
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8D146597;
	Thu, 13 Jun 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Atz33ow2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452682C76
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290472; cv=none; b=shXGRPxIHzpXUkt6+bHkot1IDbrTL7KEpeB1hM99GArxYU89IqM2bNmok9sBI1ZU5Lp/3k8d0IO76uUFdo9OOd7NrV0qUQPfSDXUoGvajM24zAbVsq7R8pPmhkpYD9HNOZlaYUq/WQBIOcJDgPcdbqKcu4GZUBhqEBnIe12kOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290472; c=relaxed/simple;
	bh=+HZBDinZDCMT7Ez14OypUVVwLMkZvNTY8vfAf9qVU3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsZ+pRFD2l0+zf+uEdWxtG/FjcukhFVtJrVx2xkL7/mkN005moHvHye84b/dy4XFdlatyHG+gNMJVWp/CSCg7jBiY/8rp4cVKZ8OhAauuiS7LdlbUoXMRsXXjCfd+v00p+0o3I084odGbK071WM4Zy70w4IjSdM9Zv0uQVBg1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Atz33ow2; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80d6cf96e13so318965241.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718290469; x=1718895269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7g5SALnsdPJQWBZt0kVgnA0bB4kjPLGUDBHBwv4noI=;
        b=Atz33ow2Y46i+1Uyb90M1hD1amAg8mvabA9p0oqITmZAh0CyHmffJodCTqn3JNo1lE
         OEo9wEKfTNDSQhqxv6lg6TZwdPHXRRT7parrTc9/kHYlcpNLv9i2DGaImHR1x8Y5UMav
         0jUeTr+9EFZx/wkQxSFTZjhEWTKJN8jQti8P+RNTp7D8CQ8OwW1acu6bxSpgyIGY/LHO
         R8ACeZ8D6E0WyjukIkpkr07XXj98UaKObY2ppQi0Lk10oQ08u2UHYhbSTut85fow94bz
         2X3Q5SOLZjrYnZvcDhA859iPOm2ctT10fDp3gpiKhK+eriNo7ULrh9SCnBLPJD6/HDB3
         4o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290469; x=1718895269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7g5SALnsdPJQWBZt0kVgnA0bB4kjPLGUDBHBwv4noI=;
        b=dXooJgxJaN4HFiZhWKqqjtVPBwZyna27DHKyBLYokQOvslBdukKphcYUP50GSxAwc9
         dANmR3mgn9aUdm8KxdTcdnxS7CYW+fwHX9nYUNmyFdgGNqFlapE0pUfehkLzpkUAHZ5g
         s3yANO7zuexlYWFWPmRlW+rsMwTYvnqceuYX4yavTH5w9iOx2pVLBTtFhDIKubljoV25
         HwQWPLr/R9ljpG7VxPbJebwDmxesEOoCGftIWXKJIaYGctqPnnYAaUL19FBsYlpFlDKd
         +mZPyh+49X7lwky1K6d7y+eino/kPSnmx3kfolPMjHg0UIQuNUBYMRFkFTNznImSbV2x
         DnWw==
X-Gm-Message-State: AOJu0YytXvx91HNQCNEwdA3HhYYFy+vCrsV18yMPm5nvkOGtcgSJ3HA1
	YXPk3UqlVUN2KcjlbsN2VzYlY4iI+hyjsS0nhfLEL9H11/hp6NmHZeyiF3w+HTGFhpPaZjs14bi
	3TcgaHbgbTv/0gVShSWbeGyP2IYUbtScuiUmpxg==
X-Google-Smtp-Source: AGHT+IEFJBIeVpnD+lw3dEtVlaKMEXn/UPaJkQ+jBNt3IL0NdXWuc6/aVyLKENNOoHl9TZ+IQBZ2xK7qOnH1FQoGYNM=
X-Received: by 2002:a05:6122:20a1:b0:4ec:f27b:ee9c with SMTP id
 71dfb90a1353d-4ee3f1628c5mr73958e0c.5.1718290467801; Thu, 13 Jun 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113247.525431100@linuxfoundation.org>
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 20:24:16 +0530
Message-ID: <CA+G9fYvS7u7seBUY36kGdJQJ4LS==ex=zzvBztYUE_X9AT5nYg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.219-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc builds failed on stable-rc 5.10 branch with gcc-12 and clang.

Powerpc:
 - maple_defconfig
 - ppc6xx_defconfig
 - tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
from /builds/linux/arch/powerpc/kernel/asm-offsets.c:14:
arch/powerpc/include/asm/uaccess.h: In function 'raw_copy_from_user':
arch/powerpc/include/asm/uaccess.h:472:25: error: implicit declaration
of function '__get_user_size'; did you mean '__get_user_bad'?
[-Werror=implicit-function-declaration]
  472 |                         __get_user_size(*(u8 *)to, from, 1, ret);
      |                         ^~~~~~~~~~~~~~~
      |                         __get_user_bad
cc1: some warnings being treated as errors

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24321785/suite/build/test/gcc-12-maple_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24321785/suite/build/test/gcc-12-maple_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

