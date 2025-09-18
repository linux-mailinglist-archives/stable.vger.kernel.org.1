Return-Path: <stable+bounces-180578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9FB86B59
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CEEB616C0
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC182DC32E;
	Thu, 18 Sep 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xtkp4Uxp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16A2D9EF2
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224115; cv=none; b=ucI0MGswW5kwMyI4VF1WdHe0Htebw34CjmbIr/9aKEB3FP5/ooj10GKtaBynCMuFE5G6czGMkyQrVjUcAVQh8dS1IR47zsotromgd2t9+eaWhDRVz0wWfI703/5dLDlwUT7H8/A9hnqPg5XJio5E5YelSYfc3SaeHcuIyNbgO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224115; c=relaxed/simple;
	bh=UaXvHS26IwDnH8wrFoWwa3f3iOMn9rhhgCGFpZk94oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsikCE5hByZ6Su846VGcB+1KcqpxBRjSmNHrdMrXC9w9/bVX0mJrWzlJex3Js5Nl+2IW8hzdd3xQRU+PnxKpscjM9qpD/pts69gl6UJOVBIIw0hwxbNB3f/r7vmjIP9mKWDBlIco4YZ321RhxHjshONLjPCUceHZnCQ0tCkXSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xtkp4Uxp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIL7KN009886
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=; b=Xtkp4UxpjlRktOka
	jqZWRYl6lSN6eBIMOk4s/wbGhSvw2lIWoj6cu6WlGj6xj3iGFo2eB3QqIeTDMT/0
	uraaCxyVsyAAgfijWWXphxW2hlWGDySWfEhFPiGXgho/D2NZIa1nF+FB6h0q+3Up
	G2W4FhUNU8oPycgRTNshqheGYYz4phi5FHc8Qv9Wph5QRvqH71EGyUlbE/Q5vQvT
	4I8kk0U05HFSM6tVz0KFXgOnzAeKryj3v6pUTUkjzc3p0bgxMN9259j0QXxW92m3
	+sDsp4FptxgRepegnCZPjdn4a2oRtDiQWkmhE4G8a6/k71rAysZOCuKBghjDkR1l
	jGREzA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498q9d89sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 19:35:11 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-75075d3d06eso1674087a34.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224111; x=1758828911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=;
        b=AKcqr0utmpkvJP23X4vJuHhp/71hmDmnTO/z3fLXWhxYla3yKuKWb3PjupiYD6TJhg
         H1Ng65leXq9dxbeypREtsrChHdkljfo0Syc8NM0NhpnQXNmXHpTxgeS2MDZL3TzUSNoI
         zQGCajdopTy4mUfVeTeFMCwhB2cGykESl569LTyre7vy0+S8pMbGqslyiI4mYQOWEur9
         /xxHEyu14F3ckBLuALpFdvEfyuvmfufGro8p00yw9rmlsl2ssDkt8meP4BRdFi8C2Uor
         vhAXJgO0fBwvkaZjllu79spOqlPJV3jLqEU6L4GfEnqncywPZWHe+OncEdU/qfDxcIQi
         OSiA==
X-Forwarded-Encrypted: i=1; AJvYcCWyEZX3pI8N+jx9nNWKFwHhhrT6bWowGBAzd7POr/kRZeaRM6csH42gPFA9Z0+2PQWxvjrAgCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrsnzhnu2vbnSnP0pFKJ0q9lCFo2ZqyFT8v0dnOnIozhgCgoit
	XdcNdmeBD+hNM0lcnNNLnSB9tR1bXH+41PVeEmjUcqAdA1lCA2qbXMGGm6PjlqRquNTZ4XtGwyY
	yG79c3IzF/4BIlqgESewc3E+tLI9lkC9EM8wEP1RcvaMtHsD/5CO4tBHn8LCMeZ/kPiQ=
X-Gm-Gg: ASbGncsAiz9OrEqSsI+RaPHTwPxQH+UvGAmVhrs4FQWaKRCpi+B5kBPyR1LsLp+cu8c
	+H+l3TFeptL7g8IMZKer7am99GBllSmX/ebAUSx37DKQhgJKAYyANR/PEHj6kO4yK7U839EGqpM
	QIgOQKOJ6WMQE9LAn8OrVtPCIbkPoCXGZa+0dd/tH9S2iE2DwaUj/UHsDHEby5qE7vWoERHK+Nn
	2ag2+VwAKfWGB9SnfZIqdFS/gxx+sVHLOJVJe0BTD6RhKTwRT8FrOdMaUJjsLlSKqL07dOxEVW7
	livZJYF4XFL/DywKi4nuL9wsYIezuyEwpEVCFBbwM/pka0J+qUXICMFsTemFbjzGYFU51QW8/Pq
	DKLlhWARucQZ9BaeOFucwQ0D05YMGrjSUlkFE
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571454a34.30.1758224110956;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwoxCYY5Mc8kGGNdF5NWEJW8KsmKqjizen55hJBywYZk1+LhtDIBl6+ggbcPD21Fo/hCQlzA==
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571435a34.30.1758224110392;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db7d1200sm1008387eaf.21.2025.09.18.12.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Message-ID: <1e3e936e-595b-40d6-8404-aaeffdeb3df8@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:35:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YsAPR5YX c=1 sm=1 tr=0 ts=68cc5ef0 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=KkCtspFpTa3j_I0B6KMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: rD-uvGkGQeOICjaeSk_8SAx1VXgDKivc
X-Proofpoint-ORIG-GUID: rD-uvGkGQeOICjaeSk_8SAx1VXgDKivc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE2MyBTYWx0ZWRfXwcitk5CVLUEq
 S5sHZBVTLFDdiJS3Lv+vkhJtE9Nu3nZP0r8F7E108IC8j3CxLdju9uOvLRjM7PyCGEK9i6rA3Pr
 GblviONCPznn3HgAUe7NP7J61TdLcBUqdHgPjKj2tMudpOfy3bnNKF/V2GApPXHorKO+qLLAFj+
 0STO530GL21y/H1mZU1/5ou6LrUvu8XK7+Ng4TAEGnfthdoi+b3SB5RQqJppbI8fNdNYhdI1Jra
 mDaXJAfXNtAEWfgurswNtRPUo+rNcPbOt5G3jj751iwNvw9nIn7Bu+YN5NwyHhHXWnDp1Y975k6
 8N/oYOCACGxDkVJ54CFhEUmhbUXPoqLJiiSXrTKtWxWOt3S2vRmmxrt36Er7OMdaBok9YcQ4Wo/
 SPjGjAyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180163

On 9/17/2025 12:20 PM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 378ac96b861b7..1a42b4abe7168 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2557,7 +2557,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>  					   GFP_KERNEL);
>  	if (!m3_mem->vaddr) {
>  		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
> -			   fw->size);
> +			   m3_len);
>  		ret = -ENOMEM;
>  		goto out;
>  	}

I'll fix this subject misspelling:
WARNING:TYPO_SPELLING: 'derefence' may be misspelled - perhaps 'dereference'?

/jeff

