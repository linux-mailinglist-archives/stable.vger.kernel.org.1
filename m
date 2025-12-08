Return-Path: <stable+bounces-200335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E3CACD14
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B073053081
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24E2E54D3;
	Mon,  8 Dec 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYZMjRSF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxxnzD79"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FB2BF006
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188520; cv=none; b=Ti0sKkXfxZENbgBeO1LEJ8s0ZC/4MWdOyhNGQnb7uEnWJ3r0SyQL8DLRJVqzzT9DmkSuRt6b3zVt7W0kK8NWGtVLNukV2RPg22esGh8ruLHwPF0F2fgrlZIQFhvVFlg8RpEpQT+nA7ArOapFoTrwFTT47fFZMalJ8evV/mn5bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188520; c=relaxed/simple;
	bh=6lxXIkzbDAGAIeMBp3NAuBv0FGQ0Onp6b6eakQm4BAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QASMKQgVhMqPty6Ed57aNHJJKRczhvFcmX5uye3I7jsyQfIEjw61g4CUa1upXdBrNyUTP2kvJZ26OsjAIIqb9HwfrPgc8xVQb2k9keOzFrJ2Sazbn5p9RjtvAyqm+YKl8xQPJO85uOCj7ZLPTZ011OClfRzAkw8jfTHmq3PbvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYZMjRSF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxxnzD79; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B88Y4DP2915728
	for <stable@vger.kernel.org>; Mon, 8 Dec 2025 10:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=; b=KYZMjRSFuXDkYsGF
	mupgbAPftYjwMnWo60n7ArrV8tGqyTGjzxlOqd3ofwFu9DN1MFJGZm41PMhZ6ddM
	bP4n0hU1sxBlu87sjSkDFKOYpyk4J4iNlb6PLSkukPERoNuK0UKIsA/AkziTZq6E
	VwtQZOXckqVY93LexDtTtADnGEj8hpNMvZ4A/RDkBtFN8fUIASdmmuPOA2cQGSFe
	9G8Z/yqh8r3X6ZQfyE44IR3G0xjX1YYSpg8Ac8lIJ387UIHDBzaDE9ZFrv5DqSm3
	EYb2lnEYLchxQtC43l5X2X6ujdsVnWmxR/mA76kutaXQ6r1jnhc3VbIgjVgS51+W
	eZnMuQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awhaqskh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Dec 2025 10:08:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29d7b9e7150so35919305ad.0
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765188517; x=1765793317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=;
        b=jxxnzD79ivgVb+/0iL4mrzYAWLMZsBkyOWff4S+WO0lAM//SIgfAaAhyiVhWHClBpR
         /taUNFPaJV23AAu6Wv4l3MXPdY8vx9jTyewnItS2b1XsuVRJYI7FKyVi2qy2z45WzFdm
         DKKVX3+mNSIIepd6w/O2Jm8pr+Q49bVwzAL0vaW0kDqKqbsd4ouYR3b4JtldyoyWxrQc
         ZGBg26tJznKzOn28OMyrcRt+VCs1cCfsvV/OcBpXkqAejXR+Cb5U3RrUNZ7wrBfvwSCR
         x25qWTv5J/GQY/pmdslpYpFKF2RfdJdb27c4BFpA0E58tzU+/PQiigigkG047QeOi/42
         CnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765188517; x=1765793317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9jHdYoc3oT9NHwSrNbma2xbBTUVUF9I4q9RnVy+smo=;
        b=PxE+/En43XQyvxka9PRCPXq8sft7ydM0y1nYeK0b5Wr32EgQVMheqrJ5t4uWfmXykF
         Z4mDlyDn1/+V4/V6GWoIYC+503Fih8qF6mGxLregCZe7leLn48+CYoJD776tWTq+5oQ+
         ZmKugrRz4+46NZC4Mc9VfoZau1xohoP2HTpiFaLWzWYVWYJu8sfeJaBE3oMvXFnsFjFM
         wYmd1WcEb+xS9zv5is9/VFXO34j9dBoZkbTPiRO/dI25e9ZOPds7vDcyNRZCvSzaP+mK
         Yx+f7MtSxmv83xvyEtuvAwUEezr065CrNYD8zBXHBUaygqYkQrPmU1MPkVL3VTah96Qo
         PsGg==
X-Forwarded-Encrypted: i=1; AJvYcCXp7vjKTbA+ilUkXiiTox9CGg6oWQz4A/m/lLa4DglWTp84VV5moO46Iu+vcnTy2puYifPOlj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzzlEKGsZ2K44JW84iLE6HTXxW3l7Y2475RbZEnN1AaVFXmux
	CmHPjAyf3cMTqfLEI0iIk9f0duKrNLk6s43Voxkz7kg/ZZZM7m+69+34kIaZEIR0Nowbe+R9Hb3
	+TIMVa9+qhZMPznI6WtrbOOVOkd5onZqQ+PUOKe9IR6jX7OpGspnTMY/uVCA=
X-Gm-Gg: ASbGnctq2u4X6y/QPCQ+41KzGyhb4fNkYsIsERIZr2EHxS3eDrTFk4RN2UGI6LO+9hj
	T7quVV4R3mkmMEJunk19MJH79qIK7cMZyT30VX3bmeZnuwU21c6brqtqdlCj+PyMKoxkwJLupzV
	9OnLg5g24LpW74viGyIsaf3FBPZ12zYhqmH+qJKv4S1FALNw+Wd5XXC8UHwEKo3RYxEl9jXdABw
	psK7SSrWHRoD8tJCwIF0UMGOQ/U5tRajCUFbt7CxYZUk+ZH8/CHStTrQd8z9gLi1Vk1w54PN7id
	Ln1WchBIQ4ObxOZREQDXLkeCh9Avw9DgdaU3G68RVe+rmX17aNT1+ks6c4l8XK07ybSpBslNx8I
	gVB6ltzQXpng4v6QOKXcDFCsQkYRAEs+60GpkMFINTGr+zwFXeaz35MI=
X-Received: by 2002:a17:902:cecb:b0:290:c0d7:237e with SMTP id d9443c01a7336-29df5ca8b3emr75729385ad.39.1765188516989;
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUA8/9IdhCw4HBguQRklGSxNYLRNSBocndWUNTCInJrc5onf69jXc87HhRJlEXhIIgDWsBDA==
X-Received: by 2002:a17:902:cecb:b0:290:c0d7:237e with SMTP id d9443c01a7336-29df5ca8b3emr75729125ad.39.1765188516473;
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d75sm122467355ad.98.2025.12.08.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 02:08:36 -0800 (PST)
Message-ID: <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 15:38:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
Content-Language: en-US
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4NSBTYWx0ZWRfX6rZTFL8STtkd
 PDibEigOZW/YV2mVPyBNxPql9J511w4TRXeUi+LRvdoPJcWzEFC/ThPTLUVHfWcTfgVINalIJ/m
 mbfTTwY8VpaPoRuD35c6MnDAbuPJzbTGYtDFaABoV2d1WDzJW/XW9YcLCQT+pXRQFMkxjbryZo6
 JeNv+I7rFEosA/ARUGyUE/LQyJpkq3L8d6LI1519TSTGuk+rtc1uCPX0ua8zpcRNPxNYH9lruhy
 BtB/IYsf2zeuF9k8muenzhviXni4E5AFUGYr0LBMm9kemd/tfbpq6axPHDfxbjd0gKVvto4dQt1
 HleGEpcLR5lw0pFfPpbgEYqMGBcHcUC3C8f1r4q4D4D/0cRrpFaC7eRfQK9CnxJqBe1fp6T4lpj
 OU98KN9GRpPcrgKil3lN51YHgEZUvw==
X-Proofpoint-GUID: uZ9_wopyASdKfqW0GIpHyzsvVZXcSmGS
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6936a3a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3EvvSBrUXICK9wu0dFAA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: uZ9_wopyASdKfqW0GIpHyzsvVZXcSmGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080085



On 12/6/2025 11:28 PM, Alexandru Gagniuc wrote:
> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
> assumes that:
>    1. firmware will make a HOST_DDR_REGION_TYPE request, and
>    2. this request is processed before CALDB_MEM_REGION_TYPE
> 
> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
> after the host region.
> 
> However, if the HOST_DDR_REGION_TYPE request is not made, or the

AFAICT, this is highly unlikely as HOST_DDR_REGION_TYPE will always be before
CALDB_MEM_REGION_TYPE.

> reserved-memory node is not present, then res.start and res.end are 0,
> and host_ddr_sz remains uninitialized. The physical address should
> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
> 
> resource_size(&res) returns 1 for an empty resource, and thus the if
> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
> 
> Use "if (res.end > res.start)" for the predicate, which correctly
> falls back to ATH11K_QMI_CALDB_ADDRESS.
> 
> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"")
> 
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index aea56c38bf8f3..6cc26d1c1e2a4 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>   				return ret;
>   			}
>   
> -			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
> +			if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>   				ath11k_dbg(ab, ATH11K_DBG_QMI,
>   					   "fail to assign memory of sz\n");
>   				return -EINVAL;
> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>   			}
>   
>   			if (ath11k_core_coldboot_cal_support(ab)) {
> -				if (resource_size(&res)) {
> +				if (res.end > res.start) {
>   					ab->qmi.target_mem[idx].paddr =
>   							res.start + host_ddr_sz;
>   					ab->qmi.target_mem[idx].iaddr =

The rest looks good.

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

