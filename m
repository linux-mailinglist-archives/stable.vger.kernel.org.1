Return-Path: <stable+bounces-105408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0A9F8F2F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3683169B40
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154C1B043C;
	Fri, 20 Dec 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXk8PPEI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255A1A83F4
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687733; cv=none; b=ZwCAtJSIKmAqLInFi7ozZCInSjVfEDi2OvrsO2YDx9qxKL++jTAFUcbB0EUnkV2q4o9zNhBsqsaVhrdeJ35tFotifZJ7FKltF6TCGplI7PBmHOgagq4ta7yHZ+fqBeBwIv6jvZrgHM74pNcXZKiywX+MlkLtW0TC0IE4eGRGXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687733; c=relaxed/simple;
	bh=XbNct4c76Ic9uCHPcqgGY5elj+bO80ByXs4FfSvDnls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocy5o7D0Z4wKjq2zq942a/047fQkvF3LeoCtJNq8+W125O00gjAswONHv0I5IJl1mVE5QipJEXL1zhbsDsp2r/OTacjL2DZVVPTKqvXYuSqkTepxZkhiWTIn15iR4IDmv5+gzKctRsVsWjg+Z4dLtTUZ5z2S5Ij/5hfErH49HSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BXk8PPEI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8faTC025798
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	upEuZgACcGPccteNXGsHcBPQQzGSh0ZOSBP1SMmeJg8=; b=BXk8PPEIElthn9uS
	1RlQKDRU81nifa+wViZyd4TcddzOlJrAFB4RDs3kS37dSsbv6ZKfkXOGeJoorx/M
	G4Syzb1A+BIOa/qdOjZnPGZVtg5nomXkYAsmndSjs65HY3C+jlAS7rMShuaFW4D1
	x8Dsiyv2MUUjW6Diz0cevzv/Z6u/CtM6wdOjKrHgfBcKO0Yq3WTWt4MWu4RNjahd
	RWosAvYyxYfyKwW0gocmvkaVr8/rrcdtrCbo0YlszLIRJiB5jNInzAZj1Uo0MLYc
	sSXLsTBu4fuLyeZOXsMtuSfi856MpZ/OMsm/ja67FWvfe7lrqGU7zzXqZJggnDJF
	vlZAog==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n59x8550-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679ef4565aso3098051cf.2
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734687730; x=1735292530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upEuZgACcGPccteNXGsHcBPQQzGSh0ZOSBP1SMmeJg8=;
        b=P2FyirKtMrcgk8L/byCMJr/WaZCIXg5E4MyQXkzIAEiMJCztYL+pXVh3K8sX/xcLJj
         +rxtRyWtBML+3eIVryvj3aiU9BLCaEwiSndrXrXDLFWrLZYLTmy/E7t77rWGOMci3q62
         FclU3D+ExOJpSPhOn1J7bvZXzok+7kHU8BNPLVEvK+A8u6DVTplznrg4YlymRgLBy/xJ
         kz0C8EETsrM8RWM7hQrqO7gfEzWEflGC7cVqEyfXOxg5jfV26IWvE0/gogmwL3n7IXYN
         76fxneT2XKn/aS2xBr3pyqZ7ks/dKPCQKkjEDYLAvAP6KE1NHCRrAOeqpbXrm+XwKRLd
         AcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7p6MM9eBYQmaG5ftmCoVsFqWLgRCi6yVCogGe8YVeUzmaFsTkm100w7oZwf00CcRHxlJdKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EuUrtz47+okO/Tn9V7wSMi/8M7cF5SDP4t/QNaWUGKl1LeXO
	cKYxLlmOOhZwpfYP+iEobsUwhUuRDw6qaJZxGu6AJx4Oo784NW3Z/k69gP0ueg7akgGW6Uf6ies
	pyuQrZM2HDowwTsgi/K0AZFGJYHs1S5q0dG10u9cVkcHBKq8tTy4AUrc=
X-Gm-Gg: ASbGncvF+ZXor7+R2CBiZ4GCwoBFjJqBe1SgNzaElpityjcm/RoYwwHeZD0apaHAjRY
	ILfsVMjgo5AzM4fsdBl779EBfl2sR052/W9GaiZqMlW7eYSwSyoXCFEw94hOQMe4s0Z+c4UPnoW
	VMfedUnH1H8B5eot5Ak5JjjEpcm19iasBO/kywbxt/E8Il42Jay+xrJFp67GYbB47mqgmrWvGOR
	2StId0FpQ4UCwdxnVrH3FUGBbPRMyqEVcpkSC+SaD2hQkAGjuQTeYFSx11rvM+w3slVgqw3LYGs
	603/DvY5dS8945sqSsWtLRKunH1P17BCKgA=
X-Received: by 2002:ac8:5d0f:0:b0:466:92d8:737f with SMTP id d75a77b69052e-46a4a8fae4fmr14883601cf.8.1734687730197;
        Fri, 20 Dec 2024 01:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfnR1C569lsJcHofBTD7Tj37idjv8eOfCgixtSaFptqF2Mtevk8lxBAJ7GLYBUU39hwBD6vQ==
X-Received: by 2002:ac8:5d0f:0:b0:466:92d8:737f with SMTP id d75a77b69052e-46a4a8fae4fmr14883441cf.8.1734687729883;
        Fri, 20 Dec 2024 01:42:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f595sm157358866b.10.2024.12.20.01.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:42:09 -0800 (PST)
Message-ID: <e909ac59-b2d6-4626-8d4e-8279a691f98a@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 10:42:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm6350: Add missing parent_map for two
 clocks
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
 <20241220-sm6350-parent_map-v1-1-64f3d04cb2eb@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220-sm6350-parent_map-v1-1-64f3d04cb2eb@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6x2IhJgirJ0YOVW4c5663-ycf5P25V34
X-Proofpoint-GUID: 6x2IhJgirJ0YOVW4c5663-ycf5P25V34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=978 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200080

On 20.12.2024 10:03 AM, Luca Weiss wrote:
> If a clk_rcg2 has a parent, it should also have parent_map defined,

                      ^
                        freq_tbl

> otherwise we'll get a NULL pointer dereference when calling clk_set_rate
> like the following:
> 
>   [    3.388105] Call trace:
>   [    3.390664]  qcom_find_src_index+0x3c/0x70 (P)
>   [    3.395301]  qcom_find_src_index+0x1c/0x70 (L)
>   [    3.399934]  _freq_tbl_determine_rate+0x48/0x100
>   [    3.404753]  clk_rcg2_determine_rate+0x1c/0x28
>   [    3.409387]  clk_core_determine_round_nolock+0x58/0xe4
>   [    3.421414]  clk_core_round_rate_nolock+0x48/0xfc
>   [    3.432974]  clk_core_round_rate_nolock+0xd0/0xfc
>   [    3.444483]  clk_core_set_rate_nolock+0x8c/0x300
>   [    3.455886]  clk_set_rate+0x38/0x14c
> 
> Add the parent_map property for two clocks where it's missing and also
> un-inline the parent_data as well to keep the matching parent_map and
> parent_data together.

The patch looks good otherwise

Konrad


