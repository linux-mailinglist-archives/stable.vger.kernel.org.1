Return-Path: <stable+bounces-105407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F369F8F10
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D75F1897236
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907B1A840F;
	Fri, 20 Dec 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XuxScu8t"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB02582
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687336; cv=none; b=scd3vrGoOTzyKGiK62YRp8fQOupSYHp8W3PvFGHOa+avq9Zv0WXG85FPnuvPLen1d/HxiwxXKQGjFWkAw4Xqzl9nAQNWIOeskIuA4OknaU2wWquAuqdOBRqKxIyVhcskI1zDhQGzskA9UYQorAQWgtY3DeWUrILONa/SWjaGJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687336; c=relaxed/simple;
	bh=zedFkMBUmq0Nn3VJdZuR2Lhi3SZTkWV7cImbJYQqa5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtM+uZ04chYt8aOGIE+asU1fEMYQP05tqBtNhonCetQifQMMyAalwEtDLdrt3muD65jVCIH9B4XUSMToc0yYYJh4KH+usmXnE99c7jTq1Cu4m2avJrwUpEWTinE7TmOqIOlCcTF5FpLrbbzPanZ3GFBaFNO0f7+L6Unm9dzL83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XuxScu8t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8WnaC024281
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wvf4m/+8J1wY5OlIjVcb1V6YaBDy+XK0fLMoqV0tlg=; b=XuxScu8tfOWRW09K
	0qjLVUZiGDW75uPfsYzamvC+rrdhgI3PuS+vDBLuJPEyV/Ru1OdPzgiOgpEFCmoZ
	BtofhpQpr2Olc9HOg0FU4LZwYHHImzprO3TAhr4OnO1ZQl9tu2glBZXxmTxFRG4b
	Pyr6PIc211JFtaEeEZQ3cVqIUqg6Ba/sb80T8+oEmRP9Hk3OO1Bc9k1TSwE3bP1g
	vqvkUgyhzQyuWEg16k2RQn/5h9BSgsR4rDoKVSFizWOwmzdwkC83fm9eTrOMEYNd
	oIkeD3Vd6++krCmm9jZcPG4EEiGN7LPLH+FVEL+QPJAcEsOxHUu8cEIjurLtPm7k
	x76G8Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mt1wsr1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:35:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679d6f9587so4511461cf.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734687332; x=1735292132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wvf4m/+8J1wY5OlIjVcb1V6YaBDy+XK0fLMoqV0tlg=;
        b=wpSHzVFZYwyrJJhvM6XkOoTd4ZHljiz/EFQBOCUwDOXPxL0Kx8tz2aHc8KbyNd0so2
         FrDAjbDhI4pNMxEEA4KzOthNp/RtBe85QLqjEHbP8os6Th/jaOm2bHL6F9hRVidM9TQG
         7SFIK2MzSoMypJbHjaM+rXzbAu+I+dPpP4IwQVmc+T7+C3mRUmPTCeV9JvCl55cy47z2
         +J4f0FrAQuSemevPrGfpzdfq5+aeVSuuNhP7uf0eVtP6lXLEqe5ta9q6qbjd18eUpQdf
         /4TCGY69ic06ocElwGTAp/4GFY6Ew/hdcrTr/w0ALssxncTD5Ln7ZaVQubWvJ5XcW6kS
         wqdw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqRr5Wi4aoAnDFM+1l8iRH6ywAme3F/v3xHbCaMp2wt4nf6oDDHabrytqflwsXhKW5KRrejY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03IrIZP3e14hlLhUNQrYH6SLRbBc9dYIkjhbDQAJMqzajJ89A
	MMbloxAgry+NlcBve83wzJ47Bp2MTN8a69+Hv+5XAEYeGM6NtLShymFYprcQtALKVsxY4uykZ7Q
	oTFndGPSDYoUT6v7DPVq6f7jF6HJbsfgTeXRcfzjTmbvlVlMDJUc1TwM=
X-Gm-Gg: ASbGnctTXNO8YVSUFDy4L/ciLkSVm5D7SZbn1s29F3bvOgrt21DKTDWcUH5K112prqn
	XoUG/jCEtdaU5/XBVAgY5CRO3izwtjozusJxd8JCtzMGyXQwuQlte884ooU2F/G/bhm3R+FWgsy
	nvxqIQ32mHlCOmEjEZSe13NnDdGemqIjUARTiKFF8oZGWRvdcRZTjTlI+bhnfx3fbsdqS2aIJ4h
	thKEceS0A/C5gGnqQqiZd7UknUcRHoLDTwHvWQ/MYIHI8SasGy1GTzUQM+WG+Gp0PMtRYXG4Pk1
	BbSHwZUaIJA87TzB0oCDFXD/ofClEq2IGWI=
X-Received: by 2002:ac8:7d0e:0:b0:467:7472:7acd with SMTP id d75a77b69052e-46a4a8b7e3amr15981901cf.3.1734687332281;
        Fri, 20 Dec 2024 01:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw19IDdykvlP7lz/VRK0vXRTUP0NYRGCinJslG+yp1jJUp8nxDB71kZfGUwkbxCXHvfdoZyg==
X-Received: by 2002:ac8:7d0e:0:b0:467:7472:7acd with SMTP id d75a77b69052e-46a4a8b7e3amr15981761cf.3.1734687331900;
        Fri, 20 Dec 2024 01:35:31 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06f942sm156285066b.200.2024.12.20.01.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:35:31 -0800 (PST)
Message-ID: <756178c6-20a4-4ec7-9a2f-6d756097cc84@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 10:35:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Fix uart1 interconnect path
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241220-sm6350-uart1-icc-v1-1-f4f10fd91adf@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220-sm6350-uart1-icc-v1-1-f4f10fd91adf@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GZdnIR2HiK93hf71FDS-r2N8aBuFoXZW
X-Proofpoint-ORIG-GUID: GZdnIR2HiK93hf71FDS-r2N8aBuFoXZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=831 priorityscore=1501 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200079

On 20.12.2024 9:59 AM, Luca Weiss wrote:
> The path MASTER_QUP_0 to SLAVE_EBI_CH0 would be qup-memory path and not
> qup-config. Since the qup-memory path is not part of the qcom,geni-uart
> bindings, just replace that path with the correct path for qup-config.
> 
> Fixes: b179f35b887b ("arm64: dts: qcom: sm6350: add uart1 node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

