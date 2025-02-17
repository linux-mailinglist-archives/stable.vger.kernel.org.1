Return-Path: <stable+bounces-116582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B2A38489
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D11886BC9
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63021CA17;
	Mon, 17 Feb 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAjCxV3U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8A21CA19;
	Mon, 17 Feb 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798631; cv=none; b=lSZDjcSR8JKRc9+pnvNGw1D1cFPmAiJ3mjHFpv0V+6ZlwMXpDWgS1abYVsBanW9UXzjGrPzmisNNofXJihMwy/rmzAENnZ0wfESRV0pZe+LsbgEdqVjWuJ4Hr4wNBYqwTVpV7RdNh3Vf/y6YwBMwfxeiydDDiSFtyHoOqpIQzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798631; c=relaxed/simple;
	bh=5jI7yAwfnD29sHW7cjA1e58vatW5I20of910rii2ypU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGINllIBWoQtfinMewLZ6qNBdnURhl20LWV1vabIpcW/3a6gl3C4Bgl13Jl0kF/UsqliH6FcGpuvf7FQSRqzb4heb2qp25P4jgZMkyUcKLl1AUJ9QVaNO6p3j+IV8Clp+U5v18jzNdufvY9KeKJRCPquVKPOIwp316Ew+GfMVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAjCxV3U; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739798630; x=1771334630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jI7yAwfnD29sHW7cjA1e58vatW5I20of910rii2ypU=;
  b=EAjCxV3U/YuenkFW+m17C/DRreYggzzzolC5xsuLJi9jKCiJzEWw4hvE
   0yavNJbYbcyABioRVzJmTqjLDw3w2wCCWclXkWPi3tKPVBMDk9msqD7ew
   wyAdFf8zTbJlAKO7pUNxTiOPKaFJlYHXVTGWoHMbziIHUshKYilGk/D55
   3dkveDGTogWUrbbf9w7Os1zBbEVEU75gyMe6CaQ6VHPar04JDNlcHRPuQ
   5l5UgHmYLXFKrcUO6vfxQZo2ukdMaDC8IdFv747uPEA5AxkAtsfKe1uWR
   8biTpPT4N23bYGk7mi12lWHj5+UZKDl6ny8cX5uXEC+Xh+xmMx9J6OQoT
   A==;
X-CSE-ConnectionGUID: efiP2CjQTfyPlVXCi4Dguw==
X-CSE-MsgGUID: MUUIoKuXSu2kg/fKtpN0zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44407675"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44407675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 05:23:49 -0800
X-CSE-ConnectionGUID: dravQctqRiSK8gousaJ5GQ==
X-CSE-MsgGUID: itWmg63nSVmT3xLBpY/ocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="119123696"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 05:23:46 -0800
Date: Mon, 17 Feb 2025 14:20:05 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/8] net: enetc: correct the tx_swbd statistics
Message-ID: <Z7M3heKHsQBvIRBi@mev-dev.igk.intel.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217093906.506214-3-wei.fang@nxp.com>

On Mon, Feb 17, 2025 at 05:39:00PM +0800, Wei Fang wrote:
> When creating a TSO header, if the skb is VLAN tagged, the extended BD
> will be used and the 'count' should be increased by 2 instead of 1.
> Otherwise, when an error occurs, less tx_swbd will be freed than the
> actual number.
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index f7bc2fc33a76..0a1cea368280 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -759,6 +759,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +	bool ext_bd = skb_vlan_tag_present(skb);
>  	int hdr_len, total_len, data_len;
>  	struct enetc_tx_swbd *tx_swbd;
>  	union enetc_tx_bd *txbd;
> @@ -792,7 +793,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
>  		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
>  		bd_data_num = 0;
> -		count++;
> +		count += ext_bd ? 2 : 1;

Looks fine, beside you need to fix the unroll like in patch 1.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


>  
>  		while (data_len > 0) {
>  			int size;
> -- 
> 2.34.1

