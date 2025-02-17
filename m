Return-Path: <stable+bounces-116581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AD5A38464
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC121737CE
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6A21C9F6;
	Mon, 17 Feb 2025 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4rMo0xK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFD21C197;
	Mon, 17 Feb 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798118; cv=none; b=jAppIedOYtCHiIlAm6pDgQzaxeOTv2UbH+MAPrK7ynz7MtwUP9bfu5kX96rgJlQ32XICF6n7WXdBwzUxyYVgv6St120eK88JRlY6X6UY3KwuvhD38AzvCry9u9veNdRmITs6jJgPO01wTLPTOc+VPpvfSj4qqWbDZpZQf5SC3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798118; c=relaxed/simple;
	bh=RXP5X417yTlCiBf+xrfyXIDd3TLnHV3EUYKREgUrLKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH5JNqad42h027Ksx/ALbpEG9RaJwe8rc8EWa7o92BmTOI5JTOUDxaCmVmlc1z6P3Bg+M3Ar+23KIYYkRr7Rra6t13bT/OXokL80pzp5eyetOinQ2x7VtN76h7Z5DEd78c2Iz2oGRGSBHmHAnalSdLIxRUxwutqHFxZYzP8pVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4rMo0xK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739798117; x=1771334117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXP5X417yTlCiBf+xrfyXIDd3TLnHV3EUYKREgUrLKU=;
  b=e4rMo0xKSOuDWVDHEwTsGHm1UkEhJsDWxpGj7alFPnpduashFErkdCW3
   gR9RZPtRFMQc7uYfef6QjS0kvXSKsQDoHN/HsYFnE/q/nuyfNEBWcOR31
   EDm9U2EYDZDhJdFY1R95elaRlRYxUZmeJyKR4YPN5T/AoqrmtubnjiFW8
   ckqGc0QBcld9ujDiHFW+9id4/X1mx+T3Fee02cCbc15fcNYqpUir4fIRq
   JKbFlLXQnx2Yy3YMsKZCcIgOMGCrTORG3ghwCavUTYwLBck1doM7nIDLm
   GdJzA0yXj3TqIzknJCRSYP++fh05gvgmtM1zSPpOOJeHAI1XDSo2N0ydV
   Q==;
X-CSE-ConnectionGUID: 6NRj06+tR0Cyoe2wD+EI0A==
X-CSE-MsgGUID: SIOyrkrLQzqs9QGcbFnUCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40344735"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40344735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 05:15:16 -0800
X-CSE-ConnectionGUID: qYKS6OdJS+2s7cDaSWruOg==
X-CSE-MsgGUID: vOK7AQiKSFimzZKPW3N2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114041454"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 05:15:13 -0800
Date: Mon, 17 Feb 2025 14:11:33 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Message-ID: <Z7M1hQIYZGWAZsOT@mev-dev.igk.intel.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217093906.506214-2-wei.fang@nxp.com>

On Mon, Feb 17, 2025 at 05:38:59PM +0800, Wei Fang wrote:
> When the DMA mapping error occurs, it will attempt to free 'count + 1'
> tx_swbd instead of 'count', so fix this off-by-one issue.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 6a6fc819dfde..f7bc2fc33a76 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -372,13 +372,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  dma_err:
>  	dev_err(tx_ring->dev, "DMA map error");
>  
> -	do {
> +	while (count--) {
>  		tx_swbd = &tx_ring->tx_swbd[i];
>  		enetc_free_tx_frame(tx_ring, tx_swbd);
>  		if (i == 0)
>  			i = tx_ring->bd_count;
>  		i--;
> -	} while (count--);
> +	};

In enetc_lso_hw_offload() this is fixed by --count instead of changing
to while and count--, maybe follow this scheme, or event better call
helper function to fix in one place.

The same problem is probably in enetc_map_tx_tso_buffs().

Thanks
Michal

>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

