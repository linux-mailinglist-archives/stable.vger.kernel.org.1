Return-Path: <stable+bounces-87588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1F9A6E52
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CAA1F23BA6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB61C3F35;
	Mon, 21 Oct 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH5m0p4e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AADD1C32EC;
	Mon, 21 Oct 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525016; cv=none; b=fiDKsDv3VQoFstOy5DlVO0oYSFndONR13C7IxfL3xu3Yai6vNgC7gc9/faNdRTTcXKW9vRy+DfMc2IVQNMR5UPM28sLD6fw25Zl6Pl4YiHviDnjxflnOtTTRLlIgprcSaSeJt3hC7DvgfkygOu58jHHscjVMy3W1s4hr+0Aer1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525016; c=relaxed/simple;
	bh=iG8UoLDE9OO5zAzlZpMo6rLD6ZMjgHZMdsip5GxdtP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZH2EuVuTDkebcu4KJt0tGpkLVtDZZMHSG5upvz2CGZ5hq3gBjdombgqRdjBC6wTuYlnQdbc0r37XxkEaspWyCYvQi+x/7db/qz5ZyHnmYIirmL7m3bvKAlTN+XR6mivvOhEZ8l+YbcOdEvnEIzyEP/iF9onqTRxrWZDZyz/v+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH5m0p4e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729525014; x=1761061014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iG8UoLDE9OO5zAzlZpMo6rLD6ZMjgHZMdsip5GxdtP0=;
  b=jH5m0p4edqEnxeIslQwGlbG+O67EjtEa9wGCOOrmVcm/J3o8+7BLy8GF
   62vgkcMBzJHfKHvNik/8I9TMUJx+j/nYS8B0CtKOCCzpIWstfJhT7OksN
   sM+VQRy2kjP/BPpZIAC/hb9GkAOac9FSYdkODN1O5re99ADXdNuC7QGh1
   AQV6cSNdIejQ1ewnpT+4O5118A/obuDpT+OwsOJJmsZfxmUv/6VracWGm
   +BFVHmDwYwafoVE3nJHfH64d3HslXASp1o0DcfHA85TFcL1Ueo8EpRQST
   iDW3wGGj3NBlwU36J4s9gY6O2TAZYrrNTcxfPYTpq6IXlq7GJORYlVpTE
   g==;
X-CSE-ConnectionGUID: WQxmZmNhTqO+ESTShOxhfg==
X-CSE-MsgGUID: jnXe3dl0TuijNisEfgZyDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28966787"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28966787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 08:36:53 -0700
X-CSE-ConnectionGUID: oGI7i789S/WjwgjjUre7Dg==
X-CSE-MsgGUID: wsJtD0j4Sn28e+VWjO3L6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="110318540"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2024 08:36:52 -0700
Message-ID: <51a0598a-2618-4501-af40-f1e9a1463bca@linux.intel.com>
Date: Mon, 21 Oct 2024 18:39:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Fix Link TRB DMA in command ring stopped
 completion event
To: Faisal Hassan <quic_faisalh@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241021131904.20678-1-quic_faisalh@quicinc.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241021131904.20678-1-quic_faisalh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.2024 16.19, Faisal Hassan wrote:
> During the aborting of a command, the software receives a command
> completion event for the command ring stopped, with the TRB pointing
> to the next TRB after the aborted command.
> 
> If the command we abort is located just before the Link TRB in the
> command ring, then during the 'command ring stopped' completion event,
> the xHC gives the Link TRB in the event's cmd DMA, which causes a
> mismatch in handling command completion event.
> 
> To handle this situation, an additional check has been added to ignore
> the mismatch error and continue the operation.
> 
> Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
> ---
> Changes in v2:
> - Removed traversing of TRBs with in_range() API.
> - Simplified the if condition check.
> 
> v1 link:
> https://lore.kernel.org/all/20241018195953.12315-1-quic_faisalh@quicinc.com
> 
>   drivers/usb/host/xhci-ring.c | 43 +++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index b2950c35c740..de375c9f08ca 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -126,6 +126,29 @@ static void inc_td_cnt(struct urb *urb)
>   	urb_priv->num_tds_done++;
>   }
>   
> +/*
> + * Return true if the DMA is pointing to a Link TRB in the ring;
> + * otherwise, return false.
> + */
> +static bool is_dma_link_trb(struct xhci_ring *ring, dma_addr_t dma)
> +{
> +	struct xhci_segment *seg;
> +	union xhci_trb *trb;
> +
> +	seg = ring->first_seg;
> +	do {
> +		if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE)) {
> +			/* found the TRB, check if it's link */
> +			trb = &seg->trbs[(dma - seg->dma) / sizeof(*trb)];
> +			return trb_is_link(trb);
> +		}
> +
> +		seg = seg->next;
> +	} while (seg != ring->first_seg);
> +
> +	return false;
> +}
> +
>   static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
>   {
>   	if (trb_is_link(trb)) {
> @@ -1718,6 +1741,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
>   
>   	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
>   
> +	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
>   	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
>   			cmd_trb);
>   	/*
> @@ -1725,17 +1749,26 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
>   	 * command.
>   	 */
>   	if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
> -		xhci_warn(xhci,
> -			  "ERROR mismatched command completion event\n");
> -		return;
> +		/*
> +		 * For the 'command ring stopped' completion event, there
> +		 * is a risk of a mismatch in dequeue pointers if we abort
> +		 * the command just before the link TRB in the command ring.
> +		 * In this scenario, the cmd_dma in the event would point
> +		 * to a link TRB, while the software dequeue pointer circles
> +		 * back to the start.
> +		 */
> +		if (!(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
> +		      is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {


Do we in this COMP_COMMAND_RING_STOPPED case even need to check if
cmd_dma != (u64)cmd_dequeue_dma, or if command ring stopped on a link TRB?

Could we just move the COMP_COMMAND_RING_STOPPED handling a bit earlier?

if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
	complete_all(&xhci->cmd_ring_stop_completion);
         return;
}

If I remember correctly it should just turn aborted command TRBs into no-ops,
and restart the command ring

Thanks
Mathias


