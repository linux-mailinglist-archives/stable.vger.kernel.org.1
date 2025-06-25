Return-Path: <stable+bounces-158532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF599AE80AC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DCB3B777A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9042BE7A6;
	Wed, 25 Jun 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/f7HjN7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4229ACF9;
	Wed, 25 Jun 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849929; cv=none; b=VQLALVzBExJfP3IELerk2w4/Wf5y9geeEgwF42f3k2q+I0++pEYAYtFijPE2gwgEoH6R9TVMgCyCj8B6sQhgeQCkPYh3S0OXMY/37xad9yR7U2V1JllOHykm25qp28sWRgQCwArnys3fp6DKFi+5qr5fYlzHIJmPkId5PW8dY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849929; c=relaxed/simple;
	bh=EwORNcbgIUlnJy5nrplIosWhC2iUUhnHDvzip379i94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7+DHWRwLkFoy/rILK+F4NxdVjmWIRyeoBLoDCYpNj1gYHBXZe60srf9VGmRqaQYP7ekYjU65v7utfnTbZIeBsUJS4pixUSe3zSYu+u0RdelF08ajO4bPjfWqs5Or7cpmfVmPZf8kPy8pKvpYruLrDvx/BsY3rBFSuo4QM6lBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/f7HjN7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750849928; x=1782385928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EwORNcbgIUlnJy5nrplIosWhC2iUUhnHDvzip379i94=;
  b=Z/f7HjN7it/t7ls5+OuHzY5bCnAIO+qVLCenycnYuTfbgITq/Ah2pA3M
   no7tJb21PDLX1el2Qb3WOFYm64/qlIkiuSOQ+lOc7hmQ+Vf1aHqAnqZhP
   T4stjtPJ2Yfb8Y3rh+U3GRKo7rHki55P50h+1jq2TUM6lKxfiEy1r0kXw
   JUYjWYLGT/Tuy4GJuJzW++IDJ6uiK52jWCpDyVaqqT6WJYY58LZ7eQ0uY
   Q8K/l/ZbjU8Q5SJX5SYpLbviHlVy48/W7enZOLA/1+qkWWxV9dOqUi0Hg
   YjMArusk355ob1PHQOMHTntfKYQ+yT/DS5f/v7YD9GUnKI0hx+5W1TEiD
   Q==;
X-CSE-ConnectionGUID: vL2FigpORuG4mwFAXmxxsA==
X-CSE-MsgGUID: nG1+pnerQKWYU1wGyGxKxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64175292"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="64175292"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:12:07 -0700
X-CSE-ConnectionGUID: uT19W73XT42S29LUckRsgw==
X-CSE-MsgGUID: gWZkRzfGTvK9giBBtJoc+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152897575"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:12:03 -0700
Date: Wed, 25 Jun 2025 13:11:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Michal Swiatkowski' <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: txgbe: request MISC IRQ in ndo_open
Message-ID: <aFvZOF5zccQ7KCxY@mev-dev.igk.intel.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
 <20250624085634.14372-2-jiawenwu@trustnetic.com>
 <aFu4yUsWek/x9kqd@mev-dev.igk.intel.com>
 <030d01dbe5b2$ab34df70$019e9e50$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030d01dbe5b2$ab34df70$019e9e50$@trustnetic.com>

On Wed, Jun 25, 2025 at 05:22:27PM +0800, Jiawen Wu wrote:
> On Wed, Jun 25, 2025 4:53 PM, Michal Swiatkowski wrote:
> > On Tue, Jun 24, 2025 at 04:56:32PM +0800, Jiawen Wu wrote:
> > > Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
> > > and free it in .ndo_stop, to maintain consistency with the queue IRQs.
> > > This it for subsequent adjustments to the IRQ vectors.
> > >
> > > Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > ---
> > >  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
> > >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++++----------
> > >  2 files changed, 11 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > > index 20b9a28bcb55..dc468053bdf8 100644
> > > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > > @@ -78,7 +78,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
> > >  		free_irq(wx->msix_q_entries[vector].vector,
> > >  			 wx->q_vector[vector]);
> > >  	}
> > > -	wx_reset_interrupt_capability(wx);
> > >  	return err;
> > >  }
> > >
> > > @@ -211,6 +210,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
> > >  	free_irq(txgbe->link_irq, txgbe);
> > >  	free_irq(txgbe->misc.irq, txgbe);
> > >  	txgbe_del_irq_domain(txgbe);
> > > +	txgbe->wx->misc_irq_domain = false;
> > >  }
> > >
> > >  int txgbe_setup_misc_irq(struct txgbe *txgbe)
> > > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > > index f3d2778b8e35..a5867f3c93fc 100644
> > > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > > @@ -458,10 +458,14 @@ static int txgbe_open(struct net_device *netdev)
> > >
> > >  	wx_configure(wx);
> > >
> > > -	err = txgbe_request_queue_irqs(wx);
> > > +	err = txgbe_setup_misc_irq(wx->priv);
> > 
> > Don't you need misc interrupt before ndo_open is called? I wonder if it
> > won't be simpler to always use last index (8) for misc irq. Is it
> > possible? I mean, use 8 event if the number of queues is lower than 8.
> > If yes you can drop this patch and hardcode misc interrupts on index 8.
> > 
> > [...]
> > 
> > BTW, assuming you can't always use last index, the patch looks fine.
> 
> Cannot always use index (8). Because the max RSS index is 63 for TXGBE,
> but 8 for NGBE. This hardware limitation is only for NGBE. And index (8)
> cannot be used by PF when SRIOV is enabled on NGBE.
> 
> In fact, the misc interrupt is only used when the device is opened.
> 
> 

Ok, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

