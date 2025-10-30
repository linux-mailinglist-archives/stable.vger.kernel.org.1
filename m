Return-Path: <stable+bounces-191747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE350C20ECB
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC830401EC9
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287033F8AC;
	Thu, 30 Oct 2025 15:27:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E4363B89
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838078; cv=none; b=VLJYYmO93Wm2Gp3antK/QqKWIqLiblOZlPs/VcSa3TYBW/CWKmrVf17MxsDTReq1skSdh4B1tjz5EWOPCwdPFFWTaoYvpEyNDDY9FysgbumDFo3WBFzSNo53XGZj5hQWul3/ghjhpHbKBY9o5yfWunLFAV3ic/btc6aBr2tg8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838078; c=relaxed/simple;
	bh=GT2Lq+KlvSytGbVIHrVL2N4Yu7XFn08ip7bAfD/9eFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFMUF1auAsPSHrAewYCpdSBpEjskJjGnUI9/kJrsKw/XjQ1ctQou3FBl4ztzkfkrEt6qM7stg4nA3Ndx456zKY8SEXHECkPkLK7ru0YTsHHcSfqxsgyIl/OTiYia+sZnWRUDYGEc555A1yeCok1wFavRqs91pAFRDeTFQXN17FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEUYu-0000uH-HI; Thu, 30 Oct 2025 16:27:40 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEUYt-006EZI-2R;
	Thu, 30 Oct 2025 16:27:39 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEUYt-00000000CkU-2pWz;
	Thu, 30 Oct 2025 16:27:39 +0100
Message-ID: <89a86fc1c48f921aa3b06146f43a32dc58515548.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx/tve: fix probe device leak
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 30 Oct 2025 16:27:39 +0100
In-Reply-To: <20250923151346.17512-1-johan@kernel.org>
References: <20250923151346.17512-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Di, 2025-09-23 at 17:13 +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the DDC device during probe on
> probe failure (e.g. probe deferral) and on driver unbind.
>=20
> Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encode=
r (TVEv2)")
> Cc: stable@vger.kernel.org	# 3.10
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ip=
uv3/imx-tve.c
> index c5629e155d25..895413d26113 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> @@ -525,6 +525,13 @@ static const struct component_ops imx_tve_ops =3D {
>  	.bind	=3D imx_tve_bind,
>  };
> =20
> +static void imx_tve_put_device(void *_dev)
> +{
> +	struct device *dev =3D _dev;
> +
> +	put_device(dev);
> +}
> +
>  static int imx_tve_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -546,6 +553,11 @@ static int imx_tve_probe(struct platform_device *pde=
v)
>  	if (ddc_node) {
>  		tve->ddc =3D of_find_i2c_adapter_by_node(ddc_node);
>  		of_node_put(ddc_node);
> +
> +		ret =3D devm_add_action_or_reset(dev, imx_tve_put_device,
> +					       &tve->ddc->dev);

I think this needs to be wrapped in "if (tve->ddc) { }",
of_find_i2c_adapter_by_node() can return NULL.

regards
Philipp

