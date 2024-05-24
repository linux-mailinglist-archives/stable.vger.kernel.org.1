Return-Path: <stable+bounces-46033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B708CE09C
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 07:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37B91F222A3
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91E74E0C;
	Fri, 24 May 2024 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RhHZpzAS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B01CFB2;
	Fri, 24 May 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528902; cv=none; b=g6HuH4n5s4YFpxR5VCc0AxK6CmroHg+y1Sqi3yUAZB1IUoYCevdGRmMPVwXYHPzOhQJmayZkz7PeWsK+btiW0Tm9wuCjJatjEqtmzJ1yAw0IWFAXMDcG6E7WdlTab3uWvtlEQziLFgc6wA3gPWSvuhgrjcpqLnOK97gf5OLEsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528902; c=relaxed/simple;
	bh=FlDGgVlQguOnjV6UYWXfJd/mNTXYd9Qlgc99324n+Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Whg5CuZumEwVavxFc3/m77zgHPDWrWYjuTgF90MZAZHwFQxO7gRZFVvXDPwDv+LtW1R3ZoH2lc30LYwOrRuG10D+F21T2iDt75EbP8Z1S5tqeGnZ49Zv13UdvjI6VaNE0M/OUKwcbh68FiY3GEdaJ1echAT1UXG2IaaOPqIF6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RhHZpzAS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNOv8i030714;
	Fri, 24 May 2024 05:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ypuoMEpVS3J8z1ZDzYni9eiy/aWKMP2ljn6gXcXq4Jw=; b=RhHZpzASb83cnO0Y
	NfoHa9js2X+DrFEgyWW5/BaSyISgxP0qncUC8VDMCGsEpfwHxlvY8tax8WcHg0kp
	Fyav+GVSTozPXAFVCvNg5ZSZY3yVoH7JhQnW/e1PRELVjjxZL5EQ1H+k9uyBuD39
	cYYMsD548yLXXwmy/sCvs+K9mRhYzuprVhSqixxh2jJhpCyoEiFlCtD6pD5oCKIA
	FYd2msQJwy7WtzxI6VOV0tcHflUTT+fOnzRp3+Xn/954WVT0qaCpFZDkOMnQ79+V
	W3jYPAx6TwwDZEUqofPthkXWBcZXEOEW81zkI7tY3E3iqUs08631dPlB8iAETlb+
	Q9dM1g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8j1a21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 05:34:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O5YqLQ002092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 05:34:52 GMT
Received: from [10.253.37.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 22:34:51 -0700
Message-ID: <5acce173-0224-4a05-ae88-3eb1833fcb39@quicinc.com>
Date: Fri, 24 May 2024 13:34:49 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024052438-hesitate-chevron-dbd7@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QQxQupERDckqvqp6h21MhJMjAqxP4dYy
X-Proofpoint-GUID: QQxQupERDckqvqp6h21MhJMjAqxP4dYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240037

On 5/24/2024 1:21 PM, Greg KH wrote:
> On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
>> On 5/24/2024 12:33 PM, Greg KH wrote:
>>> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
>>>> zap_modalias_env() wrongly calculates size of memory block
>>>> to move, so maybe cause OOB memory access issue, fixed by
>>>> correcting size to memmove.
>>>
>>> "maybe" or "does"?  That's a big difference :)
>>>
>> i found this issue by reading code instead of really meeting this issue.
>> this issue should be prone to happen if there are more than 1 other
>> environment vars.
> 
> But does it?  Given that we have loads of memory checkers, and I haven't
> ever seen any report of any overrun, it would be nice to be sure.
> 
yes. if @env includes env vairable MODALIAS and  more than one other env
vairables. then (env->buflen - len) must be greater that actual size of
"target block" shown previously, so the OOB issue must happen.
>> do you have suggestion about term to use?
> 
> Some confirmation that this really is the case would be nice :)
> 
>>>> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  lib/kobject_uevent.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>>>> index 03b427e2707e..f153b4f9d4d9 100644
>>>> --- a/lib/kobject_uevent.c
>>>> +++ b/lib/kobject_uevent.c
>>>> @@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>>>>  
>>>>  		if (i != env->envp_idx - 1) {
>>>>  			memmove(env->envp[i], env->envp[i + 1],
>>>> -				env->buflen - len);
>>>> +				env->buf + env->buflen - env->envp[i + 1]);
>>>
>>> How is this "more correct"?  Please explain it better, this logic is not
>>> obvious at all.
>>>
>> env->envp[] contains pointers to env->buf[] with length env->buflen,
>> we want to delete environment variable pointed by env->envp[i] with
>> length @len as shown below.
>>
>> env->buf[]            |-> target block <-|
>> 0-----------------------------------------env->buflen
>>         ^             ^
>> 	| ->  @len <- |
>>   env->envp[i]   env->envp[i+1]
>>
>> so move "target block" forward by @len, so size of target block is
>> env->buf + env->buflen - env->envp[i+1] instead of env->buflen
>> -len.
>>
>> do you suggest add inline comments to explain it ?
> 
> Yes please.
> 
> thanks,
> 
> greg k-h


