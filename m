Return-Path: <stable+bounces-8690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A629820082
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0035C284667
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3C125CF;
	Fri, 29 Dec 2023 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mzl0h77R"
X-Original-To: stable@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6109125CB;
	Fri, 29 Dec 2023 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EF778C194F;
	Fri, 29 Dec 2023 16:11:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF78A240002;
	Fri, 29 Dec 2023 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703866288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zqi8dmMeOU3XDtyNyrJLxgovOsvnL1n+HnUCWjiryzI=;
	b=mzl0h77RyMj6S5QimPrixX8KNRjlHePNB2ZkUiW1I9hnJLejc/VQzGFm8nS326dqZfS/xl
	bKxX9mx4sqb41UzWjA7WEILOygNJBiY3aF+fLvRNRIRx6piDkxSq6D6QjpfZWfHUaUXoBn
	EGqUEC7N6KQLY+EEXZVaq4glUhZGUMhpeh2/L3dqd4kzSptktj4f0Xq+V/7sLwXJyw9yrw
	8LbIR34NmLppvtiNnUyC1RlZoVp65QhK2CNsUmkWp6d8A1MGIWlQyrzRCrJ3lpFeChxtTS
	uB/RNEHBgtTq2yrcgaWItC+6TVZK+2vqh7awbOTGv4iN1prJ8kR1js1/I9Mx5g==
Date: Fri, 29 Dec 2023 17:11:48 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
    Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking
 COE
In-Reply-To: <20231219122034.pg2djgrosa4irubh@skbuf>
Message-ID: <3b53aa8a-73e9-9260-f05b-05dac80a4276@bootlin.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com> <20231218162326.173127-2-romain.gantois@bootlin.com> <20231219122034.pg2djgrosa4irubh@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


On Tue, 19 Dec 2023, Vladimir Oltean wrote:
> DSA_TAG_PROTO_LAN9303, DSA_TAG_PROTO_SJA1105 and DSA_TAG_PROTO_SJA1110
> construct tags with ETH_P_8021Q as EtherType. Do you still think it
> would be correct to say that all DSA tags break COE on the stmmac, as
> this patch assumes?
> 
> The NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM convention is not about
> statically checking whether the interface using DSA, but about looking
> at each packet before deciding whether to use the offload engine or to
> call skb_checksum_help().
> 
> You can experiment with any tagging protocol on the stmmac driver, and
> thus with the controller's response to any kind of traffic, even if the
> port is not attached to a hardware switch. You need to enable the
Thanks for telling me about DSA_LOOP, I've tested several DSA tagging protocols 
with the RZN1 GMAC1 hardware using this method. Here's what I found in a 
nutshell:

For tagging protocols that change the EtherType field in the MAC header (e.g. 
DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105): On TX the tagged frames are 
almost always ignored by the checksum offload engine and IP header checker of 
the MAC device. I say "almost always" because there is an 
unlikely but nasty corner case where a DSA tag can be identical to an IP 
EtherType value. In these cases, the frame will likely fail IP header checks 
and be dropped by the MAC.

Ignoring these corner cases, the DSA frames will egress with a partial 
checksum and be dropped by the recipient. On RX, these frames will, once again, 
not be detected as IP frames by the MAC. So they will be transmitted to the CPU. 
However, the stmmac driver will assume (wrongly in this case) that
these frames' checksums have been verified by the MAC. So it will set 
CHECKSUM_UNECESSARY:

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5493
 
And so the IP/TCP checksums will not be checked at all, 
which is not ideal.

There are other DSA tagging protocols which cause different issues. For example 
DSA_TAG_PROTO_BRCM_PREPEND, which seems to offset the whole MAC header, and 
DSA_TAG_PROTO_LAN9303 which sets ETH_P_8021Q as its EtherType. I haven't dug too 
deeply on these issues yet, since I'd rather deal with the checksumming issue 
before getting distracted by VLAN offloading and other stuff.

Among the tagging protocols I tested, the only one that didn't cause any issues 
was DSA_TAG_PROTO_TRAILER, which only appends stuff to the frame.

TLDR: The simplest solution seems to be to modify the stmmac TX and RX paths to 
disable checksum offloading for frames that have a non-IP ethertype in 
their MAC header. This will fix the checksum situation for DSA tagging protocols 
that set non-IP and non-8021Q EtherTypes. Some edge cases like 
DSA_TAG_PROTO_BRCM_PREPEND and DSA_TAG_PROTO_LAN9303 will require a completely 
different solution if we want these MAC devices to handle them properly.
Please share any thoughts you might have on this suggestion.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

