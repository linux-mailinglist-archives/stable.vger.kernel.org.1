Return-Path: <stable+bounces-46285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087188CFC28
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7C4283463
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95E60B96;
	Mon, 27 May 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqK6yWSJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699D56477;
	Mon, 27 May 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799818; cv=none; b=kWKwqfReCoGqyPUBah9DdZ1JA67NigZwWvxSdxxDiVAb1ZxGR+1xLKYE7RYZPAlz7MUXPKlOp/WvS7XMTxxd0sQ1yiwFr0/Sx7kvyLDrugKFq23Rr6yiJJemWkTiqiYTclNyzEcPGnMDr2DZmlAJMu/kIwhe9jnpMWZWKwI3g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799818; c=relaxed/simple;
	bh=XVMmb0jA3x8IvBNZW56yDA6N/Fuj1xxbiI7+65ezmCE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=bHWt8DE3HJXcWlKeFtio5j1BHb7BVtOj+HD/nt+Ca3EBm4W2ylJZlzNYAfWr6crDqXqtN0uTnG1zS8iVbvGzMAxJi5YKgsX5gwXJYTX3FvWwS1RX0yLVdel5IENl3dh7QfxwP6IKYWIsDUeJII785B86+w1vwl9j/orooOv/1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqK6yWSJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716799815; x=1748335815;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XVMmb0jA3x8IvBNZW56yDA6N/Fuj1xxbiI7+65ezmCE=;
  b=TqK6yWSJwxREuvM66xM+B6KU94oD3gdBTCE9appinBkWv6jolqtUGjs0
   rv0APS3wuhxeS2re6UaRswovzpbXRle8wJCIP/jpsQj0AF8QYjXM2CPEg
   172eqEEBqFAxvhrIgwxK7bmLs8t3eb1OvHEzNShIRoU5PXowzh5gem8TI
   ugN0nrLJ3AdbWrk8qzPuwc0gbzPUXJ7fIqFxKubbBCKAUP29mFal44NYJ
   8QfgQFRp3NLEeU86lUmWaq0rfY660xpGHPCG9+hBjd3HyCzbq8FSXqjQn
   2Q/WcwL63DlJL3OQHSF0CuQQCwO/dRbgP5/ilRY8XDf9NF2NqGKLIVywy
   g==;
X-CSE-ConnectionGUID: AvkB2nGwS0aKXSnwFpr+rg==
X-CSE-MsgGUID: wpYj0PGQQi6VJknU00vcew==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13328457"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13328457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 01:50:15 -0700
X-CSE-ConnectionGUID: KOSpGiLZTDyguUlL2LTGfw==
X-CSE-MsgGUID: JbSCY0uPShu1B8RosVYHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39247902"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 27 May 2024 01:50:12 -0700
Message-ID: <c10d7c1a-6e3a-ff11-1eae-363eda02ef05@linux.intel.com>
Date: Mon, 27 May 2024 11:52:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, stable@vger.kernel.org, security@kernel.org
References: <20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Handle TD clearing for multiple streams case
In-Reply-To: <20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 24.5.2024 13.28, Hector Martin wrote:
> When multiple streams are in use, multiple TDs might be in flight when
> an endpoint is stopped. We need to issue a Set TR Dequeue Pointer for
> each, to ensure everything is reset properly and the caches cleared.
> Change the logic so that any N>1 TDs found active for different streams
> are deferred until after the first one is processed, calling
> xhci_invalidate_cancelled_tds() again from xhci_handle_cmd_set_deq() to
> queue another command until we are done with all of them. Also change
> the error/"should never happen" paths to ensure we at least clear any
> affected TDs, even if we can't issue a command to clear the hardware
> cache, and complain loudly with an xhci_warn() if this ever happens.
> 
> This problem case dates back to commit e9df17eb1408 ("USB: xhci: Correct
> assumptions about number of rings per endpoint.") early on in the XHCI
> driver's life, when stream support was first added. At that point, this
> condition would cause TDs to not be given back at all, causing hanging
> transfers - but no security bug.

At this point all cancelled URBs were always given back, and always before
cache was cleared. Cache was also never cleared for the second, or later
stream rings if more than one stream had cancelled URBs.


> It was then identified but not fixed
> nor made into a warning in commit 674f8438c121 ("xhci: split handling
> halted endpoints into two steps"), which added a FIXME comment for the
> problem case (without materially changing the behavior as far as I can
> tell, though the new logic made the problem more obvious).

This rework ensured URB were given back _after_ they were cleared from xHC
cache. While reworking this it was noticed that something is not correct with
how driver clears TRBs from xHC cache in the case when cancelled URBS
exists on several separate stream rings.

No changes were made to stream ring cache clearing.

> 
> Then later, in commit 94f339147fc3 ("xhci: Fix failure to give back some
> cached cancelled URBs."), it was acknowledged again. This commit was
> unfortunately not reviewed at all, as it was authored by the maintainer
> directly. Had it been, perhaps a second set of eyes would've noticed
> that it does not fix the bug, but rather just makes it (much) worse.
> It turns the "transfers hang" bug into a "random memory corruption" bug,
> by blindly marking TDs as complete without actually clearing them at all
> nor moving the dequeue pointer past them, which means they aren't actually
> complete, and the xHC will try to transfer data to/from them when the
> endpoint resumes, now to freed memory buffers.

94f339147fc3 ("xhci: Fix failure to give back some cached cancelled URBs.")
fixed the regression caused by previous patch. Users reported issues with
usb stuck after unmounting/disconnecting UAS devices. This had to be resolved
and the options at this point were reverting the whole thing, or only roll
back this targeted streams area to its original condition, not made worse.

Commit was discussed, and first sent as RFT:

https://lore.kernel.org/linux-usb/20210813134729.2402607-1-mathias.nyman@linux.intel.com/
https://lore.kernel.org/linux-usb/e1feb74fa95ca1f19729bf959f73f30f@codeaurora.org/

> 
> This could have been a legitimate oversight, but apparently the commit
> author was aware of the problem (yet still chose to submit it): It was
> still mentioned as a FIXME, an xhci_dbg() was added to log the problem
> condition, and the remaining issue was mentioned in the commit
> description. The choice of making the log type xhci_dbg() for what is,
> at this point, a completely unhandled and known broken condition is
> puzzling and unfortunate, as it guarantees that no actual users would
> see the log in production, thereby making it nigh undebuggable (indeed,
> even if you turn on DEBUG, the message doesn't really hint at there
> being a problem at all).
> 
> It took me *months* of random xHC crashes to finally find a reliable
> repro and be able to do a deep dive debug session, which could all have
> been avoided had this unhandled, broken condition been actually reported
> with a warning, as it should have been as a bug intentionally left in
> unfixed (never mind that it shouldn't have been left in at all).
> 
>> Another fix to solve clearing the caches of all stream rings with
>> cancelled TDs is needed, but not as urgent.
> 
> 3 years after that statement and 14 years after the original bug was
> introduced, I think it's finally time to fix it. And maybe next time
> let's not leave bugs unfixed (that are actually worse than the original
> bug), and let's actually get people to review kernel commits please.

Issue was only seen at UAS unmount/disconnect where xHC cache clearing
shouldn't be problem. Whole case wasn't assumed to be an issue otherwise.
We didn't want to spam users with irrelevant warnings at unmount/disconnect
but added the debug message and description of issue in code and commit
message.

Issue has always been there (14 years).
After 9 years it was noted during another more urgent regression fix, so
a debug message with description was added.
Other cases were then prioritized over this.

Now 3 years later it hit you.

Debugging this sounds frustrating.
I really appreciate you doing this. Your solution is small and clean,
I like it.
I could not come up with something like this while trying to resolve the
regression.

Please don't hesitate to ask for debugging help next time, no need to do
it all by yourself.

> 
> Fixes xHC crashes and IOMMU faults with UAS devices when handling
> errors/faults. Easiest repro is to use `hdparm` to mark an early sector
> (e.g. 1024) on a disk as bad, then `cat /dev/sdX > /dev/null` in a loop.
> At least in the case of JMicron controllers, the read errors end up
> having to cancel two TDs (for two queued requests to different streams)
> and the one that didn't get cleared properly ends up faulting the xHC
> entirely when it tries to access DMA pages that have since been unmapped,
> referred to by the stale TDs. This normally happens quickly (after two
> or three loops). After this fix, I left the `cat` in a loop running
> overnight and experienced no xHC failures, with all read errors
> recovered properly. Repro'd and tested on an Apple M1 Mac Mini
> (dwc3 host).
> 
> On systems without an IOMMU, this bug would instead silently corrupt
> freed memory, making this a security bug (even on systems with IOMMUs
> this could silently corrupt memory belonging to other USB devices on the
> same controller, so it's still a security bug). Given that the kernel
> autoprobes partition tables, I'm pretty sure a malicious USB device
> pretending to be a UAS device and reporting an error with the right
> timing could deliberately trigger a UAF and write to freed memory, with
> no user action.
> 
> Fixes: e9df17eb1408 ("USB: xhci: Correct assumptions about number of rings per endpoint.")
> Fixes: 94f339147fc3 ("xhci: Fix failure to give back some cached cancelled URBs.")
> Fixes: 674f8438c121 ("xhci: split handling halted endpoints into two steps")
> Cc: stable@vger.kernel.org
> Cc: security@kernel.org
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/usb/host/xhci-ring.c | 54 +++++++++++++++++++++++++++++++++++---------
>   drivers/usb/host/xhci.h      |  1 +
>   2 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 575f0fd9c9f1..9c06502be098 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1034,13 +1034,27 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
>   				break;
>   			case TD_DIRTY: /* TD is cached, clear it */
>   			case TD_HALTED:
> +			case TD_CLEARING_CACHE_DEFERRED:
> +				if (cached_td) {
> +					if (cached_td->urb->stream_id != td->urb->stream_id) {
> +						/* Multiple streams case, defer move dq */
> +						xhci_dbg(xhci,
> +							 "Move dq deferred: stream %u URB %p\n",
> +							 td->urb->stream_id, td->urb);
> +						td->cancel_status = TD_CLEARING_CACHE_DEFERRED;
> +						break;
> +					}
> +
> +					/* Should never happen, at least try to clear the TD if it does */

This while "should never happen" case could probably be removed.

> +					xhci_warn(xhci,
> +						  "Found multiple active URBs %p and %p in stream %u?\n",
> +						  td->urb, cached_td->urb,
> +						  td->urb->stream_id);
> +					td_to_noop(xhci, ring, cached_td, false);
> +					cached_td->cancel_status = TD_CLEARED;
> +				}
> +
>   				td->cancel_status = TD_CLEARING_CACHE;
> -				if (cached_td)
> -					/* FIXME  stream case, several stopped rings */
> -					xhci_dbg(xhci,
> -						 "Move dq past stream %u URB %p instead of stream %u URB %p\n",
> -						 td->urb->stream_id, td->urb,
> -						 cached_td->urb->stream_id, cached_td->urb);
>   				cached_td = td;
>   				break;
>   			}
> @@ -1060,10 +1074,16 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
>   	if (err) {
>   		/* Failed to move past cached td, just set cached TDs to no-op */
>   		list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
> -			if (td->cancel_status != TD_CLEARING_CACHE)
> +			/*
> +			 * Deferred TDs need to have the deq pointer set after the above command
> +			 * completes, so if that failed we just give up on all of them (and
> +			 * complain loudly since this could cause issues due to caching).
> +			 */
> +			if (td->cancel_status != TD_CLEARING_CACHE &&
> +			    td->cancel_status != TD_CLEARING_CACHE_DEFERRED)
>   				continue;
> -			xhci_dbg(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
> -				 td->urb);
> +			xhci_warn(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
> +				  td->urb);
>   			td_to_noop(xhci, ring, td, false);
>   			td->cancel_status = TD_CLEARED;
>   		}
> @@ -1350,6 +1370,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
>   	struct xhci_ep_ctx *ep_ctx;
>   	struct xhci_slot_ctx *slot_ctx;
>   	struct xhci_td *td, *tmp_td;
> +	bool deferred = false;
>   
>   	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
>   	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
> @@ -1436,6 +1457,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
>   			xhci_dbg(ep->xhci, "%s: Giveback cancelled URB %p TD\n",
>   				 __func__, td->urb);
>   			xhci_td_cleanup(ep->xhci, td, ep_ring, td->status);
> +		} else if (td->cancel_status == TD_CLEARING_CACHE_DEFERRED) {
> +			deferred = true;
>   		} else {
>   			xhci_dbg(ep->xhci, "%s: Keep cancelled URB %p TD as cancel_status is %d\n",
>   				 __func__, td->urb, td->cancel_status);
> @@ -1445,8 +1468,17 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
>   	ep->ep_state &= ~SET_DEQ_PENDING;
>   	ep->queued_deq_seg = NULL;
>   	ep->queued_deq_ptr = NULL;
> -	/* Restart any rings with pending URBs */
> -	ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
> +
> +	if (deferred) {
> +		/* We have more streams to clear */
> +		xhci_dbg(ep->xhci, "%s: Pending TDs to clear, continuing with invalidation\n",
> +			 __func__);
> +		xhci_invalidate_cancelled_tds(ep);
> +	} else {
> +		/* Restart any rings with pending URBs */
> +		xhci_dbg(ep->xhci, "%s: All TDs cleared, ring doorbell\n", __func__);
> +		ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
> +	}
>   }
>   
>   static void xhci_handle_cmd_reset_ep(struct xhci_hcd *xhci, int slot_id,
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 6f4bf98a6282..aa4379bdb90c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1276,6 +1276,7 @@ enum xhci_cancelled_td_status {
>   	TD_DIRTY = 0,
>   	TD_HALTED,
>   	TD_CLEARING_CACHE,
> +	TD_CLEARING_CACHE_DEFERRED,
>   	TD_CLEARED,
>   };

I like this solution, can't immediately find any issues with it.
Commit message makes some hasty assumptions.

Thanks
Mathias


