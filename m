Return-Path: <stable+bounces-46031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A18CE088
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B5528307D
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A65B5D6;
	Fri, 24 May 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sy9kJN7Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9418320B;
	Fri, 24 May 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716527715; cv=none; b=qKwObQw608db5ZxMsbxNqFMhyZG68IF0RTDTHaHVPLmOy8UoF0S7nd4ttWimPn5Kygb/wrEnQskbWdgBOwjX740fKv/y1p5HypPsbeGpm44yKWIFg9EkEATKabnq6QerObioncbGHT7Itd5SuFIfl4BA/ZdagaxOcBHv2mkK1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716527715; c=relaxed/simple;
	bh=DV02NM7IGHIMfIAtW8NdebcwPtehp2HgLESzy+sYf48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L94LgSrCJlC36P5CmT3B4oY8PcP7BE9nWPq5aHf0IMPJQM0ZJ6gTTyU/+mw3l//tj2J++qpBUsN9XNQUhpbJMzPzXiSQQJ402Z5oWbgLPWzy5lSQeyjUOH1xoV69IBLcu/F7sRymk025ZCFWQm4qGrLhJiZIq/mGEEs3NmzOTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sy9kJN7Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNPHK9004398;
	Fri, 24 May 2024 05:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7rwQB85D4QX6bHSTtqyWKtjZAG2zZY/KlCEDg3gPgk8=; b=Sy9kJN7Y8bSUMyKa
	hD5SY4IOsNXpu2vl2o0Hd+lPzs3qZKCLHiTd+Odva9hcweZIF0FWSCbO5m8y4A/a
	3kc0bO7cmJprg4ETOwNP09q4sHjlEX78I5JcywRAPIdSpPUoA6fuIL6eLHxhS6MD
	TIPkZfSAXOKXk/x/C1hc6a+WDnZ+2kA/6jToPEDlcJ4NwLgFLH1o4yDH8PlZVA7K
	tUYlvdruFPyDaT0a9i4EPM++/m5/P9DzvwDgGis4Cva+fECt0lN9R10D20LMqH7y
	CI57oyYP3DTa26w3q7Kp8mRJzm9DcjQiEYln1L63dw5zvovgQFfyvYdNRp5tUVUU
	aCagvA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaabq17w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 05:15:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O5F5NZ020539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 05:15:05 GMT
Received: from [10.253.37.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 22:15:03 -0700
Message-ID: <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>
Date: Fri, 24 May 2024 13:15:01 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024052418-casket-partition-c143@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ffSjiLEijHxRilRZ6LX5cOPdtPQNRTDt
X-Proofpoint-ORIG-GUID: ffSjiLEijHxRilRZ6LX5cOPdtPQNRTDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240034

On 5/24/2024 12:33 PM, Greg KH wrote:
> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
>> zap_modalias_env() wrongly calculates size of memory block
>> to move, so maybe cause OOB memory access issue, fixed by
>> correcting size to memmove.
> 
> "maybe" or "does"?  That's a big difference :)
> 
i found this issue by reading code instead of really meeting this issue.
this issue should be prone to happen if there are more than 1 other
environment vars.

do you have suggestion about term to use?

>>
>> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  lib/kobject_uevent.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index 03b427e2707e..f153b4f9d4d9 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>>  
>>  		if (i != env->envp_idx - 1) {
>>  			memmove(env->envp[i], env->envp[i + 1],
>> -				env->buflen - len);
>> +				env->buf + env->buflen - env->envp[i + 1]);
> 
> How is this "more correct"?  Please explain it better, this logic is not
> obvious at all.
> 
env->envp[] contains pointers to env->buf[] with length env->buflen,
we want to delete environment variable pointed by env->envp[i] with
length @len as shown below.

env->buf[]            |-> target block <-|
0-----------------------------------------env->buflen
        ^             ^
	| ->  @len <- |
  env->envp[i]   env->envp[i+1]

so move "target block" forward by @len, so size of target block is
env->buf + env->buflen - env->envp[i+1] instead of env->buflen
-len.

do you suggest add inline comments to explain it ?

> thanks,
> 
> greg k-h


