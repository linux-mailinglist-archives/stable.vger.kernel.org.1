Return-Path: <stable+bounces-7919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226D81884C
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC83B1F22A6D
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004B18B08;
	Tue, 19 Dec 2023 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J/IGMFa4"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690118E10;
	Tue, 19 Dec 2023 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C78DE1C000F;
	Tue, 19 Dec 2023 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702991278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vOCGtitF2HXWOLXDqhpNdoEBncyC42eynFv1ljek8s=;
	b=J/IGMFa4EEj/d/lEkcPk0xSpQNuPyk2FE6kqlPgm/6jdbO/ngl3pGC/pYFd7akxBt6Rl03
	BYOB11oXgmQCP8b/zIbLG98RzZqD6r5v56IqxtnFM5iwOS2q37v4N7weF3RdGiYKdcPjRJ
	LESkn5eU0dafsjzWts/m6HqmXaIG0t8dyvd8ynrXs/9TL0pOHh394ZN8XxUIQZOWhO7aGc
	0Mqtli1bCPm1Tx1YCc2tdp1NNMB/zTytaqteHcmQ/4gH4ODU2UM/x6sQQ7aNJqYdwqOE6a
	Ge79Fcd8q2q2CDcOKiBfI3xBJDTNcfcVJDUAZx8ynU5q5b1CYpWq2AGWdaE7uQ==
Date: Tue, 19 Dec 2023 14:07:54 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, Pascal
 EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20231219140754.7a7a8dbd@device-28.home>
In-Reply-To: <20231219122034.pg2djgrosa4irubh@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
	<20231218162326.173127-2-romain.gantois@bootlin.com>
	<20231219122034.pg2djgrosa4irubh@skbuf>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Vlad,

+ Linus Walleij

On Tue, 19 Dec 2023 14:20:34 +0200
Vladimir Oltean <olteanv@gmail.com> wrote:

> Hi Romain,
> 
> On Mon, Dec 18, 2023 at 05:23:23PM +0100, Romain Gantois wrote:
> > Some stmmac cores have Checksum Offload Engines that cannot handle DSA tags
> > properly. These cores find the IP/TCP headers on their own and end up
> > computing an incorrect checksum when a DSA tag is inserted between the MAC
> > header and IP header.
> > 
> > Add an additional check on stmmac link up so that COE is deactivated
> > when the stmmac device is used as a DSA conduit.
> > 
> > Add a new dma_feature flag to allow cores to signal that their COEs can't
> > handle DSA tags on TX.
> > 
> > Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> > Cc: stable@vger.kernel.org
> > Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> > Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> > Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> > Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> > ---  
> 
> DSA_TAG_PROTO_LAN9303, DSA_TAG_PROTO_SJA1105 and DSA_TAG_PROTO_SJA1110
> construct tags with ETH_P_8021Q as EtherType. Do you still think it
> would be correct to say that all DSA tags break COE on the stmmac, as
> this patch assumes?
> 
> The NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM convention is not about
> statically checking whether the interface using DSA, but about looking
> at each packet before deciding whether to use the offload engine or to
> call skb_checksum_help().

So it looks like an acceptable solution would be something along the
lines of what Linus is suggesting here :

https://lore.kernel.org/netdev/20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org/

If so, maybe it's worth adding a new helper for that check ?

Maxime

