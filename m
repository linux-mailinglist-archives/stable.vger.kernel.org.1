Return-Path: <stable+bounces-47634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5F8D347B
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4ABB23D33
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD117A934;
	Wed, 29 May 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UorkxnwZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1817A939;
	Wed, 29 May 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978095; cv=none; b=c8fSmbOZClh+srQ1DHNmHs82rfi7Ms3F6Pt4EqP00QvKPqAVePAy1n6fmJlKtSL4wnaQw1DXOLu4TQc7lqVRVwO42GeOnamIG968cker0bg7V6Xs085jPC5aN6S3GOLDrMFj8j3jUnIQdoNbFHV7NOdvh78GxO87giFiMj7/jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978095; c=relaxed/simple;
	bh=9M1eItZpeVRAAB+hbA9RxHQ+zQLLx5HRy9nkmkq5pzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgcPzLcNUnyHg1PDiey/ACitXibCVDsjlsfroWI+QZlcnUwwLCCztQ5oYG3/6zijzHZMECdRGdADehSmDSA/2AJQKklKTq3zFXsURj7MLzyrHgMqFoyP1xZgK5IMl3GIjRFu6rEMqrkvZPXCGUJDrJfJ/8FZ1vs9GUQO/OWaQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UorkxnwZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SN1W28013544;
	Wed, 29 May 2024 10:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJD2zaZxSX/rGQntSM+iQHBKMz4pDWs3rOyBzHgjJ7U=; b=UorkxnwZzbZ58unO
	16bl0DW6wUuIeyS/Aelo+9m0191GD1o8SfVebhNCyrT6bLXiV1zMJ93fAAKebRQQ
	XkEL5uvkYyVFbXc76xYYDatg24V5oRdw8UD2ayCHa4fauAeQhLR8PNMrI2o6n8N1
	pfeURk26wpJrkBOEyIu/KQwZgmGHa5wkzl9UM642JZtC13p2jGduVZWKwKYOMBJi
	iENJ6HMQ3cBUBn3N5mtqkghdOvLWuKQiMC1E6RP+daEwxxVE+GnneIwp09yeFem2
	LkH3SNUyAXB0f9ES81z669FX3GW1rRsz5KOhHggZNzOTMw9mfIoi61zY6S1vWJNS
	TqkQlA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0prjeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 10:21:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TALR1I015720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 10:21:27 GMT
Received: from [10.253.14.197] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 03:21:25 -0700
Message-ID: <9d7be8f5-c7f5-4188-8878-6ce519867ed9@quicinc.com>
Date: Wed, 29 May 2024 18:21:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kobject_uevent: Fix OOB access within
 zap_modalias_env()
To: Greg KH <gregkh@linuxfoundation.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <1716866347-11229-1-git-send-email-quic_zijuhu@quicinc.com>
 <ZlYo20ztfLWPyy5d@google.com>
 <74e2db16-007a-4b31-b43d-649516000f16@quicinc.com>
 <2024052933-extended-spender-fc41@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024052933-extended-spender-fc41@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rh8NUvPS7yV1K5UzWyi-Lm32h1REwGIz
X-Proofpoint-GUID: rh8NUvPS7yV1K5UzWyi-Lm32h1REwGIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290069

On 5/29/2024 6:17 PM, Greg KH wrote:
> On Wed, May 29, 2024 at 06:07:06PM +0800, quic_zijuhu wrote:
>> On 5/29/2024 2:56 AM, Dmitry Torokhov wrote:
>>> On Tue, May 28, 2024 at 11:19:07AM +0800, Zijun Hu wrote:
>>>> zap_modalias_env() wrongly calculates size of memory block to move, so
>>>> will cause OOB memory access issue if variable MODALIAS is not the last
>>>> one within its @env parameter, fixed by correcting size to memmove.
>>>>
>>>> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>> V1 -> V2: Correct commit messages and add inline comments
>>>>
>>>> V1 discussion link:
>>>> https://lore.kernel.org/lkml/0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com/T/#m8d80165294640dbac72f5c48d14b7ca4f097b5c7
>>>>
>>>>  lib/kobject_uevent.c | 17 ++++++++++++++++-
>>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>>>> index 03b427e2707e..f22366be020c 100644
>>>> --- a/lib/kobject_uevent.c
>>>> +++ b/lib/kobject_uevent.c
>>>> @@ -433,8 +433,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>>>>  		len = strlen(env->envp[i]) + 1;
>>>>  
>>>>  		if (i != env->envp_idx - 1) {
>>>> +			/* @env->envp[] contains pointers to @env->buf[]
>>>> +			 * with @env->buflen elements, and we want to
>>>> +			 * remove variable MODALIAS pointed by
>>>> +			 * @env->envp[i] with length @len as shown below:
>>>> +			 *
>>>> +			 * 0          @env->buf[]      @env->buflen
>>>> +			 * ----------------------------------------
>>>> +			 *      ^              ^                  ^
>>>> +			 *      |->   @len   <-|   target block   |
>>>> +			 * @env->envp[i]  @env->envp[i+1]
>>>> +			 *
>>>> +			 * so the "target block" indicated above is moved
>>>> +			 * backward by @len, and its right size is
>>>> +			 * (@env->buf + @env->buflen - @env->envp[i + 1]).
>>>> +			 */
>>>>  			memmove(env->envp[i], env->envp[i + 1],
>>>> -				env->buflen - len);
>>>> +				env->buf + env->buflen - env->envp[i + 1]);
>>>
>>> Thank you for noticing this, it is indeed a bug.
>>>
>>> I wonder if this would not be expressed better as:
>>>
>>> 			tail_len = env->buflen - (env->envp[i + 1] - env->envp[0]);
>>> 			memmove(env->envp[i], env->envp[i + 1], tail_len);
>>>
>>> and we would not need the large comment.
>>>
>> Greg KH suggests add inline comments since my fix is not obvious with
>> first glance, let us wait for his comments within 2 days about below
>> question:
>> is it okay to remove those inline comments if block size to move is
>> changed to env->buflen - (env->envp[i + 1] - env->envp[0]) ?
> 
> I'm all for making this simpler, please do so as Dmitry's response looks
> better and easier to understand, don't you think?
> 
> And add comments, they are always good here for stuff like this :)
> 
okay, will send v3 to take Dmitry's suggestion and keep inline comments.
> thanks,
> 
> greg k-h


