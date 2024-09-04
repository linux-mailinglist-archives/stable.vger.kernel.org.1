Return-Path: <stable+bounces-72974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504696B493
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0451828BDC2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0F1CB146;
	Wed,  4 Sep 2024 08:32:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E41CB138
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438725; cv=none; b=R7sm/UBAnb/QtovxgdhFs4WY27JWUYcwKePDf24lNiX9mrg5bAFE8Drr07iZqVjNmmD+DsBwXeehLCvuvyJuvMXo7dQWlSFO4oslsb6cRneet3iGt96dAC0zAur0kRxIz3upGcHZ9kOeuOJ9cVDhMyWbYP9HneFPORgIREVfIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438725; c=relaxed/simple;
	bh=4aMAve0M2n058JwdXgPFrejCW9/HhTRA7Mndvu5FIn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3K/byQO1AztowDI5ktUigC8b64WHLAJCsv+J+oOT5HsCfk7IAbGglk/yU3bqYZwJfJkAXa47If7K9tt9mGWNZCUBlMMq0ODRqVyCZbxslB3ZqrWfQzs7SUre8iXaqIJRcQVnXdqvSrulgaCewaOoy5Zj6Uh/FVxdXBNmKSkDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllQX-0008Au-5Q; Wed, 04 Sep 2024 10:31:45 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllQV-005PKS-T7; Wed, 04 Sep 2024 10:31:43 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sllQV-0004ZM-2b;
	Wed, 04 Sep 2024 10:31:43 +0200
Message-ID: <095a4f602ebf408a90070d6ac0bea1f187420948.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/imx/ipuv3: ipuv3-plane: Round up plane width for
 IPUV3_CHANNEL_MEM_DC_SYNC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Paul Pu <hui.pu@gehealthcare.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach
 <l.stach@pengutronix.de>
Cc: HuanWang@gehealthcare.com, taowang@gehealthcare.com, 
 sebastian.reichel@collabora.com, ian.ray@gehealthcare.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 10:31:43 +0200
In-Reply-To: <20240904075417.53-1-hui.pu@gehealthcare.com>
References: <20240904024315.120-1-hui.pu@gehealthcare.com>
	 <20240904075417.53-1-hui.pu@gehealthcare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mi, 2024-09-04 at 10:54 +0300, Paul Pu wrote:
> This changes the judgement of if needing to round up the width or not,
> from using the `dp_flow` to the plane's type.
>=20
> The `dp_flow` can be -22(-EINVAL) even if the plane is a PRIMARY one.
> See `client_reg[]` in `ipu-common.c`.
>=20
> [    0.605141] [drm:ipu_plane_init] channel 28, dp flow -22, possible_crt=
cs=3D0x0
>=20
> Per the commit message in commit: 4333472f8d7b, using the plane type for
> judging if rounding up is needed is correct.
>=20
> This fixes HDMI cannot work for odd screen resolutions, e.g. 1366x768.
>=20
> Fixes: 4333472f8d7b ("drm/imx: ipuv3-plane: Fix overlay plane width")
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Paul Pu <hui.pu@gehealthcare.com>
> ---
> v1 -> v2: Fixed addressed review comments
> ---
>  drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/im=
x/ipuv3/ipuv3-plane.c
> index 704c549750f9..3ef8ad7ab2a1 100644
> --- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> +++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> @@ -614,7 +614,7 @@ static void ipu_plane_atomic_update(struct drm_plane =
*plane,
>  		break;
>  	}
> =20
> -	if (ipu_plane->dp_flow =3D=3D IPU_DP_FLOW_SYNC_BG)
> +	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY)
>  		width =3D ipu_src_rect_width(new_state);
>  	else
>  		width =3D drm_rect_width(&new_state->src) >> 16;
>=20
> base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

