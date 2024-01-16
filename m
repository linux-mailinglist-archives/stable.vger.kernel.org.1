Return-Path: <stable+bounces-11344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBF82F164
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E517A2848C7
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89B1BF56;
	Tue, 16 Jan 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq4ggkoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D741C280;
	Tue, 16 Jan 2024 15:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF7FC433C7;
	Tue, 16 Jan 2024 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705418582;
	bh=AmZdj0eOvsIB/ujpQpyR8C/TssJ81P4jo/0LQq93d8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nq4ggkoL4EWs4nhCK2iucl9MmiXNhmC6pgZ7TaIeIM/Lg6XVkB87rwndBWwYB4Q3P
	 sPyclCXTudskQ8Je4/NNXPRb8KGgOGlHhnzqXHFAkDmizz2mLMlcGmeqwUlPapk5gl
	 RLCNplQFOJ0ZQDPT6FrjflKizAYloysT3Vs9H/iNzKyyAAjXE2pw/nJlA2nTwPy4ZA
	 /C5LT8PZweUUzWRPgiPlxupO9ja20RncG5jXUvGlDyjhPi35Fpn97B//GgvnA3u4sQ
	 qIULyU8tFAdke8LtHCx1uT4gcbLSQLwP+4gTxyx+zk58r5haZpwFnpZEsdmvQ936HF
	 fvrrmMX8KjY6g==
Date: Tue, 16 Jan 2024 07:23:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>,
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v5] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20240116072300.3a6e0dbe@kernel.org>
In-Reply-To: <fca39a53-743e-f79d-d2d1-f23d8e919f82@bootlin.com>
References: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com>
	<20240112181327.505b424e@kernel.org>
	<fca39a53-743e-f79d-d2d1-f23d8e919f82@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 13:14:15 +0100 (CET) Romain Gantois wrote:
> > > @@ -4997,7 +5020,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
> > >  	stmmac_rx_vlan(priv->dev, skb);
> > >  	skb->protocol = eth_type_trans(skb, priv->dev);
> > >  
> > > -	if (unlikely(!coe))
> > > +	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))  
> > 
> > The lack of Rx side COE checking in this driver is kinda crazy.
> > Looking at enh_desc_coe_rdes0() it seems like RDES0_FRAME_TYPE
> > may be the indication we need here?   
> 
> I don't think that RDES0_FRAME_TYPE would be enough, at least not on its own. 
> That bit is set by checking the length/ethertype field to see if is an 
> Ethernet II frame or an IEEE802.3 frame. But even Ethernet II frames with non-IP 
> ethertypes will not be checksummed. Also protocols with a non-fixed ethertype 
> field such as DSA_TAG_PROTO could trigger the bit, or not, depending on what 
> they put in the DSA tag.

Hm, the comment in enh_desc_coe_rdes0() says:

	/* bits 5 7 0 | Frame status
	 * ----------------------------------------------------------
	 *      0 0 0 | IEEE 802.3 Type frame (length < 1536 octects)
	 *      1 0 0 | IPv4/6 No CSUM errorS.
	 *      1 0 1 | IPv4/6 CSUM PAYLOAD error
	 *      1 1 0 | IPv4/6 CSUM IP HR error
	 *      1 1 1 | IPv4/6 IP PAYLOAD AND HEADER errorS
	 *      0 0 1 | IPv4/6 unsupported IP PAYLOAD
	 *      0 1 1 | COE bypassed.. no IPv4/6 frame
	 *      0 1 0 | Reserved.
	 */

which makes it sound like bit 5 will not be set for a Ethernet II frame
with unsupported IP payload, or not an IP frame. Does the bit mean other
things in different descriptor formats?

