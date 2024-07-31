Return-Path: <stable+bounces-64791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA1943455
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8061C2191A
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7421B14F1;
	Wed, 31 Jul 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJHtM0RG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CF1B1421
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444417; cv=none; b=d6DxQnl03qTcowJIxJFpztUSKXBkzLEcYzl7dkdrduMTfyGQYuAVG33MIjzdUTUJu/7lF/K2jgr0RkIe4rGJXj5KVL905DD8pN7yE7hwgumqu/Eyrc7qjMFt+jn5s0lxd0zNoMQgn9pmGOte3jukb5eszhg2/z7E0hYq0QdYyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444417; c=relaxed/simple;
	bh=DPC7a/ItVVS/ZUsDBa3A34Cag7H61CGwBsA/cvnuO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuthLkNDFeqbn/v4VoELcFl4BUMurF2wqOf8i7xINivs4o8BPsUjChBrj+UQYZZ1vLuns2VudYNYrvTBzxWW7MEb/QL08VlWIymvbTwqn7qW98j/LtQYfrKCMXYpD3iD6b0Sf1W2tYCrT1V4FI03pFW4OjnhT7nQlrkINnUYuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJHtM0RG; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25dfb580d1fso2670081fac.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722444413; x=1723049213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=pJHtM0RGdLn5+O28CzkMS+62BASSYNGIjbh3LTlIWM+rmVD4m/sy+flHKKJvMWNNdR
         0JyVBE0aA0oDIZute/5Wo+kOyfhU9UUVxmUUqI2+ThmVNwo5JrJkXZ0/pNx1Th+AYeSU
         oKvYKE4izz4lL789eHTT2PRLUFu41SB9wAIyIakwXMxVOORt+gBfZz/2FTGs/W2HYGDb
         +RnVS/3jzVGKEpjtcuEmNmzDVlwCiFmAd7YMCBegauOBOB61ojDwvOPvkA/UWETvGCCw
         1dMEVsYnYYc7GLHfoTSsbv3P8OSCKA7tIoAkuijcvoxMrZ/quL4eu8lopXXM+Ro20z2z
         Ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444413; x=1723049213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=SKKunJEK40v+O/w7QcGf9EI9iNyiUHUHbNU9VAgxu3NHrcqM9OQ6w4HPGqz19nFf+z
         5UvSMOfFVr06oJ5QlFOthyEsjvSTNG6kpje9tiCxKQmfBzK7nUIHeSsR3zGvrx1y3Wm3
         LFycj0laHSnDbgHPbBxfhWd2pgsfNMujX4wyJUDKuJtvazzn3uguLHkZpTAFtf4JzNzN
         F4dVv6HvJyEVznuoE3jlRz8Sy6ri79dp7YRQ+8sxG+abD2ACc1DRKdYpXrdWaSE4SxxZ
         05/DnYcj4/m8C8PyQsJrxnd2Y5/79cPAOQnMwD8FuwzvEwsM1txbuOK1aTPowkLco/Ye
         LnNw==
X-Forwarded-Encrypted: i=1; AJvYcCUi6Hi5MQAe5jLzC8UOZtRIBOWMaluHquuqvcHs243y5gG8gyKcXcf7Qz7qIl6ll1K3D6B//tp3RAyaIZrLM0n+LA4Oso07
X-Gm-Message-State: AOJu0Yx8v/iYZU4nOxj4h8WzgVXV3nMqqAcnbyezcgckurgnCleYqqq5
	EwoW4IkhMUozA5nFlhIyjcAW9wgQll21Rzcr0ETD3DTWAGSdPYpoEW+fcNd5EiY=
X-Google-Smtp-Source: AGHT+IFRqHHmQ3zAhsmwrlSOV1mFp0GjcMDmn6Si4PesAAvwXnlJVIJpEu0YlsAaasZvPrDHo57arg==
X-Received: by 2002:a05:6871:aa06:b0:267:e2b2:ec52 with SMTP id 586e51a60fabf-267e2b304ffmr14807007fac.49.1722444413477;
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c572:4680:6997:45a1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26577239eccsm2721257fac.53.2024.07.31.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:46:51 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
Message-ID: <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
 <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>

On Wed, Jul 31, 2024 at 10:13:26AM -0600, Jens Axboe wrote:
> > ----------
> >   ## Build
> > * kernel: 6.1.103-rc1
> > * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > * git commit: a90fe3a941868870c281a880358b14d42f530b07
> > * git describe: v6.1.102-441-ga90fe3a94186
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186
> 
> I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
> trigger with that one? If yes, how do I reproduce this?
> 
> There are no deadline changes since 6.1.102, and the block side is just
> some integrity bits, which don't look suspicious. The other part this
> could potentially be is the sbitmap changes, but...
> 

I believe these were fixed in -rc2.  We're on -rc3 now.

regards,
dan carpenter

