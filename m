Return-Path: <stable+bounces-103919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309719EFBA0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16F328CFA2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57361CD205;
	Thu, 12 Dec 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoIMUBry"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECF1B07AE
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029516; cv=none; b=GrUyRs/mObNwGJKslEklqNUHIXxcNvB1yku7DpzDuwCTlbhlABeLa75wjuZ5mRkt6nySks0M8vfdJYE9G5S7VwGtJpgErKdVxC8UXubXNywqWv7O1hVrZD4WtsaH1NttU837LmLFOf0cqqI7bpT4cb6+w5/HYL7ya+fbnXUzvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029516; c=relaxed/simple;
	bh=RQYDiHd9It9L7bt5UKp8LB5wrmjonska+s4p2piALbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzO7Vt8j/YeTb7jGAqK+KOvYHIbC+B+865mwc75aITgoIc1QP+DPjr6H7D2Ceb/obgfxuwtEllzMnIxbgvgTL/sjxD1tY2FIVwXIZYIvEXXmNwcYs3X6a4HS7nPx2t1CfRWt+4Uyy40GYhbhuHxbJfewQeEfrqjIhYPub5+AR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoIMUBry; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGFQoW002082
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zxsp0Ujiodtl8bONZyQG5BW3txGq1ewnQuxzTrTB7dU=; b=MoIMUBryedQmkisZ
	2qkg6d0vGmVDUUxCFZ0970Fvztmj63EEC+x4a8v5gd1LkCyiRCdTQqSACtYPgHVo
	OMW5NnQBTwudnGJZt+9F1UwCXRTwdvXbJdeUW+HBlCsfVdevkK4B6Kr+hrbEooao
	9/ZnF4jA6bs8FXtZIRiel4gLDus/Y1B5hEHX5E3BzxOlinFZXCns55D5PZhJpYVA
	9Fr3zHxqIr3Y8Cp9F/QpfRR2YadPuSbihvKb/AZAAY5bOJ97ac5BJL5iLQfmhP35
	qSu1NWB8AsHu47eb05byFiqd5rZLPI9WnCPgH0a2EV42D8LFCDLJv1fRseH5w1hu
	Gj6BEw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9xd76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:51:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8e7016630so2349096d6.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029513; x=1734634313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxsp0Ujiodtl8bONZyQG5BW3txGq1ewnQuxzTrTB7dU=;
        b=RL4+OZoOET//PmqzeaXby00uYAINce9TfslknooE2T17Gy4yCFrgz7xrG5YDRQVheK
         /IMKkt/vUFZbzstvFj4CfZOSwpRSalbo/EaStTjnKp1OvUAG6DQ4NQgMxyQc0ByZN7JV
         SlTpX9GUzmfoCsxwKUMfF7ObNLLh8Ga239SjpB6rtEuNvQYjgd0o/iNnVMWv5H15SLsz
         qEb0ZuDeGxoSk3n4A6L0Rr8gkxiKbjRu9RCdXq9JHUBrqBQEHl99Xzwno7G/16o8vM+O
         zslsZzNK8I1wV4Z+9Ce+ti0V1Dyt1T4EvPxuBIINtb3jjBm6COJEvHKPJ07Haj6oh0B0
         6nhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtl6X6j4+IUQZZgjsVgW4kuAaS8gMh3aM9LhNdY907xzW5e3u1irVFXtB0EBlYx7SPWHMiNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXWly1kGuOs60YsL1843Wc7L7rUd9Arg3qUPBE1Xv5iQ/G8Wl
	4cLiRU5LXRYz0UkEUEXmStcflAwEqlKjVOtBn50pPKg7odgKLToHbExKCrALBjaIsS5bMF8qARr
	HGCEI2pK1Golwd6NvUBzdy/GKA4qPlPXwZ+che23MC0Cj3uBJRrI4Rpk=
X-Gm-Gg: ASbGncuB7qm7jVksh0BjqXB/geJAqZtiGdLhpPKRYQtvGWGOClksqQOh+RIdG/ZTcnh
	eKDVhCtim16VdH4XkZxvVUMaRxede73MYEsFhm8vxWGKS3+wN4qoLhZxTLwPnz3KXGGTkodUGMg
	UZp1NYIp1TA0N/VP+oczarfwd7dkP1nk3YfGQsiSvM/aFjGCE9P49HYWyYN1E9/WCaYGJ8GM4IM
	E+dWLZ32T8QP8caf2BjGP3I3ykqDSYfxpefPp6ijHIliUmUVFyjgUrnQjW8OBdYHIUexjbiMy56
	rG2iEAbi5hHR8pgXpqKKaQOFJdW0Jgp/8iXrcQ==
X-Received: by 2002:a05:620a:4549:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6f8941a79mr74364285a.7.1734029512986;
        Thu, 12 Dec 2024 10:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2jyr8FCbiNi4X7Td2247OcL/NrJ02mfIvguB98o78LrY1uReIr8pyquLkqqIDVibs1rVEA==
X-Received: by 2002:a05:620a:4549:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6f8941a79mr74363185a.7.1734029512640;
        Thu, 12 Dec 2024 10:51:52 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm7597667a12.56.2024.12.12.10.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:51:52 -0800 (PST)
Message-ID: <37ce381a-c6d3-4ad7-9ba4-bc02e3b6c776@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:51:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/19] arm64: dts: qcom: sm8550: Fix ADSP memory base
 and length
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
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-7-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-7-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _UT6gbTxd_MbEhDaL8mPI1gv20cV2SFO
X-Proofpoint-GUID: _UT6gbTxd_MbEhDaL8mPI1gv20cV2SFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=937
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in ADSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0680_0000 with length of 0x10000.
> 
> 0x3000_0000, value used so far, is the main region of CDSP.  Downstream
> DTS uses 0x0300_0000, which is oddly similar to 0x3000_0000, yet quite
> different and points to unused area.
> 
> Correct the base address and length, which also moves the node to
> different place to keep things sorted by unit address.  The diff looks
> big, but only the unit address and "reg" property were changed.  This
> should have no functional impact on Linux users, because PAS loader does
> not use this address space at all.
> 
> Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

