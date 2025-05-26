Return-Path: <stable+bounces-146369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBBAC400B
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE4B3B5BE9
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CBF204598;
	Mon, 26 May 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="GmRntbT9";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="QvZbOa60"
X-Original-To: stable@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4320296A
	for <stable@vger.kernel.org>; Mon, 26 May 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264887; cv=none; b=WqOGiCdMpba5Wzm28Ira6Ysdg7/GRId6M6auUDDhHsDzFCqjrXPvgO6MtNUXRpkX4vLCbL85P9dVZTB1FtuhSa1+fr2dfSViAeHnzkAb23QikVuR3AxYckhkg4hszvaRqsYIZaji89R0Wgk5HOsTRrNXRhU1CAjR+p9g2P/txVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264887; c=relaxed/simple;
	bh=ibpkxF+IyTC0eO8gP/R2ZTAxLRR85D+UrhTZ16tJvW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnxpHpnvr37CXnOLHUVmvFWF/fBFpORHfAIfoTmUssnkgLEkW8W/QdRJ+aGqRAn/94PaQn6Rma7YbQxL7CFRamavn/edTLuhVSxYDtqOnqHipaD1LTmPnUMsWjJavfEqYvP19LdfRc8pLbMqTeiZZtJl99A3RRTm9Pd4S3hfZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=GmRntbT9 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=QvZbOa60; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1748265784; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=SCQX/iHwVwMSyQkT6uzynKqPiPAsHTR2j6atuwHYfoU=; b=GmRntbT9/mAEENttiqXACzuGjt
	M/UOo2xRBblGQh+6Geb3pE+3fnXc8GdERT3cH3i84599l0ObuVdZSyu+unWJwCt1vN/y306onmDby
	St/csSN1yS28jRoM3TSWW0B4FWSB1INbzwM+DSAWIEV0KDImu40yNIuWunRQLuj9jaXZyuf45q/IQ
	sU2CvFrHXDlcfSe0nMI06rfrTz+eYuVnGPqbSsW/YyfIEBhyjSazzgpf2FU1/Kjv69Ph1YHCiEiqS
	KEDzYivjrHh2tAxA1dZ3jCXwkzdY2kfZgBAtjn6GZw6NqJkvL8Ym++joIVawfPe2vgqjIN93MxjF5
	An6sy87A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1748264884; h=from : subject
 : to : message-id : date;
 bh=SCQX/iHwVwMSyQkT6uzynKqPiPAsHTR2j6atuwHYfoU=;
 b=QvZbOa60Qg2dHssmuEpMU5pk0g9XANnpPRzmqGnBZDghOj+JRbBJFLHkB1v61UxNXenpS
 MZyIMNQ+5XzgDvTodU9QpNddWZAnhCH0IagppEDt5gYCjnSyj0cyiJ2o+xLdKKJ/vVsvnh7
 mBe8D+homi3nwqTv8ikPvPRCV7QHxuIKDxOcWnFdohI0FWolSCWtiEGmHNUcFyAEd/vgJ7r
 lFab82vOxvFobv3X8af4UNdiYTnY2TeECk3mkdu6F62mQQtvK/4eocbat1MUFiSs4EoUTLo
 avzAChEcjb82QSdmbYqt73CjbZQRobO0wcbQNO6KevZ8PSZCdhI3gI3r0ZMg==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJXXn-TRk1Hq-CS; Mon, 26 May 2025 13:07:07 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJXXn-AIkwcC8xzUn-GnHM; Mon, 26 May 2025 13:07:07 +0000
Date: Mon, 26 May 2025 14:58:51 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Miaoqing Pan <quic_miaoqing@quicinc.com>,
 Steev Klimaszewski <steev@kali.org>, Clayton Craft <clayton@craftyguy.net>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Nicolas Escande <nico.escande@gmail.com>,
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix ring-buffer corruption
Message-ID: <aDRli6uIbnuQK3nN@pilgrim>
References: <20250321095219.19369-1-johan+linaro@kernel.org>
 <aC8-mUinxA6y688X@pilgrim> <aDRR5oYBU0Z-DaWr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDRR5oYBU0Z-DaWr@hovoldconsulting.com>
X-Smtpcorp-Track: jszDgnkX_q2-.g-jcvWh-vb_x.NNkNjQ8YPbW
Feedback-ID: 510616m:510616apGKSTK:510616sQ6vhuulVJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, May 26, 2025 at 01:35:02PM +0200, Johan Hovold wrote:
> On Thu, May 22, 2025 at 05:11:21PM +0200, Remi Pommarel wrote:
> > On Fri, Mar 21, 2025 at 10:52:19AM +0100, Johan Hovold wrote:
> > > Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> > > breaks and the log fills up with errors like:
> > > 
> > >     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
> > >     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> > > 
> > > which based on a quick look at the ath11k driver seemed to indicate some
> > > kind of ring-buffer corruption.
> > > 
> > > Miaoqing Pan tracked it down to the host seeing the updated destination
> > > ring head pointer before the updated descriptor, and the error handling
> > > for that in turn leaves the ring buffer in an inconsistent state.
> > > 
> > > While this has not yet been observed with ath12k, the ring-buffer
> > > implementation is very similar to the ath11k one and it suffers from the
> > > same bugs.
> 
> > > Note that the READ_ONCE() are only needed to avoid compiler mischief in
> > > case the ring-buffer helpers are ever inlined.
> 
> > > @@ -343,11 +343,10 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
> > >  		goto err;
> > >  	}
> > >  
> > > +	/* Make sure descriptor is read after the head pointer. */
> > > +	dma_rmb();
> > > +
> > 
> > That does not seem to be the only place descriptor is read just after
> > the head pointer, ath12k_dp_rx_process{,err,reo_status,wbm_err} seem to
> > also suffer the same sickness.
> 
> Indeed, I only started with the corruption issues that users were
> reporting (with ath11k) and was gonna follow up with further fixes once
> the initial ones were merged (and when I could find more time).
> 
> > Why not move the dma_rmb() in ath12k_hal_srng_access_begin() as below,
> > that would look to me as a good place to do it.
> > 
> > @@ -2133,6 +2133,9 @@ void ath12k_hal_srng_access_begin(struct
> > ath12k_base *ab, struct hal_srng *srng)
> >                         *(volatile u32 *)srng->u.src_ring.tp_addr;
> >         else
> >                 srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> > +
> > +       /* Make sure descriptors are read after the head pointer. */
> > +       dma_rmb();
> >  }
> > 
> > This should ensure the issue does not happen anywhere not just for
> > ath12k_ce_recv_process_cb().
> 
> We only need the read barrier for dest rings so the barrier would go in
> the else branch, but I prefer keeping it in the caller so that it is
> more obvious when it is needed and so that we can skip the barrier when
> the ring is empty (e.g. as done above).

Thanks for taking time to clarify this.

Yes I messed up doing the patch by hand sorry, internally I test with
the dma_rmb() in the else part. I tend to prefer having it in
ath12k_hal_srng_access_begin() as caller does not have to take care of
the barrier itself. Which for me seems a little bit risky if further
refactoring (or adding other ring processing) is done in the future;
the barrier could easily be forgotten don't you think ?

> 
> I've gone through and reviewed the remaining call sites now and will
> send a follow-on fix for them.
> 
> > Note that ath12k_hal_srng_dst_get_next_entry() does not need a barrier
> > as it uses cached_hp from ath12k_hal_srng_access_begin().
> 
> Yeah, it's only needed before accessing the descriptor fields.
> 
> > > @@ -1962,7 +1962,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
> > >  {
> > >  	u32 len;
> > >  
> > > -	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> > > +	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> > >  	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> > >  
> > >  	return len;
> > > @@ -2132,7 +2132,7 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
> > >  		srng->u.src_ring.cached_tp =
> > >  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> > >  	else
> > > -		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> > > +		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> > 
> > dma_rmb() acting also as a compiler barrier why the need for both
> > READ_ONCE() ?
> 
> Yeah, I was being overly cautious here and it should be fine with plain
> accesses when reading the descriptor after the barrier, but the memory
> model seems to require READ_ONCE() when fetching the head pointer.
> Currently, hp_addr is marked as volatile so READ_ONCE() could be
> dropped for that reason, but I'd rather keep it here explicitly (e.g. in
> case someone decides to drop the volatile).

Yes actually after more thinking, the READ_ONCE for fetching hp does make
sense and is also in the patch I am currently testing.

Also for source rings don't we need a dma_wmb()/WRITE_ONCE before
modifying the tail pointer (see ath12k_hal_srng_access_end()) for quite
the same reason (updates of the descriptor have to be visible before
write to tail pointer) ?

Thanks

-- 
Remi

