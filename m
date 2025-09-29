Return-Path: <stable+bounces-181972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64708BAA3B9
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E743AAA08
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E02220F3E;
	Mon, 29 Sep 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="ohkjKyaL"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E8317736
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168421; cv=none; b=mBPjSPruy3Q8uVQy4Q0d58etiSwUajVqCWyd0lDHczazH3+ivhRjt2N0wnD6xwd/TuCSdzuMtdhLdYGsjDyZVOL8T7Mqk4kNc7sH2ay/vJ5oTJaegfQjNb11eo97hqtwDQxTM4EY4VvXlyaU90UcLLHvpxKzfUXzl9OFf9tUXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168421; c=relaxed/simple;
	bh=RKOIgFTv2y3WUsqHpzTwQlpbbTI5P8MAnEmoz1ITs/I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i/vl53dGgqn76WvZOFQotvXG4FoO2qQNCN0iL9yLE53qfqa4qFAeNUNUioz7Jb5W0QqjDcadjWHYnaSFrAa2ZYGf0TUxPnjaO3BNKr7jZF2tExMyFzwlkSEDgBqYHfud7i5Y7WMvdTYrcc9G2z2GPkkwGtCn04xHLCTs6tmKUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=ohkjKyaL; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4cb81Y4hgbzRhR7;
	Mon, 29 Sep 2025 19:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1759168401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hw5036fkN/5rcziOB4GCIrjxBWCw++DAh73WIlTLJzc=;
	b=ohkjKyaL8znPBojIKMGlrh4vXH2UOvHP+hhGa91OplqRIsQpOkINKMoIRVUnadVm6x6Hau
	ZF6Jj2PViQ0Ydf6aWbdU35aiMrGGp46G6ZSJb76RtfDcQzChwZ+gXF+ilUfqffyCMML7zj
	JaHrwT1s8CFfYcRKYhj8mT1qkFAXdgtt90jJNRi/1KcQj/j4MWu+/zStqQTR1seTw5o31q
	HFu5HKDbAsteSXdf0UiVqvdR/mJBNh4f1kWWnkm/yCPnLCW81hkC0P99f6iBgo7Z9T6PS3
	OcYaU9sPEjOZIBZd7LEzb/tzMSQacdj9g1XyobHB7DWLgiBaUCNkV5VKgdhQRA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 19:53:21 +0200
From: Wolfgang Walter <linux@stwm.de>
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: regression from 6.12.48 to 6.12.49: usb wlan adaptor stops
 working: bisected
In-Reply-To: <883094b3-85a5-4825-8b0d-e25e194ad146@linux.intel.com>
References: <01b8c8de46251cfaad1329a46b7e3738@stwm.de>
 <883094b3-85a5-4825-8b0d-e25e194ad146@linux.intel.com>
Message-ID: <d7ffdb1eed510f20a30fc74a5360013c@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello Niklas!

Am 2025-09-29 16:08, schrieb Neronin, Niklas:
> On 26/09/2025 18.54, Wolfgang Walter wrote:
>> Hello,o
>> after upgrading to 6.12.49 my wlan adapter stops working. It is 
>> detected:
>> 
>> kernel: mt76x2u 4-2:1.0: ASIC revision: 76120044
>> kernel: mt76x2u 4-2:1.0: ROM patch build: 20141115060606a
>> kernel: usb 3-4: reset high-speed USB device number 2 using xhci_hcd
>> kernel: mt76x2u 4-2:1.0: Firmware Version: 0.0.00
>> kernel: mt76x2u 4-2:1.0: Build: 1
>> kernel: mt76x2u 4-2:1.0: Build Time: 201507311614____
>> 
>> but does nor work. The following 2 messages probably are relevant:
>> 
>> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
>> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
>> 
>> later I see a lot of
>> 
>> kernel: mt76x2u 4-2:1.0: error: mt76x02u_mcu_wait_resp failed with 
>> -110
>> 
>> 
>> I bisected it down to commit
>> 
>> 9b28ef1e4cc07cdb35da257aa4358d0127168b68
>> usb: xhci: remove option to change a default ring's TRB cycle bit
>> 
>> 
>> 9b28ef1e4cc07cdb35da257aa4358d0127168b68 is the first bad commit
>> commit 9b28ef1e4cc07cdb35da257aa4358d0127168b68
>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>> Date:   Wed Sep 17 08:39:07 2025 -0400
>> 
>>     usb: xhci: remove option to change a default ring's TRB cycle bit
>> 
>>     [ Upstream commit e1b0fa863907a61e86acc19ce2d0633941907c8e ]
>> 
>>     The TRB cycle bit indicates TRB ownership by the Host Controller 
>> (HC) or
>>     Host Controller Driver (HCD). New rings are initialized with 
>> 'cycle_state'
>>     equal to one, and all its TRBs' cycle bits are set to zero. When 
>> handling
>>     ring expansion, set the source ring cycle bits to the same value 
>> as the
>>     destination ring.
>> 
>>     Move the cycle bit setting from xhci_segment_alloc() to 
>> xhci_link_rings(),
>>     and remove the 'cycle_state' argument from 
>> xhci_initialize_ring_info().
>>     The xhci_segment_alloc() function uses kzalloc_node() to allocate 
>> segments,
>>     ensuring that all TRB cycle bits are initialized to zero.
>> 
>>     Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
>>     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>     Link: 
>> https://lore.kernel.org/r/20241106101459.775897-12-mathias.nyman@linux.intel.com
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer 
>> ring after several reconnects")
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
> 
> Hi, could you test if the code below helps?

Yes, this fixes the issue. Thanks a lot.

> 
> This reverts commit 9b28ef1e4cc0 ("usb: xhci: remove option to change a
> default ring's TRB cycle bit") which is upstream [2].
> 
> The original commit was never intended for stable kernels, but was 
> added
> as a dependency for commit [1].
> 
> Revert it, and solve the dependency by modifying one line in
> xhci_dbc_ring_init(). The function call xhci_initialize_ring_info()
> was moved in commit [1] into xhci_dbc_ring_init(). Thus,
> xhci_initialize_ring_info() is also modified.
> 
> [1], commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer
> ring after several reconnects")
> 
> [2], commit e1b0fa863907 ("usb: xhci: remove option to change a
> default ring's TRB cycle bit")
> 
> Best Regards,
> Niklas
> 
> 
> diff --git a/drivers/usb/host/xhci-dbgcap.c 
> b/drivers/usb/host/xhci-dbgcap.c
> index 1fcc9348dd43..123506681ef0 100644
> --- a/drivers/usb/host/xhci-dbgcap.c
> +++ b/drivers/usb/host/xhci-dbgcap.c
> @@ -458,7 +458,7 @@ static void xhci_dbc_ring_init(struct xhci_ring 
> *ring)
>  		trb->link.segment_ptr = cpu_to_le64(ring->first_seg->dma);
>  		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
>  	}
> -	xhci_initialize_ring_info(ring);
> +	xhci_initialize_ring_info(ring, 1);
>  }
> 
>  static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index c9694526b157..f0ed38da6a0c 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -27,12 +27,14 @@
>   * "All components of all Command and Transfer TRBs shall be 
> initialized to '0'"
>   */
>  static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
> +					       unsigned int cycle_state,
>  					       unsigned int max_packet,
>  					       unsigned int num,
>  					       gfp_t flags)
>  {
>  	struct xhci_segment *seg;
>  	dma_addr_t	dma;
> +	int		i;
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> 
>  	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
> @@ -54,6 +56,11 @@ static struct xhci_segment 
> *xhci_segment_alloc(struct xhci_hcd *xhci,
>  			return NULL;
>  		}
>  	}
> +	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs 
> */
> +	if (cycle_state == 0) {
> +		for (i = 0; i < TRBS_PER_SEGMENT; i++)
> +			seg->trbs[i].link.control = cpu_to_le32(TRB_CYCLE);
> +	}
>  	seg->num = num;
>  	seg->dma = dma;
>  	seg->next = NULL;
> @@ -131,14 +138,6 @@ static void xhci_link_rings(struct xhci_hcd *xhci, 
> struct xhci_ring *ring,
> 
>  	chain_links = xhci_link_chain_quirk(xhci, ring->type);
> 
> -	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs 
> */
> -	if (ring->cycle_state == 0) {
> -		xhci_for_each_ring_seg(ring->first_seg, seg) {
> -			for (int i = 0; i < TRBS_PER_SEGMENT; i++)
> -				seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
> -		}
> -	}
> -
>  	next = ring->enq_seg->next;
>  	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
>  	xhci_link_segments(last, next, ring->type, chain_links);
> @@ -288,7 +287,8 @@ void xhci_ring_free(struct xhci_hcd *xhci, struct 
> xhci_ring *ring)
>  	kfree(ring);
>  }
> 
> -void xhci_initialize_ring_info(struct xhci_ring *ring)
> +void xhci_initialize_ring_info(struct xhci_ring *ring,
> +			       unsigned int cycle_state)
>  {
>  	/* The ring is empty, so the enqueue pointer == dequeue pointer */
>  	ring->enqueue = ring->first_seg->trbs;
> @@ -302,7 +302,7 @@ void xhci_initialize_ring_info(struct xhci_ring 
> *ring)
>  	 * New rings are initialized with cycle state equal to 1; if we are
>  	 * handling ring expansion, set the cycle state equal to the old 
> ring.
>  	 */
> -	ring->cycle_state = 1;
> +	ring->cycle_state = cycle_state;
> 
>  	/*
>  	 * Each segment has a link TRB, and leave an extra TRB for SW
> @@ -317,6 +317,7 @@ static int xhci_alloc_segments_for_ring(struct 
> xhci_hcd *xhci,
>  					struct xhci_segment **first,
>  					struct xhci_segment **last,
>  					unsigned int num_segs,
> +					unsigned int cycle_state,
>  					enum xhci_ring_type type,
>  					unsigned int max_packet,
>  					gfp_t flags)
> @@ -327,7 +328,7 @@ static int xhci_alloc_segments_for_ring(struct 
> xhci_hcd *xhci,
> 
>  	chain_links = xhci_link_chain_quirk(xhci, type);
> 
> -	prev = xhci_segment_alloc(xhci, max_packet, num, flags);
> +	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, num, flags);
>  	if (!prev)
>  		return -ENOMEM;
>  	num++;
> @@ -336,7 +337,8 @@ static int xhci_alloc_segments_for_ring(struct 
> xhci_hcd *xhci,
>  	while (num < num_segs) {
>  		struct xhci_segment	*next;
> 
> -		next = xhci_segment_alloc(xhci, max_packet, num, flags);
> +		next = xhci_segment_alloc(xhci, cycle_state, max_packet, num,
> +					  flags);
>  		if (!next)
>  			goto free_segments;
> 
> @@ -361,8 +363,9 @@ static int xhci_alloc_segments_for_ring(struct 
> xhci_hcd *xhci,
>   * Set the end flag and the cycle toggle bit on the last segment.
>   * See section 4.9.1 and figures 15 and 16.
>   */
> -struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int 
> num_segs,
> -				  enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
> +struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
> +		unsigned int num_segs, unsigned int cycle_state,
> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
>  {
>  	struct xhci_ring	*ring;
>  	int ret;
> @@ -380,7 +383,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd 
> *xhci, unsigned int num_segs,
>  		return ring;
> 
>  	ret = xhci_alloc_segments_for_ring(xhci, &ring->first_seg, 
> &ring->last_seg, num_segs,
> -					   type, max_packet, flags);
> +					   cycle_state, type, max_packet, flags);
>  	if (ret)
>  		goto fail;
> 
> @@ -390,7 +393,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd 
> *xhci, unsigned int num_segs,
>  		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
>  			cpu_to_le32(LINK_TOGGLE);
>  	}
> -	xhci_initialize_ring_info(ring);
> +	xhci_initialize_ring_info(ring, cycle_state);
>  	trace_xhci_ring_alloc(ring);
>  	return ring;
> 
> @@ -418,8 +421,8 @@ int xhci_ring_expansion(struct xhci_hcd *xhci, 
> struct xhci_ring *ring,
>  	struct xhci_segment	*last;
>  	int			ret;
> 
> -	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, 
> ring->type,
> -					   ring->bounce_buf_len, flags);
> +	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, 
> ring->cycle_state,
> +					   ring->type, ring->bounce_buf_len, flags);
>  	if (ret)
>  		return -ENOMEM;
> 
> @@ -629,7 +632,8 @@ struct xhci_stream_info 
> *xhci_alloc_stream_info(struct xhci_hcd *xhci,
> 
>  	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
>  		stream_info->stream_rings[cur_stream] =
> -			xhci_ring_alloc(xhci, 2, TYPE_STREAM, max_packet, mem_flags);
> +			xhci_ring_alloc(xhci, 2, 1, TYPE_STREAM, max_packet,
> +					mem_flags);
>  		cur_ring = stream_info->stream_rings[cur_stream];
>  		if (!cur_ring)
>  			goto cleanup_rings;
> @@ -970,7 +974,7 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, 
> int slot_id,
>  	}
> 
>  	/* Allocate endpoint 0 ring */
> -	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, TYPE_CTRL, 0, flags);
> +	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, 1, TYPE_CTRL, 0, flags);
>  	if (!dev->eps[0].ring)
>  		goto fail;
> 
> @@ -1453,7 +1457,7 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
> 
>  	/* Set up the endpoint ring */
>  	virt_dev->eps[ep_index].new_ring =
> -		xhci_ring_alloc(xhci, 2, ring_type, max_packet, mem_flags);
> +		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
>  	if (!virt_dev->eps[ep_index].new_ring)
>  		return -ENOMEM;
> 
> @@ -2262,7 +2266,7 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, 
> unsigned int segs, gfp_t flags)
>  	if (!ir)
>  		return NULL;
> 
> -	ir->event_ring = xhci_ring_alloc(xhci, segs, TYPE_EVENT, 0, flags);
> +	ir->event_ring = xhci_ring_alloc(xhci, segs, 1, TYPE_EVENT, 0, 
> flags);
>  	if (!ir->event_ring) {
>  		xhci_warn(xhci, "Failed to allocate interrupter event ring\n");
>  		kfree(ir);
> @@ -2468,7 +2472,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t 
> flags)
>  		goto fail;
> 
>  	/* Set up the command ring to have one segments for now. */
> -	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, TYPE_COMMAND, 0, flags);
> +	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, 1, TYPE_COMMAND, 0, flags);
>  	if (!xhci->cmd_ring)
>  		goto fail;
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 3970ec831b8c..abbf89e82d01 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -769,7 +769,7 @@ static void xhci_clear_command_ring(struct xhci_hcd 
> *xhci)
>  		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= 
> cpu_to_le32(~TRB_CYCLE);
>  	}
> 
> -	xhci_initialize_ring_info(ring);
> +	xhci_initialize_ring_info(ring, 1);
>  	/*
>  	 * Reset the hardware dequeue pointer.
>  	 * Yes, this will need to be re-written after resume, but we're 
> paranoid
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index b2aeb444daaf..b4fa8e7e4376 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1803,12 +1803,14 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
>  int xhci_endpoint_init(struct xhci_hcd *xhci, struct xhci_virt_device 
> *virt_dev,
>  		struct usb_device *udev, struct usb_host_endpoint *ep,
>  		gfp_t mem_flags);
> -struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int 
> num_segs,
> +struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
> +		unsigned int num_segs, unsigned int cycle_state,
>  		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags);
>  void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
>  int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
>  		unsigned int num_trbs, gfp_t flags);
> -void xhci_initialize_ring_info(struct xhci_ring *ring);
> +void xhci_initialize_ring_info(struct xhci_ring *ring,
> +			unsigned int cycle_state);
>  void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
>  		struct xhci_virt_device *virt_dev,
>  		unsigned int ep_index);


Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

