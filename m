Return-Path: <stable+bounces-197544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16847C90428
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1D1F4E2E8C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 21:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F554313534;
	Thu, 27 Nov 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+jWBKs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KtDvjSFT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CC301719
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280654; cv=none; b=CA/slTXhzmo+NSgw54Qwr6qBrXI2bX1DipGWD46zSswJxRYDDT4qZbF0ra11q65pdiTyR+rd264KXDpScHSb+wR/29el4Ghz+5A+mNs65y842diSnijP1zoy3Pl41DcT2bQx3X7zM8V10c3vcQxrdm3mcd3jM+botV6krK6F12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280654; c=relaxed/simple;
	bh=3GgJoLsnQaKor/Sz8O0kLxTHQNo5aw3hRWdC3uGQtTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EycccyqpQMUzUzTYyscROlHj7SvNzbKEqf4pZO+2TH1ljsBklYueWhpVBVZzF5NbKWzpLTr+/kh7CU+u3VY93LegXBU4NyvcDkuMhORLlb29Paa2rtSMqLIGJ9YqJiVduMH7jWYpMNv5siftHHqfAeUNy3bJpn7/VY0QPpc/gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+jWBKs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KtDvjSFT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARBVkeP722932
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 21:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pI+nNCxm6OA7uNJyiyjjUs/+UrmghoHh3cuApsI018=; b=T+jWBKs55M7CEQ/+
	48g/5nOxxftuDMVHBohvlh2CRaVfmH0OooE+3uMpY+HExtdTwe2NFFgyFgiTtvKL
	DZ9hDx/f2E2Q7cwWfvGhPH6TH+eYz7sfc1aFbBbN2S8zln9GZSRh2zPW7j/zVtwK
	BrBYe0J0frykh3s1ZZ5YXXJOidXZqL77V1IQLl7tKaDQw3UNAFWvZg5M/vHTrflF
	n8MPe3zPaxLqBcaMmSEXqZxdBFC7TuPlzrX/WclZcrFpMrOvR8bHPU+551R1abhb
	2SFPph7ryp3jYh5QNHNmBg9Ab4G3K1rmmN4GsgPHIcj7yBR7ZDoDPbk9Xq6B216D
	09DK4g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apnud97ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 21:57:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7be94e1a073so2015662b3a.2
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764280650; x=1764885450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pI+nNCxm6OA7uNJyiyjjUs/+UrmghoHh3cuApsI018=;
        b=KtDvjSFTeHrMl8+qgnmftJHdv4fQkBZ7Iy9Eu9KnmGYlVSGN5vJ0YKmn8njAW2Vgjn
         es370xnbVZKlv1vHeYcnnxjTp7Pcbe90MujiBTCNh0Hz+Jj+YCp7bkQqnGWc3B9OEtV3
         LM0szwovyZWFQqNSv7gGQTsaUeHlhYG6sybUm3hd92LGfTp4UNez+3UtXHhhH+zeDoAB
         1QrObsLwGOLf4AA5zUYFB5DeaX2i+xL3+zq7CmOlPVox7altwdFyQfUA3oNDt462HaS+
         HKRCjHfsk8ubcaStQJ1acgGLf6jOArnB+Xrf/0Mm3ypOcc553e3twwR7BaqYT4hnEUqF
         8A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764280650; x=1764885450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pI+nNCxm6OA7uNJyiyjjUs/+UrmghoHh3cuApsI018=;
        b=AjygbMiWQ4l7026E0bRcWeZRsWHnGZ5VaXyE3gwlGuezC+3gA2WcusXX7LMpO5UFPg
         rHKnmexj8taTDah4x87yR8uKR1ikGlQg2WQOMI2SVTPoGRVpjcl8g56E1/Jl7jLAVUfu
         CIIs+umWHa1rUBB9ItD38VWVC1UMHIMmA0C9TkpHoL2UFmNyJxwBgm4Fk0M3DlMNDZZp
         PosBeVMosyKrWSANkjpkoac2rZ6kBQ83ycjgGtLQvrHkJVTQ+aLN8VfSxfEv0Vp7oRd0
         hiB4A4URX/aYxiyCMd/Hs5snTW1QG8uhmO5A4Ax3iIW12hjvW6DlmJKocqaNi2fWAot0
         e47w==
X-Forwarded-Encrypted: i=1; AJvYcCXir1GUJDnQgXZN+jcnzcSP8/fVn6dAj9zKvi1NVjmlbSWopUqVpX7ALFcZRoA8luz4+7IMb7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJ/7gv+lTAInIM1anw0O3FOpF4zLIBfrmbPwbc9SvubCvqMJR
	Gf6gTKugkUqQQiPMey9NT5ShRy7r7rB4yCTaH+aHpG44Q56BOs0yHx4PYLZr5cgtMDFlk9ApEFV
	xz7E46sxG1F8g8XDRAGU1DDIOpy6IHBN+ndVBG6VVakPN3nEpgkyySOWy1zs=
X-Gm-Gg: ASbGncvaqkeI/wPeGlUb95MHtX2Dd1Ms0HWBXOq514IEMV8SQ5J0YMu6G41XuTXb254
	+z9X6mGVv0e4smKMWW9gorW2xX6OF3acPYqM769RfNPbzoHDllLjA27+u3S41nbO3DOnutneYH5
	Dsdp05nUGCWSzY3d/+baGH37gwVThuzBnG4mTNA5fvlZ+sr1npl+Q7CWBmv2Xn+WHWPuWJmPpyt
	Zr5cFvgD9azXk6NpZZZB09i/nzmzQxL4bdG26yOPPaNANcRSQ1ZZPT0mkMEjbbd/Ce4V92g6Ir1
	b3sCsYDtc6IuDRtw2yqca9LoKF+GFTbla1zTrdDpMuPFh16H2RdP7VhH9JFW9zBKPBbub/9pFgL
	0Icx8ZBttX46r+pvWzjWBPOCX8juyb1ZbPqEjc65ZkK0yHY1gZIERShtUT9Ilm9+DqXg/ABM=
X-Received: by 2002:a05:6a00:2f08:b0:7bf:5011:d1e0 with SMTP id d2e1a72fcca58-7c58c4a7988mr19309554b3a.2.1764280649755;
        Thu, 27 Nov 2025 13:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Ps9FT/iS+6D58IplXxo7cJi3GSOPO+Imc8jcDmYahmP/facOrbWXg8BxLWofhF4dMg0T/A==
X-Received: by 2002:a05:6a00:2f08:b0:7bf:5011:d1e0 with SMTP id d2e1a72fcca58-7c58c4a7988mr19309527b3a.2.1764280649145;
        Thu, 27 Nov 2025 13:57:29 -0800 (PST)
Received: from ?IPV6:2401:4900:1c27:6704:8849:8c0d:18ec:2263? ([2401:4900:1c27:6704:8849:8c0d:18ec:2263])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c5e611sm2853839b3a.6.2025.11.27.13.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 13:57:28 -0800 (PST)
Message-ID: <bf66095e-9f25-4e0f-876a-00f637a7c696@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 03:27:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix a7xx per pipe register programming
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2_Cipi4QeTkqVshdMbjbCRlhW4_Pm4Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDE2NSBTYWx0ZWRfX1Uk+cvUH6yyq
 49W6MSLrqf4nHx6IQl+2sMhg34071pOuulfmEp//85f0bl+aUVpfjy91TADHgwPrC/jm+V5foUu
 ILT5fLG0HbetQMXf7fdWe/ego+pS2fMJQFEq3697zz2zwOLTUwBVKSjL4NvwX/f3zsscxHOt+ZH
 u6mTwi5Y/hTIBQpy4XGkkGXTUoUIJZqIenvgOTWf+vGTE9kcur/NjgrnDR2WA6d4OaUaLJM7mYR
 HVWPE5K8wVdqBOCl0ZRCwcGglUmToHV0546q4ylyvzpnbPpw8W9YWNIMk1UNXjcxCoVHW6lHNJX
 Z5T9RPDI93jMBN/jNrI878z3o7qOukMPI82GV2JpgaS1kkrDHErYS7qK9N9C6FGlXBDjMM0qVIk
 gS2QnLyuPqFneg0sSRAG2+VYEnUmQA==
X-Proofpoint-ORIG-GUID: 2_Cipi4QeTkqVshdMbjbCRlhW4_Pm4Sf
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=6928c94a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=euEQxmOE86r8TiHOpTIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270165

On 11/27/2025 5:16 AM, Anna Maniscalco wrote:
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
> +};
> +
> +DECLARE_ADRENO_REGLIST_PIPE_LIST(a750_reglist_pipe);
> +
>  static const struct adreno_info a7xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
> @@ -1548,6 +1553,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.protect = &a730_protect,
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.ifpc_reglist = &a750_ifpc_reglist,
> +			.pipe_reglist = &a750_reglist_pipe,
>  			.gbif_cx = a640_gbif,
>  			.gmu_chipid = 0x7050001,
>  			.gmu_cgc_mode = 0x00020202,
> @@ -1590,6 +1596,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.protect = &a730_protect,
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.ifpc_reglist = &a750_ifpc_reglist,
> +			.pipe_reglist = &a750_reglist_pipe,
>  			.gbif_cx = a640_gbif,
>  			.gmu_chipid = 0x7090100,
>  			.gmu_cgc_mode = 0x00020202,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 0200a7e71cdf..b98f3e93d0a8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -16,6 +16,72 @@
>  
>  #define GPU_PAS_ID 13
>  
> +static void a7xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	u32 val;
> +
> +	val = A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe);
> +
> +	if (a6xx_gpu->cached_aperture == val)
> +		return;
> +
> +	gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST, val);
> +
> +	a6xx_gpu->cached_aperture = val;
> +}
> +
> +static void a7xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
> +
> +	a7xx_aperture_slice_set(gpu, pipe);
> +}
> +
> +static void a7xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
> +}
> +
> +static void a7xx_aperture_clear(struct msm_gpu *gpu)
> +{
> +	unsigned long flags;
> +
> +	a7xx_aperture_acquire(gpu, PIPE_NONE, &flags);
> +	a7xx_aperture_release(gpu, flags);
> +}
> +
> +static void a7xx_write_pipe(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 offset, u32 data)
> +{
> +	unsigned long flags;
> +
> +	a7xx_aperture_acquire(gpu, pipe, &flags);
> +	gpu_write(gpu, offset, data);
> +	a7xx_aperture_release(gpu, flags);
> +}
> +
> +static u32 a7xx_read_pipe(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 offset)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
> +	a7xx_aperture_slice_set(gpu, pipe);
> +	val = gpu_read(gpu, offset);
> +	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
> +
> +	return val;
> +}
> +

All of the above helper routines are unncessary because we access only a
single register under the aperture in a7x hw_init(). Lets drop these and
program the aperture register directly below.


>  static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
>  {
>  	u64 count_hi, count_lo, temp;
> @@ -849,9 +915,12 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  		  min_acc_len_64b << 3 |
>  		  hbb_lo << 1 | ubwc_mode);
>  
> -	if (adreno_is_a7xx(adreno_gpu))
> -		gpu_write(gpu, REG_A7XX_GRAS_NC_MODE_CNTL,
> -			  FIELD_PREP(GENMASK(8, 5), hbb_lo));
> +	if (adreno_is_a7xx(adreno_gpu)) {
> +		for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_BV; pipe_id++)
> +			a7xx_write_pipe(gpu, pipe_id, REG_A7XX_GRAS_NC_MODE_CNTL,
> +					FIELD_PREP(GENMASK(8, 5), hbb_lo));
> +		a7xx_aperture_clear(gpu);
> +	}
>  
>  	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL,
>  		  min_acc_len_64b << 23 | hbb_lo << 21);
> @@ -865,9 +934,11 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	const struct adreno_reglist_list *reglist;
> +	const struct adreno_reglist_pipe_list *pipe_reglist;
>  	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
>  	struct cpu_gpu_lock *lock = ptr;
>  	u32 *dest = (u32 *)&lock->regs[0];
> +	u32 pipe_reglist_count = 0;
>  	int i;
>  
>  	lock->gpu_req = lock->cpu_req = lock->turn = 0;
> @@ -907,7 +978,19 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>  	 * (<aperture, shifted 12 bits> <address> <data>), and the length is
>  	 * stored as number for triplets in dynamic_list_len.
>  	 */
> -	lock->dynamic_list_len = 0;
> +	pipe_reglist = adreno_gpu->info->a6xx->pipe_reglist;
> +	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_BV; pipe_id++) {
> +		for (i = 0; i < pipe_reglist->count; i++) {
> +			if (pipe_reglist->regs[i].pipe & BIT(pipe_id) == 0)
> +				continue;
> +			*dest++ = A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id);
> +			*dest++ = pipe_reglist->regs[i].offset;
> +			*dest++ = a7xx_read_pipe(gpu, pipe_id,
> +						 pipe_reglist->regs[i].offset);
> +			pipe_reglist_count++;
> +		}
> +	}
> +	lock->dynamic_list_len = pipe_reglist_count;
>  }
>  
>  static int a7xx_preempt_start(struct msm_gpu *gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 6820216ec5fc..0a1d6acbc638 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -46,6 +46,7 @@ struct a6xx_info {
>  	const struct adreno_protect *protect;
>  	const struct adreno_reglist_list *pwrup_reglist;
>  	const struct adreno_reglist_list *ifpc_reglist;
> +	const struct adreno_reglist_pipe_list *pipe_reglist;
>  	const struct adreno_reglist *gbif_cx;
>  	const struct adreno_reglist_pipe *nonctxt_reglist;
>  	u32 max_slices;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 0f8d3de97636..cd1846c1375e 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -182,12 +182,25 @@ struct adreno_reglist_list {
>  	u32 count;
>  };
>  
> +struct adreno_reglist_pipe_list {
> +	/** @reg: List of register **/
> +	const struct adreno_reglist_pipe *regs;
> +	/** @count: Number of registers in the list **/
> +	u32 count;
> +};
> +

Please move this chunk down, just above the DECLARE_ADRENO_REGLIST_PIPE_LIST

-Akhil

>  #define DECLARE_ADRENO_REGLIST_LIST(name)	\
>  static const struct adreno_reglist_list name = {		\
>  	.regs = name ## _regs,				\
>  	.count = ARRAY_SIZE(name ## _regs),		\
>  };
>  
> +#define DECLARE_ADRENO_REGLIST_PIPE_LIST(name)	\
> +static const struct adreno_reglist_pipe_list name = {		\
> +	.regs = name ## _regs,				\
> +	.count = ARRAY_SIZE(name ## _regs),		\
> +};
> +
>  struct adreno_gpu {
>  	struct msm_gpu base;
>  	const struct adreno_info *info;
> 
> ---
> base-commit: 7bc29d5fb6faff2f547323c9ee8d3a0790cd2530
> change-id: 20251126-gras_nc_mode_fix-7224ee506a39
> 
> Best regards,


