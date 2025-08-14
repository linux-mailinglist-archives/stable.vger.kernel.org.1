Return-Path: <stable+bounces-169520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1DB260A8
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588C33B7770
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7122EA466;
	Thu, 14 Aug 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fF53YECK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE12E973E
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162915; cv=none; b=aYHAfXf4I2h5RqUneO+1nRvteGpGHgo2WG//9xJVqSXyNg7hFQ3DWdGekz4Qlp+ruJPFPdRdqDOj4l3Y+TEIeDXZCJZjAAgSSV2i/BmD5EnXI3kUoRER53CqBeYF4KTmBTCCc+atlT5lRbLxH48RsktwRh0ZKF/9vze3btpGdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162915; c=relaxed/simple;
	bh=XhEhDZQsgMiczoesYFyeTv5mQBvZtLNYROcgClmCwOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/xf6L46FR4DxH0r6FM4giECO1qLXzd9/lB0dSbGCiub9p+LG55vkEiQG0O3dDGWyidoWzmAMXsq/Fv43Gx1V4OfUD37G5ghITMu+T0zDNRSh1akNe9rE3mFpioseK1ymfiYyYCBiqCFVtYxps8vUgU7Ea7t+6MVIkMm6EH6t2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fF53YECK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9CeOY013008
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JXECCtiDhY+FWYo/Y2DbBqY/PXD9a7G7J6neCt3E7iU=; b=fF53YECKPEpR0cg2
	VwKZMznx3OdK06LL4V00GTK7XF7m7O9Oc+xjaniO3m8nGem5KeT7rJyPcRHQ5yZd
	e2KkheFATa41mjVAAbqJwSE+mk9dsoF0ubvLylZtys7cMvbR8m3eFbpqxb+LBEKr
	TFSweUjxiGj0S0kUpdm1EaaF/ywK3kKKtoywAHsHarK2Kika3Ihu7nv8l7ioJc5p
	JQRaFO8W2wELAON6cAoGg5GMx9z2QudnF9AeQAxC8T51R4s4Qih//aFoNUcKcWRT
	fsIoLTuwMHS3Y9EGkObTcQD7t6giIx8Mu1corNqIUPi5/lMJYAaF3WaoUjzGZxAv
	lZM5mg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6txvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:15:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870623c48so21040585a.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 02:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162912; x=1755767712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXECCtiDhY+FWYo/Y2DbBqY/PXD9a7G7J6neCt3E7iU=;
        b=T8MeHig6u2szLC/+e7YBh39byu1KQfrdHhDPYNOMur38WtSknywLpqrXMmpJ3wnKxV
         nAwbgC3VbH90qsFBxkeeev7MB0fPZE2mORZwgDiQ/3Nf7nHky8aFMsYI283r0OMotIw0
         9bXe599yRyL7mfOe5vN/8Z7E9o7ltvGtXKbs96DhMdTiZTZT+XAoJIY9FfGHf8X1ZK0u
         17VudhusG2XwiHWwUlBn+lZeoR1fkWi7UtPVmrRuJbMifZl8y1/EpXdF8ENbH3L1V3sb
         zQ2r6vwsa3W5z6+MwKbV5T5R76Eq2SJGLep6wGxJQ7uBjYBOAJuN30SBVzjOjxJJxwHL
         m41Q==
X-Gm-Message-State: AOJu0Yx7AzAYcoKtthJf6IJ1uovV0PDKW3YjT7paMKubcSlosAiCPUx5
	9ybhRW4rPySu4rTazw0kwzyY5hkHf3m4NMrGiFS+gI6Q7fDdIRmNT6XKMJW8GwFrYiTTXK/ScDJ
	f95hEHP98s+XSIPDCh/4dC9qaV0Dvf/Ip+hAXXkdGe2fZBr32RPW92B7in78=
X-Gm-Gg: ASbGncvXzQODsAsLEn7Qd171rtJN5r6mIsFfpcU5BR/FaE7E28nrVgVz8XMke1kamJ6
	vqh0B+oi7m2Y8ZBP91UO0tua9bmWzy5eNtxoPX2/rjntLe6Po6fXIRW15zRGOuVDSA/iC1sB0Tk
	h/5Ir5l8i5QODrr7nRRug8HlNTAxLL8NDja+LQd5J1ByIXqjaPa0HB1dq9cVysNe6y/IHkIk0BA
	RmLZC/2wWxZL0CzsEzLkfx3MoZJ2bRGIEu2Jw1APv/69b7MWDp9Jgn+sDaW4T8mn2OdLFXciFx4
	q0FUTr0l0Q40qxUTmGyeAma5D+dmObG0vPgfhzi0v6RoLqOBwQjsu+Xqj0/IeMaVOcL1ktpSJW/
	SHBz5SQOzrIMbi3ZdOQ==
X-Received: by 2002:a05:620a:2801:b0:7e8:1594:c1d2 with SMTP id af79cd13be357-7e870445097mr153925485a.10.1755162911952;
        Thu, 14 Aug 2025 02:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG700skgv8n/LYxojP/q5UsrZ8ZDa7F90OYLMOTMtJbcl0KhlRKJm0m+VOoW1I+d9LOuGyLbA==
X-Received: by 2002:a05:620a:2801:b0:7e8:1594:c1d2 with SMTP id af79cd13be357-7e870445097mr153923785a.10.1755162911409;
        Thu, 14 Aug 2025 02:15:11 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0757b7sm2547884966b.19.2025.08.14.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:15:10 -0700 (PDT)
Message-ID: <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:15:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*()
 errors
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX5aIx+S+KI7QX
 EpQnTU6xAIq3j30i8/+tD+04Kh6fjghPYUIo1X27L06SxgqntVXqF1d0SXWoVtx3kYjs/aRt5kl
 /OPXWX2gDDp/tCM8LjuIp/wOBS/39xVHePh6c4EHhhBdjhyPO0gsq1yAPw51VxiZsen81CZ0ATB
 7/jLJjYXxXVAqgsEdnr8Kzg7QWxebwYWCMkf7Of1yA2WD1txWUGLnU98gQBBC2DPo3COUBvCRMk
 3N6wUt0teJGImPubtZ7tMMAgDnWwxfo7w71JWw4pAGSt2et8rPNmgdqYFoJoZuAdnloi4g4F1Bs
 oMhtcMcEF87wpi0X2ATOF2PxNFXiR141Dn8VWhb/QVTDuPFWeu92a700wvYyYhLUn+QZ2QzwZqP
 j7f2KHYD
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689da921 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=oxqizksRuSS1_KsISTYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6CHQzqO-n6Ldz_W9uN8d85fVrTgb5-IT
X-Proofpoint-ORIG-GUID: 6CHQzqO-n6Ldz_W9uN8d85fVrTgb5-IT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
> The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
> or ENODEV, and if that one fails with ERANGE, then it tries again with
> floor dev_pm_opp_find_bw_floor().
> 
> Code misses error checks for two cases:
> 1. First dev_pm_opp_find_bw_ceil() failed with error different than
>    ERANGE,
> 2. Any error from second dev_pm_opp_find_bw_floor().
> 
> In an unlikely case these error happened, the code would further
> dereference the ERR pointer.  Close that possibility and make the code
> more obvious that all errors are correctly handled.
> 
> Reported by Smatch:
>   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
> 
> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> Cc: <stable@vger.kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Some unreleased smatch, though, because I cannot reproduce the warning,
> but I imagine Dan keeps the tastiests reports for later. :)
> ---
>  drivers/soc/qcom/icc-bwmon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 3dfa448bf8cf..597f9025e422 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
>  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
>  
> +	if (IS_ERR(target_opp))
> +		return IRQ_HANDLED;

So the thunk above checks for a ceil freq relative to bw_kbps and then
if it doesn't exist, for a floor one

Meaning essentially if we fall into this branch, there's no OPPs in the
table, which would have been caught in probe

Konrad

