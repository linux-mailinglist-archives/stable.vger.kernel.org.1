Return-Path: <stable+bounces-119504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE064A4412A
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9511771F5
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4326B08E;
	Tue, 25 Feb 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xw0Hvceg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20E26AAA7
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490739; cv=none; b=N+UFadkgXZwfMRF7CSvTkQ19JOqSZvYcuu+VkIiGrRAIss+KQgfXHeR0tZCHbE6Y/XpwFkKhEislbL5b8b4xhUnjEvV6nwqgczcTNanHQ3iY+xBXgo+l3yyxHRYKVFZkcINE4q/mc1qdg9nEYvvfTkKwKDRgEkPQB4wv2SfxYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490739; c=relaxed/simple;
	bh=v0bj/zqw+24ErI/9iNiFwIBMrJ6F00qOqAwC3m6PJmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFme/gJcYcOBxgVcf/uaCAyxX/ubd0YQdVyN8f6V8ue3uOZZq9Nr7yuRdy12y47D0z5B5dmrODbAyKxaLW3TtGTpvCRVQHwhE3E6C6pz4IKccxOHeW29JBZQQbE90D5dpn2h9UNpqk+kYNZBQAA15OVmLsBqDwKZeG5BDQuBSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xw0Hvceg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8J1T7014364
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	woumc9GjD8qeeQzGa6RZ11jkdHts493OKWZQDEqYj3c=; b=Xw0Hvceg5hBS9mkI
	eGRpBipCHpFRWz179D8DzpEGhAi6LUzQwsAxurvqMxR2r9Hv1lCpoe5uMY99Q5KM
	nWp1FZdkjxGYQ70829sTBB3VXn2LNGzzbI84U21I9P0rOE32FCBWfmGRtezdmlTv
	yixKlxybdY6emzQtjuiw8WwMbRT/G0nqQ0PWaBkTjGAGviROsK43N18QOFC15VOq
	5NOIX1Q+TS+1oDi3CL6+uUKMiCet5bZHAN/ugn8TSiolUC+vOulrFooEOex9wiGO
	8Iq2VKs8dDe6em1z8ynxN5GlNPPhl1E0tI6z3WRDMNfj2oCY8XYY4aTi9QxzVJPD
	3S4nAw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450kqg56tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:38:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47210401379so11032081cf.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490736; x=1741095536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woumc9GjD8qeeQzGa6RZ11jkdHts493OKWZQDEqYj3c=;
        b=aVgUYh2KkYMf9wIIYnLAyJ/H3kJ6N9alk+uOj8M/qGXqwIxTOZ6+WkdqsAOqJ+kwVJ
         4OGVsgmMs2AUvy1ke5q5x1kcmLngzzTbSdbhe0lQtl8oNMNR7g6Hshckm0qmiI/HsiBl
         x4ahR6QYSrR3LbCa6ya5l4M0actX/jLAQtaunGxyTP+ybScLU4qD3Clsfj2UsOBi+jee
         6yoF2YjeAwGih1GSSV8oRQGBZN7cctyQ3meIhxpMi4EEWNLT71un4yG9GXvCPgKYUFIg
         OxAop0x+M5SZDQuQiJ2xzvKOPXHoxsmRwCidu/fD/0yLWrQhW529unShHFirqWiv9l6j
         hmJg==
X-Forwarded-Encrypted: i=1; AJvYcCW1M9M9NyoH8DbnoJ29Y0Jj4eB6o+4N6etK77sNuQIMYLmpvfu0k6BCCDwelDQiLDlHUynjzok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KyW/vKnwgioYdCBhnSiPG5J34Fo4NPCIQbwyFndtgCvdq9oi
	Qqj0xXS9cnsXhWLPt42ptk2z5ai6upJrBjhJ+BDcWWuo9/LLWzlUI535UiqB1KCLf2t0sdtFsz9
	u4zO5wrBZdE52QcolUSv+9PYiuO3gI/HWG92O6Com3S0nDb//Z7hCZz4=
X-Gm-Gg: ASbGncsA/LwKrX1P0g6IuuDhQu6Ju1TkjgQ8Et6lXZ3qQuPjLGgdKnOz7qPDO3IZklb
	+gw5gJwEHcsCCRhYiUJmXDvQ6Ms8uoLwj25sa0N270A903aZZUYbsb1/6YNibJ+tpLa35f/HjNy
	IqO1MMgpIVe7yyF95SVJbF9Ewiw7jlpEfFqVo6oqnowkIdOGpX5XcjPC8TefPgRKMh9DNwCTIPW
	owjolZHJEXieM0ty1ty/0+HsLf+F6cUocW9tS3cmRylFfIFKNbfJgC67r5Vq4MibkYqZgcmC60H
	xYPO7i2jnt0JGY6SQDF/PkRIgU8XLe+iurpIqbGI0Atr5Yc0SlHQZ1zTfEn8KYMOt4TCjA==
X-Received: by 2002:a05:622a:5595:b0:472:1d00:1fce with SMTP id d75a77b69052e-472228abedamr101174391cf.3.1740490736231;
        Tue, 25 Feb 2025 05:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjOXuBD+5u6McaA71MsHpTumzGjAxp/BpGHbEliPe5AFBeQouuQ+C3kOjYUnIrWHRb3ZXhjQ==
X-Received: by 2002:a05:622a:5595:b0:472:1d00:1fce with SMTP id d75a77b69052e-472228abedamr101174241cf.3.1740490735850;
        Tue, 25 Feb 2025 05:38:55 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d6b153sm143635766b.73.2025.02.25.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:38:55 -0800 (PST)
Message-ID: <3956606b-71de-4c71-afb0-c4918888db19@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:38:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga-c630: make SMMU
 non-DMA-coherent
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <quic_kdybcio@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hX7K-L5_UxEsV2FRUjq3-pdd4Pi9Zt8C
X-Proofpoint-ORIG-GUID: hX7K-L5_UxEsV2FRUjq3-pdd4Pi9Zt8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=722
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250094

On 15.02.2025 3:43 AM, Dmitry Baryshkov wrote:
> The commit 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on
> apps_smmu") enabled dma-coherent property for the IOMMU device. This
> works for some devices, like Qualcomm RB3 platform, but at the same time
> it breaks booting on Lenovo Yoga C630 (most likely because of some TZ
> differences). Disable DMA coherency for IOMMU on Lenove Yoga C630.
> 
> Fixes: 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Let's revert the offending commit instead, this must have been some
sort of fw development fluke..

Konrad

