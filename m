Return-Path: <stable+bounces-166445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E3B19D55
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED72D164EAF
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD92376F8;
	Mon,  4 Aug 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwrJapm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D147DA6D;
	Mon,  4 Aug 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294800; cv=none; b=VuO9My4gPushdmPXUP8USKkDI0bHbQeUPd27g1r0djZjRxTh2xRuq66CWpk/kBwFiWsB00IqT5T/cWlVmXBLLKOa7NDKLhse43H4vRLC+nstph8iuwthrFfPoqDqZvCnTHVmpPCkgR/x4pvC6FpOaqQ81hIQ+5OqMbKymZ9pioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294800; c=relaxed/simple;
	bh=LJsP3POugebwTfDcQDDyey0X+IAXbHHrUgRPsb8MIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+zdZ6guXnYgP3p/CO+IPDW0zIiE2a7/UbE5UWbLawCMXeRI39r4rIJcYR9J13pJbhjGkRaIZcEXAc6qVSSk1XwvBYyb/PmnvvzAAtdOOP5B7iR0nV3Le8/5K27wowkuL6j21k2SEUfLt8qxvSu6bUB7j22Yb7gtSHlbC5oQ1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwrJapm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9675CC4CEE7;
	Mon,  4 Aug 2025 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754294800;
	bh=LJsP3POugebwTfDcQDDyey0X+IAXbHHrUgRPsb8MIDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwrJapm8clxrbORWct74JESkw++nKBRizntME8+LH/8scwh8qPZGh+oXekE2a/hNq
	 SC3dSBFesoKAwNeaW8ZYadGbrIor3viKN9Bh4vxmLItcbN/ELSJ7d9UHWKqE8TvI/C
	 9SFH8AcFibn24rFyfIkxiKqIuwVLhghG7Eq7jsifJZpTG8pfs8jUq853vMf5ACThK7
	 pGNJI/I8osPmv8XtGBvr+qB/GoyRn/no/CSJnTuHk7F8wwFKBdkGIGOtMra7vTxqA8
	 cICuFZ9Gww8udA9nGwQBME2mWs2lul3h86ztNqtwjDP1DppAs1TiwefeTWlDjHfcKc
	 SB2rP3vFLiPNw==
Date: Mon, 4 Aug 2025 10:06:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, thomas.petazzoni@bootlin.com, Jyri Sarha <jsarha@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/tidss: Fix sampling edge configuration
Message-ID: <20250804-tuscan-woodpecker-from-jupiter-9d290f@kuoka>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>

On Wed, Jul 30, 2025 at 07:02:47PM +0200, Louis Chauvet wrote:
> As stated in the AM62x Technical Reference Manual (SPRUIV7B), the data
> sampling edge needs to be configured in two distinct registers: one in the
> TIDSS IP and another in the memory-mapped control register modules. Since
> the latter is not within the same address range, a phandle to a syscon
> device is used to access the regmap.
> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> ---
> 
> Cc: stable@vger.kernel.org

Please read docs how to add stable tags.

> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index c0277fa36425ee1f966dccecf2b69a2d01794899..65ca7629a2e75437023bf58f8a1bddc24db5e3da 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -498,6 +498,7 @@ struct dispc_device {
>  	const struct dispc_features *feat;
>  
>  	struct clk *fclk;
> +	struct regmap *clk_ctrl;
>  
>  	bool is_enabled;
>  
> @@ -1267,6 +1268,11 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
>  		       FLD_VAL(mode->vdisplay - 1, 27, 16));
>  
>  	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
> +
> +	if (dispc->clk_ctrl) {
> +		regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
> +		regmap_update_bits(dispc->clk_ctrl, 0, 0x200, rf ? 0x200 : 0x000);
> +	}
>  }
>  
>  void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
> @@ -3012,6 +3018,14 @@ int dispc_init(struct tidss_device *tidss)
>  
>  	dispc_init_errata(dispc);
>  
> +	dispc->clk_ctrl = syscon_regmap_lookup_by_phandle_optional(tidss->dev->of_node,
> +								   "ti,clk-ctrl");
> +	if (IS_ERR(dispc->clk_ctrl)) {
> +		r = dev_err_probe(dispc->dev, PTR_ERR(dispc->clk_ctrl),
> +				  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
> +		return r;

This breaks ABI. Commit msg mentions the reason but without
justification - was everything broken? Nothing was working? Was it ever
tested?

And anyway ABI impact must be clearly documented.


Best regards,
Krzysztof


