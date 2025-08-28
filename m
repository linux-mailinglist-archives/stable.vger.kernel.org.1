Return-Path: <stable+bounces-176576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C10B396F6
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FF0169122
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96D2E22AC;
	Thu, 28 Aug 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VVDi/G5o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H7wpXe7r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VVDi/G5o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H7wpXe7r"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E82E091C
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369754; cv=none; b=p67wAgjGUFsWnii2iJhTJt8wk/hZWDdArdTdc01dM+lohW8KVUB1mvmeFaKNarVM2AL0lCzpEl1x9O3QIgB9gT7Upm0Ps3ioD1LKozonecJVko0b+1JwJRgIoFHoor2QsXN8aIUFHyp9DVrhdneUQUsZn+XNNZliOhHpeqF7T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369754; c=relaxed/simple;
	bh=V7L/Y1uMzsklxnPAh214IOx2VcFlUksjl6zQ/Oiy5rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KufUXavsi3CM1qDwTfoPtKr5/PjtzLHVx0+VWxO/qdNZQLLGERhRKwtcLHe+FxHF2TH0ifxMGn2zynkdarG3T6qv2aJN3MIYXoWNncdy3ivZ7r4cV7dfGFjo29p27XrzWGlkEo2/WeqDAGimuwG5jivhWPZpO1RazGYnMfWaoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VVDi/G5o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H7wpXe7r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VVDi/G5o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H7wpXe7r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6851A222FE;
	Thu, 28 Aug 2025 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756369744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOlr6C5vhqa1kxYAAqtfuSRSBiOOy3yEM6QLgnHqjqQ=;
	b=VVDi/G5o8C1V6YAUebvIHQxNyDxcUqhryqx39L9fB3EQ7nFKvJHpSzQzgC26KTHMNhUkzO
	5r8H0JU3IyYH2T6EPcu8JnnitMnRQ9IrF9aMRW8OsrDo1V8007Am8yVqa9lZhTGbFw4UVH
	NASV6+R0bI4EXjA663yPVGRYuy2es5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756369744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOlr6C5vhqa1kxYAAqtfuSRSBiOOy3yEM6QLgnHqjqQ=;
	b=H7wpXe7rcDLkp5HsTMTb0+OLJJAAbCglgDyy+bXScDGYpg4BuYttPj/7BoDiP4mPPwWNQd
	0Xk4fLj0s/44NcAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="VVDi/G5o";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H7wpXe7r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756369744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOlr6C5vhqa1kxYAAqtfuSRSBiOOy3yEM6QLgnHqjqQ=;
	b=VVDi/G5o8C1V6YAUebvIHQxNyDxcUqhryqx39L9fB3EQ7nFKvJHpSzQzgC26KTHMNhUkzO
	5r8H0JU3IyYH2T6EPcu8JnnitMnRQ9IrF9aMRW8OsrDo1V8007Am8yVqa9lZhTGbFw4UVH
	NASV6+R0bI4EXjA663yPVGRYuy2es5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756369744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOlr6C5vhqa1kxYAAqtfuSRSBiOOy3yEM6QLgnHqjqQ=;
	b=H7wpXe7rcDLkp5HsTMTb0+OLJJAAbCglgDyy+bXScDGYpg4BuYttPj/7BoDiP4mPPwWNQd
	0Xk4fLj0s/44NcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4116D13326;
	Thu, 28 Aug 2025 08:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0QNDU8TsGhoKwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 28 Aug 2025 08:29:03 +0000
Message-ID: <1fc287a8-4b90-439e-8562-35c093d92ff5@suse.de>
Date: Thu, 28 Aug 2025 11:29:02 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, stable@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-2-svarbanov@suse.de>
 <20250825165310.64027275@kernel.org>
 <3bccf773-abd6-4ade-a1c5-99f2a773b723@microchip.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <3bccf773-abd6-4ade-a1c5-99f2a773b723@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6851A222FE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01



On 8/26/25 12:14 PM, Nicolas Ferre wrote:
> On 26/08/2025 at 01:53, Jakub Kicinski wrote:
>> On Fri, 22 Aug 2025 12:34:36 +0300 Stanimir Varbanov wrote:
>>> In case of rx queue reset and 64bit capable hardware, set the upper
>>> 32bits of DMA ring buffer address.
>>>
>>> Cc: stable@vger.kernel.org # v4.6+
>>> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue
>>> to handle RX errors")
>>> Credits-to: Phil Elwell <phil@raspberrypi.com>
>>> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/
>>> ethernet/cadence/macb_main.c
>>> index ce95fad8cedd..36717e7e5811 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue,
>>> struct napi_struct *napi,
>>>                macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
>>>
>>>                macb_init_rx_ring(queue);
>>> -             queue_writel(queue, RBQP, queue->rx_ring_dma);
>>> +             queue_writel(queue, RBQP, lower_32_bits(queue-
>>> >rx_ring_dma));
>>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>> +             if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>> +                     macb_writel(bp, RBQPH, upper_32_bits(queue-
>>> >rx_ring_dma));
>>> +#endif
>>>
>>>                macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
>>>
>>
>> Looks like a subset of Théo Lebrun's work:
>> https://lore.kernel.org/all/20250820-macb-fixes-
>> v4-0-23c399429164@bootlin.com/
>> let's wait for his patches to get merged instead?
> 
> Yes, we can certainly wait. As RBOPH changes by Théo are key, they will
> probably remove the need for this fix altogether: but I count on you
> Stanimir to monitor that (as I don't have a 64 bit capable platform at
> hand).

Sure I will monitor those series. Unfortunately I also don't have MACB
64bit platform, I only have GEM.

regards,
~Stan


