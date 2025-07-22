Return-Path: <stable+bounces-163680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3DB0D63F
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62C2AA4358
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFC42BEFE6;
	Tue, 22 Jul 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNmGnpZB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFD23C50E
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177672; cv=none; b=QOn/9zPwwpmmJN6eUmE2D95hKPPcZpGu92DWk6ttD6olnqajzK9srpB8ggaCuIPxf8lbWICEkiT01N8WtodWfuFR7vG+7WwG5pzew5+tswAzJ33evm3GQFZ8e5wjTggk5bCzzjLpZLLlehBokbW3Jyj1DPfrNix//36mezGA1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177672; c=relaxed/simple;
	bh=/A5bLX16piFxZp3C1uvq7w0g/FlmchWFhW3t4OYe1G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUj9JrX0cr8AZK0z8o+TXQCFG1K0HV7JilloTC8RG0YWF3ipwFLzBpGly5ywU4fPfXQwkb3RRtUhyybpjGW3uUu+CzACYGr7tIv9HEFqxQ8U+jY4XybEuTWgE8ikMgdsNlHO1V8PvG+r8mOxaDWX14lIOfIRaBUMu2O3hy+PrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNmGnpZB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83qdH010552
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8BjM9ebfFLsQQcZe6TQ0vgUH4ajpI01hnGqNMGuQ5N4=; b=bNmGnpZBKEr/+gT+
	Gf7YHgqDyL36SAGt8rwfkfYdw1+m84Sa/N8PyIrOktbzpow0609ipmsdR8zbGoTT
	v20gVWNzdF5F8d1S5/4ZrXGo23r7sFMTaOlqcQKYZ91x58pk6XxlYQ7eDXQuwsF1
	7JKMJx8KI74TlvzC4Q5kn2Z1av2o+gkjjvgJVbFV4bfPMsXv0U39DF99xGajnJrf
	0Nq6ru8p/FDV0JMnSecEVJiSy6a2hyty7wM1416WdVdZPzOoLhxzD94KKWRXzOAo
	XXh+LF5n5HcQL6zVRZMZKqsK54dIISctG49NJF5SEfSQFKVqzbRolryju45TWIpO
	ABzC8w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t18asw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:47:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-237e6963f70so86737575ad.2
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 02:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177669; x=1753782469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BjM9ebfFLsQQcZe6TQ0vgUH4ajpI01hnGqNMGuQ5N4=;
        b=D/DnXQXMp81sLWaq1SDMuxbKuZOitEfz+S+qS5V+u1GZ0H4Xhn8vMFsYfAcZSLW1C2
         xW0HvA94JQgvjnSoJiWZxb0bTq8p0LhmdVwf2RIhSkn5x7FkbgBD6M1iyKryRm0out72
         NHLsen5auAyXTpsvgvMdywmFZfHLmr8jOLVN5p35crY1HTHI+Qgu/k5WeZIu+dPtDoNi
         RjkduXIxGNM4J04U8wvlp+HQnnbL42uV6Xra5BGriB7Q+xvv9Ju1IsZSxNSuwGhQh9vP
         jkRskCxcYCc1f+JtTagoBxRkOIlqtI0MYHI398t/VuzwUlKGpilcD5TIgD1AoLral4io
         9yvg==
X-Forwarded-Encrypted: i=1; AJvYcCVcaKLUGu9Xy5212lHGJTCTvFzbVH+QyGT0qUnqS3rp7AcVRTs2t2rXa7zdZ7shiEqG0TIGzos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMbGHFRxl2dL5RTUgoDaNkWkpq2Dx4pwAuft2kg0nkxHsbj/s
	tI/ORopj/iI9RxRYpRqHlGZpxJ7vSczjaseM78whqMdtk70WkNKjq6XGy9x20F/0YkuxfAbpk51
	4jfAAALJQqkXhViYpcOBju3JYdu48uaAH64OnAl3pinodtmzXapYHd28fjLY=
X-Gm-Gg: ASbGncta/QPyqricwgbUBXcmD8ME2WzWbdwD9iYl+realbT2TfaH92Xn7tZ+ZRm7z2C
	xtS+F4Aeb4iX+RPzEYQa62Ve9OI7XB+bHQUuYmwwMymt6zn7I5Bi8IAl+9wQ8dzOeCoLNYTH7FT
	z8bu5BIg/ukdD4G0vnqii5vUseZkz/c7igDFPBM3Jgbd/MOql4xwg3ZvGt8tOnsmXXSuVJOLzVo
	t6o+3QzOLi645QpD3ajULruqYjeBU43yrKHcG9eCPi0nlC1SX0a+3XMQowSHKzV/fHQXtqowXK5
	kYpxEwk6NOxEE8DpjkdKQkV4TEwlBUUnO4DZCtoMWGh7aWkNec5Li9LHJWuQnDy65OCUqFv7za7
	1N+FExMXqaNbJBhVbqUHfp4bhiQr71fA=
X-Received: by 2002:a17:903:2d2:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23e3035f2eamr249469205ad.37.1753177668775;
        Tue, 22 Jul 2025 02:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb4WZW5dxHh8zGqRjkvN4xW3CSAyaaR3EwQbz0e6h/H5rEz1JsDrBRAu/UMYCUGTF2EEQHYA==
X-Received: by 2002:a17:903:2d2:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23e3035f2eamr249468855ad.37.1753177668301;
        Tue, 22 Jul 2025 02:47:48 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef9aesm72272625ad.211.2025.07.22.02.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:47:47 -0700 (PDT)
Message-ID: <1598d25d-e254-410e-ac5c-66d5450fd686@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:47:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Sven Eckelmann <sven@narfation.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250722053121.1145001-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xCcJbBMF_lfJ6Aqrwj86gQwrsY4j0tSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MSBTYWx0ZWRfX8PUVUSYAjF0I
 /EahP8Q3oYmEBJ+YGsQojbsIlQQR3RVQ3Y3pKCO8Fq02vGTylvS1ARV9MDctnFdLAOursMMp02C
 jaWXOrOwqG6CKMnPTcWIR2rt0QXwqQGXjRcRGiImLy3BuPFVUc3RPfrcfV+zDNGHekwoWILIVeG
 t0kIMYXuK2BxOnq8Fw9MbngjGpQsIaL+XDUM0lydQb63wDkKa7m5x1PPds4etAzJofgznRvaC/n
 tHogdA7NRnQaOwi141eeiINzw80ZED2m7nPlGg4Y6cGjXwJ7L74IARpmVVDYPwSjoF8ixNVsXZN
 lk9+vXPV7wcR10GAMXVxfeOx4cRon5CTh3uQxAPpS20lob+HLHUHWK4Fivom4YuvzvGOIeJi12K
 p0RthOl+w634qGOigHEsDumZZ6R/D2iHJzLAJNXtrKUKFArTD9Hw7knqEJBi9eo5ha1oKmXJ
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f5e46 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=FO1u493g7a1ack9Z5SAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: xCcJbBMF_lfJ6Aqrwj86gQwrsY4j0tSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220081



On 7/22/2025 1:31 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Cc stable and fix tested on tag
> - Clear essential fields as they may have stale data
> 
> Changes since v2:
> - Add comment and reviewed by tag
> ---
>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>  drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)
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
> index b32de563d453a..e8ebf963f195c 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
> +{
> +	/* No need to memset rdp and wrp memory since each individual
> +	 * segment would get cleared ath11k_hal_srng_src_hw_init() and

nit: s/cleared /cleared in/

> +	 * ath11k_hal_srng_dst_hw_init().
> +	 */
> +	memset(ab->hal.srng_list, 0,
> +	       sizeof(ab->hal.srng_list));
> +	memset(ab->hal.shadow_reg_addr, 0,
> +	       sizeof(ab->hal.shadow_reg_addr));
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


