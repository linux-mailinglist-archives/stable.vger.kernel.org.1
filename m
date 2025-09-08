Return-Path: <stable+bounces-178940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C95B4965D
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395B03A80AB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04193112DC;
	Mon,  8 Sep 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNt+E1dW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2D310627;
	Mon,  8 Sep 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350815; cv=none; b=g4iZU5OeDGKWiIeZi31F9S75Vt67ViBR80dKcIJ/pntv4QHYx/IrjjDXQU0+GYy/+Jp+jRFoGYDSfSimWDktbrE9ud7XyDsbQndmtt9t0WcNTvZ4W8C2ZDXdIO5ZZh6NB4zUTUL4gb8eF8hQuEhdEZJwx1haEN45Lu/t8TvuHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350815; c=relaxed/simple;
	bh=1N64bH3b43jKHEjm1ERiCLof6Xm/ogyasaqIE6RbAsc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=cgv1uPrBu6ex9lgBsdol/wOZtj/+ltFvw6apSLbNENSAENCrAWjL1RPIyFvSP/w5YlhHYKalL45sOy8SxNqt80rItiNDmGihbwdqFdmXB8ia3cC73fgmb2/Q1LQEmOFbt4pz/HnOMpKJpniZJU70IvcMWc3xNwR75MKPVumH+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNt+E1dW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b00a9989633so10703166b.0;
        Mon, 08 Sep 2025 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757350812; x=1757955612; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1RqPUOPY5J9QIjuhdTE6tslfrB+50GwLjc8x6yrTpI=;
        b=KNt+E1dWPLWBc2hyFLq3jPql34mwG4D6I9Vhg/ioWwMjsx4ikkhKYS/BdLnwUdjjWu
         0UawYMXQLOL/rkzqFYK432IlLg5VHE20c/HiM8IFWy6N61K6sUMZH/N+CPwK5SwanMm7
         Gi3xMkLkrJ1M0lwp71B/scNivM1VGXji6K4iQRk2ULipie0eQ56HM5koRoCa/xT+Hm3G
         2JNUsUXgM4RjMAQBY3zcC8I/ZhTDLMkVLa/fjynIfHyt0hmqgdQALN25+SCityzGI6xR
         OuPxlUphTVmYhP8mETvYLJjQLIkZ9IiWlKbFfLOyX8YdLlVrsLhXVOwVhWGsrzvrkpAs
         mRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350812; x=1757955612;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1RqPUOPY5J9QIjuhdTE6tslfrB+50GwLjc8x6yrTpI=;
        b=hTdSfGRPRO4rP5tCgLC2qe1jHB2s/g0sL1mw+F4WRZ0m4nStFIYcR4xJuN3Nqdr19o
         iMqG4rzAUgzfbew0vF0wquIQoxfgyR6uCQ12yetbNfvmekMNwml+ySs/pfuUq3mj3Azj
         9WudsVhoMemX0Ho8z+KBjGxUu3G896Dx0QqAQTd6pQ1ekbpgPgC4WRPVk9Lwj682zxhk
         yX2OdKwOyG7KPkg7MYSv848d7U8PKmsmlBTVzM+km609ki9fPXTQ50szJHl7faxKuER/
         1s5O990hRUf0IbChoThyKqlx+5ReWviOCSFRgely9vVbm/2gZTGy+7a4l+CeHB+Tju6b
         L7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSg3DHKZ4pVmHW0lTVPWwxJCKG+faSd95jVdATN44hX71xQuXvaHo6CalKzHybZm6E8u5o+C/M@vger.kernel.org, AJvYcCXJt1X0Yc2IjcW9GTUd1ywmfnkkoufHaJ1AOs6u7ePScH0Sm+RD+r25QxG3ZfactqqxgC5xQ+OK9YGf@vger.kernel.org, AJvYcCXxMi9U3xHFazA81JS+DYC/CjMYXkv4JG6ERGWDoSHW4Lr9tISZSVCfyS5/Cgd9gde3pQ/sP1UdBVLKyWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGnoYppG8hWR5N/r1yu3jIEnhjCEYa3eSxf4xL6e8pp3kKZEK
	lyFnYuOGbBOTXCutbteDYSvX0XroMydMbXYQaIXPjLtLsTKxUYOScaUy
X-Gm-Gg: ASbGncvKeNWUEaHXyt8772Vz965F4sArMMrWwZEAHy+iXpFiGjehpJ/rXJbBC38zjjy
	zQARg01QYum3U3pkXrpskTu0tbpm3YP8abIMn3dAaf6qF2pNNgnb3fksQiI8/7Rv8c1FH1q8egb
	HkoUR4D2cZpnfmmuHPBY6Gii34y6I4HjbUrQooK6VHqQWM8lpCmO7HLyvQw2LqBKic6ZcDTWKbg
	AAhBQffXHRFpsHSB9xKv9TMUU1PW8kgal3u0oMP3PgPMXg2d2/gXdBh+YPlmN5VgDRnOZSjaYHb
	lQZ2jc8pYUGVJ2qF2HmbhV/8aoeTD6kfuX9r04RSl2+MbFm58YWt9ONL+ZX3drvmhn81AAslYG7
	KH4Hi0dBg2aXYqGjPXB/l0saJhzM64kZMJG6/3qoBhAXO/XKNUq9I4RLDbTNS3Oerha+4lgwyXc
	DDkg==
X-Google-Smtp-Source: AGHT+IE131z6tQ41WLKn+jD529arClXzca03Khm11X9NDfpiL1KYxv451bPCyM5lSWFBtsG4tifgRw==
X-Received: by 2002:a17:906:7954:b0:b04:1d85:7106 with SMTP id a640c23a62f3a-b04931f4b3bmr1218242466b.21.1757350811609;
        Mon, 08 Sep 2025 10:00:11 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04a87dfb42sm727572266b.106.2025.09.08.10.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:00:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 19:00:09 +0200
Message-Id: <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
Cc: <stable@vger.kernel.org>, <kernel@pengutronix.de>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "Lukas Wunner"
 <lukas@wunner.de>, "Russell King" <linux@armlinux.org.uk>, "Xu Yang"
 <xu.yang_2@nxp.com>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.0
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
In-Reply-To: <20250908112619.2900723-1-o.rempel@pengutronix.de>

On Mon Sep 8, 2025 at 1:26 PM CEST, Oleksij Rempel wrote:
> Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
>
> MDIO bus accesses have their own runtime-PM handling and will try to
> wake the device if it is suspended. Such wake attempts must not happen
> from PM callbacks while the device PM lock is held. Since phylink
> {sus|re}sume may trigger MDIO, it must not be called in PM context.
>
> No extra phylink PM handling is required for this driver:
> - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> - ethtool/phylib entry points run in process context, not PM.
> - phylink MAC ops program the MAC on link changes after resume.

Thanks for the patch! Applied to v6.17-rc5, it fixes the problem for me.

Tested-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

> Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")

It does, but v5.15 (including v5.15.191 LTS) is affected as well, from
4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC"). I think
it could also use a patch, but I won't insist.

> Reported-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/asix_devices.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_device=
s.c
> index 792ddda1ad49..1e8f7089f5e8 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -607,15 +607,8 @@ static const struct net_device_ops ax88772_netdev_op=
s =3D {
>
>  static void ax88772_suspend(struct usbnet *dev)
>  {
> -	struct asix_common_private *priv =3D dev->driver_priv;
>  	u16 medium;
>
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_suspend(priv->phylink, false);
> -		rtnl_unlock();
> -	}
> -
>  	/* Stop MAC operation */
>  	medium =3D asix_read_medium_status(dev, 1);
>  	medium &=3D ~AX_MEDIUM_RE;
> @@ -644,12 +637,6 @@ static void ax88772_resume(struct usbnet *dev)
>  	for (i =3D 0; i < 3; i++)
>  		if (!priv->reset(dev, 1))
>  			break;
> -
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_resume(priv->phylink);
> -		rtnl_unlock();
> -	}
>  }
>
>  static int asix_resume(struct usb_interface *intf)
> --
> 2.47.3

