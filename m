Return-Path: <stable+bounces-172922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637EB35725
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B518D2A13EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1582FC86C;
	Tue, 26 Aug 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LWnzIXee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tRjjHYFW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BkhEO0qL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o9Rnci4i"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A142FC867
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197346; cv=none; b=fb9mIiFag01DcIed/lIF7eX0z5GDItrwPd/HUbzDDJhQJ/a1IPFgQfhiIcbVQCf5IdEthb555y4c6MqgL84hyYUo5SJ/nBl++94zEGrOed4VsNbAWt0K0rb5wu5Zs2dUlxBXIE5CLGvrZ3JF1JVFyY3zThfkNXMKghtK+nZqW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197346; c=relaxed/simple;
	bh=fUS6OtbYrLmoRaY7JSZtWng8prLoGctHMb1dUP3alME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWLe/mJuNqr+3t5VQDNT+ghoD95sPqgglI4K/EzzTcAO6fSiL85HlSHM2hpKPeIyYyt2u0Z9Qmmlg2ZMRlVmvv4WFEFA1Gfo3uc3+S0lAC3SxsGXcw1PrhdUl+Y1uLKExMHEA2A9TlFfXPI1paSQCbGvCinx9VU/6KTXVQdCjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LWnzIXee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tRjjHYFW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BkhEO0qL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9Rnci4i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD3D92120C;
	Tue, 26 Aug 2025 08:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756197343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHKsUzzxZm5K3EIZT6z287s6v96pFtzqZHd1wpk6TpM=;
	b=LWnzIXeenph3BMz5+gXjhU8YY/bqG9LtRtR9MRQFbZJtkBy/G+9fe5mU6rkfejuDSuMjvT
	axQJnFNLNewUqJjoGPtn9NVqeE5fYBxHONKeBmwmqBOx57z09JNeaFr84dDyTIqMTf9C/i
	rvEraAWzI+DWXosfmnwMisdhWNge31E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756197343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHKsUzzxZm5K3EIZT6z287s6v96pFtzqZHd1wpk6TpM=;
	b=tRjjHYFWmr6SxISznVyCI10VPcYQwQkRtLfd+NhCPmwyMgCdTwAsiIX8jKHnqvdthYwnjW
	+JL85c5ma7vQXTCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756197342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHKsUzzxZm5K3EIZT6z287s6v96pFtzqZHd1wpk6TpM=;
	b=BkhEO0qL+fBcLNmT00fIz++vQx1ER1MVWTFtShSwv/z7wh7Dcjya5NKlHdwILsOTlzvmu6
	EwoIIPWOnO191US+QQ/gOK7w8PwYTwU/lNh6ctWbIzN5vzjvl1Ped7+33pRzzVCVB1i6dH
	XOZ/cVknAAhe9tLqoeMG2DOgFbh1tJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756197342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHKsUzzxZm5K3EIZT6z287s6v96pFtzqZHd1wpk6TpM=;
	b=o9Rnci4iE+NYXjZEJGyC7Dk6kDWhNbSvBm/MWNn6U6HpAmdfbBVftnt/qO3MZE6NvV0Sk+
	y85pUuQn3SXR76BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF5E613A51;
	Tue, 26 Aug 2025 08:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CwRoMN1xrWhZUAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 26 Aug 2025 08:35:41 +0000
Message-ID: <1ecd4a9a-d685-4bce-ad06-cc8878f0a165@suse.de>
Date: Tue, 26 Aug 2025 11:35:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
To: Jakub Kicinski <kuba@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
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
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, stable@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-2-svarbanov@suse.de>
 <20250825165310.64027275@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250825165310.64027275@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Hi Jakub,

On 8/26/25 2:53 AM, Jakub Kicinski wrote:
> On Fri, 22 Aug 2025 12:34:36 +0300 Stanimir Varbanov wrote:
>> In case of rx queue reset and 64bit capable hardware, set the upper
>> 32bits of DMA ring buffer address.
>>
>> Cc: stable@vger.kernel.org # v4.6+
>> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to handle RX errors")
>> Credits-to: Phil Elwell <phil@raspberrypi.com>
>> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index ce95fad8cedd..36717e7e5811 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
>>  		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
>>  
>>  		macb_init_rx_ring(queue);
>> -		queue_writel(queue, RBQP, queue->rx_ring_dma);
>> +		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>> +			macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
>> +#endif
>>  
>>  		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
>>  
> 
> Looks like a subset of Théo Lebrun's work:
> https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.com/
> let's wait for his patches to get merged instead?

No objections for this patch, it could be postponed. But the others from
the series could be applied.

regards,
~Stan



