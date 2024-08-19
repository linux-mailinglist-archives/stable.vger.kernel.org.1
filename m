Return-Path: <stable+bounces-69576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75F956915
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D381C21A94
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC1165F0C;
	Mon, 19 Aug 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlvzDAHU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB92209F;
	Mon, 19 Aug 2024 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065953; cv=none; b=QaLdTjYFVU3+Hi3/KdEDNo60BJxqBRBanIYn+5B/78FY+TitsKZ+EmvZWYzssNRyguEgmohz7qw0hq3KmNg1XSk7pTHqVqtxB93Hr5yKlo4CecUgmKG9hZGurBoiJFQ5TVHZYllWBNvJV8uMUQBFSYrkxhb58KjHqT1wFEvDCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065953; c=relaxed/simple;
	bh=8HuoTN5MdHjN9NU9GzNhlvLaR0T3eo7+6aLGi+ufCPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi8Cra9Oz/mk1ZJmwNonvYu60g+1fsXCt2MhndfLuXj+ci0kFfsj5/MK0br0VazPyf3dlWabXdnpCmvQJEfyu9+/RzDjCpD1/nt44CpAtSC0mhcEEwZfNPooyYyFSsj1aqvoN2ZZiwTTHDTvsF3lGcV+ch21Vb+82q3lToKLJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlvzDAHU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724065952; x=1755601952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8HuoTN5MdHjN9NU9GzNhlvLaR0T3eo7+6aLGi+ufCPc=;
  b=JlvzDAHUT/5XhXoU+xnXkN8/0Nt239XCb5974dOqpJLgAe8/BavGIz/0
   ERBAUrw/IcS4gVpU+zL3dCICkIF+D5HzbF7ZXPO/OkdgMOrKTM+IgNwpV
   lAdtqMTbgAgt5mEeAIJBH8Ywr90d6vXE2Gfn3SQHWZs8vGWfSftcTMSm3
   rI2Zu7hU+rvyUB8ASbhPrtGXXTTK7DpursczqaJladnaDdQoOHRRit7Gb
   ejoDAiKG1sNZPjCkIekoUTjGAwjGFtqTkNkd2lwfXYzgo53Ls2JV+75tp
   v89q/SR0MtMkb1JM0G3Hu4AVxSX6J8Is5OTGmqvNlqUdXEAhT2WeqbxIQ
   A==;
X-CSE-ConnectionGUID: Fny+sqcVS+2H/kSVyTzsKQ==
X-CSE-MsgGUID: gI+piSTETluKmfoXdZ//hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22448832"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22448832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:12:32 -0700
X-CSE-ConnectionGUID: fWIWIV1oTNeMir2OHbdmfg==
X-CSE-MsgGUID: 8UlRE1S+S9OQ52EPST7Yeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60042820"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2024 04:12:29 -0700
Message-ID: <bb592346-7a71-436c-ab68-62701e38015d@linux.intel.com>
Date: Mon, 19 Aug 2024 14:14:33 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
To: Pawel Laszczak <pawell@cadence.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "peter.chen@kernel.org" <peter.chen@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240819045449.41237-1-pawell@cadence.com>
 <PH7PR07MB9538B91A187B4EB8654BB2EBDD8C2@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <PH7PR07MB9538B91A187B4EB8654BB2EBDD8C2@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.8.2024 7.58, Pawel Laszczak wrote:
> Stream endpoint can skip part of TD during next transfer initialization
> after beginning stopped during active stream data transfer.
> The Set TR Dequeue Pointer command does not clear all internal
> transfer-related variables that position stream endpoint on transfer ring.
> 
> USB Controller stores all endpoint state information within RsvdO fields
> inside endpoint context structure. For stream endpoints, all relevant
> information regarding particular StreamID is stored within corresponding
> Stream Endpoint context.
> Whenever driver wants to stop stream endpoint traffic, it invokes
> Stop Endpoint command which forces the controller to dump all endpoint
> state-related variables into RsvdO spaces into endpoint context and stream
> endpoint context. Whenever driver wants to reinitialize endpoint starting
> point on Transfer Ring, it uses the Set TR Dequeue Pointer command
> to update dequeue pointer for particular stream in Stream Endpoint
> Context. When stream endpoint is forced to stop active transfer in the
> middle of TD, it dumps an information about TRB bytes left in RsvdO fields
> in Stream Endpoint Context which will be used in next transfer
> initialization to designate starting point for XDMA. This field is not
> cleared during Set TR Dequeue Pointer command which causes XDMA to skip
> over transfer ring and leads to data loss on stream pipe.

xHC should clear the EDTLA field when processing a Set TR Dequeue Pointer command:

xhci spec v1.2, section 4.6.10 Set TR Dequeue Pointer:
"The xHC shall perform the following operations when setting a ring address:
  ...
Clear any prior transfer state, e.g. setting the EDTLA to 0, clearing any partially
completed USB2 split transactions, etc."

> 
> Patch fixes this by clearing out all RsvdO fields before initializing new
> transfer via that StreamID.

Looks like patch also writes edtl back to ctx->reserved[0], is there a reason for this?

> 
> Field Rsvd0 is reserved field, so patch should not have impact for other
> xHCI controllers.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>   drivers/usb/host/xhci-ring.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 1dde53f6eb31..7fc1c4efcae2 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1385,7 +1385,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
>   		if (ep->ep_state & EP_HAS_STREAMS) {
>   			struct xhci_stream_ctx *ctx =
>   				&ep->stream_info->stream_ctx_array[stream_id];
> +			u32 edtl;
> +
>   			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
> +			edtl = EVENT_TRB_LEN(le32_to_cpu(ctx->reserved[1]));

Isn't edtl in reserved[0], not in reserved[1]?

Also unclear why we read it at all, it should be set to 0 by controller, right?

> +
> +			/*
> +			 * Existing Cadence xHCI controllers store some endpoint state information
> +			 * within Rsvd0 fields of Stream Endpoint context. This field is not

Aren't these fields RsvdO (Reserved and Opaque)?
Driver shouldn't normally touch these fields, they are used by xHC as temporary workspace.

> +			 * cleared during Set TR Dequeue Pointer command which causes XDMA to skip
> +			 * over transfer ring and leads to data loss on stream pipe.
> +			 * To fix this issue driver must clear Rsvd0 field.
> +			 */
> +			ctx->reserved[1] = 0;
> +			ctx->reserved[0] = cpu_to_le32(edtl);

why are we writing back edtl?, also note that it's read from ctx->reserved[1] above, and now
written to back to ctx->reserved[0].

I understood that issue was those RsvdO fields needs to be cleared manually for this host as
hardware fails to clear them during a "Set TR Dequeue Pointer" command.

Am I misunderstanding something?

Thanks
Mathias


