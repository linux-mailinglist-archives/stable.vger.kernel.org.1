Return-Path: <stable+bounces-147923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D187BAC64C0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF58189EA26
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC42741A6;
	Wed, 28 May 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hnau/7mq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21A200110
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422353; cv=none; b=PS3nICpGeSPSqwARX01h7dfFO/MheLLios07IyFwcbiNlUeFPktgylknE5r9nAzJyiZlSAQCmUpPhc4jasbcHJ1dxnC9VbI2OMG5WjKtD9aePnkw1brHkTEsB5KibjV94t71fLfvUJO/eu5Mm8/Kw+IB/ZcUAEyXjAFNTYk6uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422353; c=relaxed/simple;
	bh=VS1YaQxjzWGKR2linUA2fdWDK/V9RwaTCLlCddwHcGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4LvM8wDfPPfi3skIh5PimWVJUrVl4Is+TXvYKFqYb4vGtgaPu0uE522ygQK2kPhhhTSDsMXjs1BR3H4R/JNWjc6YbKpYZWVUoyzBC+n34YGtiv3z/SkYyoIT6ZYYLGgaUroCP1jzu8nYrXCSFLQD68MwXNFZs6y91cMoyyCpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hnau/7mq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S6YUuq003733
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zjY+tolbRpC1WCpfxzU4Em6y
	SlDLudFcmo1sJ1gl3Tk=; b=Hnau/7mqap/VbnG9tpq4s414rF8bv3QUyksN7dya
	pHZZrUkxSjQBMgYlYJfsvGF2dKL0o2kOMdsq0QzCB//dRHGtwGUgW2ZxXO7OzFqS
	jeysqUuayT3thtYuemt9C+R6NiiKFDAGlowTKU9zZo40DHJ2Z2W1wRs5zZSn9ORr
	Le7qlSI9N9gDtDo+GrfAT/ui62q9wY5o2jsOKWsjhFvzPmxKg7/gsx5MEQBZHgKP
	e7H+/hNJJLkB+O6fI4hJtwce1tNjvHjRGkvzn79UNwQW9VnRfvvLXe4ihbozm96o
	yJLF/exG5WnIrJGXvF9qH1LhL8LAjlbKltCZWM623KOa+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66whvtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:52:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7cabd21579eso680674985a.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748422350; x=1749027150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjY+tolbRpC1WCpfxzU4Em6ySlDLudFcmo1sJ1gl3Tk=;
        b=WWxMpEv0awgmusyXTTlLnMcgI+oBKlHhMpJwt4PLtxokXUMZ6yFsDUDwo0cnyo5GzO
         qrKGQV9prqT4kCB9Z7tdya+60XpZnRwAcLTk+ZRAsQyqN2sMEHVgRniR+Nml+Fbfv7U7
         S20LsEU8eVepYTtKXv7mRiI0amR9Bxfw+H8xjmADuJdOgZa8m40/Jji+TVUEjLxg5pBi
         Eek2nS6+Vk3YbpYbfl+sMU3KHa6lqhcVW2Pkt+HqelFQ30NXgyCv+9QHleBTGHIBwCkb
         JXfgbKM9bHIFpQwaCw3Qfh1mJiwQyPS3ong93/0w+UUi9xvKQ4/J4Gp8zb63FYtiu+p5
         7JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkKgKSRmPx2M6dZO/sSZKb6lkbr2aHEMLD4h8QofmWF8YDnuJaQEdJpy/hcsU2y15381bLOLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EATYVHjw87sPaQ8v+hPmlBud4+vKjG4tdLz4Hrc5VpYnzW0t
	DJVLAX2ZaHuigR29fZR2iwCDVETV3oYhc5HzjAk5s8pYe+9zPkoER+1sExFamfeN8DY8gGvUaY7
	73l+vhEjzH6lboLBt+ZsVPu40B2IwhctX0jEVGuYgPQLvYo3pHtvsSiGaqmc=
X-Gm-Gg: ASbGncthJ3yfMwlB76IoLXl6yL5HycQTYI1b++0ZPQJ6I6Yjcg6MtkV3F2cQDHjQtTV
	uyuBWjkymTaWCw809cQJEHD01idhclTQ7I60NRUDUTrhSwSmdQ91j97M3rnLJhW4Ci6tD3Hb/4g
	RWPOBbOV6iSaJ8dRhSvN6yBGkMveoDhnD5HTWi7G9vXBVVyzUhmYqUGhA6ih0YAvCUKDGOSVJq7
	v/Xerufr9jDwA1szqHry0XJqTMdszf54Mum+IX6D1aBustaEITvAJ6OHkn6rf7anPQt4W9mdtZm
	XsP75KWnYJ3a9VXOwA67PZAjDS8u3SvaMMywXVW6Wc2KEGFyOy/qDY1LUlr3aQFXuc1w1w0v9B4
	=
X-Received: by 2002:a05:620a:2987:b0:7ca:f65c:2032 with SMTP id af79cd13be357-7ceecb6fb2fmr2414459585a.5.1748422349592;
        Wed, 28 May 2025 01:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGocp7uTKkFG2D9UdXN34dHKFQ1I2EskkbQ4JFUqEXWZMh4qwL8V76qp3zCN3NhbzVXMQqHcw==
X-Received: by 2002:a05:620a:2987:b0:7ca:f65c:2032 with SMTP id af79cd13be357-7ceecb6fb2fmr2414457285a.5.1748422349110;
        Wed, 28 May 2025 01:52:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a79e9a5e2sm1557121fa.18.2025.05.28.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:52:27 -0700 (PDT)
Date: Wed, 28 May 2025 11:52:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
        linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
Message-ID: <ehriorde5zbfoo6b7rzemnzegnwqfdobzwyjra755ynk2me2g6@om6g57n26zbp>
References: <20250528003118.214093-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528003118.214093-1-alexey.klimov@linaro.org>
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=6836cece cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8fDSzOnEAZO3B2cnlLcA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zyQRoEDboipg9dCcjzvODmXb5ceAqLM4
X-Proofpoint-GUID: zyQRoEDboipg9dCcjzvODmXb5ceAqLM4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA3NiBTYWx0ZWRfXyEWtkDvOur4U
 F/tDUEkq8+3EYhyxFaC1zwGq0PFm+8NXv/+vgxq//PSv5oJ6xLdBbYGPILIPCQCayOAnCkFKpwM
 4m3d/vR5xVS/DlZjl6/gycXV7PcAC9YfE/k4mtr2vvDuhH0SHMkLlXBZje2LA+8wzgckfUGcXDG
 lIW23a57UoHv2c3B3m/UHfoHRg2PG278zVROvkk4rJXWe8hk4un7t4Q7VMBlv3liwq+ULk6uR9Y
 1tmm6Q7i/ROdDuxrkAzFdDVGz1tKOIoguPQ7aD5sr8UVoESUw3L+xygGvFWr82c7ZYA4Och2z6f
 ncuAi1xJrheXm8/qZys++RpVey/eNYsrAhXig7CCTjn48KFbTWr1kgvDqAYq2iThgpBrVVqMqtZ
 qORNcmjYCWkuZBD+V9ns1ikvRGcALGyThrDvcnoR9PSBpkqQnPavccXwLs/lS8uOF/UujeAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280076

On Wed, May 28, 2025 at 01:31:18AM +0100, Alexey Klimov wrote:
> Add the SM6115 MDSS compatible to clients compatible list, as it also
> needs that workaround.
> Without this workaround, for example, QRB4210 RB2 which is based on
> SM4250/SM6115 generates a lot of smmu unhandled context faults during
> boot:
> 
> arm_smmu_context_fault: 116854 callbacks suppressed
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0ec600, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> arm-smmu c600000.iommu: FSYNR0 = 00320021 [S1CBNDX=50 PNU PLVL=1]
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0d7800, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> 
> and also leads to failed initialisation of lontium lt9611uxc driver
> and gpu afterwards:

Nit: there is nothing failing the lt9611uxc on its own. binding all MDSS
components (triggered by lt9611uxc attaching to the DSI bus) produces
the failure.

> 
>  ------------[ cut here ]------------
>  !aspace
>  WARNING: CPU: 6 PID: 324 at drivers/gpu/drm/msm/msm_gem_vma.c:130 msm_gem_vma_init+0x150/0x18c [msm]
>  Modules linked in: ... (long list of modules)
>  CPU: 6 UID: 0 PID: 324 Comm: (udev-worker) Not tainted 6.15.0-03037-gaacc73ceeb8b #4 PREEMPT
>  Hardware name: Qualcomm Technologies, Inc. QRB4210 RB2 (DT)
>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : msm_gem_vma_init+0x150/0x18c [msm]
>  lr : msm_gem_vma_init+0x150/0x18c [msm]
>  sp : ffff80008144b280
>   		...
>  Call trace:
>   msm_gem_vma_init+0x150/0x18c [msm] (P)
>   get_vma_locked+0xc0/0x194 [msm]
>   msm_gem_get_and_pin_iova_range+0x4c/0xdc [msm]
>   msm_gem_kernel_new+0x48/0x160 [msm]
>   msm_gpu_init+0x34c/0x53c [msm]
>   adreno_gpu_init+0x1b0/0x2d8 [msm]
>   a6xx_gpu_init+0x1e8/0x9e0 [msm]
>   adreno_bind+0x2b8/0x348 [msm]
>   component_bind_all+0x100/0x230
>   msm_drm_bind+0x13c/0x3d0 [msm]
>   try_to_bring_up_aggregate_device+0x164/0x1d0
>   __component_add+0xa4/0x174
>   component_add+0x14/0x20
>   dsi_dev_attach+0x20/0x34 [msm]
>   dsi_host_attach+0x58/0x98 [msm]
>   devm_mipi_dsi_attach+0x34/0x90
>   lt9611uxc_attach_dsi.isra.0+0x94/0x124 [lontium_lt9611uxc]
>   lt9611uxc_probe+0x540/0x5fc [lontium_lt9611uxc]
>   i2c_device_probe+0x148/0x2a8
>   really_probe+0xbc/0x2c0
>   __driver_probe_device+0x78/0x120
>   driver_probe_device+0x3c/0x154
>   __driver_attach+0x90/0x1a0
>   bus_for_each_dev+0x68/0xb8
>   driver_attach+0x24/0x30
>   bus_add_driver+0xe4/0x208
>   driver_register+0x68/0x124
>   i2c_register_driver+0x48/0xcc
>   lt9611uxc_driver_init+0x20/0x1000 [lontium_lt9611uxc]
>   do_one_initcall+0x60/0x1d4
>   do_init_module+0x54/0x1fc
>   load_module+0x1748/0x1c8c
>   init_module_from_file+0x74/0xa0
>   __arm64_sys_finit_module+0x130/0x2f8
>   invoke_syscall+0x48/0x104
>   el0_svc_common.constprop.0+0xc0/0xe0
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x2c/0x80
>   el0t_64_sync_handler+0x10c/0x138
>   el0t_64_sync+0x198/0x19c
>  ---[ end trace 0000000000000000 ]---
>  msm_dpu 5e01000.display-controller: [drm:msm_gpu_init [msm]] *ERROR* could not allocate memptrs: -22
>  msm_dpu 5e01000.display-controller: failed to load adreno gpu
>  platform a400000.remoteproc:glink-edge:apr:service@7:dais: Adding to iommu group 19
>  msm_dpu 5e01000.display-controller: failed to bind 5900000.gpu (ops a3xx_ops [msm]): -22
>  msm_dpu 5e01000.display-controller: adev bind failed: -22
>  lt9611uxc 0-002b: failed to attach dsi to host
>  lt9611uxc 0-002b: probe with driver lt9611uxc failed with error -22
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I'd also propose:

Fixes: 3581b7062cec ("drm/msm/disp/dpu1: add support for display on SM6115")

This way this is going to be fixed for all platforms using display on
SM6115.

-- 
With best wishes
Dmitry

