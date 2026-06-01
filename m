Return-Path: <stable+bounces-259593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTxGGekHWr5cgkAu9opvQ
	(envelope-from <stable+bounces-259593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 17:25:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA90621A4A
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B18303AB7C
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E44263F4A;
	Mon,  1 Jun 2026 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="am4yZ+XL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A8191F91;
	Mon,  1 Jun 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326969; cv=none; b=ToUuHzwEvFxdgUreoVHhSz31uPuPig5xf3b64CH1V0pe9THdBm6Nb9axSNn1I9qGYWoq/IwrZ7kCKSlZ9OwqCFeJsAo+g/wO65AOrlglkJBxYJ0a3+RL+4go0RvySXnBNXV20StFzxisP5ulwW2XLPvOt94XpRNRfO3xjhjgw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326969; c=relaxed/simple;
	bh=63y0HnDfCo6mxnJzeqOTetmift28YbJwLcwc3d4BD+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Igbf1hWi1+VsPNiRdjABLbWAeViVXNlJCH7kbIQZ9RVy3B7caXYOLJ4laGKTO1AA1UmN1zo6Ivbf7EPRK011ZO48B+yNi5vz4NksKcbdTMSiNg6s7gft/1zapJtQ+anLtYl9GmAn4YqvlCuCnuFwfTzeCxarANdLG+8tcL4ascM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=am4yZ+XL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D708A1F00893;
	Mon,  1 Jun 2026 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780326968;
	bh=4kNqUGFWCGfqv/yyEUEOCx6c0AAY1iCK1VKJKWgjxtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=am4yZ+XLtth/OV8VjxKH5jpRTIa7YEljtlOnFAUsvmnRZ5WgI38Fi7a11jb5FhU4S
	 M8zWLRceVKIAvG5WUrepz2yTg6Nu4zfGKBHmcMYWC2NP/twG7g/wH96kw/FNHDfD1y
	 jhuhMZLbDce30IM+n+UNnojJ1T6nILdV4ee+xqm4=
Date: Mon, 1 Jun 2026 17:15:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 030/272] Revert "ice: fix double-free of tx_buf skb"
Message-ID: <2026060100-unranked-operate-afd1@gregkh>
References: <20260528194629.379955525@linuxfoundation.org>
 <20260528194630.231806613@linuxfoundation.org>
 <bf9bf060-f361-4333-a56b-d393e7738d28@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9bf060-f361-4333-a56b-d393e7738d28@oracle.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259593-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CFA90621A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 07:02:10PM +0530, Harshit Mogalapalli wrote:
> Hi Sasha/Greg,
> 
> On 29/05/26 01:16, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > This reverts commit fd95ef8d0f6dbe2daa95d6488c9e0f8a95a7e048.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_txrx.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 48434a79869cb..08d1757f40888 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -2346,9 +2346,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
> >   	ice_trace(xmit_frame_ring, tx_ring, skb);
> > -	/* record the location of the first descriptor for this packet */
> > -	first = &tx_ring->tx_buf[tx_ring->next_to_use];
> > -
> >   	count = ice_xmit_desc_count(skb);
> >   	if (ice_chk_linearize(skb, count)) {
> >   		if (__skb_linearize(skb))
> > @@ -2374,6 +2371,8 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
> >   	offload.tx_ring = tx_ring;
> > +	/* record the location of the first descriptor for this packet */
> > +	first = &tx_ring->tx_buf[tx_ring->next_to_use];
> >   	first->skb = skb;
> >   	first->type = ICE_TX_BUF_SKB;
> >   	first->bytecount = max_t(unsigned int, skb->len, ETH_ZLEN);
> > @@ -2437,7 +2436,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
> >   out_drop:
> >   	ice_trace(xmit_frame_ring_drop, tx_ring, skb);
> >   	dev_kfree_skb_any(skb);
> > -	first->type = ICE_TX_BUF_EMPTY;
> >   	return NETDEV_TX_OK;
> >   }
> 
> 
> I ran an AI-assisted backport review and then checked this one against the
> 6.12.y tree.
> 
> I think this purely opens the issue again back, we need some sort of TODO
> list for tracking these backports that are reverted for now.
> 
> Issue goes back like this
> 
> That fix(what we are reverting) made ice_xmit_frame_ring() clear the TX
> buffer state on the drop path:
> 
> dev_kfree_skb_any(skb);
> first->type = ICE_TX_BUF_EMPTY;
> 
> After the revert, first->skb is still recorded and first->type is still set
> to ICE_TX_BUF_SKB before ice_tso() / ice_tx_csum(), but the error path now
> only frees the skb and returns.
> 
> Later ice_clean_tx_ring() -> ice_unmap_and_free_tx_buf() still treats
> ICE_TX_BUF_SKB as owning a live skb and frees tx_buf->skb.
> 
> So its again the same issue coming back to stable.
> 
> I looked up the reason for the revert and the reason for the revert is we
> took a prerequisite for this which doesn't fit will so to revert the
> prerequisite we reverted this fix as well, I think we need adapted patch to
> older stable trees.
> 
> https://lore.kernel.org/all/20260527-agent5-item003-ice@kernel.org/
> 
> Nothing to do now but I think we need to add some sort TODO-backports list
> in stable-queue , thoughts ?

Sure, but ideally people would just send the missing backports :)

