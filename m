Return-Path: <stable+bounces-104107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137779F1072
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E2116A22A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB51E25EC;
	Fri, 13 Dec 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8xiEAJi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DD1E1C09
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102516; cv=none; b=CfPqdKETbe+vW7SXjOJyM05lIUyQx2KMt8ehYUzj1RFCPC6gpIXVz2Ou35r9iwpRquvh9La66b8oN5a27kD0OdhQqIay4gGRAu9OwjnpAixEEdXeMMr8GkovUP+QoUwEno+3scuO/EVErFA4+Mcc52vU5g1LPg3C2hyHkZvPUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102516; c=relaxed/simple;
	bh=gifl5K2wVo1pUEBYfH4X/5VFPN2lBKZmAvz5lyuJzXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2YXTS/xMUbrWe1WFc71w/wNboe3tjKxSdODoHmauXDDBl3ATnsWOiKj0G4iBwRb4ggQl8eMPjs6YrKYhDrzmRaaBQ59xGll724F/RoNHgLKohDyU1XNaNBHHGch4r5sy267onBICvvALXx44+FK+O0+YpxjjrN0t/cfP55Z10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8xiEAJi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7AZgI027708
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gf/fh9YGa6CvGhKh2kJtbLjeDgDSqi4w3sMvOIhuQQw=; b=l8xiEAJi/rzNYvYn
	LP6U5R2lzWm1Hybbqq985lUCKHurNYmi2yZ1xmnFl63cQyUoMjye0CnpdZlN7qL5
	i+7hVXfTPP0lpFI+5NZASzv3LMr/ah/BXpPL7MFISkhk/i5f2gm2QVrhz7QaT4Xv
	nYxupxRM6zVXRq3twGHxoeJuI797yFW19tpNChPaYO27NyIX7WlR1GZYRCvqB3nA
	WK4cQL8V04JRd5BymBDcdAq8DR3yQnsdIARFp8kUKsthc5lxqAX6yBEAV1UZCKC/
	13Q8GMS4YLLiWd4qSQo7ANJ1an8OVZdzaD6+AbPBhEPXKmQttK3jSh7T0vwmWxgX
	LAKXaA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40ps4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:08:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46748e53285so3732181cf.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102512; x=1734707312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gf/fh9YGa6CvGhKh2kJtbLjeDgDSqi4w3sMvOIhuQQw=;
        b=Gwti6a20Mii540HyqBSdd6qzSRBPC1m6xXmebEm5x1P+NsB+32xoU+DjRpmNCGZ2oP
         8rqoSbaw6vT3PCnHUQqdG6tpePYSPLQgrgrk2gGvkIQZ1xpjtar9WDlcb3eLCutF/qFL
         M11OO1xLujC4GQm70exoi6+SJjnd+IPEaOksBC/D0dfBbf7uDTqxyBbOZdwxF4y0BgA2
         ZGUQCy4RLoTRLrs2Gp87dMtj4fl8+oI7yHSk4jeeDmiAJUQJeKhu1SV7fxbFukc2TmD9
         Fo3pppuAOeDQvqE8AKBloYyUcuQJS3lNT9IIahwUYBnwlNJw9sHHLrMAcNs75aADncKh
         m5vw==
X-Forwarded-Encrypted: i=1; AJvYcCWeVzyxAVIToBv2jG2Grqfe0HT2EwnvIyMKp/z0XAVlXuJhdVHR0vg6liSraOQ1O6gerrcNIp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAD/RkAGuUaRpv2BYn+AEbjWtWu6s8LqvTppfA3ioojLAOiA9
	ecacxDG1B8AVCFKWp0uorcUzmLWCVWzq+qlcxDvpNZmrYcMP4/TU/Wp+arX/jXcIAfvSEpemsQa
	bviTrgXe0l00BEN4IEE7UaFstVQbmKYPA5HxYyA5h0vHKff7CX0gjHJlmqHGEcJw=
X-Gm-Gg: ASbGncs+G62wWCUKee9hBBFle1uWutVAf9/nMhfT5qia1F1oLk9AgsYsAwg6WVdThn7
	WNKVw83HLBzmoz21wMAhlyK4GX4vkhhfI0OLRHIzYQtP98YedVKnXQFE1OtGMTka8cIyHch0puj
	w4RKdd4Iq1FVcmS3ao/nQS3fdIfJkTpnP9mH6KsZfaACf46GtSWB+nPDjinjt6dzaJtOnhYzdbL
	l14ZsaKKU64Frb/FxG7z3FegIPQUtlJYpAvYA+dBhCMx5IngonCYtmvb4P4XIwbjKuHjYGpIRV/
	jWnffzfdlLdA+PuzD9W1+ugFQqQ4kpDM+DC4
X-Received: by 2002:a05:620a:414a:b0:7b6:ce0a:d28c with SMTP id af79cd13be357-7b6fbec8010mr196210385a.1.1734102512449;
        Fri, 13 Dec 2024 07:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX2nm0PualiDIHCcimw5pbm6pmtCmSanRdLgYIld/OBrvjbYoZl7+DIgL64ZiMsGszKUs5/g==
X-Received: by 2002:a05:620a:414a:b0:7b6:ce0a:d28c with SMTP id af79cd13be357-7b6fbec8010mr196207085a.1.1734102511977;
        Fri, 13 Dec 2024 07:08:31 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d6501d5863sm54806a12.76.2024.12.13.07.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:08:30 -0800 (PST)
Message-ID: <98fe04fb-8ae5-4fb6-91bd-3f9406efab02@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:08:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] arm64: dts: qcom: sdx75: Fix MPSS memory length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-20-2e0036fccd8d@linaro.org>
 <9a7f43fd-a720-481e-b8ca-68150c202b74@oss.qualcomm.com>
 <d7a89a5d-cb70-4d05-bb3c-9f4808984175@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d7a89a5d-cb70-4d05-bb3c-9f4808984175@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GJSFpETbHAjRXiiPmPfl1dJ6Z4moETYI
X-Proofpoint-ORIG-GUID: GJSFpETbHAjRXiiPmPfl1dJ6Z4moETYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=993 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 4:06 PM, Krzysztof Kozlowski wrote:
> On 13/12/2024 15:56, Konrad Dybcio wrote:
>> On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
>>> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
>>> remoteproc node should point to the QDSP PUB address space
>>> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
>>> copied from older DTS, but it grew since then.
>>>
>>> This should have no functional impact on Linux users, because PAS loader
>>> does not use this address space at all.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 41c72f36b286 ("arm64: dts: qcom: sdx75: Add remoteproc node")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> New patch
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> index 5f7e59ecf1ca6298cb252ee0654bc7eaeefbd303..a7cb6bacc4ad5551486d2ded930c1a256d27655e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> @@ -893,7 +893,7 @@ tcsr: syscon@1fc0000 {
>>>  
>>>  		remoteproc_mpss: remoteproc@4080000 {
>>>  			compatible = "qcom,sdx75-mpss-pas";
>>> -			reg = <0 0x04080000 0 0x4040>;
>>> +			reg = <0 0x04080000 0 0x10000>;
>>
>> I think this should be 0x04400000 instead
> 
> 
> There are two QDSP6SS blocks - one at 0x0408_0000 and other you mention
> at 0x0440_0000 (MSS_VQ6). I think in all other DTS, e.g. SM8550, we
> describe the first, so 0x0408.

Ok right I looked at the wrong one

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

