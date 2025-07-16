Return-Path: <stable+bounces-163058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99401B06C07
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E93188B2FB
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE7277CAE;
	Wed, 16 Jul 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7YYe9l0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7C1B6CE9
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635428; cv=none; b=cY1t3TmoxXT46WLwUpNusQ9IfaGZRqslcih8QKELEANbs3BWxmj/FIby2p1sHrIgN52zDt4ibhaackKOtLJ9mfKeCPJPsE0nbaWYROQJkmc765ZNO2RBDcdedvOdb+oeBNF/eWCIcPIV1spyIEidaBmXFLKQyPDP7eE5QnopmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635428; c=relaxed/simple;
	bh=+bE5/H9chYJq1Hq5l46H2XlpTKa0n+OuaZqkgbSrK4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJgeJ+9kXVH2buTNjW0Dhao7l8QRB13IsDJC8z4g2ctoN+kCSwp9XciRSMbEwbi3TZoYiLrvDflALfZNHKV0qXV4GdGMaqxF9EUsXvEFhDfk6m5KkN49cTddmQmnMwh/56FjAuTxHXUr9ZZs9WJTkqHv20ayiIGV8dd4Z+OIIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7YYe9l0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDKjo017609
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1NecSqh/K6FXbaYkgId4IAbjQh5zLHrJiU/Yh9hchg=; b=g7YYe9l020tJCFHM
	Kl+x+DKnpjysRbOWcWVs2tVAuyktWwyyuP5gVJkaqeTZ7Ln1Mr/Hrq4meXgmnTCA
	kiYVJmaP9/guUMfyo82hHkOdmn/iDlKnOEgnzMRLA918j93ZubHEN+MVLLmjgF+O
	lei3xGovsyCaQEFCiPcWJC/+s7my2SvXybNGqGUaUPnwNcowho8viXhhy6buNDIk
	9WdH146m/Gj5USCWPHAWDkyeDFb73JMd7ZYauDXws4gAqGEyKq5zt/r8jq7RZ2gW
	Ds4vGgiuFyVgYrfjLH6AINGgyLV9jLuSqMlSEPYZ0W8KCMRsdgJuD8tfqxGoXBoP
	Lg7Wsw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8a7g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:10:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74913a4f606so4625334b3a.1
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 20:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635424; x=1753240224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1NecSqh/K6FXbaYkgId4IAbjQh5zLHrJiU/Yh9hchg=;
        b=pV0xh47RndbSG+kPkXhliyjsERR4JscBU9kR2DxDk6lSei6lL67qkqKAe2wUDMX6ZF
         6YN0L/aVPORnJC1JrFGmOfbEJJh5eCzpSQs8s0ksdfyiGnJqVfdXdpqN07e1nV3HecO+
         iqkX5coB7PT+vCVAuNacNvQpl1IK1xRK2xR2Nz5qKbqIzKL7BcjpIWyiI7gQ75ak0Gau
         rvQHf1ZUIsaqFegtzMuJsbMs3Z8UH3id7S5dL6pgCTbBrZu7DiiO7oUyliVSQqeXnmu0
         fFYZIRYvrv7NmXpFUna47X8jyEDA90f37cacaRd1PXQuQzFZmdKP3plMS/4qeNIV9/mi
         ZEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUmABiYVLiin+imVS0KkEnNADAL8Qcd4geIMaYRmqc8HpA7bwIKoOXuyALaiCtYqydaWN2GMGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03fcLgXMQj+dq7tj7h2VAD8yPpGJ4ADUO5hTySP3vaPyZcSl4
	TWUjNZweGuAi4D4H22TdCUcXKVckdEiQkaWEJ77Erli7NRdECRD/LgFK11Z/jNtuAMEuTTajZOY
	nTn/qLWZ7+Yl31aJ52wuCGFxNM9bEa7WBFr8PXRvKm+yVp2TWGMxMavvhKgw=
X-Gm-Gg: ASbGncu4fUhkvw1m/bpCcEPUh6MCR1UtGMSQzKh2pdz9HyZT0Wcbe2oDNHnlXaDFI8m
	tGLMBWm1Hd4Do5LXNFAGkcD8FMN2m3krfBOjasZlPhJPmifQi3yxQKCbL6upIE7iTN39/npwsHG
	yFi8G24J7WVPT5Ek650oEt/gatuvU4+Z/Yyw5JjfoEQmcwAcQkRo23TcGXpcRGSVUt0TQFgxHdy
	mvxjutObdkzbcn34xiqnhg1vpiVKJF+zwt03Ilq9NKA3YclXPaVtkgRVsBqa1DNLm5Xx0JnkMCw
	ys1ziuGWqLqzYbBrJVFfONuZUrE6kwN1U0ZUTdZKK6VsZNPoK7NxDx+2gljtoHFRkSp9kI/mpwP
	or52Hpzq4lGXbpSwjTxBnRNbVWnAz5UVD
X-Received: by 2002:a05:6a21:1508:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-2380db8e8d7mr1249310637.0.1752635424540;
        Tue, 15 Jul 2025 20:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiGRFaDVgMVw/6S2T7ToRpEE2QAahqPlEgNa4QLbCX9jXVhoF1n7FVrczoZKBOg8MHlEG5KA==
X-Received: by 2002:a05:6a21:1508:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-2380db8e8d7mr1249278637.0.1752635424071;
        Tue, 15 Jul 2025 20:10:24 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c989sm13514936b3a.130.2025.07.15.20.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 20:10:23 -0700 (PDT)
Message-ID: <7ecc1cfc-5033-4d74-9303-9ac58527113c@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:10:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>, kbuild test robot <lkp@intel.com>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250715132351.2641289-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250715132351.2641289-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyNyBTYWx0ZWRfX3nBsFKbl2BYN
 iRA7xQdi2lnp3XybiBtcpbx+KalmodqWBJfdIxNK8TMNTwe5JInbVPKtprVww3ofevXogAG7h5Z
 f+ho1jepK4SrQxb1C/jSP8/J9dX/lvzxcU3XFerpp3pyRFxkYEP4Uu+rrHPxyYySi3YepYT4XYA
 uajg0/fDPpoDHcmsWo3iHBhLAh6zfsHffplJ8s53zT+Yxawcbnf6eQlPsxfdtulTRkeKgmDlhhm
 MOu3E5DBPDZ0Edu8JukBmbWbpjyLnUrlzNEEgZVtJe6jacTxSz4PB9E5nG63dNlt9jAG0+fZ1DE
 tRiU2GKoLwhgY6AVHdAEgi0xU0ThnWZ7NAVWlYCnXh0wa2eRafUbEkXi3BIFpCTpaVdB+q/+rRP
 hxtWCHgLCV42eAVFhaogkG9R/PboZzhIUepVvDWl5ZrI/5wgr6PNplw9TGcJXX36CvXWVNFv
X-Proofpoint-ORIG-GUID: phXH3QEWRZx6gK1L8glAScV5bH56wApg
X-Proofpoint-GUID: phXH3QEWRZx6gK1L8glAScV5bH56wApg
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68771821 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=FO1u493g7a1ack9Z5SAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160027



On 7/15/2025 9:23 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Cc stable and fix tested on tag
> - Clear essential fields as they may have stale data
> ---
>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>  drivers/net/wireless/ath/ath11k/hal.c  | 12 ++++++++++++
>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 4488e4cdc5e9e..34b27711ed00f 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>  	mutex_unlock(&ab->core_lock);
>  
>  	ath11k_dp_free(ab);
> -	ath11k_hal_srng_deinit(ab);
> +	ath11k_hal_srng_clear(ab);
>  
>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>  
> -	ret = ath11k_hal_srng_init(ab);
> -	if (ret)
> -		return ret;
> -
>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>  
>  	ret = ath11k_core_qmi_firmware_ready(ab);
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index b32de563d453a..dafa9bdbb3d32 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1359,6 +1359,18 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
> +{
> +	memset(ab->hal.srng_list, 0,
> +	       sizeof(ab->hal.srng_list));
> +	memset(ab->hal.shadow_reg_addr, 0,
> +	       sizeof(ab->hal.shadow_reg_addr));

nit: I would add comment here that no need to memset rdp and wrp memory since each
individual segment would get cleared when

ath11k_hal_srng_src_hw_init()
	*srng->u.src_ring.tp_addr = 0;

and
ath11k_hal_srng_dst_hw_init()
	*srng->u.dst_ring.hp_addr = 0;

> +	ab->hal.avail_blk_resource = 0;
> +	ab->hal.current_blk_index = 0;
> +	ab->hal.num_shadow_reg_configured = 0;
> +}
> +EXPORT_SYMBOL(ath11k_hal_srng_clear);
> +
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
>  {
>  	struct hal_srng *srng;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
> index 601542410c752..839095af9267e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
>  			  struct hal_srng_params *params);
>  int ath11k_hal_srng_init(struct ath11k_base *ath11k);
>  void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
> +void ath11k_hal_srng_clear(struct ath11k_base *ab);
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
>  void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
>  				       u32 **cfg, u32 *len);

other than the nit:

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

