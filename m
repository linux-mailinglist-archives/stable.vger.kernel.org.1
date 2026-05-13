Return-Path: <stable+bounces-246756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPp6JxcXBGpLDgIAu9opvQ
	(envelope-from <stable+bounces-246756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:15:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF352DFFF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EA0304C895
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A13AA1A8;
	Wed, 13 May 2026 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vetRNOob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED43382DE
	for <stable@vger.kernel.org>; Wed, 13 May 2026 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652948; cv=none; b=N8slUXkbW0BKprZS9bL0sW+cvMnwueYsGXECVexiuD+ZhQsNvmqwqG6k6fsQb/KQp9lVZEta6UVcYkAg9A+CQNH7O8pXes2VN7praYPf6jQ2XWIyW9p8b/dXsnC8ds0YTuwmnMgaKHNJBCks9npuy0rvaHhjBZYCuucoP6c6GLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652948; c=relaxed/simple;
	bh=MDDvfJo2n5M2m4MkQLPoGZUX4MQN5NbrlkLCfrSFovs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhAIl4el+pmU+tESO5imxHIAy678gcUuiQvhj7oBOmS113nd2p92l4jPl92iEW2EW/R5SLaaWTAgGTIQnx/HMjuhSju/K4hEM0thRb4+1XyUvItzUYsCDy7L4QetdTvcVPp02Jh/ngmX7P7Zd+PeM2k1PShCvixSE/6Acor1Nx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vetRNOob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74F0C2BCB7;
	Wed, 13 May 2026 06:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778652948;
	bh=MDDvfJo2n5M2m4MkQLPoGZUX4MQN5NbrlkLCfrSFovs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vetRNOobQaLfLOyhgELftSEvt5je4e2uMs+Qk2edErUz65Vfq1QidVXmVMz6BqiU6
	 0SGiUr1sgW4FJH0qwa3+QS/IgWwDB5F38j23vge0Y04ahcp9fOOcV6c2oXAywlRsEc
	 8krXPVKYisJq1MZ4KIeS0wwUnv0V23OaK9OKrmgE=
Date: Wed, 13 May 2026 08:15:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH net-next v3] ice: fix packet corruption due to extraneous
 page flip
Message-ID: <2026051356-superman-synthesis-d983@gregkh>
References: <20260512181228.1619-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512181228.1619-1-ouster@cs.stanford.edu>
X-Rspamd-Queue-Id: 02FF352DFFF
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-246756-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:12:28AM -0700, John Ousterhout wrote:
> Consider the following sequence of events:
> * The bottom half of a buffer page is filled with data from
>   packet A. The page has a net reference count (reference count
>   - bias) of 1. The page is returned to the NIC, flipped to
>   use the top half.
> * Before the reference on the page is released, the NIC returns
>   the page with no data in it ('size' is zero in ice_clean_rx_irq).
>   In this case the bias does not get decremented. The page still
>   has a net reference count of 1, so it gets returned to the NIC.
>   However, ice_put_rx_mbuf flipped the page so that the bottom
>   half is active.
> * If the NIC stores another packet in the page before packet A
>   has released its reference, the data in packet A will be
>   overwritten with data from the new packet.
> * Unfortunately zero-length buffers occur frequently: they seem
>   to occur whenever a packet uses every available byte in a
>   buffer, ending precisely at the end of the buffer. When this
>   happens the NIC seems to generate an extra zero-length
>   buffer.
> The fix is for ice_put_rx_mbuf not to flip pages that have a
> size of 0.
> 
> This patch applies directly to longterm stable versions 6.18.27
> and 6.12.86; it also seems relevant for 6.6.137 but would need
> modifcations for that version. I have not examined earlier
> versions.
> 
> Unfortunately there is no upstream commit id for this patch because
> the ICE driver has undergone a major revision (libeth refactor and
> pagepool conversion) that eliminated the buggy code. Thus the
> problem no longer exists in the main line.
> 
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 51c459a3e722..081c7a7392b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1215,6 +1215,13 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
>  
>  	while (idx != ntc) {
> +		union ice_32b_rx_flex_desc *rx_desc;
> +		unsigned int size;
> +
> +		rx_desc = ICE_RX_DESC(rx_ring, idx);
> +		size = le16_to_cpu(rx_desc->wb.pkt_len) &
> +		       ICE_RX_FLX_DESC_PKT_LEN_M;
> +
>  		buf = &rx_ring->rx_buf[idx];
>  		if (++idx == cnt)
>  			idx = 0;
> @@ -1224,10 +1231,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  		 * To do this, only adjust pagecnt_bias for fragments up to
>  		 * the total remaining after the XDP program has run.
>  		 */
> -		if (verdict != ICE_XDP_CONSUMED)
> -			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -		else if (i++ <= xdp_frags)
> +		if (verdict != ICE_XDP_CONSUMED) {
> +			/* Don't "flip" the page if size is 0: in this case
> +			 * the data in the current half will not be used so
> +			 * it's OK to reuse that half. And, since the bias
> +			 * didn't get decremented for this half, the page can
> +			 * be returned to the NIC even if the other half is
> +			 * still in use, so flipping the page could cause
> +			 * live packet data to be overwritten.
> +			 */
> +			if (size != 0)
> +				ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> +		} else if (i++ <= xdp_frags) {
>  			buf->pagecnt_bias++;
> +		}
>  
>  		ice_put_rx_buf(rx_ring, buf);
>  	}
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

