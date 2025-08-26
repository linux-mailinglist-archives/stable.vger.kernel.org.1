Return-Path: <stable+bounces-172929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED75B358A4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F825E180C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C43019D2;
	Tue, 26 Aug 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2PdBgyoO"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391882FE069;
	Tue, 26 Aug 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199691; cv=none; b=afpcio4jFrfT8dAq8iqupr75CtI2r4vvA7RYTVXmV/7cTrdId1M3pCmUPpYb9FjKQa/P5Q1+9mnsqKrnnaAdjKNxeQu1wS8xdjEOqQ54PZjq+U7UXzz+Wy/ZjKNRugbKbYm5tWvz4v+d8j7wULCLIbspbt4mdtbmoozt7Bdew0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199691; c=relaxed/simple;
	bh=Lxn6j1kzDkH/WTga4d/2k5vCxhia+Sp6of3N/hIKY/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sJildRD5ULu5Y38MAJ9Yi1qcvhhW7XxxGkHTW3GdFu/p9x7A+ziULO5Jp4oeS5UjozAk6YJnsaOWc3d1ATrqgc3TxrFLdao+ShMi5cChg3uAPmUFf4vn4aGC9Lfb4oVsEKwb4VFhRcw5RM4uJUO8o4O8D3SoDjgQ5u3DogEH7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2PdBgyoO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756199690; x=1787735690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lxn6j1kzDkH/WTga4d/2k5vCxhia+Sp6of3N/hIKY/s=;
  b=2PdBgyoOHoV6cSjJpGWLXaXxW7Vezpp3hUiDEH8DGKYCAXK5f23ZuJA7
   sYUJKLxGrXlSdVb8LRKRDgihmyOUplqjMWQvLq5qUGvH0hcIcsrNm4Bkz
   c56vN3XS2M3ZcezIO0dm0p+Xy+/hTMasB57sKcA/2hgcTjI7xGQitQ1C7
   GQ5AVuz7Y7P7uxgln1HgZk7SzMjfNrKSI6mawan+MZnS4BBYr8lA1ksRH
   HKI2fHiCFmX0zWdMQxeqNqgUScIg+hgovPNgk1ANRS1suU69nW2otoRqT
   MG1fhAy9m/5gmDDYIcYEMLbWhrRw9hfdKpP8lxjSWC2pdhFMSquCi8inw
   A==;
X-CSE-ConnectionGUID: oz5noQKVS6yv1ppRAce+jQ==
X-CSE-MsgGUID: k1iAyTw3SpukqoVYCbsjww==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213074774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 02:14:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 02:14:23 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 02:14:19 -0700
Message-ID: <3bccf773-abd6-4ade-a1c5-99f2a773b723@microchip.com>
Date: Tue, 26 Aug 2025 11:14:18 +0200
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Andrea della Porta
	<andrea.porta@suse.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil
 Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>, <stable@vger.kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-2-svarbanov@suse.de>
 <20250825165310.64027275@kernel.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250825165310.64027275@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/2025 at 01:53, Jakub Kicinski wrote:
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
>>                macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
>>
>>                macb_init_rx_ring(queue);
>> -             queue_writel(queue, RBQP, queue->rx_ring_dma);
>> +             queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +             if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>> +                     macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
>> +#endif
>>
>>                macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
>>
> 
> Looks like a subset of Théo Lebrun's work:
> https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.com/
> let's wait for his patches to get merged instead?

Yes, we can certainly wait. As RBOPH changes by Théo are key, they will 
probably remove the need for this fix altogether: but I count on you 
Stanimir to monitor that (as I don't have a 64 bit capable platform at 
hand).

Best regards,
   Nicolas


