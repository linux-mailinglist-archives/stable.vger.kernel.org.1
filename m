Return-Path: <stable+bounces-9241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A682298F
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714A9B215C2
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072C18041;
	Wed,  3 Jan 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FUWLmozv"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2B18032;
	Wed,  3 Jan 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FAA7E000A;
	Wed,  3 Jan 2024 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704271219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbyKDE6LxBB4pt4rAudS3Wo2lvqVspXh6sWUjAjOt3o=;
	b=FUWLmozv1lOWyRPl125r4yShizx8ZyjVEHwaVOariUJ7aXLVKDjpme/ubSiIwoqsb3nsdJ
	MtbyWBEq5ox8YUvWRRiRa3icEdGyTgTkPXYPRkyvIgUl96BAAf0KVyMtjC2mWFeqHxrTtD
	TvwTraBrLZvEI27cbHvuio22KdPXODO98rMo90wSFiN1ojp6FTmmhlN2p7B8odtybhjuyK
	ZV1vB3xRuVxiz47x6T+5D9MtRpNpQrzFKa4CsP9E5gO2G6mOdjPkpnsaxzPOfPnvojuO/i
	FvciG0Xd49tOV6gjichyIgNN5LHpMPldNPy09HTevxOnQHYt1tNsPXzUs7yybA==
Date: Wed, 3 Jan 2024 09:40:40 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, 
    Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
In-Reply-To: <e2250240-db19-4cb6-93ca-2384a382cdd5@gmail.com>
Message-ID: <753d4eab-5699-91e3-05a4-d0e03f7052e6@bootlin.com>
References: <20240102162718.268271-1-romain.gantois@bootlin.com> <20240102162718.268271-2-romain.gantois@bootlin.com> <e2250240-db19-4cb6-93ca-2384a382cdd5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Florian,

On Tue, 2 Jan 2024, Florian Fainelli wrote:

...
> > Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> > Cc: stable@vger.kernel.org
> > Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> > Closes:
> > https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
> > Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> > Closes:
> > https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
> 
> Fairly sure those should be Link: and Closes: should be used for bug tracker
> entries.

ACK

> > +	return (proto == htons(ETH_P_IP)) || (proto == htons(ETH_P_IPV6)) ||
> > +		(proto == htons(ETH_P_8021Q));
> 
> Do you need to include ETH_P_8021AD in that list as well or is not stmmac
> capable of checksuming beyond a single VLAN tag?

The datasheet for my Ethernet controller doesn't mention 802.1ad tag 
handling and I ran some loopback tests that showed that this controller doesn't 
recognize 802.1ad frames as vlan frames. I also haven't seen anything in the 
stmmac driver that suggests that 802.1ad offloading is supported. Maybe the 
stmmac maintainers could weigh in on this?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

