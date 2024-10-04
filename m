Return-Path: <stable+bounces-81132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459F99111B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC68B21BC2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582031ADFEF;
	Fri,  4 Oct 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YgYuA8qx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934A231CA7;
	Fri,  4 Oct 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075888; cv=none; b=hAJAq3mg8u8hg8pNhRZqBJN54tWUkGoREWDLH6zeaUrpBNK6OnW/vSib2WbevnRvhmo6JzPoZxIONxHqZleXS+MdsL6feOgPcZhZK3iGS2SLoUU9g45YI4ET9d3F0hhbGLo8bxbtm44W/Yk4X/2YtoO7txvrZzetD525F7Hx1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075888; c=relaxed/simple;
	bh=BlCs4G57c75rPmpj9j2Sv00qNA2/cF5ptyo3jJ2dc78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lcnJvkXi7hsxLdxy02Lsjvpa+zhDYTecH45h+TkawXMM7KIH4l+PxOU573WNv5Xi5Zuq9AbvEeAuU0VHl3oWFzB3hpyig1s51AW9IHf6WXuluc0Dccisofpp5kF4FdnSE3cgbt4ItabocPICJ9ohn7sT1WqeODI4b/PesXTr5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YgYuA8qx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494AWxPd025555;
	Fri, 4 Oct 2024 21:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o1hG0uigKPKLd7MZiP0E36zG2soH19zWr9IJPPcvcOc=; b=YgYuA8qxMO5ztFAf
	Q/gp4rv3aIDuzMUBme0oLQTo/qgAbVY6Q4QXBrOqxH1sG5KV+7savlqIFPC+Jbmb
	3ikhBqi8vejapSD3zf0oISzL96CodbHaXZjNm7RUOiUsk6uLY7zZmzrQEYkiokcg
	ynjYjV6ZRX04WeWmTR4jkq52W55VIflZIVei0ApyjFyET1gsmxO443/9jYZ4sUPz
	0CeP0whTHISm8hKcRjGuqymC+3BK+z4/fEl4qmS002XjzwNb6V188yE54wmn2i5P
	N/t9rnKKy2trk7wcYdQ3CfzdUTQzPqjAkDfbiYgquhyR0feSiMn25mxvC4jYrya5
	cUabvA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205kk8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 21:04:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494L4TIe014511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 21:04:29 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 14:04:28 -0700
Message-ID: <2a4f79f6-fd67-48c4-a06f-b1c1c85363c4@quicinc.com>
Date: Fri, 4 Oct 2024 14:04:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: panel: jd9365da-h3: Remove unused num_init_cmds
 structure member
To: Hugo Villeneuve <hugo@hugovil.com>, Jagan Teki <jagan@edgeble.ai>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Zhaoxiong Lv
	<lvzhaoxiong@huaqin.corp-partner.google.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Hugo Villeneuve <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240930170503.1324560-1-hugo@hugovil.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240930170503.1324560-1-hugo@hugovil.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CEEzi8FV4nSMDuy67RWw_i0698R69Qv6
X-Proofpoint-GUID: CEEzi8FV4nSMDuy67RWw_i0698R69Qv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410040145



On 9/30/2024 10:05 AM, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Now that the driver has been converted to use wrapped MIPI DCS functions,
> the num_init_cmds structure member is no longer needed, so remove it.
> 
> Fixes: 35583e129995 ("drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hi Hugo,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 44897e5218a6..45d09e6fa667 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -26,7 +26,6 @@ struct jadard_panel_desc {
>   	unsigned int lanes;
>   	enum mipi_dsi_pixel_format format;
>   	int (*init)(struct jadard *jadard);
> -	u32 num_init_cmds;
>   	bool lp11_before_reset;
>   	bool reset_before_power_off_vcioo;
>   	unsigned int vcioo_to_lp11_delay_ms;
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> -- 
> 2.39.5
> 


