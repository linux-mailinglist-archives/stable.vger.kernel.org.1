Return-Path: <stable+bounces-98308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF039E3E5F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE3516384C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1520C02A;
	Wed,  4 Dec 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc7VjwwL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5011B87C6
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326384; cv=none; b=lpS7ruPThggZBoOLHzs9A9FVBv4TUBKeSflyIORKpLRtlBkULGOJyJuraRZag6B9aJC/SlIGKti+6MuM2UKJBkf+1hpel166X0lHtwl0pB/WcUzzhoY/aX0fh6TelrtO+jnwqAONA//bFbh0otCRkBg64DnVbyfxTZ719xgDs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326384; c=relaxed/simple;
	bh=WKAlhH29xEF4xdMd6IOvEbZvOJijsedbXkd9Fo94v+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pU7oikePJB82fXI495NDV9FxXoYTka7SfYpZm5bfK/Z/Lwggy7T3946aD+lBrAV+u/T8w6ucQ9i1l7EY4taUL1BhANVIQ0MFpFSDVQD/qFoOvm1SvuenKFyTYrn3uGLyrjp8PNT/OD8894s6rALEMx5V6BrLFTO05sBYA5EPChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lc7VjwwL; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51529df6202so1599737e0c.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733326380; x=1733931180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BM7g2tnTxffenD3gAnjnDpzGPqkZZJws6+BF+fZajU=;
        b=Lc7VjwwLdDhtjzyshExaeLaBucdetu31MNHxwHZ0+0irwnROs763o9LVBguJ6M8BIa
         pGgzp+hfC8ITIXW7h+6rNblFjjNIA8o+wJUJ1JtW4rkyEmpncvM3X8G191IAgS6dB0oF
         wT/uEsIaR0GFSrDg+i5GX0D1gYG31IpBMm60ipz6ne2gLw5/Z1qRk9r1X6tTaVcW/ZKK
         UjACsmtr5z7qAoBfc3ekQ2fjDHXXkqaH1v51WaEwOHqNZVkKbc7buwvorJCWKHIAu2z7
         p3jcaFsDpcCooR3hkzlsEGoq8aqsqI7c/QeQnruaIEYiOnVhVbV+5qr3aYGdroNlWDYD
         7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326380; x=1733931180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BM7g2tnTxffenD3gAnjnDpzGPqkZZJws6+BF+fZajU=;
        b=DxHoZdxR98xm54YA0t9SwPVt7Aw/SoEzkV3pUMyihTYUZ7z8O9gtT3M95yyBK12mCn
         nebcfbBxVoIQbXT6Xe1QXaLVEhmmuA5oZxTZYWxTZZb0DR5MvVkocGNfw9OrkJjJfnIv
         pyZ5i1JCzkOJLhYOZxnJQG23i3o2Wufk2ZeQI1yyCQ3aRCtt7hqOiDUdbk7rSSSn8ofw
         fFqsKvjwtQ/blF2+sKzKQxBu8e09xIrhMcauke4hKu9NYDgbGaolzYhW9DK8mMZmouog
         HKBOv0fS3wKgTV/mOeM4t8TkszzPDHXSdJYkVhJaIZjIGfFiWhqnRcWTxvTUIJBIsiNX
         mo8Q==
X-Gm-Message-State: AOJu0YweGV+i2EaP1aisxBjfam3C/0DAqWjOEkz9jm5bScq+uYnXTlMP
	VM6GT6cQBH9s+6MrnGigeuoJYONS4scVQkkkuyXCpPCod6eJjgrW55WVeS/IeH9f0uJmD5Xntej
	cCIn1itmxuhLQavI/tlyVZRHutaqPVjJkVCs71g==
X-Gm-Gg: ASbGncsHilHcG4XkY9r9IIB8AeMki/pw6mBZARIDw8t6AoQs3+tUgX5Vrl60wNzqspv
	GMzrBE1T8jX1CscIbrbXU18WhmC7kYCJR
X-Google-Smtp-Source: AGHT+IF0RVZVCMdJkXYjBAAcJHezPOoWCH4jS8XQLyQLEPZuJ7e6SomQNYsR4Mx3bJ489e5yJU/yOjgwrrV33kHvO74=
X-Received: by 2002:a05:6122:1d04:b0:515:c769:9d33 with SMTP id
 71dfb90a1353d-515cf784e53mr6510755e0c.9.1733326380385; Wed, 04 Dec 2024
 07:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203141923.524658091@linuxfoundation.org> <CA+G9fYtXS+Ze5Y8ddtOjZPiYP1NEDhArQhEJYfS3n5pcLdn9Hw@mail.gmail.com>
In-Reply-To: <CA+G9fYtXS+Ze5Y8ddtOjZPiYP1NEDhArQhEJYfS3n5pcLdn9Hw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 21:02:47 +0530
Message-ID: <CA+G9fYuDAAZkgNK4_0Y=wDcTUzs7=ggbni4iJDAPbD9ocq992g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/138] 4.19.325-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, noralf@tronnes.org, 
	Sam Ravnborg <sam@ravnborg.org>, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 at 19:24, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> On Tue, 3 Dec 2024 at 20:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > ------------------
> > Note, this is the LAST 4.19.y kernel to be released.  After this one, i=
t
> > is end-of-life.  It's been 6 years, everyone should have moved off of i=
t
> > by now.
> > ------------------
> >
> > This is the start of the stable review cycle for the 4.19.325 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 05 Dec 2024 14:18:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.19.325-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> Regressions on arm.
>
> The arm builds failed with gcc-12 and clang-19 due to following
> build warnings / errors.
>
> Build log:
> ---------
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:177:9: error:
> 'DRM_GEM_CMA_DRIVER_OPS' undeclared here (not in a function)
>   177 |         DRM_GEM_CMA_DRIVER_OPS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:303:
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.o] Error 1
>

Anders bisected this down to,

# first bad commit:
   [5a8529fd9205b37df58a4fd756498407d956b385]
   drm/fsl-dcu: Use GEM CMA object functions

- Naresh

