Return-Path: <stable+bounces-159144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7EAEF940
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09734A2050
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED36274653;
	Tue,  1 Jul 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQo39pa/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B2741AB
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374363; cv=none; b=K9qt9y38fSUEggucxrHQTdYfEK1LaHbMonjeEskObqYCWxEwxRpYTFqUlNGlXGY09Nl84FH6glR043Oh+NuLhQ+E0kpcPgC7ElhvIAqtMIEoIM22NZu5uzYvEzxOu/mY09qCLjdT+4in788XzrsBMwK9liOzXyb9syhDEgxzFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374363; c=relaxed/simple;
	bh=s6Km9kqmH3MHprC9cKJQioWs2nxJ+6oprPbTLVcSgX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUFaIvCv0Eyayz4q+eLvUt3EX8OWSb+nKdIugvJ+I/gtp4NPfN5nnYk1QkwTaEQ+mnZs1UkRDvhOREBbdzU81eJDIi9RkTw5wnnjVsHd3zM9D9LM8thFONGymBa0oVFP8yX/S91SuJPGOUiFV4ldu0GCZLQ2QM83CQofSCjKJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQo39pa/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561BrYtR029749
	for <stable@vger.kernel.org>; Tue, 1 Jul 2025 12:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u1cPDedYpfvPf50klVd2ABP2QmrtcRgKhFzFC6BNJEE=; b=mQo39pa/TId2IopA
	/ihw15S24Zv6MgtdIVTD4bFPyOQgyHt0ycTmPcyhtkEWFTir1eh4tgUnp19+W9mt
	tTgXMCRICO/yVkwxQz7lJFX5EhjfgUeUEG1k/8tx0p2xbHQeB1nFrrPjnkqeOj91
	+MBPrB+9frrqDu+5nufol6ft7Kru3GgZBh7m0weXNcpm5+MDfoBoU+8V3VNdH16G
	aPQpVrBDeLwkz3qVIl14gxqYaalfJ5YLJEZRInqA+Az+buNpsThHwK2AGUip/Ada
	qSiCloT3fYGNflm9YqxHbynMUm3gs/CiuDfq8Qx4nNViLxPQXrPOjseJtpDvCYiZ
	iIO65g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v2yq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Jul 2025 12:52:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7cfb7ee97c5so24416385a.1
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 05:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374359; x=1751979159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1cPDedYpfvPf50klVd2ABP2QmrtcRgKhFzFC6BNJEE=;
        b=L8zp6Deltvtn/4xUyYUAyfN5aVhebSvSjipGdqHYshFCHcG9b6RMrFse6Phn6GIC1q
         yJbTNIXJrolFY8MzqueOHbjBNJPDZpOZyNTDIDXUA3DYUKckkcCkcMPXNtcTWB3M4IB/
         7SspBd+DXG3lzGQhSFw1C3+s4XnO6OKRcckv/y7y0F3jPr71sPrFvYxTX6+T8WoL30fV
         I82QyyBIcnE6Qeoje8OLd8OKUniy2xNO549kD+Lmtk7/aYPKFyPpMBdmexQEKcfHclbE
         WzFxIqRxb1QY5lhwxe8wRnHMirhOVcwwBJJgCEtZUCTna/i9eCNSw/T+kQ+XJ6JiSwQd
         qybA==
X-Forwarded-Encrypted: i=1; AJvYcCV3MKqxpzlM9gCc4SHfV2df0Q4ro6DJeo+Ln4CcwbREixF9dUBAQg6IY40v7Zaq/QLJlffr/r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjyvvs6jug++pLAOODuwkcieU8i9ho6R+P61ut6rNszoWIZ+n4
	ljxzo0NfKsKF9wAArQpZnw1O3sV8yR2vvqKTFmCdmHJvWZVEZoFMAsjKPdgN2poWbTVWwoppJLD
	M21IOBNH9UN5dqT4CSlcvOugQwwTBcsPOT/KpDyDbIEdz8FKKv3+CG6ubJg4=
X-Gm-Gg: ASbGnctyg6VNXOsbc0c4wngt2QuMHeW5sGbLXoGUW9mD2zC94mgxSI/zLnGaF/QA47H
	FE8ZAsmyZipFpvFSRrSVn2b295WUk3JPs516F1n28YhO5CDfSV+B6I5LTPf4jqxIS2zWzpM4qOW
	OFG5r+FVeXwI1rrH06ZgGrtIIQaqbPtmri9ix4djbEvBSoRjrVAolp3dHmZljKAAzUD6xYv5kIH
	szhyXsg9diFg1uXsTvKlMh3oOVsI529UrJNuMziB7FtZ7NoCt5Zr8XiSxXGPxlw3Pkdvgs8iyKH
	y+8BdclwglA8PUzYN2aIhY3rIIl4tNRt5RcaeahnKe3NISAVUFuY9YLm4G5kRNImNXggnmirIy7
	OBQeMVAgB
X-Received: by 2002:a05:620a:1a0a:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d467737358mr162017085a.10.1751374359265;
        Tue, 01 Jul 2025 05:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Wskn5IkTC5clDFY3RNbkUQKyYUech94l/I/soWezJlddzlgn13MTDenGfT9lXqHy6X8jOg==
X-Received: by 2002:a05:620a:1a0a:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d467737358mr162008385a.10.1751374356706;
        Tue, 01 Jul 2025 05:52:36 -0700 (PDT)
Received: from [192.168.1.114] (83.9.29.190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831ff8b3sm7562620a12.67.2025.07.01.05.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:52:36 -0700 (PDT)
Message-ID: <64441b8a-2769-479f-8894-05c4580c96a2@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:52:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qup: jump out of the loop in case of timeout
To: Yang Xiwen <forbidden405@outlook.com>, Andi Shyti
 <andi.shyti@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250616-qca-i2c-v1-1-2a8d37ee0a30@outlook.com>
 <SEYPR02MB55575E3DE3A107D36F5393AD9644A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SEYPR02MB55575E3DE3A107D36F5393AD9644A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MSBTYWx0ZWRfX2s9mvMdDp8qu
 9hrrgpFZuzeHWuxqHdmhwvw6yHiv2Vola/I0DbmtPkn3h2MkG9T60bvKFTdpzBdPaR2ct36XLwK
 7mAgomgEdsumyY/yAqX7nXOgkeU1Rscm+65QSD/UZbpF7pxz3EatanqsZ7ci8g8VKpoQc/fp7fF
 T3dGiL2iIuUlkc0bHoefdReUibM41KYS6ei3YtDUXTa6D95PrAimzbWBS1QkvYg07AtY9w8yKmp
 r6MsVXbrboTzXZplIOL7o9DKWkaC7oD1xkEImddclr4ORvRJeuMTzeBtFNL1A7WJCI1LsbkVePN
 yAPLKELMkf9Br25K5rW1GrDIz375ytnhJDWAy3Tgn0NDCDmVmGSW2tt5leI2SDqJoMKgj67Ivma
 5RahRXz0RqHUw/K5PRYJdhM5PvmX+lapEjquHFkUHiRyzaLiWnJC/mekRADbdeYoRYiFa8gW
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=6863da18 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fKQzr7EGRj+VoE0XNsDNvQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=r0m3sDERyDekZ1TgD0UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Rn-jShLGv13N6zPzziHd3vIWDuw3ywj7
X-Proofpoint-ORIG-GUID: Rn-jShLGv13N6zPzziHd3vIWDuw3ywj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=976
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010081



On 28-Jun-25 17:58, Yang Xiwen wrote:
> On 6/16/2025 12:01 AM, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Original logic only sets the return value but doesn't jump out of the
>> loop if the bus is kept active by a client. This is not expected. A
>> malicious or buggy i2c client can hang the kernel in this case and
>> should be avoided. This is observed during a long time test with a
>> PCA953x GPIO extender.
>>
>> Fix it by changing the logic to not only sets the return value, but also
>> jumps out of the loop and return to the caller with -ETIMEDOUT.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/i2c/busses/i2c-qup.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>> index 3a36d682ed57..5b053e51f4c9 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -452,8 +452,10 @@ static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
>>           if (!(status & I2C_STATUS_BUS_ACTIVE))
>>               break;
>>   -        if (time_after(jiffies, timeout))
>> +        if (time_after(jiffies, timeout)) {
>>               ret = -ETIMEDOUT;
>> +            break;
>> +        }
>>             usleep_range(len, len * 2);
>>       }
>>
>> ---
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> change-id: 20250615-qca-i2c-d41bb61aa59e
>>
>> Best regards,
> 
> Ping for review. The original logic error is very clear. This patch is also very small and can be reviewed in a short time.
> 
> If it insists on waiting for the bit to clear, it should not return -ETIMEDOUT then.

'return -ETIMEDOUT' makes sense here, AFAICT

Konrad

