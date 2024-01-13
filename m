Return-Path: <stable+bounces-10618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682F82C915
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 03:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3757AB239C4
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 02:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECC18E02;
	Sat, 13 Jan 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db8vIRk4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED12171DD;
	Sat, 13 Jan 2024 02:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3378C433C7;
	Sat, 13 Jan 2024 02:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705112009;
	bh=5ognxcE1HcI052/VObEGy4guszc42K8ozoLqQioknjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Db8vIRk4Ae3BQLrgCp+c/2hJK3FZun1UD1mAy8lg/2z/iWzQBR+nSOmSmatK2Vu8U
	 OrAGcFYQEKp4HQzwOs6jQyhINXj10TqS4Ahx1/YSGu/SpaRFTiObr0Sz/UF8bw4gdb
	 CmS5mKqcM46hwGLJNWARbSWlCIXKEoS7mX1ezjHU9mKr7GZx7vkvGJReT8AFxgoyeO
	 uLAsw6Vgn6/VOVN1DjXGQrX9hw4ptlqAO5W/8DzO2y5CWAbJKcbvz+g+aOfYf2inPf
	 KDyqgheBVC2+zT6i+6bW8/rizBsaZiBJhtOonvdUaSG46N1RKnIXIpPoYNcCjeUAQh
	 54nAoBwyugGdg==
Date: Fri, 12 Jan 2024 18:13:27 -0800
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
Message-ID: <20240112181327.505b424e@kernel.org>
In-Reply-To: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com>
References: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 15:58:51 +0100 Romain Gantois wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
> frames are ignored by the checksum offload engine and IP header checker of
> some stmmac cores.
> 
> On RX, the stmmac driver wrongly assumes that checksums have been computed
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
> 
> Add an additional check in the stmmac TX and RX hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> IP header checks.
> 
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc:  <stable@vger.kernel.org>

nit: double space

> +/**
> + * stmmac_has_ip_ethertype() - Check if packet has IP ethertype
> + * @skb: socket buffer to check
> + *
> + * Check if a packet has an ethertype that will trigger the IP header checks
> + * and IP/TCP checksum engine of the stmmac core.
> + *
> + * Return: true if the ethertype can trigger the checksum engine, false otherwise

nit: please don't go over 80 chars unless there's a good reason.
we are old school and stick to checkpatch --max-line-length=80 in netdev

>  	if (csum_insertion &&
> -	    priv->plat->tx_queues_cfg[queue].coe_unsupported) {
> +	    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
> +	    !stmmac_has_ip_ethertype(skb))) {

nit: minor misalignment here, the '!' should be under 'p'

>  		if (unlikely(skb_checksum_help(skb)))
>  			goto dma_map_err;
>  		csum_insertion = !csum_insertion;
> @@ -4997,7 +5020,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  	stmmac_rx_vlan(priv->dev, skb);
>  	skb->protocol = eth_type_trans(skb, priv->dev);
>  
> -	if (unlikely(!coe))
> +	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))

The lack of Rx side COE checking in this driver is kinda crazy.
Looking at enh_desc_coe_rdes0() it seems like RDES0_FRAME_TYPE
may be the indication we need here? 

We can dig into it as a follow up but I'm guessing that sending
an IPv6 packet with extension headers will also make the device
skip checksumming, or a UDP packet with csum of 0?

