Return-Path: <stable+bounces-242202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B7qNkS182lB6QEAu9opvQ
	(envelope-from <stable+bounces-242202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:02:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 475824A78AC
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FEC302A681
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6690389453;
	Thu, 30 Apr 2026 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5LLQ8Xu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6133890E0
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579329; cv=none; b=oKpJ+SbS3grB/3ykVewolmmTZ+0O1eZeqZI17soeHK/OaAa2JfVVrcz7NjL/4KZyCTKAMRgyBTgePJjqmE59GlTA6aQz9fxKkxlqaR13qyO6Gs4STVzyyaQHZ6kvFIyKIj/+8BFS/NAQ0+khJJZiGgqEQx638QISAKBrxIgUsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579329; c=relaxed/simple;
	bh=ZHuLHxqB6LjVFXQ9mqBXp/R0a/Y126DJlp/s4KAJlzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQaCMofyhsTwHt2B9vQqy0kUy9hGBPwPElSq56Tn8Jse4Va6OXk+gUE2gnAQcKYVZDTFBckLgoRlcs9shjspkruU2sdcVzdZedAYSbgqf8oYmwxXQ9soA1mPUVElYe2Tj5HmTSGhegQHEyrFuSnlhRd8KmUsx2zQnDokplcZN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5LLQ8Xu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so19190315e9.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777579326; x=1778184126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35CpLK8dF17epUVO+7XXTbPPO+g9vsXIfv1w96oRvMw=;
        b=q5LLQ8Xu8hpsyAkiXl4fF1q7ZmYXRUVkBnhYSufwzEVvlqivXqGA0hJayffWHdnoqH
         rUc1STxVyuH1KdqJrxeyVH/7zyz77B84TgrKnDQCvTIfWs9lm83qqD18RetOqiKiltU/
         qbIImRLd3J6OxuEoPGfDCYzAu/dIdx+i67ayqlDN7zMIxKU6Xh1b4CGhJ6w+WNuZmEAp
         D0vfkX2/UH9o6MZMx7RH4CprCqQHggS54RtMEwuB/Tav9sMAJZqnIf9brg4NHniFhKZT
         yOshRsPSukEPZzbpiA+XR1953HbiyRFLxjsxf41l4VQ7C85iy2S35JM2uEogtknimZ1c
         xMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579326; x=1778184126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35CpLK8dF17epUVO+7XXTbPPO+g9vsXIfv1w96oRvMw=;
        b=WGc0DSp+WzFPyfCWDqv0jCIjvIPmx8NABudvLSMHe8ViEwJ1UcGr3+MIBFot2w6yZy
         him2r+H5sYF3TpCpi/YtuOTt6eXTsWr1AQ/vhapcGHayG8B7AYgdFhapQT7eL10y+yyf
         o/XYyVoEk9Lh45RSC4VYIn3xMZxxrleMIx8fGB6zaQ/Wc2NdSyrmaBq6f9hmkOzK97v4
         XI6OA//GHwz7UfJC5O2lu1VSSJpzDD30mmuCfvjr5fT/erKLzIegQssFfy90fNNYRmHX
         bdR7QmgzWlD6/ibny6i54gfcpvKNk80hceVzDNEf9oyVC8qed5wbLBg+fW+gsSCKrT2X
         +JCg==
X-Forwarded-Encrypted: i=1; AFNElJ/apXjRZK1vNAf09qrsUngs8ao7DMeP5URHb5D33USIo4VkYKZ6Go6JVZyDQ2C8mqsoospYFoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkavCRX4PrCaKZH7XMNJVXWwvmhcR/YniNpkuvwc+kQn7yVmJm
	CIRcaU3gPeXLAc7p/aF07GbVRwQOionR184H3A00WzqzZWEYOoGZ/bw9
X-Gm-Gg: AeBDietX/sIjrAQBqGDS3AdczQN6xxl6aK8JxQGi1w6jAeUEReiwsbOwoLMnI84zTiK
	IN/iHbZikBwStqc/kl23/VkR9bgVVYlFHePGqmiNHi9wx5wZgVEX58HFtcU95/UBi3al/mqxS6C
	clQtK1VvLMAMxN+c3xWMx2PkedAk53nveIU83nCJPywnbiaR64CLFqhWoP3UuB71sntZJhMMsMZ
	K2D3q5QHje6mWmAtDfcDDyDNYkLNhZcZsBzcgOqWRC2iun1y/EP8+C6jN7iCIXLJ79zTnBbNgOc
	uZQu4Nljc854qB9srZluvRgQRUIKCSTCqtyfdZRkhBq8VYKSObXooIqjZHT/NCbFdKerYcVdM1Q
	JG+fwjRCZ2WpeVqydbI6X3JKMIGyCJFELI0QM6+AjKVJ8NBTOdBfpFoqFDNZvvzyo1QBCTECtvn
	nw1vVGGtXWg7GCmhP/O2CRuRMwyRxAKZUV2xCpZWTxiBN7Zcfw8SMW0ZoXCdB/8k+IP7S6
X-Received: by 2002:a05:600c:c174:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a83d66ba9mr71345655e9.3.1777579326206;
        Thu, 30 Apr 2026 13:02:06 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72184sm1003145e9.32.2026.04.30.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:02:04 -0700 (PDT)
Date: Thu, 30 Apr 2026 22:02:02 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
Message-ID: <afO1OhM1M073okcY@osama>
References: <20260423200546.324187-1-osama.abdelkader@gmail.com>
 <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
X-Rspamd-Queue-Id: 475824A78AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242202-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Luca,

On Wed, Apr 29, 2026 at 01:40:39PM +0200, Luca Ceresoli wrote:
> On Thu Apr 23, 2026 at 10:05 PM CEST, Osama Abdelkader wrote:
> > Use devm_drm_bridge_add() so the bridge is released if probe fails after
> > registration, and drop drm_bridge_remove() in chipone_i2c_probe.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
> > Cc: stable@vger.kernel.org
> > ---
> > v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
> >     and add Fixes and Cc tags
> > v2: devm_drm_bridge_add instead of drm_bridge_add
> > ---
> >
> >  drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > index 5bee10c64265..4d76e1bd5e78 100644
> > --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> > +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > @@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *client)
> >  	dev_set_drvdata(dev, icn);
> >  	i2c_set_clientdata(client, icn);
> >
> > -	drm_bridge_add(&icn->bridge);
> > -
> > -	ret = chipone_dsi_host_attach(icn);
> > +	ret = devm_drm_bridge_add(dev, &icn->bridge);
> >  	if (ret)
> > -		drm_bridge_remove(&icn->bridge);
> > -	return ret;
> > +		return ret;
> > +
> > +	return chipone_dsi_host_attach(icn);
> > +
> >  }
> >
> >  static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
> 
> This patch does not apply. Is it messed up with patch 2/2?
> 

The file was changed on upstream in the meanwhile, so I refreshed my patch.

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

