Return-Path: <stable+bounces-118696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66540A41473
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 05:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77373B2A7F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 04:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029561A5B89;
	Mon, 24 Feb 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k/N2uq8J"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23571A2391;
	Mon, 24 Feb 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370646; cv=none; b=QZRCRhrOffyPnQwXreP/4GC6ewi51k3yqqAchZSRtqve6pVntP5+XsUvSl42Kv4h00w7tq9tmG7w4X5YrJEtGwGRlDcGxcagYQ7EVHM7eBLMEX+gW0M4eQU71hOMSws2RcTJfsrOZcsE7MrhS7LZ6NZYY8pw0yYgPpp363zIJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370646; c=relaxed/simple;
	bh=c2TRpeElFxpZIG4NM+kWVUeRgGO0CsD8fi/lB/JYzUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=seYbhU/cAQi0CDq+fxZZfOOUKElD9VmVVK4vWxwcaegBHdzKW8STpXZyfKGUztEhbGNeVKJJSmDOjCtX8uMTmsqfi97/Lx3lKKg1g4BetYF70Hr/Kvv+WXb5WQeTDEZfn74Zz9KNXVM8VtY38DBFEbnrz5hZRYunAo44bSvDIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k/N2uq8J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NMle2P005630;
	Mon, 24 Feb 2025 04:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c2TRpeElFxpZIG4NM+kWVUeRgGO0CsD8fi/lB/JYzUw=; b=k/N2uq8Jrc83pukh
	HfNFj3M3TVhmXh052B58Eqt51JGXfa29Nca1Jcpu7wfIQbNFBfYjewBey/ZZYiw2
	9ogzdX3/EaAtCTgZniPY9resF62n+LJ+vFypTK3GpT1pkJs8EAPxFJbDnULQgi/2
	dJT05IVTwTmVPTYeSlvj7mI8lI2aZwA0gknkuhl0W54PsNMfmWGG3ptsczjONMG9
	4GMEdpmk6twTWMY7ERZ3BFYEedqrztSnQEW+c9Y4ZF3IJp8bOhWhx2wvqo9wJNfy
	yos8T9Fi7sycBN9PVaFtcDCjWZU7ourDJSh9GRbM/j+syHdm1crh3zOcJw8pBFLv
	OCoGMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7bf3c5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 04:17:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51O4H80e004221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 04:17:08 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Feb
 2025 20:17:05 -0800
Message-ID: <53f8a9cd-c30c-47fe-b189-c632a093dc66@quicinc.com>
Date: Mon, 24 Feb 2025 09:47:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
To: Kees Bakker <kees@ijzerbout.nl>,
        Prashanth K
	<prashanth.k@oss.qualcomm.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Peter Korsgaard
	<peter@korsgaard.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
 <a882365c-148c-410a-ac67-b7a17dafc501@ijzerbout.nl>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <a882365c-148c-410a-ac67-b7a17dafc501@ijzerbout.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NMJ0Wgnu26jXNFvEfjIvjI7GL4Zbf8Wx
X-Proofpoint-ORIG-GUID: NMJ0Wgnu26jXNFvEfjIvjI7GL4Zbf8Wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=331 impostorscore=0 suspectscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240028



On 22-02-25 12:56 am, Kees Bakker wrote:
> Op 17-02-2025 om 13:03 schreef Prashanth K:
>> Currently the USB gadget will be set as bus-powered based solely
>> on whether its bMaxPower is greater than 100mA, but this may miss
>> devices that may legitimately draw less than 100mA but still want
>> to report as bus-powered. Similarly during suspend & resume, USB
>> gadget is incorrectly marked as bus/self powered without checking
>> the bmAttributes field. Fix these by configuring the USB gadget
>> as self or bus powered based on bmAttributes, and explicitly set
>> it as bus-powered if it draws more than 100mA.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver
>> of self-powered")
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Didn't change anything from RFC.
>> - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-
>> prashanth.k@oss.qualcomm.com/
>>
>>   drivers/usb/gadget/composite.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/
>> composite.c
>> index bdda8c74602d..1fb28bbf6c45 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev
>> *cdev,
>>       else
>>           usb_gadget_set_remote_wakeup(gadget, 0);
>>   done:
>> -    if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
>> -        usb_gadget_set_selfpowered(gadget);
>> -    else
>> +    if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
>> +        !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> Please check this change again. From line 983-884 there is a `goto done`.
> in case `c` is NULL. So, there will be a potential NULL pointer dereference
> with your change.

Yea good catch, sorry for missing the corner case. Ill send another patch.

Regards,
Prashanth K

