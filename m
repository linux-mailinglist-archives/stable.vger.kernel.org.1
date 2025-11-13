Return-Path: <stable+bounces-194687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30330C5771B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 13:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40FC74E4CA5
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C934F468;
	Thu, 13 Nov 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ES56M6pI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWq5IwsI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E934D921
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037495; cv=none; b=ALI06+CNgFJkT/e1t+VWd3ftJC4Y7c50tkCsPlX5WMQzOl+FBp1g+a1JIHIb8A/sDVC5qAgUesZYTERmoYggu1DfFoaNRmrhMVD0kECWeseTrXw8W+mtUpfuEjbPFb7/WZBSSG+sY81IdflG/foyzS9npZ063PMSZ7hyceD+dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037495; c=relaxed/simple;
	bh=9elVzQ7mj77HKCWZYVJOcXXu5o8wH0/C9oI2JgD/UFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3vt9ew9mq8erCF7nGVts7PLi11r6TF0Scr69sT05RwlDt/KvXh5Q0u2SqcKyJPb6ShXu3J+27t2lVeYTHeTRhVHAv4VxSkLo6m/l6w6tn6wqwqOdTEgpOY58yAUw3Iymq3Jfnyx5/HMOQMN0JiHN8xH3f1W2DYwrlLAJWYcJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ES56M6pI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWq5IwsI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD9QKvb3121498
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 12:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8q73xJKrrwuofdSMpRsZlhIm0BkjbrHEOxLRKfjxylk=; b=ES56M6pIRZfroTGw
	5C3QBjap7rARk/2HKLQQaT2LMjM/5G9thrQy8MUfGqtwRE0DQ/ai2LlLYkl/sKAA
	pvXdxjG6orAJntwfcRT7HjQSFKgybU8AxEcziNtXfZtwv5FdS2lmbVHng2DjSeaZ
	Q+PxXLbbmewPEkGJOAwBdu+oxRv0ucBFMOxK7Vxtx/B5k1PGQiwdEDnpYmmsDh15
	roSmjaGVHM1+GjiotwWdZ8NJZTXTVO1T/jSL87texxLL7pYFtcbVumPtZtatI+fc
	OoT1x7mOzjUHPgEqdHx2h1Nvm4xH4eNO8eXEAtccOn39mmoUZmWdI0LdqemXYuob
	ukPj0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad5pusuec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 12:38:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f91638b5so1950395ad.3
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763037492; x=1763642292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8q73xJKrrwuofdSMpRsZlhIm0BkjbrHEOxLRKfjxylk=;
        b=BWq5IwsIZ6uqxBRxynlu6HEPkVJFlrs0VFW6yskvQhw3np8gAJQtJzWzOOpQ8lL4JM
         CQdUo1/f1iL6IIDhsCvKOuhLNp7L+AdhJaea2w0MiKeWs2/OMASxjBmMTnNiT7o/GLAh
         WfOrUdIitAaXfnfkSytAHj7J2WCIdggQnYDafxwu+E05tFN3hnuPCp0hjoqwFm6xMDto
         Y0cNt4eFPoPPuNf6LrGHhgQ6R/vtQH3zYppSOiIWZUacqbW6iTA4bIFVWiu8Z0dyIEMF
         K+1CDY9IPZy7YLj4CFZwnoJn+xk0biPf1OaQaAXvXQ0YT+raFziGVh+ntrDdrHJkbvfP
         qSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037492; x=1763642292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q73xJKrrwuofdSMpRsZlhIm0BkjbrHEOxLRKfjxylk=;
        b=hETYYrb0p7VOeJ6aUWTCIsPN/4ZNwuaueuzlB8S+UXzXhjnggonXBjWhQ0n5GlGpBo
         bD+j7l00Q43LW7TJirCCkHXkZyQwDrSoQ+nv545HZOmGDgjS8EgKgwhdsx4y7Tt+pxo0
         k1XXXanlM9HmHXr6kEeqDOEoS+ZNgtg/WLHVsGM/CAd4M9a73xXbqAWzyhZdjZYrbU/i
         +nNPxrhEN4SJM7JMcYnHlQCT3WqHracGMidEzqdcmh1S4iomKkSsoAh0v65tAYOdS8MW
         07sKwBslEQqnrq6/6bIPtsKnMc+sVUlgmKZDswr7nvNT/jaDGtJSWtiRlWOCikTKVtmX
         F1rg==
X-Forwarded-Encrypted: i=1; AJvYcCU55H1Aj1qexBEaNTYe+Mr9IbAG9EiFIVOAydzQNhJrVJ3zwNYYyOnkDt7iR+EdA3vMM4EBBTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXk4YD4LJk/gk/Pc3ld1bJP8XDD63xp8HQlyqlEA/m09U0s/t
	4s9UgWMyZMDaUB+9g30iP3SX3Q7b/gduFxMFfhXffCuSDgs6b8vRl8jySHSvF9MZHcka/jgQnRT
	uU9fSXW+pblhTsgV7Kg4UdJfzD987i6ARjJtffPVBAMHh231x9rEU3hA9zmc=
X-Gm-Gg: ASbGncubAsWELvPrJa2RGKCgBd6FaYgZehTlpmsAy4BmqyP99kjUZ6TfuzdS6lzNkVN
	llf8GCRfY6WHVesAUWdPmltoPo96d8DPoFo6cdAInKFRVBNlrDlTJNbmQbQA7OZ22tUQ+8jvehN
	Uir/FNYzCTaHul9dzcgk99wfi5iYd/AmneII+XmiTeNWnGYpfrJkHyHEMQQ6zpkqWa9F0eGkiTC
	KnKG4jBPAPBEOIqRyhC6cTLVEane0egNd4ktjkoWpDoQWvt7bASvfyxJBPb+LLBmKeYnV9zw9IU
	sEsbonkGAY8cGWN0xHTaeEjW4FJclFkRrusP0jppHI+vX2+t6h7v8ICcI54vipRZ43pE1CouKXp
	OMvJGIJxvbX3a0qHmvh8Cxg==
X-Received: by 2002:a17:902:da90:b0:295:2cab:dbc2 with SMTP id d9443c01a7336-2984edd4be8mr48491905ad.6.1763037492096;
        Thu, 13 Nov 2025 04:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmiRvv1bAO43hwnywK6aLTI273kvGCPDpDB6tE28lZlIwLwScGnHFybsark2D2NJEdA5iRFQ==
X-Received: by 2002:a17:902:da90:b0:295:2cab:dbc2 with SMTP id d9443c01a7336-2984edd4be8mr48491645ad.6.1763037491596;
        Thu, 13 Nov 2025 04:38:11 -0800 (PST)
Received: from [10.253.73.240] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f21sm24521815ad.35.2025.11.13.04.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 04:38:11 -0800 (PST)
Message-ID: <5a8d75a3-b20e-4de4-b15d-a56af503324d@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 20:38:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
 <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
 <ee04e03a-ffd0-43c0-ba77-c7ee20aaac43@oss.qualcomm.com>
 <2bde5922-6519-4b6d-9edf-94fd0e7dbc9d@oss.qualcomm.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <2bde5922-6519-4b6d-9edf-94fd0e7dbc9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=6915d134 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=1x_t3JyoWHe2diQJI2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5NSBTYWx0ZWRfX6m+3m+FZptgC
 9YQ9H8mAFV+rKh0+V91Fwq0weEQTMSwFdNTzQPaZiQsTRhJ8PAPb8y5irrO2cIzVOOCljkB+JCj
 wHm6OLcmE0oc2OgV84mWn9j0rvwhRdZdKBpQ/HZ9FNCLJI3VAEO87fiJ46uhqEv6MPozm0j+nlg
 LtEVSZ7R4XNjCFuDdBW5feLAGVYJdHIrsj/f7NmFlKENJE6NctDH0eAfwX8WYoNVIDYj+jtEv6f
 N+0+RjuBUpjrsIXsHfLojvbF4qqboAZzOl07PoQIsYVpmnAq4KYqYbM3zZ55DvlmCv14DFj9ro5
 vYocWKz3QxD+ygGpqbWiZYsfvAUGoFg+vaxFzC0urOwS4e9VEE1S42JEi3C7zKvoWriqY4Ob7HT
 TioOcWjiLuwoqF9w728Bxe2hmWTqLw==
X-Proofpoint-GUID: DNkrEznma6-6aqAmviyiFKVEAwIplUfu
X-Proofpoint-ORIG-GUID: DNkrEznma6-6aqAmviyiFKVEAwIplUfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130095

Hi Konrad，
Thanks for your comments.

On 11/12/2025 5:49 PM, Konrad Dybcio wrote:
> On 11/11/25 1:24 PM, Wei Deng wrote:
>> Hi Konrad,
>>
>> Thanks for your comments.
>>
>> On 11/10/2025 7:49 PM, Konrad Dybcio wrote:
>>> On 11/10/25 6:57 AM, Wei Deng wrote:
>>>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>>>> Bluetooth work, we need to define the necessary device tree nodes,
>>>> including UART configuration and power supplies.
>>>>
>>>> Since there is no standard M.2 binding in the device tree at present,
>>>> the PMU is described using dedicated PMU nodes to represent the
>>>> internal regulators required by the module.
>>>>
>>>> The 3.3V supply for the module is assumed to come directly from the
>>>> main board supply, which is 12V. To model this in the device tree, we
>>>> add a fixed 12V regulator node as the DC-IN source and connect it to
>>>> the 3.3V regulator node.
>>>>
>>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>  &apps_rsc {
>>>> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>>>>  	status = "okay";
>>>>  };
>>>>  
>>>> +&qup_uart17_cts {
>>>> +	bias-disable;
>>>> +};
>>>> +
>>>> +&qup_uart17_rts {
>>>> +	bias-pull-down;
>>>> +};
>>>> +
>>>> +&qup_uart17_tx {
>>>> +	bias-pull-up;
>>>> +};
>>>> +
>>>> +&qup_uart17_rx {
>>>> +	bias-pull-down;
>>>> +};
>>>
>>> This is notably different than all other platforms' bluetooth pin
>>> settings - for example pulling down RX sounds odd, since UART signal
>>> is supposed to be high at idle
>>>
>>> see hamoa.dtsi : qup_uart14_default as an example
>>>
>>
>> I followed the qup_uart17 settings from lemans-ride-common.dtsi. Since these configurations are not required for Bluetooth functionality. I will remove this configuration in the next patch.
> 
> This feels like you're essentially saying you don't know/care why you
> did this before and don't know why you're changing it again. This
> doesn't give me a lot of confidence. Are you testing your changes on
> real hw, running an upstream kernel with some distro userland?
> 

We add qup_uart17 config followed the changes referenced in the below 
link and validated them on the hardware platform. Bluetooth functionality
works fine before and after the removal.
https://lore.kernel.org/all/20250509090443.4107378-1-quic_vdadhani@quicinc.com/

> Konrad

-- 
Best Regards,
Wei Deng


