Return-Path: <stable+bounces-246792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCESG3xEBGqqGQIAu9opvQ
	(envelope-from <stable+bounces-246792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:29:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC442530A2B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A286312E4AB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A35262808;
	Wed, 13 May 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2cq6pwc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8526FD93
	for <stable@vger.kernel.org>; Wed, 13 May 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663259; cv=none; b=ZuIsPM1bXlpFmZFY7Pqx6P4VNHkuaZkM8JZ1LW7QuQSEmtkbyy/EuwNeD7Gv8ijwgeHM0Q7kh4KDgx91zFMwgEDZUz5X9qn0PXBWnHKUwCi9wrJGw97cf8LEyx8jT7/LdeLt9dkTiulOjkFRQTybtEiWwnJbpOr9l9b+UpFj1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663259; c=relaxed/simple;
	bh=ERwsM3PJL5y8q+Lhj4NVYS3FtGsrJrNfL6nETyLWeik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL5MIhSlH8Qg4VkK4ndzWwxodRwj+AmCbmPeUKyq8jBiFZn257v00l2QBzY1iGnM42bWx/gRubWZs2p3oTUkV1ujJA7rm24absrPogYuReQ1tmJHT1dLVRSWuuCsJxdPCipj9v+lTjHSLF/Mo9j4CVReiojVK1/vU0ACZ+XabRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2cq6pwc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so58527125e9.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778663254; x=1779268054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN/W8ebLgutWz02+3OnJOFBU8z3ZOcJD73mdZlWwDCo=;
        b=J2cq6pwcDO2IC+Mc/8cYcTi8F1NkF78835iJBAZdO75gebMz+98F2IB9CSI040LdHo
         2TydZOoxCXlx0M/S1EEieyq/sTl9Z4NNBwJbZXTbm/N1KARxLuRmgoJv7T2+Y2qZG370
         lXUEEiH0Td/Zp1DwCRkpdpKn571UM+Co/UmVUkL6bsxjxOBqQtcq/uU1aVjeBqSQZRuH
         YVlOk99sMYmJDSeF4mrvRN+6Ysp7unme3EEWSEzpep9OLcnXZfy/kCAP/Ovnya6i8mFJ
         l7/8CLXdmPMlxir6tuFTkozkzqxw6ur0z04NnA46vCnpe5zuJFoMROHZaDV4Mzv+A2Y9
         Bxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663254; x=1779268054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qN/W8ebLgutWz02+3OnJOFBU8z3ZOcJD73mdZlWwDCo=;
        b=coRFghOjdciwu13TF7w7saelucg5k+Yllpriy9braKNKKz96tr/ioWKSdGGKybv7JK
         6k3ydVlJy8OKs+jLf7X856DKbP1Kd5kfDQFO+tvMk5VOUg1ITav2mrFgY+HLR39jD7mH
         FSlymITBOtUV2exrekJb+/dmPafc+1gTcCHbefGWorJqt/6NMw1WOmNoBkeCaw4kuwNj
         ZzczR0prHPO6xwxpPGJj2Ym+F3EMtve80mL3DPW2xDUBJE4Nxk00gEe8Re01aYDgok2G
         YSZhXPcrhowWaOZ58l/Kx5lC9CIBqj0SrbTTF7zxiphGUq/nnEChKQoe9oeBKjjHD+f6
         hyCQ==
X-Gm-Message-State: AOJu0YxX+Is2YmkXrHJ11Qw2AVEgZUS5cek6HHl7p8IDwlOEwQ1ppjMi
	DTgFdQ2l5wxv1j/H1pov1gtN71J5FpaJ6QeIGPBobj6VBjkKlwIkHFNCmtVIoNqs
X-Gm-Gg: Acq92OGQ6ukIk/sBpMJrdkp6/ozwwPdGadRWoDq2cLIIy1R+4AO9RLxoSMcex2YPhgj
	zQSV5JbV82E3k853ePkG+ekhySKkM8DK7UCNPP3jmI5loXHOVTrNP9axQBinSZmqn6z+A90Mam0
	uUTCukuRwoFGsHG1VrNS4qBHxZ37dOfXEJCFx2YDyvbW0/8ecA6z6X4vNo8zdov5QUDO7SO8Cu+
	rym9ckxRIkEQvuuLi6X8GvRAw1SM/nMz51mRbHzc0PR2HpMAnRw/ld57qTfJQNClKyI/aMGlubW
	fgSvZO8RNC7ipw7aCq2mMwYtjA+4e+NCGpfUeYtxxqlCC1ksx8QZmkif6Jv2vt+ihnlxg5Q8ZZF
	W4cnt+qs7o3Mcy/rQZ5KqTl4vO/8BMNywMKGHD2HYOi3EjCKr7CAY6Pa/U9gTPqNrFu0K9WIoUs
	IH7wlpoPg7Izdr3EQlKMichsFQ/LokaaoKZUtDA8wiBdOoPt+9dIcNOZgP+sif
X-Received: by 2002:a05:600c:3b84:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48fc9a0e266mr36229105e9.11.1778663254336;
        Wed, 13 May 2026 02:07:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce06ca2csm30681655e9.8.2026.05.13.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:07:34 -0700 (PDT)
Date: Wed, 13 May 2026 10:07:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH net v3] ice: fix packet corruption due to extraneous
 page flip
Message-ID: <20260513100732.499e3f49@pumpkin>
In-Reply-To: <20260512181953.1689-1-ouster@cs.stanford.edu>
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BC442530A2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246792-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email]
X-Rspamd-Action: no action

On Tue, 12 May 2026 11:19:53 -0700
John Ousterhout <ouster@cs.stanford.edu> wrote:

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

How is this different from packet B (in the top half) being
freed before packet A (in the bottom half)?

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
> Cc: stable@vger.kernel.org # 6.12+
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

Looks like you only need to calculate 'size' for the !ICE_XDP_CONSUMED path.
You could also use the (likely cheaper) test for zero:
		if (!(rx_desc->wb.pkt_len & cpu_to_le16(ICE_RX_FLX_DESC_PKT_LEN_M))

-- David

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


