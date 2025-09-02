Return-Path: <stable+bounces-177004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF551B3FF07
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C91B2715F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C25301471;
	Tue,  2 Sep 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ktw+Xa6Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F46301028
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814248; cv=none; b=j2ZGlW1jfDyD2F4RUhNLLJV0mKnZahvoGfVVCgMrmKKm+5scwiEYiX+kU43WHG1dH+IJDBs7jpCnf4G/4/j07eDZFjAG1ryLvj5AJtwhrjtCaCj9gX4GgCr3KzaOhV8S4vaMxNeFqdd8TQ5RxnPxTNYBwMw/b6cue+Erw9SJ8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814248; c=relaxed/simple;
	bh=kkPqc1cvhELv0tJYEVHD2ZdMWGPrOMkmdqrhZS4yPg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSOP7QiD2GrHcEXkNwsoaOoHAd2eZUojByO70+VbR3sxgMwc88ODYkX3fdAasixoNH3wUZ1QQTuFPSrTvhAr6rNf3fn0zxD0xz2SHhJPNnujiYCenC18mXcxPZsC7N2Rk2UaDvt02KD5KnUdtN/rKA+WEyTgAIj2yNcG2tcROLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ktw+Xa6Q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f76454f69so2175824e87.0
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814245; x=1757419045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp4Abv/fzY5toSq5c8kjCytYfJxDDQ+v7rc26B0Blgs=;
        b=Ktw+Xa6QWfwXZkenNWDpRsP3Zc7Tqm9416Tlt9m4HIjOPAnzCaj6Jw29SUcvb9mQaO
         Frb2mrUkA1bFxsOOWkbbDIMoZ6Z4PIuezinM1sD2qLIWyyl/98HofL0KWTaO7T5/ZXXz
         yGt0S83oUBaZMMGJKRBIpGtf/yrsR+DaOkVjxyjUWFQPMDqcUVBERlVsWi+fIUSQ/S+1
         6YFMO5iUn1PZvv/Cg60CCup3plzeY+nk2LyXv0FS2/3NpJRE6OrRd773NaceR6zUqmpi
         bhENwdj8O21rXNMHDUWfuTGTz5VUn+x8mmRITJuvWu6tqU6eXK2zUGCZ6X4x5CQL1QKC
         ntoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814245; x=1757419045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp4Abv/fzY5toSq5c8kjCytYfJxDDQ+v7rc26B0Blgs=;
        b=Xda0DBLAsB9LxGZD6K22s/Vr70JQjWWelxnSDp5oAEioiJR9vfB5UhITakyVZm/G1x
         9q+wH7Y0X16wZOvF7vX85fUIJzSOsZeImXvehLzPGmOR/3Ebob0f60OYzwr8Dnu5ylBf
         RVv1dr2fvOfrWu1Z1RxLkIBiPD6BwRPl6SDUaJj4g+4/5MiF+/UE+7JTWbYV7ggaxCy8
         ysZfiu/+8AM9Ex2ePrHCG51i4jbMBCmj6/gGswrfF7hJE5CHrAqaKwY8FtRRx7q1L8OC
         9Cg4DGLZgL85YrKUb59wyJ4hpDcW/vepwnJLRrBxjC/sOFz88C44aimwM7pHSMwudwoQ
         HXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHoxepQGHCFRBSQ7wv4Zxwlj9WdyFF0XX939FXMNjXDNTiT2L3aoAsTmRIsyXE7Rul1MwSxaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNfR2UXAUg2As5fOfoBXcqOPNpTZHTOFMLdirh2GhZKi8wfSs
	LXM7NUiCY99wSjvMVc4Oj1WHUij3nRebbzGJVXv5IVulChA/SbIYjqxtmYQgUJy3qbtp1OS/HRv
	sa/dJ4lbyRd/0695JllDtYZDL+DLJezc97yPNMwD0YA==
X-Gm-Gg: ASbGncsDs2nYHVXRy1prmRVeqlGzBlj+zauS+SdRxykRbBGEaK7QrO4KHWlkxzu2T7e
	eNACCARGuODmzznc7L794j9fQ/LF9Mw2RBj0Voo4ltMS+CaovS+/W54RvriTkuJXJky013xzS1+
	XXydvAGzqNue4FTR09MExzObXeK4hNiSBKfnp3CjNB/mwighTGtu8fGDcsYgbSUhfcN5XSJOImC
	4xu4yNbAIrBPAVp5QiKjztjecjCYNXvrOPPZVWMzrPOMuo9TQ==
X-Google-Smtp-Source: AGHT+IErcjW0+LGFGJcHQchCQeR1Yt+GA9XuQLP2Vn98G+VTiZcJCdrpPfkwDR775dV3lM7lVH5sLJhNO5IY+DD19Bk=
X-Received: by 2002:a05:6512:3b8b:b0:55f:554c:b1fb with SMTP id
 2adb3069b0e04-55f70912819mr3298424e87.29.1756814244976; Tue, 02 Sep 2025
 04:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org> <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
In-Reply-To: <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 13:57:14 +0200
X-Gm-Features: Ac12FXztQMclI5iZSDKTIUNQ7QH1_dUHxuo2PxWIXoNlkSSmA9MCP00AzVcpvI0
Message-ID: <CAMRc=MeWnrSPrLOq7yH71wpw4vP6RJiLnuLCpwXogZn0yugFgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:10=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 11 Aug 2025 15:36:15 +0200, Bartosz Golaszewski wrote:
> > This converts the vexpress-sysreg MFD driver to using the new generic
> > GPIO interface but first fixes an issue with an unchecked return value
> > of devm_gpiochio_add_data().
> >
> > Lee: Please, create an immutable branch containing these commits after
> > you pick them up, as I'd like to merge it into the GPIO tree and remove
> > the legacy interface in this cycle.
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_d=
ata()
>       commit: 14b2b50be20bd15236bc7d4c614ecb5d9410c3ec
> [2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
>       commit: 8080e2c6138e4c615c1e6bc1378ec042b6f9cd36
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>

Thanks, you haven't pushed out the changes yet so maybe you're already
on it but please don't forget to set up an immutable branch for
merging back of these changes into the GPIO tree.

Bartosz

