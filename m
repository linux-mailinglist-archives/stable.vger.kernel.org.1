Return-Path: <stable+bounces-197119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA3C8EBCD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF634E33BC
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DE2FF15E;
	Thu, 27 Nov 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+ED2TXu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXtp1l1F"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C91FE46D
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253534; cv=none; b=LiA5kmUOC3hkSH6asKeWS6FVfCiaLH86YjARPgpCnOP6HlvIrvilcyM9loBBlgkhHGRL6WmAP50SapCEADhjw5edN9VAMAVi7+wpA5tqhmYa9QdRe5BHmrnKtjKKhidUeV3YmQmnXid1pVhtDh820X4X70BU/2nsb0Q/O5Pj9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253534; c=relaxed/simple;
	bh=+qcBtseFiA92n5m2T1naWIfaTbnYB+iuqMe5ly6ejWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYvdsuAPMIFrpHecszsTWvNCb5eB6uawfg7qZKC2TC/AgeY4BR6DTDUWbsYPgpaYcH3AsL1fgfXbfNNm3lgKr/HX1gKs3D2GvUq6/1LCYQGYvL/sJMyOG2PK07xN8pXNZUCwDDbeSiEbbWa/r6rkEHGEm7AHm/ZgZMnTAoSSfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+ED2TXu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXtp1l1F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARD2YvJ1023020
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lXfQGw9aQcdQsXAqShAhqg7C4NopwvslBYymEWJH4zY=; b=O+ED2TXuJmVoFhaU
	km8EVBUOCpZ3HTYumGT5retiXw2EepI2LX/yrhNaaVRUxY69I9/mOjjmUJNXx1I5
	DmxxdYG6q9vWFmPJDM1tNUecRRbYBVY69r5kdRvtMfUzovwJp9WUHLR4V+XVHsdO
	hMxiwJErYI1jtUjj5UGAwUgau62nLd9l8nINhPmpOTLRXeXHOKrhrGNWNoTZJgOr
	ZZQUFzJLnLANgZL1XAfrloxZfRe/TkX078X766fGui+6m8P0+IzmxXJbareqdHP6
	m9wPqr1LgNAstcsOKZS5oFwCNH6nMyWawvheH3KT+3FVg+L/gVZYFyyrELZDRbfI
	/HpfkA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apq66g5ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:25:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee05927208so2552491cf.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 06:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764253531; x=1764858331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXfQGw9aQcdQsXAqShAhqg7C4NopwvslBYymEWJH4zY=;
        b=IXtp1l1Fdpo4WDrmbmYJdN2abbTB29B88mwrWpUjqUJqeXibiOK7BAF5KyqyzkCCUU
         TsjkNOpBNOfD8bDFAiBOOzb55EPuqqD5BxDJgcqhrmDXco7EKw0hVWzT/MWmDdzGG6kY
         RuoKvAYNbQ70S/azvHtg/GSOBJnN2vNMfpsRoq93Z7UB5f41lZaMyLEMJGqGpcorRc8X
         yDUZZatxQ4x/MBuJSuujV23H41GWdcrkbwuv3osUkqDZRrDZpUKbgYJZ+JNU7t1wZO2d
         D6RNInALkGSMxmX/+36o5QwiN8birRek5UdpwbjOJS//8yGzjt0q0neTEoPbkTkdANZp
         RcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764253531; x=1764858331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXfQGw9aQcdQsXAqShAhqg7C4NopwvslBYymEWJH4zY=;
        b=tgovGi4giq/VmQyAqVQRNWipMRkbLgep8Bx/dosR/1NqXRg4VnR+qlZc5nwYFTjK1P
         vZBOw02ikUNlZQ2tFWSl/A6bdKAH8W+Be7UjignqtA+csyrsKAhz8TMmy+NosMGStgGQ
         Z6GlNgz22x8bshMurgDp8FV/zMOXsmXg3Znu7m2VMdiQ9Mpb9coeuNW6F7BNQyNwjewL
         sjajqBY3Kp0S3R4tLRc18flku31KlPus+xWzGV9pW01FfuPg0TMuuvF9nIw9FT8Y7uA5
         VGm2X4ooMD7VENzP1X8Q6GldHiHNTj8oOamyyD59pZXDcqMhQPrslSf5yKuUfq231x7T
         P9jg==
X-Forwarded-Encrypted: i=1; AJvYcCWLAQSR5oWJHVaYgMM3IqmAQS/xw8bfKHBV3Gd/m9bDmZPDTOai51dr1/tKjYvI778houAB0/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7X0M4H0DD8s44xvhDWIJxRuYykV3X/NN4Ie9zlEO/8dJNvdS
	bZOc6vnSm/4LWn0BUt9yg9OuIk4ZRzmi3X+bxWZOpigVwswi4ticVL3Qbnflb8JWweXpVWtjbnu
	h8wOqGHSRvbsfV5iswAtF4Simau6teUVbdTrW3jKA/rktb2KA+/fQFcgIcLQ=
X-Gm-Gg: ASbGncvYrUkt6X8dYWeTQmIXvqr8zQkBFNpxxQxqhl3DI6HIPh9D/CHpX0Y3h+lU+92
	eFtizVR1xOE63wLklfzI71AsML9tMR0Ya0WlzIpNZU3hYDaLvpDJC0ALcPb/dMHZ8unu12zvUDc
	sDtFS9tYMuqJcwUQq5TLDldn32B5H1FlFVrmKVy6lbHZl8/hpdEOF9g3q6aS+VhRO+e5faygpJq
	HGBk1NGQZpp41wENXR6Bez5dRbw5eKWQeHFVMR48yhRIpcRLq9Vi+e8CpGhhdRC08hTeL4+GKEB
	SXPavndYrJhQt5PbKu0CtEMMgJzZGmsTJOlAj42JSoWDEPVM53PjzC3PwspbZKrjMf0PYzKKn9V
	BhLiqiZCNI9EcExFz9UBPi5pWxuHDqvVootyKMsX62TQPnZUaQRrmk3QXc4UDgAt25L4=
X-Received: by 2002:ac8:7f47:0:b0:4ee:1367:8836 with SMTP id d75a77b69052e-4ee5b6fad57mr245601431cf.5.1764253530913;
        Thu, 27 Nov 2025 06:25:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1PEAD2AIQg2biuCDwbY2+IKiEBg3avLNdeTwyi+/WMXHOuqe/1V83hpMDDO6bHfXgntzNkw==
X-Received: by 2002:ac8:7f47:0:b0:4ee:1367:8836 with SMTP id d75a77b69052e-4ee5b6fad57mr245600931cf.5.1764253530457;
        Thu, 27 Nov 2025 06:25:30 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a67sm172720266b.34.2025.11.27.06.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 06:25:29 -0800 (PST)
Message-ID: <58570d98-f8f1-4e8c-8ae2-5f70a1ced67a@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 15:25:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix a7xx per pipe register programming
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QEkStv-mTpLFuBh68rUMaO8n9_kqPt17
X-Proofpoint-ORIG-GUID: QEkStv-mTpLFuBh68rUMaO8n9_kqPt17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNyBTYWx0ZWRfX/FiO1KG+dUdZ
 NSiGe9W8pL5GVLU1QnSXhOkclp9lYSZvgLOr4DZv5WO5JElr372lpa0GHL0e1k61s6S4abAIGJ+
 It+Yyg6x7WivtsvmDz6SZHSrifPU9xOl0jgtecrxAbCJfPcLgfbSDUsJMjNBgygpWymXY5DJWct
 dTsbLPQptLBgZH82Yj0MlzGGElhsOWZO9xMm/em6vsNDqtxaf9HfCPdmLMjP4rAWpNNbjhP8pzn
 UkDKzCrtWQDIZm/YABJggwW2T68IAXzOta2aYYncJiwOnTAe0KuRZuGW+No3tGyqi8r0JBsUJqH
 WxVD7vrpGNiw/eNFll3a0mSvOcXZ6jLIa54wUNaSHtpHK3SZH5JKsSLd9SvxvOzw6lsQDLWqhfX
 1H3P4oAoUB8bw99SV01Op3mHeS6gXA==
X-Authority-Analysis: v=2.4 cv=BYHVE7t2 c=1 sm=1 tr=0 ts=69285f5b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=51bRkEKeLUuq6sK2_JkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270107

On 11/27/25 12:46 AM, Anna Maniscalco wrote:
> GEN7_GRAS_NC_MODE_CNTL was only programmed for BR and not for BV pipe
> but it needs to be programmed for both.
> 
> Program both pipes in hw_init and introducea separate reglist for it in
> order to add this register to the dynamic reglist which supports
> restoring registers per pipe.
> 
> Fixes: 91389b4e3263 ("drm/msm/a6xx: Add a pwrup_list field to a6xx_info")
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  9 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 91 +++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 13 +++++
>  4 files changed, 109 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 29107b362346..c8d0b1d59b68 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1376,7 +1376,6 @@ static const uint32_t a7xx_pwrup_reglist_regs[] = {
>  	REG_A6XX_UCHE_MODE_CNTL,
>  	REG_A6XX_RB_NC_MODE_CNTL,
>  	REG_A6XX_RB_CMP_DBG_ECO_CNTL,
> -	REG_A7XX_GRAS_NC_MODE_CNTL,
>  	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
>  	REG_A6XX_UCHE_GBIF_GX_CONFIG,
>  	REG_A6XX_UCHE_CLIENT_PF,
> @@ -1448,6 +1447,12 @@ static const u32 a750_ifpc_reglist_regs[] = {
>  
>  DECLARE_ADRENO_REGLIST_LIST(a750_ifpc_reglist);
>  
> +static const struct adreno_reglist_pipe a750_reglist_pipe_regs[] = {
> +	{ REG_A7XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },

At a glance at kgsl, all gen7 GPUs that support concurrent binning (i.e.
not gen7_3_0/a710? and gen7_14_0/whatever that translates to) need this

Konrad

