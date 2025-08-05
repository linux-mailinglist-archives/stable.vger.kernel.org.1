Return-Path: <stable+bounces-166649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD47B1BB6A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BDD17EB16
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07524293C;
	Tue,  5 Aug 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWTaRXwr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD232288EE;
	Tue,  5 Aug 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425734; cv=none; b=pKtClcoTpetuvTU1x7x5g+T1WcXA0VbFcLVmSaPkU/zkHzE/EPWYPFahypUC4D6orX1nxqqWvxTIG+wJ7rmrALpPi2wEvWOf2CQd7InNeMHnnag8kNlhLl6MlN6B/doAakf/2ayi7fKCDP8eU18gCcbqoh7z4BWUDR1D/sUfixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425734; c=relaxed/simple;
	bh=YUMbxHcRNoIfqwQxljcPeXk9kSyXJnB46QcCKO9sHAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfuOS4tsm/MNq0EKW5f/cHhvdUa1kBRy3TRpbttnvvyai4HoaVJVcrF5UVtl54Pdc4nZ6ygkwlr2P/AcoN9AXciT4cch0BTEnpkk+87frAmxd4ziJVV4nV8Kk6YyJabwHNTDRCePPH7O60s5DViJ8MD5+12NmN3JOVaWOnm65A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWTaRXwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD93C4CEF0;
	Tue,  5 Aug 2025 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754425733;
	bh=YUMbxHcRNoIfqwQxljcPeXk9kSyXJnB46QcCKO9sHAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWTaRXwrgo9ImyO1w340UuQ8einL4MAGC7EV2ZcHyQBxZ2HnR+HsXX0TiZfbaP5rl
	 iCpBBu3ybnBIxJBmUHpLy06tLPPwTrzomFLD847y+P2+hdQn4xwlapy44r5KOpF+J/
	 JdPf6EpAcSN5AF2UvhKi3xlyrxirAF7BPJf6kRHpmhI1XvWrXboss032P9Ug7KyHpS
	 p9u3rn8j4p0xJtPCF4Y2sWAA+w6IJ0NGPtsD5kj9jf5tLJagv/2+vw0QtAaQzY9vH1
	 N6jglhmyaXjAfECeNhz0NQRB+exQwBA5BtQQXo58/fsl+At6eXnoRh0tR8PToqJ74P
	 avX6r5bzQBIWg==
Date: Tue, 5 Aug 2025 21:28:48 +0100
From: Simon Horman <horms@kernel.org>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <20250805202848.GC61519@horms.kernel.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804100050.GQ8494@horms.kernel.org>

+ Linus

On Mon, Aug 04, 2025 at 11:00:50AM +0100, Simon Horman wrote:
> + John Ernberg
> 
> On Sat, Aug 02, 2025 at 02:03:10AM +0700, Ammar Faizi wrote:
> > The commit in the Fixes tag breaks my laptop (found by git bisect).
> > My home RJ45 LAN cable cannot connect after that commit.
> > 
> > The call to netif_carrier_on() should be done when netif_carrier_ok()
> > is false. Not when it's true. Because calling netif_carrier_on() when
> > __LINK_STATE_NOCARRIER is not set actually does nothing.
> > 
> > Cc: Armando Budianto <sprite@gnuweeb.org>
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
> > Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
> > Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > ---
> > 
> > v2:
> >   - Rebase on top of the latest netdev/net tree. The previous patch was
> >     based on 0d9cfc9b8cb1. Line numbers have changed since then.
> > 
> >  drivers/net/usb/usbnet.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)

It seems this has escalated a bit as it broke things for Linus while
he was travelling. He tested this patch and it resolved the problem.
Which I think counts for something.

https://lore.kernel.org/netdev/CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com/

I have looked over the patch and it appears to me that it addresses a
straightforward logic error: a check was added to turn the carrier on only
if it is already on. Which seems a bit nonsensical. And presumably the
intention was to add the check for the opposite case.

This patch addresses that problem.

So let me try and nudge this on a bit by providing a tag.

Reviewed-by: Simon Horman <horms@kernel.org>

> > 
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index a38ffbf4b3f0..a1827684b92c 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -1114,31 +1114,31 @@ static const struct ethtool_ops usbnet_ethtool_ops = {
> >  };
> >  
> >  /*-------------------------------------------------------------------------*/
> >  
> >  static void __handle_link_change(struct usbnet *dev)
> >  {
> >  	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
> >  		return;
> >  
> >  	if (!netif_carrier_ok(dev->net)) {
> > +		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> > +			netif_carrier_on(dev->net);
> > +
> >  		/* kill URBs for reading packets to save bus bandwidth */
> >  		unlink_urbs(dev, &dev->rxq);
> >  
> >  		/*
> >  		 * tx_timeout will unlink URBs for sending packets and
> >  		 * tx queue is stopped by netcore after link becomes off
> >  		 */
> >  	} else {
> > -		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
> > -			netif_carrier_on(dev->net);
> > -
> >  		/* submitting URBs for reading packets */
> >  		queue_work(system_bh_wq, &dev->bh_work);
> >  	}
> >  
> >  	/* hard_mtu or rx_urb_size may change during link change */
> >  	usbnet_update_max_qlen(dev);
> >  
> >  	clear_bit(EVENT_LINK_CHANGE, &dev->flags);
> >  }
> >  
> > -- 
> > Ammar Faizi
> > 
> > 
> 

