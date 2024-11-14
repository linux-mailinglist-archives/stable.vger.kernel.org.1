Return-Path: <stable+bounces-92982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F539C86B8
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BCB2847E
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87C1F80DF;
	Thu, 14 Nov 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GzsU5z4q"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B71F80D2;
	Thu, 14 Nov 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578292; cv=none; b=s0kke8dWRpfgWjmuBziS5BbyNx235mOdoSe6VOLCgdy7qbfQI+QpIo9N0ST0R9mLXsTcl1Chf2nggJxoeBYCwPq5RtsT+hJN9vvgz7wgruaLqxT/MkyfNTYmqDaKuALsqNTzVVtrfpg+Xd9PSb+iS5MZtE2CMxTb1AtduaKX1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578292; c=relaxed/simple;
	bh=crWZ1ze4cMR+zy2qScv/YRPHFpCp1d0+ehs6EwVQoH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q27iP0f6JLaPCX2aFGY3IUVtH6aihnuhJnkcQH4OzC0Qck4SEGLR8O26Iv+aGzegFU3k6QSSZCYzwknumz1Q6N2+GshccFS8U4fYeJ76pV/HNMTsXMUmhk25WH+WAmxX0Hu4ZSoV/WY5nMFJx07iD0yryoiBy9sOJ8+0lBYBp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GzsU5z4q; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CC6FE1F967;
	Thu, 14 Nov 2024 10:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1731578279;
	bh=shuvYLY0wGIkdQPmLkGeU/39Ky+W1R7sgHWYS0+iKIo=; h=From:To:Subject;
	b=GzsU5z4qaNTVEELKRIjILt6VvxTKUkxuZPAPw+19LBfnaIlsK/caxKH0LHa/yEXng
	 qEETAAoG4FesVCxa4/cSIlamevbPQonV6rRPlLhhiAkPUGZTeAkZET+eYz0wORsROX
	 3IlL+4Lj+SdU0IsLlmSDEcuttt3cMKZG7P6EPZUoYz6RfqFn6WfXpGYDuP5+MXlm8/
	 cM5VGFu4ui/rd9Wsa59YRJrKInjfNUonM1zwxVRJA0JYveoiTYLT5poNQRCOtPechh
	 olB25m6qLs1Twod2DEEMdSbDbEmPAV6sLGgDLFM9JXtoR0HyAg9w+lib8vfsP3+FGl
	 kwSzFH58GdJ2g==
Date: Thu, 14 Nov 2024 10:57:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] drm/bridge: tc358768: Fix DSI command tx
Message-ID: <20241114095754.GA23530@francesco-nb>
References: <20240926141246.48282-1-francesco@dolcini.it>
 <e28f88ca-357b-4751-8b37-c324ff40f9f5@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28f88ca-357b-4751-8b37-c324ff40f9f5@linaro.org>

Hello Neil,

On Wed, Oct 23, 2024 at 10:03:20AM +0200, Neil Armstrong wrote:
> On 26/09/2024 16:12, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Wait for the command transmission to be completed in the DSI transfer
> > function polling for the dc_start bit to go back to idle state after the
> > transmission is started.
> > 
> > This is documented in the datasheet and failures to do so lead to
> > commands corruption.
> > 
> > Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >   drivers/gpu/drm/bridge/tc358768.c | 21 +++++++++++++++++++--
> >   1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> > index 0e8813278a2f..bb1750a3dab0 100644
> > --- a/drivers/gpu/drm/bridge/tc358768.c
> > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > @@ -125,6 +125,9 @@
> >   #define TC358768_DSI_CONFW_MODE_CLR	(6 << 29)
> >   #define TC358768_DSI_CONFW_ADDR_DSI_CONTROL	(0x3 << 24)
> > +/* TC358768_DSICMD_TX (0x0600) register */
> > +#define TC358768_DSI_CMDTX_DC_START	BIT(0)
> > +
> >   static const char * const tc358768_supplies[] = {
> >   	"vddc", "vddmipi", "vddio"
> >   };
> > @@ -229,6 +232,21 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
> >   		tc358768_write(priv, reg, tmp);
> >   }
> > +static void tc358768_dsicmd_tx(struct tc358768_priv *priv)
> > +{
> > +	u32 val;
> > +
> > +	/* start transfer */
> > +	tc358768_write(priv, TC358768_DSICMD_TX, TC358768_DSI_CMDTX_DC_START);
> > +	if (priv->error)
> > +		return;
> > +
> > +	/* wait transfer completion */
> > +	priv->error = regmap_read_poll_timeout(priv->regmap, TC358768_DSICMD_TX, val,
> > +					       (val & TC358768_DSI_CMDTX_DC_START) == 0,
> > +					       100, 100000);
> > +}
> > +
> >   static int tc358768_sw_reset(struct tc358768_priv *priv)
> >   {
> >   	/* Assert Reset */
> > @@ -516,8 +534,7 @@ static ssize_t tc358768_dsi_host_transfer(struct mipi_dsi_host *host,
> >   		}
> >   	}
> > -	/* start transfer */
> > -	tc358768_write(priv, TC358768_DSICMD_TX, 1);
> > +	tc358768_dsicmd_tx(priv);
> >   	ret = tc358768_clear_error(priv);
> >   	if (ret)
> 
> Look good, I'll leave it here a few days if someone has comments

Just a gently reminder, thanks

> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Francesco


