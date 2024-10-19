Return-Path: <stable+bounces-86919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291119A4FF6
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 19:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C9A1F2723F
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602A18BB8E;
	Sat, 19 Oct 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NcRZyRV6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25016BA38;
	Sat, 19 Oct 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358609; cv=none; b=mPXXzBcOWS/pChIZq1bCb8dxBEMQQs6kd6bYC+qCECGfW9uYlcNlXaD6xjsGqqDZyCkG4jAF8cK2PEdJKQTcuy+wfRYO8KwaIUDNj7WEEFGi1IHAzjnoiIxLAkcoSwMr+apvbmUgRq4muRzSgN6afpR+tGZjv3ofMnUMiwM0Bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358609; c=relaxed/simple;
	bh=yCTG/ZGkPufBNrSxH4NGdIHIAM26o78L+mVBb+rIYpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WhOYqH55dQYc5iWirVaXodb1vosEB/7eeV+7+bc1jf9OJiljYmefEDRIc47Wauid4OIKJ1JOBEuKpwnfnmKF4W0jJv895wazIhaiATXRxGFBvwR2GCbf9Egw/CSumG9nhDo+E7R/CcX9GdigBL4vtkaeYs2MSeNtDEMWS/bnJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NcRZyRV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JGuMs7027799;
	Sat, 19 Oct 2024 17:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MNGRH4QVt97DFI6pbxYB0EsSMa6hnh7LzKJUtb2ke54=; b=NcRZyRV63FdenZ05
	4iSdDA1hGWS6LwaV+WhXeOu3ziMWQnLBdIx7ddaLp61JOAF1JBfa7+Gw2cdNd8De
	ECCsUdihPOFilo2m/Vp5/2QNBJjU6Kb+3XwpnC7Zxh+raS4F1ak96lTwvG6F+k5e
	djhyfy+8bsXrB+jeP4lyhVyZcQL6ZkpGgbVAlIia/gp7EDHj3iLCBfVrhgnatsyq
	gAB06/aK50R99j58vgW0ZZIH24WcxLDgaCeitcrY7mJUXyZGToN7ybGyy07OWM4g
	VN9ky/GDgrh3AQQ4PB1FAjPgjeOUFV0r+KJjaqPNyUhduNX3Fuffmw/TwHfy7i5v
	k9/B2g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6w1gw79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 17:23:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49JHNNZh029459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 17:23:23 GMT
Received: from [10.216.44.170] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 19 Oct
 2024 10:23:21 -0700
Message-ID: <fbfa824b-cb28-40fa-b447-30ed5832fe82@quicinc.com>
Date: Sat, 19 Oct 2024 22:53:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: Fix Link TRB DMA in command ring stopped completion
 event
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20241018195953.12315-1-quic_faisalh@quicinc.com>
 <2024101914-upheld-dander-d1af@gregkh>
Content-Language: en-US
From: Faisal Hassan <quic_faisalh@quicinc.com>
In-Reply-To: <2024101914-upheld-dander-d1af@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G0cgGNEKkhL6eObg_PZ4IyVdArIFnj6l
X-Proofpoint-ORIG-GUID: G0cgGNEKkhL6eObg_PZ4IyVdArIFnj6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=789 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410190127



On 10/19/2024 12:04 PM, Greg Kroah-Hartman wrote:
> On Sat, Oct 19, 2024 at 01:29:53AM +0530, Faisal Hassan wrote:
>> During the aborting of a command, the software receives a command
>> completion event for the command ring stopped, with the TRB pointing
>> to the next TRB after the aborted command.
>>
>> If the command we abort is located just before the Link TRB in the
>> command ring, then during the 'command ring stopped' completion event,
>> the xHC gives the Link TRB in the event's cmd DMA, which causes a
>> mismatch in handling command completion event.
>>
>> To handle this situation, an additional check has been added to ignore
>> the mismatch error and continue the operation.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
> 
> What commit id does this fix?
> 
> thanks,
> 
> greg k-h

This does not fix any specific commit. It appears that the
implementation has been missing since the very beginning of xhci-ring.c.
Therefore, can I reference the first commit in the Fixes tag:
7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")?

Thanks,
Faisal

