Return-Path: <stable+bounces-103916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC49EFB63
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758AA16C56B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECD18784A;
	Thu, 12 Dec 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MytoWnSo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534C17BB24
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029251; cv=none; b=LsuXrCbRfXQaELkycrN2LGViij2W8g3VSKondlPkB3qUGeI22cY8qNV/IdCTlfN6EmJoIu0nrmMxofyBPvmAwj0ck0eyYuBhuj/XuBilHxhWxgNBbiE/7UxUMq3/ISkksRA26atAbZb46DG0ezULRy8w4wBEIBbVK9MxXlFavkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029251; c=relaxed/simple;
	bh=dRBwDdqVsCCEYLwA11HwOnnwTyk4wl1aEnHQ556Jb08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQF0uv/s+u0XI95F+eWI+d3DepHyq4i4femnjEhOMgArkswxp0dmJ/WvbP1at5SdK3nm/veVdbv+SU5X2GqOeR5dM1UAOOG8rElCGLJtic3NWZyB0xbAIGPiHEO+1Wnwuq1P1XbR1WbhV2N4hshvAlSYv7cFmmOn1j7ynZZpLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MytoWnSo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHwDfF028100
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVNJWdu24OyWB2jkcJ8N7wb3euEWMH8XguJzsbaIJ/s=; b=MytoWnSoV1jWWrpz
	QZ5FYuzg9pwFWurCI3HZM5hybr/E2viiamMoJciRVHUy2HHBdP9xJTQXQCUWfcda
	s56uEOeHsJ5hWTngjVSEbSzBZ18CvWsIJnQv/46Caruz+Pi/0erro15pIztyWF15
	IOoHuU+AEjeZDNBpGNsTqNbb79Jpn32vsE2f3f7rXg+XlKWyJLlOBFamKpCnhkhD
	I9gJ45PJng5px8KeT6yJjlPM8OdVBjrZ6xZozY2Hr+XZOpc0c5knAIXShm+yo1Dt
	C8/qVnt4UnBqCh9d0h1gbw3Q6FKKPDVoXIUZC0hkiWTKrNso69uYZcRuRnTO0qRI
	ZIlDuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xuxns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:47:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679af4d6b7so1970121cf.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029248; x=1734634048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVNJWdu24OyWB2jkcJ8N7wb3euEWMH8XguJzsbaIJ/s=;
        b=KpssQIs3m/Cx1JkSSyK+p0wy+9gO8ccMlR1o/y4eImoZ7NJcPyMf0EVDAwo/0imuwm
         s8tYoA3T7/3ZquzvPa7eYwlCUBJ7/SUVbYoXcBGW+bkq29gTNP9UERS5gFsBlsWFL891
         UzZ1ijpYWjDn7h0AxxlbHtjh2fJyQFwTHzMUb+dVxiGJpNP+L45rtwMuEdMrIeWj725K
         PNqq20eN/pRTj8uPxl0FWqogUBtged+EkV9t1WkwIt9NSncI+vuFW+OaxMPTDki3673/
         Mdp9iZVfvW8CFjPD19xgHduGkOYbWHn5ZGO7kz0zZ+C29HfqBHLiT9EwOQ2O8dYYEFh8
         Xe7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxwEjLh/yrZfQ83g6ojos5Vq4z8/AhH6zjrFL1mkNqsTHDvmdJDMCZnsxhIaz/MaQOlvqjSdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCABIdmnI9nkNoZOTdX5lC2tJueBCmf+9bmd8WrYHfb15H8Uy
	Hc3Y42DVmiGPqps8kd/fAc8oD5N3DQG0Y3f4iJfE46rW8HHDgfa1OjHUoffdVEnbUzjUJYV2R8h
	YujoxpJhFZkggN9c2U/mnQSW0KvZy3gZV4aAKlPht73mrVFsVjLO/jwyV/gykBtQ=
X-Gm-Gg: ASbGncuI1Ay/42f3hg6hZyAdgb8qHNqNZW9U3HTFhQcFD17UMpPneJ0TtrIcfoGFOjl
	987j27eW6ScaHSgEsVPc0RWeycbLwEfvA8OhG42968PQDzrDl9amq/0BtxBlm8kr8W2SprtQLvd
	pSHwBwleeGE9Uor4blw5wh0WmPkXBvmA7ijzJHl7gKwwhDBbg00eYweUjUEE2cJHl5I6cUlmCvf
	594qR9dYkUAjRgUNHtZHiJA42OIu1URFaDFzfz3tV77Fs+gSy5ByN9GBzaSG6uGuuNx+iLSGs18
	9LUWqtnmCNUG/Zg4yxfriUl1RUpnzwBr7TmM+A==
X-Received: by 2002:a05:622a:1a09:b0:467:79fc:b009 with SMTP id d75a77b69052e-467a16beaccmr8769481cf.11.1734029248351;
        Thu, 12 Dec 2024 10:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvvMQ7lofip2DSWuv2YsHw8pxK/baG/hp3YQw+8Snci4cZdUkEXAtY399JRKgvY3WDHKaA7w==
X-Received: by 2002:a05:622a:1a09:b0:467:79fc:b009 with SMTP id d75a77b69052e-467a16beaccmr8769341cf.11.1734029247995;
        Thu, 12 Dec 2024 10:47:27 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69c3512f4sm482187966b.2.2024.12.12.10.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:47:27 -0800 (PST)
Message-ID: <e91fff1f-31d4-46db-bc32-c26f2f8edf67@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:47:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] arm64: dts: qcom: sm8350: Fix CDSP memory base
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
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-2-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-2-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q8lizDZd5gpKKiPJRRbupht_PtclV18d
X-Proofpoint-GUID: Q8lizDZd5gpKKiPJRRbupht_PtclV18d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=919 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120135

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in CDSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0a30_0000 with length of 0x10000.  0x9890_0000,
> value used so far, was copied from downstream DTS, is in the middle of
> RAM/DDR space and downstream DTS describes the PIL loader, which is a
> bit different interface.  Datasheet says that one of the main CDSP
> address spaces is 0x0980_0000, which is oddly similar to 0x9890_0000,
> but quite different.
> 
> Assume existing value (thus downstream DTS) is not really describing the
> intended CDSP PAS region.
> 
> Correct the base address and length, which also moves the node to
> different place to keep things sorted by unit address.  The diff looks
> big, but only the unit address and "reg" property were changed.  This
> should have no functional impact on Linux users, because PAS loader does
> not use this address space at all.
> 
> Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

