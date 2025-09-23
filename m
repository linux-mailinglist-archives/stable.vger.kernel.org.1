Return-Path: <stable+bounces-181457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41490B9553F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD5B16DF94
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99B320A20;
	Tue, 23 Sep 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fVl7NUrb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC30258CF9
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621150; cv=none; b=c0fSr2GDvrZK69SxsU1Ys9t6uwj/npZUjuoo8umjM8CF654wSX1soSYwLWym91LMU0ktkGxdV2XshmqpKLLNfe8mnhYVMlrOuWxmfexK7iGHxGC2Az1GjBrzmyK3oljqsvGXbboCpcbRIW+KIfStg3KmLvnEaAhqm3p28U958uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621150; c=relaxed/simple;
	bh=8Y73+bRj+HMBGZXn1NTOY5Q8D/DFV73lTcEAvuOEtZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L31NlzVyEZjhjQA5I4Y7API3qS/QobqK0xJ0esdZEIxC/JvMmL491dL6XWN+t1h07XiAOw6tqHmSG/wjRhoqykOJjqGq7+DqwKdgNXzHL0n4RzS9tI9HHwTyaAPoXNekZLTxRENoJDjo5HLO6dD5Nxh5TkyNYTgM+wti1lC7BCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fVl7NUrb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H9XA006658
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CegpNU3wlAiMj7j/j0CePi4xwfyVk7zXAv3zhvKqTRs=; b=fVl7NUrbE3JXkms6
	Bzkh6wugOyUoigNqqv0syV61yThZECW1Z2EaA1fHeLQuiEl9CqvO8u5IIcMmMgFU
	ZVjhv7WLf81S43eOvrAXwb/QzK4nnthbM+OWpM2MoCjLO/j4AKthjd9kX6ls3YXM
	MTmaqY1qhamdGnkvpRoVfvs7TQz8f9tzRyxV9UlXjgao0LRk7PLuv/jmnLakxUNt
	oj/66A1z2UpRW9P000f6UniX30My3CaYJsQjmF3Um11O8NxjWq9ni0D/mk+vBToD
	717a7Cw0SyX+S7W6o9zPKtO8iCLzHU+wBRJHC5P5ZMZL/xecCVYDboqloDFrCOdJ
	0RDNAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kkhr5y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:52:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2681642efd9so45157355ad.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621145; x=1759225945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CegpNU3wlAiMj7j/j0CePi4xwfyVk7zXAv3zhvKqTRs=;
        b=h6jFjeR1LCbJeD6LIaz6HhS421OJ/XZ9KbCpZNgLJedYSiIqiFbub8lZTs0EvMHwMd
         WTBABs2np1DN1KVxr4rQg4tpcx1Od1jC0w+e9uPh2VVG/MRVVX8iFV5OoYOyYiCkrQH1
         jOX74aX7FYStVOkaEk6uKueyqZPomMskAbpGcXqmiZkltIFPfP6aA1EC20rOn/Zd/hgG
         xQPZD5A7K4Va4JNOSCh3/Mls984tn+q0+BT7IhK+WOxyVyD6iuFL/GPdPhgCj6mcCDWq
         6LTGwMxJHmmZDsedjMMwsqB6w2mUwXPNM0cWz4bHZUWtwu+28LDKAfvUswRMrKnC18ib
         tBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/1KfwKEVLXJIF7b9g/p3rm0euYm931TzZLCgVd38sOE8yICIzKZd2O7qgGHn38aLWwTETfnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Oc/vMpY2kDdJuUnL4ShhSKo7g9b7F8e5BxArLeKKHxu77kpb
	LlNZvXBPC5t7lL3op29CVe/cHwYMmggpM4Z3NEMHc2aRL1lrnFhoMewERoE1FwrxDNEdm5htd3R
	QCQYDbjmwewcbhlcNu6+FD2WffaXF44hqPy9y6SdScmGn9l0z3pvR4TtTzr0=
X-Gm-Gg: ASbGncvIO9KIrqbbQx2j5JUdsjfkBPClOk/cwlqjmzvL0Wn1bTyBu2wEh7OtvG+wFZp
	FX+wDbF7I6lFosD7T6hSigQ8PjQuuEgxrmXIg26qNdJSfoMQgUw902P5bmw8Pk1CMrShXYt2Jqq
	022k+UGQI9LLKFAuby0qPkMdKASN+u3JRwvWvvMnQ/pn3sY4SKHWWeFxfeZhGzAOAKb8vgQNVpq
	tTE7sJy5A08rDZZ5jrF7kQCGm0drrjMMsyKKd4JEKAocTX4Ju1YKs08NW0Ozg13ETTVcvskrgJv
	aTykgZkvVc0imiMLwoz/up5HvxSep77Ly1Wgc0rZO2XqQ7rVXdfjKnjj/412b7SsnKCJ+nVeTeL
	GLacxUbTtVvUus2YgFru2M0o0wnGMZMQ=
X-Received: by 2002:a17:903:41cb:b0:27c:56af:88ea with SMTP id d9443c01a7336-27cc817c4b7mr23923765ad.60.1758621145229;
        Tue, 23 Sep 2025 02:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP5zMBkrF08Ao4U6Os7ZL705YRef6kuCngGJ5bzt+iMXV5WUnMZRGIdXtBk5rCzApJtyTFig==
X-Received: by 2002:a17:903:41cb:b0:27c:56af:88ea with SMTP id d9443c01a7336-27cc817c4b7mr23923575ad.60.1758621144732;
        Tue, 23 Sep 2025 02:52:24 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm157677485ad.93.2025.09.23.02.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:52:24 -0700 (PDT)
Message-ID: <a8ea8358-29f8-406d-8854-e5adf67a4131@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 17:52:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Fix potential null pointer dereference in
 pru_rproc_set_ctable()
To: Zhen Ni <zhen.ni@easystack.cn>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, stable@vger.kernel.org
References: <20250923083848.1147347-1-zhen.ni@easystack.cn>
 <f6df1f13-518c-418c-b631-cc9452ea4842@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <f6df1f13-518c-418c-b631-cc9452ea4842@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3GkvIXClcC5xvFfmZO-kVAw7ZNsGAXT0
X-Proofpoint-GUID: 3GkvIXClcC5xvFfmZO-kVAw7ZNsGAXT0
X-Authority-Analysis: v=2.4 cv=JMo7s9Kb c=1 sm=1 tr=0 ts=68d26dda cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4y7FVnu2TWKiiZhurccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX8IwQdyjNX6Pj
 iW3CmQT93QVPi9hHPGV1OErL7SM6QLWRmLd2Za16ykn4N/esqXc8foivKT09HgP0j9iIyH+KPyr
 vgBjRkHDXJFtLyZVPQidfl/79MQbW473L9XJGD1nAosnz/5k+mBcadpAkwGOO8OgFOuHjgxdRE5
 WUOUOt4MOUq/B5/X25le1sftcCL17rMOJz0HGEC4LRpPgQireNfZiyYvO2c2wTZqm/sYGjqmLEd
 IE1/UV4Q8lz5mYd4oob/RIiv6TYQQdjdT3SZp1BEzU7IUzxMibbh5s2C6marp1vEjEayL9hcuB7
 obh96wcSRhj/eCMYsntIp40bCP6hux+PJCZsPtLoOmeH77tsH1oawWA+vbVgBJMmOrX6XmgBVjb
 P7PWDyVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022

On 9/23/2025 5:40 PM, Zhongqiu Han wrote:
> On 9/23/2025 4:38 PM, Zhen Ni wrote:
>> pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
>> check, which could lead to a null pointer dereference. Move the pru
>> assignment, ensuring we never dereference a NULL rproc pointer.
>>
>> Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() 
>> function")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> 
> 
> LGTM. Minor style suggestion: consider changing "null" to "NULL" in the
> subject/commit message for consistency with kernel coding style and
> terminology.
> 

Also, for consistency with subsystem tagging conventions, please
consider updating the subject line to:

remoteproc: pru: Fix potential NULL pointer dereference in
pru_rproc_set_ctable()

This makes it clearer that the change is specific to the PRU driver
under remoteproc.


> 
> FWIW. Please feel free to comment or override if needed.
> 
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> 
> 
>> ---
>>   drivers/remoteproc/pru_rproc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/ 
>> pru_rproc.c
>> index 842e4b6cc5f9..5e3eb7b86a0e 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
>>    */
>>   int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, 
>> u32 addr)
>>   {
>> -    struct pru_rproc *pru = rproc->priv;
>> +    struct pru_rproc *pru;
>>       unsigned int reg;
>>       u32 mask, set;
>>       u16 idx;
>> @@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum 
>> pru_ctable_idx c, u32 addr)
>>       if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
>>           return -ENODEV;
>> +    pru = rproc->priv;
>>       /* pointer is 16 bit and index is 8-bit so mask out the rest */
>>       idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
> 


-- 
Thx and BRs,
Zhongqiu Han

