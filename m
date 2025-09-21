Return-Path: <stable+bounces-180823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63793B8DFFB
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 18:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174EB3BEAAE
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF95255F3F;
	Sun, 21 Sep 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rls0ouzV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E634BA47
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473556; cv=none; b=stiF6wHul9VZukH34N566hLSt87pjoDfjInA6yGOk3Vo/fPtL0ES7GcVvCHTUclw5N2PoKkcE4LYxNRvpHTrDqVV1Np5teMLlsXVGRmohqDqJxDqeLWKw3dLcps8Uyt5Asta+ngdQFQNMGS/Yk/3mWTsrQZy5eG5+6WbFgEXvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473556; c=relaxed/simple;
	bh=MQFhsVmxZWRjRv4itENoU6Kns9aiuQ3DhwsabFR2Hzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FTCnWjy1SXrOtmV4r/Z3y6Ct7oPSikMuc9DZmM9/FOiqTPyKLqTMrWe/38/GzwVvgDbWw+JrjBTUK5QrixwbX8V30CJ8KHtMhYJMyNNx+Eoa4Gaefg1rY1MldEiUpajT8lKoMbnv/7JQay0/wwehk1fqFgkPCA8rCME3FgE4qrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rls0ouzV; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-eaf8e85f66eso152250276.2
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758473553; x=1759078353; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V76Pml0a/s55tiXIzwIhg5B/3ZmZ8Rjm7Q8AJr1Ph0E=;
        b=Rls0ouzVugFwzNWXpY12HCFXzICndtzy6WrL/Rh9casAJ2HEXh5ghTYd+VxpE0N/nR
         cnB6QOtdzLPQZgTkzn+kRMiKl4jAYZDXhfPUcnpvcfKGqpm6lFgWMDUPZVDMpyfBm608
         a75xMurVrZUWkm36pKjyhP5oHYHkYu/mlkBMrn+f8GLCnVGaJN12lD2ebAOcpo9AXKDe
         i7by8eK/0oAfq6qS6iEkyigBevzXbrBIwkdM51wAVhW1eisN9wLKB37J1oqrUDLzCF2z
         TgmTjFgslHRcLRcj4RxfzxRoMyHXRwHW6Nwm2Ic3dPQbocMXJHu8NTxGzrxkv7o8yySi
         xC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758473553; x=1759078353;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V76Pml0a/s55tiXIzwIhg5B/3ZmZ8Rjm7Q8AJr1Ph0E=;
        b=UcqVgRAxJC2ehpqJprt8ddotryqrwR+SiUji923PJWQQB6YhRL6alOIKLaTMA01BDU
         bX7foZ7XsOo3H4jOQlLSNhT3fLPs7KmXf2QIar+UrAdXufOchn/y7kXnB6xv6zTnzd+P
         2zdopJDGU0ZhMTa9n1Hl8IUsDv6YT0vhkjm5zXoO8QndzoANIIIop/f6zFMpMk0vb9aA
         pQ0VmS+WvQGeXxHgqc8O+lejukB4ENXkQtSTkgdKu8icMlmUwoccfZounuwtdFbdDVAz
         wRVOilald1IF1Ey3RmiWrBraF8IXaVfjAKsm8DZ5euCPx+8kHD8H3mEfBS5GT6riWLcw
         JynA==
X-Gm-Message-State: AOJu0YywuPYEDYnbwF/RVjZR/yxa9BzbajHOcX2ZFjALGaGeM5bjTQMP
	7hiRnQNOrEohm+pHPldNv58OLDLQgWpGzdNo6MrhSgZY8tkmREePJAKR0r2s/x+9g0TEEFBUk6h
	1jvWbnEixR34CuR/oYiKC1ozPwAyrdQFdoCBD
X-Gm-Gg: ASbGncv2aoxkG7eozyfgp5sxOMA5eymUBiP9WZ9Cn1smn6P//lS2jZB2p+m7Mv99A27
	VFUZxFS2JCYeiVezQ/HzsxNWDSArugnXvjKWR6SBcZAs5anzV7KAnnqZvdjoGVuIxBEVl7SLOOW
	axJpHr8Kh6R9n9QPkm8NT8A9tL8/fCQojZqkH8KKfAmX1HS18l0KOFg+PaqNi0skG1lLykx7vdu
	3AYKic=
X-Google-Smtp-Source: AGHT+IEeFqXgXg7CBDbYnaxL+pHVuCu19fKb2xwu6AaI3zaT5AcdlfnuUETtcOKkiNNfjL2auKotRxa87AEeMOWs+XE=
X-Received: by 2002:a05:690c:84:b0:71b:f632:54a7 with SMTP id
 00721157ae682-73d1f5a880amr91427287b3.4.1758473553403; Sun, 21 Sep 2025
 09:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820193016.7987-1-bruno.thomsen@gmail.com> <2025091422353715503104@mail.local>
In-Reply-To: <2025091422353715503104@mail.local>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Sun, 21 Sep 2025 18:52:17 +0200
X-Gm-Features: AS18NWAxh2ehGUOT4feU_VxVndmMvJ81Notj3EVQ1L-Ze3ldMeuiVohdPHw9sYA
Message-ID: <CAH+2xPDx2R17zv_FbUx8+vWbshqHV9Z89yJP-1HchB=HiNWqgQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: pcf2127: fix SPI command byte for PCF2131 backport
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

I have not tried to report issues with stable branches before,
so my email did reach you[1]. A backported rtc fix was applied
incorrectly to linux-6.12.y and linux-6.6.y. Patch message
got both incorrect backport commits.

/Bruno

[1] https://lore.kernel.org/stable/20250820193016.7987-1-bruno.thomsen@gmail.com/

Den man. 15. sep. 2025 kl. 00.35 skrev Alexandre Belloni
<alexandre.belloni@bootlin.com>:
>
> Hello Bruno,
>
> I guess you'd have to send this directly to stable and gkh so he wll
> notice it.
>
> On 20/08/2025 21:30:16+0200, Bruno Thomsen wrote:
> > When commit fa78e9b606a472495ef5b6b3d8b45c37f7727f9d upstream was
> > backported to LTS branches linux-6.12.y and linux-6.6.y, the SPI regmap
> > config fix got applied to the I2C regmap config. Most likely due to a new
> > RTC get/set parm feature introduced in 6.14 causing regmap config sections
> > in the buttom of the driver to move. LTS branch linux-6.1.y and earlier
> > does not have PCF2131 device support.
> >
> > Issue can be seen in buttom of this diff in stable/linux.git tree:
> > git diff master..linux-6.12.y -- drivers/rtc/rtc-pcf2127.c
> >
> > Fixes: ee61aec8529e ("rtc: pcf2127: fix SPI command byte for PCF2131")
> > Fixes: 5cdd1f73401d ("rtc: pcf2127: fix SPI command byte for PCF2131")
> > Cc: stable@vger.kernel.org
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Elena Popa <elena.popa@nxp.com>
> > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index fc079b9dcf71..502571f0c203 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -1383,11 +1383,6 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
> >               variant = &pcf21xx_cfg[type];
> >       }
> >
> > -     if (variant->type == PCF2131) {
> > -             config.read_flag_mask = 0x0;
> > -             config.write_flag_mask = 0x0;
> > -     }
> > -
> >       config.max_register = variant->max_register,
> >
> >       regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
> > @@ -1461,6 +1456,11 @@ static int pcf2127_spi_probe(struct spi_device *spi)
> >               variant = &pcf21xx_cfg[type];
> >       }
> >
> > +     if (variant->type == PCF2131) {
> > +             config.read_flag_mask = 0x0;
> > +             config.write_flag_mask = 0x0;
> > +     }
> > +
> >       config.max_register = variant->max_register;
> >
> >       regmap = devm_regmap_init_spi(spi, &config);
> >
> > base-commit: 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
> > --
> > 2.50.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

