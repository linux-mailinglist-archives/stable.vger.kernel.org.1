Return-Path: <stable+bounces-65529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628894A495
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7F82818A4
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C151D0DDC;
	Wed,  7 Aug 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PAwZRDXD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D81AE87B;
	Wed,  7 Aug 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023685; cv=none; b=Xq5GSUVDeyVqhwbBlyc5BhvhLkKaLWJmJkF6575TnZ+lyUrMCIxdna8g3NzJIrBmp7ZrVpO4NtYwUGHqjGdjocdBDpWa02Zn1U3aPiSAx8mmt+7RYXdIMtdnCSkoUZhuY9RYDraiqlgw30EPDCL3VzUe43Kv5D035WYTMk+P/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023685; c=relaxed/simple;
	bh=13PfPwaqWfV0SZIb5VZIEOqUcw2cc8yCIcW5grujzAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bHS0uBIZMhtf/Xv4Dnb/8QJ4Epp6i03HcbMTepaKed469WdHaQXF5plwRS5PzYKeTwAkCu4NehU1yPEdcZZWfebJAjHNGAWtJjIvvp+7kl9K5TYG4rcafUN9uJwKuO3Z8w+w+ukYrP5Hf/9JN/sSP2Cd/pPTAU+Ic7Chkuc4mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PAwZRDXD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477873DK002852;
	Wed, 7 Aug 2024 09:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w4f2akm3PLX0q66J2hNtvC4aFfjKnQkbdbfkY2Cic3c=; b=PAwZRDXDOHCNFTqL
	n4O/eJeVuo+T9X9kpuNsgYokm6eHqHESzKBJs8Wum4wRHjbKz3qzLVmPmA4kkC/V
	W/5hfaOQJiZI83hBmdDCIGue0YPBAUZzplWzVrqR8kEH4vkUoZO0xjbqeE+5sLxc
	/DY3rS6YTd8rnngym1cvkmVxp2p4HMndyF7fNTSdvjy598vS42+XQhqcHN9DZ7pL
	uRAY5wsqduTmR6QhN46DqAPhMHxNucGEiPhX1Tx8BhJimVqixeyzFNZg5S6RqEUM
	Ssom/ODBrSRTfO4cwSacAbSWJw4AINFElWP33D8CGqoOo2dzrFTT4G8c0AHDu7d1
	QXrK0g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdu9a4cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:41:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4779fI28008697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 09:41:18 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 02:41:16 -0700
Message-ID: <ec99fcdc-9404-8cd9-6a30-95e4f5c1edcd@quicinc.com>
Date: Wed, 7 Aug 2024 15:11:13 +0530
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
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240806235142.cem5f635wmds4bt4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jcU0xN1rCS7mNrX7N5CpaDDZyLpmtpsw
X-Proofpoint-GUID: jcU0xN1rCS7mNrX7N5CpaDDZyLpmtpsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_06,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408070067



On 07-08-24 05:21 am, Thinh Nguyen wrote:
> Hi,
> 
> On Tue, Jul 30, 2024, Prashanth K wrote:
>> When operating in High-Speed, it is observed that DSTS[USBLNKST] doesn't
>> update link state immediately after receiving the wakeup interrupt. Since
>> wakeup event handler calls the resume callbacks, there is a chance that
>> function drivers can perform an ep queue. Which in turn tries to perform
>> remote wakeup from send_gadget_ep_cmd(), this happens because DSTS[[21:18]
>> wasn't updated to U0 yet. It is observed that the latency of DSTS can be
>> in order of milli-seconds. Hence update the dwc->link_state from evtinfo,
>> and use this variable to prevent calling remote wakup unnecessarily.
>>
>> Fixes: ecba9bc9946b ("usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer")
> 
> This commit ID is corrupted. Please check.
> 
Will fix it, was supposed to be 63c4c320ccf7, thanks for pointing out.

> While operating in usb2 speed, if the device is in low power link state
> (L1/L2), CMDACT may not complete and time out. The programming guide
> suggested to initiate remote wakeup to bring the device to ON state,
> allowing the command to go through. However, clearing the

Yea true, we need ensure that the linkstate is not in L1/L2/U3 for 
HS/SS. But since we are relying on DSTS for this, we may issue 
remote-wakeup to host even when not needed. During host initiated wakeup 
scenario, we get a wakeup interrupt which calls function driver resume 
calls. If function driver queues something, then startxfer has to be 
issued, but DSTS was still showing U3 instead of U0. When checked with 
our design team, they mentioned the latency in DSTS is expected since 
and latency would be in msec order from Resume to U0. Can you please 
confirm this once, I simply added a polling mechanism in wakeup handler.

@@ -4175,6 +4177,14 @@ static void dwc3_gadget_wakeup_interrupt(struct 
dwc3 *dwc, unsigned int evtinfo)
          * TODO take core out of low power mode when that's
          * implemented.
          */
+       while (retries++ < 20000) {
+               reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+               /* in HS, means ON */
+               if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
+                       break;
+               udelay(2);
+       }
+       pr_info("DWC3 Wakeup: %d", retries);

And turns out, retries 1500 to 15000 (worst case), which can range from 
3ms to 30ms. By this time, control can reach startXfer, where it tries 
to perform remote-wakeup even if host just resumed the gadget.

For SS case, this retries count was consistently 1, it was passing in 
first try itself. But unfortunately doesn't behave the same way in HS.

> GUSB2PHYCFG.suspendusb2 turns on the signal required to complete a
> command within 50us. This happens within the timeout required for an
> endpoint command. As a result, there's no need to perform remote wakeup.
> 
> For usb3 speed, if it's in U3, the gadget is in suspend anyway. There
> will be no ep_queue to trigger the Start Transfer command.
> 
> You can just remove the whole Start Transfer check for remote wakeup
> completely.
> 
Sorry, i didnt understand your suggestion. The startxfer check is needed 
as per databook, but we also need to handle the latency seen in DSTS 
when operating in HS.

Thanks,
Prashanth K

