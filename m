Return-Path: <stable+bounces-105363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C79F85F6
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69727A03CC
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523D1BBBCF;
	Thu, 19 Dec 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzWe1wT7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA51AA795
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640331; cv=none; b=Y2PbSYxmBsE+JMvmab7ihbqftywS0M/l5dHcrXFIrD/Q/WETH7jbc73E/piunj6F5cWfzRcVEn7lXFlYLL1Fx54vlEL230oepeg5r57WYrxPD5avECewI4Fmuecn5rhV65a+FLdfqAkbM62tJb9e90UpIKaCxRMlV+ltoeJCuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640331; c=relaxed/simple;
	bh=JnZNj5dN0tWdrd513ocZNlH6XAPltMOpkJb0WAxxZOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULRG0y+0HVajDGXKbESTSNzifEp31YgYK/MxcegcF6aIz2Vfe87h52D1mvaf9gnqzs4ahBdAq2TZrMvCF52b9jA/kBObBG1EFHBE5hpJ4Ax16W+Nlix9mAz6mA5qvXcq/t6JPlkRyJ0Pu41EIkq53tbxTH4JE5pd82nXxKRTRGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzWe1wT7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBeEAT029009
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2r7lqqykJ1mlR1GtRm0303qtSS1CFFJFT8nV8QAgwew=; b=pzWe1wT72a0scn0z
	qrzglq04EHHLXi0JXkNuqbZTY/3Bf7aF59RwNTqxaPaLOFOAYScOLmdruyowGSlu
	cJJ0NJ5qwOabr61dRO0hadTlKDYtlbgWV/BCKZqDvch6R+f3dAIE10c0Jq/hWp25
	o7gbhWVHHvdiA0A16DmB8Ngj96TI8JxADKXMXIZVxpNeAAfL1DV/EhUYY2ZSHB1q
	7K+kSPwbLwGkhe2uqQDWf3PdBQhgfkko6CxctJ4SaK4FGfdAb2NSWz1VM2Ob9qu6
	OVFXSWCGJjk2K7rpRvbEW/DtSclvVDyeyeSwsGegmfvRJYhJvgugEHJlgCPioC+4
	wb81cQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mjtesbtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:32:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b71321b993so14718285a.2
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734640328; x=1735245128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r7lqqykJ1mlR1GtRm0303qtSS1CFFJFT8nV8QAgwew=;
        b=bfWMtxcyQXsL2U5aZeQuwQa4C6YFgjGQRJdDdsfR20Tet35dz01w1KGgJO9Nk/q5n4
         h7NBygR8bO7vsONjrHODQCVE5qr7i7PKTovhxhmr5P3ENW/YASOivdHAp0HT3JdE2tu6
         wGKDZSoLFG0GMP+5CjsXDKc5ggqa9zBrTjFeY+dLLtly/J0K42oOeo2+HDYsIdAFOHTA
         JHiMF3qxw4IoRSwkq8rDhBdvLOkW07K/9NkddSRFAeoSBRiNIIaxFgRoxVgK2nrVxaah
         pKIReuE6ids4KbweNqH9xSdmKW7pw8rU6pF7nNFwufHodv4kGbmKSEcDQybV5VFBk5Ed
         JzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyN9LpK6WFIeyH/65cerURuEqDI7Q4lpiDFwNsNE0zGN0F8TiGNs/+YnHzhutKFjLhnSGTeaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2IQid6mmUz+sv9gJ/s125D/LipQo6lmcLYCnA6Jm2noHdzqV
	YNXqY5MNSb2vCiEozOR3yRByOy6sN8ALpgK/ZRKaqu3eIjMNYlrHSFtB0BykN/tNULB+2S2g4Er
	nJh8czEKZXb29zg3nWoyQJvwC/4+17P8WECz5P4XaAI47T8Dmz8G9144=
X-Gm-Gg: ASbGncssS7UcCpSvgVpxVeleJeGu8u9udBio9YP+O9KSPO9TZSEGb1H9QgMbW8iNXrb
	yhvZq4tzaAh00f4ZgzbeK2oQqJ9cMt4Dov+ND3aDU2ijJJq5BjOCBYahp3JSWn3HXaIYvC4fGsq
	zRxkbplkkcQrQeqHFmBy/3Lhs1ejdbtKDzj0B+1UQn3nHCQsrsm0YE+I/OE/giOW8DGkgorFnZ9
	vBVQc+DGPKr0UiIZpAbi+yKIaLQNTtCE9HoYJlVCvV+f7kMHikpO30gv6on66MU9bJmtC5D2+hy
	dlHkRqHyFwKBXD5E4+PgqwZx6sUAJxxSY4Y=
X-Received: by 2002:a05:620a:880a:b0:7b6:c3ad:6cc4 with SMTP id af79cd13be357-7b9ba735bb1mr16171085a.5.1734640327969;
        Thu, 19 Dec 2024 12:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr/BT/C0gq2A4C7Zfdib60XQyH836ye8DaMiERcbura2uCr7PYf7vwLn06b5xZzgBUocus+Q==
X-Received: by 2002:a05:620a:880a:b0:7b6:c3ad:6cc4 with SMTP id af79cd13be357-7b9ba735bb1mr16170185a.5.1734640327679;
        Thu, 19 Dec 2024 12:32:07 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe48d6sm101069466b.127.2024.12.19.12.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:32:06 -0800 (PST)
Message-ID: <5c1d7aef-6148-4881-844a-23e859fa3d11@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 21:32:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 19/23] arm64: dts: qcom: sm6375: Fix MPSS memory
 base and length
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
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-19-2e0036fccd8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-19-2e0036fccd8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mgbg7zAOGTzaqXxQOQTYQlf2WJBoozNI
X-Proofpoint-ORIG-GUID: mgbg7zAOGTzaqXxQOQTYQlf2WJBoozNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxlogscore=826 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190163

On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0608_0000 with length of 0x10000.
> 
> 0x0600_0000, value used so far, is the main region of Modem.
> 
> Correct the base address and length, which should have no functional
> impact on Linux users, because PAS loader does not use this address
> space at all.
> 
> Fixes: 31cc61104f68 ("arm64: dts: qcom: sm6375: Add modem nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

