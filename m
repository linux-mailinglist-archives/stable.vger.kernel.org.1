Return-Path: <stable+bounces-200466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1ACB0755
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4147B309AA79
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216EF2DF143;
	Tue,  9 Dec 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXhioQas";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHLYeMMO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BD2F5A34
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295246; cv=none; b=NAUmn7R2TPl4SaLw9DrAMStHN1g9pFMOPuZmGxnCmaOrS8Xh497OKKe3av2kifuQR8FSYW1ZCrLbR2yZk578kSAe+y7t4zQKpuSNueVhYP9jVJLAzIN1XaRCwhh/0Hj3qMOOlv/FqglEw228gq56eTE0wkVcBsPmd5MjoCYZwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295246; c=relaxed/simple;
	bh=lAA44fPZ+EdgJuey2t5vEPwQ7JCLgJhCXwin1+pD5es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib2T+YCFqG5Ho7rX0GRtW9+NvJPoFlYVfZCAfo6U8HIrcHvdZZjnnHDTicvBg4Jj3vHuUpdEhy92pqaieUvV7XH7QzQA2FqNSSsK1+vu7jIblHA2xH1PjIRU88Ne1hhe/jAZGL6FknAsV8GD3Rv6/8uKxYqmDpUR1gdo4PhU4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXhioQas; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHLYeMMO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9FhXbD340000
	for <stable@vger.kernel.org>; Tue, 9 Dec 2025 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=; b=WXhioQasmjcCm9iz
	Sn7wLcl6RiRm/Dl6N9GIRF4mHJckZqbq7ig8uw5nxiZ2bfKo+07RigJmnXisssN/
	yaDAYxYFgmM0D2IvV8blD3Tk/V3yV9y8isrbcb6agxemT29NmtnnGj8Df/eBawAO
	81ZZWW+F1Aiin5NNGNXy1YSqOmHQaTmlvw678LlMoWoTlxrgL42lfXT7o0dzwbWm
	ctbEAZsqCJ771ItbEzF0dAgfLjZRo5nBDUmw4n26XGNGp909Uu/oz+NUAIfKIjyJ
	g20Yo4XNXGD/+xBiTa9BgvD8rphHenvFUC29iDZ8y4FARv3uHg4KDPfJHRDQ09Eb
	qntGeQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axm9c8kb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 09 Dec 2025 15:47:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so9460062a12.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765295242; x=1765900042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=;
        b=FHLYeMMOxw2hQb4FwYBuoSV5h2ntApaJ3tJ+cqdeGfyZg/wuZ6QE0LElLNsb45upzq
         y2jCygWY/GvffPgK/MHkLdlUS0U7aj8mCKdIZXrGSgLXvZCVAKtnbDNElOOwMQRU6hsu
         cD3kE1HIonwbURQpKJmwWHpdWyj3AxwSkpGBYVvBezrWQ6ZsPHs1QS+C563RJF0c5MED
         fHj3evy0muogN++FA0dmejgeiXWuMmamZK3Wwgev3dci2TQbuPZ1LJAVNX0GCAoWYsiZ
         nMsR0NfR9E4ae9ZpKN5jiOe+H0Y/es929yn29acIpPKQG0ZF9Szk85wOPFIBpMvs7265
         SSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765295242; x=1765900042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDHkj3CwoCQL6wJWOKPjGCsfcQFkvee6eMCgSP3pCQc=;
        b=hX0gEHXPCPl3AE+lydkjAd7RRisvl4s7tX7SKthdIChle8YCtYelLuWRUhfI3tyrou
         agraTjHMXzonde1wxLh4fBo48OzbbhlqQuufYXE7XyCE9kWI3MWOYR/x31HPRTjZlg7C
         5CSDDdNbqdPkCcFw6dvqZwkmxx0pNqCebzS3T+0TVRDMfDtWfUfR5QLBCjjW9orcK6or
         QKlmJ9wTkWJp+mys5R8aLsrCCLNoE+VA9otViSBLzAq9ucrUBMXGIQsRO/tg3X4mu0p0
         pWXw+J6CMeGGGsFEuq0rfU61r0ysuufn9hhjMJKn/IIL++3xTgh1L0afWM4jtR2ECm9R
         ZMBw==
X-Forwarded-Encrypted: i=1; AJvYcCUkxHnyv+F3xhvDvmk8roHvzj7KHDkD3vXaILscZjY/GqFIreISMIIYj1/ek7o+ZiRPUDPSzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZsyyA0rLhV/UjRSHpl9Ubp1pYVhfuCsQT+ACtjrOSDJO6Kxo
	11eD68tkwT3+7F9GNTPl1ZMg0BmdbMFZn0uRmH8iT/HpkqsVM+CQ1U++wA0Pa/RyY7V4Bh9BTuB
	4pyJQe8hx/E+O1h1jq3mIaA2FK984vMXJpTRwL/lBL+K1dNX9rGcenP5QCdI=
X-Gm-Gg: AY/fxX57e2pQkoPEuIFWBGeFVTBXF4W3jraQTLDVHqFoT8weuvTaGL+k7O8StIYZwyV
	RBpfC/cJjEOGtHlAewTYf4V6bRDp6ekdiU8oK9GztrOJT8qiwG2vRQwc2Ch4UXOiVv0zVRDh4ei
	YcBWyPbLCbWEd0ZR2HLEJ/bQo865f8eWWKw0yFz2YKRQ/9xKe7Lyxvl4Zvz3OYfGowQsX5nu3mN
	2AxLa4ZuVxfRyIRMu+0hAIOwIIZZdRlVcIPPDm6Q/m+Ae2WIeqKI8qST3mw9Xq1e68NKV6Cokkx
	9OSu/8WneaFF4E0NNr3k1rudU3WNnx4cwd+Jv1IWVT4PjTnp0uoboXe1E9E5C9KJUns/ucrA2Q3
	EG0VjdxIXhV59k0uTk0AAfZ4ozwRLP2tPwGyo6b6Va+R0HZBNEhtyXip/Dt6+OqnRxGV3mw==
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:c7c6 with SMTP id 5a478bee46e88-2abc70fa21emr8054977eec.6.1765295242116;
        Tue, 09 Dec 2025 07:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhrMcLrAfPV8e9p+ctKvu2z65Q8ub97vqIxMWVyLeOFWssQ0s0J2qpalQgDpvc7C9ctW7Uww==
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:c7c6 with SMTP id 5a478bee46e88-2abc70fa21emr8054946eec.6.1765295241549;
        Tue, 09 Dec 2025 07:47:21 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87aa5fcsm44776850eec.3.2025.12.09.07.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 07:47:21 -0800 (PST)
Message-ID: <cb81444a-2dea-47f1-985d-ad406633804b@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 07:47:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "wifi: ath12k: Enable REO queue lookup table
 feature on QCN9274 hw2.0"
To: Oliver Sedlbauer <os@dev.tdt.de>, stable@vger.kernel.org
Cc: quic_rajkbhag@quicinc.com, Jeff Johnson <jjohnson@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251208103152.236840-1-os@dev.tdt.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251208103152.236840-1-os@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDExNyBTYWx0ZWRfX7RLW9xVniv9A
 6rW8Pl/S9OQOPKjykXqORVH8/fQn/ElKeeqnhl5VHO6dYQNLCBaX1hTPNyV4Rnwz1Jd1BkVR/8A
 VSZzlpPYGKGqcXhazvUa2pxHxcQJwusn6zWkXEm89ZvwnN4Muh+snNC6whghsiRGBJsDN+ngcIt
 U32dweo8uTUV5F/4KchRA2v4KfKsKDlajMgZvWDN492qCgeqUV+9voU8N2XzsHv8rO0uijD117i
 7O27s/Meoeb+P215qngr04CrnK0B6hrA1PoURBAJ2NIvHsJOgGcvG8DTcvsNxsKsL7uQB1IjQXX
 tLPMDgwNqa1Go4QYxH/d3mJ4DtIaB4NIi+zqyaGs9E5P6aZIWCKaxEbN6B6KhK8SMtSE4CQbOEq
 aRYNG5gM9sUQMj+HegDDtfx1FdPhcQ==
X-Proofpoint-ORIG-GUID: aSfQp3JRJbwCWyBfDwG6pYCqQi_rsBc2
X-Authority-Analysis: v=2.4 cv=Vcj6/Vp9 c=1 sm=1 tr=0 ts=6938448b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yIxbBWfxqtjDTp5mS7gA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: aSfQp3JRJbwCWyBfDwG6pYCqQi_rsBc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090117

On 12/8/2025 2:31 AM, Oliver Sedlbauer wrote:
> This reverts commit 3b5e5185881edf4ee5a1af575e3aedac4a38a764.
> 
> The REO queue lookup table feature was enabled in 6.12.y due to an
> upstream backport, but it causes severe RX performance degradation on
> QCN9274 hw2.0 devices.
> 
> With this feature enabled, the vast majority of received packets are
> dropped, reducing throughput drastically and making the device nearly
> unusable.
> 
> Reverting this change restores full RX performance.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 3b5e5185881e ("wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0")
> Signed-off-by: Oliver Sedlbauer <os@dev.tdt.de>
> ---
> Note:
> This commit reverts a backport that was not a fix. The backported change
> breaks previously working behavior on QCN9274 hw2.0 devices and should
> not have been applied to the 6.12.y stable kernel.
> 
>  drivers/net/wireless/ath/ath12k/hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index 057ef2d282b2..e3eb22bb9e1c 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1084,7 +1084,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.download_calib = true,
>  		.supports_suspend = false,
>  		.tcl_ring_retry = true,
> -		.reoq_lut_support = true,
> +		.reoq_lut_support = false,
>  		.supports_shadow_regs = false,
>  
>  		.num_tcl_banks = 48,

Stable team:

The issue with enabling this feature has been fixed in the mainline with:
afcefc58fdfd ("wifi: ath12k: Fix packets received in WBM error ring with REO
LUT enabled")

Hence this patch should not be reverted in the mainline.

But it is difficult to backport that patch, so the original patch should be
reverted in all of the stable trees where it was backported:
6.6, 6.12, 6.15, 6.16

/jeff

