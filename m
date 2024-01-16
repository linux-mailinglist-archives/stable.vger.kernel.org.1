Return-Path: <stable+bounces-11349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE382F244
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FF21C236E1
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5A1C6A3;
	Tue, 16 Jan 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HrWo1Won"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFCA1CA92;
	Tue, 16 Jan 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9751E0009;
	Tue, 16 Jan 2024 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705421889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwW1R0N0aeihLh2IgYe6QDQbFMA5/uEI9u6zAxldBWw=;
	b=HrWo1WonVjqjbbyKmQlqRqBSyB+lFhXvICHLHVV6FHLDeyhwtRDsKXYSf0EsXEWoX/DHTt
	Ce2sZTI2UxiVQ9Aoy+f/QEkZqdsjIAgqdu6G036v2c44wK0JelNt3DDajvP6i0opdTyVPt
	2vVfK9+DK4UY4yDJsKcrWYvLrTTf8P4iFcacYrpenP6vaF6dgCEPapvUxQfIBplnpJldw7
	9OWoGvICzdumA9+Zz4IU5USG+hzsSnK/0kIOgFcEvaf7YQwviAOgR79qUXLa8Srnw7ihiW
	46Tw3h4jyNZeEJWHSq6jYjKMDpROPghCIqMbZKApr/OQQ0BR8iOAoVn8RuY+aw==
Date: Tue, 16 Jan 2024 17:18:30 +0100 (CET)
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
In-Reply-To: <20240116072300.3a6e0dbe@kernel.org>
Message-ID: <d844c643-16bd-6f9d-1d39-a4f93b3fcf87@bootlin.com>
References: <20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com> <20240112181327.505b424e@kernel.org> <fca39a53-743e-f79d-d2d1-f23d8e919f82@bootlin.com> <20240116072300.3a6e0dbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Tue, 16 Jan 2024, Jakub Kicinski wrote:

> Hm, the comment in enh_desc_coe_rdes0() says:
> 
> 	/* bits 5 7 0 | Frame status
> 	 * ----------------------------------------------------------
> 	 *      0 0 0 | IEEE 802.3 Type frame (length < 1536 octects)
> 	 *      1 0 0 | IPv4/6 No CSUM errorS.
> 	 *      1 0 1 | IPv4/6 CSUM PAYLOAD error
> 	 *      1 1 0 | IPv4/6 CSUM IP HR error
> 	 *      1 1 1 | IPv4/6 IP PAYLOAD AND HEADER errorS
> 	 *      0 0 1 | IPv4/6 unsupported IP PAYLOAD
> 	 *      0 1 1 | COE bypassed.. no IPv4/6 frame
> 	 *      0 1 0 | Reserved.
> 	 */
> 
> which makes it sound like bit 5 will not be set for a Ethernet II frame
> with unsupported IP payload, or not an IP frame. Does the bit mean other
> things in different descriptor formats?

The description of this bit in my datasheet is:

```
b5 FT Frame Type
When set, this bit indicates that the Receive Frame is an Ethernet-type frame 
(the Length/Type field is greater than or equal to 1,536). When this bit is 
reset, it indicates that the received frame is an IEEE 802.3 frame. This bit is 
not valid for Runt frames less than 14 bytes
```

There is no mention of a more subtle check to detect non-IP Ethernet II frames. 
I ran some tests on my hardware and EDSA-tagged packets consistently come in 
with status 0b100, so the MAC sets the frame type bit even for frames that don't 
have an IP ethertype.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

