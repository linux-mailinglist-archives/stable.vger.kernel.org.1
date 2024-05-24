Return-Path: <stable+bounces-46075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072248CE74C
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E68B2112A
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC18626D;
	Fri, 24 May 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bW7ceZwj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4D1802B;
	Fri, 24 May 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562027; cv=none; b=ffS5xKHXxh4ahdajU8cbvnKhcR/gHAyrC/2yHJrK7rQcNcKdSpRHde/CltB0DZhkP9lSqCHsAOO3aMnudPNv338JqS8ueTc2m6cGMySo98DZR4uOK6iZefv3/ExbWBvKGgPo5iOqpj9WqR1yyF7pJax4eskcz23TnWeUePMZfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562027; c=relaxed/simple;
	bh=BJ5VrB+qJfZCoyNHI7babiy3dogLb5Qii6s5S49ROfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mLTjONSjcHf4MmKG0fMPdGcXk2UJ+xgvO436hGCzIP95Tbn5TqRwbhGbb7ylFl34XnADyOvSXfxW5tKGTIe/VYjTR4DU42FBXtQXDjgNhaIZz4HW8x765fQnU4WRcOcjJQlqI/7afJtrQfHTCUAmG7vKSFEnFNYy/eyCHTsdQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bW7ceZwj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O97ddS007622;
	Fri, 24 May 2024 14:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RQj5TYZnb1ah25s5Ay50rB8Vo5r8uZJ5JDJMSNUD8KM=; b=bW7ceZwjonyC/fWy
	6DzWjZB9cv9AhlUB7kIYpSeze8Ksh+oDyM5xUrtD5T2P2bzXtvHI9IfZbX9Tflaz
	bP5yDB5Zue0mtxTrkt9E3yeHS6ScA3ha9RYpyZ8M4Ac1P/Hqo+fQ/wYi2qOOoWaa
	spRpP0pGOtxnv43mfGjF0IVa7eePHU7gThxYD6SZ5TLlU1M7I3Z8veZIT798IPho
	+ZCS/az2s8eCVoRG5ywNVWQgf90nXkfZxESNjnIFFYEI0i4oKMg9NJvxfxgqrd6Q
	qvLXSGQfHRpET0byoIoZYcWsRgewZuJushpq/WLH9zMf7EhU1V0/YeTRE0QWKjpF
	3h1+Sg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa9ttrpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 14:46:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OEku8s000561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 14:46:56 GMT
Received: from [10.253.37.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 07:46:55 -0700
Message-ID: <ced59dca-70cd-4680-b7d5-e0983aa9be74@quicinc.com>
Date: Fri, 24 May 2024 22:46:53 +0800
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
 <0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com>
 <2024052405-award-recycling-6931@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024052405-award-recycling-6931@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ikya5VPHETM-SYfas71xA-vDncOI2iBH
X-Proofpoint-ORIG-GUID: ikya5VPHETM-SYfas71xA-vDncOI2iBH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240102

On 5/24/2024 7:47 PM, Greg KH wrote:
> On Fri, May 24, 2024 at 05:08:06PM +0800, quic_zijuhu wrote:
>> On 5/24/2024 2:56 PM, Greg KH wrote:
>>> On Fri, May 24, 2024 at 01:34:49PM +0800, quic_zijuhu wrote:
>>>> On 5/24/2024 1:21 PM, Greg KH wrote:
>>>>> On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
>>>>>> On 5/24/2024 12:33 PM, Greg KH wrote:
>>>>>>> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
>>>>>>>> zap_modalias_env() wrongly calculates size of memory block
>>>>>>>> to move, so maybe cause OOB memory access issue, fixed by
>>>>>>>> correcting size to memmove.
>>>>>>>
>>>>>>> "maybe" or "does"?  That's a big difference :)
>>>>>>>
>>>>>> i found this issue by reading code instead of really meeting this issue.
>>>>>> this issue should be prone to happen if there are more than 1 other
>>>>>> environment vars.
>>>>>
>>>>> But does it?  Given that we have loads of memory checkers, and I haven't
>>>>> ever seen any report of any overrun, it would be nice to be sure.
>>>>>
>>>> yes. if @env includes env vairable MODALIAS and  more than one other env
>>>> vairables. then (env->buflen - len) must be greater that actual size of
>>>> "target block" shown previously, so the OOB issue must happen.
>>>
>>> Then why are none of the tools that we have for catching out-of-bound
>>> issues triggered here?  Are the tools broken or is this really just not
>>> ever happening?  It would be good to figure that out...
>>>
>> don't know why. perhaps, need to report our case to expert of tools.
> 
> Try running them yourself and see!
i find out the reason why the OOB issue is difficult to be observed.
the reason is that MODALIAS is the last variable added by most of
drivers by accident, and it skips the obvious wrong logic within
zap_modalias_env().

you maybe run below command to confirm the reason.
grep -l -r MODALIAS drivers/  | xargs grep add_uevent_var


