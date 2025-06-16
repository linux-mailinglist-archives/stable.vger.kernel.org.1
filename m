Return-Path: <stable+bounces-152700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA3ADABF0
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F8B1639EE
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425B8273816;
	Mon, 16 Jun 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuFSwdep"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699891DDC0F
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066174; cv=none; b=sgjixb1kn3SfcfWsvNITumOKYaSIDHUrKLulkZfgdXkGMehN87PYl9BA2knV1Z939+068tKqvUQFt0mLenkFVbOcFvAdsVQG9teaKY91UoykyijYplBVb48IXk3AZMzpQUp+bKl9/EcGJ2c1q3eHFMXF4HS3u0azBZrAhoQUvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066174; c=relaxed/simple;
	bh=y4Bez+SzF4gjaMsLLDH7zveHRGwHpVNi0bnLbVkNFlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjSPZ3q6WLpWwhJm1XvcWbaCnLWtLIqMONsYy3KW0wJvh7/ywyY71KsgJ51ZuPY9/WrIVtGbBi1BPUWNlU4QUIsrl+C7UxPipbCSLp2PqfjC36qNnIRmTn4bescr1iCwW4laY2uw0Sk5Ib/28zsYEB8sMKB0hg7lN4uxb7cA7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuFSwdep; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8k0qM015148
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 09:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kyMuhoSMhWise6f0DE4q8u4a+CVo9/qSkPnVgBek2l0=; b=AuFSwdepGzor/9XV
	LpBiNvGenqsuJRj0XhD9bmJJ/zc9OwF9LUDynEbwsyoSGNJ06zbKcg7H6YCLvodQ
	MbfDQeyAJkg/SdRmGN6Y8EmaG5+U+jpvRYoSS43kpj73Fa3vOox+Fd1nZhF+HDxR
	BjGRuBRt1YOtzhhZaOVQPE/hC52OJKGXg8rjvNLVr2ydycCoaACPPEMThsOc37Gt
	D4z6t9tnhMyJ/Fn6SLuokajxc/s9rWrSzi0iuElGiNX8VTOCBF/JeB3b13iQuLSF
	hZw7oZc45tsm9u4KRhM9gvyMNnckxTQfuPDRjdpGLjY/wPo17o6oZk+uL6U3F3yi
	UOsZ+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 479qp5jhfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 09:29:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31366819969so3749338a91.0
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 02:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066170; x=1750670970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyMuhoSMhWise6f0DE4q8u4a+CVo9/qSkPnVgBek2l0=;
        b=RAF6CZS4peMzo4kZtARUXRt2EfOC7cRdk+qWoLXXomtgZ81R2nwecfSgTkdpe15GX7
         fEVHU2x+R5iM5SmIhXuLYK+AKAwEwLLxwX3dpK8G7aDZtIOBdXUPKNa8J8Z37UArweBq
         zyp4Gr5KXi3N3/Nvop+zz7+ULMXyLVDURm+w2ArV4Mo0IsVsjoMfpumHIPuRXxR/8Ri4
         YoTvV/NNKn727IBn3E5O15eHWhiHiiMjDjMdReXTTHiLSnTPevGr3CG7Qhfs2diIpK4U
         PwxmBpWLukODNiNYSo0P7L86MQDNu6h4+hYShCgF6nCSI4q5t3egr0gyPeJkTpPxyDIJ
         bEGw==
X-Forwarded-Encrypted: i=1; AJvYcCXJsvp0uT3pDuHs7M6WEKfYy262q0+tFWnLNrSkecbf9HzVI5t0Ty0THOtq9JPd3Af++iyZCpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xROx32D1RSjHwYNLE9zx3JI6ziuV2gQelEQOCSgpR09y9r6F
	lbmQiNy+ulmKpHFxb3uF4q6mOqS99dS25nZhJur08I1E6HX3lhEYZbtmm/AvF9Gcyz77OVJUwZ+
	55QSyXj/JF9gjzWxNi/qc4Uns3F+fHZJ5kKUBsDkIH7CylC59DHmXz6/bJpQ=
X-Gm-Gg: ASbGnctAq5yVFohlqQo/Vv3z38ku2X1r9PC9CEC4p+VQKc+qyUYl1hjfl5fe/E/rkUI
	zpKf5XQQaxpI78yPQC8R8mslifR6l28E1HuYQEYafo/A632yew6MRYqzvTBCNnbBme8aTblDPM9
	P9+DVuNpo4AKWzplZvckc8p6IJGpHykurQK4Lkwbz6CUXQFYtzm2W0uFhl2mdLHRCGz0G+erqzg
	SaQuHH94M41eLVJMS2xOCmu1wmpuLnoM55S/5v+8bc/3uzG6gVNJiX0f4JZ7XpXXO3St1pT4bix
	bDDXsk27KsgekG75C8Y5nQStNTNb1DLPrZIO73jvQrhZkwxvA6Q=
X-Received: by 2002:a17:90b:2b45:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-313f1cdaa59mr15010968a91.15.1750066170254;
        Mon, 16 Jun 2025 02:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsUd2qFGuMXKuccZvrFk7CIMKUwpb0xUUFf9RE6u/Crka9A/TnucG3IcOlzpJlwgNnMDfteA==
X-Received: by 2002:a17:90b:2b45:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-313f1cdaa59mr15010915a91.15.1750066169791;
        Mon, 16 Jun 2025 02:29:29 -0700 (PDT)
Received: from [10.152.204.131] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b6d56bsm9195325a91.46.2025.06.16.02.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:29:29 -0700 (PDT)
Message-ID: <63c2c889-0a09-4b25-a1d2-2aaa92d75d9f@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 14:59:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
To: Baochen Qiang <quic_bqiang@quicinc.com>, Johan Hovold <johan@kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-2-johan+linaro@kernel.org>
 <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>
 <aEFqsghEuJc3xxlU@hovoldconsulting.com>
 <ed06d62a-4b98-443a-a2ed-c92058bb521a@quicinc.com>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <ed06d62a-4b98-443a-a2ed-c92058bb521a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xr3iJFla8Mr1Us4hqAsQKF1E2G3kQurl
X-Proofpoint-ORIG-GUID: Xr3iJFla8Mr1Us4hqAsQKF1E2G3kQurl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2MSBTYWx0ZWRfX+jXXWaz1Cuc/
 OhmhTfwrZn9JZGx4NjoEye+5Bh55bW0SLosblLFB7b1LjCG14gJcudbiWHkPPnYGRzI+vtTLyWd
 XOeSIU5zsTINEXfU85/at4CbqYMWta7AYi90RO9fwDS/Vr/FBbBW5uOKDqAYyHi4OD3dKSdY3bT
 qNTs/2uHjlQDtTK0AlQPj6d4NnXcJO2TJpWUZc9uRVQGfL542R7iql+QI0WmunMMq7E4e780oNF
 1O/YcMf+1HYJp8GdjDmveB/dubbOIfiAaJJGpql1NBU3gofK5t/CYeUszUpV0118LlRacoJpk63
 4c8oQkBn7/8FlnOM8QnFMeYneUeaxfyYuZLphU9ZaXsoXHSnGt9WUcWCB2xP6sqSrJcrh9Kz4JZ
 qC8hqFAOVKeMlfpQk5ZwRbIW4E/8wce6eEEC1nXmCxkqvZsZvhniFCrmweIb7NOb1aQBNGHB
X-Authority-Analysis: v=2.4 cv=fMc53Yae c=1 sm=1 tr=0 ts=684fe3fb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Ske-G14cY86dgNt0HIsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160061


On 6/5/2025 4:19 PM, Baochen Qiang wrote:
>
> On 6/5/2025 6:00 PM, Johan Hovold wrote:
>> On Thu, Jun 05, 2025 at 04:41:32PM +0800, Baochen Qiang wrote:
>>> On 6/4/2025 10:45 PM, Johan Hovold wrote:
>>>> Add the missing memory barrier to make sure that destination ring
>>>> descriptors are read after the head pointers to avoid using stale data
>>>> on weakly ordered architectures like aarch64.
>>>>
>>>> The barrier is added to the ath12k_hal_srng_access_begin() helper for
>>>> symmetry with follow-on fixes for source ring buffer corruption which
>>>> will add barriers to ath12k_hal_srng_access_end().
>>>>
>>>> Note that this may fix the empty descriptor issue recently worked around
>>>> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
>>>> monitor ring").
>>> why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
>>> rather than anything caused by reordering.
>> Based on a quick look it seemed like this could possibly fall in the
>> same category as some of the other workarounds I've spotted while
>> looking into these ordering issues (e.g. f9fff67d2d7c ("wifi: ath11k:
>> Fix SKB corruption in REO destination ring")).
>>
>> If you say this one is clearly unrelated, I'll drop the comment.
> Praneesh, could you comment here since you made that change?
Empty/Drop descriptor is intentionally issued by the hardware during 
backpressure scenario
and is unrelated to the issue discussed in this patch series.
>>>> @@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
>>>>   		goto err;
>>>>   	}
>>>>   
>>>> -	/* Make sure descriptor is read after the head pointer. */
>>>> -	dma_rmb();
>>>> -
>>>>   	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
>>>>   
>>>>   	*skb = pipe->dest_ring->skb[sw_index];
>>>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
>>>> index 91d5126ca149..9eea13ed5565 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>>>> @@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
>>>>   
>>>>   void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>>>>   {
>>>> +	u32 hp;
>>>> +
>>>>   	lockdep_assert_held(&srng->lock);
>>>>   
>>>> -	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
>>>> +	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>>>   		srng->u.src_ring.cached_tp =
>>>>   			*(volatile u32 *)srng->u.src_ring.tp_addr;
>>>> -	else
>>>> -		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>>> +	} else {
>>>> +		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>>> +
>>>> +		if (hp != srng->u.dst_ring.cached_hp) {
>>> This consumes additional CPU cycles in hot path, which is a concern to me.
>>>
>>> Based on that, I prefer the v1 implementation.
>> The conditional avoids a memory barrier in case the ring is empty, so
>> for all callers but ath12k_ce_completed_recv_next() it's an improvement
>> over v1 in that sense.
>>
>> I could make the barrier unconditional, which will only add one barrier
>> to ath12k_ce_completed_recv_next() in case the ring is empty compared to
>> v1. Perhaps that's a good compromise if you worry about the extra
>> comparison?
> I guess the unconditional barrier also has impact on performance? If so I am not sure
> which one is better then ...
>
> Let's just keep it as is and see what others think.
>
>> I very much want to avoid having both explicit barriers in the caller
>> and barriers in the hal end() helper. I think it should be either or.
>>   
>>>> +			srng->u.dst_ring.cached_hp = hp;
>>>> +			/* Make sure descriptor is read after the head
>>>> +			 * pointer.
>>>> +			 */
>>>> +			dma_rmb();
>>>> +		}
>>>> +	}
>> Johan
>

