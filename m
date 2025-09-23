Return-Path: <stable+bounces-181454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA40B95496
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46142E61F7
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC313203AF;
	Tue, 23 Sep 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPqGjOEa"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB3261B9C
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620429; cv=none; b=BKy2tC/7SpobHiOZYAfuCHjpm1M6B8i1EV48gZ3tqeZPG5gLyWMLqc+Uf55hFi0lIW7pZhJrthmV9h3bfbo5CG/arVuTMh6dlJoYLq9LSZn+CEDaWyTY9me5yJCaO8jZgDSRrk9sTYnNzoxxos01v0AaxjpUoAw3l+LxU6ZC0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620429; c=relaxed/simple;
	bh=lrniPcq/EMoZoJ9q6kpsy/moAyYYSuWej0Nz5iwRsx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkU/uHAfjcW5DKNZtuvcUjrXKAlBDV6KeD9cWOq7GOiJ1qeCAdekk7JufZO6gv2oR+Q9sdKlHdJyVVwOYGRf0CAzHO5kR6dzzvAGQYeC71tu6uRzitT3uxjcBK2keB5zXoyrblzKNnFOO8Ye3EuJsM+C00pUR2VuQRaSE+l7Xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPqGjOEa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H80p015064
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JNVgEX4hQucPST2Eo16MWxlRv5Mi9D4k3k6zXwC4jYw=; b=KPqGjOEabUKamGAp
	iiIpQPs7QH10ywmOgtgwam8/vfuyOc+wADHY8NnKSsK5DlZT9YMi1BLOVbMjRo3a
	dp6yyhHhi74wQB3MrMdfbAsxBI4vmWbE16uHSdIFjBaCo/BGggjnrpVLGnGdX6fd
	m0/DPz7yznUsPA7ATZZTcsr3smvxONLMd9EBBgeJMgE7hyJvT+6qAVsUCfUj2S9b
	t5qt3uTfoApUaAflhcEyp9mx6eE7FE84Ff+05XE0H3E/v0ea4k08ude/B4uOpam4
	boLmY4LAeN+jqmZIYo02ce06sCQx5UMpW6pRq6teYNf3OI/St0srMMsVzPSzVTIy
	qNwF7g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk3wx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:40:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ebc0319so57748885ad.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 02:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620425; x=1759225225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNVgEX4hQucPST2Eo16MWxlRv5Mi9D4k3k6zXwC4jYw=;
        b=PtQjtK7maU0BRw+cjFkj5NHVVtIWmyEI8N/kaJo3TmIcOVFiDfPcMUGK322ukiFNoT
         B5pFFJ8PQ5N3sZKFVoYAI2tnMTUdBsQ8P8Mv8HjW16qCBScGA6PcWGp7CkKC9D/Rjj9r
         dp40SdjYgCosN3G/0QhWhBH0aKDdD5cKgY3FI1LZeLXR/7qvg+oPUmLG9RCweOgsP5yS
         P7wtU5eG2wYMEHIG+1DVLr51xIRxLBH3s4p+SROqnhLxjTL3PlpObTM7rv1yTw2fNBLM
         0TMtSZQMwyehoK2u71Lz4rtu3I9l2/KMk3Z9tduyZ+mnplNnrrJvL8ZNEHokUHADKETD
         ZUzw==
X-Forwarded-Encrypted: i=1; AJvYcCWkEQoZK3CuEoOPcV+WqIDHqKE7N+ZpD9TvZfR0ZsKEEDFUWAZc78o/8PbDyf11M9dLsvYShTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6C8dv7Iobv/WE0UBdgCZGV0yMUx4n6Vp3/lS7WwNovpEbhkO
	ceaJvHfbMW3TU7kp+tKTeznoPH6mxmTg20LOVA3AmN0dJxCuJRTi0a/CQGHfJad25PORWu+81dZ
	qqhQ+nUr7/3g5yaCGPPVJln/HwxurCSIUaTEzjPwZj/4SMvq9nxlOEzRLj2g=
X-Gm-Gg: ASbGncuU8H9GEnLrOvBm7rD3FkI4cbw6BJhhtmuPPoOGQ+kmxXQ+8y9+FSh7K2Gox2x
	tmcxR3qhN9kgkxHUUSDYtoTjXQxM6WWInc3zm+MTNTdj6ecXeWfjyvNw73owHzP0LHqfLuAOqOM
	Srk92amY9FNsDIHTDhxK2+36PTtphYS0pRD4shHUwiiUqqPoG69+ufsrmLNokHLhNw4IzOdQvoV
	O7JXEJ+v0sYXu11ytDkeqDd4VGC2LcsZruVEGYxXrTp8I5DGG/cdq/lgoMu4bPQpd9+2UIJ0NxO
	Mwy7eA5RAVnAQXL1i0dizhcx6MozN07cL4vPYH5NxAVt/jvIiB9XjBfsqt0omeh5P617EzQOiY5
	4OtqQ/pzvVfdmbGN67fAnKy3fOCJgEPg=
X-Received: by 2002:a17:903:11c3:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-27cc874d3edmr23610425ad.44.1758620425351;
        Tue, 23 Sep 2025 02:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC4W4K3LDTrf1UcmNKSDWbYbjQQR77LQfcgbxBqvaDdoFPpjfSSwDPQj+qqaBnWwRKsbAo2g==
X-Received: by 2002:a17:903:11c3:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-27cc874d3edmr23610165ad.44.1758620424882;
        Tue, 23 Sep 2025 02:40:24 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dd5sm157818035ad.26.2025.09.23.02.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:40:24 -0700 (PDT)
Message-ID: <f6df1f13-518c-418c-b631-cc9452ea4842@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 17:40:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Fix potential null pointer dereference in
 pru_rproc_set_ctable()
To: Zhen Ni <zhen.ni@easystack.cn>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250923083848.1147347-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20250923083848.1147347-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AdEt0_suPGwMZsmDBNmjdQyifsklSQ6Y
X-Proofpoint-ORIG-GUID: AdEt0_suPGwMZsmDBNmjdQyifsklSQ6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX0lXCjdreYW+A
 tRDl6C+W3Fi5s0Yg+EpPktRZ+OTLXsqvzYwVfB80M0QbwlAvoh9ji/7iCh0l8SgZRzW7rE1yGik
 3xLKkUMNxPxeh4RA61kXrxVby9ygNYlSZuFLHExDrFwyspn/8QTEM2AFTIKxMEDhc922RKJezEp
 Mc6Q8tved4NNEuelB89E+7ESjEV7ZR4M1bwxmaCaRA3QCFcT+4RA/ltjetnctgYk7HMhWIxKEhc
 fh0eYTo6GG/Doa00Xx4XPegGGk8d0KpBJTK1RU9qA8ippvOJm3Xkdwm1v8gsneYKHj+OFdYYjbw
 IbQ4rXsZrzdWnwrm4X2vfZFEzinF2hA0dDYgLdllkvv1aM12JQOgFOFGKYmDcznKYxSP/CXQ2YG
 WjfVtpZ7
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d26b0a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BLr15FpE7PLhzqKsQ1oA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/23/2025 4:38 PM, Zhen Ni wrote:
> pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
> check, which could lead to a null pointer dereference. Move the pru
> assignment, ensuring we never dereference a NULL rproc pointer.
> 
> Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>


LGTM. Minor style suggestion: consider changing "null" to "NULL" in the
subject/commit message for consistency with kernel coding style and
terminology.


FWIW. Please feel free to comment or override if needed.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/remoteproc/pru_rproc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 842e4b6cc5f9..5e3eb7b86a0e 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
>    */
>   int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>   {
> -	struct pru_rproc *pru = rproc->priv;
> +	struct pru_rproc *pru;
>   	unsigned int reg;
>   	u32 mask, set;
>   	u16 idx;
> @@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>   	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
>   		return -ENODEV;
>   
> +	pru = rproc->priv;
>   	/* pointer is 16 bit and index is 8-bit so mask out the rest */
>   	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
>   

-- 
Thx and BRs,
Zhongqiu Han


