Return-Path: <stable+bounces-232647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBUcI2d+zGl/TQYAu9opvQ
	(envelope-from <stable+bounces-232647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:09:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9E373A47
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A0063039CB1
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95572E9EB5;
	Wed,  1 Apr 2026 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SdsaoRXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U56hsVKg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5D2D0C9D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009312; cv=none; b=OlBMyL0WJTUwUljJX+psaP8KRtlIHyUSSCPZYznQ4qgOBYV6NrAF7sXZqUX+TgzFVq+A+1FfSpY+F5PTEDBZN4h4aZtJO3yxv1XxdwKMEt351/YARcWex/3sw8AFnspFkgC9xOuD9WNh9RGnDBFQBJe2Y3L3vle6WyGctZD4OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009312; c=relaxed/simple;
	bh=JzjgiJr9bh3w7eGUdwF1di2s7JHNBbqWdZsjve6fgIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4e6lghi4GQ4PicqP3x/sOyV+uod7LivUvOS8TD6ISEEK8oSD68Mn8+fdBMBgpmUvyXgKkTx3bgowo7Q9ll04QCkcAbXPR4IzbOc5uBufLzuXpwjWD1ApXy84TeeHi78z7QcXewio1SWr5RyopyxV5shZCP2QeF2MrlDtHxeeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SdsaoRXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U56hsVKg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311UYbn3103857
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 02:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=; b=SdsaoRXguAprSXDC
	9yqfibThNQiZbFtLpJLvlRbnzUlBoNti8nPp8KytZcH/7sJ6VRyHl9l0Z2dElFnJ
	xvSsBuCX+2UxFhUit/ctzMvqqkmB5hUsFrFuOXqg3K7i+nj7oAbfq6tByucuAB9d
	Xjk4yK1ogIreLKEZ3N3FH7h1MjdM99gMhCjsABL0jMLIzQrYOWSZYTZSu4AvMW4M
	d5/PDb2q9DIXOkfZ4g+HmcHGtsBVhUf1X8ZcGzQSryIvisNvWHRlMyYkVAm1h35H
	m72zq3hj3OfQp71JpQQaMjWtm80v4ZaTL+BWFKLvGsph4yierehzmjWITI0JDrbM
	z40LYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js21xqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 02:08:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so533059a91.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775009310; x=1775614110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=;
        b=U56hsVKg0m+vwwOPiRPuJkwIlHMVDVArHFhXHevJ1C+7H0oTL0YsyCW2a8ROUWaPvf
         zdMf8lSvO+IvYufklFLlLq46I/IlB3bk69THqApTn7e1dnvLPXMYeZEUtlWVx3jLgwpn
         J1/dK23tE0+nLy3gdkr7HyeL3rB0wqwSRft6m+SGepR0N/2caV77tdiUcknrhx+z5ri+
         t3zLzEvglGrwESo80/iLuLsX8O8uBK3n7AIrXN+RQtBA+N09oZZjhAjSp/boeyEYtnB4
         K4OBbqA2mLVEoNzDCgVrX1lNA/a14gY1JzFNKDaKpxxLqotK0y+dfVcZHRgA/1JMAXEd
         An/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009310; x=1775614110;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=;
        b=mWmAXLAbUWw1FWs21RlYASVJbarbFxcqsHnKI7QtpEdpa9H6xLJl0Lqiu6pjaYlSNd
         qkC/hNvVvSl3BJSS8x54FADulmYkF64BwXbuUWjTqonaRxiQkCEh6nehrn9OTYGav4Vc
         LEahZn66Gf6wFlj6rUOqoKAc4Er6xZzzvFwOc8vKcTbgp2VpX1qwapp/aqucjIxGg3i5
         1MApI3cf/nVpLDD0R3T77orM0tnaCGsKLbY7pbTBLtAxZl8C3mmkpoMBzov4GGl3f2b6
         s5ADVjRO2Jx7LAgPxlXyz3LvfcUV9LAJETS52eePLxor0jKeuzXqjWwr1Tw3OJcz8ebQ
         xeMA==
X-Forwarded-Encrypted: i=1; AJvYcCXvpv6QUsPqn/9spyDjMjbgfiUqymbuKmd+JaUiIZwDQv2XRb01aH7oKvjh+3dTfDONDSj/Y6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLSUwRBmrfUZQt+ltvwWx+qTXeJqR3TgtUVfEERq9m/3z7kGP
	2sne6HvfirvaosJpRhuyUB9cB/2ALVz6JThDUbarihFKdTHWSfsJwFdhbepm8pprM6ZNuYVluBJ
	fFx2cMcdc7ITTaYvkssKFUyc1kgS24VyFGFmp6fuJ3To6FSyawP+GpCOSdZY=
X-Gm-Gg: ATEYQzyJy+FrHRUstQ3D/1/t1rOYC2zM/LkFbnNSqJNApcmZHFeBNjVSEQh0TmyDUO5
	5pmXoAbZq/MercoPMP/j0w5ByXJMZF1CAywdBGt1o0kplzO5w7xU2noHjp2PzbtirRe3OhDOkvA
	s0a+YrWzyfBSCUu/dwMgTJfawcV4SiT4qqTUAfv2V+KLo5byDRyMVfQfLMZXz0nDoOUMLcp+M7J
	PT9f0YU6udZ9IH2VswwrpoNlYn5yWGj/BrmClnhnuZEQCGw3XUr95akfhmUbUgHOlrxjW/daDHc
	PnGQcn/MeX2ncI314M3LfPlvZnUmnzbDgZA86dX8QqtEw3WNZ0k2nr3HpxXJdXHoWjPT8pPmpwP
	XnRE01pfh23ytpsmdf1EOoAxGjd84Rw0Glb4i1lMwTv7dWxuxZ/vfaTJuvTawwSi9TQi7GjsgJ0
	6ZmXFbm1f+laljdw7lDw==
X-Received: by 2002:a17:90b:1845:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-35db8f8ebffmr5487410a91.17.1775009309698;
        Tue, 31 Mar 2026 19:08:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-35db8f8ebffmr5487375a91.17.1775009309166;
        Tue, 31 Mar 2026 19:08:29 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b96c684csm1889708a12.0.2026.03.31.19.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 19:08:28 -0700 (PDT)
Message-ID: <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:08:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: kfarnung@gmail.com, Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oBdjKeEIZc4G16cShitbnBnE6VC58Dv7
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc7e1e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=pGLkceISAAAA:8 a=A18gnXuDaOBEhP_xktQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMyBTYWx0ZWRfX2OKc8olSACQV
 LQr1zfxvAR02zDwzz2u/bQ4hbT7hK92s2kduU5obHduWhAUwMbz/EOZOhKi4+sxySMSIl3pWW9L
 mgCWfK0v+KdgLi7gHOQnHth2HppORHsJSBBwcTDQMK0u1jxhMzCvmymMiUIwVeJdEwtpO3hXcpg
 PQvMqUgjQx5n/1HnJLVDVtam96PQqTReKauRccPIJbsA3lpgh/xS3Sm0pe17oqCO9KC9Wtlofso
 Pozh/Fv38VZvqcHa5gfQoWjCAPVWq4U1dXUz+ZW3OWXw7bQc5zeMl0hMOnHYo9w7VElLnHcEPMf
 y2KrycIFXOEgVGa359Oc2Q0e9cmzpN5JjZLR81Nwn5rZ7VFGTevPtgEvjvWX/phr4G5s2gR90xT
 5ig6zb8KZcuLvNo0WPToXa3+SANPLBt8dISDFCdiRUf7wAnsIl2eEY/DvD/i6v+YAPaPawbr8+b
 TEnHrGYBWMFvG0rohug==
X-Proofpoint-GUID: oBdjKeEIZc4G16cShitbnBnE6VC58Dv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010013
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-232647-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AFC9E373A47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> From: Kyle Farnung <kfarnung@gmail.com>
> 
> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> reliability issues similar to those reported in [1]. These platforms

how similar it is? can you describe the issue in details?

> were not previously included in the ath11k PM quirk table.
> 
> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> systems.
> 
> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> 
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
> Changes in v2:
> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-kernel)
> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #2 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> +		},
> +	},
>  	{}
>  };
>  
> 
> ---
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> 
> Best regards,


