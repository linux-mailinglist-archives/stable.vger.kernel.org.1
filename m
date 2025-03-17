Return-Path: <stable+bounces-124599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648AA64202
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960177A282C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07C79E1;
	Mon, 17 Mar 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cKq5ZtX0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714B38B;
	Mon, 17 Mar 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193940; cv=none; b=EPtCoWWZFN72P/h6K53mobp6hGiSccbIN6IJOa5BQrb73FB8wiUBGg41R96yr19pD+QElYI9bZf1bTX1yrec3DhHs89nzeTDNaJiMaUPhCNJXCJvtAX1OVuauAoHlgl3nsZ2BHSxvdmdkkyY1TH09Xi3/55CzMzoAB6koGJlf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193940; c=relaxed/simple;
	bh=s3b7+y++gfSN/qvS3e7lR37yQPwzv3HBi6QdlNd3/xw=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dogF2MOiiT1Iaeu4idHtqEEs/sjh54DGZOIOcXTyU4dNGtAFh03H3jrGbYisMOnttPbkCejXt4NHhD1+elJ64saCIF/H0tPBQ3FHB1VLAAj1x1+/3zIb4g8bSPM3+PWSXOG2jBidw2qzurNASLw02MFOaLCmqTMQCl1kiE+wNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cKq5ZtX0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GN0v39000505;
	Mon, 17 Mar 2025 06:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFJvksJOo1i7wsMZAVn3RO2VxECvjJcsHq03blLL2/s=; b=cKq5ZtX0FO3xKtD7
	hA565oIVvSOilP+KkbEMbLkPJZs7MpXqpXgAhTBB+ksM+wkSgSc+55yws32WYE3k
	j4vxLFtWH0ZEtr6HWakoUWUI0PNtJUgxyIZzJBvrft2AuoGKk/sY9/+tGqT+x5AB
	D25vKHdT+KRwQdPaq3ZpsfIcBBA96CNX2JThU1QllN6oKLYsj18WmAuWNU+xF9YO
	+0vA7lzMtrVCheTYUDrMR1gR1egNUJGc3iaLCI5v2B/QPHD6cVE0weFGXMsXoxX7
	Pf1LLkh7J9Rcb0CXyFv4PwK410RFV1Z8/u8gC4qTOZ5ZsMvMaYt6nGPMrJIHHgV+
	bDBlww==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxun8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:45:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52H6jU4k006792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:45:30 GMT
Received: from [10.219.56.132] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Mar
 2025 23:45:28 -0700
Subject: Re: [PATCH v1] remoteproc: Add device awake calls in rproc boot and
 shutdown path
To: Greg KH <gregkh@linuxfoundation.org>
References: <20250303090852.301720-1-quic_schowdhu@quicinc.com>
 <ec46a72f-f31b-c306-e57d-9bb7f58b24a2@quicinc.com>
 <2025031340-crux-nectar-b62c@gregkh>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Message-ID: <1226e147-9df7-e5d9-8d0b-7ef94cc1c446@quicinc.com>
Date: Mon, 17 Mar 2025 12:15:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025031340-crux-nectar-b62c@gregkh>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rkl3Zos1lRgl1ZFMrjlDF7f5GgEtJvRk
X-Proofpoint-ORIG-GUID: rkl3Zos1lRgl1ZFMrjlDF7f5GgEtJvRk
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d7c50d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=N659UExz7-8A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=YYWNctvE90rqYRJEuNsA:9
 a=pILNOxqGKmIA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=908 priorityscore=1501 clxscore=1011 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170048



On 3/13/2025 3:33 PM, Greg KH wrote:
> On Thu, Mar 13, 2025 at 02:42:10PM +0530, Souradeep Chowdhury wrote:
>> Gentle Reminder.
>>
>>
>> On 3/3/2025 2:38 PM, Souradeep Chowdhury wrote:
>>> Add device awake calls in case of rproc boot and rproc shutdown path.
>>> Currently, device awake call is only present in the recovery path
>>> of remoteproc. If a user stops and starts rproc by using the sysfs
>>> interface, then on pm suspension the firmware loading fails. Keep the
>>> device awake in such a case just like it is done for the recovery path.
>>>
>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>> ---
>>>    drivers/remoteproc/remoteproc_core.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index c2cf0d277729..908a7b8f6c7e 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
>>>    		pr_err("invalid rproc handle\n");
>>>    		return -EINVAL;
>>>    	}
>>> -
>>> +	
>>> +	pm_stay_awake(rproc->dev.parent);
>>>    	dev = &rproc->dev;
>>>    	ret = mutex_lock_interruptible(&rproc->lock);
>>> @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
>>>    		atomic_dec(&rproc->power);
>>>    unlock_mutex:
>>>    	mutex_unlock(&rproc->lock);
>>> +	pm_relax(rproc->dev.parent);
>>>    	return ret;
>>>    }
>>>    EXPORT_SYMBOL(rproc_boot);
>>> @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
>>>    	struct device *dev = &rproc->dev;
>>>    	int ret = 0;
>>> +	pm_stay_awake(rproc->dev.parent);
>>>    	ret = mutex_lock_interruptible(&rproc->lock);
>>>    	if (ret) {
>>>    		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
>>> @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
>>>    	rproc->table_ptr = NULL;
>>>    out:
>>>    	mutex_unlock(&rproc->lock);
>>> +	pm_relax(rproc->dev.parent);
>>>    	return ret;
>>>    }
>>>    EXPORT_SYMBOL(rproc_shutdown);
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
Thanks for the instructions, corrected in the next version.


