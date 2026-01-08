Return-Path: <stable+bounces-206344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA1D030C8
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91654300A521
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C374472024;
	Thu,  8 Jan 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dsPMqdAC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fkNW00/V"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFC47148D
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876733; cv=none; b=ot3kiYL23+hMx1vHbTTpvCKZjTOQpfNZLHTCHWE3AewX28lEduMwLXrdgXIb+9613AhRccaOT6y55SxInvqKfYx3ilxTxWbmyHGXzwjgrIe4XwkUpekKKwWA1W/AefNxRpOyXd08DczB38pWUi6Fwk3yotPFnK3XoUuAjuOSmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876733; c=relaxed/simple;
	bh=QOFVeDUoq+RkKbWZq/pMK6/NwJiOTJMnMsw+4xmARgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phyfu2iMo54iz1dPbjsqq6DJVoxKenQGMLzf77UDgXlf1SA/SCDN6UFOYNLJN9ZSk4ZQJ9qgiLLIuGQNudc4eQ+damMG/Y95U/eRCVEKEwPBaZJtqnsScQ1IPAtjHZ7qHYMA9GTFmLACOP82pY3kNewN14pmuTQfnnzhteVVB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsPMqdAC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fkNW00/V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6087QdAi1259119
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 12:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SSZq0W/AuZXDHLOoNS/P9czI9HRnbDZBm6oN0SdJro0=; b=dsPMqdACt2Xh921z
	pRkDa8qe5suH+5GhB6H7n9IAh3Qy7G1LuN85nUII5FMXJpXNj9+kK0UMg7M1l201
	LOWIGdY+dSbghFFh+hxtyUABxBUqVM8XdcjwoFpX/BMUtjjPfWx46iZgU/RDWYt7
	vCurZWjy7vIbL3UnUlpvnUoE+b0y3Vqu20qXqNfpo3Z2EszkjScEBXM0N9PWBePb
	ZzuXegM0TdDSCU2Hm0+yALRVRh4pKQWHJJbd1BFyZihZq1DUvpVzAzmFzsY14+0k
	oIs/rzV/2q+j3d5ahZ8S/sFgTv/5UAeRsAUg+TMdBTFe6uf0MHlO/Lg1aMFHxkh8
	5IxtjQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj86grxq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 12:52:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c231297839so109031185a.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767876728; x=1768481528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSZq0W/AuZXDHLOoNS/P9czI9HRnbDZBm6oN0SdJro0=;
        b=fkNW00/VQAyq8xsMPjygWHJu4wIkmz3lGV2Aac6AaNhNFOBzk5RAqQ8tgjTivbvasa
         Sj/znN4fIuRiEgOe2eWJDCmrPZNvI2/Ap47CVb6i035Uap+BJSi2y52pfkIDNz5+ffni
         2gSFgQHi3QisVWnOTlK+YGMV2J1j5cXELZrAGHo5PIMj6NdEPjWoP93PtRUJAkj4QvM9
         lUcNNdF4QIF4YiCzpZoNKO7+ndPhffAlVZnXzljTa1fhYxyQ4Uuc69lDphvHVFv2gAfJ
         0iMN1ALtyaqrKbLXme1VI/cAFBf+Ng7zenhew1qHSQJvWaJKgc70w6IYlZbUKqziYKqq
         y/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876728; x=1768481528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSZq0W/AuZXDHLOoNS/P9czI9HRnbDZBm6oN0SdJro0=;
        b=IP0w9mgpfqTv8qmwP1Ih/O0d/85+046CpnrFqc9qEBVfYnWMoit52R2VYchRl3ckRh
         rpOIDoWa0TpQP/D61mpDc3/WvKAocoJUt4qV8QVlEYNgcgDc/xEvDdB4OuYM17Oc6/wb
         xFWopB6ZEuoGEZ+IxbQHGbsgscy2e3wM/SBf/6wWACFo5keyoPcY/Nv2b9eW7SG2NBmz
         2LXgSPT7k9X9wsC4rAy6/UtgIOTxjBzLzcWDBZPYvsf9e7vmrnmxqQWJxpqdcrJ1y0HJ
         Lj8lnqfGnEb3uedJ+0p9sRhN81aL5eCTb7nKnKu61EbxhXTs51YDKTGc6mmCZhd82ykV
         FAfQ==
X-Gm-Message-State: AOJu0Yw5xWtqzDFbVTCUXq932kr2boF0pYrYjFlKDy/ELPqbJSQNePTt
	p1uDhIZ8wtO6xje5OlEqhr8wCp77dd/mfHN+kpv8HOGAyu6f5r5wfjbNFwIUyt9J3uaGxuGXaUF
	u/sBMKaP3GfQkUvshaKzKUj7VcqHL0r8IRBfpRQKRlkuh5gFdHif8vRVPUOE=
X-Gm-Gg: AY/fxX4YUHP1RVh2eQoFBk84lH2oIHKO3nEGlVF2i8m5MjzY7g0iE3l0Q8Y4aLLsUxf
	qjegqNx2b4CT1g6z0VPy3RZSwOM9hn4dMa/BBYwpB4j4OdvFPL5ERTr/IYw2Qci7n4LyEfZ/LuC
	jebZfBRUv6s+5H9rOmh7mG9uthm0Pi1I6J3p4D542cjoK+bKV/go87Hds1FRYu5XMMoLEX9+VzK
	pjNuxdK9AsEzuOh08rZBN4eq3mbYPi8Bp9rd4mpon4iQZk0wZJQaZNsmh1Uvg3lKXpSTpqcyJAp
	euR44uO9omO+vlfzhP2ZVQTwad6hGxIX4qU4iWlNxKC4rXZ6I5B7w+HnCTXOYjhM87Vp3Pkah1y
	s1jN/Wm7hQdgNkrmkX03v9FLPgzCj3UBqMAqGQwYFAFxKAWY5HPLYTRtgoWlPis7yGpg=
X-Received: by 2002:a05:620a:1794:b0:89f:63e7:b085 with SMTP id af79cd13be357-8c389410364mr545960785a.10.1767876727849;
        Thu, 08 Jan 2026 04:52:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo45yMO7U4oaudAIbE+xfU6IFOYt/20jPnNbq86GzeDWfKgToo4vFxzHEx+lvnvjGdNyAZaQ==
X-Received: by 2002:a05:620a:1794:b0:89f:63e7:b085 with SMTP id af79cd13be357-8c389410364mr545958885a.10.1767876727439;
        Thu, 08 Jan 2026 04:52:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm811852566b.2.2026.01.08.04.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 04:52:06 -0800 (PST)
Message-ID: <dff0c32f-b471-410b-8a70-9c20e436a3b7@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 13:52:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix
 I2S2 and SWR TX pins
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260108100721.43777-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260108100721.43777-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZNjaWH7b c=1 sm=1 tr=0 ts=695fa878 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7bMfskS0MixV3btvheMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 91p1SN3tjZ93qEFr8MYD5-UrckqzmjOg
X-Proofpoint-GUID: 91p1SN3tjZ93qEFr8MYD5-UrckqzmjOg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MSBTYWx0ZWRfX+3+GBZbCpUf5
 FFRvJTcej3RBo9k6Glu6uEHQA8BnIHTUK6VFZmlGZpDE2HOnlcv1Oh+c9T6BDDhR42OD98hmM1c
 PXmyZTS6iiBjP70IJE/6dQFjjPCsaemw8+xpOVzJkrBma2+zIsO9gMQIUtzaP+XsHjhmdz2yaCz
 jQ7I1to7ekhYR1OZJ7Flf3q3WTVc1gDn2TMPx6KQnumJXLz1m8l0wcKXuqaQMSNhEcGl7/ubmX4
 fIPsm4FISFVHQj5VcDNc1iwLoOHytTChyKKkv6W+GkrzGzSGqOwCFNvmidCkZdbUeP1WwNp80ah
 8PhzDN2paUwpWqnaUok79B4FHRm7OFiLW6kv7ydi2lyZmrRluDfpBRlBf1A7DezJh+Hp9KyHY8U
 WWK5gtHgek9zezkwZ+6meO238roFWNB4kSUVeYaePkil0LcCl50E2XPmJH2ytaH+Bf5BgI3Y7nE
 tcjgXV20MlluXpqCm0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080091

On 1/8/26 11:07 AM, Krzysztof Kozlowski wrote:
> Qualcomm SC7280 and SM8350 SoCs have slightly different LPASS audio
> blocks (v9.4.5 and v9.2), however the LPASS LPI pin controllers are
> exactly the same.  The driver for SM8350 has two issues, which can be
> fixed by simply moving over to SC7280 driver which has them correct:
> 
> 1. "i2s2_data_groups" listed twice GPIO12, but should have both GPIO12
>    and GPIO13,
> 
> 2. "swr_tx_data_groups" contained GPIO5 for "swr_tx_data2" function, but
>    that function is also available on GPIO14, thus listing it twice is
>    not necessary.  OTOH, GPIO5 has also "swr_rx_data1", so selecting
>    swr_rx_data function should not block  the TX one.

This is a little difficult to read, but tldr the correct functions are:

5 -> swr_rx_data1
14 -> swr_tx_data2

which is what this patch does

so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


