Return-Path: <stable+bounces-127324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0FA77AED
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6186A16BABB
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DBE202F7B;
	Tue,  1 Apr 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShzPhrhb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF81202C5D
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510377; cv=none; b=X62wF84lLVDQ/3Uz4eNZE7S1t3/saH3HHfIsURmkmyEiIlZF5pB/fRsSGqiLLuppzrGhEFH+nKU1jtnx6p9lsqd4BjNMdXUCAywGJgFLVY7mdxRMUDGEhQSzMkKKlRDGAyVDTdg+pUka4kC9yE4X0Fk/7UKvuZK63J/1rXLbMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510377; c=relaxed/simple;
	bh=MzWbRRs8pa6TteDFhTWSEA05fml/aRf6VDr6jSrrhl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwkWv1JiwkPQF+vzD1HhBdD7kKUcGwOquYFNkDe8gBtsLHME04SzmEb6bZIcPgJpmdUlLSdr8VLbOjWLMu0FA+5WPcozie2ohHSC7ZlKTLyARJnHIZq5+QzNIvPqbJ4alsVPlkN8bbL+ih00GxBamOgZyeA+o6yoPoH94XkPgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShzPhrhb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5317MvJH024962
	for <stable@vger.kernel.org>; Tue, 1 Apr 2025 12:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5IelXbw1nz5rkiuUSMs5w3F2RL5AE5cDWJplubtFH4=; b=ShzPhrhb00ncAYyG
	gmU8r1cR9cGillA+SR52rm3c4D4g/iJoAAnLH36M4LWWT4WlCF+f2vIjQkhWltZD
	ObZo835RPeQTEacjukwOK9BTXYmCtVY58MbtJPDlhmXTEj0rLb1ep3HAb2P9WsV3
	a2XZwOInITmHLO72EX7+Wpod2jVbitk83jAIX1YSWaCg20HI8ZUa8QzNeECxMHNN
	mmJxSTWH5a9fh2mI1HBoQbe+lhX2TJsZ2fDEOAIUztG9ZIG3ktKNoM/9gMkzsf2Y
	6avmjNs5Ob5Ey+uKeierob7lF6zcSi5kdytIk0D7mk8Pvsccfh49VH7/lXQ/Gvh/
	GSrw6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpys0yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Apr 2025 12:26:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ade807fso1590745ad.2
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 05:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510373; x=1744115173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5IelXbw1nz5rkiuUSMs5w3F2RL5AE5cDWJplubtFH4=;
        b=bLkOJeqoYn9odX4iNfNcR2TtYlhi0kc0t4jbMpU9jzOk82+kCfU+1rbJAFlg3JWmDP
         Lyt8jb5escsHJtwNDgDJcAS2PDjULjOoRRFkA1I9gcqoXZ/PoKgROOqUhLEeuGX5mKm/
         fuJroBLuNwWI9bONf6yTdOY3nQYDaiDr+opRnMLxXqywE69M/K0pEgv4ekMrvD15DoK9
         G2ludWWDqfOmXR0H1BL3OnRiako5/fXulxGRLmwKpJaiOcvSQ1CC3fK77K+vKrO1KitA
         d1FaTE4OJxnE15JLx3iDnEdpfQnhO04uwTeFdGnsFiMdCey3n8KuQxQCGQbpMlK7de1c
         aP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFfpYPyw8umk/HH1uiNGWdLHsrhlhB+oq3uFe5HtyaqrOmJCRHfPW5XOCTlBpMG+QWjdZCk2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rbagQ8QB9x2OqV8bVlTavu9A9suwYiK9+N9J/MOONgMF5aXa
	HP0Irr/Liy1rKch/Ux1n7RT6qsfl59QHK5WQMnMFqzkMmzkobj9esmTDpmccU7blWm58rbeFC/N
	fbY98dHuZCk5WpVfWcIlhMVei0TGE7rkEswXah3YzT1OBRBkc9t3rYEc=
X-Gm-Gg: ASbGncuc2Lajguj4C7vbjKhP/lursAv88gsx2gsBcPKJU/4p4I2nMsZRS6cNseBUQTn
	uOL1fQfph5MvnqBSoaivhKVpTSc0MaknCxbvC9arKK57MCiOblnyAOjJvFbMx36Z2GJ7eTgk76K
	fzMqywGuai8lkCskkEZRqrTndQJLfQxHT28TFutXvvegYyCjv0VpbX8VxxGksvNaAXgJlVcUBTJ
	sHWXPaCb1RH5ATvvEtmICVasgUFqzYuNMqYLs05rNQoue8M1+c5FEJzVzGzOKZfU2FH2pu+2kzd
	YlPt5UUdlIUay2VUSkKRVa0kq1sjwxJ6rVV3RK0SEfpdpl7IdUhN5NE=
X-Received: by 2002:a17:902:f709:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2292f94a1aamr166788325ad.6.1743510373141;
        Tue, 01 Apr 2025 05:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF913CZIgF3zF0FHk8m4BOSMaMjEn/F31BODeWH5rl8fQt/hKYO7T1Pweu6BZVIgOku/ZpQDg==
X-Received: by 2002:a17:902:f709:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2292f94a1aamr166788065ad.6.1743510372745;
        Tue, 01 Apr 2025 05:26:12 -0700 (PDT)
Received: from [192.168.31.128] ([152.59.239.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cec2fsm86789825ad.117.2025.04.01.05.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 05:26:12 -0700 (PDT)
Message-ID: <a1ccb48d-8c32-42bf-885f-22f3b1ca147b@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 17:56:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
To: Frode Isaksen <fisaksen@baylibre.com>, Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Frode Isaksen <frode@meta.com>, stable@vger.kernel.org
References: <20250328104930.2179123-1-fisaksen@baylibre.com>
 <0767d38d-179a-4c5e-9dfe-fef847d1354d@oss.qualcomm.com>
 <d21c87f4-0e26-41e1-a114-7fb982d0fd34@baylibre.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <d21c87f4-0e26-41e1-a114-7fb982d0fd34@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AsNr66a_sALwf0kSLNc2xuAjmxX-kaiN
X-Proofpoint-ORIG-GUID: AsNr66a_sALwf0kSLNc2xuAjmxX-kaiN
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ebdb66 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=v/fl2IxmdEHBtBzv4ytVIg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=VabnemYjAAAA:8
 a=EqO8uaqlcL3FtOQN4IAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010076



On 4/1/2025 5:38 PM, Frode Isaksen wrote:
> On 4/1/25 7:43 AM, Krishna Kurapati wrote:
>>
>>
>> On 3/28/2025 4:14 PM, Frode Isaksen wrote:
>>> From: Frode Isaksen <frode@meta.com>
>>>
>>> The event count is read from register DWC3_GEVNTCOUNT.
>>> There is a check for the count being zero, but not for exceeding the
>>> event buffer length.
>>> Check that event count does not exceed event buffer length,
>>> avoiding an out-of-bounds access when memcpy'ing the event.
>>> Crash log:
>>> Unable to handle kernel paging request at virtual address 
>>> ffffffc0129be000
>>> pc : __memcpy+0x114/0x180
>>> lr : dwc3_check_event_buf+0xec/0x348
>>> x3 : 0000000000000030 x2 : 000000000000dfc4
>>> x1 : ffffffc0129be000 x0 : ffffff87aad60080
>>> Call trace:
>>> __memcpy+0x114/0x180
>>> dwc3_interrupt+0x24/0x34
>>>
>>> Signed-off-by: Frode Isaksen <frode@meta.com>
>>> Fixes: ebbb2d59398f ("usb: dwc3: gadget: use evt->cache for 
>>> processing events")
>>> Cc: stable@vger.kernel.org
>>> ---
>>> v1 -> v2: Added Fixes and Cc tag.
>>>
>>> This bug was discovered, tested and fixed (no more crashes seen) on 
>>> Meta Quest 3 device.
>>> Also tested on T.I. AM62x board.
>>>
>>>   drivers/usb/dwc3/gadget.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 63fef4a1a498..548e112167f3 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -4564,7 +4564,7 @@ static irqreturn_t dwc3_check_event_buf(struct 
>>> dwc3_event_buffer *evt)
>>>         count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>>       count &= DWC3_GEVNTCOUNT_MASK;
>>> -    if (!count)
>>> +    if (!count || count > evt->length)
>>>           return IRQ_NONE;
>>>         evt->count = count;
>>
>>
>> I did see this issue previously ([1] on 5.10) on SAR2130 (upstreamed 
>> recently). Can you help check if the issue is same on your end if you 
>> can reproduce it easily. Thinh also provided some debug pointers to 
>> check suspecting it to be a HW issue.
> 
> Seems to be exactly the same issue, and your fix looks OK as well. I'm 
> happy to abandon my patch and let yo provide the fix.
>

NAK. I tried to skip copying data beyond 4K which is not the right 
approach. Thinh was tending more towards your line of code changes. So 
your code looks fine, but an error log indicating the presence of this 
issue might be helpful.

> Note that I am not able to reproduce this locally and it happens very 
> seldom.
> 

It was very hard to reproduce this issue. Only two instances reported on 
SAR2130 on my end.

> Where can I find the upstream'ed version ?
> 

The upstreamed version I was referring to was that SAR2130 DT is present 
on open-source.

Regards,
Krishna,

>>
>> As per the comments from Thinh, he suggested to add a error log as 
>> well when this happens [2].
>>
>> [1]: 
>> https://lore.kernel.org/all/20230521100330.22478-1-quic_kriskura@quicinc.com/
>>
>> [2]: 
>> https://lore.kernel.org/all/20230525001822.ane3zcyyifj2kuwx@synopsys.com/
>>
>> Regards,
>> Krishna,
> 
> 

