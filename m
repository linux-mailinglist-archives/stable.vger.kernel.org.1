Return-Path: <stable+bounces-203233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B24CD6FCE
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D12EB3000B1E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793B337BAB;
	Mon, 22 Dec 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQrwaqUR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kiPrOeAX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5E1EFFB4
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432197; cv=none; b=bPjySZZsCfKYOvy6bx4Adhm50kjJt/vHfegvvUCDim9YiQwPWVEb0YoBc5iyXTkBT4iKmU0IxSB3/fTSN3Scr6l8SbKr2fK9UN9KtVlSqJNdSW7cnpKVV+J0BiuQ9vjqVHu2VQDi01jtUhwEpiMxWJQUr94bVpJ2VNt9FHGRv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432197; c=relaxed/simple;
	bh=hFP8wNqan67bFKWAJvdODGqeW6LGRWIvu/1ZkhiDoGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoOQtNox8jVfDoidk/OGWwHQfYfySis0SUqgKAFOo1IrHA4NS5dM7i0lWS5+aUdIb+FuD3ALG7VIDbRY0zpPrO4Skza+KDwfcfhW8N6ygkjvWt6uUvCvFJihrzZGYsLMFN0Y56Mm3tDBMC6phEw1msvXjdgNga95pNAMwTDyYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQrwaqUR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kiPrOeAX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMEDKS91531701
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 19:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nn+s1homNWQHMLWddz1S2iuslw+Ts3/5yDOH/7TAz+o=; b=jQrwaqURDpMYcJ+g
	BSunj32sgTKzILCDPr2RUtA4nv6oA7xkzmsMN+BKPJNV6N07ytkTm8Kz3v2lPa2B
	+8ltcFOGUHtdEGMAeHKwQTs8qV1PiyuovZX6PsakWAYFBkLXMbFbtzlGPSQ38sAs
	Sfoj4UOQwWOYuNOKGCzxSNQkspht5lCyRUzgQ7F2t7gb70mPhd3KLTai+KEqRFyV
	mma7EZQEKqxao53EY7li/mjqxtjycMv/nNL4n1MlCuCg5PMNvBEvbfXa4g9YnK8M
	BH+8wzVbmTCuRMplFVyjal8/5Oe6WzbJSiZ+0QvxROLrL5VpJJ1BBzUpXW/HyGeV
	h0trww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y18kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 19:36:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9321b9312so8649374b3a.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766432195; x=1767036995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn+s1homNWQHMLWddz1S2iuslw+Ts3/5yDOH/7TAz+o=;
        b=kiPrOeAXjBxDjNDBypWt9uFG6KZ0kerbKqkZO01aFdpyyArLLFk8NtBuC/wV0xsFov
         yWqBdL1hSVrqMS6jfTxqxfZOdm8Ufyja1OWfqB38Bo5WzU1ee1MRMS/V4NBC46a3PUkh
         22LW6VvY6LvCX1niBrTPdbMHi7VNUh0BMEXmbAr1G3+78dOeKhdq6GHDWirRhKOBkghv
         M9T0aTgvF01NMpyygtkP/LUeLzJtEv+E21Axv43HfSIO3QKzq2PPfN/eyq+SSc2YS5+a
         TGM6HOdvuxFCS5MlElVa6uXBr/mJNjnH213riSXjns0pSCgX6YLhN78G/MBp/wz1Qk9J
         1zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432195; x=1767036995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nn+s1homNWQHMLWddz1S2iuslw+Ts3/5yDOH/7TAz+o=;
        b=G3yVJtSt48nnZnzdtlOnhDe/Z/fyj3LZ1glThj6I4b/Gg1M60KXDO1TpGtO4n3/grz
         P0AgK5aMO+NgqZsUMOBGr4YlzVXAs6fTJDs3zuxU13JGMU8X6JlvkOKDquY1aaMFgWXo
         HSASjwwjIiRz7eCFWF1AjX7pAfbU1s4vYYz+vu3x4tmPKsH7v5W/Rb+1ZIJhUzeS7M0B
         WIB4duhbg3K2EXUYBojzHH6WZdKL01ThXvL0N/jzw5rcM/PnDuo7nJWTzW7vSFLqAVhm
         203lSxSBTKhMJLo98ajrf1EKkvcCethsaec9rlgDH9Q2yYwm12DM3HlekiQMAIf08s52
         MCXA==
X-Forwarded-Encrypted: i=1; AJvYcCXV+BEWk2IavwkoFogS7CwpS1dyvT5SUa7EsM7A/s15bIoYNviuInEl1VAyyz246i88xVBKE+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Cz0sdUA85ztP99vRa0+OUf2IlZGcSe2xebhIva8+GiMcq3h0
	XiPPelW9jJBNYVZgeAOoIQZe16Vu1I41gZDEPK0XksadHH9bQVPcbswO46v+UBlIWbIQ5eH+9ii
	PdMFZXBElwYo660S25qEBW+17SUDwjQHNBN06kr5gRleVstXc2kp96YJ63I4=
X-Gm-Gg: AY/fxX7NQY748ClOI2GT1yhlnTasNVC3y1xIy8sFmpClGzxGdSOUIXU20Kvw1ptQ+Vd
	4HZeAL2GoOnstKb9ls6RX+Z0V/li0++AQlXLlSySp4N2gg66CRopo/oX9EYb8GW61Mij8V+YqwF
	drydJqcZLX7ZB0oeghFIJ/3O4uuv/9wZozB2HhDoE9o13a6csw5PNcivOZsWXgCNdnbVhOGBlEt
	93/gC7+sW1/RX1l1B3lqTNPdb7QaXSKE5emBPtxYE5bwEqZMRHf403FXFC8qt+95ze2Xx5L+wzW
	ibv4PecP8Pvbqmso3keUbyZ0ks13KAoi3G4tY7HLUnbnzc4RAiMqq8i3oq81KoEvzhkQzuCnVWo
	S4jFbSAhmljnQHn/wrqPShpQl7iSUJnxhTA==
X-Received: by 2002:a05:6a00:4105:b0:7b2:2d85:ae74 with SMTP id d2e1a72fcca58-7ff65d7e724mr10088514b3a.29.1766432194757;
        Mon, 22 Dec 2025 11:36:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYTrKbRHCEjE4Of6gK0jRIFuxMxi8T8wLXlsDgiw9a+p7RRCcbDeWEWpFFi4cgP/vYgY1lxw==
X-Received: by 2002:a05:6a00:4105:b0:7b2:2d85:ae74 with SMTP id d2e1a72fcca58-7ff65d7e724mr10088499b3a.29.1766432194320;
        Mon, 22 Dec 2025 11:36:34 -0800 (PST)
Received: from [192.168.1.5] ([106.222.228.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48e1d6sm8647579b3a.53.2025.12.22.11.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 11:36:34 -0800 (PST)
Message-ID: <0e592574-9e8f-4bb0-b875-3a437fd340fb@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 01:06:28 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates
To: Johan Hovold <johan@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251221164552.19990-1-johan@kernel.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251221164552.19990-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=69499dc3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=oy5nMm26i85I/VS19bmskg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dk0i7xQ4PQfej7aG6gsA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: RRaDwSLNraOrZZODrYsXXTD11JuN9Wip
X-Proofpoint-GUID: RRaDwSLNraOrZZODrYsXXTD11JuN9Wip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE3OSBTYWx0ZWRfX0yYt4uVuRw51
 U6B2OiRUbyEz3q+QVsNpy6TNbpiu2Ph5UI/7JIv8QcQjxAZQvWgkvDgYCUfUypH14sanjRTra4G
 EfCM8fJpjSsGAfoLuxYsy+H9Xb6n2ahbIbWyDa6bKJFNBdbWLAqSFcp8vWCbE70eDhREsCAo58c
 AIlRSmrUrb3U3kEWHuHUb47jD1Eks+DWUTN0PWd7W8fTLshcxo9Gh19dnLJZmQ2VoWwJ6N+qqeJ
 1F6+UtzCXBXXoR/cT7vEcw3o1QCqAFA5ykisS4UUeooOsDTEd0lrzghI6lh3VDJRviE4flJorX3
 DllfbsbZ4zyd1x5S7mEQplOm4vDuIvCJATWUAn1dnTCvgZKosDsVdz/VO/nQAWH+eJil9sCf2Ta
 fksO7HO0QD7EBf1qM1fD9TBt1icZbFBFgbQ0CL/5QBGiYWpGFy3pZDde7q23hyOhsDl+LDRbRig
 q8o08nwihXgt+c9tFNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220179

On 12/21/2025 10:15 PM, Johan Hovold wrote:
> The hw clock gating register sequence consists of register value pairs
> that are written to the GPU during initialisation.
> 
> The a690 hwcg sequence has two GMU registers in it that used to amount
> to random writes in the GPU mapping, but since commit 188db3d7fe66
> ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
> the updated offsets now lie outside the mapping. This in turn breaks
> boot of machines like the Lenovo ThinkPad X13s.
> 
> Note that the updates of these GMU registers is already taken care of
> properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
> properties on a6xx too"), but for some reason these two entries were
> left in the table.
> 
> Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

I fixed a similar out of bound access issue in the coredump path last
month. This pattern indicates that we should consider combining the IO
accessors of both gpu and gmu.

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 29107b362346..4c2f739ee9b7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -501,8 +501,6 @@ static const struct adreno_reglist a690_hwcg[] = {
>  	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
>  	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
>  	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
> -	{REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL, 0x10111},
> -	{REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL, 0x5555},
>  	{}
>  };
>  


