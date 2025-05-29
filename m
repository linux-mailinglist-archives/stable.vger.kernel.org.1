Return-Path: <stable+bounces-148049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4887AC7667
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 05:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D29C3BC1E4
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4F24676A;
	Thu, 29 May 2025 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izhl589d"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E84245006
	for <stable@vger.kernel.org>; Thu, 29 May 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488303; cv=none; b=b/k9TG+OzUjHSAXLYkteDcGOx4fvjluOdj9GlJsBJ0Ea9nsPL9Um2KwzerDHJ1ME5RI0Mba9R+yGIZPXmApV0And0xLVoiDtN+a4bIWx4JVVAL8g6yxG5s53jblGblhB9W37YjU0fu8C2u8KUzyAYbvpiCKh7NvSpxnJiUB28iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488303; c=relaxed/simple;
	bh=aaJ6iaqpBEkCCmxAISiX4uGVBDBfRGWsFdy29xehZXA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cwg/Mb8A2B5kLcJjDHhToc0Gj4hoqlthy512mi6G1VjQY32YmRq4diVjDbQcIX846m9hxKcOaT7nr4iZdjykSt3apF0CBoMqUFHIZR23ScOi3nv/FC/tgBmDKCySG3KuT1EFYAY5zre/oQawoUkyrOujZUyECmx4OQT99sBvtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izhl589d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SHDH94000710
	for <stable@vger.kernel.org>; Thu, 29 May 2025 03:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2vePQPOnLVdfdrggklf8PTNS1Rsknj1/JpGHx3svC8=; b=izhl589dsj2FHk+1
	RndQ2CwUNyWJqEVf0pgg+eCah8WfBYZCDkBgGTTIjRTYI/DAMJQSWiiSKTbHvgkM
	fUf/kn/ZoKgVdTcTxSgq+zCPMYrHoK7Yg5pFT1zOPlWEQr2e4JeeyxE+lgZVzmwt
	JyWBEVkhRtFr4cOxsICA7xlD6QNIscLT3qBOQuf1KqAVbtUQX4YuMbh2Ea5cWgcB
	7ptXNv+zuzp2qdcw8iIinwVOlNCn0KKzsZAYLJR34QB7NPq1rvTEVEx3oIiXkL+W
	NYs+ccXtg/WTNr7t9VCvrFRX9oYNNjOcq3WxjsBU1+MPRXoJ9+iIXu1DCPjDl6eC
	+rt6Pg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g9494t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 May 2025 03:11:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31215090074so681890a91.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 20:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748488298; x=1749093098;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2vePQPOnLVdfdrggklf8PTNS1Rsknj1/JpGHx3svC8=;
        b=miELm/BLpWir/xwmbNEtx1BLgHaBQcI4ZWUk25VrD8LLl2UpYieskvZ+I1Gv5CM8YA
         hc4RQDRUQua0qUB8cf9FkJVtro3qIouTEUpMpwuEqLNiC7g4BulxHXvCQoV1mG7uUWB5
         Yh/k6V0Iqgy9LSuR2KjutqIL+cGEDEbRQp6PWARyAWIjaqQqlg3gGRVXpz8D7Svt7Nsb
         UoExgAMx7yRNRA595EYoqa+aPkGhowaUxA9XnpUaChG4c7jityhHIhkAVL+VLNBULmP9
         V6ldrJee9ZtOlTPkTo1R1cqFm4vDmZEv41XgEfXwaJ6Su396QirmHadlE2jg1Qtamo+y
         kOKQ==
X-Gm-Message-State: AOJu0Yx5AtRqGvqO5MBbI8xhXWHUy3KiQI9hRBR0UUxkCTGDONbr9SmX
	0PMxxeVkvFIaGPfzNVqzasMBnwhBwUOoAk3MtvbfacB1lq/Xf26GVtrIKtANRiXSNxq+dT5cEeT
	69LfmR/my/rj5RFqc2SlDoMMuh2dS/WC0LRMbrXjIDCE0bKOhowFfnF4it0PCBStf9OI=
X-Gm-Gg: ASbGncujUIVqKXLGyB4bNdqT7sjZU9Ig9+ot1uVGqnzTAbP8W1vKgey07mgTkguEAC2
	4SLf+O09wEAu26TjiMUS2bX+zYE0ud0rIyHew4eLfBcrvb+g2oTUrwD7c4Os0bvYPaBYu8rH5bL
	+fDDDm7gU1RVbBpw1YVf6dUvwybCF9kyMhfOnkbRLz8jUxC28LcvNBxREZ634svAyrOHYZCpzk2
	DIQRyuZdMEm4UebxYRAjFvVZx8YGr0ZJPyWtyYrkT3MQ7GUr/b5kxZxFlKnnqBwTyVS6urnGivI
	67JtXpv6vy68Y+a0dBtuQya/qnBvMxg=
X-Received: by 2002:a17:90b:4c12:b0:311:eb85:96ea with SMTP id 98e67ed59e1d1-311eb859b73mr6274048a91.9.1748488298483;
        Wed, 28 May 2025 20:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0wLnjI8RBCVl1hZDa2G6VR0IFiIxWSSq9ghtff45z6KaBah7kcwO3pIxUpCV9np9pBPkN5A==
X-Received: by 2002:a17:90b:4c12:b0:311:eb85:96ea with SMTP id 98e67ed59e1d1-311eb859b73mr6274006a91.9.1748488298115;
        Wed, 28 May 2025 20:11:38 -0700 (PDT)
Received: from [10.239.154.73] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b91c046sm381376a91.29.2025.05.28.20.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 20:11:37 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Google-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Message-ID: <42be0934-2e97-4d02-98df-b5a03195e8ae@quicinc.com>
Date: Thu, 29 May 2025 11:11:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: flash: leds-qcom-flash: Fix registry access after
 re-bind
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250528194425.567172-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
In-Reply-To: <20250528194425.567172-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6837d06c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=m213F5Sxp9nYWYPwONUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1Z-ElQ4xCZZVnlfPO5AQFTr4qB3TKM_U
X-Proofpoint-GUID: 1Z-ElQ4xCZZVnlfPO5AQFTr4qB3TKM_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAyOSBTYWx0ZWRfX2S9ijrDBFw5r
 P1jVBdeG0ju2OPyhV4le296c2/iV48Vy2T9MaUcOrLlnklYWCe7hg6wsmifWj4IPXizyQYYGj8d
 EfmMsAuFA+9tKZ8AfOehE50sqpaYJzncYE9INCMEAP5OY7Cx39zUyurtmgM+7fpaOG3DB4Ae215
 nsLA70DxF+4We+nZWk0+HNeU135hPiTd3dZKu9up818R+hMXqcvDk24n+iNrtPDy2ogUtll9iG1
 092wFPGVy48N7eXczW2sSAQjrvHCt62BWxPmDC/dipca4EfkdVGc1vV13YqSMarg2gjZIAAMjey
 ZSt9z4o/j/coJMr5Tfy6Si5MkbpvK6TH5CBLsUER38uT7QoP0BcuTlQWIIxi2cxXk+6oIKsHtwH
 rRf67QGWvQRm1CJoISGVizxjaVgaxUHxWPft3sAr8SQvNUkGpcnR7J0boMUbYphHzTlOwr7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290029



On 5/29/2025 3:44 AM, Krzysztof Kozlowski wrote:
> Driver in probe() updates each of 'reg_field' with 'reg_base':
> 
> 	for (i = 0; i < REG_MAX_COUNT; i++)
> 		regs[i].reg += reg_base;
> 
> 'reg_field' array (under variable 'regs' above) is statically allocated,
> this each re-bind would add another 'reg_base' leading to bogus
> register addresses.  Constify the local 'reg_field' array and duplicate
> it in probe to solve this.
> 
> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This is a nice example why constifying static memory is useful.

Thanks for fixing it!

> ---
>   drivers/leds/flash/leds-qcom-flash.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> index b4c19be51c4d..b8a48c15d797 100644
> --- a/drivers/leds/flash/leds-qcom-flash.c
> +++ b/drivers/leds/flash/leds-qcom-flash.c
> @@ -117,7 +117,7 @@ enum {
>   	REG_MAX_COUNT,
>   };
>   
> -static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
> +static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>   	REG_FIELD(0x08, 0, 7),			/* status1	*/
>   	REG_FIELD(0x09, 0, 7),                  /* status2	*/
>   	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
> @@ -132,7 +132,7 @@ static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>   	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
>   };
>   
> -static struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
> +static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
>   	REG_FIELD(0x06, 0, 7),			/* status1	*/
>   	REG_FIELD(0x07, 0, 6),			/* status2	*/
>   	REG_FIELD(0x09, 0, 7),			/* status3	*/
> @@ -854,11 +854,17 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
>   	if (val == FLASH_SUBTYPE_3CH_PM8150_VAL || val == FLASH_SUBTYPE_3CH_PMI8998_VAL) {
>   		flash_data->hw_type = QCOM_MVFLASH_3CH;
>   		flash_data->max_channels = 3;
> -		regs = mvflash_3ch_regs;
> +		regs = devm_kmemdup(dev, mvflash_3ch_regs, sizeof(mvflash_3ch_regs),
> +				    GFP_KERNEL);
> +		if (!regs)
> +			return -ENOMEM;
>   	} else if (val == FLASH_SUBTYPE_4CH_VAL) {
>   		flash_data->hw_type = QCOM_MVFLASH_4CH;
>   		flash_data->max_channels = 4;
> -		regs = mvflash_4ch_regs;
> +		regs = devm_kmemdup(dev, mvflash_4ch_regs, sizeof(mvflash_3ch_regs),

Minor: sizeof(mvflash_4ch_regs)

> +				    GFP_KERNEL);
> +		if (!regs)
> +			return -ENOMEM;
>   
>   		rc = regmap_read(regmap, reg_base + FLASH_REVISION_REG, &val);
>   		if (rc < 0) {
> @@ -880,6 +886,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
>   		dev_err(dev, "Failed to allocate regmap field, rc=%d\n", rc);
>   		return rc;
>   	}
> +	devm_kfree(dev, regs); /* devm_regmap_field_bulk_alloc() makes copies */
>   
>   	platform_set_drvdata(pdev, flash_data);
>   	mutex_init(&flash_data->lock);


