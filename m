Return-Path: <stable+bounces-15535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC7838FBC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCB628D666
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302C5EE99;
	Tue, 23 Jan 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lidfzf/D"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D065F541
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015633; cv=none; b=nLrYD28nxVsVlV5TQ15fFFCYTEzAF/ZXeKGecapD6sGxHWTwzqVGuq6ilmanMzAlmTaA77FV/aXLaOeps8g1dLskhLmyfj8g/vrKsdQFIa/PFIgqkdQHBrrP9SGUzCzv8mAni1XERaKDYFsOVnzRQK3zB4SwSAGDUBIf1KmCfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015633; c=relaxed/simple;
	bh=J0H1M0wTy6ZAjcB8gwE0Ape9n7NPht8jS6c983A5reU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL/9U0kdnPMUEdB/uYSwRITFRlywU7eiZcSajU+jYrflOCE7t7bCFwDAonPTXt9so0dCEObiOAb6DCFUxQ1HaIyFlvvkDbEtZ7aT88AXMLTvhMAdxjnnr7T9mZ1398TIlMWUUlU0nclBGlVDyrIRCy6ZTC06IQaQk5avfOvIQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lidfzf/D; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f15a1052b3so41345937b3.1
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706015631; x=1706620431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDso/2Y80kbqbJKefAGut4d9dRp1m/o06w1Bs0lmtgg=;
        b=lidfzf/D795nGA/NohJRI++m2cBBEejunFeL1cpRUnOxpg0x4ObwsYc0y9TVE/bYXa
         RtOph5BasDvMQxd9j2s9t5/NS/jSS3vHdsXjsCwGStR36EMGA4vn/ZfhQ9li3eGqNxF2
         rHOkIJ6RR/8jpm3jbsixBi4Riy4ou/VOVCaNBTsuFmHh9L5hc2eFGJ6tRPJ6GHqyTpg9
         Invw5atPfC5+wikpzAtS7kECYUTbqmqYCRgc1H1dwAYRVl1tT4mBVMIQRzNc5PARf3c9
         CzwcBc0XGPq3C9oaHA1giFtTDdxazwZPHogOtI7QikuuuJJ7r/8tR1B/c4alAQ8jt4Lt
         LnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015631; x=1706620431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDso/2Y80kbqbJKefAGut4d9dRp1m/o06w1Bs0lmtgg=;
        b=O3lO9RXSRlUpDZ3tnyYNM/CQq4TAvl/JWRGdi7euTc8B7cKHyqUwy8loBa80C74SMO
         rdcXwU/rtg7GWYexJATBNd5lXgDGNXH5QMPPBuLmlVGJvBRa1Z7Qjv2Guca2WNCq9pwu
         CAO6VWmORKh92zqvoYzblUiXRsH1gBRLgBkDB1fYvjfKX9ZYd8TU6Rfr9ActTUy/D7EP
         Re4LoDsmBbiLDaN5ejVYOt2xP7JXyMrONPFVAFcZfdl7eU0eXBo32/POye8xO11xkgru
         64y8SbJQtFhx0t2nAMiEm9a811JkUFaQvLVf7bfwRFs1zX4ZU9u4+1ayIDczp8XZlXFs
         /eBQ==
X-Gm-Message-State: AOJu0Yyo1eUpSInhEDwZRcDSXffbL83sAbZ62C+puwbIanc0sfYK9q3k
	TuV2fyVmy/AlMS7Bvkov2ZuGY/2OQof6UUwJI8qMx0Y1v7D+ghOqjU4E8md6vpnUPxtJUEtOyd3
	Z1gW3PhMkVNroTh4O8DXJlHz6XgMwQh2Nvqv+GA==
X-Google-Smtp-Source: AGHT+IHw/YsJzgw2ky7VF9P7A+DY41B8Ee51i5bTyK1wO8/iF6Ar/aP/6+RDlrSbAisT5mdkfql4kJB3twIZkNJcukY=
X-Received: by 2002:a81:ab4c:0:b0:5f8:b42d:4707 with SMTP id
 d12-20020a81ab4c000000b005f8b42d4707mr4363579ywk.101.1706015631168; Tue, 23
 Jan 2024 05:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235812.238724226@linuxfoundation.org> <20240122235822.085816226@linuxfoundation.org>
 <CACMJSevr71oSy-CjUKkyXa4ur=mQL3R+PBnJUWQB-Pw3yp+kgA@mail.gmail.com> <2024012314-distill-womanlike-77bb@gregkh>
In-Reply-To: <2024012314-distill-womanlike-77bb@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 23 Jan 2024 14:13:40 +0100
Message-ID: <CACMJSevTCk+HkeBC4YbmiRrzViwBNi9r30wdDKrB8J92YBcu4A@mail.gmail.com>
Subject: Re: [PATCH 6.6 328/583] gpiolib: provide gpio_device_find()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 13:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 23, 2024 at 10:56:50AM +0100, Bartosz Golaszewski wrote:
> > On Tue, 23 Jan 2024 at 03:03, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > [ Upstream commit cfe102f63308c8c8e01199a682868a64b83f653e ]
> > >
> > > gpiochip_find() is wrong and its kernel doc is misleading as the
> > > function doesn't return a reference to the gpio_chip but just a raw
> > > pointer. The chip itself is not guaranteed to stay alive, in fact it can
> > > be deleted at any point. Also: other than GPIO drivers themselves,
> > > nobody else has any business accessing gpio_chip structs.
> > >
> > > Provide a new gpio_device_find() function that returns a real reference
> > > to the opaque gpio_device structure that is guaranteed to stay alive for
> > > as long as there are active users of it.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Stable-dep-of: 48e1b4d369cf ("gpiolib: remove the GPIO device from the list when it's unregistered")
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> >
> > Greg,
> >
> > I think there's something not quite right with the system for picking
> > up patches into stable lately. This is the third email where I'm
> > stopping Sasha or you from picking up changes that are clearly new
> > features and not fixes suitable for backporting.
> >
> > Providing a new, improved function to replace an old interface should
> > not be considered for stable branches IMO. Please drop it.
>
> Even if it is required for a valid bugfix that affects users?  This is a
> dependency of the commit 48e1b4d369cf ("gpiolib: remove the GPIO device
> from the list when it's unregistered"), shouldn't that be backported to
> all affected kernels properly?
>
> thanks,
>
> greg k-h

Eh... It is technically a fix but also this has been like it since
2014 and nobody ever hit the bug (or bothered to report it). Ok do as
you wish with this one.

Bartosz

