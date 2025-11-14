Return-Path: <stable+bounces-194793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C19C5D680
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 14:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3FC4EDA70
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972231D375;
	Fri, 14 Nov 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Px8eC1GN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpF5mLJC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885831C56D
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127636; cv=none; b=eHFcr0nejmWfdoPYXppaVIcF8/r0DrddS/IeWcmNx0S3+Wv4zY9+GHtIaOK08cGZO9sBmnC3NXFqmgFkKvbbJSkDg4cN5Y1Hgul3gScDTmioelHnPeTWAtJSmN28FdhUj5pCEznITZ8o9Dx7GejxDfcbdrIxTECXN71wIwbLc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127636; c=relaxed/simple;
	bh=5A6JdhBRmv6MbsALQsZRtyY2qGt4NnOfRC53jAZgmFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpQU59BbD6BV/TOidVYsyrImFXyHRyqmHI5a79h8QK6AIbtNLHR9u/JQKVTPH1opgatFg5G17OdiAM0g+/Kplua97pLdD6jYuMh43NPUYf3m1u4LKW9r+hA2KD/3U5NUeHFiqaxgahmKBKoj81I8M5OjweNJEoCSYYNmGVz03Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Px8eC1GN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpF5mLJC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE81NSE1630688
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 13:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8h49vkr88QSRBl9WHezGJ3lwgPLQouFMI9a6UN+Msr4=; b=Px8eC1GNB+h53rBi
	AHLdNzs9wzRong0sgZpOFxhmv8tOx2bGXzY6g48J0V4yTldUCYZ7HvhWIRLCc9/B
	dZzQe7rWq7T2rFNrpB3t6A9i90zdUJlTL7DKJOiP+vqlA7esjgnN/nFesuwUKIHJ
	tEOuzegbRECPDxnDtJGKWVZP1UrJWDrS2L5CD61BnK786Q73j8o4b3hbVuaOvTfW
	CRSvt4IGa9v0jLQV7SqS57w2+vYNZO9F80COknejBqcHUA5cYcxtySm8Sb63Ooql
	jfuiNrza+y/oPuqr2RI/qTJv1fGGzVgqOw3ds9K7FsC8QIujV+WaUzU0QolzpS8P
	M3bS9w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9daatf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 13:40:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b8ed43cd00so2561993b3a.2
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 05:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763127633; x=1763732433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h49vkr88QSRBl9WHezGJ3lwgPLQouFMI9a6UN+Msr4=;
        b=fpF5mLJC7wXF1HJYs1njWkIFyqETCdgArEkaTO8+rbQmIQBRu3SCTYBrO3Jo1hNA2B
         IHJbSNM9fPugmi+Z+8517eLXQH99vUIGnCgT5otv3hJ7Y9Ag2t+uohDVolYBks9Vqwxt
         7p1cTUvj25Db+tiBAW1p8Ns7gJxtZTmfJBZOiW682FLlI36EjQ+7x4Wdp1d0+KYj/CkV
         XOUNjzCpdWuP6sfj9uxgMZ/phVeZp09juHoagKqtT53yuCKlGF6by542TvzaEn013+sz
         jPS9FtyacAuEVXCxsSNtRYN98K4uJZ8KxxNl49ykyaR7vZHe8sSXNZvvAyOJRW+zfaV2
         1z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763127633; x=1763732433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8h49vkr88QSRBl9WHezGJ3lwgPLQouFMI9a6UN+Msr4=;
        b=Z3pQ/Fq/soranqKN8XhNLq1dfrgzCxncPC0ZjtFt2RtwOU0x7a0WzKhr792V8kgqfs
         GSFW+wnkbry8jlSSZVThLD4ItMJF80yEGpZayrlEx/Dr8uwQZmF4c/dsDxXSLjY6k+vj
         zNa9iskVyi4EcIzPA1JXnLJ3En6Au2HSfHnRd+dz4YGqIrFQqbIIHE8bhseTYIv4PJnD
         u3dzA+3czxF/dix5ZWxN6sKn0me8HRP0eNamgSkP8vL82AaZfIFMEcwGEN0NEgdxJDHO
         rPwuy7XIs8Mc4YdZYd8bryFDEBPPz4p6B4HrBCAbcRsiGlXJXlLO/6GkcIxsQGViA0Gi
         xUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXun6yXUllZIo3YsTk8BXl95kqi21VBLdBb3jOFzK9URuZ+B/FoYCATMOCMSoeKgKiMNBmXGNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/F2lpwt0gpzTpNX8f2+1vNYYnIN1C8ckBxPmc8HVR00CoQCU0
	tc6QfSHrhPGNryB6f6q3tXHIjoBWGqXRyrbChjBJ+fwQz6xExOykM2D0XyMqQW9EIdYYB8nA/Nh
	PN/7btHylJU4B/89qM839TbPT02+disbr8X4vmIv5rp5wz3sWuSKWv966WtA=
X-Gm-Gg: ASbGncspT6QnSameTj/AqsDlndaKxZ+PLMY//6QZ5ff9hrPsRck2Fh/9gBqmJ5aOy0E
	uWMKAjGT0wwYf8Y3Icom0sjFc9euU+HqOpOE9bUCvwkJZRu3fN94dZ+V4cSjPabRB8nCWOPweXI
	P7iuTYVOkJ9YtMTP8Jj8QBm4yNuQthY5HN0c5Isr7URQONeT+jrLZ9Xu0fjZvzppXBG1J4QJHXT
	7Ay8SXGz9vmWJU+1saqFwnO2zhmyGjFmq9scCZm3PkegksehcXYWf5qKjArCdZd9+m4EL6XWIPC
	r1CDswVXDxUx83MwkocS3h3Q43ikX0AEM57w0g8RhGyKTe7bSn0PGW6S9sk2jJBlKTaSHy7gmZ0
	ipNOsnjt2w1dQuL3tPYJpzfHGW016Dn7hixz+wJrLffUmxpcJdfR7z6ROuPh+DcmvmEAuT9YI49
	eBnpUO
X-Received: by 2002:a05:6a00:4b12:b0:780:ed4f:e191 with SMTP id d2e1a72fcca58-7ba3c479c6cmr3119081b3a.23.1763127632765;
        Fri, 14 Nov 2025 05:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU919LE5QV0HkXIS1uAsaA3rGe0/n1O0dclAyr16aS8Fl3W3rmFXwCmYqvA/A5OkK9XfJp6Q==
X-Received: by 2002:a05:6a00:4b12:b0:780:ed4f:e191 with SMTP id d2e1a72fcca58-7ba3c479c6cmr3119053b3a.23.1763127632266;
        Fri, 14 Nov 2025 05:40:32 -0800 (PST)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9256b8824sm5284823b3a.31.2025.11.14.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 05:40:31 -0800 (PST)
Message-ID: <b24c5bdd-06f1-49ad-9055-3365de64f1c5@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 21:40:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rpmsg: char: Remove put_device() in
 rpmsg_eptdev_add()
To: Dawei Li <dawei.li@linux.dev>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        set_pte_at@outlook.com, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20251113153909.3789-1-dawei.li@linux.dev>
 <20251113153909.3789-2-dawei.li@linux.dev>
 <b754155b-a17b-4e8e-92b7-8ab37949dded@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <b754155b-a17b-4e8e-92b7-8ab37949dded@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z9qU03-sB3SUqgM7VyZxbNLMUXLxXZbk
X-Authority-Analysis: v=2.4 cv=Rdidyltv c=1 sm=1 tr=0 ts=69173151 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=sFvjiMhPOwDUbjvKCIEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Z9qU03-sB3SUqgM7VyZxbNLMUXLxXZbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEwOSBTYWx0ZWRfX9+Pr1BzvYyTh
 uLTla/WAXBXg+YkYXWATq0W9Qof2CvNdkFvfoY607EMWqckQlc8RNyXhU7XWX3OpLuPQojEinsJ
 yoZDmZDqCJxo8xqHs1Jcj+f5/YOnWu80W4TtSjRItKAZMO21+aU8m0NsUMPUc98vITMSASDOez+
 h089Wp0cvDRPXj3SAXGQ1X78zz4dKp8EvWUJG4vUpfLNNij0ABZTMacD5GlOXYWkMZhQZJk/bGM
 dTzxF1xq3YCfpqsfmGpn6fhG+r7TA73DHCaa9vy8F3PA4OVpB8LHNaXnFBBanzyTDp9rBrS87UX
 duwZ23s221FpBpyJ1/bqILX38LTKHchckRUVkXJwW0MNUfYG+U3UtolzW4BCmdRfeLfP7NSLgRS
 p6KWlRx12vncW2UKy53D2QLrWOdduA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140109

On 11/14/2025 5:53 PM, Zhongqiu Han wrote:
> On 11/13/2025 11:39 PM, Dawei Li wrote:
>> put_device() is called on error path of rpmsg_eptdev_add() to cleanup
>> resource attached to eptdev->dev, unfortunately it's bogus cause
>> dev->release() is not set yet.
>>
>> When a struct device instance is destroyed, driver core framework checks
>> the possible release() callback from candidates below:
>> - struct device::release()
>> - dev->type->release()
>> - dev->class->dev_release()
>>
>> Rpmsg eptdev owns none of them so WARN() will complaint the absence of
>> release():
> 
> Hi Dawei,
> 
> 
>>
>> [  159.112182] ------------[ cut here ]------------
>> [  159.112188] Device '(null)' does not have a release() function, it 
>> is broken and must be fixed. See Documentation/core-api/kobject.rst.
>> [  159.112205] WARNING: CPU: 2 PID: 1975 at drivers/base/core.c:2567 
>> device_release+0x7a/0x90
>>
> 
> 
> Although my local checkpatch.pl didn’t complain about this log line
> exceeding 75 characters, could we simplify it or just provide a summary
> instead?
> 
> 
>> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dawei Li <dawei.li@linux.dev>
>> ---
>>   drivers/rpmsg/rpmsg_char.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index 34b35ea74aab..1b8297b373f0 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -494,7 +494,6 @@ static int rpmsg_eptdev_add(struct rpmsg_eptdev 
>> *eptdev,
>>       if (cdev)
>>           ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>>   free_eptdev:
>> -    put_device(dev);
> 
> 
> Yes, remove put_device can solve the warning issue, however it would
> introduce one memleak issue of kobj->name.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/ 
> tree/drivers/rpmsg/rpmsg_char.c#n381
> 

The above link I arised was wrong; it’s now updated to the correct one.

https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/rpmsg/rpmsg_char.c?h=for-next#n476


> dev_set_name(dev, "rpmsg%d", ret); is already called, it depends on
> put_device to free memory, right?
> 
> 
>>       kfree(eptdev);
>>       return ret;
> 
> 


-- 
Thx and BRs,
Zhongqiu Han

