Return-Path: <stable+bounces-180747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B899CB8DA67
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A8594E160A
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378A2C236F;
	Sun, 21 Sep 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nimsq3Nc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E02C0F60
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758455034; cv=none; b=Tt3+OpZ/o4Pv0KbRpvEbmalHFAdT/srHiWNMQRkuHlzzPGlVuwxHLZ4GgLmDbYmmb1lyTFEx9DRtM4CrwvG9lwvA5YhCEpN0YGElUh1GO/tnv7xuD2bqyytkPMoV3MX1K61PPAqPmDFWuG4MROs34nClrp1sjt71lk8hdnlZXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758455034; c=relaxed/simple;
	bh=+Pn/OVfTwdSSSOXNeOm06iGQ/roCwDtZwhhSb17LvI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFlaIDXsT4u0KMefqzfYudbrRzZrrOw0uuKWPpuddNh4N7S7HSDTh2ppWzoYjTBsDMeuUgngELibDzd9nl/6ytVNT602E68jZOmONq6u1FRclHW9R8TPBcI2kDaU0gv6kzkVDC85FuRFGflR9mSg/awfzI3MAqj8P8qodoLU9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nimsq3Nc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L7hxcl008421
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 11:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2tz38OrlUOeLMiW/V6pVbFqi
	MiAYEhH1+bQDPLCltYU=; b=Nimsq3NcjCR1Np9YlKps0K9TPHI6pZtKpJKVIutE
	AfHwOLN0/u/XjtyWYsHtAFIf+lEBdJnDX4pjqBrjW1cch+9U+ldIxOkJTLFLuOzT
	KO9B4GljHXJnEbhyJnc+fImVzdzktygSlkTfGyqBqRQA3jQ+tkfi4NSL8TXiBYeh
	KNayi9ZX3m53EEqwfUVLebk/3o8jFkcYvnSR7Dk/hObwqZtsbLASek3AvVlnC13d
	z4zpcb3Ks8ZwRgBYpn/UR6pEaD3gJixdL60gQunqKbpR1X/yDh9jeTr5roCFhzg0
	3LMe//iuWciUS+hDqeuVah4M3L+R+3xoPrYiBeBldpXIrg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv23nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 11:43:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5fbf0388eso46244471cf.3
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 04:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758455023; x=1759059823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tz38OrlUOeLMiW/V6pVbFqiMiAYEhH1+bQDPLCltYU=;
        b=v/UyL2p2eVfhwJu/GjZXsyrkhpjDcW0CQudaVetD0WZCqanjQcigkweRdhiHQkTMGQ
         OAdGmNrq2GyrtM/6tT5xlP3FQtWPbE9zdGwXWrREIPju0x9NCZO3u84IbVHJnkVaTcJf
         SN5rwNaC7py1/gqENgwO88yse3Azh8tt1WkNo0Ho8SbOj3MAxZ1+hL9lLJELBLR1U1bn
         OLGyL64OMMqAQ562AWeKt69hAtPGb2S5XDOc3318BHow9TpYt8VjBq//I7KnRKZ0FpXn
         0l4jesXCBh/pTE1r0ScyUcvXIvn3/7T3gtj93W0wNfMHkrM7yiFHCjLo4xnZkelygdNy
         bt0A==
X-Forwarded-Encrypted: i=1; AJvYcCU0M2wEEiepJI1rDKAu0LZ5d6xEyRVExu5M9dM9bMBrMlQGg/TAGvRV6H02J3cwNykrOefIOiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oEkKMz2NYw/Jm0tA+cV7UZR4ZxrqfA5JuGscCTs1ZZaFCCA6
	e0N5ANt/XjVjy/U0Xu6+CRPtm9YNb6WsDAKjIHM20ire8e0+xBgLbgRKSfW+z43Oaxz5PguUyC7
	Zt5RVt9Nbu6YIJHxF+77UnYd2h67AlrO2M+BDuP3RYqASY+oo5Kj6JAK8dmY=
X-Gm-Gg: ASbGncs9EcmVlqfFfqntr0OwJbitRfgFYRddUJ7OvGzIcSYzj38ih1u2dwZG0XEN9AM
	LCI5qUPUGCh2aa2/WHRmpx/ZWkpKkWeP3f+n2b8F4XeKIBwfNBzvETeVrO6SCSKiSSMAfHBDL34
	auyOQIXvNTZ40PTFCr77ii2trvmdTueR8RmMP6ic8FcUj2B8KG5SxeUBFVd/koqr2vqJ3WeEIiG
	lXXJpFFpnkJc4maw6z0zao0rILwQVYp7q0RE3a7OoS6tKQu7xZvJSphxiyerH/r+nFdz/sXRjiL
	bFsuI4YL6tpXQBhfQVnisStBC6mF9VVXSGaf2fw7FEZPQsfPpjryXXgUMOa0AhjjJoi77YWSbj3
	eGV46sEx5GqXzqBYKU2JhaFib+3WCK1LfXyurHWOOhJbkvBZSWZQa
X-Received: by 2002:a05:622a:289:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4c06f84409bmr97544691cf.24.1758455023259;
        Sun, 21 Sep 2025 04:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgRW/31bOxLKwY8qsOfsclAMytFaKWAzuOnLefGy2cQabOY5f9ALQUf9IAhjpMBxBBPDADQ==
X-Received: by 2002:a05:622a:289:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4c06f84409bmr97544541cf.24.1758455022788;
        Sun, 21 Sep 2025 04:43:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57c56d47591sm659763e87.50.2025.09.21.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 04:43:42 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:43:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <lqgi66r4voh5z4p7mrjiulxvy6gky6mzn6rq2yresuhqfzsnt3@xcgvnxxd7qnq>
References: <20250921095927.28065-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921095927.28065-1-make24@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68cfe4f0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=YRiNdvbt-P8spsNBmjsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: YeSb96v0AcSBU4a5If6CYzN1dTK-O4J0
X-Proofpoint-GUID: YeSb96v0AcSBU4a5If6CYzN1dTK-O4J0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfX/bXJT2fkXa5+
 6wXlPguyHJxSp0V3QtZZSCatRSPBYcdVVgvG2s3SdBAByOlNLO5/CjW6OVTzelyu+SFToIHHf9J
 B4KXDAJNeLMjtzIxx3tvEWioYve6hkWDc9OeCC67/AfC20SSttL4eP6zNObVMXfnNocUSr6YD3c
 4/jjwm7OtNU6ONC7YVtuU+HsmX6sHXvnyLNuxhROQGWxKYCNehbJIqPlNdZeCNZJ4cHDoOyiusG
 ZJxcD7/91XAWJSxyC+ERkX36PXrQUc98EsbPM95EQLlCx8Mxuq6VHCibuNw2eHwVxzA8QG0d+dE
 PpARyu8pYqrNfhO7KYgvPDy0fEQCjJO1vt0Qc5JbvHdh4WIETDtPUXbFunKsh32fOZsdJflkfwi
 mMjJ6Hm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

On Sun, Sep 21, 2025 at 05:59:27PM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data(),
> which ensures that the reference count of the device is correctly
> managed.
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
>  sound/soc/codecs/wcd934x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1bb7e1dc7e6b..9ffa65329934 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5849,10 +5849,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  	slim_get_logical_addr(wcd->sidev);
>  	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
>  				  &wcd934x_ifc_regmap_config);

regmap code doesn't increase refcount of the device, so we need to keep
the reference till the remove time. The code also leaks the memory for
regmap, so this code needs additional fixes anyway.

> -	if (IS_ERR(wcd->if_regmap))
> +	if (IS_ERR(wcd->if_regmap)) {
> +		put_device(&wcd->sidev->dev);

This call is correct

>  		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>  				     "Failed to allocate ifc register map\n");
> +	}
>  
> +	put_device(&wcd->sidev->dev);

But this one needs to be deferred until remove time (e.g. by using
devres)

>  	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
>  			     &wcd->dmic_sample_rate);
>  
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

