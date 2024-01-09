Return-Path: <stable+bounces-10391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB38288CF
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30962287D45
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4EA39FC5;
	Tue,  9 Jan 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VFu75ftC"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3439FC1;
	Tue,  9 Jan 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 543ED20002;
	Tue,  9 Jan 2024 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704813386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssy2NqEQhKlkgPOMZNnArO4w7khdLMgeVZhOT1pVsOI=;
	b=VFu75ftCyPs7Lt9Z8ASUCZLKtzregIBQ7aO1l9XO0o4PxjAaAZodyeAc62v9jOluNfDemu
	k3UYeyXIwZv+40VMTA8dbBJ96HLEz1GcKkRFD7hUZ9YA35syoJI0M3P+LZYGF/08ycxnVc
	hso6sRefCxYy8VW40CxWvbKDZdFfQjw0PJ8q0rbL+a4Y8fcZ+/9tvLsJ8EMPbluacn/FjD
	GP3DbZjfpODWTrs3T/1J0xL2q6FPFmKGhlQBwYim9+vscLOa2A2cgZWrc9LNHdYZO3S+ma
	Oo4Ui811n+ADwLMT6aTcnKnAszkX8zPAtIC2pWRcNjiGy9tWl4KoozOfyOye1Q==
Date: Tue, 9 Jan 2024 16:16:49 +0100 (CET)
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
In-Reply-To: <20240108143614.ldeizw33o6l7aevi@skbuf>
Message-ID: <7afd8717-4b3a-2104-3581-4cf3440be0f8@bootlin.com>
References: <20240108130238.j2denbdj3ifasbqi@skbuf> <3c2f6555-53b6-be1c-3d7b-7a6dc95b46fe@bootlin.com> <20240108143614.ldeizw33o6l7aevi@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Mon, 8 Jan 2024, Vladimir Oltean wrote:

> On Mon, Jan 08, 2024 at 03:23:38PM +0100, Romain Gantois wrote:
> > I see, the kernel docs were indeed enlightening on this point. As a side note, 
> > I've just benchmarked both the "with-inline" and "without-inline" versions. 
> > First of all, objdump seems to confirm that GCC does indeed follow this pragma 
> > in this particular case. Also, RX perfs are better with stmmac_has_ip_ethertype 
> > inlined, but TX perfs are actually consistently worse with this function 
> > inlined, which could very well be caused by cache effects.
> > 
> > In any case, I think it is better to remove the "inline" pragma as you said. 
> > I'll do that in v4.
> 
> Are you doing any code instrumentation, or just measuring the results
> and deducing what might cause them?
> 
> It might be worth looking at the perf events and seeing what function
> consumes the most amount of time.
> 
> CPU_CORE=0
> perf record -e cycles -C $CPU_CORE sleep 10 && perf report
> perf record -e cache-misses -C $CPU_CORE sleep 10 && perf report
> 

Unfortunately my hardware doesn't support these performance metrics, but I did 
manage to do some instrumentation with the ftrace profiler:

Same test conditions as before, 10 second iperf3 runs with unfragmented UDP 
packets.

no inline TX
  average time per call for stmmac_xmit(): 85us
  average time per call for stmmac_has_ip_ethertype(): 2us

no inline RX
  average time per call for stmmac_napi_poll_rx(): 8142us
  average time per call for stmmac_has_ip_ethertype(): 2us

inline TX:
  average time per call for stmmac_xmit(): 85us

inline RX:
  average time per call for stmmac_napi_poll_rx(): 8410us

It seems like this time, RX performed slightly worse with the function inline. 
To be honest, I'm starting to doubt the reproducibility of these tests. In any 
case it seems better to just remove the "inline" and let gcc do the optimizing.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

