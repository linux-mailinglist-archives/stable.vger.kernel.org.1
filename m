Return-Path: <stable+bounces-46047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F099B8CE305
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7167C1F20F50
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB46129A7B;
	Fri, 24 May 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mbX42WD/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F2127E2A;
	Fri, 24 May 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541700; cv=none; b=rBy3SgOzMkE/Y1S8xmMvi9WGvKPjCCdL1MGD9O7P9HKV3XmQKvYL7PiI+cwD0I8XsPxOeTZBRjgXQckddkNqhjPhsL6An9iJuP3G6sXlmH6aDmOFb4dOjPCuS3SnuKQaTtc2j74DaxunKhPPMHzUE31N5cgHOnFE6XNM8mY04KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541700; c=relaxed/simple;
	bh=9Sa658riCmbCqT3J4PTUjBFOqYcZyEuze19YWzLl+Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qtQE4O/OSh9X1wD0VkaKxZu+Qm6OAVcrik1dOUAvkRUoXzH2MK6I3qSXrligzPGN0IIF9T2Vn6Au3dMVBoqkipBvM37qH8YGREYZOtRvUt85yz8AdyZ35kYPjymgSECfKlwhz7E5y7g/xwFLUN6uGZFeL75BIPEaSlkjs/cOcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mbX42WD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNPFQw004328;
	Fri, 24 May 2024 09:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7/WifPwzNZzPU9rOUg01zfQZ3c0yxVuki52/ZR7b14=; b=mbX42WD/1ON8fmsr
	yRfw5/qMoRgLRlLwwtro5eVhz9sWrr3lFDyDVsx6oWVcZiNLbC3WPLB4QhaBB9Rj
	PBgpezBTHU7PNvegP13dZ9a1Swssx/xpFE6ET7dHCwL9iUHVCfs/xyf7NyjEbh8X
	LNU98mAgE3zwPHgYEXGsu96JaZs/kGZlSOuvboch/9q6nXhSSA6Bc2t0/MfQBKtm
	bJ33YVKb1O2GdSEoP4zMmfill3sgiyDHkWD3IE7lcDBuwBd9xPu0ATnmpkTloWz3
	BJfjaLU1kfGN41GlY2PbjmWkIGFHkQB53OpC4APH0U/AYRVAJf8fA+p1kXjoliyb
	OGFgRg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8khsaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 09:08:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O98ALV026893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 09:08:10 GMT
Received: from [10.253.37.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 02:08:08 -0700
Message-ID: <0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com>
Date: Fri, 24 May 2024 17:08:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <dmitry.torokhov@gmail.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024052418-casket-partition-c143@gregkh>
 <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>
 <2024052438-hesitate-chevron-dbd7@gregkh>
 <5acce173-0224-4a05-ae88-3eb1833fcb39@quicinc.com>
 <2024052458-unleash-atom-489b@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024052458-unleash-atom-489b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dBrbM2yb5iv4TzbRnaERgjGqmr-zxoCQ
X-Proofpoint-GUID: dBrbM2yb5iv4TzbRnaERgjGqmr-zxoCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_02,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=907 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240062

On 5/24/2024 2:56 PM, Greg KH wrote:
> On Fri, May 24, 2024 at 01:34:49PM +0800, quic_zijuhu wrote:
>> On 5/24/2024 1:21 PM, Greg KH wrote:
>>> On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
>>>> On 5/24/2024 12:33 PM, Greg KH wrote:
>>>>> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
>>>>>> zap_modalias_env() wrongly calculates size of memory block
>>>>>> to move, so maybe cause OOB memory access issue, fixed by
>>>>>> correcting size to memmove.
>>>>>
>>>>> "maybe" or "does"?  That's a big difference :)
>>>>>
>>>> i found this issue by reading code instead of really meeting this issue.
>>>> this issue should be prone to happen if there are more than 1 other
>>>> environment vars.
>>>
>>> But does it?  Given that we have loads of memory checkers, and I haven't
>>> ever seen any report of any overrun, it would be nice to be sure.
>>>
>> yes. if @env includes env vairable MODALIAS and  more than one other env
>> vairables. then (env->buflen - len) must be greater that actual size of
>> "target block" shown previously, so the OOB issue must happen.
> 
> Then why are none of the tools that we have for catching out-of-bound
> issues triggered here?  Are the tools broken or is this really just not
> ever happening?  It would be good to figure that out...
> 
don't know why. perhaps, need to report our case to expert of tools.
> thanks,
> 
> greg k-h


