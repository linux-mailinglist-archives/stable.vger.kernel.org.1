Return-Path: <stable+bounces-9015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66168206BC
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 15:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C541F21A4A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E28C0B;
	Sat, 30 Dec 2023 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8mrjQsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212308F44;
	Sat, 30 Dec 2023 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso35423645e9.0;
        Sat, 30 Dec 2023 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703945880; x=1704550680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+R7KcpxGcAae88uSpjAc6ssjrL8q0BN+mmyQ7vBRz9g=;
        b=h8mrjQsGPyYMl0cgNE5J7F7fysHKLk0NIij17zQhT1m84uMwhvmu8gXnAwoq28sCFZ
         yHWks60XYFgDH4SIuOSbbLpKmT7WLgOfPIPBqCrXF/2Bi72GXlzuETenBzfweRv/O+MF
         bsk5li3cMt+dCxKX1MQ0zN7wbwQ6anuGaTKnhCDjhDESJwxjWJio975sIRYqZnAkhMUv
         rtMjpunG0qvl1bSKSBJNK50NuMvsqOWwW3oZfiPhhfgTKmne524krqDnSV8AaKCJ/cWN
         J01Eoo4HUSKLYfQ+HQ2Q99UOtovUjjVt7HPCZVmJtaw4GZzKDZcKadvNW4RTlse7Dq58
         FLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703945880; x=1704550680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R7KcpxGcAae88uSpjAc6ssjrL8q0BN+mmyQ7vBRz9g=;
        b=F6BJQ/+QSeaJb+d/p3HB3ihCxd0OzNn1jU+jLgOTGe600uGDyKQkKDOjWzLdajUvAL
         hTwrAiLC01C1WKO913ANLeTTlB8SP3aOp4LgZ4hUWw4ih13LzF89LMCps7p5+7ixME2c
         /LJHR/91dKCGGmRoYKt+rdLmq4MZvqVY7DYK05xwTOTr9MQ/Qk33Vh6tKCSbKv4y2h+y
         u2tABUJnOxZIRxnRQDhem+tI68fYf9WJPDllO89AxBSPebbYmDArPUvBw4UnFBbeHK71
         ARuYifI/LZoDoBD4QhIJbPQ/vEUgLhY5eUh7T7Hy20+1lTEUsvh+oVIs//+HpNzzBcdz
         a/kQ==
X-Gm-Message-State: AOJu0YyVrO2p1Wtqj5JmSEAsU1ExUBadfEyw80iQDkLqzZWqUX0z2xCC
	m1XjpRc22O42i34GffWXa4M=
X-Google-Smtp-Source: AGHT+IF38+ihYGwQE2jKo23+QfWOtlZ4bwiC5hfRHRKW7Fyl+Q7HblyNWNrqoYgvjxB6zQ8/dJ+5Ng==
X-Received: by 2002:a05:600c:3581:b0:40d:5cd2:fce2 with SMTP id p1-20020a05600c358100b0040d5cd2fce2mr3059562wmq.23.1703945879967;
        Sat, 30 Dec 2023 06:17:59 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b0040d5f466deesm12179997wmo.38.2023.12.30.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 06:17:59 -0800 (PST)
Date: Sat, 30 Dec 2023 16:17:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20231230141757.vof2lle75vusahgf@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com>
 <20231219122034.pg2djgrosa4irubh@skbuf>
 <3b53aa8a-73e9-9260-f05b-05dac80a4276@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b53aa8a-73e9-9260-f05b-05dac80a4276@bootlin.com>

On Fri, Dec 29, 2023 at 05:11:48PM +0100, Romain Gantois wrote:
> Thanks for telling me about DSA_LOOP, I've tested several DSA tagging protocols 
> with the RZN1 GMAC1 hardware using this method. Here's what I found in a 
> nutshell:

Good job exploring the complexity of the problem in depth.

> For tagging protocols that change the EtherType field in the MAC header (e.g. 
> DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105): On TX the tagged frames are 
> almost always ignored by the checksum offload engine and IP header checker of 
> the MAC device. I say "almost always" because there is an 
> unlikely but nasty corner case where a DSA tag can be identical to an IP 
> EtherType value. In these cases, the frame will likely fail IP header checks 
> and be dropped by the MAC.

Yes, there are a few poorly designed DSA tagging formats where arbitrary
fields overlap with what the conduit interface sees as the EtherType field.
We don't design the tagging formats, as they are proprietary (except for those
derived from tag_8021q), we just support them. In some cases where the
switch has permitted that, we have implemented dynamic changing of
tagging protocols (like 'echo edsa > /sys/class/net/eth0/dsa/tagging')
in order to increase the compatibility between a particular switch and
its conduit interface. And where the compatibility with the default
tagging protocol was beyond broken, we accepted an alternative one
through the 'dsa-tag-protocol' device tree property.

> Ignoring these corner cases, the DSA frames will egress with a partial 
> checksum and be dropped by the recipient. On RX, these frames will, once again, 
> not be detected as IP frames by the MAC. So they will be transmitted to the CPU. 
> However, the stmmac driver will assume (wrongly in this case) that
> these frames' checksums have been verified by the MAC. So it will set 
> CHECKSUM_UNECESSARY:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5493
>  
> And so the IP/TCP checksums will not be checked at all, which is not
> ideal.

Yup, this all stems from the fact that DSA inherits the checksum offload
features of the conduit (stmmac) from its vlan_features. People think
that vlan_features are inherited only by VLAN upper interfaces, but that
is not the case. Confusingly, in some cases, offloading NETIF_F_IP_CSUM |
NETIF_F_IPV6_CSUM really does work (Broadcom conduit + Broadcom switch,
Marvell conduit + Marvell switch, etc), so we can't remove this mechanism.
But it uncovers lack of API compliance in drivers such as the stmmac,
which is why it is a fragile mechanism.

> There are other DSA tagging protocols which cause different issues. For example 
> DSA_TAG_PROTO_BRCM_PREPEND, which seems to offset the whole MAC header, and 
> DSA_TAG_PROTO_LAN9303 which sets ETH_P_8021Q as its EtherType. I haven't dug too 
> deeply on these issues yet, since I'd rather deal with the checksumming issue 
> before getting distracted by VLAN offloading and other stuff.

I agree that what brcm-prepend does - shifting the entire frame to the
right by 4 octets - sounds problematic in general (making the conduit
see the EtherType as octets [3:2] of the original MAC SA). But you also
need to take a look at where those protocols are used, and if that is
relevant in any way to the stmmac.

	/* Broadcom BCM58xx chips have a flow accelerator on Port 8
	 * which requires us to use the prepended Broadcom tag type
	 */
	if (dev->chip_id == BCM58XX_DEVICE_ID && port == B53_CPU_PORT) {
		dev->tag_protocol = DSA_TAG_PROTO_BRCM_PREPEND;
		goto out;
	}

From what I understand, DSA_TAG_PROTO_BRCM_PREPEND is only used
internally within Broadcom SoCs, so it seems likely that it's not
designed with generic compatibility in mind.

As for DSA_TAG_PROTO_LAN9303, let me guess what the problem was. TX was
fine, but on RX, the packets got dropped in hardware before they even
reached the stmmac driver, because it declares NETIF_F_HW_VLAN_CTAG_FILTER |
NETIF_F_HW_VLAN_STAG_FILTER as features, and the DSA tags effectively
look like unregistered VLAN traffic.

That is certainly an area where the lan9303 support can be improved.
Other VLAN-based taggers like tag_8021q perform vlan_vid_add() calls on
the conduit interface so that it won't drop the traffic even when it
uses hardware VLAN filtering.

> Among the tagging protocols I tested, the only one that didn't cause any issues 
> was DSA_TAG_PROTO_TRAILER, which only appends stuff to the frame.

It's very curious that you say this. Tail taggers are notoriously
problematic, because while the conduit will perform the checksum offload
function on the packets, the checksum calculation goes until the very end
of the frame. Thus, that checksum will be wrong after the switch consumes
the tail tag (and does not update the L4 checksum).

There is no way to overcome that except to not inherit any checksum
offload features for tail taggers. But that would break some other thing,
so we opted for having this line in the xmit procedure of tail taggers:

	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
		return NULL;

But apparently we have been inconsistent in applying this to trailer_xmit()
as well. So DSA_TAG_PROTO_TRAILER should actually be a case of "checksum
is computed, but is incorrect after tag stripping", but you say that it
was the only one that worked fine.

> TLDR: The simplest solution seems to be to modify the stmmac TX and RX paths to 
> disable checksum offloading for frames that have a non-IP ethertype in 
> their MAC header. This will fix the checksum situation for DSA tagging protocols 
> that set non-IP and non-8021Q EtherTypes. Some edge cases like 
> DSA_TAG_PROTO_BRCM_PREPEND and DSA_TAG_PROTO_LAN9303 will require a completely 
> different solution if we want these MAC devices to handle them properly.
> Please share any thoughts you might have on this suggestion.

I think the overall idea is correct, with the small mentions of "let's
ignore brcm-prepend" and "lan9303 should work, maybe it's just a case of
disabling the VLAN filtering features through ethtool and testing again?".

