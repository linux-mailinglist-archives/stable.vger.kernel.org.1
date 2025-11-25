Return-Path: <stable+bounces-196864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C075C836DD
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 903D434B4B4
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08519287256;
	Tue, 25 Nov 2025 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3GQjHDU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DTncleeA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55C1FF7D7
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764050379; cv=none; b=RIAXJETQv2lgyW4wt7X0oC04vAgcCMOut3RPzCKqZhg3hfqMaYi/j/JzSkF42eUo+dSRF4A/Uk3ej9fdVEQgryuh0pNdkL4OQic33qsTzEV/8P/9U5m+Z3QYwuKut3YzWzG0BshhjnY6PCQ7Z5NG9kTaRsjNAZ01muG41jRlkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764050379; c=relaxed/simple;
	bh=DLzeVXg1Kpqmdac8Ngi+Yun1wczuPvzXY/lPXP9whX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAWJcNSdtAByJa4L4CO92jS/k90W450aY9phjaHlz/PtsR3IfNhd8oRwE9tTuRB7m+a/JZF7ept9I74xX3vuPf5asDg1djwVhIrQKYgU1sjjrzZMNPuoCr+1VFNBRHvxnS97ZdiSyLG1ecXtaRh3X5ut/3EBk83NtM+RGdkSi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3GQjHDU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DTncleeA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2ghbi1741133
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rMDLkTRGzuILPlvQEG+XGyWGEVc5AUhPUHDgO7Immwg=; b=J3GQjHDUaOnvR5sn
	9HdhkzB51sn/jPdoNGJ0yjc5l846wKVShpoL00WL4BWI8t0wUHNF7D+O+ZN6jG/r
	Uld0Z8bmFJi/AZSvCruE59rMJAVyT664bW+Ga1srrxRofCbewr6OLX/WI9u9jKJ6
	IZeFUM4wPR+SnMhNpn9w7gX8BSoX4qIKdhsMIeLxAGSnIyepj7W7fdLcuJ0NXP5R
	LOVGO7k606ER4ABK5sQB4mZOBMPLQ0bJe5jQ8GzQOjZ8qPFHeozU5q7j/5ZKHc5F
	CxhNsgAS4nfTEBxRNdze2N+wUHFrOE0w47mocLhREXNnO8/El+ubX1fI9kM89KmZ
	0wje6Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amteba3ca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:59:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aa148105a2so4697615b3a.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764050377; x=1764655177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMDLkTRGzuILPlvQEG+XGyWGEVc5AUhPUHDgO7Immwg=;
        b=DTncleeAYscSXe9hjVAdFxDvW1728RaGNKAIZllYD8FaQRHmpJdpuNvzu8AFJLSR74
         0xvXfTKMRPQj87JHKvtvpp2G3hSmsR+rkuaKSLZQLmr8u2FKfuj0npZJ/YYMOFkqk5hs
         BXUGanQrTGXcCk5IHHRY5zOWyRc8McMZfVsPE7NRws+jeAT0F8lOTZ5kcx8DBwMqr2Zx
         JeSf3LPin0GMojcBMC91OQ1m97L+3yyx87g/Z74aBkQdqx2MOZjiXIUFF09iyB5NREf1
         xC2bBUfu8shMqQA8SLSZ+0kGZ+rLrHUhmBEQPJPSvilx31yqSI9KcjU51PoZYBJpyt7j
         khpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764050377; x=1764655177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMDLkTRGzuILPlvQEG+XGyWGEVc5AUhPUHDgO7Immwg=;
        b=sFZPVTkEzE+WGOzJjDX4o3FVoWpJgwHrSK1sE/8o0ck+9o1Q6iK73OE+/vsocJv8QB
         BQABRBF3qVMWkOsziyTLjD67YdUb6ji5JZuGo7iwIjY4RRlaeQN9DobcNoykpJ/GIgwp
         V+JoZ2XaUXh4dRVd7bTCW0eyIAmv1HPnBagqspHlz05qeAW4GegnmJ8AhB/8YVWzIgE2
         Q5mBxgR5VYpEKWcHqfUR5n9UHtHm2bsl4IItUwH8uVhu2/UkH+f1cRftAfAnQybWnvr2
         42+UtCeKfh2phZvQeZxNntF99ne0vLdANz5xy7W4GqsLVTJ91zufBg9ScPkLR0DOBnfu
         oz7g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ORpa3ZS2zlzq7yFmkA4NwW1uxgMdzLo1QStPft6gZSj2beNuUS23saFQuJDKEWfpycF71KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX+B+uE7uqCPMxt3PXVn8fQ73os2eM4+l1VTatwtfdrTOLFKa
	2d5ypQiBIJSe6mAvOIY/eaGoeiPifDn7AleW3I7GY7GUrye5VGs8A74OwnlCruqrFgd1tOr0oeI
	BaLhyB2rQc+deIB2JBhGgQl0tk8oCjaluIUkhqQCy0ZquTPXJvT09Gf6iB3c=
X-Gm-Gg: ASbGncvpyT002jSVnqGG8tL58Mei43ikOsmG8f2gD5cLyDAipCk2QEe1W9JJjrKXsJq
	GFm/SZN4Ox7UMd6H/jAsshYh1xoDoGYntaBcksb9e+pJJxmbcJFIp9n16u4dAt5pQ/clTEh7Doh
	n2oUczwXmeXaTsf2PcruHVm59oJ/1AFmb1IEUMRrXEtQt4J2vtsfsV6/trPLEjXQ6W92dAhSalW
	DhP1qNaX8pRUlUri+PbumB4xHmzJUybyV6s+XX1gyZD95JSWXxrvRKw4gqMuB8695JtGlx8AqC0
	HbGlesnnJ5UywKB6ifKhiOjihj2M8jGZvJwQwH3+V9f3GRa8lMpCmCn5VFSsbnWDe8t2a1OrYw7
	4IX0wE+dS/CxCXUGbYu+5WTk9MxnTKN8f6d4QX9Vly8wBW/Fa+uUxLuPy0GruAWmt7Ky6+A==
X-Received: by 2002:a05:6a00:3a1a:b0:7a2:6eb3:71ee with SMTP id d2e1a72fcca58-7ca8946ca5amr1800793b3a.9.1764050376758;
        Mon, 24 Nov 2025 21:59:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKnxLXlUlFvXKip92+KHsNOygVA8ja82PGqxLupS4kq4t+WYy23EeMJ33yx5Jw2IOAgdM2gQ==
X-Received: by 2002:a05:6a00:3a1a:b0:7a2:6eb3:71ee with SMTP id d2e1a72fcca58-7ca8946ca5amr1800762b3a.9.1764050376260;
        Mon, 24 Nov 2025 21:59:36 -0800 (PST)
Received: from [10.133.33.228] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm16619347b3a.52.2025.11.24.21.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 21:59:35 -0800 (PST)
Message-ID: <7e5fc36b-1b87-4e52-94b8-d8d67dcf33cc@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 13:59:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: vdec: restrict EOS addr quirk to IRIS2
 only
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mecid <mecid@mecomediagroup.de>
References: <20251125-venus-vp9-fix-v2-1-8bfcea128b95@oss.qualcomm.com>
Content-Language: en-US
From: Renjiang Han <renjiang.han@oss.qualcomm.com>
In-Reply-To: <20251125-venus-vp9-fix-v2-1-8bfcea128b95@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 88_Ex0VuanF1t8ed-JPO3_0ASwzpEERw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0NyBTYWx0ZWRfX7vBCCC+TPfL5
 8DIrb4roP1cCJIaDdccRpd4wqJS2mSm7Wn+1hOqUqC559++xfSsDu1+OkDd79faFyhTp5dncQ2z
 K9GP+pSAGcTVK8STpkZiTRpqU+bcYTAAISoXxcOlgxQ9CAdzjSiI+2f64WU7S3OiwuBtSdoV6uH
 klzanbFjvVSEUCRrFbgRScBCw8Tujr3rmtmGLB5mwpNWZxL2EeoqirFygFF6wG174kB2PXLfSs4
 XfIBm8Y6tqoaw8zhjqmZR7OtVbXoUogYtf5N+kDojaB2fJn4mhATqJKequKEUeaMzMGMHAc4pAe
 oxYR44Uwf8yqehTLyuuXLsdduoO2DoDZGhps81DWEAoIEwuTQ8rOHeZPap8g3Hs/6hjkcOOiYR/
 6b6Gl001MdBbMc5TNuwQacqnFdOqIg==
X-Proofpoint-ORIG-GUID: 88_Ex0VuanF1t8ed-JPO3_0ASwzpEERw
X-Authority-Analysis: v=2.4 cv=d7f4CBjE c=1 sm=1 tr=0 ts=692545c9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=xp9ffQbxc1IWA5zbOIUA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250047


On 11/25/2025 1:34 PM, Dikshita Agarwal wrote:
> On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware could
> not handle a dummy device address for EOS buffers, so a NULL device
> address is sent instead. The existing check used IS_V6() alongside a
> firmware version gate:
>
>      if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
>          fdata.device_addr = 0;
>      else
> 	fdata.device_addr = 0xdeadb000;
>
> However, SC7280 which is also V6, uses a firmware string of the form
> "1.0.<commit-hash>", which the version parser translates to 1.0.0. This
> unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
> condition on SC7280. Combined with IS_V6() matching there as well, the
> quirk is incorrectly applied to SC7280, causing VP9 decode failures.
>
> Constrain the check to IRIS2 (SM8250) only, which is the only platform
> that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
> restores correct behavior on SC7280 (no forced NULL EOS buffer address).
>
> Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop command")
> Cc: stable@vger.kernel.org
> Reported-by: Mecid <mecid@mecomediagroup.de>
> Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
> Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fixed email address for Mecid (Konrad)
> - Added inline comment for the quirk (Konrad)
> - Link to v1: https://lore.kernel.org/r/20251124-venus-vp9-fix-v1-1-2ff36d9f2374@oss.qualcomm.com
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4a6641fdffcf79705893be58c7ec5cf485e2fab9..6b3d5e59133e6902353d15c24c8bbaed4fcb6808 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -565,7 +565,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>   
>   		fdata.buffer_type = HFI_BUFFER_INPUT;
>   		fdata.flags |= HFI_BUFFERFLAG_EOS;
> -		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
> +
> +		/* Send NULL EOS addr for only IRIS2 (SM8250),for firmware <= 1.0.87.
> +		 * SC7280 also reports "1.0.<hash>" parsed as 1.0.0; restricting to IRIS2
> +		 * avoids misapplying this quirk and breaking VP9 decode on SC7280.
> +		 */
> +
> +		if (IS_IRIS2(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>   			fdata.device_addr = 0;
>   		else
>   			fdata.device_addr = 0xdeadb000;
>
> ---
> base-commit: 1f2353f5a1af995efbf7bea44341aa0d03460b28
> change-id: 20251121-venus-vp9-fix-1ff602724c02
Tested-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
>
> Best regards,

-- 
Best regards,
Renjiang Han


