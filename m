Return-Path: <stable+bounces-47506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D08D0EBE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 22:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C671F21AE3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CD16130D;
	Mon, 27 May 2024 20:44:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61C17E8FC;
	Mon, 27 May 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842653; cv=none; b=UtaYUoaQQAHaXacG/BT1uzBtTHpS2B/IMLYXUd5/MyskK2D53dj6TRHpMFxCrz7v/LCZW5KjJtk4muIXY3J3NC9xhgXYgqyvhFJL56hH+8KrmiItJrA3kfNPNMo1Z4MsZbvGS8Lq5hG2LuIKSJhFlT/ohBLyRWtYr6Rgj2/+xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842653; c=relaxed/simple;
	bh=U1AjakDK+K5nbYaKkqnUSS8GTOMKffDL+ZBcW8XHkjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM2mD5fQRA4O6jtlqGd1hGcuExyfYYOMdhZekUfL5fQfPePhKEWP2CoNxYgGtb1BhOrB0+wCytk7hYxZ2zDPAIsqoRwsQ2L6GsCMx15bcxTc/83G7YmKPayGaLkx9o5boZs8fsgi4AhuQlamMJwltAAit8GNHroH9k6nD/uZsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBhBf-0004Tg-UH; Mon, 27 May 2024 22:43:19 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Val Packett <val@packett.cool>
Cc: Val Packett <val@packett.cool>, stable@vger.kernel.org,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] drm/rockchip: vop: clear DMA stop bit upon vblank on
 RK3066
Date: Mon, 27 May 2024 22:43:18 +0200
Message-ID: <1817371.3VsfAaAtOV@diego>
In-Reply-To: <20240527071736.21784-1-val@packett.cool>
References:
 <2024051930-canteen-produce-1ba7@gregkh>
 <20240527071736.21784-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Val,

Am Montag, 27. Mai 2024, 09:16:33 CEST schrieb Val Packett:
> On the RK3066, there is a bit that must be cleared, otherwise
> the picture does not show up on the display (at least for RGB).
> 
> Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> v2: doing this on vblank makes more sense; added fixes tag

can you give a rationale for this please?

I.e. does this dma-stop bit need to be set on each vblank that happens
to push this frame to the display somehow?

Because at least in theory atomic_flush where this was living in in v1,
might happen at a slower interval?


Thanks
Heiko

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 ++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index a13473b2d..2731fe2b2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1766,6 +1766,12 @@ static void vop_handle_vblank(struct vop *vop)
>  	}
>  	spin_unlock(&drm->event_lock);
>  
> +	if (VOP_HAS_REG(vop, common, dma_stop)) {
> +		spin_lock(&vop->reg_lock);
> +		VOP_REG_SET(vop, common, dma_stop, 0);
> +		spin_unlock(&vop->reg_lock);
> +	}
> +
>  	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
>  		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
>  }
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index b33e5bdc2..0cf512cc1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -122,6 +122,7 @@ struct vop_common {
>  	struct vop_reg lut_buffer_index;
>  	struct vop_reg gate_en;
>  	struct vop_reg mmu_en;
> +	struct vop_reg dma_stop;
>  	struct vop_reg out_mode;
>  	struct vop_reg standby;
>  };
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index b9ee02061..9bcb40a64 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -466,6 +466,7 @@ static const struct vop_output rk3066_output = {
>  };
>  
>  static const struct vop_common rk3066_common = {
> +	.dma_stop = VOP_REG(RK3066_SYS_CTRL0, 0x1, 0),
>  	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
>  	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
>  	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),
> 





