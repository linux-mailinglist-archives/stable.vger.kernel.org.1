Return-Path: <stable+bounces-67447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AB9501B4
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09A51F21F11
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1E187327;
	Tue, 13 Aug 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WOX88y6a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6E13BADF;
	Tue, 13 Aug 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542822; cv=none; b=pWNGNNrcWu20Fe/xRyQXZij4isU2xG7NOaGOE7gvRfSb6KvDqNctj/Bqwgb8jAqsS6VgYGoBNzTfcRp/hbmMIDcLQ4JPCxX/r4P5AmBE7XGG73l1zBx4rByATIRpxnFT4ZGixjdNqJsUqMdXPxCD/KGJsZlkHNiZaWvhAfib7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542822; c=relaxed/simple;
	bh=rIa5jRwpylk0EMqGKYR8X5flL4X7ACahtZ8KgByVmoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WEO7zMjH2H3FgTEh3sI7oyU+C6HQWyKdCzZxIeRrGi9Tgr6GpyBDFnKJK8lDsh3jscVH7dvDZJfKycyDGEB+T9MqF5n3lXATXFwYnFpTbWZb85yUywcH+taDbkDcdzVg408hUhAxYV8y1VOT//N3i/b3VhGwp7tpeedc1EaGJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WOX88y6a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4bCjA003151;
	Tue, 13 Aug 2024 09:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gWH0Feu6jKBdpXoGLqXF0SgT6nH7BExsqXP2hvhKh/Y=; b=WOX88y6aLTqGVN98
	PfjSJ6bFKBON9dVW1rzgBtsPbhhFTZ64aXSNAxY3JJ2V7oTWh90hs3NZ0nDGjgjJ
	3CnR568bCAvYRSmE4vs3YiwQNNC6fBME8ZfuW8KMDjUZHjtcmvOh25QU6FNqpRoX
	rSKXuvMJQgzK6upHEZYrt1O0W+YgxQwg0ta5j+9y3IJDdcvkNcEvyWxSoHRJPvd/
	IBhcWkR+sVRpXMRBu/d43bwQqV4heG0hr5Y8f5n3OSKO1pOo9MIyXSrgikFF35U8
	8EDUwYgOZ4tvdQATJBeY0oM9grSOMX+6WPXpw6goLLLbbipe5HrwL97dHFv71i9w
	pqR+Fg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x17sf41u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:53:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D9raLE030080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:53:36 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 02:53:35 -0700
Message-ID: <a89b5098-f9d6-4758-52b4-29d24244a09b@quicinc.com>
Date: Tue, 13 Aug 2024 15:23:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240730124742.561408-1-quic_prashk@quicinc.com>
 <20240806235142.cem5f635wmds4bt4@synopsys.com>
 <ec99fcdc-9404-8cd9-6a30-95e4f5c1edcd@quicinc.com>
 <20240808000604.quk6rheiqt6ghjhv@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240808000604.quk6rheiqt6ghjhv@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i1n7NIYdppHzqbXviOY2Nhfbzqg6anu_
X-Proofpoint-ORIG-GUID: i1n7NIYdppHzqbXviOY2Nhfbzqg6anu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130070



On 08-08-24 05:36 am, Thinh Nguyen wrote:


>> And turns out, retries 1500 to 15000 (worst case), which can range from 3ms
>> to 30ms. By this time, control can reach startXfer, where it tries to
>> perform remote-wakeup even if host just resumed the gadget.
> 
> Polling for 20K time is a bit much, and this will vary depending on
> different setup. This is something that I want to fix in the wakeup()
> ops and keep everything async.
> 
This was done as part of experiment, just to determine the latency in 
DSTS. And it was around 3-30ms. Saw rhis same behaviour when polling 
DSTS in __dwc3_gadget_wakeup(sync)

>>
>> For SS case, this retries count was consistently 1, it was passing in first
>> try itself. But unfortunately doesn't behave the same way in HS.
>>
>>> GUSB2PHYCFG.suspendusb2 turns on the signal required to complete a
>>> command within 50us. This happens within the timeout required for an
>>> endpoint command. As a result, there's no need to perform remote wakeup.
>>>
>>> For usb3 speed, if it's in U3, the gadget is in suspend anyway. There
>>> will be no ep_queue to trigger the Start Transfer command.
>>>
>>> You can just remove the whole Start Transfer check for remote wakeup
>>> completely.
>>>
>> Sorry, i didnt understand your suggestion. The startxfer check is needed as
>> per databook, but we also need to handle the latency seen in DSTS when
>> operating in HS.
>>
> 
> usb_ep_queue should not trigger remote wakeup; it should be done by
> wakeup() ops. The programming guide just noted that the Start Transfer
> command should not be issued while in L1/L2/U3. It suggested to wake up
> the host to bring it out of L1/L2/U3 state so the command can go
> through.
> 
> My suggestion is to remove the L1/L2/U3 check in
> dwc3_send_gadget_ep_cmd(), and it will still work fine with reasons
> noted previously. So, just do this:
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 0ea2ca0f0d28..6ef6c4ef2a7b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -411,30 +411,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>                          dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>          }
> 
> -       if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
> -               int link_state;
> -
> -               /*
> -                * Initiate remote wakeup if the link state is in U3 when
> -                * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
> -                * link state is in U1/U2, no remote wakeup is needed. The Start
> -                * Transfer command will initiate the link recovery.
> -                */
> -               link_state = dwc3_gadget_get_link_state(dwc);
> -               switch (link_state) {
> -               case DWC3_LINK_STATE_U2:
> -                       if (dwc->gadget->speed >= USB_SPEED_SUPER)
> -                               break;
> -
> -                       fallthrough;
> -               case DWC3_LINK_STATE_U3:
> -                       ret = __dwc3_gadget_wakeup(dwc, false);
> -                       dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
> -                                       ret);
> -                       break;
> -               }
> -       }
> -
>          /*
>           * For some commands such as Update Transfer command, DEPCMDPARn
>           * registers are reserved. Since the driver often sends Update Transfer
> 
> When we receive the wakeup event, then the device is no longer in
> L1/L2/U3. The Start Tranfer command should go through. >
Ok will do this, I hope there won't be any corner cases where the link 
is down when start_xfer happens. I was not really sure about the 
history, thats why tried to incorporate my fix into the above IF check.

> We do have an issue where if the function driver issues remote wakeup,
> the link may not transition before ep_queue() because wakeup() can be
> async. In that case, you probably want to keep the usb_requests in the
> pending_list until the link_state transitions out of low power.
> 
> The other thing that I noted previously is that I want to fix is the
> wakeup() ops. Currently it can be async or synchronous. We should keep
> it consistent and make it async throughout.
> 
Sounds like a good idea, we can move the req to pending list, then issue 
async wakeup, and queue it back once linksts_change interrupt indicates 
L0/U0. Special care is needed in dwc3_gadget_func_wakeup() when making 
it async.

Regards,
Prashanth K

