Return-Path: <stable+bounces-67602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C4951374
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 06:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB4C1C22EFE
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D94CE13;
	Wed, 14 Aug 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kLcFEAiY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B73182B5;
	Wed, 14 Aug 2024 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609341; cv=none; b=otS6ieKsp9TJShmluX3JqGfVyfqIeXN+9h8dL+dCyjBtLTytPa+bIhOoEEB6uojEQeOK16+B7tyuxOsx4GA0gKi3H2j5o9fMMeuqSiUNdKaANv9kL6nZmGwFc4mlMr0Zon3smGun2P2EAQFQdhomkuonylPFU3I5wHQHE5d8LHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609341; c=relaxed/simple;
	bh=Umh3zMhFXKL1dHtYPdGRhTXjQf+cXqe3JQ5A+Vx+L5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UKprxoGexoH9Qx5n1y+u8sibqof1HuwpfQ/LWarH6a+9iBm2tXZh/0GrHcfC+ePI2Hq34UcIottGVCa/OSoObLw43Qv+YGABylPB+fut9rj0sbtKuOgbNxYptOb3fhtWB1Z11MF3UOvNOY2BYMixM1o1/JNc1Za8IntlfXc8TaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kLcFEAiY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E2clNf016977;
	Wed, 14 Aug 2024 04:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n26wZzdKE0a9/zaYRFmywMl5+MoJimZr3OH3v/Yy5WE=; b=kLcFEAiY7UX2rt2P
	c22nwZeiv3T6imyN3L27dG5Ppm78iZIFDRWZwvz8zVI5LGXXnA0DLVjVI815A5N8
	j5R5TVtlOm/qF6XsJYX0enBBuqudwMccZYtCdyyTPa63XJgVao+Aw1nfuP/b9UwC
	lwakZ0qkIyQJMZsIeMM5Gnt37XxJRGGdrfZpa/PKoeJflW375rxrNnE9EuVKo+Nd
	u+nxMjIiaErnxEzKXFptKu90S2U9Hqlzb5mYGYmmacm4cxVKAMxGqWI20CeQkEB7
	AYHDXyuQSVJGKwFr7aREFdCc0eHawvz7gMKqa8GiuQSMGjZyyuGAsFmHC6468UHj
	xxyDoA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywg640-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 04:22:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E4M7Dk017977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 04:22:07 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 21:22:05 -0700
Message-ID: <04fc6990-b249-29cb-bc15-7fe85292f6a0@quicinc.com>
Date: Wed, 14 Aug 2024 09:52:02 +0530
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
 <a89b5098-f9d6-4758-52b4-29d24244a09b@quicinc.com>
 <20240813233043.uhsxocjr2pn4ujle@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240813233043.uhsxocjr2pn4ujle@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U3DC_W_ehm6TxCOAMc8KUCv-Ci7pCLnc
X-Proofpoint-GUID: U3DC_W_ehm6TxCOAMc8KUCv-Ci7pCLnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_03,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=749 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140028



On 14-08-24 05:00 am, Thinh Nguyen wrote:
>>> When we receive the wakeup event, then the device is no longer in
>>> L1/L2/U3. The Start Tranfer command should go through. >
>> Ok will do this, I hope there won't be any corner cases where the link is
>> down when start_xfer happens. I was not really sure about the history, thats
>> why tried to incorporate my fix into the above IF check.
>>
> 
> It was initially implemented verbatim base on the Start Transfer command
> suggestion from the programming guide without considering the dwc3
> driver flow. First dwc3 checks for U1/U2/U3 state. Then we fixed to only
> check for L1/L2/U3 state, but it's still not right. I've had this on my
> TODO list for awhile and haven't made an update since it's not critical.
> 
Sure, thanks for the confirmation, will send v2.

Regards,
Prashanth K

