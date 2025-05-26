Return-Path: <stable+bounces-146361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E866EAC3EA4
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7951889E4C
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE601C84A2;
	Mon, 26 May 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG1noKS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637919CC3D;
	Mon, 26 May 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259302; cv=none; b=SGd/gwhx1kuODuvc4tU9mv3VYUNheblHf1zChK4+c1RKmGQsxiYbKKd+NBAoymfCH2JLSAkv5U9YNcsZBBwrAQt5wDV6QKVI629JtlT6WQpkKNHEowNQF30zmthnyDbSeSfl6ZOrJRyPcxeFiht0JqZt0IioYqwpINpr/JeVDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259302; c=relaxed/simple;
	bh=5SkZ27MFt+s5gbVQg3eH6ITCcs8U+KTTQskKya4Ci2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNs5LuBrHn08QEnHpjzOzkwbKgRLk6+6uRHmLPYuYi14KYzK0gLF6yY5xuM+cWcni3f0I0aH7D5qp4OwOGHV1WcaV9jUZwN0nJgdcA3PanIXsl84yDFYjFHyc/FNRYZKrx6G8yu9r3nZVcbun7HcKrt7pp35t68kMq7Tuv03DLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG1noKS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB06BC4CEE7;
	Mon, 26 May 2025 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748259302;
	bh=5SkZ27MFt+s5gbVQg3eH6ITCcs8U+KTTQskKya4Ci2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG1noKS+2rYdiUxvikU5MDWDqnSdzxnC9pj6g76zAGYnk1dcH6cnfbBUQgOsDClG+
	 GUpED1jEpKKy5Te/ypi2RuF822sr2UMZX50rQRtwMktVq8Vqcj9Bjz0s4uPhX1JMSf
	 Jo4fIK1u2alLzFlyrie5kSUgfwgVwtS4K25V1aGH6IIYKEUmGmA2XEjYxD2/1FsfHk
	 yXqubXIUIXoXcRXZ2AEFBWiOxX8DeXGI14kqOrW04n+pU+MoXURCJM7DcMdrMQAYAd
	 uy/yRH4aR8OzcuaiXIky6inPYCq4VcYdM6fvZc8ReXgddoXcwS6QbjqkItVNpXCpTU
	 5Bvzd3q9bASjg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uJW6g-000000000GJ-1m26;
	Mon, 26 May 2025 13:35:03 +0200
Date: Mon, 26 May 2025 13:35:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Nicolas Escande <nico.escande@gmail.com>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix ring-buffer corruption
Message-ID: <aDRR5oYBU0Z-DaWr@hovoldconsulting.com>
References: <20250321095219.19369-1-johan+linaro@kernel.org>
 <aC8-mUinxA6y688X@pilgrim>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC8-mUinxA6y688X@pilgrim>

On Thu, May 22, 2025 at 05:11:21PM +0200, Remi Pommarel wrote:
> On Fri, Mar 21, 2025 at 10:52:19AM +0100, Johan Hovold wrote:
> > Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> > breaks and the log fills up with errors like:
> > 
> >     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
> >     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> > 
> > which based on a quick look at the ath11k driver seemed to indicate some
> > kind of ring-buffer corruption.
> > 
> > Miaoqing Pan tracked it down to the host seeing the updated destination
> > ring head pointer before the updated descriptor, and the error handling
> > for that in turn leaves the ring buffer in an inconsistent state.
> > 
> > While this has not yet been observed with ath12k, the ring-buffer
> > implementation is very similar to the ath11k one and it suffers from the
> > same bugs.

> > Note that the READ_ONCE() are only needed to avoid compiler mischief in
> > case the ring-buffer helpers are ever inlined.

> > @@ -343,11 +343,10 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
> >  		goto err;
> >  	}
> >  
> > +	/* Make sure descriptor is read after the head pointer. */
> > +	dma_rmb();
> > +
> 
> That does not seem to be the only place descriptor is read just after
> the head pointer, ath12k_dp_rx_process{,err,reo_status,wbm_err} seem to
> also suffer the same sickness.

Indeed, I only started with the corruption issues that users were
reporting (with ath11k) and was gonna follow up with further fixes once
the initial ones were merged (and when I could find more time).

> Why not move the dma_rmb() in ath12k_hal_srng_access_begin() as below,
> that would look to me as a good place to do it.
> 
> @@ -2133,6 +2133,9 @@ void ath12k_hal_srng_access_begin(struct
> ath12k_base *ab, struct hal_srng *srng)
>                         *(volatile u32 *)srng->u.src_ring.tp_addr;
>         else
>                 srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> +
> +       /* Make sure descriptors are read after the head pointer. */
> +       dma_rmb();
>  }
> 
> This should ensure the issue does not happen anywhere not just for
> ath12k_ce_recv_process_cb().

We only need the read barrier for dest rings so the barrier would go in
the else branch, but I prefer keeping it in the caller so that it is
more obvious when it is needed and so that we can skip the barrier when
the ring is empty (e.g. as done above).

I've gone through and reviewed the remaining call sites now and will
send a follow-on fix for them.

> Note that ath12k_hal_srng_dst_get_next_entry() does not need a barrier
> as it uses cached_hp from ath12k_hal_srng_access_begin().

Yeah, it's only needed before accessing the descriptor fields.

> > @@ -1962,7 +1962,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
> >  {
> >  	u32 len;
> >  
> > -	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> > +	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> >  	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> >  
> >  	return len;
> > @@ -2132,7 +2132,7 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
> >  		srng->u.src_ring.cached_tp =
> >  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> >  	else
> > -		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> > +		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> 
> dma_rmb() acting also as a compiler barrier why the need for both
> READ_ONCE() ?

Yeah, I was being overly cautious here and it should be fine with plain
accesses when reading the descriptor after the barrier, but the memory
model seems to require READ_ONCE() when fetching the head pointer.
Currently, hp_addr is marked as volatile so READ_ONCE() could be
dropped for that reason, but I'd rather keep it here explicitly (e.g. in
case someone decides to drop the volatile).

Johan

