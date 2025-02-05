Return-Path: <stable+bounces-113912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79449A294A0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3EA3AB4B0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F981E89C;
	Wed,  5 Feb 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrU9+IBS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC0170A37;
	Wed,  5 Feb 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768593; cv=none; b=X9dW8qqdG4qsi1HRap5pzn3kf2p0qP2N2oziokLrJcSDM94+YSGKyH3nQDaHS7+rkVgaMixajXdfi2Cabmxpqh2Rpy1ncHp6uijbYjx6r6/L3Uy5qKtUJmxiuUhMRiNwbO2SKmgksvfRl2XbheItskccWWQNXcs5L/j/LK2j9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768593; c=relaxed/simple;
	bh=pValUP4hr2J0vvV8MW/5VeEnUuSXcQUdwrR24hMQsRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCe6Kl9drydRUwISsofsLQfHIDD5x4DT2cpsYxp5GDIQtXaihlQvjzjR51duhY7z/ANBRuDVbmfTykxtEEtn+nLJV68adPUCl50q7oV4DkKGCk4gXlhlqmE4ERT7jMePsuQC20MJ16kfE3QvC6PRYX9lslbrQZ2IN3+0lggNmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrU9+IBS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768592; x=1770304592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pValUP4hr2J0vvV8MW/5VeEnUuSXcQUdwrR24hMQsRY=;
  b=DrU9+IBSDVID2ln5UOnNFwKFznn1N+kdAw374dZX/we9PrrZHeVy5z6M
   JAhWV821/u2e35YGGH9RC/e0RkMGH8zhVNIy14gE75YjYjBfW+QliVjSj
   j3oCr74NuxQlC434vaJWjhBi//+UnRSx/KBt/ZN4plhZyjpImFLcp/Lzc
   H5DEXGzSKHk6uWEMAT1D3YcTBAtdyMqc/VSXtkKRpQx/8/maZKLpbnlDH
   dOKVXdYllA9CuV845/gZJyKXSMpngjK2nsSUCOLOxvU8VPG14fukfiJsH
   nXm8HA5O7Bt/sY9wb9aadahIxTcdF76QxZ6LVeDVtUT+2tvvFbL12EMSQ
   g==;
X-CSE-ConnectionGUID: 1iX/xyKNQEmplWD6xOU3bw==
X-CSE-MsgGUID: 5fgr7D2pTAy1MHvMd6dzpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49588336"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="49588336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:16:31 -0800
X-CSE-ConnectionGUID: ZiEKmQthRL2CLa3uaoXM4g==
X-CSE-MsgGUID: CWa3BaI4TTyLolJDpB+lPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111814806"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa008.jf.intel.com with ESMTP; 05 Feb 2025 07:16:29 -0800
Message-ID: <69eccfa6-5ca0-44d7-b6a8-2152260106e2@linux.intel.com>
Date: Wed, 5 Feb 2025 17:17:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250205053750.28251-1-ki.chiang65@gmail.com>
 <20250205053750.28251-2-ki.chiang65@gmail.com>
 <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5.2.2025 16.17, Mathias Nyman wrote:
> On 5.2.2025 7.37, Kuangyi Chiang wrote:
>> Unplugging a USB3.0 webcam while streaming results in errors like this:
>>
>> [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
>> [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
>> [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
>> [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
>>
>> If an error is detected while processing the last TRB of an isoc TD,
>> the Etron xHC generates two transfer events for the TRB where the
>> error was detected. The first event can be any sort of error (like
>> USB Transaction or Babble Detected, etc), and the final event is
>> Success.
>>
>> The xHCI driver will handle the TD after the first event and remove it
>> from its internal list, and then print an "Transfer event TRB DMA ptr
>> not part of current TD" error message after the final event.
>>
>> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
>> transaction error mid TD.") is designed to address isoc transaction
>> errors, but unfortunately it doesn't account for this scenario.
>>
>> To work around this by reusing the logic that handles isoc transaction
>> errors, but continuing to wait for the final event when this condition
>> occurs. Sometimes we see the Stopped event after an error mid TD, this
>> is a normal event for a pending TD and we can think of it as the final
>> event we are waiting for.
> 
> Not giving back the TD when we get an event for the last TRB in the
> TD sounds risky. With this change we assume all old and future ETRON hosts
> will trigger this additional spurious success event.
> 
> I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case seen
> with short transfers, and just silence the error message.
> 
> Are there any other issues besides the error message seen?
> 

Would something like this work: (untested, compiles)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..81d45ddebace 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct xhci_hcd *xhci, struct xhci_virt_
         return 0;
  }
  
+static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
+                                          struct xhci_ring *ring)
+{
+       switch(ring->last_td_comp_code) {
+       case COMP_SHORT_PACKET:
+               return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
+       case COMP_USB_TRANSACTION_ERROR:
+       case COMP_BABBLE_DETECTED_ERROR:
+       case COMP_ISOCH_BUFFER_OVERRUN:
+               return xhci->quirks & XHCI_ETRON_HOST &&
+                       ring->type == TYPE_ISOC;
+       default:
+               return false;
+       }
+}
+
  /*
   * If this function returns an error condition, it means it got a Transfer
   * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
         case COMP_SUCCESS:
                 if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
                         trb_comp_code = COMP_SHORT_PACKET;
-                       xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
-                                slot_id, ep_index, ep_ring->last_td_was_short);
+                       xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td comp code %d\n",
+                                slot_id, ep_index, ep_ring->last_td_comp_code);
                 }
                 break;
         case COMP_SHORT_PACKET:
@@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
                  */
                 if (trb_comp_code != COMP_STOPPED &&
                     trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
-                   !ep_ring->last_td_was_short) {
+                   !xhci_spurious_success_tx_event(xhci, ep_ring)) {
                         xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
                                   slot_id, ep_index);
                 }
@@ -2890,11 +2906,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
  
                         /*
                          * Some hosts give a spurious success event after a short
-                        * transfer. Ignore it.
+                        * transfer or error on last TRB. Ignore it.
                          */
-                       if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-                           ep_ring->last_td_was_short) {
-                               ep_ring->last_td_was_short = false;
+                       if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
+                               ep_ring->last_td_comp_code = trb_comp_code;
                                 return 0;
                         }
  
@@ -2922,10 +2937,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
          */
         } while (ep->skip);
  
-       if (trb_comp_code == COMP_SHORT_PACKET)
-               ep_ring->last_td_was_short = true;
-       else
-               ep_ring->last_td_was_short = false;
+       ep_ring->last_td_comp_code = trb_comp_code;
  
         ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
         trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb, ep_trb_dma);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 779b01dee068..acc8d3c7a199 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1371,7 +1371,7 @@ struct xhci_ring {
         unsigned int            num_trbs_free; /* used only by xhci DbC */
         unsigned int            bounce_buf_len;
         enum xhci_ring_type     type;
-       bool                    last_td_was_short;
+       u32                     last_td_comp_code;
         struct radix_tree_root  *trb_address_map;
  };


