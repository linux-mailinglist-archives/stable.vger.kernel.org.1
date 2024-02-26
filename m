Return-Path: <stable+bounces-23601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675A8669CE
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 07:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4285B214C6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9A1B948;
	Mon, 26 Feb 2024 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0K8yL0m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04218EA8
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927316; cv=none; b=oAo8xg9SuOF2FDPbn0K6OwTDRRP8bH+yh6fWyGTu0gF7y4e7P2r8Lgy8vf7fs37olI0msm+oaREVcbwNQUyn+FCJV18m2KRNM2//V47ShcFQPvj0h+ZpKiKxTiLHgMkm+moMQvb2Sf5RCerx0WMTbyB+0tod8gf84hlMpkWq7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927316; c=relaxed/simple;
	bh=NyHhjgHqIojntibUYstzp9V7LWphlWvcEt4ot0gc8x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvSkwuAho2n9k2jruIgSTHx7/y3UlKdcSmNjiMIQHGCN7fLiARz1PEnVJHQyKD140GpQCWap5EoKyO5G8xZkK8IbTD8d8SGyA6w7Ahahy5/oEaSHG+pYC9GivnxvDw4WUPekDIWMD5A76uBb8wGISO7vtQgd0fsogh1NIanuFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b0K8yL0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181FDC433C7;
	Mon, 26 Feb 2024 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708927315;
	bh=NyHhjgHqIojntibUYstzp9V7LWphlWvcEt4ot0gc8x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0K8yL0mAL4pSIB0ho7D1v2ElycCVJMADyBMqHBsBfQxjqHBjKUGb1e/uoglKinjQ
	 h9RxpOXkDeQRgzPP3MrdDukhgeMrkW1pKQS90HMQMsY2Yduq1PJZk+OqLlb6zVZkJw
	 PAiTmA73xH0pBgYRqW3oq4lyDOgJvcIITam/akOs=
Date: Mon, 26 Feb 2024 07:01:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Patch "xhci: fix possible null pointer deref during xhci urb
 enqueue" has been added to the 6.7-stab
Message-ID: <2024022614-omen-bauble-ea55@gregkh>
References: <20240223174501.3260504-1-sashalkernel!org>
 <977d5a90-4c4e-446c-aeb7-fb31f7281f17@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977d5a90-4c4e-446c-aeb7-fb31f7281f17@hardfalcon.net>

On Sun, Feb 25, 2024 at 06:31:04PM +0100, Pascal Ernster wrote:
> [2024-02-23 18:45] Sasha Levin:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      xhci: fix possible null pointer deref during xhci urb enqueue
> > 
> > to the 6.7-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       xhci-fix-possible-null-pointer-deref-during-xhci-urb.patch
> > and it can be found in the queue-6.7 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit fb9100c2c6b7b172650ba25283cc4cf9af1d082c
> > Author: Mathias Nyman <mathias.nyman@linux.intel.com>
> > Date:   Fri Dec 1 17:06:47 2023 +0200
> > 
> >      xhci: fix possible null pointer deref during xhci urb enqueue
> >      [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]
> >      There is a short gap between urb being submitted and actually added to the
> >      endpoint queue (linked). If the device is disconnected during this time
> >      then usb core is not yet aware of the pending urb, and device may be freed
> >      just before xhci_urq_enqueue() continues, dereferencing the freed device.
> >      Freeing the device is protected by the xhci spinlock, so make sure we take
> >      and keep the lock while checking that device exists, dereference it, and
> >      add the urb to the queue.
> >      Remove the unnecessary URB check, usb core checks it before calling
> >      xhci_urb_enqueue()
> >      Suggested-by: Kuen-Han Tsai <khtsai@google.com>
> >      Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> >      Link: https://lore.kernel.org/r/20231201150647.1307406-20-mathias.nyman@linux.intel.com
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >      Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 884b0898d9c95..ddb686301af5d 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1522,24 +1522,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
> >   	struct urb_priv	*urb_priv;
> >   	int num_tds;
> > -	if (!urb)
> > -		return -EINVAL;
> > -	ret = xhci_check_args(hcd, urb->dev, urb->ep,
> > -					true, true, __func__);
> > -	if (ret <= 0)
> > -		return ret ? ret : -EINVAL;
> > -
> > -	slot_id = urb->dev->slot_id;
> >   	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
> > -	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
> > -
> > -	if (!HCD_HW_ACCESSIBLE(hcd))
> > -		return -ESHUTDOWN;
> > -
> > -	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
> > -		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
> > -		return -ENODEV;
> > -	}
> >   	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
> >   		num_tds = urb->number_of_packets;
> > @@ -1578,12 +1561,35 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
> >   	spin_lock_irqsave(&xhci->lock, flags);
> > +	ret = xhci_check_args(hcd, urb->dev, urb->ep,
> > +			      true, true, __func__);
> > +	if (ret <= 0) {
> > +		ret = ret ? ret : -EINVAL;
> > +		goto free_priv;
> > +	}
> > +
> > +	slot_id = urb->dev->slot_id;
> > +
> > +	if (!HCD_HW_ACCESSIBLE(hcd)) {
> > +		ret = -ESHUTDOWN;
> > +		goto free_priv;
> > +	}
> > +
> > +	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
> > +		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
> > +		ret = -ENODEV;
> > +		goto free_priv;
> > +	}
> > +
> >   	if (xhci->xhc_state & XHCI_STATE_DYING) {
> >   		xhci_dbg(xhci, "Ep 0x%x: URB %p submitted for non-responsive xHCI host.\n",
> >   			 urb->ep->desc.bEndpointAddress, urb);
> >   		ret = -ESHUTDOWN;
> >   		goto free_priv;
> >   	}
> > +
> > +	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
> > +
> >   	if (*ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
> >   		xhci_warn(xhci, "WARN: Can't enqueue URB, ep in streams transition state %x\n",
> >   			  *ep_state);
> 
> 
> Hi, this patch is causing my laptop (Dell Precision 7530) to crash during
> early boot with a kernel 6.7.6 with all the patches from your current
> stable-queue applied on top (https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.7?id=8294c8ea0d96dc8271e87053f7b6731ee5b986ca).
> 
> Booting with "module_blacklist=xhci_pci,xhci_pci_renesas" stops the crashes.
> This patch was already thrown out a few weeks ago because it was causing
> problems:
> 
> https://lore.kernel.org/stable/2024020331-confetti-ducking-8afb@gregkh/

Yeah, thanks, this one needs to be dropped as it depended on previous
patches to work properly, I'll go drop them now, thanks!

greg k-h

