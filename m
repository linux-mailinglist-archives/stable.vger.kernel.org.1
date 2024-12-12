Return-Path: <stable+bounces-103925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430119EFBCF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39E828B57C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80E1DEFE2;
	Thu, 12 Dec 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VkTjskcd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14819309E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029646; cv=none; b=Gh6+nz90z5wTBxSdy1sLKbBrSWgI9DWMTAsG3iHLjyU+ltj9yi1cj5z48AB2ZHI1VHC7zfbrG1fzJuT9Zf4S658bbzUsho2daUo8KoHnAWm1O0Ru+FZ3o11atSdB02YgapXELcLwl14h1kRyQKHcB9rjDXBinp2Vk4pg2j6UBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029646; c=relaxed/simple;
	bh=YqD8X8dTSLW0UhsiLYoa26fBkK7MqXLrmruLEfDm07s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWiolpcgqqcc7/+EiZjr7tfMuUlTkZDDIKVGAMMl23K98StLTL/smiG2X8NM3um31aacdXJ2MNgk3Y+7zWmxFsCsC/c5VTB9ULGqTCK7NmzQAiHFLb8xxlEpCMnor0q+S57lXVRkahH2JeA8OXpEm4SiGoUlZjlawnfmTOM0as4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VkTjskcd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHJMOm002038
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTamirzBNQlHmG4r0cKpNNbWBIJC1+oLjE1ff9gQBis=; b=VkTjskcdMf07zzCD
	wEBzCOrMP5vjivpTQlZIAPePl6g2+qlqAa9nk27KYcNYSf4Rl/FauKSraIi8h3Pr
	XLHxfR+lxehVixkGfg0WClblp4F2PWF9wA8rejil1lybbf29x/XPnzeO8YgUmE2p
	OGeBjfEJE0sqv+QGuthdoaCCXD5HiIvLs0Lkg8vb4qUNLjwJyXKF+PkWtYE8qIQK
	cfuVTqgAfePZmlnkGGqs0CCoKFM3q+X44YjV28VkJoiiKpkMALLTR2of5qlw/3LR
	n3pRRsjd1VaWFeoySlTFqwDgztbbK3frBnzjj+4O+a+79zI8mOLi7ikg76hbaI/z
	ZypvQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg66fwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:54:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467975f1b53so2425211cf.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029643; x=1734634443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTamirzBNQlHmG4r0cKpNNbWBIJC1+oLjE1ff9gQBis=;
        b=IX64oSCtmtof2kZSmVVowNxysVvYVVLxk4MjdEHftX332MDzizSAtarAFmuS8FWllL
         m6MHs/3qf03VCeFm5lnN+DVZUqQOG3oOVAI9crossluqPAD169DxLDfIPf3vDWAkI4U1
         Nk58cJqZCgs2DRtwFajyubzwAvTrHYHVdAxRQXIzBRBW0UWmSGJKHMIEa+2A+i7+DUKz
         j8LC0nK99dw5T/vvrm+FshESA3Y8Qf5bZL2ob2oh/5KA+2mutYhr9VdDfQUe4mJmrhyz
         hsmZpb4X3qJmd06Yt9LYlXTfJ10suIQC/mH/JrAlcvrm7yZqjFbudrJhb8cJjwG8AFAU
         HQPw==
X-Forwarded-Encrypted: i=1; AJvYcCXMVMhj/eOIXw/8jwq6y89c+g3iyPwbS+PRVI6CzJAdxQnBOHw7bs7NaHg+5+OvL03y9ACaLTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbudznZDeiZPOimC/xkHOsKHSoR9d62+aaKVsMzQcnk9HNrSAv
	A4nC9MAZDWMwgzWLYvQv0LqXZiLDLXCuTSB5Q6mBww+Sz9SwNeqnolJyzVXaFvN6F7YW/i0POkU
	NEDh1QujHgyMuHePbAeyCAAcOD7lDsE1MbjhQ7Nq006YKpH/WRsg6Z/s=
X-Gm-Gg: ASbGncvBZQAffbF0zY3nIq+bYCtiwK988mVOmCNbiUuoeOBnJOQsLy8SiJsRzx5pPud
	5iz1Qe9w/FgNqqHd/3ZaRecyRMUx+d7/Zz/ATC7LCtYzBZlnZZpSEzJejvV/YfIO7IUmpPEwWnJ
	8aOUon7avtvmQkwNj/SAXFxWB6onTfa2pI8U56LLicm63+5LGmdXgopyA2FmfbEfWzUPBMYg24h
	teYoqmCGlQhOMtOrlzYSRYNEUrN0cLswT6HlID4O/xg1/Uk2Fx3ZDo3ENe1m5PvPKC+Jr4ZHNXF
	WxfukDphQ2M+/Vn013hWOvrx3UH+bcihQ9MxVg==
X-Received: by 2002:a05:622a:134c:b0:467:85f9:2a72 with SMTP id d75a77b69052e-467a13be41amr9729701cf.0.1734029642930;
        Thu, 12 Dec 2024 10:54:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA91CN7gmMtUSOi3v4xB4Yyybhvn12hPNspB5otAKXeqmK0F+T36aH5EtifJ1tYpQMb5Oneg==
X-Received: by 2002:a05:622a:134c:b0:467:85f9:2a72 with SMTP id d75a77b69052e-467a13be41amr9729421cf.0.1734029642562;
        Thu, 12 Dec 2024 10:54:02 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3bf50397csm9448387a12.79.2024.12.12.10.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:54:02 -0800 (PST)
Message-ID: <82fe86d7-b22e-4c69-9a37-e25185d9ba00@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:53:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 12/19] arm64: dts: qcom: sm8650: Fix MPSS memory
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
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-12-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-12-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n2FQCAcxRS9J7onxQtljp_sNARu1q4hb
X-Proofpoint-ORIG-GUID: n2FQCAcxRS9J7onxQtljp_sNARu1q4hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

