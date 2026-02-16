Return-Path: <stable+bounces-216751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BHUJHx6k2nV5gEAu9opvQ
	(envelope-from <stable+bounces-216751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 21:13:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2114763E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 21:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A84AC3029E78
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DB2E8DE3;
	Mon, 16 Feb 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aRUICT1r"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10B28D8DB;
	Mon, 16 Feb 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272820; cv=none; b=SsRCDsqwZnEFpp0ujexCFvgYjFfstDAF+6zW8TymwTCc0RYfhPZZJ3Hxbbrs8Ej70/KEGZA1YTV28rpvk/dH/HOKYExZ8Aaf5I8figP0swzNQB89kpiD0TaubB1o2ByDMpv3rag0xa0n1utpdPEhZXJgIgwBWaPzuNUmVcBFNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272820; c=relaxed/simple;
	bh=IE5HoO8HWJTuHPBPnLwIKsMKbbBbg5iNPVQzRfN+AIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKfvAHTPHhWOLE/Y1ADm2k46g34uyAuY3myBTNrdjGjPSe155UJsN9PN4WZwp8ShpVgVkw/m1PRAL6hDvZiuNOCS6JQN+SvJoS4IisSYf9eAGgkbgsTrxD/iR3nYXbtPcUwI/6Hik6ZNA/r2pixAyBNM0HAh6162diXp3GP/k3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aRUICT1r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nqY1zFk/Ql6M+VyHSIk1GNbgl32SNTksZ6fx1kYYdT4=; b=aRUICT1rS+kUDwna0wkLu8ffeK
	VysFFZ4uheQmytzrHh50uCyI17ca+F5UrE/Sy0C+Et9bo3WhU73HhCoc5K7uyDtgJq+297VZImOC4
	HvYOuSmpDAssuIY242B4xqHj/TL1MY9q08lB3r60EViBjT301l25FJYmGjEHU6EYJVNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs4yD-007XMg-SV; Mon, 16 Feb 2026 21:13:25 +0100
Date: Mon, 16 Feb 2026 21:13:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabian Druschke <fabian@druschke.network>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Fabian Druschke <fdruschke@outlook.com>
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
Message-ID: <64b1a578-5325-4d51-9b10-2b54fcaa0a7f@lunn.ch>
References: <20260216185245.182450-1-fabian@druschke.network>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216185245.182450-1-fabian@druschke.network>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-216751-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1A2114763E
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 07:52:45PM +0100, Fabian Druschke wrote:
> From: Fabian Druschke <fdruschke@outlook.com>
> 
> r8169 allocates order-2 pages for RX buffers during rtl_open(). Under heavy
> memory fragmentation this allocation may trigger the global OOM killer,
> causing unrelated user processes to be killed.
> 
> Use a GFP mask that avoids OOM killer invocation so the allocation can fail
> gracefully and rtl_open() returns -ENOMEM instead.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabian Druschke <fdruschke@outlook.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3507c2e28110..3525e889ec1c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3952,7 +3952,8 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	dma_addr_t mapping;
>  	struct page *data;
>  
> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> +	gfp_t gfp = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +	data = alloc_pages_node(node, gfp, get_order(R8169_RX_BUF_SIZE));
>  	if (!data)
>  		return NULL;

~/linux/drivers/net$ grep -r alloc_pages_node
ethernet/chelsio/cxgb4/cxgb4_main.c:		newpage = alloc_pages_node(node, __GFP_NOWARN | GFP_KERNEL |
ethernet/chelsio/cxgb4/sge.c:		pg = alloc_pages_node(node, gfp | __GFP_COMP, s->fl_pg_order);
ethernet/chelsio/cxgb4/sge.c:		pg = alloc_pages_node(node, gfp, 0);
ethernet/amd/xgbe/xgbe-desc.c:		pages = alloc_pages_node(node, gfp, order);
ethernet/fungible/funcore/fun_queue.c:		rqinfo->page = alloc_pages_node(node, GFP_KERNEL, 0);
ethernet/fungible/funeth/funeth_rx.c:	p = __alloc_pages_node(node, gfp | __GFP_NOWARN, 0);
ethernet/mellanox/mlx5/core/pagealloc.c:	page = alloc_pages_node(nid, GFP_HIGHUSER, 0);
ethernet/mellanox/mlx5/core/en_main.c:		struct page *page = alloc_pages_node(node, GFP_KERNEL, 0);
ethernet/mellanox/mlx4/icm.c:	page = alloc_pages_node(node, gfp_mask, order);
ethernet/realtek/r8169_main.c:	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
ethernet/google/gve/gve_main.c:	*page = alloc_pages_node(priv->numa_node, gfp_flags, 0);
ethernet/google/gve/gve_rx.c:			struct page *page = alloc_pages_node(priv->numa_node,
ethernet/google/gve/gve_rx_dqo.c:	struct page *page = alloc_pages_node(rx->gve->numa_node, GFP_ATOMIC, 0);
ethernet/hisilicon/hns3/hns3_enet.c:	page = alloc_pages_node(dev_to_node(ring_to_dev(ring)),

:~/linux/drivers/net$ grep -r __GFP_RETRY_MAYFAIL
veth.c:			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

What makes the r8169 special?

     Andrew

