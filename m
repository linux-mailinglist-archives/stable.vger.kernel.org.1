Return-Path: <stable+bounces-203204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6F8CD534B
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5CF30329D3
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CD630C613;
	Mon, 22 Dec 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TRpbEqJU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXUwOiUo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9824E4C3
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393525; cv=none; b=szv//gcc0LEoC4g/S0CsHed5Q7pADpWMqv/VgSKmPp6MUk2+PI3H6RCfX7WMTjOlftH2kGIJVpwuPNjfiBJ4oFekNO7Ibll8/7H7Bh1OjWHVN6yn/zloxLcNJHro1zuy18eIXTxSAHRhwFhNdzz0Qx0zfvafh9YwBo3UEuk9Ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393525; c=relaxed/simple;
	bh=s+MH1Wksus25flQEOZT8H2FX5EwOBcctS2lnJti54rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwyLehPblOyn1O38PTafi/YRPbPrM+NAkks6UQ9/SlOCZcpm4jLzapV+qikv3FHy1kd1vyXwYQDeYnRPpsCNIDL/Np5XE7vGp0Ev83xQzRXDzLPM5BcPA+D2C9kUC/Di6QDO9pMxLAaJmiD7V2bs5LxsvrjJsoHYz3pXCEwapzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TRpbEqJU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXUwOiUo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM8QHdN090252
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uob+hAF8OiofpUbnbjg7D+uwM1p4gb+qkC9KuaAID1o=; b=TRpbEqJUhbVzV0tu
	s466P7IMqRZNeJJlAodUf//R/Gfj2EMsu1JnEcp7cYOnTjsDEQ8sg8f6pVLNipim
	gGcptlvILCb/xmWsPGm97apHwSKGr6g/xQtWAgE9HguYftCssDO3zxh4ztjuscVR
	nmBxt3outQiO0qaK+ht58YwvmwYYoRz6TKVFKhD0KQSlc3uec9IaCn5kFd3qfJ6k
	CI6HayG7gxXsd17tqoCUC0XH7cy8ib+gsFxhzR917LqrjpZBbfnTj6MMu186QMJr
	85NLRghXY6EUIJzEVXO5xznXtBl05KfUAly92bfBO52YhvQD2Daay9ViTWth87hq
	WWlERg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mracc2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:52:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edaa289e0dso12215441cf.3
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766393522; x=1766998322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uob+hAF8OiofpUbnbjg7D+uwM1p4gb+qkC9KuaAID1o=;
        b=DXUwOiUo8ol5HBsGy0Tr2Ttz02hh40kSNEsUSySNTXgxwiYsJfbgi3gooNEM6ioRWj
         YIy09i8AKeMCPfxFo5GARBYNbAeURaZ+bX84CBsl8M8gIp+dEDO1b2kqX6rSHdMVOfqk
         Pu04RpAy0XTYbe/M5tP6DraPVC85LDbE9nYMWYnx3IkemC5/fOpAZQxbyWmN5/g0R/E7
         tvT/oc5kYHWPu04cp5L8bNyeC/vx5gsx8mtjJxhaIgdcierJ36cEgl3uK1TeeYJrLI2J
         T9O4UoqgCTu04xyk7PZymInZo5OdKX2hvpLwPRi1kPENx/OxEsFSxTshLyf8a4gtRJ1J
         6XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766393522; x=1766998322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uob+hAF8OiofpUbnbjg7D+uwM1p4gb+qkC9KuaAID1o=;
        b=Tzq1ep6r78YuW8W5l0dS3VHd93K4AM7Z8y7yMq6nVhkOurdSntM8q347HniYncr3qy
         SO6L1MJu3BHSiFZHuNrLj+ws4+4Qj25DKjJxo5U9ZotjyUB5ZF1hF7HLA0qSXy3OVfZZ
         NkqxZDyMIJKz/At7NctTpEww/JXvh6L500ewjFNNspsuIlauR6SaPzF8CUNtxYTiE/6X
         VKAmJAJwsKKi1+ThAtHYV0M0zUys+l//aRUZX72I6bPGfrqVRE4waI0tx2F4dpPIbKBW
         J6NHhcUcWeFptkalLkuMexZrqfKr9awyO2B67q1w1IlCkUp5YzWV7HQe8p0tFrRHUd5z
         xUiA==
X-Forwarded-Encrypted: i=1; AJvYcCXSfnhZB5XTw7SbKgRYtSLiJlw8qrLArLmsKEyx/O9Qn3olnjMGCPf9dg+PXZ12WQR9+z2vJZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIm6iSO1B4ydD4uISsfSlS0Pj/e8wJwfCMgHGfTjWmHyUYkSb
	WlOil4jRwXO3hnfE0RbLFScBaZr0A9azcPNZxXYGF6Owo8J7bv9lZPlWLa80N4964CLLHcWQf+k
	NsOFbor4R6EScJ1OlMzuywnFvr0HLrJM5Kltd1BGG3ImJmrsump5qLNW5DxE=
X-Gm-Gg: AY/fxX5DUyzvyD5/r1rYkRR4bY4NHZ9caaPoizADE/KQaDCqgo2FB5GTGB9YaTfs/xb
	rwqsbgeb6DoW+thrsdQAEF5B4iXu1xj+L8DuWbMBmpXugy1v1n1BQnDYN+aMssLHSKaEe1MEV09
	qZunQ4Z+GjRrmjhbdP29oqBiWudZkPuGt5KWNlQ5OPgMDct9/OSqEq4GSc5kKTBTMStqh0HnKLi
	Pvnd9ObdcZxG8zOYWG977BT34+Mh2AX8J/iIMqFgFRxJnIJcirpmwgzursUrPOk6oXednhX9p2L
	dcYKa8M2vWGpn7xTo7m1PzrcvneN5iSNoX9ZNFd3+Cm35gIAlb39tIF+lpFoa4NINY3IbbrxjoT
	b4ECNAovQ2P8gdpXUqRI13DGZ/7Ur4RscFtD7kEUT1JFoyUQ6pAFx77gjuNWXnX/C2Q==
X-Received: by 2002:ac8:7c52:0:b0:4f3:616f:150 with SMTP id d75a77b69052e-4f4abbdff03mr115520391cf.0.1766393522544;
        Mon, 22 Dec 2025 00:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWwe4NdFNAaev00TKW28UVBa3Fu6va8hqB4ZolVSybJM2HPRrqFtrcc6EfguXpS+jYS4uOtw==
X-Received: by 2002:ac8:7c52:0:b0:4f3:616f:150 with SMTP id d75a77b69052e-4f4abbdff03mr115520251cf.0.1766393522151;
        Mon, 22 Dec 2025 00:52:02 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8044f4acdbsm853980266b.22.2025.12.22.00.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:52:01 -0800 (PST)
Message-ID: <e4748c15-935e-4dd0-a49f-a68921074922@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 09:51:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates
To: Johan Hovold <johan@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251221164552.19990-1-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251221164552.19990-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JOqAtLpUpBqvXB36whe28c_t_KdMiMgw
X-Proofpoint-GUID: JOqAtLpUpBqvXB36whe28c_t_KdMiMgw
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=694906b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dk0i7xQ4PQfej7aG6gsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3OSBTYWx0ZWRfX2RJtBntXA9OD
 EarRhBU1eZVBZavxyONz68EJMCRHePgzltnoFGpe+Z4GXzLyR1eKJDbHziXMgXBM+MUDU0xjzBA
 EpouSdG5PoYzV/ozxodDNQ7GTw8rj8OZa6kWZ4kBDjET1ulffEMpe46MdFDx376sRuvyTiURb18
 JfUA4leHpmbElSJuZjmfRU3BhMgFihwfR6BrOiFzRWDonE3cB83+Uo1wQDqvMkTVwbqtYJet16W
 GCYo/0TZtFlJhxTNhlJ1HR3w+K35MzRZaauMPu5jgyMdoI4JwQrTMiw6k+K3hXv8cU8iBSpDQnV
 PJ2Wty+oIr+PDbqbJSdDzGSX6m2a00ElbL+WRHO+DTaMwHMUWTrAXdzBwd4Vz5J/Vv1Zu4AS9e2
 1LlWETKbKZthZ8PG+iystxesllkDt4HF/1RfjshCJlnRWaJR0WJJ4gR6ym67sRBjL5tthGirDDW
 gDA7TOJuNbVFPqHf+xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220079

On 12/21/25 5:45 PM, Johan Hovold wrote:
> The hw clock gating register sequence consists of register value pairs
> that are written to the GPU during initialisation.
> 
> The a690 hwcg sequence has two GMU registers in it that used to amount
> to random writes in the GPU mapping, but since commit 188db3d7fe66
> ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
> the updated offsets now lie outside the mapping. This in turn breaks
> boot of machines like the Lenovo ThinkPad X13s.
> 
> Note that the updates of these GMU registers is already taken care of
> properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
> properties on a6xx too"), but for some reason these two entries were
> left in the table.

I am squinting *very* hard and I can not recall why I only removed one
of these entries.

> 
> Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 29107b362346..4c2f739ee9b7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -501,8 +501,6 @@ static const struct adreno_reglist a690_hwcg[] = {
>  	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
>  	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
>  	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
> -	{REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL, 0x10111},
> -	{REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL, 0x5555},

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

