Return-Path: <stable+bounces-105362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256309F85F3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC251890C20
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C21BC094;
	Thu, 19 Dec 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UubtjLmU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5851A0BDB
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640282; cv=none; b=KTuULI+poFdIvk3isYhg3TYhk7cv17FlA1YV2naHrcFSkivV/Ja+KG1L8vB7Z7h1I56C0HtTRT9Lzx7aZrhtmtAGQ6ksFknPBbwlK4n1HFWo2y3Fc+F33M6V8CivqzBo8bgdyad6OFhH2f0TQDEJzPZZ4r5dlUoEwSxLEgJzxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640282; c=relaxed/simple;
	bh=Stb5F+PLbGVcj04yCFnD7g1zWF4aaJ0ugAOc3kFyYZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um2ilmpruMVRuRK8Ac+SLoQoyH9f/9Bt7ix/6S24JjSgPVo6cI9qL5pYDUI4eI58GFqOV9IfU26eLTRVCvXs0KKgw/eKHMyD/4L1gwwBpqZZFs/l0JsnNnqZi+dKMTF+tmTkEfMRy9HXW/sMDM+L4e2x7x2P3LbFi7iAnJk4aDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UubtjLmU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJHKe5t014800
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEd1ikdMFXCq6Hs/06c9ITB9jI1Rf8Mdc5eUz+u92eo=; b=UubtjLmUFrZu7DFM
	pYmBkWti2jQxUHX3P7vSJQL/uAMcRhRf5T1hzt938WX46iMyQdHT/TpBwD0EXZ0P
	+rE3L81KCdp8OJgTILgnahpOaCei6SiMIkD+75sXbn8PaMwXVwCYL/fcSUiUMNae
	gHyFyXaccrv8tmUp5HqQnppa8LWZwmKJNui+itVnPYovq7F7CQIvOZaysLVGXb8d
	60Kxc1BOSU9errnkq9Cz0I+H2DbQzut65KNREizFPYowz6WJrfF8NekRznIdvzVc
	by2Zf/Eq9aXNhuuyiMAYZsaRPip8c6QWIum7aSpHJ+EEFOh/bwTLVMarwTcefw/J
	/z6z2Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mqt80d47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:31:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46a32c5cdbdso337541cf.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734640274; x=1735245074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEd1ikdMFXCq6Hs/06c9ITB9jI1Rf8Mdc5eUz+u92eo=;
        b=slBBuD141Bu7elGY5G+0kKzKRPiAoblxnCifCMRc84L7LUj2OIIL71oMMCRPAqr75x
         lQJPFxo8j4d6pBitArh/WDM4E/xBIZJaa26fYjrwJwBw+r9eC9+QQdqTPg0JhWzZMwq1
         rlJbtEyvpVzhQaYluBhkMXH7BmyjCCOqvEde2YY9hdgqH/kDrvQ9Wup87bl7K8UbGYh7
         7K+h3kvvUOznIWJ3rAP9g86XBn3gIt7CbMbyYk9wSNnumLYQbnN6Zd+7jKh+3l9ovFW7
         aeH7Abqhu3+xpCgy3j/jAcbUxeFNq1olAXHveuBZJZKV523Kb2i/qwUEadzXbXah4EUi
         gW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ51QLrWb1J8/cGEhms8oYRoRmUFgIM7zRdSFQy7CtZ3Jdy9ALNFp7AvC9D1YNUo8DbGLEo/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsB+fbmXGPnW/jQ5Evf0azMkvYjRA/3yKerMziDHZ8EkziTTHr
	8FTIRAZQ5GxCBUvfrp2NhI/xR1Df4jt1BoYIu2hmgoaKgQ2wojBo8GecZCisB4zOLMCKdyA3G6C
	+qnB88Xs5aPqKoTuxis4+9WfOiDxzd3bh7dUZ4FQXt3vNEPuFmu74lv4=
X-Gm-Gg: ASbGncvpMkcSWtHQGW65HKdYo3lPmsMR3JLu4peBS4/XxLJD+i3RKHNpLiI7mZ+Py0Y
	tn6F69R6Q0lVr0UnaDa7sVpoVNDmZDbmNaI3gExDcaKpNCniX1RCpDQPZlWLmAgeXzbmjvikWuU
	eO5aI1dfwHNjIy91q4vi1KUDSps3vNanLg14k4RHFyh+8hgGuSNsjyIOa+pQHJXHZHEHa8CzxZp
	qVIUTK0ufzAbiGuo/L9eu5z7l//E0zICig1tYGBdhuIkV2argvWLFR/+h+WGJGdiTFbL0L1/6cI
	YUTT1vljCYu2n6S0eeqzTr6WiEN10u7ctQc=
X-Received: by 2002:a05:622a:1909:b0:461:3cd2:390 with SMTP id d75a77b69052e-46a4a976f47mr2527081cf.12.1734640274534;
        Thu, 19 Dec 2024 12:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw1vwgTOwOzVY8/Tn7DUj0B0ykISEDQWZkgubggiXEVzJ9LlH9NuacPGwqxgW8at9UmwiV/w==
X-Received: by 2002:a05:622a:1909:b0:461:3cd2:390 with SMTP id d75a77b69052e-46a4a976f47mr2526841cf.12.1734640274122;
        Thu, 19 Dec 2024 12:31:14 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f013ab3sm100448666b.140.2024.12.19.12.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:31:12 -0800 (PST)
Message-ID: <52333311-5649-4d0d-9160-9c16d01764db@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 21:31:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 18/23] arm64: dts: qcom: sm6375: Fix CDSP memory
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
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-18-2e0036fccd8d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-18-2e0036fccd8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zYqnjgjoUzPRW3LI5XxnbibC3tzzyq1k
X-Proofpoint-GUID: zYqnjgjoUzPRW3LI5XxnbibC3tzzyq1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=763
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412190163

On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
> The address space in CDSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0b30_0000 with length of 0x10000.
> 
> 0x0b00_0000, value used so far, is the main region of CDSP.
> 
> Correct the base address and length, which should have no functional
> impact on Linux users, because PAS loader does not use this address
> space at all.
> 
> Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

