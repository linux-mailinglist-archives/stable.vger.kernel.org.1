Return-Path: <stable+bounces-126683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4449DA71122
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 08:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846FD7A245E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709E1993B7;
	Wed, 26 Mar 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aFg/fdwE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7C1990D8;
	Wed, 26 Mar 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973056; cv=none; b=Bf9Q5vJ5mUkvwkRuvjm10s5KLB8zbzm5eWtfbQMkS13cUZWq8sRwdO/vXWjtiO930tAKSHd1rRUfP7wb144ZEDPHeBicALVprvlAJO7Ga3PgnsxpKam/5m0Ek1S7okzWW1VM3ceQwonTsY2b+Wj38H5TqffBE2vZw7ADDFXG4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973056; c=relaxed/simple;
	bh=pg0PxGOC3C9ExTcKwQDmVm/v35Bf22iPakRzYRqZR3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cwTXocALEQvjboQxUBTgOvD4TP3bh/wc1+NgOzQkxmRLeEZFwGmBXbR/M59gCArAek6HPHxFy1lt6fHihAn41sXlcQvpI+fb0o92Ux8VFBrQwAD4yVowyVCNjJDkWOY0lv2byNU1O3Ob1w8LMlJtGziltr0k3aYVhHFMFX9A7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aFg/fdwE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q737EG004065;
	Wed, 26 Mar 2025 07:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ps4jDZtSQv+h55bH8VjAcS38Zn8hgipwCPWFAZ1jOkc=; b=aFg/fdwEiCJnNI46
	BgDP9y9pY5BFODLo9zTjmL/FVgAvFjnHJkMgZoThPzZv71KEdzQ3yV+sEnWWO2CO
	Ti4L+pxa4HUtkf3g/2/cd5WwfdtXFt7Maf+mna2ft45bLGtZ/ta/6Iz18E+AWD7a
	M+2vCv+MHtwuTXE4n7Vc33SVywjorjRoUoHETFnKbxO701MTGI89xeonxbC6Cpx9
	6KXSw9BXUEQNqecMlaT39zgTLCDcLjUB2SyCLtRKjS35le5ke/UWzFukfEYyEt0b
	dDS3Y/CMbFEveY/nNKPCrR0F0rapWi20hboisexb/aNaAnR/Zi72tg5sRYwlJTNb
	HSTSmQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcyc04s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 07:10:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q7Afmv025620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 07:10:41 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Mar
 2025 00:10:38 -0700
Message-ID: <fc59e721-3e43-4b81-8c35-75b33e9e6fc9@quicinc.com>
Date: Wed, 26 Mar 2025 12:40:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        Frank Li
	<frank.li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org"
	<bbrezillon@kernel.org>,
        "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rvmanjumce@gmail.com"
	<rvmanjumce@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
 <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
 <8c624cf0-febc-4ab9-8141-2372bfe4d577@quicinc.com>
 <VI1PR04MB10049E90AC1CB4823F91D1D698FA62@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <VI1PR04MB10049E90AC1CB4823F91D1D698FA62@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e3a871 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=UqCG9HQmAAAA:8 a=COk6AnOGAAAA:8 a=8AirrxEcAAAA:8
 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=hwt3D7lepPnkcdXaZawA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: dbc5crea0z5QoNzLft0YGSSzxQCZVH1P
X-Proofpoint-GUID: dbc5crea0z5QoNzLft0YGSSzxQCZVH1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260042



On 3/26/2025 12:28 PM, Manjunatha Venkatesh wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>> Sent: Wednesday, March 26, 2025 12:15 PM
>> To: Frank Li <frank.li@nxp.com>; Manjunatha Venkatesh
>> <manjunatha.venkatesh@nxp.com>
>> Cc: alexandre.belloni@bootlin.com; arnd@arndb.de;
>> gregkh@linuxfoundation.org; bbrezillon@kernel.org; linux-
>> i3c@lists.infradead.org; linux-kernel@vger.kernel.org;
>> rvmanjumce@gmail.com; stable@vger.kernel.org
>> Subject: [EXT] Re: [PATCH v5] i3c: Fix read from unreadable memory at
>> i3c_master_queue_ibi()
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 3/25/2025 8:13 PM, Frank Li wrote:
>>> Subject should be
>>>
>>> i3c: Add NULL pointer check in i3c_master_queue_ibi()
>>>
>> yes, Aligned.
>>> On Tue, Mar 25, 2025 at 03:53:32PM +0530, Manjunatha Venkatesh wrote:
>>>> As part of I3C driver probing sequence for particular device
>>>> instance, While adding to queue it is trying to access ibi variable
>>>> of dev which is not yet initialized causing "Unable to handle kernel
>>>> read from unreadable memory" resulting in kernel panic.
>>>>
>>>> Below is the sequence where this issue happened.
>>>> 1. During boot up sequence IBI is received at host  from the slave device
>>>>      before requesting for IBI, Usually will request IBI by calling
>>>>      i3c_device_request_ibi() during probe of slave driver.
>>>> 2. Since master code trying to access IBI Variable for the particular
>>>>      device instance before actually it initialized by slave driver,
>>>>      due to this randomly accessing the address and causing kernel panic.
>>>> 3. i3c_device_request_ibi() function invoked by the slave driver where
>>>>      dev->ibi = ibi; assigned as part of function call
>>>>      i3c_dev_request_ibi_locked().
>>>> 4. But when IBI request sent by slave device, master code  trying to access
>>>>      this variable before its initialized due to this race condition
>>>>      situation kernel panic happened.
>>>
>>> How about commit message as:
>>>
>>> The I3C master driver may receive an IBI from a target device that has
>>> not been probed yet. In such cases, the master calls
>>> `i3c_master_queue_ibi()` to queue an IBI work task, leading to "Unable
>>> to handle kernel read from unreadable memory" and resulting in a kernel
>> panic.
>>>
>>> Typical IBI handling flow:
>>> 1. The I3C master scans target devices and probes their respective drivers.
>>> 2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
>>>      and assigns `dev->ibi = ibi`.
>>> 3. The I3C master receives an IBI from the target device and calls
>>>      `i3c_master_queue_ibi()` to queue the target device driver's IBI handler
>>>      task.
>>>
>>> However, since target device events are asynchronous to the I3C probe
>>> sequence, step 3 may occur before step 2, causing `dev->ibi` to be
>>> `NULL`, leading to a kernel panic.
>>>
>>> Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent
>>> accessing an uninitialized `dev->ibi`, ensuring stability.
>>>
>>>>
>>>> Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
>>>> Cc: stable@vger.kernel.org
>>>> Link:
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
>>>> e.kernel.org%2Flkml%2FZ9gjGYudiYyl3bSe%40lizhi-Precision-Tower-
>> 5810%2
>>>>
>> F&data=05%7C02%7Cmanjunatha.venkatesh%40nxp.com%7Ceda8be8c7abc4
>> 3b4ab9
>>>>
>> 608dd6c31c8e7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6387
>> 856832
>>>>
>> 77582903%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
>> OiIwLjAu
>>>>
>> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
>> 7C%7C
>>>>
>> &sdata=oyc9Wv%2Fj8HMRFIiIGL9nIw0XvI6FsLK2SvsQJ55H7XI%3D&reserved=
>> 0
>>>> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
>>>> ---
>>>> Changes since v4:
>>>>     - Fix added at generic places master.c which is applicable for all
>>>> platforms
>>>>
>>>>    drivers/i3c/master.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c index
>>>> d5dc4180afbc..c65006aa0684 100644
>>>> --- a/drivers/i3c/master.c
>>>> +++ b/drivers/i3c/master.c
>>>> @@ -2561,6 +2561,9 @@ static void
>> i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>>>>     */
>>>>    void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot
>> *slot)
>>>>    {
>>>> +    if (!dev->ibi || !slot)
>>>> +            return;
>>>> +
>> 1. Shouldn't this be a Logical AND ? what if slot is non NULL but the IBI is
>> NULL ?
>>
> [Manjunatha Venkatesh] : I think Logical OR operation is correct,
>   Since if any one of the variable is NULL need to return before accessing those variables.
I agree, i was incorrect.
>> 2. This being void function, it doesn't say anything to caller if it's successful or
>> failed ? Should we make this non void function ?
>> if not, i am thinking it may run into multiple attempts, no log too.
> [Manjunatha Venkatesh] : If required we can add error print log, Others please confirm your opinion on this.
>>>>       atomic_inc(&dev->ibi->pending_ibis);
>>>>       queue_work(dev->ibi->wq, &slot->work);
>>>>    }
>>>> --
>>>> 2.46.1
>>>>
>>>
> 


