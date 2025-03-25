Return-Path: <stable+bounces-125990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87FA6E949
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 06:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF3416BE57
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AA1A0BC5;
	Tue, 25 Mar 2025 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHNifEnJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A42907;
	Tue, 25 Mar 2025 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880655; cv=none; b=HT+LdHNzsilNByQ2S+ebzsNjj3FuXYsqmD3i3gjVBNqgWKeXisZQclC6oEbU1opdGqMx+CINPvaFUDhnGIwZ3Up0ffP739jhZYSfTQxb57tOCDgHnCnOGdK3JXWta+lNpN1mXixPIUffutMWKB4f2hOXeleXTT1/8hgbEQwyDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880655; c=relaxed/simple;
	bh=JArVNnUAwlj2MFnuwHDUQDbi3ZCgkRJVZPFi9PxPWtE=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sk636F8rjsAGR7AegpGyh1/qi7e/2G+5cD3PMvnnuKw4O8IATPzjkYEkG4rBG/Txx8tmVkvH75y/J13RwzDIR+qaL3wpXlubW1GRMLhW7jKx6Q1U2JBCFSI1KG3KpAhV7cokuN5A4r91FvgEVUkf6QaOAMWt5QjdjbcQhLmejK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHNifEnJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OJc19b007616;
	Tue, 25 Mar 2025 05:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3M0yFOikFeKKZNxfh746QOLOETK1JwkS+594envMNnA=; b=kHNifEnJzeMPsZCg
	7GuXrMeUk8tcePnk5YBUCzD2WR4z2RXrhsmAaDfEzs0ZRK4zo8enr42BhbOxTqK0
	QXxmZtPgZfMIU1eR/qxK4wdQByyQwbP8STY/Z5h+l7/zt4eJnQ8/CgXZXlHG1fhT
	TymwOH+ktqp0IJPoTsnUBWkcsDhjN5ab/iGB8ZVxBvRTlvWT4AsfJ82KsA2r+qOJ
	rqkLld2YbbZsXWraMvboRThegrki6OYl/ZRMu5EFdgFvpPXf8xGTahfwZBaXT2pi
	2S4XZNhn8BnbzpnpK8d0ouAt3UEYcQfUIscdFDi3Xd/eqjd5umVSlRpoeJzQAE5o
	3ljVtg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyjeeea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 05:30:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52P5UmWt020175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 05:30:48 GMT
Received: from [10.219.56.132] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Mar
 2025 22:30:46 -0700
Subject: Re: [PATCH v3] remoteproc: Add device awake calls in rproc boot and
 shutdown path
To: Bjorn Andersson <andersson@kernel.org>
References: <20250317114057.1725151-1-quic_schowdhu@quicinc.com>
 <6lyuwfypd5sq5fqu2ibgpxiulvq3txe6igxhrpqd4443z4zex4@5bvlrpohwg5c>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Message-ID: <0a1585ec-5e79-117e-32f9-f9678d362adc@quicinc.com>
Date: Tue, 25 Mar 2025 11:00:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6lyuwfypd5sq5fqu2ibgpxiulvq3txe6igxhrpqd4443z4zex4@5bvlrpohwg5c>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67e23f88 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=N659UExz7-8A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=3bjYy3hnNO--dNZ12UQA:9
 a=u9uUOCSzve6TOVsG:21 a=pILNOxqGKmIA:10 a=-_B0kFfA75AA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JXWO9wj0wcWckYK5glXDtkUGHk1KgmAI
X-Proofpoint-ORIG-GUID: JXWO9wj0wcWckYK5glXDtkUGHk1KgmAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_02,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250036



On 3/22/2025 3:51 AM, Bjorn Andersson wrote:
> On Mon, Mar 17, 2025 at 05:10:57PM +0530, Souradeep Chowdhury wrote:
>> Add device awake calls in case of rproc boot and rproc shutdown path.
>> Currently, device awake call is only present in the recovery path
>> of remoteproc. If a user stops and starts rproc by using the sysfs
>> interface, then on pm suspension the firmware loading fails. Keep the
>> device awake in such a case just like it is done for the recovery path.
>>
> Please rewrite this in the form expressed in
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
> Clearly describe the problem you're solving - not just the change in
> behavior.
>
> What do you mean that "firmware loading fails" if we hit a suspend
> during stop and start through sysfs? At what point does it fail?
Ack. It fails under the request_firmware call made in adsp_load under 
drivers/remoteproc/qcom_q6v5_pas.c
>
>> Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
> That patch clearly states that it intends to keep the system from
> suspending during recovery. As far as I can tell you're changing the
> start and stop sequences.
>
> As such, I don't think the referred to patch was broken and you're not
> fixing it.
Ack
>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Cc: stable@vger.kernel.org
> It's not clear to me from the commit message why this should be
> backported to stable kernel.
Ack. Will remove stability from mailing list.
>
>> ---
>> Changes in v3
>>
>> *Add the stability mailing list in commit message
>>   
>>   drivers/remoteproc/remoteproc_core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index c2cf0d277729..908a7b8f6c7e 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
>>   		pr_err("invalid rproc handle\n");
>>   		return -EINVAL;
>>   	}
>> -
>> +	
> You're replacing an empty line with a tab...
Ack
>
>
> Other than that, the change looks sensible.
>
> Regards,
> Bjorn
>
>> +	pm_stay_awake(rproc->dev.parent);
>>   	dev = &rproc->dev;
>>   
>>   	ret = mutex_lock_interruptible(&rproc->lock);
>> @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
>>   		atomic_dec(&rproc->power);
>>   unlock_mutex:
>>   	mutex_unlock(&rproc->lock);
>> +	pm_relax(rproc->dev.parent);
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(rproc_boot);
>> @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
>>   	struct device *dev = &rproc->dev;
>>   	int ret = 0;
>>   
>> +	pm_stay_awake(rproc->dev.parent);
>>   	ret = mutex_lock_interruptible(&rproc->lock);
>>   	if (ret) {
>>   		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
>> @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
>>   	rproc->table_ptr = NULL;
>>   out:
>>   	mutex_unlock(&rproc->lock);
>> +	pm_relax(rproc->dev.parent);
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(rproc_shutdown);
>> -- 
>> 2.34.1
>>


