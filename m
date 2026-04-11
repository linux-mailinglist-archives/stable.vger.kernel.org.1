Return-Path: <stable+bounces-235717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GY0DeY/2mmFzQgAu9opvQ
	(envelope-from <stable+bounces-235717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AE3DFEE0
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C52C3025738
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915591A0B15;
	Sat, 11 Apr 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rOhNADDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBB19DF62
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910861; cv=none; b=Ei2VOfmCG6v0UVENfupolYAEzYDVUa6IeVhPZvKqTWFGkoI2hcuV2XZVURxqcDZxYos9GdgF/rX8L/sFnc0nc+e7qYw9usdmU6kMcgJaEw6RmElcJdNvNTvH2Ujki+Sgx4JO/LaOyznmxZ2QpMZDW84ugoMcj7tf1WP7Drnv+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910861; c=relaxed/simple;
	bh=X2t+yaYaZsutfPKPYxoJOyLmkjJDQRmkMhOU64B+e08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRPYo08OqASRHBFn608pUPe7OcA0DvcKMxlGQoudE0mbtqKX+ZkDOL9mCA21Xav1gE2JoV7Hwqn1wHVM0F6qPIgmhBjInxs5DUNDAHR7MJt4dowPWOjoU6ZwyODYaYH3wOfJzPbBK9glhck2aF9T3b0KZhgjzj65JLZf2hAn/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rOhNADDy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso2990402f8f.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775910857; x=1776515657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOxwujemq0kL/KQS4PJuYHJAL6Vzf+e3T0xcOOritGk=;
        b=rOhNADDytYjBJ0HRjp4nibc9ez03YXhjeGHbXTlXTjyjRtJNLbvlk3GFbK4i8b5ts7
         A1GlMblsSiWBVqIeO+Un65Xi6Jbb2NKQyGus/4Ou9ojVosrh6wJ4F7s77Ivd100Zpgw2
         zxDt6/RSl1WWduVoAPBFd+Qi6rufr+FC5WrRyKUCpl//mIX3fcKya2aj+/10l7yEmTgC
         2Pbhl8BT4z04vS3tQIrssLu58FawoX4hSrhQZBpNM1GWEkBoJGPRSY4yoeMSqDimDDpg
         6rwk2uCn8K0PiSEd/EsMhO7RYRt/LlHAmEdBmoA261VAbOScc5UPXrKpNpIuIQkFZNgH
         Vecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910857; x=1776515657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOxwujemq0kL/KQS4PJuYHJAL6Vzf+e3T0xcOOritGk=;
        b=S7365JCANk2NH8kXifxb+oEoLcEu4uuUTAYMKzno7DXzaqZa3cdx2jLwnNiuXwcsZ6
         hH/26Z9j/TLZc+RnO7fChg8nTwzt+QCNP8n0A1Y3gvoGldFoGv7/RTu7IAKIlVT4FVFY
         f2Yvs6rl+Y0PHRFEI2L1ZwWQagnatI3pvdHi+NiucWYGF3N5b2L/5xfFrrez65WpbZYN
         SeVznLa35rxupdzhCxjcwNx1gTHQGd+OgO2EyanS1bWJFzFxvLuLkKlCyZLuROhxvPxD
         kbdnlx95NkX9E05wlwOvqbpIWcF1ZbZzavMl9YdskMOnTF3944bMArAzPzW5PhkY9A9z
         Y7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVbV0kN+CfvZpo3bi8ug44uJR8Tbc+sm4IuepUssNSo/YWrusOr/MY11+SpHHNj/e/kdyOKm7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eoRMABmtrOutmyjH/faWAIu7fTFkfxhdlNQzTpwVOTotzHRK
	oh8nN3Cbhn/l1nmiqlcpKzdrWmzGHbwFP8gahG3ZbSg6cvi5eJIgpTPEXOt9fowFUaw=
X-Gm-Gg: AeBDiesCOrxfal9QC0AF8s/PkmFpV57hSQX4i1T4ZJSf3GnbiSkD0EDtxM/gT9z+WP7
	sOh/KQ1blnjd/cfg5h0Re85wAf7PBjeEKC1BcoGjhXmUUZp2xyPcqz1pTfW05dUBZZ1oseQno3f
	y6qjhyvutPCMrZb8vMm/5W8uNiG0xbX8OrGXTGVWlvYDtfghRBWb6O7qidb7mt/9iMjhL/kdH7I
	2jQ2yWuAtbFlUW7kXLJbsnCdmwPKnctMfs0Ppd6c7DMgYUj4PVnH8Chc4ZUehZIUGNIRm7EL32d
	YFFi5hr1fZUkg76LRki9Yuh73+5yPfeqFdfE9ZPgZqb93Y9wkY5PQpfAr4bRN39Mld+qPT18jIS
	pF6CtatefbpYZq8Z1N8WnxK7tq+bsXfzTdG5xAkyXSYRV3kPcml48/9AuNH2daQ0XRn2Cwcfhbv
	pjl55ZZcI8YvJ0vAy0vooIdk/zLgbfOIc=
X-Received: by 2002:a05:6000:40c8:b0:439:be67:a038 with SMTP id ffacd0b85a97d-43d642d47f7mr9826259f8f.41.1775910856868;
        Sat, 11 Apr 2026 05:34:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5ccdasm16450654f8f.34.2026.04.11.05.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 05:34:16 -0700 (PDT)
Message-ID: <1932cc15-0ced-4e0a-8034-98ee78f370a2@tuxon.dev>
Date: Sat, 11 Apr 2026 15:34:14 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Long Luu <long.luu.ur@renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-2-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346F56B1A311E46053EDB3486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346F56B1A311E46053EDB3486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235717-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,renesas.com:email,tuxon.dev:dkim,tuxon.dev:email,tuxon.dev:mid,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 934AE3DFEE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/11/26 15:17, Biju Das wrote:
> 
>> -----Original Message-----
>> From: Claudiu<claudiu.beznea@tuxon.dev>
>> Sent: 11 April 2026 12:43
>> Subject: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
>>
>> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>>
>> Once the interrupt is requested, the interrupt handler may run immediately.
>> Since the IRQ handler can access channel->ch_base, which is initialized only after requesting the IRQ,
>> this may lead to invalid memory access.
>> Likewise, the IRQ thread may access uninitialized data (the ld_free, ld_queue, and ld_active lists),
>> which may also lead to issues.
>>
>> Request the interrupts only after everything is set up. To keep the error path simpler, use
>> dmam_alloc_coherent() instead of dma_alloc_coherent().
>>
>> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - none, this patch is new
>>
>>   drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
>>   1 file changed, 33 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 625ff29024de..9f206a33dcc6
>> 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>>   	channel->index = index;
>>   	channel->mid_rid = -EINVAL;
>>
>> -	/* Request the channel interrupt. */
>> -	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
>> -	irq = platform_get_irq_byname(pdev, pdev_irqname);
>> -	if (irq < 0)
>> -		return irq;
>> -
>> -	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
>> -				 dev_name(dmac->dev), index);
>> -	if (!irqname)
>> -		return -ENOMEM;
>> -
>> -	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
>> -					rz_dmac_irq_handler_thread, 0,
>> -					irqname, channel);
>> -	if (ret) {
>> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
>> -		return ret;
>> -	}
>> -
>>   	/* Set io base address for each channel */
>>   	if (index < 8) {
>>   		channel->ch_base = dmac->base + CHANNEL_0_7_OFFSET + @@ -1012,9 +993,9 @@ static int
>> rz_dmac_chan_probe(struct rz_dmac *dmac,
>>   	}
>>
>>   	/* Allocate descriptors */
>> -	lmdesc = dma_alloc_coherent(&pdev->dev,
>> -				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
>> -				    &channel->lmdesc.base_dma, GFP_KERNEL);
>> +	lmdesc = dmam_alloc_coherent(&pdev->dev,
>> +				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
>> +				     &channel->lmdesc.base_dma, GFP_KERNEL);
>>   	if (!lmdesc) {
>>   		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
>>   		return -ENOMEM;
>> @@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>>   	INIT_LIST_HEAD(&channel->ld_free);
>>   	INIT_LIST_HEAD(&channel->ld_active);
>>
>> -	return 0;
>> +	/* Request the channel interrupt. */
>> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
>> +	irq = platform_get_irq_byname(pdev, pdev_irqname);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
>> +				 dev_name(dmac->dev), index);
>> +	if (!irqname)
>> +		return -ENOMEM;
>> +
>> +	ret = devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
>> +					rz_dmac_irq_handler_thread, 0,
>> +					irqname, channel);
>> +	if (ret)
>> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> As per [1], it is redundant.
> 
> [1]
> https://elixir.bootlin.com/linux/v7.0-rc7/source/kernel/irq/devres.c#L108

This is a fix patch, it just moves code around, intended to be backported to 
older kernels (e.g. v6.1, v6.12). However devm_request_result() is introduced in:

commit 55b48e23f5c4
Author: Pan Chuang <panchuang@vivo.com>
Date:   Tue Aug 5 17:29:22 2025 +0800

     genirq/devres: Add error handling in devm_request_*_irq()

     devm_request_threaded_irq() and devm_request_any_context_irq() currently
     don't print any error message when interrupt registration fails.

     This forces each driver to implement redundant error logging - over 2,000
     lines of error messages exist across drivers. Additionally, when
     upper-layer functions propagate these errors without logging, critical
     debugging information is lost.

     Add devm_request_result() helper to unify error reporting via dev_err_probe(),

     Use it in devm_request_threaded_irq() and devm_request_any_context_irq()
     printing device name, IRQ number, handler functions, and error code on failure
     automatically.

     Co-developed-by: Yangtao Li <frank.li@vivo.com>
     Signed-off-by: Yangtao Li <frank.li@vivo.com>
     Signed-off-by: Pan Chuang <panchuang@vivo.com>
     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
     Link: https://lore.kernel.org/all/20250805092922.135500-2-panchuang@vivo.com

And it is not present in v6.1, v6.12 kernels.

To have a clean backport (at least to the above mentioned kernel versions), 
would be better to have the alignment to devm_request_result() done in a later 
cleanup patch.

Thank you,
Claudiu

