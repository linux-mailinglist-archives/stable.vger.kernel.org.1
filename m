Return-Path: <stable+bounces-191709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CBC1F2F0
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2240A189676C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118733FE1A;
	Thu, 30 Oct 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnN+qUfS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRgSGyKZ"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CA334C2B
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815216; cv=none; b=LjnP34++FfQkFjJMJccMJsEcDJZYMrYrCYFworKgaWZiyWgSHqrKWqu/aQipief1iswiouHtkBPfhF0f2GlKarlNoKonFqwbKJP/A00gM1yFLVb2+kwCH9FK+ZL2RTEflzmC62Q+AITd9zKqxq1Kzee4Y1v1TwSOLpvSQIpLh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815216; c=relaxed/simple;
	bh=X7ILzCECf3H8UUnRWySC0tpXkeSAn5oZR3ZqEfON2eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiWtaFncXIgZkmRiqMb1ztRuG9v3a9Kjz1ZB+AFC4f6hPSVcUdSKldqA8cLeSYddbDzgzMgFt9BrVD0FT2IoKJuZjl4IhWYWG+Dyl+l8sMatcTtM1W9p1k2ANf34skWW9SHnpOl2ddzUP1tkNIogj22+AG9voBNO4WG8tcuXF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnN+qUfS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRgSGyKZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7sOED1655941
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=; b=WnN+qUfSPIP6UeXT
	XHylrDpOJWAK8vNluPmyt7e0oEK3LktbOMK9udQuwKuPwyrHW2SYRiv+jl90Lt98
	Da2bAH/mr+yeVdJMQeUvXDoHBTCmHxrHGX8fdtpVQlKrjnTWewsOqu5u30tivxxs
	vVKdv9/tQx9eU8sd5OYkxL71Qcci2nvSTKoxSDa7OfulVxNxuLvWXukvlhiS1W4I
	arueGt5BgazcxUgxj30gcycYuFgMdMicW33TTLn89ziW4edtKYJry3qKQLQEsB4S
	rmPQySyMF4GVWBvNlYw5/3wfhIiNoVy9YGcqEjKwM71M7/FJgz8ZiI5CXg2ib2LJ
	DULE9w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptsqc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:06:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8801e695903so1157436d6.1
        for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761815213; x=1762420013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=;
        b=IRgSGyKZDvHIkMoKrp2ODheCoVq82VI+zC3afcmsfRdv7g8xuEnehnhH8q6A+BXseF
         cbgt/AKXUGrXjHoI58vcLP7KGnJt3fD1z5cii2eQer7iHgUKis3gpa3XCwwYTtZW5nys
         FJWen0z5Khkp6AxSqAjNSP9f1IGaQy4jsRmmN3EuLLukPRUdkbbX5xNiCsBBxITDhswt
         75V+JoUiwtxFY39xvmY/3QqtQbm+8G0FwgKcvHLWzkloD+2t8q31AclKeWwd11zmQ0xu
         QBadhKLdu2JWv1q4bvfgeBmqGfoKwkQDdzUpDy0QYcndWFeI1+vBx6B4DBFgXn0EcWq9
         5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815213; x=1762420013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIb99wMfqBRmzqLt4TerM4AEHn1832mxc0+HjrXIUdQ=;
        b=MzeuCl3/9w5MSVF4IE8vVuyL4AUq7bNnN8FKY7dE7mk8q0MgJQvyfYTxVIiYqKAnYy
         nOoaGIsyCyaPInj1tF12DdadaYJUX9jr6/jI6R+OrxM5ExKq5lZb64KRtmJ5NQxtP93j
         Kzy8S+7M2oADvE3r7E6JfRr3AwklGemOrOpqz33n8X7scplO7Arg1V6BCzw69b3F7Tcy
         u+IVYQLy+PUs43rM6yR460NPblvjsfbYT5YRQ51i7v+XBCB7Iy2Joi8aZTIfJBLVgGKb
         PZ35CinspErRZFhiwgf1u6HXpBlr7CsG45ymkEv1EQ4DZcn6aZ5tR4b26OoE/ZqKOBpH
         cAAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUQHjSMLAMIhigC8wU99/emNWt3OwF5jpG+ZEjx4CVkVEGoYWb8wwwzkFtLZz4zitC1zSfhkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjZ3obRy4o1SCZ57nHqLKlCqqOhewHWf70CLJ5ALQxmRIxYrk
	Q7J+M3RXmGjShrJ7g0z4gZsprQxgBZtyUqIuT83X4hokhEBm4SchZCj9ADM/F7BrG8z1+vwkUAh
	MESzpHFLFSu+O8Apn6wdrbAzE8eER8le9UH5N+enXO1iX5l1j1LtXAcZK8Lw=
X-Gm-Gg: ASbGncsccqeqBPzgmMbNY0Vdq2DUvemCookQxtP3pcS/bulkO4TFB4dwt1a3cXy1ZLy
	ybqgwxLpYEfeN80tdfX29727yG2TROd6kMU0m2ICkNunjWUm2bH1O3earIuCGcla3sEmpf+3Rqt
	Op5x//c0jBfe7mpI+H+Sf+jP52V4nll7FGPXerw8GHChBcpQW6q2zriI1r9WE8dbPF4nLjVmE19
	hj+WR451+bRmZ9PTSPB3CmghlUWnxATiBlU3qa7XW/sUsHOlQ+rDHEbxETo7ZWIF+xU9RLVJwMW
	oDHBVGJg1UXadAVS6YeMsGYjlHcp11AJBiufIiqCVVUJrrAiAYWLy2NMbN5AAtJbVxIxgW50c4t
	4cRVmmW502VtKe7v8ryE8hfWDvmfw77Uyfpnnt6nkn2G7gXtbmYet++gM
X-Received: by 2002:a05:6214:23c5:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-88009c19ccbmr49168666d6.7.1761815213111;
        Thu, 30 Oct 2025 02:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgvsyWzB5+BObIPZCH/c4u0+NukSV+lTB2L5w6KrqKL76+JE7wKJWY/APuk/ewwXv5qVpOQQ==
X-Received: by 2002:a05:6214:23c5:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-88009c19ccbmr49168366d6.7.1761815212685;
        Thu, 30 Oct 2025 02:06:52 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1669495266b.55.2025.10.30.02.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:06:52 -0700 (PDT)
Message-ID: <312b62d9-c95e-4364-b7e8-55ebb82fd104@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:06:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: codecs: lpass-tx-macro: fix SM6115 support
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Stable@vger.kernel.org
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3NCBTYWx0ZWRfX1OfCrK2IGaWz
 rW6kIOwip6ujzfzUvIGPuf9McInL/jygBLfVL4QaDtY/yTSYjQ1YkktH+3+GSUyrXKjIqL+lKon
 QCOhNCQ/zPjR1BxsxUxTCp95Ofsg6Q+4lHEPFph72lpF1eybxIZjgJe11Z2KORoFElzyl/3wtj5
 /1gFD3onqw/mdgxKnc7CZLXaMvusB+4vUBo3yUfiMnhYBhHdH9AvcqS3tnMTg+fH599SpvnmPAP
 k1bT5WRPggKsgjlMCS2+dTNocA1edykmFg9YuRS4UL9ojOPQM4Ur32VK/rhujL2l9DdYbfYN3S9
 zWEI9Ve+aUBKRSgeq3eweiax+qKxnmCZjJmcQWobUjUz5D3sXZC7F7b4ib2HPqNr9xrJP7XVhMe
 wEWB7aDJEc01rZBNRy6im4rnE1ZSIw==
X-Proofpoint-GUID: BxUtFqEP5_1tz7wE8EIWfv31rnz2gqC9
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=69032aae cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jFCpiT4AGmqPEWX61NoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: BxUtFqEP5_1tz7wE8EIWfv31rnz2gqC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300074

On 10/29/25 5:00 PM, Srinivas Kandagatla wrote:
> SM6115 is compatible with SM8450 and SM6115 does have soundwire
> controller in tx. For some reason we ended up with this incorrect patch.
> 
> Fix this by removing it from the codec compatible list and let dt use
> sm8450 as compatible codec for sm6115 SoC.
> 
> Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/lpass-tx-macro.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 1aefd3bde818..1f8fe87b310a 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2472,15 +2472,6 @@ static const struct tx_macro_data lpass_ver_9_2 = {
>  	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
>  };
>  
> -static const struct tx_macro_data lpass_ver_10_sm6115 = {
> -	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,

8450 has | LPASS_MACRO_FLAG_RESET_SWR here
> -	.ver			= LPASS_VER_10_0_0,

and the version differs (the driver behavior doesn't)

Konrad

