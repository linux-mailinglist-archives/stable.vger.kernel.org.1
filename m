Return-Path: <stable+bounces-118246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F3A3BC6A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC35C7A3F0B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D61DED4A;
	Wed, 19 Feb 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhEoV8Z+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0881A840D;
	Wed, 19 Feb 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963276; cv=none; b=pnmrW9cxKlqjuyPEz3f50IUmkjtQ21fZYy/pA4VGO1v2sqMgrlDSvPID6Oj2rFW8nf8YCXWzXk9SOFWMcpMDjuwzv5IcqrHw+zuosSMKbpO9/cyDo6+jJp9oHJyx7I09QQxwo6R/SzbgjF72NQXDCF1MruXxK7II5RGJ5YlfivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963276; c=relaxed/simple;
	bh=tl5pzB5lQ0dT/Bi0R1NrudW2rHGEeLRrxww72qbAKnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktI4UQO2ov69gfXWEd4bSvgCaEAP7AV6LRaI9AN6z3PNesP9F7KOAaPwGLwtidf+fFDCKFmwrInGqhYcm6BJ4ihgoK9ixzXCftvu5733WoEZu3+9CeY832bm872k0Ya05ipB5BObLLOcgtFPoRLC9w81+J5geL7BuvDX6ujPl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhEoV8Z+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739963275; x=1771499275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tl5pzB5lQ0dT/Bi0R1NrudW2rHGEeLRrxww72qbAKnA=;
  b=bhEoV8Z++qY8EYGnL0+f2HGbnbffexorbXWF13Cr9PasIqoEPR8YUjlt
   4uWL8OulLxb33pqmk1xtruKuRkaJ/WVBPYSlRVBzWGK06md2N4wyUGf3H
   C4qvC7kNN7EQwq7BB5O9crbu4BTCORhuFutvxLN0JVSOSJZU2j8AaAFdC
   aOuf+aBEGsnCuJPLi4Q/UXsNetG+UV23Iin7bsNKY8WufhmP48aK//wIN
   XU5sse2CeYyRtLK1w2BAlP++lQv+IJOCGl283z7Bvht5sa/OfASDNFVKg
   2uF4oDAQx46PMpeSNax1nAljXpnb7A4LCJqGrBuRhZnTzN7ZVi60xFG2h
   w==;
X-CSE-ConnectionGUID: v/njSpbpT4q34DsXTjieAg==
X-CSE-MsgGUID: T3Ie6bYnRBSJpVxaDtwxRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58101236"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="58101236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 03:07:55 -0800
X-CSE-ConnectionGUID: wXhrJnbqR0q5d0rDK0cZnA==
X-CSE-MsgGUID: CbAA0e9KS9OZe1ScliBf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115580794"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 03:07:50 -0800
Date: Wed, 19 Feb 2025 12:04:14 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com, michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Message-ID: <Z7W6rtLwpHGlox3T@mev-dev.igk.intel.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-10-wei.fang@nxp.com>

On Wed, Feb 19, 2025 at 01:42:47PM +0800, Wei Fang wrote:
> There is an off-by-one issue for the err_chained_bd path, it will free
> one more tx_swbd than expected. But there is no such issue for the
> err_map_data path. To fix this off-by-one issue and make the two error
> handling consistent, the loop condition of error handling is modified
> and the 'count++' operation is moved before enetc_map_tx_tso_data().
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 9a24d1176479..fe3967268a19 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  			txbd = ENETC_TXBD(*tx_ring, i);
>  			tx_swbd = &tx_ring->tx_swbd[i];
>  			prefetchw(txbd);
> +			count++;
>  
>  			/* Compute the checksum over this segment of data and
>  			 * add it to the csum already computed (over the L4
> @@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  				goto err_map_data;
>  
>  			data_len -= size;
> -			count++;
>  			bd_data_num++;
>  			tso_build_data(skb, &tso, size);
>  
> @@ -874,13 +874,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  	dev_err(tx_ring->dev, "DMA map error");
>  
>  err_chained_bd:
> -	do {
> +	while (count--) {
>  		tx_swbd = &tx_ring->tx_swbd[i];
>  		enetc_free_tx_frame(tx_ring, tx_swbd);
>  		if (i == 0)
>  			i = tx_ring->bd_count;
>  		i--;
> -	} while (count--);
> +	}
>  
>  	return 0;
>  }

Thanks for fixing it.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1
> 

