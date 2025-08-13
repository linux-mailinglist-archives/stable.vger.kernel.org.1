Return-Path: <stable+bounces-169350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A676FB2447B
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9299A3AD9AD
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF12D6419;
	Wed, 13 Aug 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxXDoQFz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642C23D7D3
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074196; cv=none; b=t8nXyaY2hiPnZIqlZ7jg8BqahnHHNm25Lmqk+Ah/m1cNUOjfBX+vMDDk2vCDPpIRpr3GPO/JaN0Ad8phzrmHdS5RJrrw554Rl1QqVc1e/e3qq3DlxjXOhszi8HIWLPYj/Z70pmni6ptIN8Wy1VaR3NC+8oj2OjoAXDlYwU26Yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074196; c=relaxed/simple;
	bh=2CKVRdemxHDDhnWNqTaAtbQxtL/RQiETHYNOnHMt6xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhRRUkFqe0M42tG5u7reYYhBR21Bb42sTrnwHrJ1R9QjL8piKplYd8xHGx5f5qLNptOK0T8FG6GIS4iL7uStVrXkg0DDvP3upfkNh9QLLovH0X3wDg/p6bykCrrI8rVOTE4Hg09YrJsxdxeue/+9WieW0tfwdi6dP0ZbtaYjKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxXDoQFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mKB6027086
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQKOqPn4stGn50V72VGH4by1OgDoWiB79n0LyosLssI=; b=dxXDoQFzbFYp95Gb
	7qvXPwnhepfea9s8H93Y5p0XfFFhnMysJa9yr5WU246qe1w2Gj3bdE795JYujXJy
	4bzSvDFoqFGAkZnSqsyWq6+Xb14qDe0jasm7hCTRKI60JseHri5xCSUbYNJzGObp
	VfFXEYuv675HFiIBTWN8LmQkEwMOWjdmPxlmP+jWAd7EeyAskFSTeRs2pixW3szA
	ea2xWCjTrJ2wYKWCg6TZhzV4ylkTYmjL2PTcvTbIXWVaKife16pyhcuyBjesurdP
	ks6xEI9N/on5jX9Fqpu0E+I4GDHGgML/V56zFRpCxgD9ourObH8gqLCQDLuFPhZt
	LWUO/w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmb1c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:36:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so4781301a12.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074193; x=1755678993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQKOqPn4stGn50V72VGH4by1OgDoWiB79n0LyosLssI=;
        b=Sr65mVNlAcGgdobyQ654Ks4vEDMn1dPnR58Qv4ZYMCSBg7Ay19dYGFpmp5Yy1j2aPP
         NcvWxyu8gbVHnI4WAMgI8v5Ic7zZc6fGSaxMaHDZBhtupoNv6//rnijEN9P6sJxOUS0o
         PVr+XElBWNXZPi+ZFhudpNPKUHbwp7OJCp6Bfxvd6/6mIHh8x5udnXezEQPgqsS0Gc+d
         ABu8GifNtEr1hSsVxnQi0frj8a893p14mKjMfFjxA6ZNHOw+a5EPi2blE4tWQm8+Jb/T
         riXWBvxa0IJxMXrah+NhMjQpI3Ta8s1S/UJjGlsjMypMcRULOlMEupz5P8lTbU58Bi/k
         60sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKQhXuCbC1z/JXH6Z/f9WV3T9Yp5c6gIhAgyhtfwxlecG9fmRDw1XgIqj3oZag3AWQA/jhIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0C8HbC0o5MicegNAwb/54ysBD/SRhOuYlabur9CXQ03HiM/qZ
	rDQvFcN76+ndO6gs/iUzcyqt8zDJzlxMpaqb5oOSvwYlQYc31OT1ErM/Ztfn/Wj217xWjTwAXwA
	UBK7YzE8Nzn7lEtiCzi+3dgewN0Bxu76KQLSoTf4k91USULBbYK1RmLRevTE=
X-Gm-Gg: ASbGncuS0VpLwG1UmWqAGeU47kIguqfMGp2P/eNBK2s49zc6QrR8hxg82ieGq/HO7jH
	fuH2S8pxH4NWE3hQdOW3F6niwcwA7b4am7VXlwMvdoOtlyofI+M8xBECOHhuRGXZOP+UIMSWKCl
	AediCRaOKFnGtHVbUKW/4oCErRsclGdoNJF3nbhPfMU+8rKppm65GbWGWi7QPuiaF6+W/UEe2fo
	p2VUD8YgcH0q8V60yGG8vf7hSqjF+7lY4RKWO94e4gNZMZMSbWGWIOVFAYcHhHKNREplp0kd6xI
	Hl6qze7gHdQW5VybCGEoOW580ZtznEjHhxX951WV/Htf01IyByDVYeSr/Q2BtufGYCubZU8=
X-Received: by 2002:a05:6a21:32aa:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-240a8b0c473mr3889564637.23.1755074192930;
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICpPeEcX9FHh2K8fbGGrwZV61Cc8VFekfAlP5BaQVSsk3pjIElUOwyc5IKvo9ORk6/74N9g==
X-Received: by 2002:a05:6a21:32aa:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-240a8b0c473mr3889527637.23.1755074192453;
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
Received: from [10.92.180.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdf61d182sm28438065b3a.119.2025.08.13.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:36:32 -0700 (PDT)
Message-ID: <32f60af9-7475-48b1-98ef-82962485acb9@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 14:06:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Fix address for usb controller
 node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com>
 <b98f8d3b-e45b-4889-b498-adeeb4a3e058@kernel.org>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <b98f8d3b-e45b-4889-b498-adeeb4a3e058@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfXxI99aJb1ACpv
 WWvc4uI+RYYVYEEZGTbGrKBOEMb/aD/n9Ymxp7mWiRHIsmGoO0HWdlpqyDh4GRujtOSDNWWwPM6
 HIwEldScs+zx09PRpGfBAvFQrAP5KtRf8hpkNc2uPDUgN2hN6GQ6aLSRkTDpz7LK/oV2WZEhq9q
 AyZedxqXLFCMjC23WsghH6Zc525+0AY2+l1hT7J03PMS8Hu5qVLZ800A6KqrmJWOzF2esKa91O5
 /FtlMzpGmYcPaS41BLft1rl1tYSlnvX+EahsVhqM6Z9fKXyBhfD7SDHUbkjqOzvFORN13LuCnrN
 IdTvx6hWiza+pEp6QymdfsX49p5+rWLyxCnI+FPR3WFZ8kZyoEuos0XGeNWaBhHiYwuChC2xE4y
 Kalou0c4
X-Proofpoint-GUID: Opp-jXIjXTnpR5GUAww32GvC3tId-767
X-Proofpoint-ORIG-GUID: Opp-jXIjXTnpR5GUAww32GvC3tId-767
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689c4e92 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=-uJ0XW9AK0pjk_nks4cA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119



On 8/13/2025 12:56 PM, Krzysztof Kozlowski wrote:
> On 13/08/2025 08:38, Krishna Kurapati wrote:
>> Correct the address in usb controller node to fix the following warning:
>>
>> Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
>> format error, expected "a600000"
>>
>> Fixes: c015f76c23ac ("arm64: dts: qcom: sm8450: Fix address for usb controller node")
> 
> There is no such commit in recent next... And how is that you fix commit
> WITH THE SAME title?
> 

I sent it on top of latest linux next.

My bad. Will send a v2. I mentioned wrong title, but the correct SHA.

Thanks for pointing it out.

Regards,
Krishna,

>> Cc: stable@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 2baef6869ed7..38c91c3ec787 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -5417,7 +5417,7 @@ opp-202000000 {
>>   			};
>>   		};
>>   
>> -		usb_1: usb@a6f8800 {
>> +		usb_1: usb@a600000 {
> 
> There is no such code either...
> 
>>   			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
>>   			reg = <0 0x0a600000 0 0xfc100>;
>>   			status = "disabled";
> 
> 
> Best regards,
> Krzysztof

