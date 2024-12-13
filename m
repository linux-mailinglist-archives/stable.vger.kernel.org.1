Return-Path: <stable+bounces-104101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52839F101D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FA5284313
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E01E2858;
	Fri, 13 Dec 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vdf6hTQo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEE1EB9EB
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101888; cv=none; b=GMdoUx1CTevYCb3C5jemN8atpVrMsVq348IAaavv12m+65lJzqTGUM3MGBkbAZYqP1Z+wehuAOev507B1DF0Kj2Qo22ApRcS6S+OOA8e7IQCi9PPdPee9+277oPmUWYni3e2QL4gNw5PA+dXeZrDM+cDYDXmTQBQR/IEslLUQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101888; c=relaxed/simple;
	bh=w4PDo4lU3FmAcpCjU+IT6PySTuUD5F6w5xSf9oPCSi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN03rz+PB8EqLC0ceZ5fDznzLe1yPdv6+Qq6b0mCDT6mMqBwO9tFPfxijNSGfeCfKSb0Z5ZUq7yWA0u0kaewHLHvzJ9kAMhbKTPk92aXWHsEoX6cQ8uJfdE31JBC6Y12xxeu4LCumUrVb8AMPzox1dJLi7oufJDX+0gHWTJj8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vdf6hTQo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81jEo022262
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9rlitEYMAstCU0CcMg0k4rqH3luwKVbJGjPNhceUqGk=; b=Vdf6hTQofgwk653g
	DmNKsDUZXhpLmOAIM7Nqx1WZRiPbzsEoEEwIS9siXGMyrB0TWHmYRpkbXLQ4QdWG
	bei+bA8osmLBQiEfGag4FyueI+10tV9L4HFUAan0WYGbFbWhohJEoagJoV2XTAoo
	peAWYAxZKr8qKQ8IMiQPqjZHAor/9WI6J5v0jfQaNXDohyTies7xffNZqBsWMUiJ
	kvk2qiHyEfmLdGbTrLeg/CtnXtCOnz3gYi1G/9z1KvsMwF2SM4LrTNsDGwxd4Blp
	eXbaDGEd0PyHkiJlU5fTbi7f3a9tQx6JMdf6K9XRybG3gm8LkPZFLnzHHxMp1sj4
	gQ2aoA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh2715yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:58:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467a39f07f8so2229141cf.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101885; x=1734706685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rlitEYMAstCU0CcMg0k4rqH3luwKVbJGjPNhceUqGk=;
        b=PE6rbtmzgyWgVhy0r8hrkuCw+ogDon2sbscGfPG/7IkN9Z0aA2NuQt31WlNv2wMb/6
         s8UNaevSbUQ7iXFGgX9u/m/RgcW0IocGP7OHvB9tYQDpdf+vy0nHKJJxppFktKeVmEkA
         bKKq5n1n78C3zfE3eBsoPoYgMz186DVQ3avDqr4JcualpjCXEbFZcwfBXm6OkJgVTdTE
         0JKtkC12U39lFTO5ft9CcGjGodRj03DkggYe7FQHp10vlVUhoSl7yHz2nzv5GqBURN7G
         SB4AuDgkg0wYscOsvt5a0V5M0jdiSdVIGUaFVIr7qlciaAlBYH9WnWYAJcgHPsoRTumi
         FVrw==
X-Forwarded-Encrypted: i=1; AJvYcCWU5phB4lFUxO3Z9QsAgpw9aDEONr06e8gl7n9HHyT5iM3UI97Np8Svry6RW/j+JPyRfOJ7keE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfb6wZmlI0mVUAuA4rVeAyXxMVFURG8oRA5DnXybEXkDKPVTD
	HmdjSEpXE9Q4/5qx557LJ4fxQsYvgYtXHpByRG76GIlsWzkmhHDBJL2Tfh8DFir46QmfGhtuA1e
	mewDRcE/KmyImxfPOV81Pfr4ZCloMk6f3CVOrE2PY2Q9j3743D0d9DEQ=
X-Gm-Gg: ASbGnctRd+wpqunN+mPitW7/5H0M8V3ZBWJLq46T57HgkqwEOYQvtF9xzD1rvyERrdb
	LBRx+ymOWlShpfqAcR0zhMDaCXv72DZ8Dx6Z9UDCYzCl6Wklp324tG88uZ72flInOPjQk9Dt7VS
	1asky3dfG/HPX0zQI4Ig4iOj0tGOQn9qppi4DogCmC0x+XG89qozR6zwkYnILq/eyAjsKzyagG/
	XGHaNaXSLGBxdMXX+4Uawu2CSbgG7WmnYnFhTVlW/KnXIEhY4WiTWEpM2UgAoZVAHB4R7IJU3Y2
	dcl/weUdhOIVEbDL+y8Lau3CvOfC272YaUBT
X-Received: by 2002:ac8:5dc7:0:b0:467:885e:2c6e with SMTP id d75a77b69052e-467a573441bmr19802971cf.1.1734101885140;
        Fri, 13 Dec 2024 06:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVl+CoBmbFo4oYakH+eF5u2smvgvJQ/hIj+BanY8o0pxOB59lIum9KZ+H5dMfNOmDtuvMgXw==
X-Received: by 2002:ac8:5dc7:0:b0:467:885e:2c6e with SMTP id d75a77b69052e-467a573441bmr19802741cf.1.1734101884711;
        Fri, 13 Dec 2024 06:58:04 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab920c3e95sm6516166b.187.2024.12.13.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:58:04 -0800 (PST)
Message-ID: <0b2c2b55-c41e-4d09-bebb-702d1de49e7b@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 15:58:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] arm64: dts: qcom: sm6115: Fix CDSP memory length
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
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-22-2e0036fccd8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-22-2e0036fccd8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vNtIUlV7oc16nFm6UaYzyJSm1YIhYMtF
X-Proofpoint-GUID: vNtIUlV7oc16nFm6UaYzyJSm1YIhYMtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=847 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130106

On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x4040.  Value of 0x100000 covers
> entire Touring/CDSP memory block seems to big here.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Cc: stable@vger.kernel.org
> Fixes: 96ce9227fdbc ("arm64: dts: qcom: sm6115: Add remoteproc nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

