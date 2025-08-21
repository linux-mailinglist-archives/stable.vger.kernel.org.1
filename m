Return-Path: <stable+bounces-171966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD18B2F4D4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F4972867F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253C2E62A7;
	Thu, 21 Aug 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuGITtCG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8B278146
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770740; cv=none; b=itzJIzGGloUgrJ/Ml7uYV8SNUOdqYYHA3WCwAl4oMB5Rv+zGIMA3DwZC9GZsAqNSBPlfN7QDL1vQJuPMjPeN9gpeAyV/4eaMDKzhRXgVpft3ZUTe58zmYz+vzc/fOJ7yxLbT4kEtdYAbSPcuhL1tKGPIQUCQU8FHqDmQjSG0j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770740; c=relaxed/simple;
	bh=W55lIs0o4bVzwB1sO3ZceQBJ9S3lG+nynjMBHwc5ly4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jXjHqFqX0A6BaCRp4YfMT/WwlxSJXjeFBP8IqIuGTahtwwy5nKfWtlGu6gIdvX30PJhr4VEJsRt9kG1fGBPJvcWjYUoTN6JXbL88ASYcdSW2z8xJcvBE9EfEHndNyUFfnxIguLFiXMKsaB3VaQGsiSjf9lfyiYiB4s5G2wmytho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RuGITtCG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bHWt012893;
	Thu, 21 Aug 2025 10:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xEo7bUQQUH84AKWD0zlcF0q9tkWIFq48lNEKGmT3F4Y=; b=RuGITtCGztjQ3m1U
	YVzSIdPrZ/J6R1azXXTh/lfi5XbKElS39UYSGisFbIVJ2GlsR9lBCsdiYvWh1DAW
	IvfNV7IyM+3J3rJ6xguzJ0RlEZdCT2lrob8adofd5nrBrIFZ4WmRrHHUC1r0xFcQ
	dVfIigkBxsFA8m511r2gex8hKpV1vY1UP+4q1iuw0+HTFuIfLp3l8gt/2OfCb3mb
	gGrs4V3lECNorG+ouzMthGpySqJQCwklJF8Y1hd3qQJNyNGf3d6RH7SRq55cTlvv
	sLLWhtF7M8mIUoAiRaxeZm1bwYwvId9pFkK2cUQ3pWR0eTOq4Uu/Cufibprz/gAf
	w9dPpg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8atg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:05:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57LA5aH9026860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:05:36 GMT
Received: from [10.217.219.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 Aug
 2025 03:05:34 -0700
Message-ID: <c49ff042-2a24-4500-9069-e5defb72f695@quicinc.com>
Date: Thu, 21 Aug 2025 15:35:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tty: serial: qcom_geni_serial: Improve error handling
 for RS485 mode
To: Greg KH <gregkh@linuxfoundation.org>
CC: <quic_msavaliy@quicinc.com>, <quic_vdadhani@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250818105918.1012694-1-quic_anupkulk@quicinc.com>
 <2025081912-exerciser-universal-f920@gregkh>
Content-Language: en-US
From: Anup Kulkarni <quic_anupkulk@quicinc.com>
In-Reply-To: <2025081912-exerciser-universal-f920@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX/8DJdyJ8+rl/
 8HTexEcm+pOiiNI/yR1eOW4LWMECeLslg0SfOydHsNiK1wHIpOo/Cvo33hztXbwFg2/DCFVtbWd
 hsuEffDIIbcpl43BZYkjc9O0FPUbpCg8WqJ+Z6Zb2iBBDrtlJ40xFQlDftSv2QrKcX5oqC8QROo
 tMEz3oTtk9OVNO2I+0kCchQJ1Z2Ct/mrhrL2wQ3YXTZ29coGgKkYsoVXLyyjOdbyHDMXIwFiLiN
 ZNcXNkGKcbZM+qyVI1BXfnhR7oHAMTUijmw4n13Vs65pWcvIrt6TdbZW6UhPQ5XQLVfGprXs3s9
 FSaUPEktZDtalmrwC4GGDanY+SfGdZHDrmTEnCvcvirbVuDTeo8SpcEBpVWpnidopY2+Vq5U34J
 J9FEkNaf9nJqqV8iEPo3oJ761Hh2bg==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a6ef71 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=Rb9XUztAbtOzyq8rFsEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: W4geuaDlOEkd2TOdFF87CByBcBYLEqBy
X-Proofpoint-ORIG-GUID: W4geuaDlOEkd2TOdFF87CByBcBYLEqBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

Hi Greg, 
This patch was supposed to be for internal peer review, and I mistakenly sent it
to stable@vger.kernel.org. Apologies from my end. 

Will not include you or other lists, for internal reviews. 
Apologies from my end again. 

On 8/19/2025 4:32 PM, Greg KH wrote:
> On Mon, Aug 18, 2025 at 04:29:18PM +0530, Anup Kulkarni wrote:
>> Fix  error handling issues of  `uart_get_rs485_mode()` function by
>> reordering resources_init() to occur after uart_get_rs485_mode.
> 
> What exactly is wrong with the current code?
> 
>> Remove multiple goto paths and use dev_err_probe to simplify error
>> paths.
> 
> Don't mix fixes with cleanups please.  Shouldn't this be 2 patches?
> 
> 
>>
>> Fixes: 4fcc287f3c69 ("serial: qcom-geni: Enable support for half-duplex mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
>> ---
>> v3->v4
>> - Added Fixes and Cc tag.
>>
>> v2->v3
>> - Reordered the function resources_init.
>> - Removed goto.
>> - Added dev_err_probe.
>>
>> v1->v2
>> - Updated commit message.
>> ---
>>  drivers/tty/serial/qcom_geni_serial.c | 38 ++++++++++-----------------
>>  1 file changed, 14 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 32ec632fd080..be998dd45968 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1882,15 +1882,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>  	port->se.dev = &pdev->dev;
>>  	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
>>  
>> -	ret = port->dev_data->resources_init(uport);
>> -	if (ret)
>> -		return ret;
>> -
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!res) {
>> -		ret = -EINVAL;
>> -		goto error;
>> -	}
>> +	if (!res)
>> +		return -EINVAL;
> 
> But now you are not calling the stuff that was previously at error:, are
> you sure that is ok?  If so, why?
> 
>>  
>>  	uport->mapbase = res->start;
>>  
>> @@ -1903,25 +1897,19 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>  	if (!data->console) {
>>  		port->rx_buf = devm_kzalloc(uport->dev,
>>  					    DMA_RX_BUF_SIZE, GFP_KERNEL);
>> -		if (!port->rx_buf) {
>> -			ret = -ENOMEM;
>> -			goto error;
>> -		}
>> +		if (!port->rx_buf)
>> +			return -ENOMEM;
> 
> Same here.
> 
> As you are mixing different things in the same patch, it's hard to find
> the original "bug" you are attempting to solve here.  I can't see it...
> 
> Please redo this as a patch series.
> 
> thanks,
> 
> greg k-h


