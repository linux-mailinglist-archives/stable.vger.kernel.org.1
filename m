Return-Path: <stable+bounces-253499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB45KA7cDmrmCgYAu9opvQ
	(envelope-from <stable+bounces-253499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:18:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C25A3230
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55805304A786
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36837F754;
	Thu, 21 May 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2KqCiRr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwIjVE/y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77CA392803
	for <stable@vger.kernel.org>; Thu, 21 May 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358617; cv=none; b=RQ/V1fHOZ7oS578Y6jDLSRDAv8CMXVKVCN5JzPn9wLJiwZNn9S/+0b5HaH7N6qZJSVnDaeLQzGxIjtYa1jsjfXUIRyq03n5PG7mb6L/z2Q+ZF1J66E/1Wk8pbMzDei3MVy7D6ffuIezfLvyzKiQIsxIf33ABw160cbXlG7VvIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358617; c=relaxed/simple;
	bh=Z3KAG24ikGctN8+3JXxzF/QjpEQrkx80Kwtm6MVN8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRzwGqar5BzvbyCXwT43naXLFyrX1t1GEDfOnvIdyhnfi9Zgv5aLA/5k93BND7Fn71TIp6LnI/MZfpRr6zB9GYtBPtrPnWAsLafI58IjCJ844Iu0CXIWuFfKEhehP0CtQHl7kqPaT3sAiQqIYW8UY6FfJARTndOxkQnfwCD6RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2KqCiRr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwIjVE/y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99uMr3772831
	for <stable@vger.kernel.org>; Thu, 21 May 2026 10:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=; b=n2KqCiRrOQrxLNGF
	XgBkFgRwHC2u1RPF5a/auykres/jpwRgCdtJtROt6BASxFvKYL+Qfhju5Dz6F6mF
	G+hfxCHv85g3xPYMaJxNlfXoH284Ofwj0oylvJc4GpMK42w4Ykbi3bMFumP3dGVn
	Of3qQ/AuuJXJ24iKJ65BPO3IerbeKQ8W6XZEqt0Y4INWvvdUnzOxXDCSS5NQP9yU
	YQ1/YFvSg+qAsf+bIwNfhsp+QmbuH/pux4UglorAuGH+3KDIOePVZTWhcKI3rWkU
	Bgd5ipAhxEfTGDhgXs+/b86rAa6+H9YyBoLagFfCMGxmomgpsus3+zWqvMYiQ/zc
	cpABdQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42pxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 10:16:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so7621463b3a.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779358614; x=1779963414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=;
        b=TwIjVE/yZ9Fp+wDulH6B+hWohwEtI6luF53CsaofwIZMWhNc9Ff7bB0Wh1ts+xk5ug
         11kcFURop8LgtLM62/KCkkP2+OR48NgC4/7EZ3mI0Hhji+p3mncfbBqHT0yJjPAfkaWP
         gE4fPD7jJq+uU8n0imS8n8pJZ5IX7YEQuM6Vz9Jl5XvW1NZupkFSXGwnBujMBsQ4bZSk
         cHWtsgbDpUjPa7KDHCGX/QsntwS0H+tFTeoWCJowafiifROitrJkqSDsUQ07JHEpm1rP
         LZOvX8W331tvhX3lTkOL8SKeFSewCcqeXSElWCEOtTgl+SwWzvmdF63UiXIJmTI4MltU
         sMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358614; x=1779963414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=;
        b=LJRrzbaxevYG3pnpXmzpKItzPIUe97XQpLag42KCBbZLDGAKi2WRkfY3YaMz44x97Z
         HY/rih/xc7bkQe3H4o3dJc75NggZ33ys8NsghZhXWvZmgR+5JOhHem2hFo4e9/5K/1Ue
         GyVG3IVbbRl7dKHsBSxVTZ+u6F6a1UpPsgLS/psVmtE0tftxI3Pzl2UGYdQcRAcxVdZU
         Oaq2aNiKyVT/HA86oE12vB2bBzN9FoKS46AGv7JDfCMJym3qRBuJ2VpD12WflRCea1Yq
         WzzooitGQe+475Mb2xSfyR9NfSe32xQAnEfCSvyfXmjCWzqye8Uvi4MIqHolKLg1x6nB
         /HTg==
X-Forwarded-Encrypted: i=1; AFNElJ9awClzirSRisWpL6WpEx3nxLutYszzbUTA7SV2O1RWoKfOUaXJiHXgpvOTnliYnBu8tYG9+iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLcPZI8fUD7Y3YkYXZ5OWmDmLN4aOfgAkH4GElDhrOs3ns0Ih
	tWkqRzQzduwUxz3P5KGQAoEMf695kd+CPKaqPQfM/3UKdWQmO0tRFvn2FitiTUkW+zkz+vF8hOJ
	awhfHa1GsSVuAaHx+qpZD7NYvtp2GrwdLcHL1xtXZRksAvG5S8SkvPU0eHuYOp/kHf70=
X-Gm-Gg: Acq92OEb5B31cWZFOfKxoafvCEjfYWeTkuSMiRsufASUq1rZM+u/aCToFp0urWSSP4l
	etMlWJwRPMq8S8GYNwd0+loRkl5n2l0GEbWQsCudxA5rC/NXQUfcN+sxwNMXUAakEVxU/jXSNdb
	ueMROXVK45Ap5YuAYgEss79Dsi3taxdR23AwzkPkJ2e2ieQ5+wkLXZYq9ldS46P2S+4FuoFAHct
	SeG4pdIcHnKnnbUT8QhRyq/l3P0i+jYmbWCTaRfqBn9N3ZfsU99RRC26n08g/Z/5hjelWiscwa/
	uNTyISPpKLqqXVPIAPSRRyj9dDw7MJqG9WuIB2VN3bc4p6FVaQdcXswhctoOKMAdKo/HRBycbo9
	pRmPwqgv5lknm9uz5C8PTm/VR70Ze+iLOUDcHg6f8qf+1VVTosSXoJxEO
X-Received: by 2002:a05:6a00:330c:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-8414ae6e041mr2501846b3a.33.1779358614186;
        Thu, 21 May 2026 03:16:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:330c:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-8414ae6e041mr2501811b3a.33.1779358613617;
        Thu, 21 May 2026 03:16:53 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e3d6a7sm997070b3a.55.2026.05.21.03.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:16:53 -0700 (PDT)
Message-ID: <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
Date: Thu, 21 May 2026 15:46:47 +0530
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
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0edb96 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=_EeEMxcBAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=yJUUZN2m8lq9mbh6i7kA:9 a=QEXdDO2ut3YA:10
 a=czjwGCTIUPoA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=ST-jHhOKWsTCqRlWije3:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: _RGSb7HIULt22rEgI1kmp8eCTTvqjAVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwMiBTYWx0ZWRfXxEDN5B/paumP
 DIJXYGxuI4wS1woWCsup5jlPw2p4dFfjyS6oncumzVUJMojNJGcBO97q6rspao6NGYY/S4f1K/3
 U4OHglaOFacJLS5386EWsCWzYup2pc84F9eRAsy/LyIH68Ru/kgEbl51MKXZHpymJMBg4wShVFG
 KNFERuQl3+MfsjRVEjU24wCYKwIYKwKv8RTAE7w/ZiFANz2aSYq0VCpKTUFFGaPo8Aw10MQsozu
 VuE4Y9mniHsv+qL1VMbB3ksT2b73z8A2hs7mjfQBp2X1Hzg7wMIKxj2fg9hrTpiC+V0jiYNHeTa
 z5FRRKTX/XTfwngxKD0M1wM3tzeSu90Opa2X6RD8OTSv9c764F0FtonHlPLFxnYvKNk0eLYKUMK
 yC7Ahu1jLYEQ2JqmIwnflhcUuwq+7vvnnAwPwK5mK0SMY0bgtj4bQW4vmPOktuChnTeca+sYEoj
 wijPvHkHVFC8k0+d3Xg==
X-Proofpoint-ORIG-GUID: _RGSb7HIULt22rEgI1kmp8eCTTvqjAVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210102
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253499-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,oss.qualcomm.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 165C25A3230
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Carlos !

On 5/21/2026 1:57 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 3:40 PM
>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; o.rempel@pengutronix.de;
>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
>> down
>>
>> [You don't often get email from mukesh.savaliya@oss.qualcomm.com. Learn
>> why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi Carlos,
>>
>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>> From: Carlos Song <carlos.song@nxp.com>
>>>
>>> Mark the I2C adapter as suspended during system suspend to block
>>> further transfers, and resume it on system resume. This prevents
>>> potential hangs when the hardware is powered down but clients still attempt
>> I2C transfers.
>>>
what was the reason of this hang ? I was thinking you don't have 
interrupts working when client requested transfer but adapter was 
suspended. Please correct me if wrong.

And it would be good to mention the actual problem and why/how it occurred.
>> Code changes looks fine to me but have comment on commit log.
>>
>> It seems, you are adding support of _noirq() callbacks to allow transfers during
>> suspend/resume noirq phase of PM.
>>
>> Would it make sense if you can write "Replace system PM callbacks with noirq
>> PM callbacks" OR "Allow transfers during _noirq phase of the PM ops" instead of
>> "mark I2C adapter when hardware is powered down" ?
>>
> 
> Hi,
> 
> Thank you for your comments!
> 
> But this patch is added is not for support noirq PM callback or transfer in noirq phase.
> 
Okay, may be actual problem description can help me.
> In fact, this fix is to mark the I2C adapter as suspended during system noirq suspend to block further
> transfers, and resume it on system noirq resume. This is to prohibit I2C device calling the I2C controller
> after the system noirq suspend and before noirq resume, because at this time the I2C instance is powered
> off or the clock is disabled ... So I want to keep current commit. How do you think?
completely Makes sense. Please help add how this problem occurred and 
why ? So the change/fix will be good to understand against it.
> 
> Carlos Song



