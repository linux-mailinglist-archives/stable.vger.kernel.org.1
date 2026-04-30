Return-Path: <stable+bounces-242049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA6GE4gO82nywwEAu9opvQ
	(envelope-from <stable+bounces-242049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:10:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C049F145
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B5930214E9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A03FB7C1;
	Thu, 30 Apr 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fwNzz+Na"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AF39BFF8
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536639; cv=none; b=H7lC5nOTiRm0JRaRq6G4EoXWjQVtsbjvJuWk7X0moYWRS7o946ZqsD5PlXQZa2G2kBNbS6jcoCKsPGaIIjxpWW1Cjgf/g+UO9vJG5gXZhvsurnfkYnkYtIrhiuraDoN1j8YhbiGxXhcjfE0kNt+OulB4udT3qxQwD/xH8DCurs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536639; c=relaxed/simple;
	bh=JRFm17Wq30t/hsV74w8ufye5HTxnPS70PRqVcBEiMHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dTE5pUmjixWLzmn8fy2iO5UXDaeD5GyD4whmUWa7zKlPVGFRoiPSvn3z0YYFvACpXVLjRnAgL7luV30VwCThDQTff+e66pxXnNt0fHKf0dEbGlFf2wBzT0b1FNBRMfezIwxuHaf9yBdubkDrhmQPVI+lZUfcw9x+i/J8f1OMYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fwNzz+Na; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 439F3C5EF3A;
	Thu, 30 Apr 2026 08:11:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC82760495;
	Thu, 30 Apr 2026 08:10:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17DA91072B755;
	Thu, 30 Apr 2026 10:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777536634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dnqNnTF0DYaAxbSZWlFQjgF0Ulm0iKJS5gN4T0zzOZ8=;
	b=fwNzz+Nahzd38yd2W8yYXV3nQsiEuOlIsLSQuH5OhRM1zDbACIAU/uKtL012G9uEA2HkmS
	nB3OykRQmJIxe0b9U7rd8nFEVcqvZbj7i7PEncC8dtmG0AnoyXJ+ZZWxuh39kFr8+bAdEt
	oUumRVDNKQoPOxcGlC6PGhC7FIEa2dzQ9cGl6bFnVG8F/weTPUqAl+XJUwskomgQ34DPWh
	lTB9JC/oGYDeGhyLBwuRd1o6tA7d/5sVC7VkpxCakZZHfBDi9atmyXLyyq+KtiUfnzG5so
	Cb/C0zlhjp8UankqPtmDYFWIOYJkkgrJBVDkkPo3sz3dyCIxqUUhzmIPQJcTLg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 10:10:29 +0200
Message-Id: <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Cc: "Vitor Soares" <vitor.soares@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
To: "Vitor Soares" <ivitro@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260407144142.1420354-2-ivitro@gmail.com>
In-Reply-To: <20260407144142.1420354-2-ivitro@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9A7C049F145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242049-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,bootlin.com:dkim,bootlin.com:mid]

On Tue Apr 7, 2026 at 4:41 PM CEST, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>
> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> for both runtime PM and system sleep. This causes the DSI clocks to be
> disabled twice: once during runtime suspend and again during system
> suspend, resulting in a WARN message from the clock framework when
> attempting to disable already-disabled clocks.
>
> [   84.384540] clk:231:5 already disabled
> [   84.388314] WARNING: CPU: 2 PID: 531 at /drivers/clk/clk.c:1181 clk_co=
re_disable+0xa4/0xac
> ...
> [   84.579183] Call trace:
> [   84.581624]  clk_core_disable+0xa4/0xac
> [   84.585457]  clk_disable+0x30/0x4c
> [   84.588857]  cdns_dsi_suspend+0x20/0x58 [cdns_dsi]
> [   84.593651]  pm_generic_suspend+0x2c/0x44
> [   84.597661]  ti_sci_pd_suspend+0xbc/0x15c
> [   84.601670]  dpm_run_callback+0x8c/0x14c
> [   84.605588]  __device_suspend+0x1a0/0x56c
> [   84.609594]  dpm_suspend+0x17c/0x21c
> [   84.613165]  dpm_suspend_start+0xa0/0xa8
> [   84.617083]  suspend_devices_and_enter+0x12c/0x634
> [   84.621872]  pm_suspend+0x1fc/0x368
>
> To address this issue, replace UNIVERSAL_DEV_PM_OPS() with
> SET_RUNTIME_PM_OPS(), enabling suspend/resume handling through the

This is not what the patch does, the patch uses RUNTIME_PM_OPS.

> _enable()/_disable() hooks managed by the DRM framework for both
> runtime and system-wide PM.
>
> Cc: stable@vger.kernel.org # 6.1.x
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
> v3 -> v4
>  - Add Reviewed-by from Tomi Valkeinen
>  - Rebase on top of drm-misc-fixes
>  - Verified issue still present on current mainline
>
> v2 -> v3
>  - Fix warning: 'cdns_dsi_suspend' defined but not used [-Wunused-functio=
n]
>  - Fix warning: 'cdns_dsi_resume' defined but not used [-Wunused-function=
]
>
> v1 -> v2
>  - Rely only on SET_RUNTIME_PM_OPS() for the PM.
>
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu=
/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248c..e07a9892df4e 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1230,7 +1230,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops =
=3D {
>  	.transfer =3D cdns_dsi_transfer,
>  };
>
> -static int __maybe_unused cdns_dsi_resume(struct device *dev)
> +static int cdns_dsi_resume(struct device *dev)
>  {
>  	struct cdns_dsi *dsi =3D dev_get_drvdata(dev);
>
> @@ -1241,7 +1241,7 @@ static int __maybe_unused cdns_dsi_resume(struct de=
vice *dev)
>  	return 0;
>  }
>
> -static int __maybe_unused cdns_dsi_suspend(struct device *dev)
> +static int cdns_dsi_suspend(struct device *dev)
>  {
>  	struct cdns_dsi *dsi =3D dev_get_drvdata(dev);
>
> @@ -1251,8 +1251,9 @@ static int __maybe_unused cdns_dsi_suspend(struct d=
evice *dev)
>  	return 0;
>  }
>
> -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend, cdns_dsi_=
resume,
> -			    NULL);
> +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
> +	RUNTIME_PM_OPS(cdns_dsi_suspend, cdns_dsi_resume, NULL)
> +};

Not an expert here, but the docs [0] suggest using
DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?

[0] https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-=
L456

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

