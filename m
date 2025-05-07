Return-Path: <stable+bounces-141954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD7AAD1CD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 02:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF0B983D99
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD472AE8D;
	Wed,  7 May 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tz8HyTLp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190CD41C64;
	Wed,  7 May 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576118; cv=none; b=uhKZWwNL0uXM6uNuANNHSqu/5G6md+ZDOhq8EwxMR5dNIhR+RKENspMPYmozNqyTuPNSOTCcpMCb7bbdAUz/OrIOUhA/MKAD9dRaJ6Y0mDAEib5L+sM4u5FsklIiMUU8Lp7ZvH7GKm1wkHRI+gkFnYdEjW5v+CQRqh3NDyYnpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576118; c=relaxed/simple;
	bh=/OnQESi+k75GS4FGnTDLjAd5wOePp1BR1JUfAZomySM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DrrMAoxKsQSQuQj5+nPpFra3IWJ7sjuYVt1s89NmUE1wdDxtpFe3BTlu/oI3Xgq58k7xdnNsWouxgTPYtJnJrm0On+Yo+MF8VQyYl6yuqJphGLpYemXs+q7Gj5lelNqgHiS88rOxF3uYCvtoCVjIw6phlHi49WL0OsnC+baCx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tz8HyTLp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546HV5f9026059;
	Wed, 7 May 2025 00:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4/g/OVPj3fhjD8Y8UxiPaBYN9z2qsQGTB15kCcY0TI=; b=Tz8HyTLpukTmRhCo
	ZtfYV0NGUwZhqruGGP2wXzY+9MtulodBduVZyWhUzK3xRpicgOR3/RR27m7S369g
	iei+2cRvPCNBGKjJU7GLku4ssPRx+bvc8lMvOlhE+EaqtYnzqoc0Z76dERwfaS4S
	9/5ZsKicLsgBvTyXLdYRuc/UyR5mEiZShN64zGT3Anf2Vxjt4yFokc4m4NyYzmJJ
	Z42PXARpJhAXiQIUj+eLCQOSvTeOIkH8cq0GVCpuPWPyPrGWC3xeS9ECHNBzZVsH
	6eVc1HdwfnyGfcpm8vCKAnGQhCPLwKw8lrdsiyVOtv3VDzSD60Y5YO/NlmBtHrIk
	ovC5OA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uuuwrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 00:01:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54701b2C005222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 00:01:37 GMT
Received: from [10.231.217.95] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 17:01:34 -0700
Message-ID: <1972319a-2261-4349-9bd6-0bccbc6723c3@quicinc.com>
Date: Wed, 7 May 2025 08:01:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Steev Klimaszewski <steev@kali.org>,
        Clayton Craft
	<clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=681aa2e2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=ojUg76g7okCP87frUzgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oj888djbZ6UQBZO7aeXP8DFXg2H9csWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDIyNyBTYWx0ZWRfX8gnzS4fPU31C
 FoDWVmPrGj42DjCU0tMF6IcCWc4ymYyJw8MRIa5ytmXyskanPd0hagWRFWjxG7Fm9k4wnIgou1p
 N4yJCblyrfy4EHTrRPMonS99OEOK+KaZkJ9Bly5javYyEEmFRpLUy6C6kCa7nK0Yg0/yz4gP5p/
 AzQA68qE70LvakF9YqGKV3azaBmck9t1ftf5loGF5BRejCWgaR5AWkJ6Yz+W2agt57UCOHx2xOE
 x+Rw+DChiL8IP4PN9u7LvadoA/rgIk3oQscWoBhzbJ6sv2a/KD8EIBwnlgKFUUqNnwrRbA/rzuK
 6rpBkd60Ep1J6zG6MJWNVrzzqqMTZH6V9y2JkTbMj0LeKyJxWt74/vNRZXGXTA+uJAK/2PYYr26
 FSzN18mfPIVYoeD8QVjQ3So1MLa0YDM75lpr+hU+k/iaM+/q/WvbVlSKP9ImFi4IqXHylZoT
X-Proofpoint-ORIG-GUID: oj888djbZ6UQBZO7aeXP8DFXg2H9csWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_09,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060227



On 3/21/2025 5:49 PM, Johan Hovold wrote:
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

Reviewed-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

