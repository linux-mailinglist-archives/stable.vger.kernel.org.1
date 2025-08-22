Return-Path: <stable+bounces-172350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7DB3142E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9652B16BAE1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00822F066B;
	Fri, 22 Aug 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xn+orgFD"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBE28B7EF;
	Fri, 22 Aug 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855805; cv=none; b=XF3NSbBpylAZ/60o3inT/5UysI1r9/o8e1Gq8Alhdksl725WBLXf/he3HlO7QQgc4ChK+Cuzf4O+jvaFfSNCmeJTsTmalIa0xO1lxqheGpdbu0JerDKq4An0PFA5utr9QL2DFr0jiF5ArsDUcOtkj341s42y0tMZUUY6RlLWP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855805; c=relaxed/simple;
	bh=XvLLjO10ZjfDDDyrr6k2ma2BhF/RNPJ4DSCV+fvgoPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=li6qCLVtcoofcLzL6ROT63iCAdiQHeLR9PU6639pKCDiHQglZM28ICTCw/EXuSjPesvW2I9FMFQibEtd4TPs+7r+lXEAcrUIDTADi0dTYCkbU1ITZM0PciFHtlVEOciOFSpVr4ylOQ+DmgpLCbNu8qaGkYZ0CrcO8z7RArWaUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xn+orgFD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755855803; x=1787391803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XvLLjO10ZjfDDDyrr6k2ma2BhF/RNPJ4DSCV+fvgoPg=;
  b=xn+orgFDfKERT1aKz/Gil9nJfGHNp8BVNN+BYiL9s7xFz/ZF/STxZd1n
   8YAGWZDQgtsVtUihUEjSLKp27MZQLa6TpF1vbppQqbHuqOW5/NgCqU4u/
   6ncqNlylpt/huWXsj6hMYVwnXmwcczp13lNM/h83KL7Brn1YirKXwPx7k
   c84NIw0cgb3y84d/y9+5HHoj37wHDjXAYsDrcp6D2rfi7LCwo3Prrwpk0
   +ftipjC5YYO1/+iAcHslGCncUjRO6zyp/4xOXIKt8LL48ob2Az7qTmM/O
   yOgFfR1In6pZjSh8jr+ZbbNZ1AvfR0WcaD4V0pPCzL4Xe5x2R1Jjo9YaF
   g==;
X-CSE-ConnectionGUID: LGcmkA5hT8qi7s/85J+MnQ==
X-CSE-MsgGUID: YHj2pwobRuWKcPBmUWDZiQ==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="51127577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 02:43:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 02:42:54 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 22 Aug 2025 02:42:50 -0700
Message-ID: <73371973-d6b4-418c-a51c-2e89abab61e8@microchip.com>
Date: Fri, 22 Aug 2025 11:42:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
To: Stanimir Varbanov <svarbanov@suse.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
	<jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
	<stable@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-2-svarbanov@suse.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250822093440.53941-2-svarbanov@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 at 11:34, Stanimir Varbanov wrote:
> In case of rx queue reset and 64bit capable hardware, set the upper
> 32bits of DMA ring buffer address.
> 
> Cc: stable@vger.kernel.org # v4.6+
> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to handle RX errors")
> Credits-to: Phil Elwell <phil@raspberrypi.com>
> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Looks good to me: thanks!
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> v1 -> v2:
>   - Added credits.
>   - Use lower_32_bits() for RBQP register writes for consistency (Nicolas).
>   - Added Fixes tag.
> 
>   drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd..36717e7e5811 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
>                  macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
> 
>                  macb_init_rx_ring(queue);
> -               queue_writel(queue, RBQP, queue->rx_ring_dma);
> +               queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> +                       macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
> +#endif
> 
>                  macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> 
> --
> 2.47.0
> 


