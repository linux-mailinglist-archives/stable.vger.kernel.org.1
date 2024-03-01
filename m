Return-Path: <stable+bounces-25727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C386DEF8
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 11:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F08288C8D
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912469D28;
	Fri,  1 Mar 2024 10:08:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF9482C1
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287734; cv=none; b=uEvGfzZ3y2cUDIhexX6w5Is3JRu4RezG99kh5QvuweFnh4B1vbafEEgvJgtPfKIzxpdjbSYI6YPSNI0QSSp9K9Al9GOmv6OvOV+R8XugMvxiHNkwJlyvqSZyyvS3eGbm4ymOi8HNiMczB2Dh+WoeypyoH4z7xPaSjJhPqdTOzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287734; c=relaxed/simple;
	bh=cfhI4adbzcjp8NkNHtD4wblqg/sRFVZlM616n37Agb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpL5eKdJyHfW0dBCItF5fWMXp0HcUOpoJw2sHBmN0Iw3PnHlpD+8AMFhYUD+4ZXE8txp96P0vI1vDOpiSat60YbCH4/kysBEYN5wTy/iBPtZWWE9jjf+x3eK1Q8OpbBSfAFCzMuevj4YE/RZoGzN2L1vxOpdS2E6HRF7Az7SEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rfzou-00053s-Tf; Fri, 01 Mar 2024 11:08:48 +0100
Message-ID: <2d65be7ae251221bd7524871e0cbf4b22d16a9f9.camel@pengutronix.de>
Subject: Re: [PATCH] etnaviv: Restore some id values
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Daniel
	Vetter <daniel@ffwll.ch>
Cc: Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 01 Mar 2024 11:08:48 +0100
In-Reply-To: <20240229195532.7815-1-christian.gmeiner@gmail.com>
References: <20240229195532.7815-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Christian,

prefix for etnaviv kernel patches should be "drm/etnaviv: ..."

Am Donnerstag, dem 29.02.2024 um 20:55 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> The hwdb selection logic as a feature that allows it to mark some fields
> as 'don't care'. If we match with such a field we memcpy(..)
> the current etnaviv_chip_identity into ident.
>=20
> This step can overwrite some id values read from the GPU with the
> 'don't care' value.
>=20
> Fix this issue by restoring the affected values after the memcpy(..).
>=20
> As this is crucial for user space to know when this feature works as
> expected increment the minor version too.

Uh, right. Lying to userspace about the GPU identity doesn't seem like
a good idea.

>=20
> Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c  |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6228ce603248..9a2965741dab 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver =3D=
 {
>  	.desc               =3D "etnaviv DRM",
>  	.date               =3D "20151214",
>  	.major              =3D 1,
> -	.minor              =3D 3,
> +	.minor              =3D 4,
>  };
> =20
>  /*
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etn=
aviv/etnaviv_hwdb.c
> index 67201242438b..1e38d66702f1 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chi=
p_identities[] =3D {
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
>  {
>  	struct etnaviv_chip_identity *ident =3D &gpu->identity;
> +	const u32 product_id =3D ident->product_id;
> +	const u32 customer_id =3D ident->customer_id;
> +	const u32 eco_id =3D ident->eco_id;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
> @@ -278,6 +281,17 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_=
gpu *gpu)
>  			 etnaviv_chip_identities[i].eco_id =3D=3D ~0U)) {
>  			memcpy(ident, &etnaviv_chip_identities[i],
>  			       sizeof(*ident));
> +
> +			/* Restore some id values if ~0U aka 'don't care' is used. */
> +			if (etnaviv_chip_identities[i].product_id =3D=3D ~0U)

You can drop all those if clauses. Either the hwdb value is an exact
match and the value is the same or it's the don't care value and you
want to restore it, so a simple unconditional assignment would make
this a bit more compact.

Regards,
Lucas

> +				ident->product_id =3D product_id;
> +
> +			if (etnaviv_chip_identities[i].customer_id =3D=3D ~0U)
> +				ident->customer_id =3D customer_id;
> +
> +			if (etnaviv_chip_identities[i].eco_id =3D=3D ~0U)
> +				ident->eco_id =3D eco_id;
> +
>  			return true;
>  		}
>  	}


