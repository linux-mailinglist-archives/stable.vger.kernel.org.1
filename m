Return-Path: <stable+bounces-217445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFATGOMtl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:36:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A74160374
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BDA305E30F
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9E346FAE;
	Thu, 19 Feb 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="DhQsuyLs"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA0345758;
	Thu, 19 Feb 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515241; cv=none; b=atT1WZUHkaVuYo92cvoN8NM/n+/VmyEPPrzsAJrxfGdso5Q0gfUBzmel3eumDf0aBck2QRAon8XX/RSwaSyB7O6DTdbHjE8IETELBtr3FsStuhKeI/jegCSxZVH49cLeBU3//OktL+/svDXltjhCLS9sl/NfTo/NXriJ/H3/5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515241; c=relaxed/simple;
	bh=N0xwsE2WWVW2aVE+WMgG16V1nog7gqbaReNhJq9bJw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0IyN/q+ammegGJ3rZ/MQJAuUf0BIGKf4tkAELO+XeClpVywzqZw+v1cb2Fbc5FZV3kmUpQdZHZjm848cGOU2Csmd+LFTXufSiq6IUZkYmAcw+OUxEcED6A57cDelcerJJ0dxsN3UobyOLvfo5VfEg2Gjtz49oG8wVMxl/cnkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=DhQsuyLs; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 746A1148323C;
	Thu, 19 Feb 2026 16:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1771515235; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EhwThLiF49uWSR0GR+2RK0Tqx4pT8auqAlmLMUG4e/w=;
	b=DhQsuyLsmk+S3PIAygzUV7EOyLmszbB2pOJF8gVJynIuscf7tpzj9MGt1jtkZvcUvP+pgV
	NtchHnIqUPzeBtJZxncc8kyA7irRUQxwQM0XaCbfcsbhZ3NV3BKpru6OgM6I3lcXyh8Esr
	LibNS2tHflQc3FGjxNDiTkPGasNz1Wcxggs5RwxHef61BL53Ds4OyndEimizGvTJnzwDVc
	0NmRRFG+8PfJpV4d88Ormev3dot7Zq7WEq1xCz6TF+X3bA/FFxaIm8WXHdoY/5/87H7es1
	pQprgFGel2sps8VMwLWymY7DaFTx2CorhRc7RmqvazeixUhCWGp3AfcRz78hsQ==
Date: Thu, 19 Feb 2026 16:33:50 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: Re: [PATCH net] net: macb: Fix tx/rx malfunction after phy link down
 and up
Message-ID: <20260219-raffle-unvisited-891b68df5aef@thorsis.com>
Mail-Followup-To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
References: <20260208-macb-init-ring-v1-1-939a32c14635@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208-macb-init-ring-v1-1-939a32c14635@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217445-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[thorsis.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:url,tuxon.dev:email,lunn.ch:email,thorsis.com:mid,thorsis.com:dkim,thorsis.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Queue-Id: 05A74160374
X-Rspamd-Action: no action

Hello Kevin,

Am Sun, Feb 08, 2026 at 04:45:52PM +0800 schrieb Kevin Hao:
> In commit 99537d5c476c ("net: macb: Relocate mog_init_rings() callback
> from macb_mac_link_up() to macb_open()"), the mog_init_rings() callback
> was moved from macb_mac_link_up() to macb_open() to resolve a deadlock
> issue. However, this change introduced a tx/rx malfunction following
> phy link down and up events. The issue arises from a mismatch between
> the software queue->tx_head, queue->tx_tail, queue->rx_prepared_head,
> and queue->rx_tail values and the hardware's internal tx/rx queue
> pointers.
> 
> According to the Zynq UltraScale TRM [1], when tx/rx is disabled, the
> internal tx queue pointer resets to the value in the tx queue base
> address register, while the internal rx queue pointer remains unchanged.
> The following is quoted from the Zynq UltraScale TRM:
>   When transmit is disabled, with bit [3] of the network control register
>   set low, the transmit-buffer queue pointer resets to point to the address
>   indicated by the transmit-buffer queue base address register. Disabling
>   receive does not have the same effect on the receive-buffer queue
>   pointer.
> 
> Additionally, there is no need to reset the RBQP and TBQP registers in a
> phy event callback. Therefore, move macb_init_buffers() to macb_open().
> In a phy link up event, the only required action is to reset the tx
> software head and tail pointers to align with the hardware's behavior.
> 
> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
> 
> Fixes: 99537d5c476c ("net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Cc: stable@vger.kernel.org

After backporting this to my 6.12.66-rt15 based tree I can confirm
this solved our system lockup issue we had on at91 sam9x60, and which
was caused by the above mentioned commit 99537d5c476c (which made it
to the v6.12.64 release as f5c055c284156).

So for the stable tree:

Tested-by: Alexander Dahl <ada@thorsis.com>

Thanks and greetings
Alex

> ---
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index effef67d80731e5cc795fcef5adc280ad931eda9..43cd013bb70e6bd08a31a0826364e4f34c0e0b89 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -705,14 +705,12 @@ static void macb_mac_link_up(struct phylink_config *config,
>  		if (rx_pause)
>  			ctrl |= MACB_BIT(PAE);
>  
> -		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
> -		 * cleared the pipeline and control registers.
> -		 */
> -		macb_init_buffers(bp);
> -
> -		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +			queue->tx_head = 0;
> +			queue->tx_tail = 0;
>  			queue_writel(queue, IER,
>  				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
> +		}
>  	}
>  
>  	macb_or_gem_writel(bp, NCFGR, ctrl);
> @@ -2954,6 +2952,7 @@ static int macb_open(struct net_device *dev)
>  	}
>  
>  	bp->macbgem_ops.mog_init_rings(bp);
> +	macb_init_buffers(bp);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_enable(&queue->napi_rx);
> 
> ---
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> change-id: 20260207-macb-init-ring-b0e37b3a3755
> 
> Best regards,
> -- 
> Kevin Hao <haokexin@gmail.com>
> 
> 

