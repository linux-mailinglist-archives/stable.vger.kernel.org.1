Return-Path: <stable+bounces-253518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NhFLCf/DmomEAYAu9opvQ
	(envelope-from <stable+bounces-253518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:48:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146285A5191
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A56B301D069
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0C3C37A9;
	Thu, 21 May 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWeVFYMj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="If9iB5Pf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573953321BD
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367203; cv=none; b=X8F8rE3tdTQPiwecvirPpCVQocsFYZ2ZsqvRE0/l6YkbtuUTVerWNGTbsMwcq7JwZ3+JvjSi/LDAtDkExlKqR/0i6KkT/EOp9NJgW5lFkl8qhP3xEJXsAWyIv1DmUrTx0rbMnQeU+MaWSNYOip/MtFVnRTWunje9POXWUCnLEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367203; c=relaxed/simple;
	bh=lE5m9vKNKBhobwgtfEDX9vo4+fc7RBiEF/84RQgcKZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIcn5jYXy6A/rx2dKYwsWaX/35uw2EfUO0j7zfTnRMPAfymVBiTiU+QfRUyje2rZ6P0rGEZO+1xY54KvzrUJ7Fz/63ROuyDeGLiARMkJP6AgYuCwzQVjye/09+AH1fSOdu04EFkoLDeCYZBsxTBwZqnyeogVEt9FhvDeGVmmzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWeVFYMj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=If9iB5Pf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9ANZc1731294
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=; b=HWeVFYMj4PEPy+2a
	2Hzq4NalWUT/Twjbj35kS7uC1uIFTltZplcQgTb8C39PiRZ5kfNguz37s+q9OpfQ
	q7c7vvosyM6mO5n8mPh2i/DZdu9QL3vvVmPxJOrWYpzWtY8l86vZBUmQndvKwPDL
	mH+pW7LAUPCl3Cc0KXUbSju3987w6uMptiYEUFbtHXQArPcgPwYcCkJ6p3JQJfGZ
	mHUbBUO7N0WFwHuL8EctNwZgIVygHqIuX4H71ghjmi0c07ktAGkL1JKTeavC1MOz
	xwO3mTr5F7YeKwwu7T4wERma+X6dIW6xdcKrfLmQvGAwhtlSYvqE0GgfBlp3Pnp1
	dIbsSQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f5crn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:40:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2babbeff9e4so65800855ad.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779367199; x=1779971999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=;
        b=If9iB5PfuWVmvo/IRx5HfY7GapQnJXlyu1VPSxN/RS5Nqk26cY5tVjnqufPIJF3V8l
         51kQg4Oy5Y42R9FZZJ67TGxWg2cjhWrVGVTlr781P8yKlm0wWr/cDu3jAyoCH4Oc5T8v
         Fe+o0goak6olQIy0eHPqjHmF9wx0A29rOhTBZaUKICTV5W9krQ2r1TS77fYj3iKQuPZv
         OEwvt42OwtDP/rwZlgyVi7hZ79FGY18cUnvpWVs/ynKx2Fxx9jQg33UZiDxs150esyvY
         ef0Vqk2PXNUXLiivrXcD34kjAyKt33bTz+H282AFgAz8lObFOuVjQ9T/OC4YoOjVPYdX
         6xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367199; x=1779971999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=;
        b=AUq6d9eIPOj1CzElkEn/ceR+HL4q0Ls9MXYYQ+9peeNDcJsa9FdxFSNXWxDxngDWxd
         Tddov+CaNpZttP3zuFmcSGdtZvy8hs6yU3IbP/IVpaLEDGhurxXmgeXGBdkPxXi2jY70
         NJybiJ4crXhnhO8BOxglyxX0nDUsCl28npJJFsgvqCywIHIAG3pWkMrEyfnkexvgSZ1i
         yjSwPzy66zuXKGf5fhs0R2KZjmbFdz0BBALmXxKEXmlMVmXfuXklief1hfhIPdhqK+dz
         fEdlHmZCK1AeFfOK4CWEye0ERewmmAg+vL+7gRNSbPiIe/0stoWHW3MjA73G5dO2u+jC
         tFDA==
X-Forwarded-Encrypted: i=1; AFNElJ9txrX1QxGCFv5wLDE4NXbK4XvbZZB6+xXdcrq4j0b5GYQPyZbXAo9r9eyHvZKRQ4WWTSAofPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDZBtP+w1AA7OB0IiPOCWsKsByPTIvAxgeyoGKF6xHgP5mzTm
	1uYWudEd8M76/Pd4LwLh0SpIj9pJM9o6npdzGPiLC9o1pa1D0rYbzhFJ/WRExTqkks8/fh/tD6x
	5oZNVkbHuc6BIRSyru1j7FO8CI7JAl50tQmk/ORMRYR+6i/0d9V6CMEUJ9AE=
X-Gm-Gg: Acq92OGnLlYsblYjfPaPIXirJzCkMuyrqrpq4xht33zzoroauk4LW5eqW2zW3Z7kG9j
	pzH4ZLpMe7bMspBRkemHijGwfuzdwOMYi1oI2b4YRcpoTEvT54DdzdL1IEOtpYn/p7hDyArChkN
	P2PdDjsjhKNEMmRwgm7rh8PB28U6mOpCY1YoqQTe4YU7OFRMNf1cEbhRGgRuKGohSgytSvn2aUp
	TZ9ZIS3irgLZ1aAizkVXB68o4bYQX/4VcsVZk/WP/XyK4LRTul6UVoj0RSLo/YjxXNxMU68PVtS
	e3psoIMM/GnwlwLD18uleWtIvdtQmXlSfpTEH4BLfJBxQjIE5gSFKgyS6TWXPH8Yv2Ifg9XVNU2
	GlOaP/QhXwieLhzEZbRLoQ30Jf2dycgo70KaNryhOyWql0bZgftE9QPv1
X-Received: by 2002:a17:902:fc50:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2bea2641874mr28014325ad.14.1779367199271;
        Thu, 21 May 2026 05:39:59 -0700 (PDT)
X-Received: by 2002:a17:902:fc50:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2bea2641874mr28013965ad.14.1779367198767;
        Thu, 21 May 2026 05:39:58 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9289e05sm10418955ad.27.2026.05.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:39:58 -0700 (PDT)
Message-ID: <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:09:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
        Frank Li
 <frank.li@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Carlos Song
 <carlos.song@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
 <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0efd20 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=2tUGZl6TGnhxom4q2uIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: yJ_C6MvDbjDf2PJrczW4ldrBDFm4CXlt
X-Proofpoint-ORIG-GUID: yJ_C6MvDbjDf2PJrczW4ldrBDFm4CXlt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfXzjzMuZukwQT3
 LsrKm6lsL/ymbMRc5PsEbWrUaL/JB/bI0yE0sqyRp4NNGB9vyEcB5/Aho7taDF/T6qkiT1S8O8+
 aEWW5df6Ajy2cifpwfYjKjwfmgJ2c2WkqJY/4ZhrGfgMfG5zqACy0ZKbDjLuCb1dRGd46Ir21dM
 q3bLJJgF8V409FSah/bmVwM7RkSwS8fUKpHqdZaqqMwDRSiVrIp7uEh6lSegRbImL6pRtnHEf2e
 BbTJbF9tSg1mDTtrp6ZeZnOXftdOJk7r7JoeIrGi7fXS5mM4UdtT66mMa3O4E88b363hy1OJE8+
 y4rlURtKVExtnZ0wn+rJjZ8oYS5pHMoA3VozC/SbVCsoHTx3x6JddLlmeD+rpQ7BJmY4faNlFU7
 esAQZPdbQ/AvSQx7xyNB9oHj5eABlwsG4Yf/4s7JTPPGKe2cAVEdKQEwbLiOPufACDxRFtlEjn9
 9QI8juA7kHB+tj4uzJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.nxp.com,oss.qualcomm.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-253518-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 146285A5191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/21/2026 5:32 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 7:14 PM
>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; Mukesh Savaliya
>> <mukesh.savaliya@oss.qualcomm.com>; o.rempel@pengutronix.de;
>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
>> down
>>
>>
>> On 5/21/2026 4:21 PM, Carlos Song (OSS) wrote:
>>
>> [...]
>>
>>>>>> -----Original Message-----
>>>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>>>> Sent: Thursday, May 21, 2026 3:40 PM
>>>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>;
>>>>>> o.rempel@pengutronix.de; kernel@pengutronix.de;
>>>>>> andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>>>>>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>>>>>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>>>> stable@vger.kernel.org
>>>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is
>>>>>> powered down
>>>>>>
>>>>>> Hi Carlos,
>>>>>>
>>>>>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>>>>>> From: Carlos Song <carlos.song@nxp.com>
>>>>>>>
>>>>>>> Mark the I2C adapter as suspended during system suspend to block
>>>>>>> further transfers, and resume it on system resume. This prevents
>>>>>>> potential hangs when the hardware is powered down but clients
>>>>>>> still attempt
>>>>>> I2C transfers.
>>>>>>>
>>>> what was the reason of this hang ? I was thinking you don't have
>>>> interrupts working when client requested transfer but adapter was
>>>> suspended. Please correct me if wrong.
>>>>
>>>> And it would be good to mention the actual problem and why/how it
>> occurred.
>>>>>> Code changes looks fine to me but have comment on commit log.
>>>>>>
>>>>>> It seems, you are adding support of _noirq() callbacks to allow
>>>>>> transfers during suspend/resume noirq phase of PM.
>>>>>>
>>>>>> Would it make sense if you can write "Replace system PM callbacks
>>>>>> with noirq PM callbacks" OR "Allow transfers during _noirq phase of
>>>>>> the PM ops" instead of "mark I2C adapter when hardware is powered
>>>> down" ?
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Thank you for your comments!
>>>>>
>>>>> But this patch is added is not for support noirq PM callback or
>>>>> transfer in noirq
>>>> phase.
>>>>>
>>>> Okay, may be actual problem description can help me.
>>>>> In fact, this fix is to mark the I2C adapter as suspended during
>>>>> system noirq suspend to block further transfers, and resume it on
>>>>> system noirq resume. This is to prohibit I2C device calling the I2C
>>>>> controller after the system noirq suspend and before noirq resume,
>>>>> because at
>>>> this time the I2C instance is powered off or the clock is disabled
>>>> ... So I want to keep current commit. How do you think?
>>>> completely Makes sense. Please help add how this problem occurred and
>> why ?
>>>> So the change/fix will be good to understand against it.
>>>
>>> Hi,
>>>
>>> In some I.MX platform, some I2C devices will keep a work queue all
>>> time, the work queue will trigger I2C xfer every once in a while, but the work
>> queue shouldn't be free in system suspend.
>>>
>>
>> work queue has transfers queued even if system is suspended ? IMO, the client
>> i2c devices should not let system go to suspend.
>>
> 
> Hi Mukesh,
> 
> Thank you for the detailed discussion.
> 
> Yes, I totally agree that I2C client drivers should ideally stop
> issuing transfers when the system is suspending.
> 
> However, in practice there are many different I2C clients, and not all
> of them strictly adhere to this requirement. Some clients may still
> trigger transfers through workqueues or deferred contexts during the
> suspend/resume window.
> 
> Therefore, adding this protection at the I2C controller side helps to
> avoid unexpected accesses when the hardware resources are unavailable,
> making the system more robust.
> 

Agreed !

>>> Within a very short time window, possibly from noirq_suspend to the
>>> system actually being suspended, or possibly from the system starting
>>> to resume to before noirq_resume, this work queue will trigger an I2C
>>> transfer, and at this time the I2C controller's clk and pinctrl have
>>> not yet been restored, reading and
>>
>> Right, this kind of explains the problem to me. I think you are trying to serve
>> i2c transfers when your resources(clk, pinctrl) are not turned ON and also
>> interrupt remains disabled. And that's why you need to add
>> _noir() PM callbacks supports along with IRQF_NO_SUSPEND |
>> IRQF_EARLY_RESUME flags.
>>
>>> writing I2C registers causes the system to hang. This patch make all
>>> I2C operations are performed in a safe hardware state.
>>>
>>> Is it better if I add these comment to patch commit log?
>>>>>
>> if my latest comments makes sense against the issue, you may write
>> accordingly. if i am wrong, then your explanation makes sense. Cause of the
>> hang needs to be clearly mention int the commit log in your next patch.
>>
> 
> Based on our discussion, I have updated the commit log as below:
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>    - noirq_suspend and full suspend
>    - resume start and noirq_resume

- noirq_resume and resume start [Just opposite ?]

> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Does this look good to you?
>
Looks good, Thanks !

>>>>
>>>
> 


