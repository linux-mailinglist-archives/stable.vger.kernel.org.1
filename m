Return-Path: <stable+bounces-69450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBE956352
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 07:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9E9B22432
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788D14D70E;
	Mon, 19 Aug 2024 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjYa4vYT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638B156C65;
	Mon, 19 Aug 2024 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045890; cv=none; b=jFfEXpLqFYwCbUaA1mxlBFaJaw3ggzGkhM4UitXMaT+a7usCDqYoo+r6Aq2IJNUhm52avkxEOw/OEsxoqM9RgZOc3iyRLk/kWnijKDvw0kzZIlvUDkop+4Jqbu9cG7qpZahq0Kd4u6Fca/yd4rIqNELcyMxFGuUUJqkxI1GZXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045890; c=relaxed/simple;
	bh=ndVlNUFibYvE+W+MCflv+7hF3XBaaCGrOjNwNocdg6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A08mfugN8W1mBZA6XRQvuCod/9xGn8kYT8LhmQE7HSxQa1Wbje/dmxxPSGEldQnDy9vEU/7KMEAzBpsiyAqUQ93LxAlQstEguQroAiSMDjBljX1HGYy0mV7cjb4KYgv/JF19gb2FHhpUJMIC58bvGJfzQT3mr2kQVIcZvU4JDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjYa4vYT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IMoNe0014094;
	Mon, 19 Aug 2024 05:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e/Dw1ICLUJJQZkBDhaiKiDg+TY8zAl1ju75hw75bZic=; b=FjYa4vYTIU0wD2SE
	OmxWo9VsJ8KwaaEmwQbmXoPogaqWCo5vwFUXCNQXqNe3GZGXpbkUWiaesAE4h6+u
	wF2RshMj1JgjQMBdjwIt8qjjKBOPd628hhck5x7i+DXloCMPvuuFrtbtGEqgoSdV
	w4pDE74fvd6gezKQ6u5WKNBym8JAeYlwIKCm2yKYSdELF7opoZqgLQyoyCzduWdx
	ntZnKtIY0EW+u7h4Bl7TdK1Elg4d2G3PSw6xK4sKIQ99C9DGH176R5wXJJfdiNl4
	4HER3I0qhGlxNu/ndf9KdMV2yGQZ0X9XLJcCnmU7R6vse8z2A0hMstn8DTWJ1pVK
	Bnd7DQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412n1jtyg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:38:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47J5c3qg026279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:38:03 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 18 Aug
 2024 22:38:01 -0700
Message-ID: <e222bd06-fd9f-32a3-02ca-66a01cf4ab5e@quicinc.com>
Date: Mon, 19 Aug 2024 11:07:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [v2] usb: dwc3: Avoid waking up gadget during startxfer
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240816062017.970364-1-quic_prashk@quicinc.com>
 <20240816214941.l3el46ittrugxqp5@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240816214941.l3el46ittrugxqp5@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GjUqhaIkt5YN1OPXoRcc9jjQvzU55aCi
X-Proofpoint-GUID: GjUqhaIkt5YN1OPXoRcc9jjQvzU55aCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=599 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190040



On 17-08-24 03:19 am, Thinh Nguyen wrote:
> On Fri, Aug 16, 2024, Prashanth K wrote:
>> When operating in High-Speed, it is observed that DSTS[USBLNKST] doesn't
>> update link state immediately after receiving the wakeup interrupt. Since
>> wakeup event handler calls the resume callbacks, there is a chance that
>> function drivers can perform an ep queue, which in turn tries to perform
>> remote wakeup from send_gadget_ep_cmd(STARTXFER). This happens because
>> DSTS[[21:18] wasn't updated to U0 yet, it's observed that the latency of
>> DSTS can be in order of milli-seconds. Hence avoid calling gadget_wakeup
>> during startxfer to prevent unnecessarily issuing remote wakeup to host.
>>
>> Fixes: c36d8e947a56 ("usb: dwc3: gadget: put link to U0 before Start Transfer")
>> Cc: <stable@vger.kernel.org>
>> Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>> v2:  Refactored the patch as suggested in v1 discussion.
>>
>>  drivers/usb/dwc3/gadget.c | 24 ------------------------
>>  1 file changed, 24 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89fc690fdf34..3f634209c5b8 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -327,30 +327,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>>  			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> 
> Can you capture the notes I provided explaining why we can issue Start
> Transfer without checking for L1/L2/U3 states on top of this function?
> 
I also thought the same initially, but didnt add since Greg usually adds
the patch link to commit, so that the discussion would be captured in
git log. I will add it on top of dwc3_send_gadget_ep_cmd and send V3,
let me know if there's any other suggestion.

Thanks,
Prashanth K

