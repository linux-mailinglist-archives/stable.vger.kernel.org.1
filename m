Return-Path: <stable+bounces-104030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB09F0C29
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2DA16960C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626E1DF735;
	Fri, 13 Dec 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioxRIeCz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10E1DF256
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092671; cv=none; b=reVkh2FE3vEY6gPxpQNrIPpKJ+ISMgR6PdMOMOtu0PYGm3bvHhV4dXoEzDqSqp7S9V+ewkEiyotp1EzhKxaqMOgOJqGtw0pOoiqfkUBVY/eZCwpLF9hvJuX7RAkBUnHUnbIWMcCItGFEHHvPqOWjAUWPaheKosGQL3b9PZVldh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092671; c=relaxed/simple;
	bh=tD17HkrkjwHc/HyJb5615Eo+jPA69PLVs85GiGzdgJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV+jItoqZrzdCeUcOCwL8pKZn1AnIj9gEO0nAT3oFKuwEKaO2bcSRWGfLU2imzF1FCO+EpoH5FPOAvlyHkH4086PrzktpcVbuAB39ky3gVGrJ/0Uq+5sR0Glo/7b4gwdFjAkerKmwbR10Igp0208jwZ+Mgr9kLhwvKv+hn7yG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioxRIeCz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81awm022117
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hSakwGz/qif/zcmahl1MGSvr3z7MyIjajOoGXN3iwwI=; b=ioxRIeCzkslyJbSk
	Et1CVOx1y7LfzrzFbGNh3xFlfvx+nrQvnaVTiuXbkbzAvhdiCBnfmhgKSeRtiRe+
	czMlHxZBKYhobHLvNtGc8yHEqVp0FHnwuMXRKDVZKoepVdCQ9PblyhO2YegPYS9X
	fMVsePc47Thile8IdMV+Xj1MlggDlYEmFxS+IfKvc+RVBvH2HM8lCPi76eN0byU5
	Gu376g32B4qkVabRmHUzxoubxXOhHu/Qs17PKu6XctKasLSVQ9nK2tsZac4sxk5U
	iilv9fKZ7DSG8t66Vd5mcbrmLuFKcztGjTXbUkfoe61l4nBEVbnWzwhZea+pcEh4
	6esS+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh270rey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:24:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467975f1b53so4459381cf.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 04:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092668; x=1734697468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSakwGz/qif/zcmahl1MGSvr3z7MyIjajOoGXN3iwwI=;
        b=Ja3atB6UTjYa14SOLmHk1xtFtPBrIN7QOX62rQNwzAgRM6kHcMg98zrcfPuCrYucs7
         bnIoEr9qUkcWLda/QdrxISUBJolAu7XyT5JNB5t30NEcafjRpkvQ7S1p58dKbEL8pt0t
         Ohwr5rZDoJYJlu/8+jnXU4+oZNntri+KKJdqGjhaUh2z0fYdd8vzT8YrfpG8UHYIDVLo
         ags8JFOxl6noxIfRrDduKUDQJhfC3peBSQflrEVmmI+1/sOqR0UYLBbjsjXgCo66wDCm
         D06+uHRKNj13hfl9xrDxJriab+Ah7N0mlcWeW5uHxGU/zbKoP7kf92WUt8fCyrm3x9qL
         NC7A==
X-Forwarded-Encrypted: i=1; AJvYcCUFeFmx0unEoAztuxm09/Utx94m2tpqptuWosGtt4O8Xwpt0zsMHTm6ZoWSj7GCMSSw0rMORp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTPbOyEnz3zgIhyywcidBI6aa2hJL/KzFZBzW0vQW6bvqqmHD
	NyQ20B7BEYcAvGzymLHkAj/a61q8XQHlk5hCBSAhZaEVwMzMcoImYcSOB/lZdMZeD4QCxpEnwjj
	H6f4SnqqCN1+P2Hpk03ddS2o++LunrJkcxBwmz2qiyJ+yMSWILmJaIkE=
X-Gm-Gg: ASbGnctO9/O2cNuwB4k2WblkMk6W9gm5SSzCOapuQQePQaNsuKCEAABzeRqWIuM6WBH
	xQsqCDy78bW9lgiBeagd2cPTy5m+Hm4eiJ38nZocPPSmz/jPoNl7PAJyy9hi0ZzyRn281O0/LL1
	F2li+ZfLnl/RqEgTbVWrsCjVYOpkaWDzt9o9y3Abas2ZS3D9c8egLppVfsfxl273CS6YTpRGHEi
	gcm3ggst6z/hAxmxjTdI+Dwgj16QZWYamlR++aAATBtQn+LZp4anENlZQes5NWfodb1p7gf7mTE
	CivXR1hjgScCXs9RwiagQ8beSNBBMVBYQMJR
X-Received: by 2002:ac8:574b:0:b0:467:5fd2:9963 with SMTP id d75a77b69052e-467a5757d84mr16327571cf.6.1734092667919;
        Fri, 13 Dec 2024 04:24:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF65NgsdFcTVYtqrAw8zNApgyyd4jHo1Dv1pzOx2jmjXPzcuAJErfS0afRSei3yts2ia6f5pQ==
X-Received: by 2002:ac8:574b:0:b0:467:5fd2:9963 with SMTP id d75a77b69052e-467a5757d84mr16327291cf.6.1734092667528;
        Fri, 13 Dec 2024 04:24:27 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm11386055a12.40.2024.12.13.04.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:24:26 -0800 (PST)
Message-ID: <40bdbb34-94a5-4500-a660-57a530f066c8@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:24:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: llcc: Enable LLCC_WRCACHE at boot on X1
To: Johan Hovold <johan@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org
References: <20241212-topic-llcc_x1e_wrcache-v2-1-e44d3058d06c@oss.qualcomm.com>
 <Z1vzddhyrnwq7Sl_@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z1vzddhyrnwq7Sl_@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HUea4xEEh_jSnXmpfokcaMARoWc8N9U-
X-Proofpoint-GUID: HUea4xEEh_jSnXmpfokcaMARoWc8N9U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130087

On 13.12.2024 9:42 AM, Johan Hovold wrote:
> On Thu, Dec 12, 2024 at 05:32:24PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Do so in accordance with the internal recommendations.
> 
> Your commit message is still incomplete as it does not really say
> anything about what this patch does, why this is needed or what the
> implications are if not merging this patch.

I'm not sure I can say much more here..

> How would one determine that this patch is a valid candidate for
> backporting, for example.

"suboptimal hw presets"

> 
>> Fixes: b3cf69a43502 ("soc: qcom: llcc: Add configuration data for X1E80100")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Cc stable
>> - Add more context lines
>> - Pick up r-b
>> - Link to v1: https://lore.kernel.org/r/20241207-topic-llcc_x1e_wrcache-v1-1-232e6aff49e4@oss.qualcomm.com
>> ---
>>  drivers/soc/qcom/llcc-qcom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 32c3bc887cefb87c296e3ba67a730c87fa2fa346..1560db00a01248197e5c2936e785a5ea77f74ad8 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -2997,20 +2997,21 @@ static const struct llcc_slice_config x1e80100_data[] = {
>>  		.bonus_ways = 0xfff,
>>  		.cache_mode = 0,
>>  	}, {
>>  		.usecase_id = LLCC_WRCACHE,
>>  		.slice_id = 31,
>>  		.max_cap = 1024,
>>  		.priority = 1,
>>  		.fixed_size = true,
>>  		.bonus_ways = 0xfff,
>>  		.cache_mode = 0,
>> +		.activate_on_init = true,
> 
> If this is so obviously correct, why isn't this flag set for
> LLCC_WRCACHE for all the SoCs?

The other SoCs where it's disabled (8180 and 8150) have it in line
with the recommendations.

Konrad

