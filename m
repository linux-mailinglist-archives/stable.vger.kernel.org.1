Return-Path: <stable+bounces-209996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7BD2D98D
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 08:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D8830C1B74
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C22D5950;
	Fri, 16 Jan 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfWa9EYC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ve5yJXfZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90BF21D596
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550126; cv=none; b=e+Qin6UBPwbgSVUSq0eZKEv2NHE3LGghQoqzcwOFfaYm5TJn30tSG6+mbr5AjHOwOtQsanCcKRiN2isIA/+N2lXZ4O/MK8O/E/+bdZ4tLtTFxjECfFPKJqLiENDyhSqKM8dHidYNngH2QO9bOpQ+kM2BAd5x3zP9ymrSiRxCJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550126; c=relaxed/simple;
	bh=sz32ZWxmrHzWpYgronrl//wpJs3krepRhJ1ijJQveVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ar0+9lJjxUky7T0BYo9+qVTyXpEV8hvEjHY9fikFOMVAz8gVqI403U8cLOLnpF02CzafeUhmFq03doeypQ2lhI774T+eizLiTMnwG+s+icQvlXD7arYWT1bBO6s4Dyx47g+QMa9Der56Lt+4vcWXq2WmQW2P0H5yy/gmY/7qxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GfWa9EYC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ve5yJXfZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMh9q84017960
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4bR95UiIdFbQlV/U43B17eYqfgMobapeZaIBBrbadl8=; b=GfWa9EYCrZSyfvQi
	IGkzvS+xcY0pl4W+yIwkxPSKVtqWz5zmP+t1X5TPsa2FwD1mHRwWvQBZ47v0hW8Y
	amjqOBPChDs9fBo1tF6ixpPdk2QI8priKycClI73DfGmrSt2MSDS7AebOfk8Cs7Q
	roSOSqdZgNyBSvHhfoGwLVdlNu0APNcd4/gp6M4L9v64WFO9QU8kwpMERNQJ0q0x
	iRFaS1KQRYSaFIl4SGQ2SpQ07y1EpbrQoICb1SGLPuZNezT7Y5BfDz3LQNsXuBkY
	tx3rGh6gMUAsEU//MQG3D3GX0zPoTdWuyvZE5Gw0uP9CXK8VodPdL5HoM4eAfkgh
	3HcvIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq98y99b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:55:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a2ef071dso436581285a.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768550122; x=1769154922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4bR95UiIdFbQlV/U43B17eYqfgMobapeZaIBBrbadl8=;
        b=Ve5yJXfZJSdvs5vhpeQBKl/JY0Ew6W5dcpeoGft5Tid0gSzxT8L5GfNMCuLb+fSmVa
         1nSK02M07+iUw5mKYgwMMgvuGdDmKUypvGbAiGKNvcg47s4jyrL0dlKvKiidYTtFxx0c
         Yz2894UYyu87Qz4QIGQDtxE1/mW3qBrxIcWKJAOQs/3dqr/xGUb5emsqrdzRtkL8ia03
         SXm+cIsphPd1d9dPTmKVpmFvR4QoRSG9sZ9CqYYWVVj8nWvGB3GUDBcVUBTruLM6l6Kk
         hOlXobDMwHJbjB7NJumlIMizmWhBvtUJTwILBseixZOyspGn0+WR8iv3WYZUod2s76FW
         IMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768550122; x=1769154922;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bR95UiIdFbQlV/U43B17eYqfgMobapeZaIBBrbadl8=;
        b=mqqwB+NOMN7KG2nlaz6lgcffuAZ+9mK4hqA/OFsVFQJxYKux6qxcVHQvYa0zUzbNIZ
         BoTQgT1z3tdZx+hhWrTTJmNYiYnMUkQUrfpw4JnNIKE4Fi6OkUt1+LYrHKb6LP4Fg+Ay
         7Rg3DLisFbBIgWsW6beWtX7HKG/1wWiI5BNTFDr8K5n8fLIzYyFUxrVKCYmuDBFNQ+CL
         2qq0Kz1xwWtYC/h4YN0KMpWAlQxsd34dZ1l8egCGAo+Igq6WcBlExEn5hCF7m8ZSY0f/
         UmRwbF8t0szeTt1zKVXKb2r706f41q252Wxr+dLmT7hbE1qcNU0qcWxTbVYmbWC/3yyE
         H3FA==
X-Forwarded-Encrypted: i=1; AJvYcCUu60Qc7sOx32a4Uu8Ki1nK1tBKJNXZJ/IxrE2pNFreVRPgqfFNhPeZTiXxLZoSXfSo5Y6VIAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MKjJUbtML27pK7cbA6Hlbe4W+6kDu+J4Q7vP97EdGnnb3IVY
	PRkYJuzpdtQqDw8WyP0qAxcs3o9NkvhU1noPZ6HAV11niXiLBXnmBmRCCVaw2tWk80Jb6rnzOnM
	8ij7aBQF2c7hcdzr5u7mHqbgIUngaV30mIxveecls93EGCy4dlpMuuIENc2M=
X-Gm-Gg: AY/fxX6alqi0OWxl93SsoyhYRtpYdzwT1NeVoKfHDUgztL14SqL4rgjKt4VA9t+sVs4
	ajsojMqTRGDkZfok4JrM+Kh1zPDHs+Jz4xF+jv0CR8YR8Hz7p6Dpwm+Il0RByaL2zjhCm1hIK3b
	kRW14Ce5wcXx287dcWrjtRjSmWzWvT7PO6NtDx9vNJd95QPqOSgY1apncVlCDTsSsswOHdylCp7
	D7ihY3Y2WXw4NOY9MprfPFdyo44O3itOYr4spppfcyIT0bnbTNoIjFFR67IcMJ+xBzBXBWOBFFh
	EY5eW+XeGPYxkPhFueHA3ZrAYsxD3KKK4rfsgHU6407NyvL+UeF5Kjn6XvaTihjKU4xGhniMtTH
	Q3B0KG8NUeKo1j8LU0xNHSTre2KPGdS5kkoAPAw==
X-Received: by 2002:a05:620a:4506:b0:8c6:a26b:7ea3 with SMTP id af79cd13be357-8c6a691a0c3mr296269285a.36.1768550122196;
        Thu, 15 Jan 2026 23:55:22 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8c6:a26b:7ea3 with SMTP id af79cd13be357-8c6a691a0c3mr296266785a.36.1768550121631;
        Thu, 15 Jan 2026 23:55:21 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879e2c1be7sm75271266b.67.2026.01.15.23.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 23:55:21 -0800 (PST)
Message-ID: <0d04b5c6-4e4a-41c0-ba14-09c95a6df235@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 08:55:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: parade,ps5511: Disallow unevaluated
 properties
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260112202040.GA943734-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260112202040.GA943734-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=6969eeea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SW3E11V1xAdanCoC9skA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: lFZp-Fo-72H_ZOrolxkj2ox0lJSsJnTa
X-Proofpoint-GUID: lFZp-Fo-72H_ZOrolxkj2ox0lJSsJnTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1OSBTYWx0ZWRfXz4lVMOAozpUH
 p0Kf15cxFvvNlpbkWLjyWFDo61NupildXJvtYaOoq6jN6DBPuX2ey/iJ+8VW7SfnlFg/DAsnz/G
 zR1ipsJ651MUCzH5M6e1x3YDA88Ec7fO48ks08G2LQzxD6zjgcNkCU/g8pvQ/bjX95hNPptJzhL
 E3TQ67fTBTTELn6ke0XsbtqJZ7S7NEGnlHfzc01IWUv5Kjrt73xQX3EJoXXoEddBHpCMH03SdvV
 jzaLDWhjQszgHSoXGtCGYPLx2TbD6Nn0ksafio82AcSnNfjI6v4cQhyhRLlGCTqwTIdNqWgS7sR
 avl6VFg/ORcbSOSx7Vbh4MVHyQneOz3qpq0eKTygNGjJ/VxMPAvIDZz6+5+eZMCI9C+nivOVHEF
 uuQPpIfBp9nvH6L/vk4w6ndG167xObs6RvAw5l5sle7BC7gqaLm379ksTD2MZvoCHS473+5H/0c
 pA8EGqbshLUss6VRiYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160059

On 12/01/2026 21:20, Rob Herring wrote:
> On Mon, Jan 12, 2026 at 10:01:50AM +0100, Krzysztof Kozlowski wrote:
>> Review given to v2 [1] of commit fc259b024cb3 ("dt-bindings: usb: Add
>> binding for PS5511 hub controller") asked to use unevaluatedProperties,
>> but this was ignored by the author probably because current dtschema
>> does not allow to use both additionalProperties and
>> unevaluatedProperties.  As an effect, this binding does not end with
>> unevaluatedProperties and allows any properties to be added.
>>
>> Fix this by reverting the approach suggested at v2 review and using
>> simpler definition of "reg" constraints.
>>
>> Link: https://lore.kernel.org/r/20250416180023.GB3327258-robh@kernel.org/ [1]
>> Fixes: fc259b024cb3 ("dt-bindings: usb: Add binding for PS5511 hub controller")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/usb/parade,ps5511.yaml       | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
>> index 10d002f09db8..154d779e507a 100644
>> --- a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
>> +++ b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
>> @@ -15,6 +15,10 @@ properties:
>>        - usb1da0,5511
>>        - usb1da0,55a1
>>  
>> +  reg:
>> +    minimum: 1
>> +    maximum: 5
>> +
> 
> This 'reg' would be the upstream USB port. We have no idea what its 
> constraints are for the value.

Indeed.

> 
>>    reset-gpios:
>>      items:
>>        - description: GPIO specifier for RESETB pin.
>> @@ -41,12 +45,6 @@ properties:
>>              minimum: 1
>>              maximum: 5
>>  
>> -additionalProperties:
>> -  properties:
>> -    reg:
>> -      minimum: 1
>> -      maximum: 5
> 
> Removing this is wrong. This is defining the number of downstream USB 
> ports for this hub.
> 
> What's wrong here is 'type: object' is missing, so any property that's 
> not a object passes (no, 'properties' doesn't imply it's an object).
> 
> We should fix dtschema to allow additionalProperties when not a 
> boolean property to coexist with unevaluatedProperties. I'll look into 
> it.

I see your commit. I will send v2 of this.

Best regards,
Krzysztof

