Return-Path: <stable+bounces-179826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21048B7CEE7
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8621B21FCB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CA30B526;
	Wed, 17 Sep 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP4/C49y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1A303A0B
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108389; cv=none; b=cpCQjtW9Cwza8rIpRgY7wooOLk0qDpOL4IRziGzbVfGXC6Mky20i90b/WPrFplzm8W5Wy751+6cDjLYhQLA5DF4PKkl4I76ytwqEAjFzaOcpZ1hZWEAUF85ln+VocT4NBGUZZvvMycPn2Z1r+WH9/+odO0CALBxI61W9HbqTS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108389; c=relaxed/simple;
	bh=ppa9xqtoGfGGmWZPvjGVyKSOFbJHHlCDfK1ROI9sSuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I+rgH9VlBSCoIm9qGnEIV/PX4ZBRN+CkzDhHUVs/YOJui3zwSSIKNqEf4XwzrrCKfwMPdRGXRmGlyN9dTSFMX/7YJSqeb+G90JUUZgZI0MYzcU/JIbNN1Y2S4H8jtyrBW16+DKiJ4oanuzXFiHhJdVGLuXmCdwwb0vRyehopRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP4/C49y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042eb09948so1316740366b.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758108386; x=1758713186; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgyP1skDDpJkVrmkkvIDINFO9MgyddQrfr7riBVEJpU=;
        b=eP4/C49yE/BRvaU3klF2lUBfV5xFx4nym6GMuSa3xR2rbLkwV85cKFvaf+GEJE+wjk
         dnAiIBZQWDdPFNqQ0O4XdKOQwIUZukP+HrIrz7rREM918n/XuMmKfcguv/mTJNhOX0U3
         sHmFjL+JOguJgshk1dRs+60vR/ZhMBaLJAN/abEFYUc1qG27uGk5v0Ne+szca+mlZjyP
         YKKzAZ313FhKoj29YoqhxLQmScpKSHgJ2O6RXBNMfAKS7r748BMaKje7priHMZy+gK/H
         s8p5qh7eJcVNqyBZ88mzCaX+7hIAUznTqUzdx0nJhbisdq4wPVUBGKXeR409g81HYVws
         q1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758108386; x=1758713186;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HgyP1skDDpJkVrmkkvIDINFO9MgyddQrfr7riBVEJpU=;
        b=NX8ICMCoBwKdYpCCk+JlH5MeqerJtmvnRPRl12SI5LJ4tXsFa3Y6pj8pOvx8PNc5zU
         +6CkbAsITKD2FjgOCmLyWwC8WYl6KW+GdPicpxTmjFnEjeVn3894LWSxOgLqAgFXfm1r
         +2xuzIVvaznJwL86+g/Scotee3e1j5Z0gdF16hvoEo9QymIC+90drEFeScLnNHncBZEj
         D2tIt/0N+PRcGBG+MMiqc7SPJp3WdpuQj1TOvS6GetkGxOu3AxEqxyi4Oqyv2RM0ASD+
         Tta/FWq/u01ApjIdFQjilh7uFJpzk5c43BXg1cw4OliXdZGQELwrW4ipbGBA2z7HgqBt
         XmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWxJIUObHx3ySLGJM5kzzg1pwMh0zCJrp0seyTaE7aHeRaMWMxbHzoYWMUtyXoIyIib/QefKWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznmu32FwZvRaEtlyk1kEhofeWzNQ300GY3G24C9eB4GO8rWXqH
	Yrukf8k0f12hB4h4smsxP9Y1m8ZTlck1IGDgg61om1YzQ/Rf20qR8fVS
X-Gm-Gg: ASbGncuJrcUm40Tvp7AALG6COloH98Tefwft1sRwDc0Luge5dxuZPOCI19yaNog1UbP
	GN2K0z/eVsSFYuZi2ZFqtyVH0ByU3oNr6/2uMpq3peOZFbr/+JLAuORYUnlzAbUbGPOzzlf/lAN
	xZEXrpm/zq7RTD9tZ2FLnKuyqK6histeuo5B2bnubbFuW5XlfTRidHdojNGFSVKHDYq2LHAJdQk
	/Z0YGyc+N3I/rBoE5W+aTx5qBmZZeEqk5GQQAjwOpfYEhE5lehS3PajMBCAu/hbX8Pn0RhaW4b+
	tua4kRtMAn3ZX7OB7u9Uqjq3gGZesy2GRArFTys+VvaWmj/RL0O3j51RVinX/DE5ZKajXrZMgpm
	9NLDelVF3uVMMYI5pS1OcHcGglxzR1YYBIUltviKOQSMSW4WvyLlKBSy9zUzckdFo0VY=
X-Google-Smtp-Source: AGHT+IFZoOXXk0BzdVxzupl6UXjj53Xlysq4bZMGAJDUG5f0y1MlvEMSvXFKvK4gq4mVVf9cuDDYRA==
X-Received: by 2002:a17:906:f592:b0:b0d:61a0:9a28 with SMTP id a640c23a62f3a-b1baf60b87cmr182559666b.6.1758108385868;
        Wed, 17 Sep 2025 04:26:25 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da388sm1340847766b.22.2025.09.17.04.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 04:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 13:26:23 +0200
Message-Id: <DCV1EPLCX5L5.3MWOCVTH5AWM4@gmail.com>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>, <stable@vger.kernel.org>,
 <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Russell King"
 <linux@armlinux.org.uk>, "Xu Yang" <xu.yang_2@nxp.com>,
 <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
X-Mailer: aerc 0.20.0
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>

On Wed Sep 17, 2025 at 11:54 AM CEST, Oleksij Rempel wrote:
> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
>
> usbnet enables runtime PM by default in probe, so disabling it via the
> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
> measurable power saving in my tests (no link partner, admin up/down).
> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
> the PHY off on admin-down, not from USB autosuspend.
>
> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.
>
> This affects only AX88772* devices (per-interface in bind). System
> sleep/resume is unchanged.
>
> Fixes: 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC")
> Reported-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
> Closes: https://lore.kernel.org/all/20220622141638.GE930160@montezuma.acc=
.umu.se
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@=
samsung.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Link to the measurement results:
> https://lore.kernel.org/all/aMkPMa650kfKfmF4@pengutronix.de/
> ---
>  drivers/net/usb/asix_devices.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_device=
s.c
> index 792ddda1ad49..0d341d7e6154 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -625,6 +625,22 @@ static void ax88772_suspend(struct usbnet *dev)
>  		   asix_read_medium_status(dev, 1));
>  }
> =20
> +/*
> + * Notes on PM callbacks and locking context:
> + *
> + * - asix_suspend()/asix_resume() are invoked for both runtime PM and
> + *   system-wide suspend/resume. For struct usb_driver the ->resume()
> + *   callback does not receive pm_message_t, so the resume type cannot
> + *   be distinguished here.
> + *
> + * - The MAC driver must hold RTNL when calling phylink interfaces such =
as
> + *   phylink_suspend()/resume(). Those calls will also perform MDIO I/O.
> + *
> + * - Taking RTNL and doing MDIO from a runtime-PM resume callback (while
> + *   the USB PM lock is held) is fragile. Since autosuspend brings no
> + *   measurable power saving for this device with current driver version=
, it is
> + *   disabled below.
> + */
>  static int asix_suspend(struct usb_interface *intf, pm_message_t message=
)
>  {
>  	struct usbnet *dev =3D usb_get_intfdata(intf);
> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct u=
sb_interface *intf)
>  	if (ret)
>  		goto initphy_err;
> =20
> +	/* Disable USB runtime PM (autosuspend) for this interface.
> +	 * Rationale:
> +	 * - No measurable power saving from autosuspend for this device.
> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
> +	 *   held, USB PM lock held).
> +	 * System suspend/resume is unaffected.
> +	 */
> +	pm_runtime_forbid(&intf->dev);
> +
>  	return 0;
> =20
>  initphy_err:
> @@ -948,6 +974,10 @@ static void ax88772_unbind(struct usbnet *dev, struc=
t usb_interface *intf)
>  	phylink_destroy(priv->phylink);
>  	ax88772_mdio_unregister(priv);
>  	asix_rx_fixup_common_free(dev->driver_priv);
> +	/* Re-allow runtime PM on disconnect for tidiness. The interface
> +	 * goes away anyway, but this balances forbid for debug sanity.
> +	 */
> +	pm_runtime_allow(&intf->dev);
>  }
> =20
>  static void ax88178_unbind(struct usbnet *dev, struct usb_interface *int=
f)
> @@ -1600,6 +1630,10 @@ static struct usb_driver asix_driver =3D {
>  	.resume =3D	asix_resume,
>  	.reset_resume =3D	asix_resume,
>  	.disconnect =3D	usbnet_disconnect,
> +	/* usbnet will force supports_autosuspend=3D1; we explicitly forbid RPM
> +	 * per-interface in bind to keep autosuspend disabled for this driver
> +	 * by using pm_runtime_forbid().
> +	 */
>  	.supports_autosuspend =3D 1,
>  	.disable_hub_initiated_lpm =3D 1,
>  };

Well, this fixes the issue for me. No suspend/resume -- no deadlock -- no
problem. Thanks.

Tested-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

