Return-Path: <stable+bounces-103929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5689EFBE8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328C16C1B1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A11D9A79;
	Thu, 12 Dec 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2WpEYE0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912B1D88DD
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029736; cv=none; b=sFtWOAdbg7//fpZtShaWpaWfRXVO0gtdooDo8d48meJE4vKuNkoOCQ3CkIsDHNsVTyEJilBjbXowpjrLS1M/aoHW56dkEEPg/ZTm1Yf8y6Ptsn9up5gICH51ay9myfaQLPSmlLKlEUyDhGd6PG+NDjkxDDGfLveA2g0dK5lnYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029736; c=relaxed/simple;
	bh=6Ykd4LXZc/kByKynylSQh3A2HAOdlX7jGwrQ/D7Gu/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0Cg+6ChHJO50xeVI2qFh791JUCAEza4WUNtQbbqF+emsay0cA0xYzb6csRZ6j+IoqXflGrp9gefBMu/l/b6CYkDqW81txfUVSaeTPR2eYtI/mb9Olcs759/pJ/Xj95Bvv8yuNPoQt3pbULuzt199p/0eWuXXcLoc9P3HTkDUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2WpEYE0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD1RQa000455
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zI72/iwp++JOMDiSSOOOuPR56P6EMEm6GaLozzp9c4A=; b=a2WpEYE0cl20+RAf
	UXqg25+GsO49TBrUKDH+nX8dRa7DGQTlPf0La7TqVs7JyH96aLu+jl+OOfmIZ3Ea
	nsanIhGMZYGORwwA+vf5BilmoXXabtttelPCuHMGX/osVsabHCwYTCko0S+8ono2
	oa4TSVow2l1kRK54HsDpFla5MIa9pBhjByzhlIFGMt2UEpznVDxQ0+g5SJEJaiID
	ujNpK02FrT64efJR9shiKIxnc6NGhZp60qatxwEJ+CAf7l7oFwTlY3paJ5K9ec84
	I6OBDFS12HrdUhYMuaLoPx3MGcle+Em82ZN8Y2djkEMGGHLw5uVhZHY42ifRHpJH
	JnRQTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes2f3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:55:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4674128bca3so1634111cf.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029733; x=1734634533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI72/iwp++JOMDiSSOOOuPR56P6EMEm6GaLozzp9c4A=;
        b=hItLapZKviPUPLO8ePA5mrJ57dFSlVr1mE+X7y8uLjcgff8VXzYVSw8DcDernxdfh+
         8W6gBtwFR2fFhHZO9R1lJ7gF8Is5Hrb0OpX6t3BqyH0rzzY/bFg4eZ3B/EU2VWz781cM
         gKqwWsyAbYqDc38Xd6p9YMZ9KXDtv4Z1Ztk3IFOmC0zH8mkFbd4NfxN/o7u4kYs4XaUJ
         6OaIVgYpKON//yHd47rxCui3pA3QGmh0ucjlPQhP61289GLs48uXSoGkdWwgkhbOmee0
         XB8BaaBsmpNesvwYxdPKQtcmmeJnmn53uMfXl7G23K5/vfB6hA9Us8sHxiakc0Llh412
         IRZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9vrnNCqYDmsVfxSCBa7bdLhbz2qbbbSehK9goUFivz4GarWgM+vbhwOwDr9GRXXecpt8Qbyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+RHgxanCVd3XF8u/Usax+wOuw8D7cjyIx9M5fzYA5FtTX9Dq
	83yMRl+t4/05k2oV52MGN6Ax8wOVmKcWN/PLUigpuy3Kkg3s2u1FolfxA3tOCeKqiKTMh12WAI3
	OJoYGMZmyR8quXvxJ8o6vorOlbyoRzLbcj3li+w1PsEmbZi5oklWHISE=
X-Gm-Gg: ASbGncvEg/LdO26WkoHc0PIfie5ILuC4Iywzw5Q80UyKh+LLVUcQWtQxRbzq7ZziLC0
	dcqkBxx2PhxYn+qQHplCWGniY4lcO+BTptm72NB/oZLc2pp2r6TaWZcYblgxXoUplZqFhM0XNzC
	MU6OWrz29L5RtiFsZ8tmcb1FClwOLgRWwoAIinKp2DzT8tKbktLtgQhq3qsva0RGIWOsNN555XU
	DYm6Jy2NX5J5niZq+LZ8NmOdb7rxQdbbZSfBwNtVLFElU5NL8Pn+//77PP7EHY0roWxS+EAVYym
	au74rcTEZWRJr6HYIGnKzypqCWcZFyaG5qtqug==
X-Received: by 2002:ac8:5d0b:0:b0:467:5462:4a14 with SMTP id d75a77b69052e-467a13bcb81mr9719091cf.0.1734029733538;
        Thu, 12 Dec 2024 10:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh+6GqlSEppTRVHfwFh6/LFI4/HjserV6YHyLGu2Tmb1xxtvWO18Oqsh69zRHwYho2dvwIyw==
X-Received: by 2002:ac8:5d0b:0:b0:467:5462:4a14 with SMTP id d75a77b69052e-467a13bcb81mr9718891cf.0.1734029733124;
        Thu, 12 Dec 2024 10:55:33 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653a95e90sm836436566b.173.2024.12.12.10.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:55:32 -0800 (PST)
Message-ID: <5cbcb8a5-f39b-4416-8317-15d56f932915@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:55:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/19] arm64: dts: qcom: sm6350: Fix MPSS memory length
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
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-16-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-16-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: s87GGGJWVUI0g6aVgVJCAjIjYSVt08LM
X-Proofpoint-ORIG-GUID: s87GGGJWVUI0g6aVgVJCAjIjYSVt08LM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=872 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

