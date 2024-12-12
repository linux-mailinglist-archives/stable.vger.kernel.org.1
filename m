Return-Path: <stable+bounces-103915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE79EFB5F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50400188E6B1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5E17BB24;
	Thu, 12 Dec 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dbbnbrog"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD82F2F
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029222; cv=none; b=n7hNxLpmQ4oVHSmwCF1Cjd1g3ztZPjSzLcqSsBTZZGxT/11n7NUFLK3iWvrl8f8WAxHtPzSGop1qRcdjm2Z3kE/GX67dXuhZaiMwhaaJw8cQ7rTaN7nhd7vtshlJUkc5zJ3VKa8CE1W+DhMYZ+3Z7m4V1ElGR3jZXOxxInV4B/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029222; c=relaxed/simple;
	bh=SOYf3SfjKiZ95SWaRy9LWaJhoXXb98txie33gEZoVzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1aWib/jM0sQFzpXQnxoOLodrnXoQQKSgciyWzIQtD3jcQaPHs9Fput4lGG50PYrJ5Zeuxx/aFPf+DUalkPiMsHT6KDRhhGWwYhBAOubGzlIcSfhCG/Xd0zSTEFMYAfEnP0vlWI4sYcvlZ0F0zaPzHdxyGoUpfCWRhOV4b4Tot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dbbnbrog; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCH86HZ030073
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PmOQqrjMzqeBGq34PKXHlYCtCJdL+dzG6VReuDNyzL8=; b=DbbnbrogjPRbR5Y/
	U0XsqR6SXEAfFTeGJBKsNC0CHLjyf7O+GFWG5GTuaMhV5gfJ3pTkVTEXQma2IdAt
	swe2QCKr9EtD1PnfW20FtPQidKQBtQmSRRKbIwG6IN2/dYJXARDhGc1Z1QaIl0rd
	uWQHghK1GXp2dyJXg07P77v2XCb8jjThsxc1b7hSqaCF+QtXquS7JKHcdGVa4W84
	AT2KHNVk65qyuiXwdyvQHoLfF1THBtzwOtzlJRKoVFnwHGgv3F4ty5FLSW2MwhhS
	65aUJslk/pYPdUiveFlwzcwBooMDwjjA4BlSt+jTQsZUlWH4y7wa+WQ0N20+4fSK
	bMWvvw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4cb9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:46:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466a20c8e57so2009181cf.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029213; x=1734634013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmOQqrjMzqeBGq34PKXHlYCtCJdL+dzG6VReuDNyzL8=;
        b=jYMAeAQcpvw6iq74yJX+iogj37V2EjZFWsycJuS5S0l2eO5dLa4vzTP5TQzu+I2ftR
         queCYB7528bxPTtYUr/Awv5u5I0aruZQ09UsvCzy7uPgARb8Oo0Ua0rO/dmGO4TKsV/b
         9lwWrPhN640m5Pja/WA3SKZLqNq+ex4LsaADEFWzk4W6xhoZEfmrStJDqMxazCI7W6Fx
         VOFK3eW/9C8XeC/uTLKi4cMsrhvyXBO6ktm+F3OaeQLqW93H+emQitYwHpKsBTggulEr
         VQM12nyTtr1Gy1Mj6S7BazZQy8uXu0dw7g+NoVjW/4tFm8Y9GuJE790T35cW/KzgE5jd
         EPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxONMAPMhk8JaH9d0rk74cnvFiUoN03YJqSMAEeBraIWBsRlkfmvkM3pOFL0b5h9omtGZ9mWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjC/gU4fvMwsMY+ze+THo4FrkByfoOhVYmBGvXZwVyY3H0H+3
	keL7P1pd6R/sdCFdFh543PKG87md/zFxabNZeseJ73WYjWXAWWMvmdPgRYoPK1gm99on2PZfkIX
	m2q+kh7Ea2T2bvjTryCwIIGnTSXvXumFj6L7wyCFhh4Vg1IrOy6tdS20=
X-Gm-Gg: ASbGncsarxPWWYSDeF6GLTVQv9kTOt2HoWPdkNg29v/JSXfXhcVDTBCJqaWUic5YSn+
	xUrm4rButEFL9aMdNQU4iCWDu5X+nIRBxlIAcaU5zQNIqyqLl6XJLuGR3LZllrH81hqd4zWyQD6
	oKMq4DEKMRMoTn/LX1UGoWBDiIG1fhFFJ14nNl9Ls+QeSpGzswWCnhN4hDHLvqrsqq7CL8mYLxr
	Sg8om2A8hKPLWiGK51Er/CXpX6BCnGNkaQdh9ZIkzWJtLzjDGRWUz9njr39tt2sQWr7+aYrnVc8
	04hVS/30GtE6vCPGyj5iVDIfqlvi2d9ZGJeJ+A==
X-Received: by 2002:a05:622a:1a87:b0:461:4467:14bb with SMTP id d75a77b69052e-467a14cf99fmr7724411cf.2.1734029213599;
        Thu, 12 Dec 2024 10:46:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdpfmTx2mHf6sXsAQz5sQIHlNuntc35VI2+MYkILXa1EgItZeGr7YDJrQd/P66nUPjXjjjCA==
X-Received: by 2002:a05:622a:1a87:b0:461:4467:14bb with SMTP id d75a77b69052e-467a14cf99fmr7723591cf.2.1734029211712;
        Thu, 12 Dec 2024 10:46:51 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb7722acsm7157269a12.3.2024.12.12.10.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:46:50 -0800 (PST)
Message-ID: <8b2519dd-3338-4770-9f9e-d99de5648fcd@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:46:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] arm64: dts: qcom: sm8350: Fix ADSP memory base
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
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-1-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-1-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YZ63YsnAL-VsXGVsbo8AU-dkuX2Y4j0i
X-Proofpoint-GUID: YZ63YsnAL-VsXGVsbo8AU-dkuX2Y4j0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=831
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in ADSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0300_0000 with length of 0x10000.  0x1730_0000,
> value used so far, was copied from downstream DTS, is in the middle of
> unused space and downstream DTS describes the PIL loader, which is a bit
> different interface.
> 
> Assume existing value (thus downstream DTS) is not really describing the
> intended ADSP PAS region.
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

