Return-Path: <stable+bounces-179209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FFDB51E65
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019C43B2454
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F6B2874E6;
	Wed, 10 Sep 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1gbJxRWG"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050122EE5;
	Wed, 10 Sep 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523474; cv=none; b=D1OR2RW4akAWM+g7csyHOkKgTKATq+gfJ8CXtN3LanC7YtUAeR7OMdoM4V4eH08B/UBTM13ZDDZa4ydfWXVAGBkUA7yvvwmB29FVLFS87uESrKtKEI+za1tjjJuETk/2wX9MXelh3UYc2MBv04Xyc948FeZ73IiVMNvAbcfH8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523474; c=relaxed/simple;
	bh=DtE9miUBQAJCy5AeiKeGehsF4pgnBKqNW9ryVVfwaFE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=uC8py6FxbqSB60BcP35rw2mwr/KN/d9SaAWVvzsfCTHOf2MQnQp94Lb86BNs6Cql0DOQaUN2kvIDyAFtQoHZhYOhD5lCbUJrdDmimZpk1zUqhecgtGr5FeaiaPRP4EFgF5brRwXht1J7dm4vtvC2sitfa4CthB51awc+mnN+OSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1gbJxRWG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 10E411A0D5A;
	Wed, 10 Sep 2025 16:57:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6122606D4;
	Wed, 10 Sep 2025 16:57:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E431C102F2833;
	Wed, 10 Sep 2025 18:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757523468; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4szWPvO4QJK7QXpJTUGbKS9tON103WxwvOm5NDrmuMM=;
	b=1gbJxRWG9xSsrPgDIudnpxMmPnmBcGhPlleMVERqlMGN5PBPGFylksL/5CZ5YKfw82vclr
	pN87gSozbGFw7JoU0OsC2FGCzPXsr7nayyyqXutREb4U2rhCcW/hfNWsLCIbfxyEptcaJO
	NpaaRyXPWzG3yhXSYCWajaowwzfZvQ/J7FrhkSeqfW1qJqtq9UD5LeU02UzPANnRlz/0mK
	1O7Bfu4cKF4BdQdrWALzTiA6PlOw7Pp8hDf5Nbx9Oi7hLToIeQIjrZh4lbhSQXl1VSbcR5
	7DjUCQbZcG2txaupiwFZ053mN+AWnhmbgdzfIKXGrpnwhz6tM3zRdIRxo8WOOA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 18:57:23 +0200
Message-Id: <DCPA2BR78XM8.HWKZZ8WQF3S8@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Andrea della Porta"
 <andrea.porta@suse.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Phil
 Elwell" <phil@raspberrypi.com>, "Jonathan Bell" <jonathan@raspberrypi.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>,
 <stable@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>
To: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Stanimir Varbanov" <svarbanov@suse.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-2-svarbanov@suse.de>
 <20250825165310.64027275@kernel.org>
 <3bccf773-abd6-4ade-a1c5-99f2a773b723@microchip.com>
In-Reply-To: <3bccf773-abd6-4ade-a1c5-99f2a773b723@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolas, Jakub, Stanimir,

On Tue Aug 26, 2025 at 11:14 AM CEST, Nicolas Ferre wrote:
> On 26/08/2025 at 01:53, Jakub Kicinski wrote:
>> On Fri, 22 Aug 2025 12:34:36 +0300 Stanimir Varbanov wrote:
>>> In case of rx queue reset and 64bit capable hardware, set the upper
>>> 32bits of DMA ring buffer address.
>>>
>>> Cc: stable@vger.kernel.org # v4.6+
>>> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to=
 handle RX errors")
>>> Credits-to: Phil Elwell <phil@raspberrypi.com>
>>> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>=20
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index ce95fad8cedd..36717e7e5811 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
>>>                macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
>>>
>>>                macb_init_rx_ring(queue);
>>> -             queue_writel(queue, RBQP, queue->rx_ring_dma);
>>> +             queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dm=
a));
>>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>> +             if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>> +                     macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ri=
ng_dma));
>>> +#endif
>>>
>>>                macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
>>>
>>=20
>> Looks like a subset of Th=C3=A9o Lebrun's work:
>> https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootli=
n.com/
>> let's wait for his patches to get merged instead?
>
> Yes, we can certainly wait. As RBOPH changes by Th=C3=A9o are key, they w=
ill=20
> probably remove the need for this fix altogether: but I count on you=20
> Stanimir to monitor that (as I don't have a 64 bit capable platform at=20
> hand).

I when looking for where this patch came from.
Commit in the raspberrypi downstream kernel:
https://github.com/raspberrypi/linux/commit/e45c98decbb16e58a79c7ec6fbe4374=
320e814f1

It is somewhat unreadable; the only part that seems related is the:

> net: macb: Several patches for RP1
> 64-bit RX fix

 - Is there any MACB hardware (not GEM) that uses 64-bit DMA
   descriptors? What platforms? RPi maybe?

 - Assuming such a platform exists, the next question is why does
   macb_rx() need to reinit RBQPH/0x04D4. It reinits RBQP/0x0018
   because it is the buffer pointer and increments as buffers get used.

   To reinit RBQPH would be for the case of the increment overflowing
   into the upper 32-bits. Sounds like a reasonable fix (for a really
   rare bug) if that hardware actually exists.

   This wouldn't be needed on GEM because RBQPH is shared across queues.
   So of course RBQPH would not increment with the buffer pointer.

If this patch is needed (does HW exist?), then my series doesn't address
it. I can take the patch in a potential V6 if you want. V5 got posted
today [0].

[0]: https://lore.kernel.org/lkml/20250910-macb-fixes-v5-0-f413a3601ce4@boo=
tlin.com/

Thanks,
Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


