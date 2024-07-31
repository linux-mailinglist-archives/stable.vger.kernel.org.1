Return-Path: <stable+bounces-64803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607494372D
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E2F1C21BDA
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E851607A3;
	Wed, 31 Jul 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqTX+pTu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477A17579;
	Wed, 31 Jul 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458255; cv=none; b=dOritJbAMpqqCqvCMEXDgIDWGTgNjRsmByLVw5mMqzfW+1Ozj1h8isDtLEuPCJ5KBM42We7O+GHQr2rYvQ7MMHD0EUsmkoERqv2pONWq5h1UlzCHnqXHaCLMzUgGlHpBRAWQyo+zHpExjDl6IsiIKIu3C0uVJvF/1n7wKSUuWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458255; c=relaxed/simple;
	bh=nk2rtqkALrOEJI4zx8bHmEo90G8/Hu9hDFGoit3/tbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRpUwIILfs99TyGIAn9dzYyvh+A2UXTJzw9lPgzRnBFyZGguw+cBsnUZ8MBqO3Q4JWdURn771KpJiCQeGSWGbxfhzcZJBwY7TkTLyV9B4Y3KeJn5n0G195CRzaW3cnR9XMeSfaDuuv0NMVdN20dle/SqHGw9vziZa+dyJ1N8cNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqTX+pTu; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-825896b2058so1464770241.1;
        Wed, 31 Jul 2024 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458253; x=1723063053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOhDM8lQxiqkUUvDaagzUqGJjpM37eXS5rnNFdsUI48=;
        b=IqTX+pTu0HJog9lBX6Ql7lqUUKWRpCCReI3dtKTae7Lh8Lqyfk81+uilVgSLJl3zgv
         zNKL5lIxO4hlgMYAxZwyNCNUQXC9DZVceWAa71bhrw0WPIOqtDHiLOOQCVtMifm6VewU
         2ME+PiB4b3vx7N2rSOzdBzAs1NNuJnCKBmjwzGqzR5W413c4xBg9TFoSqBjsBZ7wRJ1h
         6qVJzRBAtDleYVZzdGfFCS9kRdcDm0ax3Bz6ffZdOafJml0zOAWM46qXnLBILl4/KuuZ
         wjnIVxjZsWicboGEn8Kq+E30ojrt1OHfy3oheMqwHoaiDDfTCyzj2GiBHcGhNmUSt0DE
         a7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458253; x=1723063053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOhDM8lQxiqkUUvDaagzUqGJjpM37eXS5rnNFdsUI48=;
        b=bDSU1kbIlMbVoAzugkgDPEomhY0zB3pzjGBD+DOqWai1qLicgqUJXRwVPuvAMLb6Xk
         Zue7Vr4Kkvf0YLfx9Cru6LCoDSfNYd8G94wAGc1KHOhCasaWx4Xizv2rkMgTfPjMl0yv
         dyRzaopFo8R6sdxtM7s4ZlynLWi1GYx3XOlLVo+ZJTrl032rkP99Oi8LlPnCxgQ44xbH
         i3cGzCWF2qWCWG01jgyJAzJeS6r7W7PtBTvmjx5/ZYCETitBH6r2ycweIwPcfwKKYFTa
         /mXq3GBA04lRCt8K9jlw0vl548Dz/F7v9w3AWaQj02vwlrYE52hv4iHjfWGqPSUHJjqh
         OJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXe3Lbi3fDskXQTVvZgsCrNSn3aWv6kDe5vldwCD+WNoQCfy3QS/GZrANvUbadQ0sEtLA7OUP6BRNnP0MREBk9dAnLuuHZxhYS9OreG
X-Gm-Message-State: AOJu0YyQLcgsI7Wx175xaz2NH1tPbHUg0/CNgjO53itJzV2NKtVFQzQv
	fNr+R8k4p57kg2ZF4BUtpZRz3HXD/sFd5YeUIejAyhtIiir/9bqiuONkFfrACp1b5ZaMfzaGsTd
	yzoiCgsbU/+86qmk9F+/s8NXUCKk=
X-Google-Smtp-Source: AGHT+IGCtBkZqYwESM19mphPCC1KETf+G6XCOtzGQJrvZIQ7BScn7bT6T4xToOaNhXCTMK5k8/U4M8JbJXfbi95YdxM=
X-Received: by 2002:a05:6102:5493:b0:48f:3bcf:58a5 with SMTP id
 ada2fe7eead31-4945099bbafmr568249137.19.1722458252937; Wed, 31 Jul 2024
 13:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 31 Jul 2024 13:37:21 -0700
Message-ID: <CAOMdWS+tfMZ=aVjChQJ8n-ih_6_DmjY-xGPY2XOq783BuTmE9A@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

