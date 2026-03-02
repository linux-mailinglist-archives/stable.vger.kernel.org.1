Return-Path: <stable+bounces-222548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLAMJ4xTpWkR9AUAu9opvQ
	(envelope-from <stable+bounces-222548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:08:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195131D5443
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DEA6302B811
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CC387581;
	Mon,  2 Mar 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="irWNKPM6"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD9430B8B;
	Mon,  2 Mar 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442383; cv=none; b=sSsXcSDYu54DlF+cwYGVvn++IUgV3L9DRbld8p0/A138vSK3vCgpWdqmcAWvekwDgQ/WdU6ps3yqMwhirUJ4vopDXw874zVOLrhg2W2fRtsYiJAb2YGE7r4hNNKoulB/uc6nz60nuP5J7cJ0zLZ4JMiEv1RzG2KR0dYZr6+f/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442383; c=relaxed/simple;
	bh=r0rUJ79XcHw2ctvPIG/bEBzM1XM+kCL7v2UyEDImRrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfhIh2qCaunmq7Bug80j4RjYww9Xo2njwPLS3sLnrpGufjrkf/iCIljsqcYWsjxyd02WN0oV2gwHfS1agP6c2lvKFW7ZMIbgIm+jh/AvwDfZdGPhiTCsrWlkEbAcNlZMlop2MKOcVjhvvYEOJyrNvfl4UvDEW/NpULcNxiwrouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=irWNKPM6; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4418B1486B3E;
	Mon,  2 Mar 2026 10:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1772442371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+lsuT024m5YlWSyMVvPIE+Thxn5KQ85ifvO/KH6mvxg=;
	b=irWNKPM6vLX1zRPhRfcyiOsxZj+EmMdaq/iHt2CJPLyV1rBPR5KfIFFtX+HqKr4vOnkLZP
	RuLXVRvkuzI0BpbK63/bwtiTSEYEJAW5f7wtin1AAWjmVZpTLdqXoROYsdXMIbyjO767MM
	VbZGC1rKY1P91+1fv0RQrXiwGcpSOKX0yA6D3oUX+ScoVf5znsfwpqvxGfQo+EkkREKFcR
	7ornFY+EU7HAr8hnzMzel65PMYpFLuv30GJVSoYAGK6+ldVyU3xfNsmEQ19T5n+E+Mm5mX
	bToNbi9iU5xc5H4PUizJEI6OyjKVkycyt8LT2+5idgG5/xb0OMWPLelFq/TPkQ==
Date: Mon, 2 Mar 2026 10:06:05 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, haokexin@gmail.com,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: FAILED: Patch "net: macb: Fix tx/rx malfunction after phy link
 down and up" failed to apply to 6.12-stable tree
Message-ID: <20260302-afloat-stubbly-1858603fbb0c@thorsis.com>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	haokexin@gmail.com, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
References: <20260301012805.1685772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301012805.1685772-1-sashal@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222548-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[thorsis.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:url,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,thorsis.com:mid,thorsis.com:dkim,thorsis.com:email]
X-Rspamd-Queue-Id: 195131D5443
X-Rspamd-Action: no action

Hello Sasha,

Am Sat, Feb 28, 2026 at 08:28:05PM -0500 schrieb Sasha Levin:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I tried cherry-pick the upstream commit
bf9cf80cab81e39701861a42877a28295ade266f on top of v6.12.74 (current
state of the linux-6.12.y branch) and it produced no conflicts.
In fact the diff is very much the same as below, so I'm a little
puzzled why it failed at your side?

I'd like to see this fix in 6.12 stable, because it fixes an actual
problem for us (see msg ids below [1] [2]).  How to proceed here?
E-mail as suggested above?

Greets
Alex

[1] <20260219-knapsack-thirteen-7d9e83451a40@thorsis.com>
[2] <20260219-raffle-unvisited-891b68df5aef@thorsis.com>

> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From bf9cf80cab81e39701861a42877a28295ade266f Mon Sep 17 00:00:00 2001
> From: Kevin Hao <haokexin@gmail.com>
> Date: Sun, 8 Feb 2026 16:45:52 +0800
> Subject: [PATCH] net: macb: Fix tx/rx malfunction after phy link down and up
> 
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
> Link: https://patch.msgid.link/20260208-macb-init-ring-v1-1-939a32c14635@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 6511ecd5856bd..4ebb40adfab37 100644
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
> -- 
> 2.51.0
> 
> 
> 
> 
> 

