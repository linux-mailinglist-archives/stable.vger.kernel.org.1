Return-Path: <stable+bounces-126675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E315A710B6
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689613B1C16
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646A16C684;
	Wed, 26 Mar 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CYnczo+S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5742E3370;
	Wed, 26 Mar 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971526; cv=none; b=ugTISm/jaQyt5yi4/7vqrYzNE+kOmJ8uYItQs/CZke39ZYse4vg8ebqmpx3bkSafbs7a27cEoxhiMHkmLLwxQIkT99ZRklakGu4TVWPl5ohI7kcDc/LonZoRpurm12nK8WvMG7UAIecHOYmsVgRIiyIZTRy4N5e/L9tMezZyTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971526; c=relaxed/simple;
	bh=oiypN598uF6V6jJVYKswR75CGS8EvahQEBQfXkQIPG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bEGx5n57jIKl1jdVNSBQxolrdrE88uAuQubZJu5a4+opWA9F0vCoelswKj9FCyk2Uq/bJt3aUcSV+O62qFvxDbXJY7OSdmlTjECbEKzii1a40rU86eJU6z0cAnF93gJQqcDHCNWN8mkrhFVypPpqNRk4wDZYOlgRf4weuQHelfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CYnczo+S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q64GBL026608;
	Wed, 26 Mar 2025 06:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d//EkLK8NlNhrMxANYCpSXjTkPzJKf9XO3dDZrPjyb4=; b=CYnczo+StkThpktw
	v/OqgyADRy3nZv1CHyRHSpAeWT5DN9ThhTw5OfNVcY9+k5KOtcC005gShLvx5hqG
	aUAT9ys0k2q3FhZ0SgF11+j5UaWGkEQz9FcywnPXkQw9a0M+ByZ6nOoTASQ6hAeE
	ji3Rmw5oCoDqYUunU6l0LUhfHeKKkuDD0ylC241psTlQ7iwJ4VDfT6wPF0eo7j9X
	ly6cHIG+ftuTVHrBm8Q8xtuIxMut1Or6me6WB2EY3nkZ4AxO+b7UF84pYvpdE/tQ
	H0acLYQKeywEFr7JL8eY+5sTzouXDfjyH54JyII+5v1vn+XM8aGYaqSUz26B1L8g
	9dE1Gg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcybwy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 06:45:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q6j6U1011352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 06:45:06 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 23:45:03 -0700
Message-ID: <8c624cf0-febc-4ab9-8141-2372bfe4d577@quicinc.com>
Date: Wed, 26 Mar 2025 12:15:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
To: Frank Li <Frank.li@nxp.com>,
        Manjunatha Venkatesh
	<manjunatha.venkatesh@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <bbrezillon@kernel.org>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rvmanjumce@gmail.com>, <stable@vger.kernel.org>
References: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
 <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e3a273 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=v-MiteamF9m1uwOrjlcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: L2jECwzCxSH8wi0t7I2AstVutKQazjYD
X-Proofpoint-GUID: L2jECwzCxSH8wi0t7I2AstVutKQazjYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260039



On 3/25/2025 8:13 PM, Frank Li wrote:
> Subject should be
> 
> i3c: Add NULL pointer check in i3c_master_queue_ibi()
> 
yes, Aligned.
> On Tue, Mar 25, 2025 at 03:53:32PM +0530, Manjunatha Venkatesh wrote:
>> As part of I3C driver probing sequence for particular device instance,
>> While adding to queue it is trying to access ibi variable of dev which is
>> not yet initialized causing "Unable to handle kernel read from unreadable
>> memory" resulting in kernel panic.
>>
>> Below is the sequence where this issue happened.
>> 1. During boot up sequence IBI is received at host  from the slave device
>>     before requesting for IBI, Usually will request IBI by calling
>>     i3c_device_request_ibi() during probe of slave driver.
>> 2. Since master code trying to access IBI Variable for the particular
>>     device instance before actually it initialized by slave driver,
>>     due to this randomly accessing the address and causing kernel panic.
>> 3. i3c_device_request_ibi() function invoked by the slave driver where
>>     dev->ibi = ibi; assigned as part of function call
>>     i3c_dev_request_ibi_locked().
>> 4. But when IBI request sent by slave device, master code  trying to access
>>     this variable before its initialized due to this race condition
>>     situation kernel panic happened.
> 
> How about commit message as:
> 
> The I3C master driver may receive an IBI from a target device that has not
> been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
> to queue an IBI work task, leading to "Unable to handle kernel read from
> unreadable memory" and resulting in a kernel panic.
> 
> Typical IBI handling flow:
> 1. The I3C master scans target devices and probes their respective drivers.
> 2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
>     and assigns `dev->ibi = ibi`.
> 3. The I3C master receives an IBI from the target device and calls
>     `i3c_master_queue_ibi()` to queue the target device driver’s IBI handler
>     task.
> 
> However, since target device events are asynchronous to the I3C probe
> sequence, step 3 may occur before step 2, causing `dev->ibi` to be `NULL`,
> leading to a kernel panic.
> 
> Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent accessing
> an uninitialized `dev->ibi`, ensuring stability.
> 
>>
>> Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
>> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
>> ---
>> Changes since v4:
>>    - Fix added at generic places master.c which is applicable for all platforms
>>
>>   drivers/i3c/master.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index d5dc4180afbc..c65006aa0684 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2561,6 +2561,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>>    */
>>   void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>   {
>> +	if (!dev->ibi || !slot)
>> +		return;
>> +
1. Shouldn't this be a Logical AND ? what if slot is non NULL but the 
IBI is NULL ?

2. This being void function, it doesn't say anything to caller if it's 
successful or failed ? Should we make this non void function ?
if not, i am thinking it may run into multiple attempts, no log too.
>>   	atomic_inc(&dev->ibi->pending_ibis);
>>   	queue_work(dev->ibi->wq, &slot->work);
>>   }
>> --
>> 2.46.1
>>
> 


