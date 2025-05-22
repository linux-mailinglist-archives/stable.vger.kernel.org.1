Return-Path: <stable+bounces-146103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20509AC0FCF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857427AE72F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691C292930;
	Thu, 22 May 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="rXdJGOEu";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="KIXu+vFs"
X-Original-To: stable@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560528C85F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927222; cv=none; b=oPLSRqLfPJbWI5Yhupx2v7UH99iUlxtOX2rtoC74XS4hWW7MH3/aYBef9JuuHlIcmkBBOlEJvGXjjtr22ebu5IxlBFAD6+qekzeMpuXYNmQD4SiktGw1Y2qsVKlSlCpgf8kGSZEGYWF54QUZr6K/hVOayXKqQYxEYY9Gvv4SxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927222; c=relaxed/simple;
	bh=ExiGtKKlNl5omI6u/F8jfCRa/a4eEg7GmAo4NYEvkek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udKXUBfj4L8hQss/OaeTyeYbnOWaQMgAr6cbvnEydJnwHlApfj7uQRIOI5UMOVb7UqTdkWzYs3XjUiLA3ubBZHXTZL4AaiKvjXSWoPGPHAEGRg2vDgpehcJqFKpR3zOIWNSC7SeKWpyKa290H1mQlcXjBms9i21aIbFpYf+KeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=rXdJGOEu reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=KIXu+vFs; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1747928119; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=7qN1T9wqy0WbqzOLQtkE0Dw7RBPwgU3gOcnLNpwdHSI=; b=rXdJGOEu4lRsqJjn2yiXccTYIJ
	dGHGbmpxyu9Lv2vQRJoGu/MbAeILhR+qmnl0/DueO8pK1qRty0DgHLxlFfVyaC09hSS/4mJ0XyyEG
	C9jp/5hH1e8RxLAF5oO525iokgyphYLxZbhuFlz8WKmThXIosLy97pQLU1Vq+UtiK16nPk2Zhh2Bo
	vJKRwqNUU2gE+TTGk9h0yN2TElvUKmlxzUOyJ6T8931EjWc3oOxnT1EmgTrTP79IEE6NuspccMBbU
	cXRIaggZojNPwCjgfTtRfEgkSRfcARrx2RDvtyuxkIvKqqUOwqpKxlBI9ao1CIhvduNdVW/5ncW9t
	fk62ax1A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1747927219; h=from : subject
 : to : message-id : date;
 bh=7qN1T9wqy0WbqzOLQtkE0Dw7RBPwgU3gOcnLNpwdHSI=;
 b=KIXu+vFsxpSHoNsGfQmjw8xru1Jbjzfy1u2CFj5HwQraMobFeaXejnJ9wIMok4m4Z4cKx
 Hbx62T9sUDYoibCA7MA5kgYAf8ZrUbMravPb25Zo2+cLs8skhjaRTtgnZxe+tBGvmbAxdl7
 2TknueDvcOvfeKKhfxNRDWs74YVueBkRXpYpcrHY7S2r2nI120rX+6f9fj6g5Klacs7BsNO
 o4BUgtWYMlrqniWdlk/yjRHF7z/EWoJi6lQJaL1snBfbrKptDONLZYGXOh92ENiIOCvoM3D
 J5O8n1ZvM7P8vi8zZJn7G0VMIPMdfsboWfgRGeKATeVgo5Xhtkx84f4bM27Q==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uI7hh-TRk6pL-O5; Thu, 22 May 2025 15:19:29 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uI7hh-4o5NDgrofwj-m1A6; Thu, 22 May 2025 15:19:29 +0000
Date: Thu, 22 May 2025 17:11:21 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
 Miaoqing Pan <quic_miaoqing@quicinc.com>,
 Steev Klimaszewski <steev@kali.org>, Clayton Craft <clayton@craftyguy.net>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Nicolas Escande <nico.escande@gmail.com>,
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix ring-buffer corruption
Message-ID: <aC8-mUinxA6y688X@pilgrim>
References: <20250321095219.19369-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321095219.19369-1-johan+linaro@kernel.org>
X-Smtpcorp-Track: bxfuCSW2PpAI.znXCELlDi698.lmkKKA1mra5
Feedback-ID: 510616m:510616apGKSTK:510616sQ6vhuulVJ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi Johan,

On Fri, Mar 21, 2025 at 10:52:19AM +0100, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the ath11k driver seemed to indicate some
> kind of ring-buffer corruption.
> 
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
> 
> While this has not yet been observed with ath12k, the ring-buffer
> implementation is very similar to the ath11k one and it suffers from the
> same bugs.

Thanks for the fix. We have actually seen reports that could be related
to this issue with ath12k. I know that this series has already been
applied yet I do have a couple of question on how you fixed that if you
don't mind. That would be much appreciated and would help me understand
if mentionned reports are actually linked to this.

> 
> Add the missing memory barrier to make sure that the descriptor is read
> after the head pointer to address the root cause of the corruption while
> fixing up the error handling in case there are ever any (ordering) bugs
> on the device side.

Just as a personal note, driver doing that kind of ring buffer
communication seems to generally use MMIO to store the ring indices,
readl() providing sufficient synchronization mechanism to avoid that
kind of issue.

> 
> Note that the READ_ONCE() are only needed to avoid compiler mischief in
> case the ring-buffer helpers are ever inlined.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org	# 6.3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/ce.c  | 11 +++++------
>  drivers/net/wireless/ath/ath12k/hal.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
> index be0d669d31fc..740586fe49d1 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.c
> +++ b/drivers/net/wireless/ath/ath12k/ce.c
> @@ -343,11 +343,10 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
>  		goto err;
>  	}
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +

That does not seem to be the only place descriptor is read just after
the head pointer, ath12k_dp_rx_process{,err,reo_status,wbm_err} seem to
also suffer the same sickness.

Why not move the dma_rmb() in ath12k_hal_srng_access_begin() as below,
that would look to me as a good place to do it.

@@ -2133,6 +2133,9 @@ void ath12k_hal_srng_access_begin(struct
ath12k_base *ab, struct hal_srng *srng)
                        *(volatile u32 *)srng->u.src_ring.tp_addr;
        else
                srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
+
+       /* Make sure descriptors are read after the head pointer. */
+       dma_rmb();
 }

 /* Update cached ring head/tail pointers to HW.
 * ath12k_hal_srng_access_begin()

This should ensure the issue does not happen anywhere not just for
ath12k_ce_recv_process_cb().

Note that ath12k_hal_srng_dst_get_next_entry() does not need a barrier
as it uses cached_hp from ath12k_hal_srng_access_begin().

>  	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
> -	if (*nbytes == 0) {
> -		ret = -EIO;
> -		goto err;
> -	}
>  
>  	*skb = pipe->dest_ring->skb[sw_index];
>  	pipe->dest_ring->skb[sw_index] = NULL;
> @@ -380,8 +379,8 @@ static void ath12k_ce_recv_process_cb(struct ath12k_ce_pipe *pipe)
>  		dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,
>  				 max_nbytes, DMA_FROM_DEVICE);
>  
> -		if (unlikely(max_nbytes < nbytes)) {
> -			ath12k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
> +		if (unlikely(max_nbytes < nbytes || nbytes == 0)) {
> +			ath12k_warn(ab, "unexpected rx length (nbytes %d, max %d)",
>  				    nbytes, max_nbytes);
>  			dev_kfree_skb_any(skb);
>  			continue;
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index cd59ff8e6c7b..91d5126ca149 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -1962,7 +1962,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
>  {
>  	u32 len;
>  
> -	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> +	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
>  	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
>  
>  	return len;
> @@ -2132,7 +2132,7 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>  		srng->u.src_ring.cached_tp =
>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
>  	else
> -		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> +		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);

dma_rmb() acting also as a compiler barrier why the need for both
READ_ONCE() ?

>  }
>  
>  /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()
> -- 
> 2.48.1

Regards,

-- 
Remi

