Return-Path: <stable+bounces-178040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A231B47B71
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E43B9DDF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F526A1AC;
	Sun,  7 Sep 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXCNPexG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C4849C
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249293; cv=none; b=tjJd+OhDaQzbj6l4zmngxCcwsM46f1QJecS8DA6XjzQuNl72YGqcfWfTBvVdG2iDB027YJluAJ1CM+3aKORiU8MHsXDieoTCxjAWtQuUxVAMQf+qlqjfum+lP9XsYkcYO5qbNOBs/xqcb6itF8P48Jl3yXLOpJPgX/V6GxSU0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249293; c=relaxed/simple;
	bh=fovseDpu+uBVSyhkPuz3suEFYJtmdGB3aLws1MqwV/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmBplfzWMOLHPQwH8RDnd1KyZeXzQVjz9m20wyPNPMYuW95hAnCjM44EhE63dGSnIKjPqovCnsSczqYQpjyE5I7jLAj2nrv7X/pIP15m8eCcDuIH+fYYi2LXr6jo6HoIVkjCnpf09vCEGA+7HWA5i2kwlGQf0rSPbLD9sKcQR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXCNPexG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5878jRpU022426
	for <stable@vger.kernel.org>; Sun, 7 Sep 2025 12:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfAmweq7JyBuIK2YLoea3uL1qJZjl0HZWJilg59gpOM=; b=iXCNPexGVnqjEcB5
	P527Jno7dswx6qeEqQNsuqyAM8ckrRJhKTDnflfzV7vgDmw9P2GUtv5u6bIN9vja
	8e5sYYjMwgUhas75XLDhK3PYL8N80ssjVLpJR2uh7kbiXLzBfYDuzWN6qkGn31cK
	PLMxu95wtcMla57HF/tmJubrn8kuMUiRL41kWKgQEpy4AGwRM5LJByIiYxF8koxY
	onu0KfDjSMOGTBqtViZli9I6vwXOvquICLqYtMcHgwKZ8lJzFDMc+iCzCt8XEgY6
	2geBnMQwmOz05n4EjXHTW3y97yVYiVnBjiwwCzbLoC7OY1Hpv0h2u45QXyi3HG11
	m2emAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws25q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 07 Sep 2025 12:48:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7722ef6c864so3242170b3a.1
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 05:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757249290; x=1757854090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfAmweq7JyBuIK2YLoea3uL1qJZjl0HZWJilg59gpOM=;
        b=Zst8x54eZel6EaX6tXcut0yDao9k00zRI5RQXtdcqy1k2LGEvxR2jpKCAw9oJPDiTi
         tsz3bfgJtyty9KUxR6w+6FkE3rsSX2AhPAt7IMswnpqjuk8QN8kB2q1ug3n83gwTfSon
         mcqgBWJ7aaq5H52c8iJOvyv8mXA3GQGsA26GLdNXid4p0h5i4EGfX9EA6aJxRPji4/T4
         TJfPJSqJnmyvsRKQXTOVJi9ClOvFx/TcQbBhCCj3aSpDL/4QX1GAjKEYuDHr0QVqSJmg
         NoECaOqxWftOQUOaXYOdVcGL6iB60EJHVBopXFF+oMOos2zxArgYog+4O2esRNxbgeEo
         sSPA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgLOdqSw+YKpnWeWitsb8KWgoediYhelH3tEHLc3JO6XS1f8qIORWVCrD6orVvzpIMUj9/6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhOj1AdfPzp6JEZ/6X7ZNrTJn+ofm7AvU3n/DUwqRlL+Edvv4
	PWH1uIF+1WHf8necgoah909qvBTWjmQB0i8/his2//ECOxQqcqW9P82xiRsLsMEfn1cW1K2fcNJ
	52x1N0TdsKANel2V0yimTYVh7YjFhdrs7VdjTcG9dsqrKBwuH9lmAwGLipWA=
X-Gm-Gg: ASbGncuf0DFP7I4lWXpDKKczKHg7qh6pajhLqRsYZT9LNmqCaecgK14F9awbZDyLeJZ
	E2MGpS719bJT8NiySlOkMmeD7OxRhrOBLWYSR4/s8aHDxKrr0Kq5R6X0k11u7QgoGG1R4Nb9ZDL
	p/GWzmVyz8+Ob3dGoEVVjOEI0ZY99TKwN+MjSt/7ug7RbJSKoAh/Ix4BmtuhP54Gyo1mTcUv28n
	2E8BjqkUdOaBemB1E5IINMP/APH1APgL1a0dQ7G1DoIyFZ2s3onMaj7RDnRheO4uK8ebqSca/3m
	BDvS31xZJYVs6iIqtyMRaWFCB4AQBIfRVeT+pLc6iKSB162F9s76W2Kv80uka6vtbA45gLKP8E9
	0Jb0u
X-Received: by 2002:a05:6a20:3943:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-2534073ed6cmr7506756637.25.1757249289771;
        Sun, 07 Sep 2025 05:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENWjF4ugvYWq1kcweui34vJDpxHEqv2vVeVqYw4aUXOwqNAELGDOT7480x/k7bScPoBqYfsg==
X-Received: by 2002:a05:6a20:3943:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-2534073ed6cmr7506730637.25.1757249289290;
        Sun, 07 Sep 2025 05:48:09 -0700 (PDT)
Received: from [192.168.1.5] ([122.169.129.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm22929103a12.13.2025.09.07.05.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 05:48:08 -0700 (PDT)
Message-ID: <eaa235f2-b6be-46e9-bee2-1a4818736d42@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 18:18:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
 <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7_5ddJDIB8ZfEXlBEJVJYMSXO7bL9GAK
X-Proofpoint-GUID: 7_5ddJDIB8ZfEXlBEJVJYMSXO7bL9GAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXw3+6Q6kZkOjo
 ewjXJpwP8MpcwQmOCz4eAnqZlQTC4jHFBc52nERUbbSPSmJTv3XNt9Iylb0Dd65JVGSavh0nRlo
 SPM6GzCxVyU5hp6aClh1PLvojvFXcwHW1dz//iskbUS4iE2kCq+Uv7s7Fr6Y1JdplLQ2wETve6y
 xurZgnm7JeABUp4M475I/DZHQRR6VM1MoXkQQmjJX0hCbykO8Ju7Gg13LNLK1IQNNIDfSTMGkto
 U65ksXIatwbhP1XCTIU2C/kzzoJT7dRJPJnjBNKKMgvkwv5g9yJZ4pjmAh4XnD9cA5nXHEPmZAI
 kqGzgZipCpLlINJ2PtPapHVivoNk6uVWqXZwCdO5NIwnJyIf35HvUV/KxyxQXO6jiY1WOjPSUyW
 cUnlXUCT
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bd7f0a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=/ZFYPCvVo1eZwIJTb8k6Sw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YKXIHFROM69d4h8Ztm0A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/7/2025 3:30 PM, Srinivas Kandagatla wrote:
> On 9/5/25 4:04 PM, Mohammad Rafi Shaik wrote:
>> The current implementation does not configure the CPU DAI format for
>> MI2S interfaces, resulting in -EIO errors during audio playback and
>> capture. This prevents the correct clock from being enabled for the
>> MI2S interface. Configure the required DAI format to enable proper
>> clock settings. Tested on Lemans evk platform.
>>
>> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
> 
> Am really not sure if this is a fix, because sc8280xp does not have any
> Mi2S support. If you have added support for MI2S on any other platform
> that uses sc8280xp machine driver, then that is the right fixes tag.
> 

ACK.

You're right, thanks for the clarification.

I'll update the patch based on the inputs provided.

Thanks & Regards,
Rafi.

> --srini
>> Cc: <stable@vger.kernel.org>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 73f9f82c4e25..3067b95bcdbb 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   	int dp_pcm_id = 0;
>>   
>>   	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
>> +		break;
>>   	case WSA_CODEC_DMA_RX_0:
>>   	case WSA_CODEC_DMA_RX_1:
>>   		/*
> 


