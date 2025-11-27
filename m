Return-Path: <stable+bounces-197528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBAC8FEA7
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C3346998
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211B72E8B91;
	Thu, 27 Nov 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXlJnZee";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvsuagI3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1F2FFFBC
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267822; cv=none; b=DdYbwYMdrYSdM9yMUAZLxg7l6bklrmDvaZeCdbMP7jVQahejoYk/VFve08YBTGnh2mNSZ0gLQdbVwMGWqJ3Y6OTP6lVU4OBrIxeR8Nw/6yWS6Tc2jxpHdkLPQcqMV/mlcgWWXpigHw/afQfg4P3rcukZHEZpiprPWG6kvqx0nOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267822; c=relaxed/simple;
	bh=pGvZ5SattYYHOiHhfNEXrMAp3ftWVa2ZtWqec5muQN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZcdyQs22o3Q7gLoTVfigC5PA9DOigOqWRX3yCZ0jzkulVaPjBaD6tCZBLwuXI+xhRALi+yXcg2TOHfpZt1A83ufLJ+Cqtk3cERUZOn4o+2QYSBkR3QLOF2qY2dMFN55+7gF72U7PzrrwEoKwTaSkbo7AFm578VthjGsz9R/FjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXlJnZee; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvsuagI3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARA3a6j848530
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 18:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUchDNtUE84gJY1BIo7DyrQV1aOljy5HhZHPH/qoZ3s=; b=PXlJnZee5fix1eQK
	pWveOSQUVQ9grdsqlTkS+zIy108BabjuXjxPuOsqyiYBucii8BzrHecpPMnd4NAV
	HA86O6byF+UPp6aOC2fs9lZ645L31XPFcsiVeQd4mq5Jm7XXYF69pbdiRM35LBAK
	68wF9DNvKx/5KTdT6L8KkzYh/f7fZQLRoKVI0qHl4QQ9d2iJ96u6j8mH9Hi76nWO
	LFDmAQOhY5O5AGhbcnqPC3Rjn0aGEWLwIUOtmo4KZ6EjCSL9OaPVhtKysOBT+nYY
	fUkfAQ0aqW2WGgXnO0u/ykh4eXil64dYmtLIC3Rq8m5TlDr1qSONFDrh21GP9hRG
	1hQGMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmjd96pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 18:23:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edace8bc76so1803951cf.3
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764267818; x=1764872618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUchDNtUE84gJY1BIo7DyrQV1aOljy5HhZHPH/qoZ3s=;
        b=dvsuagI3vuPnHVUahwXkQQLIRKMAsQ8brhdflkTLxuRT43emA55l7pKWrCEYQ4cSEa
         NhbQkWQDQwkFzlST2GHATgzAH7SjiussP3S1rJEy/DJxLT+QzbRsdMit9MqEFCLKKbSg
         nAyxy9Dkq52IC8UgovtcaSI7AgscJJm679rwIuW2qU+b8nY7Z+Fnmmkp2ZQXznJlziOi
         HOUge5NvfGDt0cdnhLh2mbBJzSk5L/kcx0CszUnjYDZMgzJajapRhe9pQzn+u+xXXnPM
         +pYwAeRoqX/IVsdziPcAfR7FPCzKogxS68KBC6Bgdm4KgNxzTTVRlZtnadsusEZ3u4x5
         mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764267818; x=1764872618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUchDNtUE84gJY1BIo7DyrQV1aOljy5HhZHPH/qoZ3s=;
        b=YhQmDq/YDfY2Sks1FjOmifqkqAC2SyikpM/8mB3d4fTCuci17zbhZUR0SueD14kJNF
         M7Hy87TsA8gu6cZYUHS16UuXoeW2PZgdAXg5SLFJFaKE/rmeST+xMLhKg/GsfxlYIkxq
         bxyZbCRLUJ1DbqIOE5nnvlCsWOvmsyVApo8w2lz8hYBhr9RrXdXJvjm3yMWir9IUE8jQ
         zoR8bo1WOAfGPm/tvejRRzdGl1cHjCzHAI7qTwNGn4k/EsVpcKpEuFPprPUYiU5T6T08
         zZouhZp5MxT4mhbYKQDk2NLPspo7gWjswEZvjD/G5So97CDmt0TzWviLHtdNk5OoDAnC
         Kadw==
X-Forwarded-Encrypted: i=1; AJvYcCWMmGMPjtIZo3p3Gawlfe22I8VyMEUnRO2dOL4lQ5AD7c0GePweBVVqeb/Ki/Cvk10VGETdztw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdM/g10jB6KfOT7KjozFJFtX/amhm4uWUg0K9c7wX45MHQoa29
	Ea51Ouagbo+leU9OaYoqD00ATUpUmgmu9rhdJsHhZ5J48RIS5Tt9AjNFII4vQJsnzTyWXIfndMl
	pI9W8I8FowmeQg8djamtLoAQwCaTb1WbPzH9xZUj4o8MUrMbQmYgFzt+YulU=
X-Gm-Gg: ASbGncsj41jj2u7GMz6Jo+0CfO+wCYOoj8xS7wJXcHV1sH9L0oy5bntMgUs8kAWDmQK
	JzicDXubibYs8wsWhyxjEAw/eNMCdrbpa4rrqEozLw5G/nHINevkYhCdfUM/BRph0bMTPzxr9QJ
	/9qDNopiKpYtyxx4gMQQ02rgu16RhsEZpwW9coQ9HEIejys8e4NyK6hyJGmrRwIQFDKVINU4Jp9
	J1aO+Dmj0rb0nm6zzRLk5lxWUflBYAfjqeejg05Tj3Fs4sdfqQ2zEtegwKioHTiHIWZEKM0gfxb
	CWA+gkhJtXDiwEg2UIRvI+aYoeF3MnFSg48lEOIeskRwVAkf41bsJOR+o+DSByy0oRiEmBZ1d4t
	vqR2JUeURU/4P7i0j+Arvc3uTrC65LkUwOUOyEljX8rRB2Am+Y0v6DyKT2XqwLQCMXhc=
X-Received: by 2002:a05:622a:48c:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4ee5b786a91mr241585901cf.9.1764267818303;
        Thu, 27 Nov 2025 10:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFeMQ9EMbLd3D677mJIIOmwB+k9eDLur9GvtzjsK1+MSFnfAPwRig3yaBnk8ECV9phL4g1Bg==
X-Received: by 2002:a05:622a:48c:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4ee5b786a91mr241585631cf.9.1764267817872;
        Thu, 27 Nov 2025 10:23:37 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c3bsm2094550a12.19.2025.11.27.10.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 10:23:37 -0800 (PST)
Message-ID: <7f723f9c-93f4-43b2-8421-7af5f697c752@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 19:23:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix a7xx per pipe register programming
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
 <58570d98-f8f1-4e8c-8ae2-5f70a1ced67a@oss.qualcomm.com>
 <951138f1-d325-4764-a689-e1c3db12bb90@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <951138f1-d325-4764-a689-e1c3db12bb90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ApQYPClHrBD0XmSeAkpn9wD2cjrcQM8H
X-Proofpoint-ORIG-GUID: ApQYPClHrBD0XmSeAkpn9wD2cjrcQM8H
X-Authority-Analysis: v=2.4 cv=OPcqHCaB c=1 sm=1 tr=0 ts=6928972b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=6nOnMbRXApaOt5cKipAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEzOCBTYWx0ZWRfX5/QohChvRW9z
 aN3wXa2c+bqpMmpzlE09dgG1gsckuPyRwD5/GtMhqW5YH3g/YWA2rvVmZtP0R6L5dIIY5+3/Q5a
 SqjbDoPhBNjlpYVtzf5pqqpOw7MI2T5lwQhB9EocraKowc3kIvJRze/GS92O/XKAeLJWbEa8K0Q
 4YlS5cciYnR0pLAlPjAIYh/pCTWRAwPl9RnykQI3EACnGCxEqqBNTdhie6PkO0ZUDEI3aS61q8v
 Euk4qH6x9rFHXvZ3ClKIOZH3/PS8omYc4HInQOe6UuSjko8XEwS3HUcczeaW64qQGFDRRklzP+S
 JrSjenxqJ27zoAZswI7mMBJmw9hMHOz9Js55P1Wob0cGMOPt1Fd1vvyokTG0bhaXrlVqil1Afve
 qu6A+Nd1ELCkp0zALe9wfvTjj2HGkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270138

On 11/27/25 7:14 PM, Anna Maniscalco wrote:
> On 11/27/25 3:25 PM, Konrad Dybcio wrote:
>> On 11/27/25 12:46 AM, Anna Maniscalco wrote:
>>> GEN7_GRAS_NC_MODE_CNTL was only programmed for BR and not for BV pipe
>>> but it needs to be programmed for both.
>>>
>>> Program both pipes in hw_init and introducea separate reglist for it in
>>> order to add this register to the dynamic reglist which supports
>>> restoring registers per pipe.
>>>
>>> Fixes: 91389b4e3263 ("drm/msm/a6xx: Add a pwrup_list field to a6xx_info")
>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  9 ++-
>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 91 +++++++++++++++++++++++++++++--
>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 13 +++++
>>>   4 files changed, 109 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> index 29107b362346..c8d0b1d59b68 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> @@ -1376,7 +1376,6 @@ static const uint32_t a7xx_pwrup_reglist_regs[] = {
>>>       REG_A6XX_UCHE_MODE_CNTL,
>>>       REG_A6XX_RB_NC_MODE_CNTL,
>>>       REG_A6XX_RB_CMP_DBG_ECO_CNTL,
>>> -    REG_A7XX_GRAS_NC_MODE_CNTL,
>>>       REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
>>>       REG_A6XX_UCHE_GBIF_GX_CONFIG,
>>>       REG_A6XX_UCHE_CLIENT_PF,
>>> @@ -1448,6 +1447,12 @@ static const u32 a750_ifpc_reglist_regs[] = {
>>>     DECLARE_ADRENO_REGLIST_LIST(a750_ifpc_reglist);
>>>   +static const struct adreno_reglist_pipe a750_reglist_pipe_regs[] = {
>>> +    { REG_A7XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
>> At a glance at kgsl, all gen7 GPUs that support concurrent binning (i.e.
>> not gen7_3_0/a710? and gen7_14_0/whatever that translates to) need this
> 
> Right.
> 
> I wonder if gen7_14_0 could be a702?

No, a702 is a702 in kgsl

Konrad

> 
> If we do support one of those a7xx GPUs that don't have concurrent binning then I need to have a condition in hw_init for it when initializing REG_A7XX_GRAS_NC_MODE_CNTL
> 
>>
>> Konrad
> 
> 
> Best regards,

