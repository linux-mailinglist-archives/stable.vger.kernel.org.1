Return-Path: <stable+bounces-241870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEYkDEnu8WmulgEAu9opvQ
	(envelope-from <stable+bounces-241870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7A6493A3B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4B26302AF0F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146BE3F166E;
	Wed, 29 Apr 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MY4x65lp"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F537F746
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462852; cv=none; b=XG9vcGYDN6zHnAGREGLFEpzG0P9fKFDPRV1cKoNCTXvVMuNMRuDW5xA7CSYPLx+pWprDTyO8TVOlbrhO1mdx2TU7fzt6JjVAbEpd7AeAF9AkptSc0zMnVONM/iq2eNxLlzsmmx/po7i2nAzLWD0OZiylsd5APpMlfc6HerB4Pjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462852; c=relaxed/simple;
	bh=SOlTYRGPpHyRN69gm1xO3QQ3xSIzKfNcb5dULJf5RAg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tBuVi+GqFZyoyZLL4VAt426i59QOMM6y6g9GiQP0DCC2r31iYlEuA2Rpm9bAX6eSgCnBMzWj7vpxspp1p6P3iCnbfSx8GDX7l3QKskDzzPKEfbnyM9EHsXBFZTE6HOEJ8qnCg0D6j2UJa9qeAyLnVZvkRfRlklUfi/0Pcz78bMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MY4x65lp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0DCAEC5EF22;
	Wed, 29 Apr 2026 11:41:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC72A601DF;
	Wed, 29 Apr 2026 11:40:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9559010729C05;
	Wed, 29 Apr 2026 13:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777462844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Nxrz0cgWctqJlCSw2ayGmz8ggago1U3Xvv/tXD/4dxQ=;
	b=MY4x65lpEtQO4FmzwnmwaK27cI5ixpQraQfOx7BbrdQA+0SFxZzFiz+xOmT8YYQlvSiiQb
	/Qos3U/b4T7Fu+zkS4YpicDtIxa7cssuxTMqfoAoJNrp4znUVriG2qRz0mP/hrp+x1INmz
	Cn4M/FuuXYECa3v6OS29hHhhACezDVU3WuG0S+Oo3CLS1yqOCu4f26YzKk555dhCUBTVXL
	hclYXNOeLJipQT5Vd5zVBs16a+tmwAJlG23eu3MWdF3wHuaauyt/E8NqZYat3fChK9138D
	cmGiHzdoxHppe7DPlCoSSsSENUxGpwkAciM2FMlip2pYcs1i76x8dX03s/jxtA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:40:39 +0200
Message-Id: <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Marek Vasut"
 <marex@denx.de>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
X-Mailer: aerc 0.20.1
References: <20260423200546.324187-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200546.324187-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8E7A6493A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241870-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu Apr 23, 2026 at 10:05 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop drm_bridge_remove() in chipone_i2c_probe.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support=
")
> Cc: stable@vger.kernel.org
> ---
> v3: split the patch into two, one for i2c probe (bugfix) and one for dsi =
probe,
>     and add Fixes and Cc tags
> v2: devm_drm_bridge_add instead of drm_bridge_add
> ---
>
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> index 5bee10c64265..4d76e1bd5e78 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *cli=
ent)
>  	dev_set_drvdata(dev, icn);
>  	i2c_set_clientdata(client, icn);
>
> -	drm_bridge_add(&icn->bridge);
> -
> -	ret =3D chipone_dsi_host_attach(icn);
> +	ret =3D devm_drm_bridge_add(dev, &icn->bridge);
>  	if (ret)
> -		drm_bridge_remove(&icn->bridge);
> -	return ret;
> +		return ret;
> +
> +	return chipone_dsi_host_attach(icn);
> +
>  }
>
>  static void chipone_dsi_remove(struct mipi_dsi_device *dsi)

This patch does not apply. Is it messed up with patch 2/2?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

