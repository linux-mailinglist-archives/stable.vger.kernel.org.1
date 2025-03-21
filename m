Return-Path: <stable+bounces-125760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24DA6BF2D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EBC3ACB53
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3291C5F14;
	Fri, 21 Mar 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="c5lSIsRs"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CD23BE
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573261; cv=none; b=oeCt2bb48IAIvld5NXca/b1+C8BeKkc9heYvvvPswV6QPEM3rLtuwI5/F6WP8hvWtVyJBVIjQJh+EvpEkuG/j1DvdRf7eUETKBTHQFggQ/FobpsbuMAX7L0dRMnfln7RnEHeRxpVY5CV4OKUB4JrJnbL2lowSkLAnABwOT/eAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573261; c=relaxed/simple;
	bh=SdiCIhrTBarDgLN9oEDarofNp34/gFdYUmSF4tTKMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj4nY4hDieCVJg/7WRxlE9k399Y74DvSQ4FYzuN/fobEA9jntIXlzWtpg+EzXJPc0jwUepEA1LGXF9GpZyD+buG6G9fAW7bYj/Xq/zeJUMbWkX9tiVuXpZdZ7+9CCsKLo0XGsrM+j7P5IckTSgLDRUhGgddx/JE5ROVWtnVbk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=c5lSIsRs; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Message-ID: <981e83c5-6531-4939-b0ad-eebeb02d00af@craftyguy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1742573256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trfnl0mlXgOimQXZYhYIs6u/12k9GzhtwYKbj7vbYfU=;
	b=c5lSIsRsfbLSTGbwlLgODbiZ+bgfgqhgVdijjJwwyoSX1UiL4s2gVslmK3rQdH0qaYySrZ
	Ut/akmLHNDz++s8KB1kSWUMzGc3FkD/N8sv8TamHvuhqhIzJQz0SDc7ZlhTHXEtiJp/C6W
	x4UfLKzmbCGUtjot79oDQNGIUdhbbo8FFmBa4stmbmSBErjlQEKno+oPb4fcvBwMCJB+Ub
	Rnt7tXNvCZnH2C09upHIRMjAW6PNKwHR58uVbu1gJ82FITtTWDNeRek2odgRbE5rIryDnt
	Ajl6vtcHLQ63KVVGlv49N7bYQjFGBiMBmQqmBhJz3gSBIi29oXxFDvt28MdHPg==
Date: Fri, 21 Mar 2025 09:07:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
 Steev Klimaszewski <steev@kali.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/21/25 02:49, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
>      ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
>      ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
> 
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
> 
> Add the missing memory barrier to make sure that the descriptor is read
> after the head pointer to address the root cause of the corruption while
> fixing up the error handling in case there are ever any (ordering) bugs
> on the device side.
> 
> Note that the READ_ONCE() are only needed to avoid compiler mischief in
> case the ring-buffer helpers are ever inlined.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/net/wireless/ath/ath11k/ce.c  | 11 +++++------
>   drivers/net/wireless/ath/ath11k/hal.c |  4 ++--
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index e66e86bdec20..9d8efec46508 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -393,11 +393,10 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
>   		goto err;
>   	}
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
> -	if (*nbytes == 0) {
> -		ret = -EIO;
> -		goto err;
> -	}
>   
>   	*skb = pipe->dest_ring->skb[sw_index];
>   	pipe->dest_ring->skb[sw_index] = NULL;
> @@ -430,8 +429,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_ce_pipe *pipe)
>   		dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
>   				 max_nbytes, DMA_FROM_DEVICE);
>   
> -		if (unlikely(max_nbytes < nbytes)) {
> -			ath11k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
> +		if (unlikely(max_nbytes < nbytes || nbytes == 0)) {
> +			ath11k_warn(ab, "unexpected rx length (nbytes %d, max %d)",
>   				    nbytes, max_nbytes);
>   			dev_kfree_skb_any(skb);
>   			continue;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 61f4b6dd5380..8cb1505a5a0c 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
>   	struct hal_ce_srng_dst_status_desc *desc = buf;
>   	u32 len;
>   
> -	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
> +	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(desc->flags));
>   	desc->flags &= ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
>   
>   	return len;
> @@ -829,7 +829,7 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
>   		srng->u.src_ring.cached_tp =
>   			*(volatile u32 *)srng->u.src_ring.tp_addr;
>   	} else {
> -		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> +		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>   
>   		/* Try to prefetch the next descriptor in the ring */
>   		if (srng->flags & HAL_SRNG_FLAGS_CACHED)

I was experiencing this issue several times per day, but haven't hit it 
once in the last few days while testing this patch.

Tested-by: Clayton Craft <clayton@craftyguy.net>

