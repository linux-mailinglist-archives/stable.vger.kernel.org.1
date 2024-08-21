Return-Path: <stable+bounces-69799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF469959C06
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BD286D0D
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823018C01C;
	Wed, 21 Aug 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIEGSlQe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B051885BF;
	Wed, 21 Aug 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243902; cv=none; b=ma6np1yhiq7Y7LVeXbCRZRImsh2W1iRVwC5rZGLPznczDVo58IYpHX5QvaML9eDoNX7sJky53GGS1Dsum1UXlWe44UQ7SmR/bV8P4FKyxlN3WEmCoG7xmrpmkk3KMzj94zwKFWosMehJjjrDGmoc05N5BSI9f5S7eDMofJYowiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243902; c=relaxed/simple;
	bh=//RxV0U/4Gz6Q96cnCAeQNniwMPQX/5AXHwMAzAzoeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hkvqP13v3TbwigSG9Kil0zmvBv9EZqPikXgbfz0gh6z5iUIAnDif7upCok2OPoV+9iMPW5b2hBisPcRXD22OrLe4gbDxtCTeGPoaQeEm80PH7QnDwEaLCiRoeekcYtjzHYFmImCyGpERdlKenB8AsdOBO5ASWb3H2VnI49dZWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aIEGSlQe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6IBXa012828;
	Wed, 21 Aug 2024 12:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m99oEZYNIzUFDu2lrPYQyIAdVDwvlNz2UyXWFUN5PvA=; b=aIEGSlQewmtvnT3C
	zbEULJP6FOSkLoor7ECzSkBKHf98IDh93nAU2MoxGuhNQIz0hVpl33HyYHbJtAD2
	CWEtHdpKKJfbu1l+o8RpM1bBnXHENGRqMEZ43zAx25j2IJW6hj2brPFLJcIgUi8c
	4CvvHbgm3KYmG2bbUyhSsj6Ne7qfskJniBl9a6JMISl0J5Y/R28tkMfomLgHpLWL
	gD39T0otUXya5x0jW6d1ND8BlGQuX4qDi/nmb6fFacNOfkrXvZPAsVrbqZ+xWsEM
	WqqEWZEswx0OSKhn8CJ5Rp6ZD1hCQM9N3kLbSKAeudIKb46f1DEDqxQs4UNpDlYa
	ZiAo2w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pe5mnqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 12:38:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LCcGri001080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 12:38:16 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 05:38:14 -0700
Message-ID: <e31f0796-7163-a36c-486f-0f8e0a613661@quicinc.com>
Date: Wed, 21 Aug 2024 18:08:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [v3] usb: dwc3: Avoid waking up gadget during startxfer
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240820121524.1084983-1-quic_prashk@quicinc.com>
 <20240820223800.zt52jaxedijbvskt@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240820223800.zt52jaxedijbvskt@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W1gldy00z9CmcvFqcxjktCfeRKQ6Qsnr
X-Proofpoint-GUID: W1gldy00z9CmcvFqcxjktCfeRKQ6Qsnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210092



On 21-08-24 04:08 am, Thinh Nguyen wrote:
> On Tue, Aug 20, 2024, Prashanth K wrote:
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
>> v3: Added notes on top the function definition.
>> v2: Refactored the patch as suggested in v1 discussion.
>>
>>  drivers/usb/dwc3/gadget.c | 31 +++++++------------------------
>>  1 file changed, 7 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89fc690fdf34..d4f2f0e1f031 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -287,6 +287,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
>>   *
>>   * Caller should handle locking. This function will issue @cmd with given
>>   * @params to @dep and wait for its completion.
>> + *
>> + * According to databook, if the link is in L1/L2/U3 while issuing StartXfer command,
>> + * software must bring the link back to L0/U0 by performing remote wakeup. But we don't
> 
> Change "L0" -> "On" state
> 
>> + * expect ep_queue to trigger a remote wakeup; instead it should be done by wakeup ops.
>> + *
>> + * After receiving wakeup event, device should no longer be in U3, and any link
>> + * transition afterwards needs to be adressed with wakeup ops.
>>   */
> 
> You're missing the explanation for the case of L1. Please incorporate
> this snippet (reword as necessary to fit in the rest of your comment):
> 
> While operating in usb2 speed, if the device is in low power link state
> (L1/L2), the Start Transfer command may not complete and timeout. The
> programming guide suggested to initiate remote wakeup to bring the
> device to ON state, allowing the command to go through. However, since
> issuing a command in usb2 speed requires the clearing of
> GUSB2PHYCFG.suspendusb2, this turns on the signal required (in 50us) to
> complete a command. This should happen within the command timeout set by
> the driver. No extra handling is needed.
> 
> Special note: if wakeup() ops is triggered for remote wakeup, care
> should be taken should the Start Transfer command needs to be sent soon
> after. The wakeup() ops is asynchronous and the link state may not
> transition to U0 link state yet.
> 
> 

Does this sound good? (Didnt want to spam with new patches)

"According to databook, while issuing StartXfer command if the link is
in L1/L2/U3,
then the command may not complete and timeout, hence software must bring
the link
back to ON state by performing remote wakeup. However, since issuing a
command in
USB2 speeds requires the clearing of GUSB2PHYCFG.suspendusb2, which
turns on the
signal required to complete the given command (usually within 50us).
This should
happen within the command timeout set by driver. Hence we don't expect
to trigger
a remote wakeup from here; instead it should be done by wakeup ops.

Special note: If wakeup() ops is triggered for remote wakeup, care
should be taken
if StartXfer command needs to be sent soon after. The wakeup() ops is
asynchronous
and the link state may not transition to U0 link state yet. After
receiving wakeup
event, device would no longer be in U3, and any link transition
afterwards needs
to be adressed with wakeup ops."

Thanks,
Prashanth K

