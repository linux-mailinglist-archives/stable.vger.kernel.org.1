Return-Path: <stable+bounces-241873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IlnBAybw8WkOlwEAu9opvQ
	(envelope-from <stable+bounces-241873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF6493B76
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0B983025A5E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DE3A4538;
	Wed, 29 Apr 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vaWMHGd8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDF175A81;
	Wed, 29 Apr 2026 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463329; cv=none; b=fhPfvwVxt+baz4974YuY7GNTVNQj9R9rO2aTFgm1mTcG73OYrtkonZAkV9VjMgnlW/Oyi/f0sRnu9AAbUFt+HrUpZztPmXOfIiAZYbGWFmt5mH+WA022FYr3Gca/7Yy/RjPq9OEBjRvypk2f9LcnKEGHOWid/RCWXQHG9MW0+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463329; c=relaxed/simple;
	bh=APYJhzwnTuBda3ahLszGP6EC1lJwJVG8XTSiAQFO0PU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=GTWZS/TFQEDajr8cOiFDF2ZYH8/EuMJMUdsa/nc14rkNZ+qU7lVSzsgUrmtU0joLd8i7d6ET13bKroJiPKOIeixnkTcHPiIaac8EPdg5rocXYoKPG9LBc7L22w2x5huceWVg0TFWwxjfOx3d39HkJ9pgkff74OfNStxqJf7/qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vaWMHGd8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C5D4CC5EF22;
	Wed, 29 Apr 2026 11:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86C55601DF;
	Wed, 29 Apr 2026 11:48:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D9841072824E;
	Wed, 29 Apr 2026 13:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777463320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NAr1kMTIhIkt5U+a0cZfT48BHAuxADVaU25o4IUMDEE=;
	b=vaWMHGd8d6HTFYAWZnAqAgbuI9L921J9mPJZpVt1p+fgsMmjm5jEgzXIoWoCIPGfp4GbJu
	A0EQVyYkVyoBV+6wnSHqQko9IZ01AC39MmLoxQ+57ihBOhsZ6cKzrUhDzB/s6Zq87Xr9Og
	3wzR7ABdt6cjrdzrLvEajEzJ0D55xxuvW2C0sE8FbKSk6NKSgnmMJ2E1p03MSz6Sb7rTYE
	HAYxK4Xi7/D5Eyt9A9Z8FLBIho60EBrTWYY/ff940tLL1tlkIp2N8MNXWvelm2wKWm8Ss+
	whZfXSx+QO6vGGH6H6IQfl0V/s0ScZT8opgLyGQEmOkvDaHME/jf6W0KscAiPw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:48:33 +0200
Message-Id: <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Peter Senna Tschudin"
 <peter.senna@gmail.com>, "Ian Ray" <ian.ray@ge.com>, "Martyn Welch"
 <martyn.welch@collabora.co.uk>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Archit Taneja"
 <architt@codeaurora.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-3-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-3-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5FEF6493B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241873-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> bridge before returning.
>
> Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> tied to the STDP4028 device while ge_b850v3_register() may complete from
> either I2C probe; devm would not unwind the bridge if the other client's
> probe fails.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix br=
idge initialization")

That commit only moved the bug to a slightly different location. The bug
was present even before, since commit fcfa0ddc18ed ("drm/bridge: Drivers
for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)"), so you should update
your Fixes line to point to it.


> Cc: stable@vger.kernel.org
> ---
> v3: add Fixes and Cc tags
> v2: IRQ failure path only (explicit drm_bridge_remove)
> ---
>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/d=
rivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index c9e6505cbd88..2d02cc69f237 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
>  		goto out;
>
>  	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> -
>  	ge_b850v3_lvds_ptr =3D NULL;
>  out:
>  	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> @@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
>  {
>  	struct i2c_client *stdp4028_i2c =3D ge_b850v3_lvds_ptr->stdp4028_i2c;
>  	struct device *dev =3D &stdp4028_i2c->dev;
> +	int ret;
>
>  	/* drm bridge initialization */
>  	ge_b850v3_lvds_ptr->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
> @@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
>  	if (!stdp4028_i2c->irq)
>  		return 0;
>
> -	return devm_request_threaded_irq(&stdp4028_i2c->dev,
> -			stdp4028_i2c->irq, NULL,
> -			ge_b850v3_lvds_irq_handler,
> -			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> +	ret =3D devm_request_threaded_irq(&stdp4028_i2c->dev,
> +					stdp4028_i2c->irq, NULL,
> +					ge_b850v3_lvds_irq_handler,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> +	if (ret)
> +		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);

Why not just using devm_drm_bridge_add() and keep everything else clean, as
you did in other patches in the series?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

