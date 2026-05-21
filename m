Return-Path: <stable+bounces-253508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O8vEFvTrDmoFDQYAu9opvQ
	(envelope-from <stable+bounces-253508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:26:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8805A3FEB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 389113158CF5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4133BB10B;
	Thu, 21 May 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTwfCwhl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcpNLLoW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597E3AF672
	for <stable@vger.kernel.org>; Thu, 21 May 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362084; cv=none; b=eTYslH+RvgZE19wb1gyj5HL9qnHpS/bVDRzE2VGg51A5xpz2Yj5pP8qpI76udFBPR92OqJ2BAegf/G8bUBhV3SjJHQ2h2a4YNp39I/Aw8nxNJB25NH9tSGhTKzecwxiRBhY47v0mWRTabGc8dSmRacig6KB/GHhChPe+LmeCfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362084; c=relaxed/simple;
	bh=C1+cFaPFiKE4mgAzSG1N6mY7diKK/o7fD03Nl3zE8aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gd/CnLnaGRLXbPICeLHS0Ra5aD5vd+eGPlEMTvvCvE3IZefhv16UCohdaPabjUMW1JQUeItuJEsGTn3G3Lfca2lJZahhj8jYrL7MSN9ttNozxU67mAASxXwNgMmQYgNOQ5ObrHO3l/bVqvhxOrPSM9HQcdyfBCE1TYUYlu2s+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTwfCwhl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcpNLLoW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LAXqv0818809
	for <stable@vger.kernel.org>; Thu, 21 May 2026 11:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tgpvgnbwwr5UBe0lC1Mf4Vi2XM398nJ8kTHxTpFW4hU=; b=hTwfCwhl2SgL0Wi+
	/3yR49gIx/qT/qSo6EoxcIIlIv57BYlUishzWRZF2eeSUFTQ9ednQUI2SNub7Rip
	T8y3d+dzx811r0WU9fctsd+AMTU6lzMGur06QgZqwn9tqzM5iyx5FqAdg0nsSZSP
	MhCdyhaFj70KCut7YTkKuPahd09yU2wfkVBOhvyu6bqRja7ONA+/xoNqjFOSEtfJ
	K4ouj469BhQnYqSu2rmV298PfAp1TjXDDgrCvGvDQKq0V0NspZk0NE9hHm/tXDUh
	xSRLSb4NyGz6lwHIruHnMlxeHLptvtK3vsC3JUuUJl9uGvlqRQmCbVet4hTmMUD3
	FvhBPA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkg4b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 11:14:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso10816934a91.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779362082; x=1779966882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tgpvgnbwwr5UBe0lC1Mf4Vi2XM398nJ8kTHxTpFW4hU=;
        b=UcpNLLoWCZJLP0hPxWaEw04BjdJAY+2rPWVvqoIxpdikZeRgDjE8BUg3R49eB8BylQ
         m+5TbkXnXXlRM8WFe1BlvuARSXnKEVcNwU4adWm5df5LJuolY0OZAcIToPamdOpJJupL
         KQi3dsYHO52/rrBW/XhLc2GZIZzreRV1C+tb2O6BQfqObZbH8z3MaYAzik1oBE9IRcTN
         NwFPxYxBKb3V7Zb3KwcrjgXfH2U4F+FiQtIFsZWqrtKCg3LiIeSx6PWtUXC5G0KQvm88
         O1y7gv+c5/C9uEXBQIPAj19EmSts0KZp5dDV6Hg380I4CYg0OU3BA92aYYNckcNSzp7L
         wyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362082; x=1779966882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tgpvgnbwwr5UBe0lC1Mf4Vi2XM398nJ8kTHxTpFW4hU=;
        b=hwATIDDntObX73Dfd8nNot0xX2toMJHoTyS+51YKFvxBsXkLpxMx/JVNtjKJ7U5H3K
         7apFqEF8uVxHT7OjjYn2J7bSSkCffSwDGNC9hiqi8ZfqL5MJL2vAEZoCeLvSovjkcvtj
         VM3SjYHUmBf5s+/Gi7n9/nCgHJii487x6231LMMRE6Ad34+PJ32WEgbP9iHKzDqATbHb
         qBhAypVmdxBVL+/SPUuHxqc+nW/NIrp0KuC86E3Ul6L3lZyjLqVrZeNkPfZsrqotKxqu
         FHMPdE696aSKTSJSTa7M5bp0nM/r6k2OuuHFaZ7vDcWDxP5jhLKt2t2m832Vy1XZkIwy
         SytQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kTbttC6dmiQ2ABq+NQF+pVqLafpfkAQ9VnDqyd2ncyXDy5MwEAoug78HbaCQJ3IDjrVfIq8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQS715aZl1JAsc2O8Y3JZORQj24WIFI2slwLUZ95ilMmPFLV5Q
	RiBEJnKKJQ5NkkHkOYjsW1M3fhaFIG+CQWanZ2FdflPipA8ytAZbv1y8kxrYFNyRCJbE4KqiiYw
	GpZmnnj5SJ8B6k2WcZQxeg1YrxlIeWKkw3P94cMLc4bSWJLNU4WdzrDcBSsw=
X-Gm-Gg: Acq92OG/+nL0zZEq5PPnXupiCKl50Ul3NAsGOdbNE8v8mrIofGh42QLkpo+zwOxHyO4
	v5TqATs1X2/bwesOuqO6A3v7Y9boHBB2oHxz5u8u1VoHkCtlglf51rvMgWd54wyXX08am2GRCKs
	7dfWBo5Xtgpbecn5UGtIEjg1IE5V/VRDy09olhNzaeAd5kzn+U4oGpnhdt/VUVqbNalAUet27Za
	jhffw5Qa4aOyFSWl0BfRugAfw1h8IFDiicTDxMfj3XZmQQ0m207INyxjNUi56NVI8qOvUBwIm8u
	px+OdI7LQNQ86vCrFl2CiM378FNxW4YV/L6WCpqME9lx6xgC8AZEKfg2sXTeWZTSN82iT+IjG1Q
	GxWyahfA5DxglPwzuidRby+lY6PSUyOa7WkGPzaeFcwdqzFzgM/mKF5xs
X-Received: by 2002:a17:90b:514b:b0:369:d22:4788 with SMTP id 98e67ed59e1d1-36a4575d7bemr2644416a91.25.1779362081599;
        Thu, 21 May 2026 04:14:41 -0700 (PDT)
X-Received: by 2002:a17:90b:514b:b0:369:d22:4788 with SMTP id 98e67ed59e1d1-36a4575d7bemr2644391a91.25.1779362081192;
        Thu, 21 May 2026 04:14:41 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a5ae97051sm536922a91.0.2026.05.21.04.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 04:14:40 -0700 (PDT)
Message-ID: <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
Date: Thu, 21 May 2026 16:44:27 +0530
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
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExMiBTYWx0ZWRfXxNWX0+zYnI9f
 9bCXAlLUgVpCSc21wuNF1wcFISbB+7EYZWUX20uvv47EzVlIZPOqW/ZnMFDnDVbVblDJcBMAxGJ
 bv2Ftz3acu3GPA5qCoDycnwqZhdQiG5l++MVVCNWO8xwQP3AybAPLSJTcubqt+rWV6aS1IN2AU6
 FtmtIdxSDMv3qsqSbj5tfMCjUtGo19h+0Xs0ZmcSq8N5gq2sgFQviXtpcUazHYPBjhCm6/qXoDA
 FO/2NKhONs8tbPNhiN/7DQ+dtYSyvFbf2J5IKoJOFqnHOFgkezETj2Uix6hdDua4e7pDsq575pm
 0YKaJrpAeaRFEbZhNxRVxwEGDFisO5S1dtKXiAek2aHgDujcfHAV93+uEn6+i8nBj4UwFBw1Fcj
 yEJHD5Ipe/A4PmP2C6zI4Cs2PGqOK0fYG0/K+h6djfe3UFPt/o1ALLCp+ADp5jK21TZZfyrqU90
 4imNewhtGauSkVTuyYw==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a0ee922 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=5_mVXZLGvQfHWcJsArQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: MLWAFT67Qyjpt1qJ-K1V5FOFp-h8F91M
X-Proofpoint-ORIG-GUID: MLWAFT67Qyjpt1qJ-K1V5FOFp-h8F91M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210112
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-253508-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,oss.qualcomm.com,pengutronix.de,kernel.org,nxp.com,gmail.com];
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
X-Rspamd-Queue-Id: 9F8805A3FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/21/2026 4:21 PM, Carlos Song (OSS) wrote:

[...]

>>>> -----Original Message-----
>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>> Sent: Thursday, May 21, 2026 3:40 PM
>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>;
>>>> o.rempel@pengutronix.de; kernel@pengutronix.de;
>>>> andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>>>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>>>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>> stable@vger.kernel.org
>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is
>>>> powered down
>>>>
>>>> Hi Carlos,
>>>>
>>>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>>>> From: Carlos Song <carlos.song@nxp.com>
>>>>>
>>>>> Mark the I2C adapter as suspended during system suspend to block
>>>>> further transfers, and resume it on system resume. This prevents
>>>>> potential hangs when the hardware is powered down but clients still
>>>>> attempt
>>>> I2C transfers.
>>>>>
>> what was the reason of this hang ? I was thinking you don't have interrupts
>> working when client requested transfer but adapter was suspended. Please
>> correct me if wrong.
>>
>> And it would be good to mention the actual problem and why/how it occurred.
>>>> Code changes looks fine to me but have comment on commit log.
>>>>
>>>> It seems, you are adding support of _noirq() callbacks to allow
>>>> transfers during suspend/resume noirq phase of PM.
>>>>
>>>> Would it make sense if you can write "Replace system PM callbacks
>>>> with noirq PM callbacks" OR "Allow transfers during _noirq phase of
>>>> the PM ops" instead of "mark I2C adapter when hardware is powered
>> down" ?
>>>>
>>>
>>> Hi,
>>>
>>> Thank you for your comments!
>>>
>>> But this patch is added is not for support noirq PM callback or transfer in noirq
>> phase.
>>>
>> Okay, may be actual problem description can help me.
>>> In fact, this fix is to mark the I2C adapter as suspended during
>>> system noirq suspend to block further transfers, and resume it on
>>> system noirq resume. This is to prohibit I2C device calling the I2C
>>> controller after the system noirq suspend and before noirq resume, because at
>> this time the I2C instance is powered off or the clock is disabled ... So I want to
>> keep current commit. How do you think?
>> completely Makes sense. Please help add how this problem occurred and why ?
>> So the change/fix will be good to understand against it.
> 
> Hi,
> 
> In some I.MX platform, some I2C devices will keep a work queue all time, the work queue will
> trigger I2C xfer every once in a while, but the work queue shouldn't be free in system suspend.
> 

work queue has transfers queued even if system is suspended ? IMO, the 
client i2c devices should not let system go to suspend.

> Within a very short time window, possibly from noirq_suspend to the system actually being suspended,
> or possibly from the system starting to resume to before noirq_resume, this work queue will trigger an
> I2C transfer, and at this time the I2C controller's clk and pinctrl have not yet been restored, reading and

Right, this kind of explains the problem to me. I think you are trying 
to serve i2c transfers when your resources(clk, pinctrl) are not turned 
ON and also interrupt remains disabled. And that's why you need to add 
_noir() PM callbacks supports along with IRQF_NO_SUSPEND | 
IRQF_EARLY_RESUME flags.

> writing I2C registers causes the system to hang. This patch make all I2C operations are performed in a safe
> hardware state.
> 
> Is it better if I add these comment to patch commit log?
>>>
if my latest comments makes sense against the issue, you may write 
accordingly. if i am wrong, then your explanation makes sense. Cause of 
the hang needs to be clearly mention int the commit log in your next patch.

>>> Carlos Song
>>
> 


