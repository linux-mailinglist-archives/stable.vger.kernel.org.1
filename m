Return-Path: <stable+bounces-114171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C7A2B271
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 20:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E94A16234F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235BC1A9B3B;
	Thu,  6 Feb 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JEiWV6ZM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A91A9B28
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870854; cv=none; b=ru9THYTWguBEUhOF6wzWiHZ5pK21CZeRf4jARgYecolDb8RBI/ZKEaeiyu3NJ1f8ZpW0VpqH8/1pWcWKi5T6/bLq30lQnNvgQQuAYY4Pgu8Yw3uo7YMKIqmvSRv6Ltuh2HXIqgqlGicTn1uOQDOiecbZNswa3pfPHlqap4uF6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870854; c=relaxed/simple;
	bh=kzFOt+hUFf2hH0dfSHzEMgZGBx5oqybElRnsgUP9O+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNPX+X6+gtPpk19NE7ZUECIwvshfLxJAnuK5Vw7XixB3mI1bi1CJospvq0NUJhRO9yMO6D6JDIJTlMGUkd2jz6SIiHAOMFaFHUOu51m/LCOM6FFI5A0TsS3mGgkvtBnZLHIDeBE5JUat6YyHjnYecMqNo4Sy9GKhmsdmsj6t+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JEiWV6ZM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516Is6dN022730
	for <stable@vger.kernel.org>; Thu, 6 Feb 2025 19:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzFOt+hUFf2hH0dfSHzEMgZGBx5oqybElRnsgUP9O+I=; b=JEiWV6ZMs6Rcgd6m
	Rk5pSE6UsQbQ/v6Uoj16oVvB23CD8gYVux7FGaIrFWWCPTwm7FqtlWfGJypfJaKt
	/cYCSImgiP6PQ+b9UscfGuuL/Pty1N6DafI5ypBRjxcW0gBYHDoH/oRunhFw2Ynr
	LQQdf8cJXJ7SAkCPFc6mi1l+CPlaBUzKQ3xGMlnLVNQkP2DO/Zsx217gzeD8JiPf
	pizf24t7hCX9KvMUxjn6QEXbphRS2umZR1E/E+Yx1Dqeg10UHc9NgzRokhCVjYvu
	Zor2Dwow+V8FNBFuceikJQbbejD0k7mbtCUrpgdPmEomAiuSXP7NIA0rq5QWG7ur
	YmdOpQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n2rt83bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Feb 2025 19:40:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c013ef320aso14233985a.2
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 11:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870851; x=1739475651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzFOt+hUFf2hH0dfSHzEMgZGBx5oqybElRnsgUP9O+I=;
        b=oIknIQBWIzLKUQ397ZlypcrpqAnq3ItWsG+b+ygWSjfkGDSJe37f4sfUcGDKyn4aw/
         VCgi3rrvI5cYAvliMgWOUAFT3j5lS9pb7BQkmJjJ7oOnjQZG27yLDPEWw+jcfeie0Squ
         Zjjr/AvfWv+dg71jgipaIdGdRm5FC4A/QWPsgPeKdX95iEoo8K+UkC9b4y4NUQaOBQsl
         +LPXBYHEHpR7V8lsYmgm6Kv4yK0c1EU/1um3EVUg3wQZdupgMzjuHlMEA5odSrtqBbRt
         F6eXi/4zwmpa71KttVcOO0/GkTWQnoABTTvSUgCY0Nu9ZGy/D7NQ1EjFmQmPO7fCNthw
         W/cA==
X-Gm-Message-State: AOJu0YzPCqdKluM/3I7DAdlrnehRq9Ktggc/1ssd28pBs7GUrNtVGOgi
	VRdAuLz8xh43wyVRuuYWd/CGbPJvH7OFRE7xey+7WOWwIZUrawBJQCXlNTjlycoqu89HEkicmpE
	vDXIJSOpV/XqIl1/5EqdP5CxvKrEVd3S34ZwSK1qM5uhp77Vm7nIx208=
X-Gm-Gg: ASbGncscd1odRofrVVBlkG6Dg5eCfiQTNJ5pXbqjP+Kfjhe5rSq29eq8tkqQTmyN1QU
	SJKXMfkzYK9OOUjl9wyPhLq4/pl9ZG4IbozLVI5C63vvhbK4GcTH3K//LiW/xnesH9CZth2LU7I
	McrKkRzIy/agui7T1namSNiGKANrFVenz6e6P7VIE5XYcaYEsxSPTGemyL5wv/ToZpp4vokSuP8
	Y1i0b1VWjC40nwYPDo4v4wPFFQ7EJq2gXNi2M7oHGYaR5uYiQYAYz8tZk38TQTLXHzBnBdr2+5+
	aCT4g6zUpDthmDZvI1Bd/A==
X-Received: by 2002:a05:622a:3cc:b0:46c:86d8:fbc with SMTP id d75a77b69052e-47167ad1375mr2774361cf.11.1738870851167;
        Thu, 06 Feb 2025 11:40:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK2GFCexxJpENqKGcHNEyCUS9NksWXDELz9dkEmRkjk/gHfsgg3nLmQnccU+pMc4HP4PrA1g==
X-Received: by 2002:a05:622a:3cc:b0:46c:86d8:fbc with SMTP id d75a77b69052e-47167ad1375mr2774141cf.11.1738870850809;
        Thu, 06 Feb 2025 11:40:50 -0800 (PST)
Received: from [192.168.65.90] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f8460csm145266866b.62.2025.02.06.11.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 11:40:50 -0800 (PST)
Message-ID: <1ded2597-d5a1-44be-b5d2-30b70657730e@oss.qualcomm.com>
Date: Thu, 6 Feb 2025 20:40:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: ipq9574: Fix USB vdd info
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250205074657.4142365-1-quic_varada@quicinc.com>
 <20250205074657.4142365-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250205074657.4142365-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Urd2-lyw0KBXOUCWllDOtxDSSjVylXCj
X-Proofpoint-GUID: Urd2-lyw0KBXOUCWllDOtxDSSjVylXCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=581
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060156

On 5.02.2025 8:46 AM, Varadarajan Narayanan wrote:
> USB phys in ipq9574 use the 'L5' regulator. The commit
> ec4f047679d5 ("arm64: dts: qcom: ipq9574: Enable USB")
> incorrectly specified it as 'L2'. Because of this when the phy
> module turns off/on its regulators, 'L2' is turned off/on
> resulting in 2 issues, namely 'L5' is not turned off/on and the
> network module powered by the 'L2' is turned off/on.

Please wrap your lines at ~72 chars

You use "'L5'" and "'L2'" a lot, making it hard to read. Try focusing
on the effect.

Konrad

