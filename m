Return-Path: <stable+bounces-61780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4793C786
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29349283734
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571519D8A7;
	Thu, 25 Jul 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1SoH6+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4C19D89E
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927454; cv=none; b=oEo3PMoOyQCOiCVqFI2gAMmf+daj4o+QnEBsJF35dIp/lj60cz5C/qvvPV1FfOI1h/BP4JHH1ODMoucLuEaz8YWq4I3WGJE9ddAUivIX2QhlyoWbZzyKWcgIj0CdQTLKZPwFPoX8uhfAKtEGMpuIBFzaR0JeCeTz8xs34ugIDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927454; c=relaxed/simple;
	bh=yq6fiZf90GE/tQySFOVh8V/HeAcKNExS/zycZaa10Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8ryK5/lm9AKS23F45l5xMszvj/fUJEuhBoqZuL9/6JaiM0NdYK2giyz9HhAFgqEZzpXnTWA1tGe2AotKk8h5IOZQXpCgq7a7te3HVL3mLVDL4g4M1i7IeF8JGLSVJGhZC5DfcSY1icuhZYBXowr4wwNRMuSaovhmNUB/W96pQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1SoH6+U; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db18c4927bso55063b6e.1
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721927451; x=1722532251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/6EDuIv5npXWqlxfUSzl63jK0iAGmMuRKGsW0DtQFk=;
        b=M1SoH6+U78cvdRDxe55p9K6etlQYFHjJWxEKzjKJd/itAZSNqin34oBQKMGDjibsmJ
         zgyP94d64ZAsUWo6LTnf6As9xqhjy0OW8I1/m93sBUvG8APnUav+ynp9x4/81LNZsftB
         tNeNMHk+I4c5Xx5k98gcyoNMprtd/n5PQBsNY+iqlXkC6LdNBdj/AFvfUavZIYDZMwlK
         z6HmAPevtVsIhkcGchsIHOj3T3hAO6kbXTkaYVp7I872j29wQ7F3QkXYwikcU8vC0cXN
         ACO6QaULA8KU5XT3pCJ1DiP4DlM9OrvbX0OcYGTheYEpxcPjuL9LnB6wvgAswbemW7PL
         n89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927451; x=1722532251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/6EDuIv5npXWqlxfUSzl63jK0iAGmMuRKGsW0DtQFk=;
        b=pI6ZacTy2dJmwB/YaYuYwLZ7mgZyPeR/ZPY7UD9wwBvk1Skk6Kp/95JRvLk8bjBVIW
         2wtTGOSeBJRdVaGPYTR+n81RL14D/eYLRrIuIGd/04PLWqcpzR7ue7R6IVLs3DYKW9O6
         HINs94qvwK0HauxhZ25BIfSmUMUC3MmuXHvBSVDxHpp2pWz7udN1qMwq3W0+JjjTOAIC
         mEMGbNAkj/XTifwOWhTzOSKBsCvQ4gRhgY4YZWuF3JbBv2Qvba9unUOGHWj5YTEbmnKb
         zd47s5aO+CkeYgkb7cJ4s+XF9NfiLtdNsuRIm0RFRR2S/nZRlc5TlCU/JhXOJXqRgg8B
         2sdg==
X-Gm-Message-State: AOJu0YzxLwrXFaVW59kc1fv3xrkQm3O1rr8LIh4nbigdH0++yNV25+eO
	vqlKLVo095RHmzSqhJIe4pAXyXhUNsbiUpoZNYf2sDjOqS85ovw+qA8O4SMG//VkRAtkVEz/8zn
	dMM6tRfzyw0HnNe3G77UrMTq/sSKBaTnLOGv/xEQL6yiypZ7Esg8=
X-Google-Smtp-Source: AGHT+IGZJWFzM9uMa6wq5NoAxXUBEnqFHPu1rf7aDHw1G3YQx/Iwzcp3y7kbrA2Tb6TdzHCuqJn2Ds6P8BN7E4HUIA0=
X-Received: by 2002:a05:6808:1924:b0:3d9:4004:ff27 with SMTP id
 5614622812f47-3db14118421mr2499522b6e.21.1721927451044; Thu, 25 Jul 2024
 10:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.511303502@linuxfoundation.org>
In-Reply-To: <20240725142728.511303502@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Jul 2024 22:40:39 +0530
Message-ID: <CA+G9fYtZKAiw3abrvxmBovfYbJK7XcpV0aqH8Lg9wPc=i5ULHA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/33] 4.19.319-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ian Ray <ian.ray@gehealthcare.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.319 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.319-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors were noticed while building arm and arm64 configs
with toolchains gcc-12 and clang-18 on stable-rc linux-4.19.y also on
linux-5.4.y.

First seen on today builds 25-July-2024.

  GOOD: 8b5720263ede ("Linux 4.19.318-rc3")
  BAD:  f01ba944fe1d ("Linux 4.19.319-rc1")

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on arm:
  - gcc-12-lkftconfig
  - clang-18-defconfig
  - gcc-8-defconfig

Regressions found on arm64:
  - gcc-12-lkftconfig
  - clang-18-defconfig
  - gcc-12-defconfig
  - gcc-8-defconfig

 Build errors:
-------
drivers/gpio/gpio-pca953x.c: In function 'pca953x_irq_bus_sync_unlock':
drivers/gpio/gpio-pca953x.c:492:17: error: implicit declaration of
function 'guard' [-Werror=implicit-function-declaration]
  492 |                 guard(mutex)(&chip->i2c_lock);
      |                 ^~~~~
drivers/gpio/gpio-pca953x.c:492:23: error: 'mutex' undeclared (first
use in this function)
  492 |                 guard(mutex)(&chip->i2c_lock);
      |                       ^~~~~

metadata:
-------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkAGJux4DNHx9cFS4VQJrPrBvc/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkAGJux4DNHx9cFS4VQJrPrBvc/
  git_describe: v4.19.318-34-gf01ba944fe1d
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: f01ba944fe1d15cbd27088980031db315340e6e4
  git_short_log: f01ba944fe1d ("Linux 4.19.319-rc1")

 --
Linaro LKFT
https://lkft.linaro.org

