Return-Path: <stable+bounces-58054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDE9277A0
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C51C234F2
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91B1AE0B9;
	Thu,  4 Jul 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZldM6dRI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F632F37;
	Thu,  4 Jul 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101691; cv=none; b=tgQCONFypWJH+qHU6KBcoYAl7nBbVkzPoTi74G+UUc7CsovBmLjNqowNHtIfiZje+1Vm2aNEuYWZLuCFSbrvWTqa714FLAt1VPNxI87V3zUR8om/mNZ0oPRiGs6ztlGi52ySBCWaXAxiELdJ7w4j38icogyWcaVIASYZQV2r/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101691; c=relaxed/simple;
	bh=UFqN8xvCB8w9vIeI+cu2J0sVHAmfZ9jRZhHRZGntYjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=asLp2iZTD990r52Y8WAQZWRr6xcgzvcFBec6uUgb+7kmQHlcvT9YvulyzVfuMX/Monad4JI35fVdruAsWJ2mfcaCVpCH9SsNUP1tLrakUUjjB6oGPE5JfOQg5g6IL46fJ8fttIYT/g90ZcWTLaKlu48jwIKqPtkaKlTjLIKi18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZldM6dRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4647noL9015114;
	Thu, 4 Jul 2024 14:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rvrm85HRa0dhBRIcgLfXrelgW6iDhoI2iPvXaq7OgR4=; b=ZldM6dRI4srAatFx
	8kT5PL14lSET464rmd/i2N9PIxo9Ig/fs8gfPDGRTtwxCZNNWANHCIoEiovsgAJw
	r7QnwN0odgtXE9Jpfvuv4+eQC16ktbELN7upPhmLNP6z/xR+oUc7UcdeUEJtYUGU
	klfj+3J+sd3x+3wN/ZP1g5JiyPNswAlP1tjCuJJhe6/8eoikqFD3PU/ps8gwZ64q
	5kW/OUT6i8DVCZWYEoHOnl9OjS+7bQrwWNwooAlHNQmzG8Q/hF+z54DGpppCg1vg
	ZXzuUKvs/U4U2itzpzPdxUhfjWnC3dJYQ/XLtb+VRZWgIpq2DGQlB6RxiI+61AE8
	0kGkaQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996un0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 14:01:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 464E1J7r012872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 14:01:19 GMT
Received: from [10.253.9.70] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 07:01:18 -0700
Message-ID: <13741696-6f30-40b0-be95-2406208cbe0c@quicinc.com>
Date: Thu, 4 Jul 2024 22:01:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
To: Zhou congjie <zcjie0802@qq.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
 <tencent_6866D69439F77A09338872DC0398A84CB908@qq.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <tencent_6866D69439F77A09338872DC0398A84CB908@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -FtCGf4onjOmWOg-URm8vZYOAdi4M0ul
X-Proofpoint-ORIG-GUID: -FtCGf4onjOmWOg-URm8vZYOAdi4M0ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=859
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407040100

On 6/30/2024 11:08 PM, Zhou congjie wrote:
> On Fri, 24 May 2024, Zijun Hu wrote:
> 
>> Subject: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
>> zap_modalias_env() wrongly calculates size of memory block
>> to move, so maybe cause OOB memory access issue, fixed by
>> correcting size to memmove.
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
>>  
>>  			for (j = i; j < env->envp_idx - 1; j++)
>>  				env->envp[j] = env->envp[j + 1] - len;
>>
> 
> I notice it too.
> 
> In the debug, I find that length of "env->buflen - len" is definitely 
> larger than  "env->buf + env->buflen - env->envp[i+1". So memmove() just 
> copy some extra '\0', and the problem will not happen when the length of 
> env variables is much smaller than 2048. That is why the problem is 
> difficult to be observed.
>
yes, it is a factor of why this issue is not easy to be observed
> But when the length of env variables is close to 2048 or even more than 
> 2048, the memmove will access the memory not belong to env->buf[2048]. 
> 


