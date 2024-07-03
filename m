Return-Path: <stable+bounces-57969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DFA92676B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05921F22A79
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911B17C7AB;
	Wed,  3 Jul 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEoJGHUm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010D1836DA
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028909; cv=none; b=YgoHF0BTmD5sYYObCWID57ugTpvlah1OsT6jgoPrwSjETvCLUu4PGTc10PLRyiXgBg34YC0LF4OUrz8JotcMlURaIALX98zPJjNpOYXzZ2W29cJH60EJ80IE1ep8tviigGaUhxpIP84FqmDaxlkoaIEV8veOpJE6AE+0Uf5kq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028909; c=relaxed/simple;
	bh=N8V2R60Um4mvF/DP+2QgAWbUsTYcbkQA65824qtqEKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qd9p1c4LIiNZgL4EHI/iz6WKs+PQ0JS8U0FIn6KHQJetwk+lgvFvMU9SpCdBqG8L3zlzxOVe8zQyuNRJknAPAGO/1Xfcn7/oh0GGgi7nkYhmxr8HWrbk14brkbtdWnx549+U+6fdNF7UxceIJzqJVwnORFQsdvssCE9dZZFjI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEoJGHUm; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ef7fc70bdeso1812906e0c.2
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720028906; x=1720633706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjTTtlNb0syE5KHwXFKv4dS9jF5tUNRtWjSxSGgYhH8=;
        b=vEoJGHUmZiE8r859Sd05aMMQeZp69insLmefrK2b9m0wBH3S5UKAed9BPNFxofjm8z
         039zaDIfhLi4/OEhzOGG801EcnAnzyzzX+W2+p/ybCUl0CP6AHk8Z+46nTaiuJA/J5a9
         jt1TjR4ykl3aBMyM3v2eZVwBTyeF6ZQC2vgLlTymIhOIbREPbxCHwOgfcaG/eLAAynWq
         uVeewVNge0LY5RQIqiK/88FLSqPutFjspGZfPWk60nJXCpBz0nO2+zyVQXhVBco7AxCS
         +2JUfrEOmwt/miEKpU3IC2HllL7BvUj2riL6THx/pLW6Lzu0tqzZOHBD3bm+7/BiFWfR
         vBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028906; x=1720633706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjTTtlNb0syE5KHwXFKv4dS9jF5tUNRtWjSxSGgYhH8=;
        b=nBvFuhFoeWVIJHGnJjbmovE5Ajhjw8EGBrTP0Qn+Kev9w460+NhJytGBzd3VImqpDI
         xRbciQ0IabaYn5AfEvLYl5uzDeL74sQDn8Y57xNjw5RAH86LA02Yk4AeM1JBbJf2a+6L
         pTRd9EAK60XpS7evfG+A6MHofcNUmx7vQpFkOY7dNZ/5Hjh2oU4KlQ1DGg+W3rrkRAU2
         MSse/3Pj5kpcSs9vVhFE+hOf64oeXJ6AEXD+Gl0lYVEynrG0GFoUKghir5/OjMS9L/IC
         UQKH6vc+XB+MBanbhOnUcFAZKatGT5jPGbWH2/VxSfq+UVoHKc+0RXIPNS4A6hR6HUYa
         7vVQ==
X-Gm-Message-State: AOJu0Yzf1/+599IMZdYatEWMGWmjfqtM1GBRNEFzqGQhxDUMuqLDkCch
	cD8LghDAh673Ss/mCI5eaZMy6KczW2w/8NmonWaQNXyZ8ocVkLLhzuvMdz2O+TdQYptEve6JtbY
	t7JvvIe61EiP3+BemD7T40e/IbZWJ4KfLRuGcsw==
X-Google-Smtp-Source: AGHT+IHq4gQLLZyc40X+uhVEaroOxiBVWeM6dpArotla1mzYAwd70XY8Y0gppC8vzwEKdeysF2KmeOOv9KP+gfgSVoE=
X-Received: by 2002:a05:6122:f0b:b0:4ef:320f:9f13 with SMTP id
 71dfb90a1353d-4f2a55043e0mr15627099e0c.0.1720028906555; Wed, 03 Jul 2024
 10:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102841.492044697@linuxfoundation.org>
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:18:15 +0530
Message-ID: <CA+G9fYvXVQ599HH3ZYfNEZrZwacR-0hzKCqrLa=+ON0hDTwwGQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/189] 5.4.279-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.279-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on stable-rc 5.4.279-rc1 due to following build
warnings / errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on s390:

  - gcc-12-defconfig
  - gcc-8-defconfig-fe40093d


Build log:
------
arch/s390/include/asm/cpacf.h: In function 'cpacf_km':
arch/s390/include/asm/cpacf.h:320:29: error: storage size of 'd' isn't known
  320 |         union register_pair d, s;
      |                             ^
arch/s390/include/asm/cpacf.h:320:32: error: storage size of 's' isn't known
  320 |         union register_pair d, s;
      |                                ^
arch/s390/include/asm/cpacf.h:320:32: warning: unused variable 's'
[-Wunused-variable]
arch/s390/include/asm/cpacf.h:320:29: warning: unused variable 'd'
[-Wunused-variable]
  320 |         union register_pair d, s;
      |                             ^

Build log link,
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24509933/suite/build/test/gcc-12-defconfig/log
 [2] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24509933/suite/build/test/gcc-12-defconfig/details/

Build config url:
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtfDw1Nbem1ANR1V8mLxfNeR/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtfDw1Nbem1ANR1V8mLxfNeR/

metadata:
  git_describe: v5.4.278-190-gccd91126c63d
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_short_log: ccd91126c63d ("Linux 5.4.279-rc1")
  toolchain: gcc-12
  arch: s390

--
Linaro LKFT
https://lkft.linaro.org

