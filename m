Return-Path: <stable+bounces-188127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C1BF1DA4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0230F4E9ECC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A81DF24F;
	Mon, 20 Oct 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlqvTeos"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903751519AC
	for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970681; cv=none; b=Nv+Gc78HNAe5Mj6VlTLR4ofiIh+x8tCL8ZribgoQ37NOhwk32jw922shesFozcZiuTXHOMKAPnjcVAuMeENwHYtmXWFzVHWx2tXDa0Fg6q8Hvj/K7IdL6qzoObpAVwYMKvRrnzvFW/ihfydJa5ze2lXwMa7hzC32NC5dGwWqB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970681; c=relaxed/simple;
	bh=AWZ5JEQErQEgkIxsRTfnsV0dbvBu3BBNbNNvaGHfU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak4z/MApPyRytxhFg32w7UPD0UEHCiFWbjj+8HmCM54maz2k2Kq+XaXgnrQrmP10eYRuWO6dDnr9CgZLIjk71Prub0ARkIi0BiSQXB9/pDRY8wWgzG9rB2SxzoqECNkJNv1xO/qEJqATAXFZLWm0YfW6DTGwNA2vent+KUoVmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlqvTeos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBAQWw022738
	for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 14:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WDwzWmcq4AKDGdpNvyveTUSafU4v7snQckB7LNYwDV0=; b=SlqvTeosTjNrJ8Eb
	sO4+qHexPJuy7bWwTF+Ezj/j9GZBx+dQ1f6a0pBbXo/5d7D5JbgcePTZ3iMUJnc7
	44cOs4QlAuJx2EFC8s0D3pwXt/cgbZffLJ3h+yL40mn2OCUOoBcy7gcuqr1P+8Ck
	S8g9juUcJoUjaoanE6I+bUt8x4sbEtUoPjJe1NW/sQehaVJTATCjxWmpY2Tm7eXs
	PYCj7ZWIMRJGW1KmLCR64VSm+NYR8L7K91Po4vrao/Zu2BNyZLDKc6alu5yjnCup
	C2UqdSFVLLoAVp94yhTIS0TSw3D4aWeRrV5dsjWIV0sQjWlMQFIWl1WKu/JWvKlC
	D2D/PQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4y4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 14:31:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-81d800259e3so71790626d6.3
        for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 07:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970677; x=1761575477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDwzWmcq4AKDGdpNvyveTUSafU4v7snQckB7LNYwDV0=;
        b=IMdj5CeCDlZKNCBiSwBvr2B0GeHhTjIxhWSUlhWfcQ4Gu59OZQv+NPdgABcD/M88a/
         mwLV+dBnzkqDZRmti8L1kGrZqBB4bpYwicLe3VK2R3nLtxY/mUu/HCdejNrYYffjHTn4
         ionkfDGImUZu21z1xx0Cx6cYvcDt+Dtp1cz/fr38tAlebT8yNX9vfn2EbYdLsUZm53K1
         j73XdnaZAboxjQVtfeefr0IGRj/CKUglLLc4Bxexosi2kXYhe2sAdIS/g3dyzQOhz7hk
         ErYr7ODnpq6Tvdd5YfvDTpMg7AZMUHogXiX/5s/8kJer3wuSceU6rMzk6Qdlk64BxOwj
         m+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUBF6naCZp++zBnc8fhwTynfHXI99MwgGZrTvGxSJAg+MqaKApve3NeCB+JGUGntWCgdgsMSsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9iw7VKb0TAXUOEKFc5lrINMdx490W4VTqGYToAOhuvxouYJ3
	GuVq0Zyazng2w5B7gHDqlhfr7pfEBCmV/wiwK2wTVIOmBjuPE1+twomb2Heiafxzz2JchlAtGqX
	8IhA/2faDpMIVZSHza+nkp9V/SfWaWblG+aSvuuc9oxh8ZIRYV/iOBnD69Dk=
X-Gm-Gg: ASbGncvsa9/Cqhd6gNVAOQGg3rRDlE8BmDyARjfLhJe1VSztIlwSzAhPStS2EWISxXy
	3Q6F1UxniRpIxsRzPovZo5FsFUU3dgdoBWlC0fav9A6QeipLsIojrJVU4OUb+l3KkFZfkKsP1gO
	NpKlOI9t1OULA9UyXHxCqzVdvaIFe2AvRPQ/iz5wntV7jQgF9FMAa0m0odbon7SluTm5jZCb69/
	5dEvUmXJRzpvmociLCsAnmL2qz4nH/XGZ/SCTDF7yvdASaFkNPHbQDFwJWUhaY4ezao3HvLwner
	Ag2VQALXNeyf+3PS43+48CBNLPZjg6aB+GPlXxfe04PSfwFBfjwxoILe/crMuDTq3DB/ebVzTRa
	85UmKF0KdeKUIPHOU2MB9A1uivQ==
X-Received: by 2002:a05:622a:110e:b0:4e8:a9a2:4d50 with SMTP id d75a77b69052e-4e8a9a25039mr160564841cf.41.1760970677202;
        Mon, 20 Oct 2025 07:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEos+8Az1kXkegLkZkoK78dfEsCGhaPacnWf31fm6ldL4T9xO4u7snVWYRJLwJrJQGi8f6MRg==
X-Received: by 2002:a05:622a:110e:b0:4e8:a9a2:4d50 with SMTP id d75a77b69052e-4e8a9a25039mr160564271cf.41.1760970676602;
        Mon, 20 Oct 2025 07:31:16 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm171487535e9.16.2025.10.20.07.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:31:16 -0700 (PDT)
Message-ID: <4f394672-c7dc-4fdc-b70a-27fa8e20dd74@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 15:31:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: sdw: fix memory leak for
 sdw_stream_runtime
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stable@vger.kernel.org
References: <20251020131208.22734-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251020131208.22734-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251020131208.22734-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LYetc7ndgl0XLRxHCH-V7WY7VQQTLFcA
X-Proofpoint-GUID: LYetc7ndgl0XLRxHCH-V7WY7VQQTLFcA
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f647b6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-57JWHKmnLzaxYqXpKAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXwAuGplWZSJfQ
 20GjoZEO1r9T9ogBlQKlGOhY+OoyEbE6AykoaEN8IAOZe3RdhlzGxONiJ8cEFlv9jFTUQ6L6v1N
 dz4+id272I+rragihpOshzkMKSzBfv1VbvxPQqnR1fRJQP/BaS3edCLDXwdqMBnd6lTgoYT6Rfu
 p12FQmHflV0rQSDe5LqDQGXt6cZ+b77s4TCGbIybowRkbP0juXxnEgAOtlZRKPZvO5lb632nkW/
 0I/vPO8qU3WMY9FyEGp76MCzhYHKoCgdUT1jV+AQj2IxtB9W63CDYzS+eBpeXBSBfgH2lJ7Z4Fv
 XZ++SjqerYrf72dFgUAioqXh1bEuGKguD7ZsGD+DtnLUkJf7b94uaFOzBjHUL7yM5Fhi2qJqvxO
 9M4KhueZNvdoo3gAokfI3mhXi5cAXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023



On 10/20/25 2:12 PM, Srinivas Kandagatla wrote:
> {
> + switch (id) {
> + case WSA_CODEC_DMA_RX_0:
> + case WSA_CODEC_DMA_TX_0:
> + case WSA_CODEC_DMA_RX_1:
> + case WSA_CODEC_DMA_TX_1:
> + case WSA_CODEC_DMA_TX_2:
> + case RX_CODEC_DMA_RX_0:
> + case TX_CODEC_DMA_TX_0:
> + case RX_CODEC_DMA_RX_1:
> + case TX_CODEC_DMA_TX_1:
> + case RX_CODEC_DMA_RX_2:
> + case TX_CODEC_DMA_TX_2:
> + case RX_CODEC_DMA_RX_3:
> + case TX_CODEC_DMA_TX_3:
> + case RX_CODEC_DMA_RX_4:
> + case TX_CODEC_DMA_TX_4:
> + case RX_CODEC_DMA_RX_5:
> + case TX_CODEC_DMA_TX_5:
> + case RX_CODEC_DMA_RX_6:
> + case RX_CODEC_DMA_RX_7:

Looks like we need one more entry here for RB3.
      case SLIMBUS_0_RX...SLIMBUS_6_TX:

Hmm RB3 also has memory leaks for very long time, good that this list is
able to clean up some of that inconsistent handling of dai ids for
soundwire stream.

--srini

> + return true;
> + default:
> + break;
> + }
> +
> + return false;
> +}


