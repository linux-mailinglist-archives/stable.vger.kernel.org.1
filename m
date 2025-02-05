Return-Path: <stable+bounces-114009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D68A29D4F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 00:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128CF3A6FDA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ACF219A67;
	Wed,  5 Feb 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qp/XVm8S"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD76151982;
	Wed,  5 Feb 2025 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797374; cv=none; b=rulc1sNJjdQm6ZU3zMtsIQNqOx0lfOZDcC5kO2FE2QeRTA6RhX27VAkh7X09hFn/tY7iefMoTxaYgNlo3uAg7G648kX2a0oeT03+bFw3RO152G6R2XnFPPuIw0Lt7QCkzBnKVtGNFS+9X7pFd30cr/kgA64Un7Jc4L9Ol+rBZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797374; c=relaxed/simple;
	bh=Nvv2DGEOtcrJV98VNO3iVlHK1XBISSzOjxsw4Jo6yl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MbOoEw5WRWJ18OMMhoN/UqVRqvdvmoz3zQoaZvNsfs4M9UQthAQoiSXJpqKWFq+0wsA6rwRvVm84fKRHiKtGgaFC8I6XhSN2Ko/GTus9m4XCuVMrAMZlMybufPmpmwD2BgX6VfrPunNbrrvAjJwJtxTMft0pWULiA/Lzaze4tTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qp/XVm8S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515ErV0S010937;
	Wed, 5 Feb 2025 23:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h9JQqmEzqkt43tgEtRsXtbPM/f5qT4U4nQT1jZMaNJs=; b=Qp/XVm8S+hm6/Ok3
	11dH+qDDzDBft589lXneobeKEcbV120C62PAyk2CI4DpkJf58MJZNJeTvXa/P5/X
	1SOBGYEjlNdCQFCPVTS44HlAXnaKO0qibFRR0K26VbOqw+yN2nnd2Ynrk47RAdl/
	VMas7vxp7oD6P6M3mCFO7JMD0+8yRyCDwrP/P6W99p+GJT26wuxELQt6ZRzhu4h4
	n1xdMwiSlB4+FIC6I9NEMTcEdnVx2j/nYeECljzN0NcoYFrt5/FYjo5bs5jSQxfC
	/tLzwSdDY7wElhqPEfUycwkOtQMm24oUy5HQ6THS5PnyL41bkz4QQxYX7Q3Suf5+
	kOaVlg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ma5994sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 23:16:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515NG5Xf012438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 23:16:05 GMT
Received: from [10.110.44.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Feb 2025
 15:16:04 -0800
Message-ID: <c3fca109-b9ad-40c8-8f4a-033c48a86850@quicinc.com>
Date: Wed, 5 Feb 2025 15:15:43 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: cache usb roles received during switch
 registration
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: <gregkh@linuxfoundation.org>, <xu.yang_2@nxp.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250127230715.6142-1-quic_eserrao@quicinc.com>
 <Z6DVRbmwB859RlCt@kuha.fi.intel.com>
Content-Language: en-US
From: Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <Z6DVRbmwB859RlCt@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: keEM2tfYbGFv4zlfVJmgl6J_dOEKNLk0
X-Proofpoint-ORIG-GUID: keEM2tfYbGFv4zlfVJmgl6J_dOEKNLk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050178



On 2/3/2025 6:40 AM, Heikki Krogerus wrote:
> On Mon, Jan 27, 2025 at 03:07:15PM -0800, Elson Roy Serrao wrote:
>> The role switch registration and set_role() can happen in parallel as they
>> are invoked independent of each other. There is a possibility that a driver
>> might spend significant amount of time in usb_role_switch_register() API
>> due to the presence of time intensive operations like component_add()
>> which operate under common mutex. This leads to a time window after
>> allocating the switch and before setting the registered flag where the set
>> role notifications are dropped. Below timeline summarizes this behavior
>>
>> Thread1				|	Thread2
>> usb_role_switch_register()	|
>> 	|			|
>> 	---> allocate switch	|
>> 	|			|
>> 	---> component_add()	|	usb_role_switch_set_role()
>> 	|			|	|
>> 	|			|	--> Drop role notifications
>> 	|			|	    since sw->registered
>> 	|			|	    flag is not set.
>> 	|			|
>> 	--->Set registered flag.|
>>
>> To avoid this, cache the last role received and set it once the switch
>> registration is complete. Since we are now caching the roles based on
>> registered flag, protect this flag with the switch mutex.
> 
> Instead, why not just mark the switch registered from the get-go?
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index c58a12c147f4..cf38be82d397 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -387,6 +387,8 @@ usb_role_switch_register(struct device *parent,
>         dev_set_name(&sw->dev, "%s-role-switch",
>                      desc->name ? desc->name : dev_name(parent));
>  
> +       sw->registered = true;
> +
>         ret = device_register(&sw->dev);
>         if (ret) {
>                 put_device(&sw->dev);
> @@ -399,8 +401,6 @@ usb_role_switch_register(struct device *parent,
>                         dev_warn(&sw->dev, "failed to add component\n");
>         }
>  
> -       sw->registered = true;
> -
>         /* TODO: Symlinks for the host port and the device controller. */
>  
>         return sw;
> 

Thank you for the feedback.

Yes that works as well. Wasn't entirely sure if we can set that flag from the get-go before calling device_register().
But guess we can reset the flag if device_register fails since that is the only failure path in role_switch_register().

I will upload v2 with this modification.

Best Regards,
Elson

