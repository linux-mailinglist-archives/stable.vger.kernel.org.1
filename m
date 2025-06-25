Return-Path: <stable+bounces-158514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C9AE7B34
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D517B6FA7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB327F73D;
	Wed, 25 Jun 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db6iaAPP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8C27EFEA;
	Wed, 25 Jun 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841622; cv=none; b=YjKLJrhXMcg9gxJCrweotkeKimh9IiFXt6772mopifhvWW2PRZ9wzrpLaSHAm2RjNxIB8p94L0ZbUra248BaUZcNFS6FeSiF+AG87oV9kLHgdZh3s3WTfWmC+Wu8dZbFAL9jsBn4NVaFgzMmNN72w5At25+U/ak/MfJAC5w8fII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841622; c=relaxed/simple;
	bh=sbR5bzeR9B14+orF7aU5BQhpGADtGkzXTRYNSKp93Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f34+Q0Hwr+3ZpCdo7+RMJ79ayCpqETO+akzrI9oqEs69639jYuE5baS31w1JNMrlO8OXPas1joe6vVQW2IXRzDElMZ5tGWBtNpvY++7JrJ4i78BEj4UyhEuGBl6HmgMAj+AgDQ/a8VQDejcvqvyVHZ+JfYGvUvXSFbGCUEDWepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db6iaAPP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750841620; x=1782377620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sbR5bzeR9B14+orF7aU5BQhpGADtGkzXTRYNSKp93Ug=;
  b=Db6iaAPPT1DR1v/+Ru/F5TSRQgJRflV6qPetFc8cDgyWnaKW6a+F4r1u
   R7vpLU8sWJ1Nh0fxcuU2rJRVv5y++sy5wHDGtd2iIT9EPbu16g8sHgnha
   SESRfntfAOxO/ciUULrvzAXCzSdHDwvdhj3u7iapthoWKcxa40d0r+Jnj
   p7Ci/f95XvsUSh/QooeMY53KfKDWCSGeRf5/pQwXn2g9ZC2Jn3+m7V0BI
   w5KtlQVQVXe3iYeb1DsUpOE1rP0dX7ATO7m7kX/I4pJOBCOUm/zwAGDIR
   q/BdD2zDCs7LvQXo3ZJbNp90tbJLiobHvGpGpZ3JY8MPysuVoCbAzf8+r
   A==;
X-CSE-ConnectionGUID: DSICgPSVRh6IuTPH3/07Dg==
X-CSE-MsgGUID: Boh1PC/QQ3CTEQYOd6rHUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63703497"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="63703497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:53:40 -0700
X-CSE-ConnectionGUID: 70mQxObcS0uyAvG4Ue8REA==
X-CSE-MsgGUID: Kz2FA0ryQ3utlvE936/PQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="183191401"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:53:35 -0700
Date: Wed, 25 Jun 2025 10:52:36 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: txgbe: request MISC IRQ in ndo_open
Message-ID: <aFu4yUsWek/x9kqd@mev-dev.igk.intel.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
 <20250624085634.14372-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624085634.14372-2-jiawenwu@trustnetic.com>

On Tue, Jun 24, 2025 at 04:56:32PM +0800, Jiawen Wu wrote:
> Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
> and free it in .ndo_stop, to maintain consistency with the queue IRQs.
> This it for subsequent adjustments to the IRQ vectors.
> 
> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++++----------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index 20b9a28bcb55..dc468053bdf8 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -78,7 +78,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
>  		free_irq(wx->msix_q_entries[vector].vector,
>  			 wx->q_vector[vector]);
>  	}
> -	wx_reset_interrupt_capability(wx);
>  	return err;
>  }
>  
> @@ -211,6 +210,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
>  	free_irq(txgbe->link_irq, txgbe);
>  	free_irq(txgbe->misc.irq, txgbe);
>  	txgbe_del_irq_domain(txgbe);
> +	txgbe->wx->misc_irq_domain = false;
>  }
>  
>  int txgbe_setup_misc_irq(struct txgbe *txgbe)
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index f3d2778b8e35..a5867f3c93fc 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -458,10 +458,14 @@ static int txgbe_open(struct net_device *netdev)
>  
>  	wx_configure(wx);
>  
> -	err = txgbe_request_queue_irqs(wx);
> +	err = txgbe_setup_misc_irq(wx->priv);

Don't you need misc interrupt before ndo_open is called? I wonder if it
won't be simpler to always use last index (8) for misc irq. Is it
possible? I mean, use 8 event if the number of queues is lower than 8.
If yes you can drop this patch and hardcode misc interrupts on index 8.

[...]

BTW, assuming you can't always use last index, the patch looks fine.

