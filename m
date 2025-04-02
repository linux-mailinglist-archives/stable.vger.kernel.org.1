Return-Path: <stable+bounces-127378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEAA78781
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 07:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2507A4500
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9520C46D;
	Wed,  2 Apr 2025 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQFCvrRI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EB1917D6;
	Wed,  2 Apr 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570634; cv=none; b=Rig6RqP7fkTrA9x6fWiFGphe6+eLwDUrys5DfqxmA3ee6mEwhKWHOQZQInkAHAFzMOQdKMkH11AHQlOqs//X/H4GfDhPhpgCRsgeophZmdjyXZL6vBO06XhWjA3sj5AFIYSYCmvcZ6wJjxV4aTevOpwMGpB72neuVUuSt1nau4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570634; c=relaxed/simple;
	bh=grZPU9oPQcN0TENqzwiUIqv/0tkINZLoV8QdjaVk4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdLorA2OHWIE0qYpg0/Unvf1GSRMpLvBmcVL30OsBv7+9NCJ5V5hW02BCUkZ1z2bsvFJMU66GNdMW/xJof+TJKhZ/VzjpOiGuauLfY7OEvTr5xpz/yxM9/N5O4G3GshztkgC8cLzTFMmhJI5AFQzSI9o6pknGg9TfxB2tjo9RhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQFCvrRI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743570632; x=1775106632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=grZPU9oPQcN0TENqzwiUIqv/0tkINZLoV8QdjaVk4ms=;
  b=EQFCvrRIvajSsqqZhBdzcTLPrVBY/3IpIYyNgW0vqMfpjUDf67u4xVLq
   T1OsphOs69Pfnribq76IRUPwVOG3BvuZ8Yq+mYXaDpLQPfKuA+Tlr5QTY
   V5+YNHFmc7V8bzV32PfYlhf6f0VEgVArXASXJe9xZod7qREEti3ozwZis
   zkHYXtBklQpNYwcmmOqQ2oc+ueDHy+QR2aj39Vo883to8yP6L5J7ZZhON
   HJWFbjVBlMHV8W6E66sAQKe1BaRYzu83ZFK5by3/51UT0nN6MU92/3r1Y
   gDBQi1wJh1yFrUpyOTwvHBLHiPcaRShucYUOdIgWJeY6s0VCrnRZZXuuL
   A==;
X-CSE-ConnectionGUID: AxM7Mw19Tm+2crt10Z/C3g==
X-CSE-MsgGUID: gPIa0Rq/SkWEBluKdREBSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="62316430"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="62316430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 22:10:32 -0700
X-CSE-ConnectionGUID: lJLrnvqyQ6+t3OLQZ1mEug==
X-CSE-MsgGUID: yDnFL7ROQt+M+lRdqiM+GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="131570397"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 22:10:28 -0700
Date: Wed, 2 Apr 2025 07:10:18 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com,
	joshwash@google.com, horms@kernel.org, shailend@google.com,
	jrkim@google.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: handle overflow when reporting TX consumed
 descriptors
Message-ID: <Z+zGrWljk7u91VMY@mev-dev.igk.intel.com>
References: <20250402001037.2717315-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402001037.2717315-1-hramamurthy@google.com>

On Wed, Apr 02, 2025 at 12:10:37AM +0000, Harshitha Ramamurthy wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> When the tx tail is less than the head (in cases of wraparound), the TX
> consumed descriptor statistic in DQ will be reported as
> UINT32_MAX - head + tail, which is incorrect. Mask the difference of
> head and tail according to the ring size when reporting the statistic.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2c9198356d56 ("gve: Add consumed counts to ethtool stats")
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 31a21ccf4863..4dea1fdce748 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -392,7 +392,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  				 */
>  				data[i++] = 0;
>  				data[i++] = 0;
> -				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
> +				data[i++] =
> +					(tx->dqo_tx.tail - tx->dqo_tx.head) &
> +					tx->mask;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

I will add it in gve_tx_dqo.c as num_used_tx_slots() and simplify
num_avail_tx_slots()
{
	return tx->mask - num_used_tx_slots();
}
but it isn't needed, even maybe unwanted as this is just fix.

Thanks

>  			}
>  			do {
>  				start =
> -- 
> 2.49.0.472.ge94155a9ec-goog

