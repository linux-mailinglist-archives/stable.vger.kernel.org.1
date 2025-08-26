Return-Path: <stable+bounces-172928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E5B35889
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB24B5E08D3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EAC303CBE;
	Tue, 26 Aug 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EN5txnML"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A72FB97D;
	Tue, 26 Aug 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199623; cv=none; b=TrvOLXo+ZvpNOhRJz7KFihnkNU5qoTdMAHn+XHdqpmDFWPpg6KZ5d2SJbDnBVUmrw1Y74yhTXahU6OhGrdYSG6OgeJRigOlgRZB7hJOWwCJD3QYYa/3aOyc5it/iho/LnoO300YeoAO3LaoLI88SwgeZjMKw/Ct4sU0Tb9WUs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199623; c=relaxed/simple;
	bh=7k06+KU4FS2Nl7hFPiL3ggXSFJrFlkWWsqe3DM83IFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QM9YDwi7rO5MEuEJRDcizv2zhd+Vdn+GqUs65BLtbOFEr2lPyNyfSUqgsuavS0MVRi7H6mg0LAg2GrMBnGdvCakMaAnObzZVvAijV7xTG03wNz3+1LK4AAjoJL+iIia16vLRCTgMwC2SV9fM0C3zOhz690QpUMy9/oC2but35pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EN5txnML; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756199621; x=1787735621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7k06+KU4FS2Nl7hFPiL3ggXSFJrFlkWWsqe3DM83IFU=;
  b=EN5txnML6qGQcRJ2MjzkGEdHYAtsipk07bLA8UVABKRp0FouUZDdw4lF
   aPT0inI4dMDuPqUGHKXYt4ir/xI+6XLlfLCQ+ivbvzOU9hyNGDYf7jXor
   Hz4C0hdqiisABArdzJcduFxAMbl4OKOrIL/n8+hWORKM2aPdBaRWUF0rT
   nitto2uw7RCHPrxuS/7SvBHJqOYG62DDth58BbQ2IbGcfdSP5rdKeB3ul
   kk8XZlVq/5PRxKpdAa7AdsaCbmQ8eVTAwK4LyYkC0MR3LZXEniAuan2OS
   C16NPGEXhWuxdZryPT4QL02vMALxOFKJj3dMgtSUUvt89WraDNOse9/7J
   Q==;
X-CSE-ConnectionGUID: M1JPlUWoR9q6iYMXOF8AMA==
X-CSE-MsgGUID: p1l8mJrQR+iVfmrclzS1tw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213074667"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 02:13:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 02:13:16 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 02:13:11 -0700
Message-ID: <3e1c2519-e5b3-4775-bb49-ec8f355ca4b2@microchip.com>
Date: Tue, 26 Aug 2025 11:13:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
To: Stanimir Varbanov <svarbanov@suse.de>, Jakub Kicinski <kuba@kernel.org>
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
 <1ecd4a9a-d685-4bce-ad06-cc8878f0a165@suse.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <1ecd4a9a-d685-4bce-ad06-cc8878f0a165@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/2025 at 10:35, Stanimir Varbanov wrote:
> Hi Jakub,
> 
> On 8/26/25 2:53 AM, Jakub Kicinski wrote:
>> On Fri, 22 Aug 2025 12:34:36 +0300 Stanimir Varbanov wrote:
>>> In case of rx queue reset and 64bit capable hardware, set the upper
>>> 32bits of DMA ring buffer address.
>>>
>>> Cc: stable@vger.kernel.org # v4.6+
>>> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to handle RX errors")
>>> Credits-to: Phil Elwell <phil@raspberrypi.com>
>>> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>> index ce95fad8cedd..36717e7e5811 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
>>>               macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
>>>
>>>               macb_init_rx_ring(queue);
>>> -            queue_writel(queue, RBQP, queue->rx_ring_dma);
>>> +            queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
>>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>> +            if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>>> +                    macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
>>> +#endif
>>>
>>>               macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
>>>
>>
>> Looks like a subset of Théo Lebrun's work:
>> https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.com/
>> let's wait for his patches to get merged instead?
> 
> No objections for this patch, it could be postponed. But the others from
> the series could be applied.

Some cleanup by Théo, could interfere with sorting of compatibility 
strings...
We'll try make all this be queued in order, as Théo was first to send. 
Sorry for not having realized this earlier.

Best regards,
   Nicolas


