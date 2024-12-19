Return-Path: <stable+bounces-105361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC79F85EE
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2F1890287
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C91A0AFA;
	Thu, 19 Dec 2024 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOwxQocj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D381BC094
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640251; cv=none; b=W4AaimyagKPRsjMsLRq/8a8NMfPpQAwJ9lhIq2JhRA7pUcQouKBQX+76g/G2Fw7+kTH9OT5P8dspOlDgsBS3bqjE1nGOfDQYls8aAgSYJch3lOnPGMBOyZKL0KUGH4NsoPR//LqE/CU89qEQQH3DjZvSsZd+xEWd2G/KUtY5/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640251; c=relaxed/simple;
	bh=SGJhB5w4dhKNdNsZ/fy3LQq/O4ivIL19SWzULYS4hKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6RY9EOW75eLwwDaEl2wTUs7hkck9lLeLSVRHsEJyuVeNc2MhOjshjVsN72JsCoDVNhl5GuzvDrFtPV/WTksOEk6W+GXR8ymK5sQEQyOAn1Hc3w7GCPmFxWRsCiZxXAekEtLIRvOVlozHBGJqXr8cZnpeUz9obiGsD81pJivy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOwxQocj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ9hmB0032628
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/zT2SHtjepoFaJZEduVyZ4rnNNgrziZ7GT1NhC/jlRs=; b=BOwxQocjwgWePO3x
	6WBk4hURFaGdwehooOMXIYsaubm760ZPXW4tPHhFjfAH/JQzsdQ1hseBpljA3Tuf
	/8VzMuQ0GcNHOynx1a/PDw38sBwD7lUiTgk38jzPzVNtTFDxASYmISZQ+VDqF5dP
	yLb0A+spQ36Rb3rpY6o5HWa19+wk0QxAAS9TdoqIsnSRQYG9vlN/mVLPSPCnqJp9
	YOHyqyBwKxQHqzPxJfPy2I4xM7kqvuB/jJI4+/Io3jXDQDsDlPMFsPvKGSWL2GS1
	h1BdI6RFbGdnTrWWEvQFrFAqd2IgjcMiEZaspyoor7NiAtUNR12nidmt+W3nVEfA
	+SbR+w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mh3y9m62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:30:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d880eea0a1so3488196d6.3
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734640247; x=1735245047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zT2SHtjepoFaJZEduVyZ4rnNNgrziZ7GT1NhC/jlRs=;
        b=BBKvOzjxbQmuu7FfECSpd4cUzSZUeSHyuOx4ADqHVtW7ETsj8ZYS3u8FCfNUVnku8x
         ICdEqOVgMlT8qeHsbZ/MuaAx4dMMutwaMVO00ZOGmjfT9XeoM6hLxFEuEmNv3CBhZqY+
         VLkk7/65+GOIL56U+Qd77wBlN9mG69x33PXP6hFne4I5WgwOGAyWfrb0KSNO1vh12oSP
         cqkwVn4krem9qJpTQbgi3AVagGAYH4LN+9Z3SZRZtAtPhhYR5Br+89RW+B+xXw+qG/YN
         xU7+sdHMILdzdnov7ut+xNywPaFqkwbs9gHg9u6niSzcv8aggr3ZippMeGHw0Muye2a6
         2ihw==
X-Forwarded-Encrypted: i=1; AJvYcCXVMukQzvXQqioLafzuTKpPrPoQDCohpY9LaiwICfOWIn3i3e52aN49NX+NIoLX+DTAJZV1ock=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKvy3Jvt4SskblLBdBItgP/yZpLXtm+CkkT+1sDAMJB1UyEuB
	YjFgsjuEVy8xA9gQ2HbuypGp3iWjtKCRW4oJvZ80RVyjJSHLUe9U4VPMYO42pwK/uS7mU5J2V2M
	30yBzdx1AtBYNIlDZz4n8p4DUA72PL5WMlqjiDm2Bztp9VtPuF/V1Sv0=
X-Gm-Gg: ASbGncuhqvS8K9DOBsYccLENRoXwdnI6C/t3cndIvIbtpXPEj5Lzof3siQqxBZpaKuJ
	rioiLYVxyBcqOrnKcNAKjPvMVOIKf1FuNZf/KHzarbYKqWaaeBHVad/ZsdnHqJyr51xSjnltVSY
	43oolvoHSAU5WRXdDJmIlDxtMKz/dzc3gRCKMyuimuEN6O4Vl19fXyrnPkzIuNMJ6UWVpfNSswJ
	dUUHJaTh4P35LI1EShVaYAufks13i8lPd9gX0e2NoziM6ofWhBXiPPdRr3Etl7vIfMhyppjQnx9
	ekEWUhlLdK/wDl5eUZTka/jQY2xAkQJrqIU=
X-Received: by 2002:ac8:7f16:0:b0:467:5931:f6a8 with SMTP id d75a77b69052e-46a4a9c1a19mr2426971cf.16.1734640247350;
        Thu, 19 Dec 2024 12:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEysFg7n/L5ltIY9bJXWNNbYDMXz7C/YdoGk7l+6pKFxHz6jjoMDc1H8319zDpTxRfHTb7+4Q==
X-Received: by 2002:ac8:7f16:0:b0:467:5931:f6a8 with SMTP id d75a77b69052e-46a4a9c1a19mr2426681cf.16.1734640246909;
        Thu, 19 Dec 2024 12:30:46 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679eeb1sm969331a12.48.2024.12.19.12.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:30:46 -0800 (PST)
Message-ID: <11e93b69-c162-49eb-8b67-e51bab559eac@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 21:30:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 17/23] arm64: dts: qcom: sm6375: Fix ADSP memory
 length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-17-2e0036fccd8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-17-2e0036fccd8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oOek7VOi7pQ3f2Vy1WsLnjmrAWPkmPUG
X-Proofpoint-GUID: oOek7VOi7pQ3f2Vy1WsLnjmrAWPkmPUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=706 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190162

On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
> The address space in ADSP (Peripheral Authentication Service) remoteproc
> node should point to the QDSP PUB address space (QDSP6...SS_PUB) which
> has a length of 0x10000.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

