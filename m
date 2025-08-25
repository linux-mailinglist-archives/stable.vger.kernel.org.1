Return-Path: <stable+bounces-172898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E145B34FD0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132322A61D1
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DD2C178D;
	Mon, 25 Aug 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDLJvmbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0EA51C5A;
	Mon, 25 Aug 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165992; cv=none; b=ilGeLxgzYqOoxFckkrz2lBTHYbAJE6eDQnBZlmEKBqKQ1NxLDQHUKpCAu36DCcLI5KABUOkf5MrO+rtKugZlOgXJFczgttJJ6GMZ/e4qaHaU3Y5goWK60yVZe9Woofu0KD3slz8lgW+ZfCvpzP2/BnhkRfYO3gY7aMlrNZW61S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165992; c=relaxed/simple;
	bh=OSFizG0G8sYZyxXrUnI/kUtdTxY7DmYTz4FmYAkcABA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXtw/3DgXrV7ocT9+4GWLJJXSnQ0iW+iDQ+5js1E+PN2xzi9oP/cmKN46ZOGRwaQAZ2MSIJvKNQOeHO9RFuel/fgGh66xAqdBUYF9Wnt8HIiJBAHG2zjuuhb9S0UdUCHCXKA0LP/XF3mVs2CmjtAFmL7TgDq9O/zH6dC8tiDbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDLJvmbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E533C4CEED;
	Mon, 25 Aug 2025 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756165992;
	bh=OSFizG0G8sYZyxXrUnI/kUtdTxY7DmYTz4FmYAkcABA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LDLJvmbUwIA7DVd7La2/nDraaRDNjuq6eOXjb7WjGUBke0MHAE6gSENBkjOuv3xSk
	 G/lvWZrBAIAgAbwXr9DyoSrKDbTpdvbG6ywD10b7dsCR872nd02rpjWFSeB/U8ZGRT
	 nDMzcugkTDMc6Dec/Fk7j6M3PpyHKI2EYylPvrHnee+xu9wkNH+/HdM0ICeJtdRdv3
	 51pw9kyAAzkF+h0dw4+kxlCPScc3CdolgjN15HZawluYOQ70LuqyWjdur0xJfMJNiH
	 B9RnkiIoGzzF7fcAlLSexGp4+odDp6RuxLNcePNnw/nfwXINVdFrmiiXjiFeym1O6D
	 98dSxXnqdb42g==
Date: Mon, 25 Aug 2025 16:53:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, stable@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring
 buffer
Message-ID: <20250825165310.64027275@kernel.org>
In-Reply-To: <20250822093440.53941-2-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de>
	<20250822093440.53941-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 12:34:36 +0300 Stanimir Varbanov wrote:
> In case of rx queue reset and 64bit capable hardware, set the upper
> 32bits of DMA ring buffer address.
>=20
> Cc: stable@vger.kernel.org # v4.6+
> Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to h=
andle RX errors")
> Credits-to: Phil Elwell <phil@raspberrypi.com>
> Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index ce95fad8cedd..36717e7e5811 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>  		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
> =20
>  		macb_init_rx_ring(queue);
> -		queue_writel(queue, RBQP, queue->rx_ring_dma);
> +		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> +			macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
> +#endif
> =20
>  		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> =20

Looks like a subset of Th=C3=A9o Lebrun's work:
https://lore.kernel.org/all/20250820-macb-fixes-v4-0-23c399429164@bootlin.c=
om/
let's wait for his patches to get merged instead?

