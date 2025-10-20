Return-Path: <stable+bounces-188136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AFBF20F6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57570400DBF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39746264A76;
	Mon, 20 Oct 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5639v1w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7038261B96
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973568; cv=none; b=ottfpaiMe4QDi6yZBMxwjQ8S8lNImUSfQk5TGjJxcbzvW6cA6Yg5uFmHQCULufyo2Xsi3dqHviC0bzHyxDn4oloJ+phrBtGZZ9Lg2CoHm6mNcv4DxNd0HKPPm/GIxOAPLnp+E/xSMfF90+ihKt2Vxc/4BJG27fdRnarSc6CKtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973568; c=relaxed/simple;
	bh=txIz2mOWj+d71E+Te7JQa6TGasPd3qP3hYYTto4gqzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJMP1wFWnLlY8glB0LBGdvEr07Ad0osSYq9byQ8x8NolqO5qW8RSC9n3TDodR65KD0Gw3QwZdBtEQM4QRctThzT+SdAB41SBq8amTfngLHLTIKphAYqOlwnp9kLnvdCJFuQ7AAFbqn8Agi/C7gxOwPFyhvKXWwFtb+SjeugNJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5639v1w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBtN5r014855
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I+yIVlYM5/2IuWRwZgg83a0i74gXu/4A3ovbjVxqAvo=; b=L5639v1wdsU88KTZ
	aP31YCPaZZA17fAr371LPz20Mbe9pPB7jmcP/Y8iw0T8UvihA7TV4RPBzBAVRWSo
	qeOH0FXFykqJ6BytYCI2boZwYh4q/Mec+JwiaByylksSYZZ3kFU7OJD2YSv8b9/w
	H+FjqRpgvHKOVTKlyjcAIJPP6oxu0n8WnWP5zit66fkzf4Ynh0TMoRh0hREVhTgF
	n5bdgtu0sxfq6dPzXCXY8E/fl1VmiPWADwT4AEEjBXr8TXqiKm3vFbn/MsnJia5t
	2opTO9GPTBU7I+MlXaSnqesfc/GDdglQ9AiOMmIJrwFehUH1diFuZLXpoqyacvPO
	pp11KQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pdcu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:19:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c2085ff29so159554046d6.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973563; x=1761578363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+yIVlYM5/2IuWRwZgg83a0i74gXu/4A3ovbjVxqAvo=;
        b=nrk1ywmgX8SGWVQarko7a7I65Vyy1xq4xlSkRf1idQVXHmiREvvD+4OhXeZS0pUKw+
         pFwl+rSB/VzWZXR4OPXPn9uEvuyxOmbC5g0RtG15i2NsP40G4XD6pMNwT/3pp3FTfxHB
         LTmO899iEkVUPJ8xjH4B0Cb1mEMyHcPCqw1qFJ2fO1CRXESHEOfm4eLu2Q6VhozqZBCu
         nUo2wu+id9FRY0wCc8cR9LTuRLfyspWhQebo5S24jZHXyfXAx0X8o6PWy8eqq4RREmXj
         uajvn4jbzM6AvWifHfDroBAij+MFdhNOoLgVJS2qupiWPr6xilVt2hwC2VvzRiX5Z9Zj
         26rg==
X-Forwarded-Encrypted: i=1; AJvYcCVQi9QzukkQ3ycIzPPYdX3Tm4Piqkf75cRELCYsILZjEkPajfyj0woh3/Ar9GC+XUQetZuMRR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVrNy2zs3YNo+Zpyk9t7jqys6NUypfYiY+SzoELGpfQaCCUGj
	ZsFtRXi73pBanYqOcrbIo66Frl/v5Gdhyin4UY9u+bKradA//7SQPua718+oclZuaecvLecTBnG
	ony9GNm1+PgDfRdSGUZ7/f+0+ubYUBewrXxpLX1nf4Ud0EQbRkz3Z3WgzZt4=
X-Gm-Gg: ASbGncuQ07JAAMa9LxIU36q4/xlyFwyW/ai4jBWhk9DlqlITnKWtmEnzHuYYYkx5Tkc
	ntriYf371u2OZYyNVmqd2+cgTXBpthm31vjQoAECjtJWt62r0Vc00b1lMFAqJXC4i+mLJqGJgea
	x8c/TYtnrD3wuk3Cd7HZhwPVl9unZosJn76JCSLmkAExPbf0VQwVxiFRbBX8qny5uSzcbOXWi3u
	c+Uttllk+fsL+tugUhGljvmbKstAwcGV67nvgem33JKxWjxqGcWI2wQcN2h4SRRSiOOPdLOhLS9
	+dmDmpLNQXYAYs07akYLzv+Uy9S5CXiWThzNnoFQGtWqteUasYidkhiXhTQY1NXggKwse8q/Zy1
	VA0E5D5H7rRK98HzWWNWj9HU9rQ==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b940:eba6 with SMTP id d75a77b69052e-4e8b940ee60mr75347001cf.54.1760973562704;
        Mon, 20 Oct 2025 08:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH7CJ1xZAKYdlNReNmCh8bS2iyCK1x9Vecn8/NOzPyBPl+tYWrz9fVLu/gfRksjbH30i8Ykw==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b940:eba6 with SMTP id d75a77b69052e-4e8b940ee60mr75346481cf.54.1760973562191;
        Mon, 20 Oct 2025 08:19:22 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4715520d753sm150398215e9.13.2025.10.20.08.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:19:21 -0700 (PDT)
Message-ID: <56328447-4cab-4446-b8be-63fad2a6217f@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 16:19:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: slimbus: fix bus_context pointer in
 __devm_regmap_init_slimbus
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, srini@kernel.org,
        rafael@kernel.org, dakr@kernel.org, make24@iscas.ac.cn, steev@kali.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20251020015557.1127542-1-alexey.klimov@linaro.org>
 <asrczgrmisaqzhin37jzgylm6ez2mlxtsbe6qp5mqgfecprup4@yb32qzna367s>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <asrczgrmisaqzhin37jzgylm6ez2mlxtsbe6qp5mqgfecprup4@yb32qzna367s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX9pp5caI8G7NK
 Qy6oj22TMr2sqpDt5ysVpNIQB8Uaf0/n81MhGWyWaDppkrnI9FhTW/DPbfgqKJshAEj3jPbuSpA
 DKTu48GEe2xy/s6ygJ2vZziTkFKC2AEDXFbkwAK+Gx8wAJ0zXr/Wev6uHisQ7XXoc0QbeYbgmas
 KIx4IRmRCG+kg0bI8/ftqpKo3W5Xs4gcaYrFQFdcW2cK6RyBE+iGAmENSmVFGNQQKHESWTJFhn9
 NAnYZmvp+3nN7N1x9NbgDblcy3VeH/MywrPt0vAEJGoDZrKzzkSwPTrF/+unQ3SugLHsj3t7H3R
 QI7mflzAXMvnIjZIUn+d859s6G5PfSh4/2EHqbqynMOpQ/YOzzbKzaZtQaeE95yZpUjiiJPSng6
 zejq5WIRpotVXPK3qLTcr6IfZmBCxw==
X-Proofpoint-GUID: hIDl-tXQ5spjng2B2R0p9afKGCUY5K7W
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f652fb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FQcGyLhEAAAA:8 a=KKAkSRfTAAAA:8
 a=ZVbmtxpYz0up1Ekx5joA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=09nrmc514_O-33C_6P4G:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hIDl-tXQ5spjng2B2R0p9afKGCUY5K7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/20/25 12:15 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 20, 2025 at 02:55:57AM +0100, Alexey Klimov wrote:
>> Commit 4e65bda8273c ("ASoC: wcd934x: fix error handling in
>> wcd934x_codec_parse_data()") revealed the problem in slimbus regmap.
>> That commit breaks audio playback, for instance, on sdm845 Thundercomm
>> Dragonboard 845c board:
>>
>>
>> The __devm_regmap_init_slimbus() started to be used instead of
>> __regmap_init_slimbus() after the commit mentioned above and turns out
>> the incorrect bus_context pointer (3rd argument) was used in
>> __devm_regmap_init_slimbus(). It should be &slimbus->dev. Correct it.
>> The wcd934x codec seems to be the only (or the first) user of
>> devm_regmap_init_slimbus() but we should fix till the point where
>> __devm_regmap_init_slimbus() was introduced therefore two "Fixes" tags.
>>
>> Fixes: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
>> Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
>> Cc: stable@vger.kernel.org
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Cc: Ma Ke <make24@iscas.ac.cn>
>> Cc: Steev Klimaszewski <steev@kali.org>
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>
>> The patch/fix is for the current 6.18 development cycle
>> since it is fixes the regression introduced in 6.18.0-rc1.
>>
>>  drivers/base/regmap/regmap-slimbus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
>> index 54eb7d227cf4..edfee18fbea1 100644
>> --- a/drivers/base/regmap/regmap-slimbus.c
>> +++ b/drivers/base/regmap/regmap-slimbus.c
>> @@ -63,7 +63,7 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
>>  	if (IS_ERR(bus))
>>  		return ERR_CAST(bus);
>>  
>> -	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
>> +	return __devm_regmap_init(&slimbus->dev, bus, &slimbus->dev, config,
> 
> Looking at regmap_slimbus_write(), the correct bus context should be
> just 'slimbus' (which is equal to '&slimbus->dev', because dev is the
> first field in struct slimbus_device. So, while the patch is correct,
> I'd suggest just passing slimbus (and fixing __regmap_init_slimbus()
> too).
+1
I agree, it adds more clarity to just pass slimbus instead of dev.

--srini> >>  				  lock_key, lock_name);
>>  }
>>  EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
>> -- 
>> 2.47.3
>>
> 


