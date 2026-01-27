Return-Path: <stable+bounces-211698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NC2F3sdeGkKoQEAu9opvQ
	(envelope-from <stable+bounces-211698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:05:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3488EDAB
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818DD3018D67
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C82BE657;
	Tue, 27 Jan 2026 02:05:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75829284663;
	Tue, 27 Jan 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479540; cv=none; b=e/irMRoe9djlNHbL5vEbHUGn5zK3UVEfRRNisqZXZIgjZ7ylIobJUYu32Hcmt9oOCZ/D5d28AWmTyjuBMcp06uJDIK9/gL6fMDLbDMktgtoMQmoldQJxfzRAjiXdtS0QcG9FDNIklqHqX5V3RnRksMBCJejDe6AJTdkj/8bIWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479540; c=relaxed/simple;
	bh=jtCdFaeN7M/y+/pP+4rZ2c4E1Jn0waySsAtKkf43YI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBMeRFDTN1aDAkEnDFfP8mgDDLK0MvkGk7EZoFnGb8Ylbd9JWsltBVxJVwSmDGGaIy2ypLErn1zEwennVdFbzUoU9N0zlyz0BMsIbZpzmLOkBpp3tm99juhKV3tFJ7VkZYkCbaMW8OfqnX5cIyvpNvYkyd1Mz/krYJp5jpJeTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BFB16335D2F;
	Tue, 27 Jan 2026 02:05:36 +0000 (UTC)
Date: Tue, 27 Jan 2026 10:05:26 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Yixun Lan <dlan@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH net v2] net: spacemit: k1-emac: program frame size
 registers for jumbo frames
Message-ID: <20260127020526-GYA88966@gentoo.org>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
 <20260126171449.83288-1-tmshlvck@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126171449.83288-1-tmshlvck@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gentoo.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211698-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@gentoo.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF3488EDAB
X-Rspamd-Action: no action

Hi Tomas,

On 18:14 Mon 26 Jan     , Tomas Hlavacek wrote:
> The driver allows changing MTU up to 4K via emac_change_mtu() and
> allocates appropriately sized DMA buffers, but it never programs the
> MAC_MAXIMUM_FRAME_SIZE and MAC_RECEIVE_JABBER_SIZE registers.
> 
> This causes the MAC hardware to reject frames larger than the default
> 1518 bytes, even when larger buffers are allocated. Frames exceeding
> the default size trigger jabber errors and are discarded.
> 
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
> ---
> v2: Added Fixes tag and Cc stable.
> 
>  drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index 220eb5ce7583..31b1bdb2827e 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -228,6 +228,12 @@ static void emac_init_hw(struct emac_priv *priv)
>  		DEFAULT_TX_THRESHOLD);
>  	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
>  
> +	/* Set maximum frame size and jabber size based on configured buffer
> +	 * size.
> +	 */
> +	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, priv->dma_buf_sz);
> +	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, priv->dma_buf_sz);
> +
I'm no expert here, but just notice there is additional MAC_TRANSMIT_JABBER_SIZE
register which is no need to set? or is the problem on receive side only?

>  	/* Configure flow control (enabled in emac_adjust_link() later) */
>  	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
>  	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
> -- 
> 2.52.0
> 

-- 
Yixun Lan (dlan)

