Return-Path: <stable+bounces-23589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA904862C5B
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5971C20CBC
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1416415;
	Sun, 25 Feb 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="NyB6hhut"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4618641
	for <stable@vger.kernel.org>; Sun, 25 Feb 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882585; cv=none; b=han05sVhE26OQfzBg1R/H9JpJ3jn1p+y5tcTKijQ8oSURTKuAUiwirE/9HCC6ZaM4HY2DrzGPZm7Oa/i/6SMgsRN76yLr9YjdQDyGqfwSAvrSUkgTnBsXdAmq44RTULjkhm9VSIHWGlZ1tXBPf8RTUxJ1mdvINsdcSd3fAcLH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882585; c=relaxed/simple;
	bh=Pbm3RzxbQ2SWdmzRSuTpOsZgs+kWh29GujagVcBRVkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=THN2WFg+oZrFpgW+CelucsLGBZ+vrO0kITntvjPlYg2a9Y4aLwKfG91EuNyU7m6s91imxZMvR4Zt+0Q8gLiaaEsZGan+ZAgcr41xMnisbsEkCs5mGi6yrIIwsV7xR8+J6i0h8ZH8V1wMlS2X5K/zZjT2XH8iKYQVApnWDbNK7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=NyB6hhut; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1708882265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtii81rRpnJMNSlXpfeG8JgKCpg4AFzMMvt6UXWe7j4=;
	b=NyB6hhut8kvJGxUBKVFWRcib4KqFWzsQcFMgKtVjjkDegy2Wu/KM8q8v83YSegVzqsYI/p
	lVYvCq3re91ldZBA==
Message-ID: <977d5a90-4c4e-446c-aeb7-fb31f7281f17@hardfalcon.net>
Date: Sun, 25 Feb 2024 18:31:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "xhci: fix possible null pointer deref during xhci urb
 enqueue" has been added to the 6.7-stab
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20240223174501.3260504-1-sashal () kernel ! org>
From: Pascal Ernster <git@hardfalcon.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240223174501.3260504-1-sashal () kernel ! org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-02-23 18:45] Sasha Levin:
> This is a note to let you know that I've just added the patch titled
> 
>      xhci: fix possible null pointer deref during xhci urb enqueue
> 
> to the 6.7-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       xhci-fix-possible-null-pointer-deref-during-xhci-urb.patch
> and it can be found in the queue-6.7 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit fb9100c2c6b7b172650ba25283cc4cf9af1d082c
> Author: Mathias Nyman <mathias.nyman@linux.intel.com>
> Date:   Fri Dec 1 17:06:47 2023 +0200
> 
>      xhci: fix possible null pointer deref during xhci urb enqueue
>      
>      [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]
>      
>      There is a short gap between urb being submitted and actually added to the
>      endpoint queue (linked). If the device is disconnected during this time
>      then usb core is not yet aware of the pending urb, and device may be freed
>      just before xhci_urq_enqueue() continues, dereferencing the freed device.
>      
>      Freeing the device is protected by the xhci spinlock, so make sure we take
>      and keep the lock while checking that device exists, dereference it, and
>      add the urb to the queue.
>      
>      Remove the unnecessary URB check, usb core checks it before calling
>      xhci_urb_enqueue()
>      
>      Suggested-by: Kuen-Han Tsai <khtsai@google.com>
>      Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>      Link: https://lore.kernel.org/r/20231201150647.1307406-20-mathias.nyman@linux.intel.com
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 884b0898d9c95..ddb686301af5d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1522,24 +1522,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>   	struct urb_priv	*urb_priv;
>   	int num_tds;
>   
> -	if (!urb)
> -		return -EINVAL;
> -	ret = xhci_check_args(hcd, urb->dev, urb->ep,
> -					true, true, __func__);
> -	if (ret <= 0)
> -		return ret ? ret : -EINVAL;
> -
> -	slot_id = urb->dev->slot_id;
>   	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
> -	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
> -
> -	if (!HCD_HW_ACCESSIBLE(hcd))
> -		return -ESHUTDOWN;
> -
> -	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
> -		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
> -		return -ENODEV;
> -	}
>   
>   	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
>   		num_tds = urb->number_of_packets;
> @@ -1578,12 +1561,35 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>   
>   	spin_lock_irqsave(&xhci->lock, flags);
>   
> +	ret = xhci_check_args(hcd, urb->dev, urb->ep,
> +			      true, true, __func__);
> +	if (ret <= 0) {
> +		ret = ret ? ret : -EINVAL;
> +		goto free_priv;
> +	}
> +
> +	slot_id = urb->dev->slot_id;
> +
> +	if (!HCD_HW_ACCESSIBLE(hcd)) {
> +		ret = -ESHUTDOWN;
> +		goto free_priv;
> +	}
> +
> +	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
> +		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
> +		ret = -ENODEV;
> +		goto free_priv;
> +	}
> +
>   	if (xhci->xhc_state & XHCI_STATE_DYING) {
>   		xhci_dbg(xhci, "Ep 0x%x: URB %p submitted for non-responsive xHCI host.\n",
>   			 urb->ep->desc.bEndpointAddress, urb);
>   		ret = -ESHUTDOWN;
>   		goto free_priv;
>   	}
> +
> +	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
> +
>   	if (*ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
>   		xhci_warn(xhci, "WARN: Can't enqueue URB, ep in streams transition state %x\n",
>   			  *ep_state);


Hi, this patch is causing my laptop (Dell Precision 7530) to crash 
during early boot with a kernel 6.7.6 with all the patches from your 
current stable-queue applied on top 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.7?id=8294c8ea0d96dc8271e87053f7b6731ee5b986ca).

Booting with "module_blacklist=xhci_pci,xhci_pci_renesas" stops the 
crashes. This patch was already thrown out a few weeks ago because it 
was causing problems:

https://lore.kernel.org/stable/2024020331-confetti-ducking-8afb@gregkh/


Regards
Pascal

