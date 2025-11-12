Return-Path: <stable+bounces-194590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E50C51791
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E1E1899B47
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3D3054D7;
	Wed, 12 Nov 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tri/oO1Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYyU5yWA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2E302777
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940952; cv=none; b=aE8HQKfXL7NZg7jCc05lr5IveZP72QOSHzYfTKh52ysfNXB3KhURWbU63lzsRBKqjSLJEYA92r7xw0LYNCTv6hDhnefaiPUs4cgVK7y+LGIJWEzl0FK5gb3PpNKdNQhSPu4DvMeWiWmXj/+aC+XkKFMy8o6gSVgyy7ANxP3MCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940952; c=relaxed/simple;
	bh=wTui7CYgiy+K6A4DwIyIpanabpofRNM0sn205OFN0K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5cQn3NaQ37MYX3LcNEBro69cxuHpCvG+Dxq2tUmBZicEwfYQsQBpTtOPT/gosqQUy1BrDpHw6ktwtNZ2BnRqdakzhrHXAv1Vdw5i2En6lP696bcahf7+A+wsxTvQEPCj1+BPNWe+PJIC3Cn0nHZRWovs9H5gmnx3B4WFknRxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tri/oO1Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BYyU5yWA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9ggxh1109097
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=; b=Tri/oO1ZEG/NXnXj
	LZ7eUv/Z4t5Xpb9bTEJ/YzsUOMgVtx55KaPtO6P1rg/gKKagVqtARxR66yqlMfXF
	Ba4NWIJ6sfBdpgI8Ci98+8p48bSh3al5LCHotjlL25X5gcmdgIh3Rq7Og1k+/kZk
	iwc3j8n/K+ztzRkkV/l4P8IVQfN1uSos8ObPgx8IA1b2epBcan8o5MBRhVb2wOhK
	nyROZc6CCrMkjRSi8+ZT/jQlxIWRS2smP8pgiut+sgB1SgR7Jm+Nxn0W0DSxjift
	76jWYAICf9fX95WAvBfZMrTQiNqq0mzoIBKG+FKdvb7yv7DCh+zAZzcqBdTA++3y
	d67QyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum01fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b25c5dc2c3so19332785a.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762940947; x=1763545747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=;
        b=BYyU5yWAzNjmSjF0db+II+H5IL4CxtRMmKrta2O86LW9BoVRVca50EOlyJ1Csws1na
         VXIjg+0QOC3IYyRve5/R25xPOvBjiaKNnO9Mmcbz9J3VAoIQcmLRQ0Rqan5q82teMrhd
         KrmjkW4cs361zLjk0HgqlC05Utg4est/0lE+cK0QH8NtjpXMFk8R6qvSqDOkWFJZJvVl
         cECr9wkDrU7eUnZuiTeBE5YQsv1i8GtB18FuJkDfGY0FjUFdiiDzHEimoDgjJ77Iy21m
         YdZ2lc7SkYLhNwDBN385SlQpwt5jtfNhLp/l2naZJ+mqitQuyePdI6VqFpdiQCs0nR7e
         Vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940947; x=1763545747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dPJ4QZdBUlMpVPRyGvKtHV7b42+J5SfL4CezhrPsEM=;
        b=BVhS2Y/OCV7fleOSB1P8kvPW+Zu72bDm+XKzOd2HHHhQpbdP0YpxC29GLmyMwPqhD7
         upOWUwKJO2Sj9u+9bc/1vcI5yNEHAU5QzTknhFJT1ODHOP7TtV4hLHH9X7CzGQWSgBRO
         r/VoA82qnGPPZB0rAl8X811Hm+SBlBGCRFP5cpy2dw5M1Ba7xC4yCD00fXbI1yP8aHl2
         SopOkYC63AgJnE2rr5ebAJ6g9vqcfj/76W4ROivXPncJNmHfURxDQnrrlPUPBj1eWtYL
         maae9NWuYWaYMhdodlNPxuLXpdrW6fWClJV3tUBlvZa2hC3397MDea0lTR7vtSFJF484
         hWCA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ndikoQpztZyrgyQkNmmCiDfKai2u8gNsn3OShRlShH7Ie2wt/i7WQ2AviSWT0ZOLUErYymQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyML2y2F3dmJpn4UwAiDG5wR7l/e2PV6W0O5Z7uRHDTfLHvxlDO
	sBJR0bGCB49sFarqqm9LyBKxrYkmfaWCsfo9gYxJCC5fPafJ161rWkJ/z3sUYmwbKkh5gY0D2jv
	lnKE3ypWbxVmpN/sNM5TGK6LQm1SuPCrCyYbtj0n3eRGB2vMW42K02UfX3QQ=
X-Gm-Gg: ASbGncsyz0qtDT0js+xeWeA3FGnHvgXr63mvtyVOQPDeixJAL9FpQcL+mnsnTsbLkOO
	/0/89VldtnLhAssOKF3PhOgFHXCMH7n+xJaTT55MCQr9CsVcFmMFJ2bt56ZcXV/sd3Z8OSAqa5L
	qxtqvpWttCDCdQatiEp5R18R2leyoHvmz8tWirj8kxiS59Ik1alHbrCZTE9SzTnI+D2NrulBfvL
	Xl7/09u2r6QkKfKHnxnfKVR7daiANUqCC8qNvvH7IpLq73U3sFWl04rzEzFahljwUxQxxvPEFnt
	I93s7L2HfhwMN1ODUB4vdxWINYGpQuZRA4Ez9KTpyrc9A+NiSy8Me8LnvcGcKyA7jgz9y++kGHA
	fDvAQUL/ObSA44B8QAbHXs3twSOxaR1cXzUSgDZD9zSCxrR5x8TPNUuaW
X-Received: by 2002:a05:622a:11c4:b0:4ed:b0fe:54af with SMTP id d75a77b69052e-4eddbdc11d9mr20202621cf.13.1762940947375;
        Wed, 12 Nov 2025 01:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPqrzdXmGbyKJf1zyUJ/6/lZ60CvdT07rxfc/WOc785KhcfTTcn2HopItZGmkx92ctB3AEQw==
X-Received: by 2002:a05:622a:11c4:b0:4ed:b0fe:54af with SMTP id d75a77b69052e-4eddbdc11d9mr20202511cf.13.1762940946968;
        Wed, 12 Nov 2025 01:49:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc9656sm1568734666b.7.2025.11.12.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:49:06 -0800 (PST)
Message-ID: <2bde5922-6519-4b6d-9edf-94fd0e7dbc9d@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:49:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ee04e03a-ffd0-43c0-ba77-c7ee20aaac43@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3OCBTYWx0ZWRfX+P0aN/S1wqTp
 Gc101jHTqJgt23lY7nBQOXc0bJ2uk9A61iy7azDHOh3lvhUNjPzD01yVnEXO9aA4kVzfhsDL200
 ITCqWp0c6ryuPq001JKauXNNhRe+pxtHbgW7xFidz2JaEAS8RQ8qJc26I9rbR6zIMGBfY7A9Tqy
 4q8EwRNHAxth5dzdB2osNi+UXdSxktPdy4qBauEUJ9D0Ke5kN3I4C2jFEx5vtSp4CYB5FA9PBjo
 D2CHO1xk/s6/g+IszFloBsWERPHFnTsMmtp+phXK04vsLFG6cDksyFYLqYvwuU9F9OAaEDN2CCT
 axr1bftNYPzpjmZGvIDdKcpwXdd859a5+Y/98oLE4wX2dNvyBIhiu5AYSDlvufQdLIPEVyxETvI
 u7wt010rpl73v8abxQQelRR9BFdrvw==
X-Proofpoint-GUID: vTxZvhioKoe35ELBXLRpyVkl6wnO_vGi
X-Proofpoint-ORIG-GUID: vTxZvhioKoe35ELBXLRpyVkl6wnO_vGi
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=69145814 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iyyYdLundppeB2c9LQAA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120078

On 11/11/25 1:24 PM, Wei Deng wrote:
> Hi Konrad,
> 
> Thanks for your comments.
> 
> On 11/10/2025 7:49 PM, Konrad Dybcio wrote:
>> On 11/10/25 6:57 AM, Wei Deng wrote:
>>> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
>>> Bluetooth work, we need to define the necessary device tree nodes,
>>> including UART configuration and power supplies.
>>>
>>> Since there is no standard M.2 binding in the device tree at present,
>>> the PMU is described using dedicated PMU nodes to represent the
>>> internal regulators required by the module.
>>>
>>> The 3.3V supply for the module is assumed to come directly from the
>>> main board supply, which is 12V. To model this in the device tree, we
>>> add a fixed 12V regulator node as the DC-IN source and connect it to
>>> the 3.3V regulator node.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>>  &apps_rsc {
>>> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&qup_uart17_cts {
>>> +	bias-disable;
>>> +};
>>> +
>>> +&qup_uart17_rts {
>>> +	bias-pull-down;
>>> +};
>>> +
>>> +&qup_uart17_tx {
>>> +	bias-pull-up;
>>> +};
>>> +
>>> +&qup_uart17_rx {
>>> +	bias-pull-down;
>>> +};
>>
>> This is notably different than all other platforms' bluetooth pin
>> settings - for example pulling down RX sounds odd, since UART signal
>> is supposed to be high at idle
>>
>> see hamoa.dtsi : qup_uart14_default as an example
>>
> 
> I followed the qup_uart17 settings from lemans-ride-common.dtsi. Since these configurations are not required for Bluetooth functionality. I will remove this configuration in the next patch.

This feels like you're essentially saying you don't know/care why you
did this before and don't know why you're changing it again. This
doesn't give me a lot of confidence. Are you testing your changes on
real hw, running an upstream kernel with some distro userland?

Konrad

