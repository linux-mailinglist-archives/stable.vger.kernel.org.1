Return-Path: <stable+bounces-10030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDC827129
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231651C22946
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12054655D;
	Mon,  8 Jan 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="icnrmGyA"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066746533;
	Mon,  8 Jan 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96F241BF20B;
	Mon,  8 Jan 2024 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704723798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/7gyP7Ro6EIbSwHo4bXO7Wl4exbJDbw0YZeICc6ouA=;
	b=icnrmGyALvII03k+3GInGbojmaxtepRoQ7+GtXT2w0spXvKR1ks6erFkOAI2x9pIX0BBsc
	MJcD5ANmD/A92ILssF2Da2xZ3qNH8sHiZ28QKKl8Kp8c4BPpaRUagJZtHuDNWMgnVAGDnq
	hJO3W1ZMAJDbgqABnXKC0prKgPjmlcM+tlVXS2aYXWhl1HGZqKNgqDyyxABbjrYfebXu2X
	lq0L96omGzIS6TEXJTBrR+ETUHeUwhT94HYhhVSMyopDtf1aDp1t5HuBBACmaIoWIYTNn7
	fifQ+OACszEyUZ8XKo4P6W3Fs+rzBjyaVpXgx/CT18/mxUNwgMmUmc1z1Y4XEg==
Date: Mon, 8 Jan 2024 15:23:38 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: stmmac: Prevent DSA tags from breaking
 C
In-Reply-To: <20240108130238.j2denbdj3ifasbqi@skbuf>
Message-ID: <3c2f6555-53b6-be1c-3d7b-7a6dc95b46fe@bootlin.com>
References: <20240108130238.j2denbdj3ifasbqi@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Mon, 8 Jan 2024, Vladimir Oltean wrote:

...

> Nitpick: you could render this in kernel-doc format.
> https://docs.kernel.org/doc-guide/kernel-doc.html
> 
> > +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> 
> Nitpick: in netdev it is preferred not to use the "inline" keyword at
> all in C files, only "static inline" in headers, and to let the compiler
> decide by itself when it is appropriate to inline the code (which it
> does by itself even without the "inline" keyword). For a bit more
> background why, you can view Documentation/process/4.Coding.rst, section
> "Inline functions".

I see, the kernel docs were indeed enlightening on this point. As a side note, 
I've just benchmarked both the "with-inline" and "without-inline" versions. 
First of all, objdump seems to confirm that GCC does indeed follow this pragma 
in this particular case. Also, RX perfs are better with stmmac_has_ip_ethertype 
inlined, but TX perfs are actually consistently worse with this function 
inlined, which could very well be caused by cache effects.

In any case, I think it is better to remove the "inline" pragma as you said. 
I'll do that in v4.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

