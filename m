Return-Path: <stable+bounces-178032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DFB47A4D
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BDD3B42CE
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17023BD06;
	Sun,  7 Sep 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROsvt3gP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93B230D1E
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239224; cv=none; b=TejR2+qXYCJM68bYmaAsDKp4fzSMZRSpvPEBmuJ3SisgkFshh7Abh8cl35ApIVXJylRynRMTyCixtn6sg+LOawATuRmyG3cHF1lm8DWTRqXPLz7dmXe58yq6ucmNccDEcRuc8hBqf26t3S8AIEHc3Rl+plqihQscRslNv0cmZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239224; c=relaxed/simple;
	bh=JdRGVx4bHeaB9hxsshS++UJcE2XQe4YXg/1/cdY5kpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtp45A7eXFDlcScz2BtESHcDi4PQzGDt2gea/OLRAv0DJVIOm0cprMO3gnXF9BG6QqH5DGxYW3AvTU3AxZp85MIuv5osStFpurzvXufem9in1RmolyBVR/DfP1RyUF/bN7uSQXzaAmNyqiAvCTzz0R/T7KmZRP9jEB1GpqTX04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROsvt3gP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5878jIJV022279
	for <stable@vger.kernel.org>; Sun, 7 Sep 2025 10:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qr3Czd9PwhhylBpPVieXHwCBf6HZ/rEjYpqLSCwU1MQ=; b=ROsvt3gPtum96m7O
	O+9R4aaL8zNmbnZ+R/3AfPkim2F6zAIbHwZq1T5fz/KNVz4e9KfKVXQhGVbESLb6
	m7iX3fXPgiMe59J1CbZJhtQp5nQ2hf7bdQDAWynMIqjnT+3Cq46IFcW+7f2ra7dk
	mUo3UwG1xETfod5qzQIyZpf+WCbg4V62gOa17zkTWQCjNDQv6boB/ojppi3UM1Y/
	/tsvSboIWkAaUBRpYUY5Tq/Sw3GyO8BTqLcQdIbgwTNWveXlCD76nMsoPc73uvVo
	kviLF5HEdr6HLO5uxptPcTtzMhPJhQ+PchDdTvJ4enNTGUcPsOwvZ45gWPjD5QYY
	o3K5ug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws20dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 07 Sep 2025 10:00:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7224cb09e84so78769006d6.1
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 03:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239219; x=1757844019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr3Czd9PwhhylBpPVieXHwCBf6HZ/rEjYpqLSCwU1MQ=;
        b=duUM+rD2quR4bWiDfzOUOJ8FD8XtBjnbarT+sbE6YrZSchcFqbmbCL2YrW3KPnChEy
         lkVV8BOmBjrAUCf9alEc6XRobeHlO5nYwRpzY/I2DqrrlOdQCC0kTkwTrQA/G4Fz/OX3
         cty6g1Ffbd7vV2IFLjq3SgztnCANO4IEk6QNRwkG5yiG5VPQJ/yK2buPyPgetgJ4bAn0
         24jxV09Icavh6eKLhothE+npMmY7mFPtdVxV1JsRjdQRhDgKRt0hXggvKnOO3Om/aXcZ
         8w+5WjATFY+HiPDfaMB2w29lJTQ0O1VfdTAW7TMdewai+KLO6/4yrMnjJ0gFqJD4QkVe
         1SWA==
X-Forwarded-Encrypted: i=1; AJvYcCWBN9zFNcmAjpFRoNrc0cT4WQdTTg3Wy6DWc0EF5rFksNSnZ9KSyv0sybb0mkDEJShdEqZ1bbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFP8giRad8uw+JT36JdiVu2bJXvaizrw+adV7yKi2q0zSnDL6
	IfKdQfYOk61WLZqrOF2LhqfuzmUZGn18e9u8q9W+hNX/pQ0OUxTiy/EIkDN2n/rDBKWrKt9QJNZ
	5Lg84Arc5RsLMw3PKPNfJtI8bpi6MJuCLC5H/jmzJLCg/Rzni39HHek7z5Qc=
X-Gm-Gg: ASbGnct4yMew+4g6W1uUsnWYJtMh0W/EMvcZwmd529nENtPy8mx34uaMBOrM7qcRK5d
	Qhnrp/qX5KlTdDmL5d8n7tVOXbg+xNSKJD4+2tXAiALq/bhr8q9YTN9G4hASpE1lkSukaDiJ6Kv
	mLCa8eiuSut29a9IozSfG7r+Wt+BNTKAuAkod0dMhZj4KiBeo/H2lMEaoiaIhQ7vClQVSKsR2Ou
	1cBa1X2iIYpBPfmZLdqgNJn5wsKRzYbIzjGBRzgoTFXLzMyDZ1Rcjnbp59ZBvlK5ZLWhyyLqePa
	W0aBc6kj/uCX04olXZhrmHmW1TyExtYVWT2fFWTFAVV0Y9l/X41UUuU6l4374s1lvd8=
X-Received: by 2002:a05:6214:2462:b0:70d:ae61:7ddd with SMTP id 6a1803df08f44-72bc5842ebcmr122738906d6.31.1757239219435;
        Sun, 07 Sep 2025 03:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZRn6PmHHN0WVzaevPq6eNyd0NSdg9SA4KKI1yKwL5vha/Px9Z7l0N1LQNsS6IGy0U+cad0g==
X-Received: by 2002:a05:6214:2462:b0:70d:ae61:7ddd with SMTP id 6a1803df08f44-72bc5842ebcmr122738456d6.31.1757239218799;
        Sun, 07 Sep 2025 03:00:18 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm141015435e9.3.2025.09.07.03.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 03:00:18 -0700 (PDT)
Message-ID: <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 11:00:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
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
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MUnhwidyUDuRJhFGPd6MLGUCHXlbcGjp
X-Proofpoint-GUID: MUnhwidyUDuRJhFGPd6MLGUCHXlbcGjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX5lcR9pvorU4k
 95+9wwDgNB5ZlFDeEDrcXuR4DZC0frnxpwbRotK0FABEwk5RdXqva5u28mI+ozig6bQ3AwmcOeR
 lFTEkshOBaskVvBVavSopUqZN4LZreql6pgkKDJq0wlWuYWB2rEqfjX6Citmly58MfGtLzuxjYX
 hTwY6V0YjLog/C+xkvNMw4uAfELz8KWSRjCQc2HWQ8wPS09+sNYlgWVsrZsGDQjvN/HLtSMWzs6
 V392mQik5AUK5FFUugVZc56+FqKp3spQA5DrZMBFoJwziCV/Oid1c2D+PnZ+6JOFm5I3veHIKk+
 QA9pBddtSrH+N172nbge+FxQcnGf0uWMGnfz6EVIe45LcLfj5Sq/tMRLFHew2Nxhtkkcru6Hcjw
 59GwTQNZ
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bd57b4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VTWOZG3uf4wZYCvkMeEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/5/25 4:04 PM, Mohammad Rafi Shaik wrote:
> The current implementation does not configure the CPU DAI format for
> MI2S interfaces, resulting in -EIO errors during audio playback and
> capture. This prevents the correct clock from being enabled for the
> MI2S interface. Configure the required DAI format to enable proper
> clock settings. Tested on Lemans evk platform.
> 
> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")

Am really not sure if this is a fix, because sc8280xp does not have any
Mi2S support. If you have added support for MI2S on any other platform
that uses sc8280xp machine driver, then that is the right fixes tag.

--srini
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..3067b95bcdbb 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	int dp_pcm_id = 0;
>  
>  	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
> +		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
> +		break;
>  	case WSA_CODEC_DMA_RX_0:
>  	case WSA_CODEC_DMA_RX_1:
>  		/*


