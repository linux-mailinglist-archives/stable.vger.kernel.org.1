Return-Path: <stable+bounces-214859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJzaDsN9iGkzqAQAu9opvQ
	(envelope-from <stable+bounces-214859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:12:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7410897F
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CCD300F9DA
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05A3559F7;
	Sun,  8 Feb 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Y7Tk5RPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4Rf7oVv"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A43161A8
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770552767; cv=none; b=jwYsQxmh4OWn6Agko2GBv8Cy9/zmbeA+ngHwrQnK4/PXeQBivVUa8BbDdS0AnRYQ3wdMTaEcqsmBO8LaF7US4719ld1O8axr6ZHnPvb/I0QORLn9SmH+1daMatmeTsnYGJLRWZE5Lu6042GmEJLLt7kHupf+WyG1/MtiDVGx4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770552767; c=relaxed/simple;
	bh=KfyzwgzfBCS+dIRqKvz0IVUcZ0PmJyKGe+h3emogPGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuqjP4KgG4FcxUAdSWYV8bcfIxvbl0bWdIsWRMzHmWUE8kIOCfYtRxfMbayzMdq4ArmBNPqCqMMyQFPguorhFzLzM4z9rSDB6WWUPDldUas/io94kZXc6u3m9mXnQKCdUwpBcUoqfla+S/JaSrOthdaDIp7VdZn2V1Wsgk71xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Y7Tk5RPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4Rf7oVv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 285137A011B;
	Sun,  8 Feb 2026 07:12:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 08 Feb 2026 07:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770552765; x=1770639165; bh=brTtWvoi2r
	170zcr2eIq8zXbw9D8CvRWjSWvsv+ASN8=; b=Y7Tk5RPgIIry0UHBurrzFgcD1F
	j/2S9/KQv2Zd6xvfFjMXOXwZ3Hz0RjjyXaGXTMcPWNhNX5cJ32Q+knBsBlq59e4u
	ZEakHg1GiKYMsUDLDZxLTwVD3zDi8f3BiYwRiAyAB5+ncNJfZ6ai5zaXqmZDB5Ht
	azFBf74+9ij8zlsk438KxtBR0O/Vc4HvRMa5d2MDOHwGL4C/2Wz3+ezp45/Ec9ee
	y42r6GLeHb3P6jjn18QqnvL4i0BshCBDGIXX5yLpi+/x2IQ0k6S1dC69ns+xQ102
	9/6w8Tlwc0oZYy0dQw6vziCAyk2oW7/LEECD0UaXMXxhDEEGsiNRmzTRecpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770552765; x=1770639165; bh=brTtWvoi2r170zcr2eIq8zXbw9D8CvRWjSW
	vsv+ASN8=; b=k4Rf7oVvkj5p8U+5eTXXdIy+cQEnxkfbYDLJxXL5puZpaasQupO
	HmlJedY+mwCDyo/5z1WZo7eECTT2GNdtiCG6wKq+mPrsUfLoROczyTxekrCaFqTe
	v5n6NemSqGMom2tulp1RoIQASPrruaIDqlpbsZa9abU6LcvJEQcoi0CZH5mLqIjh
	ttlAlTwAhe6ylYEhBx9wpdzQd8HaKeAh5l5gxc/KJK4b2ndzQq36M1gnUSsA1dxe
	rI8wSVm+l1gsSYxGhrWGtudIxO1jV4TawXgj+CqAYbxO8zQH4UxmpGJCAAoPfJSo
	IKnUk4aporIoES1pXSTxRt2p1FsEyyrcwzw==
X-ME-Sender: <xms:vX2IacY8hjjTCGsWgRFeaY31GSReahpSlM3N3L41privftVEBdB7Dg>
    <xme:vX2IaTWDjq_0n4hgZy-jmUaeXg8edy4O8_UEuAGca6c2zLfABQ8GrRstiZgj3te4H
    p3qxRpDSSrvg0I1trdmIoTJAxiHfrS9BsUV5fhe49PYgNtnrQ>
X-ME-Received: <xmr:vX2IadEXTXfB73FUyZbz-fi_yk502BDqcVI1rsTKdcfIayMbf-hh0NFBWuo_tJPOa9Fn3lZzcvePOzLAAIdTm-oCfZ1qqiqr56dFaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehte
    ekuefhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhn
    pehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgrgiihuhgrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhorh
    gurghnrhhhvggvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhshhifrghshhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgrohhlshhonhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohephhhrrghmrghmuhhrthhhhiesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vX2IadDCimT3sBe3r2LG9826QPzn7td3Am5bu_Vz4Hna2siUl5YEHg>
    <xmx:vX2IaVyFm37AMGtUpuDbPKPB2L5dYB2yYQdyN7r6RDYWk_dXje6CPQ>
    <xmx:vX2IaeALAfhTEmNj-2KH7jY8Zq3m8umCNZFcjoSEQrYXOAWV1BbNAg>
    <xmx:vX2IaeBtPAaH-8O17yJnMfXV7nmQ41Us46wZ02FOCGKyz9djpWuXhw>
    <xmx:vX2IaQTrOZ-EtF7qyW8ruq9EFC9WV6azrJIqAOU3cyy7i_C58sPtGUH6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 07:12:44 -0500 (EST)
Date: Sun, 8 Feb 2026 13:12:42 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Max Yuan <maxyuan@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Joshua Washington <joshwash@google.com>,
	Matt Olson <maolson@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] gve: Correct ethtool rx_dropped calculation
Message-ID: <2026020826-blustery-crimp-f3fc@gregkh>
References: <2026020757-credibly-prologue-e2b8@gregkh>
 <20260207184305.497723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207184305.497723-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214859-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:dkim]
X-Rspamd-Queue-Id: 38E7410897F
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 01:43:05PM -0500, Sasha Levin wrote:
> From: Max Yuan <maxyuan@google.com>
> 
> [ Upstream commit c7db85d579a1dccb624235534508c75fbf2dfe46 ]
> 
> The gve driver's "rx_dropped" statistic, exposed via `ethtool -S`,
> incorrectly includes `rx_buf_alloc_fail` counts. These failures
> represent an inability to allocate receive buffers, not true packet
> drops where a received packet is discarded. This misrepresentation can
> lead to inaccurate diagnostics.
> 
> This patch rectifies the ethtool "rx_dropped" calculation. It removes
> `rx_buf_alloc_fail` from the total and adds `xdp_tx_errors` and
> `xdp_redirect_errors`, which represent legitimate packet drops within
> the XDP path.
> 
> Cc: stable@vger.kernel.org
> Fixes: 433e274b8f7b ("gve: Add stats for gve.")
> Signed-off-by: Max Yuan <maxyuan@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Matt Olson <maolson@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Link: https://patch.msgid.link/20260202193925.3106272-3-hramamurthy@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Adjust context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 22317acf16ba4..997e1d7736a84 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -156,9 +156,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  {
>  	u64 tmp_rx_pkts, tmp_rx_bytes, tmp_rx_skb_alloc_fail,
>  		tmp_rx_buf_alloc_fail, tmp_rx_desc_err_dropped_pkt,
> -		tmp_tx_pkts, tmp_tx_bytes;
> +		tmp_tx_pkts, tmp_tx_bytes,
> +		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
>  	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_pkts,
> -		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped;
> +		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped,
> +		xdp_tx_errors, xdp_redirect_errors;
>  	int stats_idx, base_stats_idx, max_stats_idx;
>  	struct stats *report_stats;
>  	int *rx_qid_to_stats_idx;
> @@ -186,7 +188,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  		return;
>  	}
>  	for (rx_pkts = 0, rx_bytes = 0, rx_skb_alloc_fail = 0,
> -	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0, ring = 0;
> +	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0,
> +	     xdp_tx_errors = 0, xdp_redirect_errors = 0, ring = 0;
>  	     ring < priv->rx_cfg.num_queues; ring++) {
>  		if (priv->rx) {
>  			do {
> @@ -200,6 +203,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
>  				tmp_rx_desc_err_dropped_pkt =
>  					rx->rx_desc_err_dropped_pkt;
> +				tmp_xdp_tx_errors = rx->xdp_tx_errors;
> +				tmp_xdp_redirect_errors =
> +					rx->xdp_redirect_errors;
>  			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
>  						       start));
>  			rx_pkts += tmp_rx_pkts;
> @@ -207,6 +213,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
>  			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
>  			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
> +			xdp_tx_errors += tmp_xdp_tx_errors;
> +			xdp_redirect_errors += tmp_xdp_redirect_errors;
>  		}
>  	}
>  	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
> @@ -231,8 +239,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  	data[i++] = rx_bytes;
>  	data[i++] = tx_bytes;
>  	/* total rx dropped packets */
> -	data[i++] = rx_skb_alloc_fail + rx_buf_alloc_fail +
> -		    rx_desc_err_dropped_pkt;
> +	data[i++] = rx_skb_alloc_fail + rx_desc_err_dropped_pkt +
> +		    xdp_tx_errors + xdp_redirect_errors;
>  	data[i++] = tx_dropped;
>  	data[i++] = priv->tx_timeo_cnt;
>  	data[i++] = rx_skb_alloc_fail;
> @@ -281,6 +289,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
>  				tmp_rx_desc_err_dropped_pkt =
>  					rx->rx_desc_err_dropped_pkt;
> +				tmp_xdp_tx_errors = rx->xdp_tx_errors;
> +				tmp_xdp_redirect_errors =
> +					rx->xdp_redirect_errors;
>  			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
>  						       start));
>  			data[i++] = tmp_rx_bytes;
> @@ -290,8 +301,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  			data[i++] = rx->rx_frag_alloc_cnt;
>  			/* rx dropped packets */
>  			data[i++] = tmp_rx_skb_alloc_fail +
> -				tmp_rx_buf_alloc_fail +
> -				tmp_rx_desc_err_dropped_pkt;
> +				    tmp_rx_desc_err_dropped_pkt +
> +				    tmp_xdp_tx_errors +
> +				    tmp_xdp_redirect_errors;
>  			data[i++] = rx->rx_copybreak_pkt;
>  			data[i++] = rx->rx_copied_pkt;
>  			/* stats from NIC */
> -- 
> 2.51.0
> 
> 

Does not apply after I added your other backport :(

Can you rebase this one on top of that one?

thanks,

greg k-h

