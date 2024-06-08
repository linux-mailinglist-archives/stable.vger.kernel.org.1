Return-Path: <stable+bounces-50030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE434901227
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB46281C19
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D995143891;
	Sat,  8 Jun 2024 14:50:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88D2557A;
	Sat,  8 Jun 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717858214; cv=none; b=scrNWM3W8Q1aL44esjYwgO5TplHuomtBHTce53rQFhcJU7EWAckbQFlFS7PNBkCC3VoklmtHuu6IG1uLNJZld7STXO6BEPVrS7c6Ydxq5k+NrGKge0tHK2sfj637JP7C0o3h/yUZwdDL673KoBSGbxAS0CIjVtxdSlx1ZmmEo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717858214; c=relaxed/simple;
	bh=gZ/+8nQSV1aK+OQQ8dc0w8T7Yf+mPiYoo+5hUXsRFpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Do7aNNkW+5XFrdLAR0ZuG8FPnWyS2d5/gqoxwpFnu9jG6zHXR/ufsCb7rSNlxh2wt54KxkmQFbvCIqEFtsmAeT38yMx2rHPsefiZhMJbkMxA1bG81EccMGeifjxzFj9fWLANWyuu8I9AccqmC14IZVrkOkzQoswxnFu6rn6GlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sFxOB-0000AO-Bf; Sat, 08 Jun 2024 16:49:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/2] drm/rockchip: vop: clear DMA stop bit upon vblank on
 RK3066
Date: Sat, 08 Jun 2024 16:49:50 +0200
Message-ID: <4253237.VLH7GnMWUR@phil>
In-Reply-To: <CNOFES.QFA1L3UJ3SH82@packett.cool>
References:
 <20240527231202.23365-1-val@packett.cool> <CNOFES.QFA1L3UJ3SH82@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Sonntag, 2. Juni 2024, 05:35:36 CEST schrieb Val Packett:
>=20
> On Mon, May 27 2024 at 20:11:49 -03:00:00, Val Packett=20
> <val@packett.cool> wrote:
> > The RK3066 VOP sets a dma_stop bit when it's done scanning out a frame
> > and needs the driver to acknowledge that by clearing the bit.
> >=20
> > So unless we clear it "between" frames, the RGB output only shows=20
> > noise
> > instead of the picture. vblank seems to be the most appropriate place=20
> > to
> > do it, since it indicates exactly that: that the hardware is done
> > with the frame.
> >=20
> > This seems to be a redundant synchronization mechanism that was=20
> > removed
> > in later iterations of the VOP hardware block.
> >=20
> > Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 ++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
> >  3 files changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c=20
> > b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index a13473b2d..2731fe2b2 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -1766,6 +1766,12 @@ static void vop_handle_vblank(struct vop *vop)
> >  	}
> >  	spin_unlock(&drm->event_lock);
> >=20
> > +	if (VOP_HAS_REG(vop, common, dma_stop)) {
> > +		spin_lock(&vop->reg_lock);
> > +		VOP_REG_SET(vop, common, dma_stop, 0);
> > +		spin_unlock(&vop->reg_lock);
> > +	}
> > +
>=20
> Oops=E2=80=A6 so doing it here actually causes deadlocks, unless we also=
=20
> change all other reg_lock usages to be spin_lock_irq/spin_unlock_irq.
>=20
> Not sure if doing that or going back to v1 would be better.

then please go back to v1 (as v4) :-) .

I.e. regular spinlock vs. spin_lock_irq will have performance
implications and this "feature" is a one-time only thing used
only on a more than 10 year old soc, so it really must not affect
stuff coming after it.


Heiko



