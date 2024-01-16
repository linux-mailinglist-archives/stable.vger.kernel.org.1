Return-Path: <stable+bounces-11338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B582EEC4
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B63285515
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DD1B96F;
	Tue, 16 Jan 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mkAehRpo"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71E1BC20;
	Tue, 16 Jan 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA498E0007;
	Tue, 16 Jan 2024 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705407233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAVZV89c3QYDdLE/sBbeCyFMppkpsy3QuH1HDnDx73c=;
	b=mkAehRpoJMOds1A3ag3izRN4ezIhnrkAkhPQxR5DxoOK4BvIsTbIR5UfiwKB4HGGdbmwB0
	kYFfl8c3mQ/9440wIMEl95bjiR/nGqf1LDVCp+1IGxg6uP1rDUpnZ99oLJf74vp/3jfnkG
	fjjjWq5Af3ubeIgwqM399Yf4Q3/Aj16xblGfGy6gOgRw3bZ16Xdoe1hnt7vheGIBggz0id
	GweB3+qyJ3nsSrZDfxOfbSj8lNVWsS+nT5cup4GQW/1/zbsj+jgzxCtu0kJcLwSzQnjgm5
	BCJfZZZst3IaTq5M9wi36/a7f6zhHHa/g9QY7f7LdD64D4SBfbno6ZKaOomfcA==
Date: Tue, 16 Jan 2024 13:14:15 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
    Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v5] net: stmmac: Prevent DSA tags from breaking COE
In-Reply-To: <20240112181327.505b424e@kernel.org>
Message-ID: <fca39a53-743e-f79d-d2d1-f23d8e919f82@bootlin.com>
References: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com> <20240112181327.505b424e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Jakub,

On Fri, 12 Jan 2024, Jakub Kicinski wrote:

> > @@ -4997,7 +5020,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
> >  	stmmac_rx_vlan(priv->dev, skb);
> >  	skb->protocol = eth_type_trans(skb, priv->dev);
> >  
> > -	if (unlikely(!coe))
> > +	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> 
> The lack of Rx side COE checking in this driver is kinda crazy.
> Looking at enh_desc_coe_rdes0() it seems like RDES0_FRAME_TYPE
> may be the indication we need here? 

I don't think that RDES0_FRAME_TYPE would be enough, at least not on its own. 
That bit is set by checking the length/ethertype field to see if is an 
Ethernet II frame or an IEEE802.3 frame. But even Ethernet II frames with non-IP 
ethertypes will not be checksummed. Also protocols with a non-fixed ethertype 
field such as DSA_TAG_PROTO could trigger the bit, or not, depending on what 
they put in the DSA tag.

--
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

