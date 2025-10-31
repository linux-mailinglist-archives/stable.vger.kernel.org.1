Return-Path: <stable+bounces-191808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EAC24DC2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8A562584
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15C347FCA;
	Fri, 31 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p8G702Ah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2kfGk89"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAF346FDC
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911406; cv=none; b=mqlj69AlV15FBm1isvPFnXDrwo25jXZjpoBWcuWf1SbwFIWcsF2E9Ds7IdOwU6cpJ9PudJBsxL06SWZtqcuwyTIzqULOeBUy4dPoqqqTHxHHudnDY5R+x2azvHH4bQ6VqtkHI9lDCZqYGSx/0wTnBmqqF62thxthgkyyNaY2KEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911406; c=relaxed/simple;
	bh=eoVbHo7aC1vVS9/BhWqWBi4mcYDKQTV0DCH1R1NJ3jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZidUrzQv5/pH1fSjFW6q3yU/vEn4nSEQyuqwSwWIKuXIPbGAmlg4VPBHAlu6Gy07sQj7nTvbBcCyUWCxp2KXS/pzTXEa0Lq1kr8/r3XTVYBNt5tzlVDxyJYv/ju6US2D9woHlOicE294DSWsdEJN9d9Wrml4HzRIgIFC1MDc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p8G702Ah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2kfGk89; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V4Ln421827335
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=; b=p8G702Ahp/V4Bhu3
	jwFIha0OnUWN1QfNncuJ+KkaGHvLHpZxP9bZ5A+OjRtOTinXZJQFg3qp59evVq6Z
	yuHk1IV5mo3WMwfTR26n4YH/l06MjGYCwm5t+jPeKtcaUITGqHlcdEaHuT2puy1w
	Y8T16N6yzpwl82kqsFCnC4fNnKA5YLgOTn6h7qparFGEzXpOC85ZrltzlYeVeUmg
	J4B4oaq8SR3NpADgp2Wa+FN9WYfHiW82E+48xvI7saAMh4Dv25FlqfV/+3uuyoTf
	mFd7vzFEXsnSUsxxMWj4FuhTfh/DTHfCae+KvBoHGthiZ4SEeearGBqiqVB1yUFY
	DxdESw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11s53c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:50:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89f7a8b9775so551476285a.1
        for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911402; x=1762516202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=;
        b=K2kfGk89uM4+5ot93ZlaPj2T5eA4vRXKimViNuhyhHLa/aVZA9PK/K6kzOIgmWld+s
         tT3e80WEY/7SM7Wa7piho5Q/pIerb1wCFax/leW1JWhhhFL2KnkaDYQFsU7rsaBQKudZ
         zH4GXgO07+FavLTc+R6XWWYPRvUrT1sqxZQ+OF1uxSgku9I2RdJTkkoxVxPTPZbGg7XH
         5w3pduQJgaELqNleFMAwmDjxkpYceASWiFGBo9pk2S4eA6WEt+XvqFCXTbWm8yiwl/2f
         hlst2g3p6t1r4GKs1lgr4xpobVT385H0xt3ymop5fsv+MlLvoKT+KsZA6jQ31t1F4726
         rL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911402; x=1762516202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLRZg0S+AE6oEph0CbBMONDhQ2wpbW+QzzCe2qY2NRc=;
        b=aUsO/a0bWvrXMXJjbgcxkd1KQkglC7510OK0aSRqDOEpm3LsEiO6kHHFKfkFsnFoOq
         uGHjJip6EmM2nJPz5w63DtWsLTvfZTloW5I8Sf3gH9TEr3QPPuX+vj/oRmWIhGIp3zoi
         Zml/8pk+fuRpZuzN90MJ6Y/bJHI6JcsWPZF3PPvnaNwSCWG+RAErKg13SfxngWnGWUj2
         fdcp3+DImH700lbn8iI5Yw1EDI5Z6q+5c2ZOdvLZuZu1KOiLHUVFWXf84eh2qEAfnYr6
         rCzUTV1Dh9V6HR1qMaj7Dmis/p8cpdlMmZePAMwWiOgy68zYe9BjZQmkqMbDAe+SDhc/
         +mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDg4tnGtpW6zI6U6rgVgnipUmOl2lZPJTLerLPYjfpPx7Sw03st7rM0KMgDvmXyInXjuOZh04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvxF3O5KKVAwq6MbKKEP3wA3+xS+YaYrNa04My6UThQgiWDOv
	/jwStYZAFMetZKYj6yNv967Pj/Q1DmcpiFT1l9OxOU8qwi52A4Hp7KfSxsUt895JfPdtRbwmDca
	rCX674RcDMzOQZLsKFOpATXP8CjYnguNbiY8uHCf4EWw/zEz8Fq3bkJRtfrs=
X-Gm-Gg: ASbGncsNE79iqqhAbUICA5JLqjKEwwVrUKWYP6cH8nhi/ZrAKgrOSPHbvaVZqMp6PWz
	oQjgWLSQmYJmfvT/0qCvlNkje9/9AOlYcaqX8O4e8vPgi7Rte3bb7GJ5Y3Pk4j/Z5D7XYl7mqni
	e5xQ74bTUo6fXy1r+H07pD52AxAB+zWH8BGQZ6GC7TbqYZI5L8JMgAj6syoILtC3OZbSBeZfQzK
	qmGpwbnrDPOvCKBu7xtTZWunG3rFgwWuxMf3R4mSAw5t2dE87SJ9aWDHzw474ik9tFgM90qiNVg
	wzE051Io0juxrv/dPzxoeeEk+iXREnRJ8bSpzPYXZK4QamUsej5N3wD5kZcUhmp6FgmkcwOgPn1
	O/EwoBhPzXZc0LJSbjH+txRMDXg==
X-Received: by 2002:a05:622a:20a:b0:4e8:b446:c01c with SMTP id d75a77b69052e-4ed31009474mr37044901cf.58.1761911402027;
        Fri, 31 Oct 2025 04:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEWPfCzEgB1x7tlVV25/AaqTH5SPGouZCDNOaKdIMjMHxQEiVR/bwWZMHsFaO3q/nxJufbjg==
X-Received: by 2002:a05:622a:20a:b0:4e8:b446:c01c with SMTP id d75a77b69052e-4ed31009474mr37044551cf.58.1761911401600;
        Fri, 31 Oct 2025 04:50:01 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429c13ebfe8sm3170057f8f.35.2025.10.31.04.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:50:01 -0700 (PDT)
Message-ID: <c3120458-e493-43a8-b5e5-0de62377ca29@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 11:49:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ASoC: codecs: lpass-tx-macro: fix SM6115 support
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org, Stable@vger.kernel.org
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: z94dM4px_i0CdYR-TdVfSlBD6-gMo9iN
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=6904a26a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bqFBmpm2teb5LxhVygoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: z94dM4px_i0CdYR-TdVfSlBD6-gMo9iN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfXwJVrRxUoq6oV
 EZJx8pNN8ut39n0G8I/AFRmluCFyK0/5DRtJ3rh38EgbmQAb0E+FCezeZVR6LiqOuttZNVAQatt
 DumEYsIP7Fu3MkPUN8tSfQyup/ajxhLhIVbvqHZ46wjnq5+9Qp85j2DVrTCEvY/NxUOHG+tVXTi
 3pYZV4OK25a3tAjwGXCdMGijcfgrQOLKldrVjpztTHbqfopJpzTf1SDmP4NHdZViX6yncTMCUe9
 QnTDfEpJ0cLt0/vEC8+L+44yURn2xnw8ZE+i8LzV7M8GjKB2O/R6ONVM4s9WBHiANIRnTdEJJeH
 dKHoBZJViGE5wJYLBcQjj9cQygzia5K06B4X9e820rReglLbsIoh+576h2gckYJNzhZFsyEVBfS
 Nbv431SRyik1tj9QtH7N38C8wHCr/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

On 10/31/25 11:47 AM, Srinivas Kandagatla wrote:
> SM6115 does have soundwire controller in tx. For some reason
> we ended up with this incorrect patch.
> 
> Fix this by adding the flag to reflect this in SoC data.
> 
> Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/lpass-tx-macro.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 1aefd3bde818..ac87c8874588 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2474,6 +2474,7 @@ static const struct tx_macro_data lpass_ver_9_2 = {
>  
>  static const struct tx_macro_data lpass_ver_10_sm6115 = {
>  	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> +				  LPASS_MACRO_FLAG_RESET_SWR,
Looks like send a incorrect patch here..
will send a v3

--srini>  	.ver			= LPASS_VER_10_0_0,
>  	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
>  	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),


