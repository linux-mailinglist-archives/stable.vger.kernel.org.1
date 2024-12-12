Return-Path: <stable+bounces-103924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5F9EFBC4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7759F189156B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B96188CD8;
	Thu, 12 Dec 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2zac27S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D218A6AD
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029629; cv=none; b=lMkK669lXwtoaRkcAijDVhrEr0gu6OZsa7bTjRgE92kDHN3OuOwATHajMK+U0f1/d+xEh2kkbiUsFDHfVYOeLj63OlMn09sLTV5RG5Bjqd+speztgUbMeqvEp/pu+95ClFw8kqBUWewJksV/r6B4hvXhx20BKPVC4tXnTjZt2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029629; c=relaxed/simple;
	bh=K/eXURgpahEEJaH04jCtGcp1FBNf2Xs9PKt1sSMYnGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJUV97ExDqLd0kRacoMneElS/nk0aRDEE6TSuOwnlLGJOdJNSGgS8JQizW8QTSYWun59aqCD3GTJy6k6VFAxmjBSe2nakCLZ5IJnCErNnzU+jNveIqexO4Y/UlL2DO/ZOc5vdr/1P/RtxDcEDcJKpcddDJFkXq7I/Sc9WD3d35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2zac27S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGvmSY032414
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2EWVPBLtEC03LtV/VCcxWaAVnYY20CRfi5mVxiTmo78=; b=B2zac27SxEA5ocM9
	Ny8EFdnfWHp2KSKZzpbHqUgA3Ij6gqBLUsoW9qnDCuEAWLTCEw0ujyDoVnxAmzaP
	bxR2y6ezwTZ0+TxQYIesaIcC2QQiZpaC4ANxpXrEdLCwgraw6SZt6VNs3RvtKR3g
	GXnIN9G1kdBFTFVb3kDEFDjSMZGNNNeX7MvPEkHZ4GQw4Vvb3WeN8T8tzfA2tK4+
	yZ5OJPxim19aX0GJtymP8hRykgwTVkpuK+qqMxa+6HhoSSNisRUUo+QGjv4s93r5
	06s8ukjfPtCVBSGg3hbwqmEGyz0FZTBgCUQLngIQfNNH4606345zWH21rebLXDVk
	PMTz5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfd71h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:53:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679ef4565aso1383621cf.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029625; x=1734634425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EWVPBLtEC03LtV/VCcxWaAVnYY20CRfi5mVxiTmo78=;
        b=Bi2CagJczcEl2Jv1EYWvmpviFrp0TWlxPZScR5YvoWlOCODMYknYJ/R13pgLYa5viI
         SztnSVLMFt39sworiVBnzI9I93yuq8WBl2uXvcUSdyqqMd7+3EK0cHLkAhOMuEq/7V3H
         yeUV75aqjKo1L/Z6gsUJDoAPFuo4HxnDo3Q4KYRKM1xCg+hOK2261sgoY1GvdlkBBYXn
         QuQ+k6KjjK6aP5BP2HHwWstoCef+ePQheqEz67gU4L0Iz8/k5aCwpjs8g9wrMbPcI984
         T5JkL9ZPv9SLGw9D4DNLhFBdp4HSKwXU9Vm0+Q+8nWJOe+XK9LoMAhbohm9W1MTnaclB
         0Wrg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1XFfoR2QbZWN+ru0PKSbxryk6NNDaQnpp51aeNgXiH2EK8nbuaFlaI7qtTmCPx+11t5LAD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSqe+qVJOjVIcCFbkzaLNdelnhbvnC8ZACf+aH/NF1Tg4bbY+
	8+YYAR6vXlIWSUdPrO8r3jGVwg9sLSBdLiV5a6mrxPGF0zLdECBYkvzeHgn06FFkmGRkbSdcl5a
	FB/imfwkpY/NIdCBS3TmM3q4iBr8RfkFppXsYHCgjKykt9qWDGGu/abY=
X-Gm-Gg: ASbGncuoZvExpAFXi38yaWacAjx+FvN0rhNwxzwMu1K34X4bMHXMi1kcxualLDuFuoK
	gdHylRhxxucMrDuhmF5uaY0qoh2x2Shh1egngIJz2zg7CRd2RCJmpcepZVFkDNAfAh7e00b7sR+
	Mutwo8PNz4FwgB1d1rhPwNxvNTFx6ZDDvld5hoB0Ni2D7KuTtgeSPZwLGJjP/urab3NeZZhEAAc
	EWXwmUb6mfR2v1E3kDa8XiJZ3AVZUX+AuqGkdreJAgj7ubknBtJ25cvpsM2Fl1nAPsu6JZnJHBa
	j2KW7QtI57vBSJhslo3J+kGlNjkABYrFw54tAg==
X-Received: by 2002:a05:620a:1998:b0:7b6:6b55:887a with SMTP id af79cd13be357-7b6f89310fbmr62948885a.6.1734029625212;
        Thu, 12 Dec 2024 10:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcpI2kOmFSxCzRaWBA84uAP+qdfL00B8JP8QQaJsyPDddJIHWLhLeyOAluLqtNov6oUk5ODA==
X-Received: by 2002:a05:620a:1998:b0:7b6:6b55:887a with SMTP id af79cd13be357-7b6f89310fbmr62946685a.6.1734029624822;
        Thu, 12 Dec 2024 10:53:44 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6b1552b05sm259372466b.164.2024.12.12.10.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:53:44 -0800 (PST)
Message-ID: <496b7d4d-447d-418b-b6a9-a47b4a4968f1@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:53:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 11/19] arm64: dts: qcom: sm8650: Fix CDSP memory
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
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-11-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-11-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: v6cypAaz5vrSgIHrkSQtT7xYWKl6GEBd
X-Proofpoint-ORIG-GUID: v6cypAaz5vrSgIHrkSQtT7xYWKl6GEBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=970 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in CDSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
> copied from older DTS, but it does not look accurate at all.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

