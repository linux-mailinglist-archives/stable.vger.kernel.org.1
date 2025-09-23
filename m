Return-Path: <stable+bounces-181430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F31B941AB
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3418A77C6
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A325EFBC;
	Tue, 23 Sep 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VlR3cQxd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D41ACECE
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597985; cv=none; b=T7aaqdFU3MQggq6qrzakm7I9HHGN+slcDlfMGgjstC4p1pmZGmfGsiKOXUj3/gDCfG8OJX8j9aA3pv3WgyJKayjjbnyhIRflc5Xz0vnPhO1zOy6VQDUSswmENVbS1205aM3kCktkPr0wy6Fwms7c8ziFIuekhghpNeuXcZ/oq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597985; c=relaxed/simple;
	bh=/9okwRIp4AGyHNqa6uQ0KAc8kzAsFvI6jPY28fzJH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frZakpHLPGrPnk1AEUKIfEwC+SXHmintcukx6GtbBPEn7YMb/DIRO6wNTH1sevHtD9d8WDsGS5bHqYb6k8/7F3ejPtVn9/Ju9OSDb130Q7yEJalxkGdF3zzv/h6yePU5tDUhkz6muGdIgKe+gUFy9OOZj+g0LUzfMsIbDfEUBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VlR3cQxd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH66l2027910
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F3GWnZoDTq3sp/K2/e/shKmR
	rtysWnVz2jKe17D2uyM=; b=VlR3cQxdPlnuEF5mkZX+P72kr4YNH4WDaB9XC1Qo
	bAN8xNhhz5t+aHGfs4Mk2mMkHLuPmaUxu1R0HMdWoemoXDTP/nnPiFSh3NdzGQp8
	H+EO7hSdqiGKKaawM+jd9Bx0AOETSHA09WawaBmm0inDYLh9wIn2QnuwSGmx3xpt
	3BTQThiRcXApKYW/dmw/YlsRRvF6xJ/pF2HP0Q7tAVANM6SN7eu1u919ehGrjsUI
	IeHCdu8Po3+yUQJrU4OsG77Lp4I3NnlfXH6TN9QwhlOPBqIZEb/+ogkuqiJHwnFv
	1NmhK8j86qCE0iNNgdzT0X2/NZy/HUDd+Q6Vgo+mU/kDHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajese70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:26:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718cb6230afso96475126d6.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 20:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758597978; x=1759202778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3GWnZoDTq3sp/K2/e/shKmRrtysWnVz2jKe17D2uyM=;
        b=rxuWsdnsSLvd21+zpMpYyPv/Ki/GjIwc1JxMyVMTlVpmKq1+5akNbD4XdKowJhkf30
         PS7947H5LkDG82mcSn1aCgE8X6WIdQ1R2Vfhc6mEOqtt1iunYI1BlpGmei44rR1gNH8h
         DiW0EfWTuD6XIMfnoeegj2WmOXlWVOhKWE8cQYp3JOreT27/kJED2OaWXBR0WTsQPQ6Q
         8M1dC8wdYINXB16uYxN6vBB5Oxs6IzA+gl9QJEdTdSuSO27/c/VQBy0DFmzauy0K+ELQ
         AeabNKLjQr3knFpqGPF7QDk7mN9zFdw2PkSxG9VuPHfdxRT4Z3QuaubGhV1rDMt1cngr
         GtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7oZDkXi9DO628nPStksxyBUc3mCK/a+Mhvtc4eeZ+pIH/hXCKXto3JC8UjFoeZw9qyZDFDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2sNkbTM3+jNck9D/kUHZ5maL7hHuJHyC4wulGvu0+ins4pfkP
	eT9m9poSz7FF2aHv6bia7U8kuLcY1NQnPL5MZVlo2o7h90xVdFc1pgYC7e56uE4bbdD1D9JM3cj
	RK4uRfht1BRmeCmjigPJSJ2KuGbE9m0Y9GJ6cDxOWU3HavtJaXYV/0AoHwVw=
X-Gm-Gg: ASbGncuUNej5R1uBDFFvI5EUty2yj6bQD0xU+2saPV/Ue63DwoVo0YymrjnkKbMevDr
	ODM4/FtVCKrloleZ/XFKNPYmdyeM/hieAHjrxzn5dIu+IblL80qtuff9mksovKAmo3qJYSW0rY8
	stNRfCZqMst+Na5ShnBECwrrAmqE8C55+MFcNd+cRaPnpuyr8C4FzV71MuBMfJUkHakkR9UCa+v
	OFrnM3vA16T8xj00seEz40pYd3CEt9+QrKDMNLFE7Q4d6UrNJqm+MDvse3ZECvDHlD9sP+xf8IA
	y59uN258LVmU3fnAhKsiQrbGuwQzF1obqgUq9nIxGc/VcNWPEhcoVdQaR/9EMGrRLhQRRaa5ImE
	DPHvDpypMtjWTRFoIR7bhUImg/ukK9fKi2PgU05NQ51huUzu7H49v
X-Received: by 2002:a05:6214:5184:b0:7a2:7dd5:a529 with SMTP id 6a1803df08f44-7e715457b81mr13988566d6.32.1758597978263;
        Mon, 22 Sep 2025 20:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCyCVOG3I8IOeAlxq627lGyS4LI/Q55RrD7NxcdRqumGitid3wdqGpVNnvz0boAGvkOcRioQ==
X-Received: by 2002:a05:6214:5184:b0:7a2:7dd5:a529 with SMTP id 6a1803df08f44-7e715457b81mr13988316d6.32.1758597977705;
        Mon, 22 Sep 2025 20:26:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a9a81f52asm2683912e87.124.2025.09.22.20.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:26:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:26:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <unqzejlsp6emzja5ry32smzlinntodgbioyojr5osiqddh2ppi@mtf4e7y4cids>
References: <20250923023828.36647-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923023828.36647-1-make24@iscas.ac.cn>
X-Proofpoint-GUID: gUQyuSgKIBpnlsJ33U6ZFaRQm9wu32di
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d2135b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=dSz2rv1DY3fttFFokb4A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX3nvAkhrjG3Wk
 JGeHacxAZVlmiRloOSV/MHvHHeSHEAMUDMtm6YUgKhtomWajXxA4+xoGC4JQ4RVGEbGFg9iJZhw
 jXPMI+Lfga3poueT9WdGtLPLB8jPSPxuapYZAOJwH8XKyeyOOoL4ujrUsz1GV8IcwL0CAViT95C
 IVrieFq94hlhA8XtU8P4548UiLOPVucx2JSADQ+EbgOImfa5OnLJ1L0IscwKD/1PijJWzpD0xIU
 Ij3D5FvTEMSnpH/p59+ui6LVcepBzp41UBRpu+T8aZolrnMxqmhtrxeSoL+aAumCw2s/G6EzEpM
 ZIbRLUJ4+FfhWyET2SYM1Wem6mmB22WMePB1cHsKCtcGi3y5R5h2uJ3HHrqAPk98MyCPuAR1pp4
 s0Lv2709
X-Proofpoint-ORIG-GUID: gUQyuSgKIBpnlsJ33U6ZFaRQm9wu32di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Tue, Sep 23, 2025 at 10:38:28AM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data() and
> add devm_add_action_or_reset() in the probe function, which ensures
> that the reference count of the device is correctly managed.
> 
> Memory leak in regmap_init_slimbus() as the allocated regmap is not
> released when the device is removed. Using devm_regmap_init_slimbus()
> instead of regmap_init_slimbus() to ensure automatic regmap cleanup on
> device removal.
> 
> Calling path: of_slim_get_device() -> of_find_slim_device() ->
> device_find_child(). As comment of device_find_child() says, 'NOTE:
> you will need to drop the reference with put_device() after use.'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - added a wrapper function due to the warning report from kernel test robot;
> Changes in v2:
> - modified the handling in the success path and fixed the memory leak for regmap as suggestions.
> ---
>  sound/soc/codecs/wcd934x.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1bb7e1dc7e6b..d9d8cf64977a 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5831,6 +5831,15 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
>  	.endianness = 1,
>  };
>  
> +static void wcd934x_put_device_action(void *data)
> +{
> +	struct device *dev = data;
> +
> +	if (dev) {

Can it be NULL here? Can put_device() cope with NULL being passed to it?

> +		put_device(dev);
> +	}
> +}
> +
>  static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  {
>  	struct device *dev = &wcd->sdev->dev;
> @@ -5847,11 +5856,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  		return dev_err_probe(dev, -EINVAL, "Unable to get SLIM Interface device\n");
>  
>  	slim_get_logical_addr(wcd->sidev);
> -	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
> +	wcd->if_regmap = devm_regmap_init_slimbus(wcd->sidev,
>  				  &wcd934x_ifc_regmap_config);
> -	if (IS_ERR(wcd->if_regmap))
> +	if (IS_ERR(wcd->if_regmap)) {
> +		put_device(&wcd->sidev->dev);
>  		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>  				     "Failed to allocate ifc register map\n");
> +	}
>  
>  	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
>  			     &wcd->dmic_sample_rate);
> @@ -5893,6 +5904,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
> +	if (ret)
> +		return ret;
> +
>  	/* set default rate 9P6MHz */
>  	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
>  			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

