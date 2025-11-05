Return-Path: <stable+bounces-192521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB8C36719
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B28A567A3B
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956582FCC02;
	Wed,  5 Nov 2025 15:34:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA967262FD3
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356848; cv=none; b=gtZU7smviPlYy0b7XW+RLgTNC5UvCg21l0Dd4uv+OoF8Ye7vj6Rqbjk2FFJPixIFqWaDPFobPnvQai5BgEEOOTITKjMYAaYeF1JZHpWlZSYt97A6RP+PM7J+YRIHhmHsVLmCqy2VAhh+KumODy7XnREqJqJTSXcEddl/8wEBjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356848; c=relaxed/simple;
	bh=5E+JnmRJxKFbZjtKlkibE/W4om0Z6FVCgs6dlKMkkAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agK8wPfYqnJOvGgiyuiGGhg7ILdSbKrWnVGMQ6+xHy21zgPIzQi7zYQ3LvVNUXYVmF1Dg43DhfXGHhf56XVrzv3BBR10dl8x8210BsSwtAUsjtfE0f0mSgLlCjz0m10qhykYYfJeNVezteai0q2HgBYgV2cj13iQ+Va9TWJEeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfWG-0004ZV-Fp; Wed, 05 Nov 2025 16:33:56 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfWG-007DdL-0W;
	Wed, 05 Nov 2025 16:33:56 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfWG-00000000By3-0HJ8;
	Wed, 05 Nov 2025 16:33:56 +0100
Message-ID: <18cf6a292f8e3335092b39249712569d46327a5b.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] media: staging: imx: configure src_mux in csi_start
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>, Steve Longerbeam
	 <slongerbeam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team
	 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Hans Verkuil
	 <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Michael
 Tretter	 <michael.tretter@pengutronix.de>
Date: Wed, 05 Nov 2025 16:33:55 +0100
In-Reply-To: <20251105-media-imx-fixes-v1-2-99e48b4f5cbc@pengutronix.de>
References: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
	 <20251105-media-imx-fixes-v1-2-99e48b4f5cbc@pengutronix.de>
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

On Mi, 2025-11-05 at 16:18 +0100, Michael Tretter wrote:
> After media_pipeline_start() was called, the media graph is assumed to
> be validated. It won't be validated again if a second stream starts.
>=20
> The imx-media-csi driver, however, changes hardware configuration in the
> link_validate() callback. This can result in started streams with
> misconfigured hardware.
>=20
> In the concrete example, the ipu2_csi1_mux is driven by a parallel video
> input. After the media pipeline has been started with this
> configuration, a second stream is configured to use ipu1_csi0 with
> MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
> of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
> already running, link_validate won't be called, and the ipu1_csi0 won't
> be reconfigured. The resulting video is broken, because the
> ipu1_csi0_mux is misconfigured, but no error is reported.
  ^^^^^^^^^^^^^
   ipu1_csi0 ?

> Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
> that input to ipu1_csi0 is configured correctly when starting the
> stream. This is a local reconfiguration in ipu1_csi0 and is possible
> while the media pipeline is running.
>=20
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 44 +++++++++++++++++--------=
------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/=
media/imx/imx-media-csi.c
> index 55a7d8f38465..1bc644f73a9d 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -744,6 +744,28 @@ static int csi_setup(struct csi_priv *priv,
>  	return 0;
>  }
> =20
> +static void csi_set_src(struct csi_priv *priv,
> +			struct v4l2_mbus_config *mbus_cfg)
> +{
> +	bool is_csi2;
> +
> +	is_csi2 =3D !is_parallel_bus(mbus_cfg);
> +	if (is_csi2) {
> +		/*
> +		 * NOTE! It seems the virtual channels from the mipi csi-2
> +		 * receiver are used only for routing by the video mux's,
> +		 * or for hard-wired routing to the CSI's. Once the stream
> +		 * enters the CSI's however, they are treated internally
> +		 * in the IPU as virtual channel 0.
> +		 */
> +		ipu_csi_set_mipi_datatype(priv->csi, 0,
> +					  &priv->format_mbus[CSI_SINK_PAD]);
> +	}
> +
> +	/* select either parallel or MIPI-CSI2 as input to CSI */
> +	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
> +}
> +
>  static int csi_start(struct csi_priv *priv)
>  {
>  	struct v4l2_mbus_config mbus_cfg =3D { .type =3D 0 };
> @@ -760,6 +782,8 @@ static int csi_start(struct csi_priv *priv)
>  	input_fi =3D &priv->frame_interval[CSI_SINK_PAD];
>  	output_fi =3D &priv->frame_interval[priv->active_output_pad];
> =20
> +	csi_set_src(priv, &mbus_cfg);
> +
>  	/* start upstream */
>  	ret =3D v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
>  	ret =3D (ret && ret !=3D -ENOIOCTLCMD) ? ret : 0;
> @@ -1130,7 +1154,6 @@ static int csi_link_validate(struct v4l2_subdev *sd=
,
>  {
>  	struct csi_priv *priv =3D v4l2_get_subdevdata(sd);
>  	struct v4l2_mbus_config mbus_cfg =3D { .type =3D 0 };
> -	bool is_csi2;
>  	int ret;
> =20
>  	ret =3D v4l2_subdev_link_validate_default(sd, link,
> @@ -1145,25 +1168,6 @@ static int csi_link_validate(struct v4l2_subdev *s=
d,
>  		return ret;
>  	}
> =20
> -	mutex_lock(&priv->lock);

This warrants a comment in the patch description: csi_start() is called
with priv->lock already locked.


regards
Philipp

