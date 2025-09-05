Return-Path: <stable+bounces-177845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C2B45DB4
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F17C169816
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1E30215B;
	Fri,  5 Sep 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaZMVkxR"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CA302142
	for <Stable@vger.kernel.org>; Fri,  5 Sep 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088881; cv=none; b=PAFQPWzSRpf7VhqCXh5XQpYI5eNJJH5ggbvdfpSwubTE/6jpJr2c8a8KFqZ6r/1v3ld/punrxu2Z9JcyYBiBBaeYNRA5u+vtBO/N6MAhBy36ZH7gk7M2rtbaht1Ie7cOax44C959fij9lT6BQMn+Dxg131F77fnGqAfEkglEad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088881; c=relaxed/simple;
	bh=QzQU6X3d7uC2WCQBqpeq3Z9QU13w7Y+ipPzD8W6kKso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0TWO9d68vKzYVb5To9oBDih6a9RSGJt3+9pIDBqDx2NiMzMesBAMdtooeURYzbt+yeBMbFEoJEACV3QVazrk1NgVn2MNv++AJEp91z4o/lXPfSBxuV72CzM5z2KYwibaTOvsejLNPqTJ8MI/rOZMH3h5Di5e0BROWqyfiBg8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaZMVkxR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585936II014923
	for <Stable@vger.kernel.org>; Fri, 5 Sep 2025 16:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4uwzJLV0wZH0OwJa1YLvQG99
	I8WF7++RUAwFDj4AzKo=; b=BaZMVkxR8r1DNF/+8QLZHIMpFQhxY8xYFoKWrYHV
	NgHslzkeqfqTzesQZjsFxoMm6i2vT2ZdO2ArCiXlF3Qpz+gYsO3ZljAd4efBEYFj
	xwiTwSDFdL7ftH9yjOhDYgsB7T6CfAAJVIBznI8H8Ao1su8A3+ZTd5tYeNv1kyEN
	1ouYZhAPFJ9Cf5JGpZVPtwetmQzbl3VWVOJe7mZ1wVPCN33J9zaZwwJKmoYQlPO5
	L6c9APEnr8YNTCIqg5cKqo7tuzAwtC/DyaMWATDasOBQRYSpf5LE3o2UDk7wfLvD
	HT8NXpmF/4o39ySa68++vhUvIgC79s5KJ/I8jO54pkSqHg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3bm6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 16:14:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b30d6ed3a4so51190361cf.3
        for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 09:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088877; x=1757693677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uwzJLV0wZH0OwJa1YLvQG99I8WF7++RUAwFDj4AzKo=;
        b=Ur03FH3pVyTy8wdOPXUM+s97BOUZXOCpAZvvrJN8Oa+r1dcFrd0wHe/ZFWn9XiBNeb
         qLu7zN8nUtD0nspv2Iih1lMpSA/l8XESHQtYddysNb0+BiWamV+XzdxTyQrzQl0gdtx1
         HScZm0XPGQGsnCWBqoOR+7Kf9eVfHW/viHz8UHXRsR2zIZ+KzrwL0+5jXpTYTpzkLj6E
         zqm0YH3Fgk6kkzQ3wRNzuBC4ZfCq4v0tEP7EoX6ffBj9u+HFjpE/J1zeuKc13lWzPhG0
         gF6HvvEuUHYKUKjnK3ZJuSs2b31bkLvBEy5ByjhXN/7LXjXkLjhf55m2yrCVb2fAqmAy
         6uUg==
X-Forwarded-Encrypted: i=1; AJvYcCXCb12guIhtBRTzOCSyjB6CcV5LDfjtHgzaLVtWcw9JqKXih5weeqvvLLDQr+wziulIKJJTENY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHQXhXLMThN2V0gl//UeUD7ctc4vqAGoST3AwvVbzv0j7i86q
	cWIr1zfuGy/nstfWPO8ozjdzQ1mb7EIa5i87Pm3GcFsTk+5dSVWZa1mga10pTeokJ5TfhvEG25E
	oxtRkZ100KsM5SZWa93Ej/8dKCq80eQqlaEypanF+g+6LStPF3zM47IpUMJM=
X-Gm-Gg: ASbGncu64favHeMisNKYSGcDuTSAmQDMxTTb+At0ABYpesc0QN3bLarVPowOwdmqCiR
	FMurby0xA8zz3Gyu1US19KY+zBstJWVNpvVXwXn2NSAmh9W/RLaMXRZmHd8SSUV4s6Z3tR1saqf
	o4PlDVDdwwnJPG8JC0w9jYhP4xWDoJD/zmsJcwJ12TftVy4ba5GuGSbVhIqjD9cBRH4crMx+D4R
	IyUw4mwBxURD+xf2TQ81hoRd+03GkjVYfNILFqb7ZH4lG30npW4ztDhZsWgWE7epF1T+EldNb+8
	NIp5i+rH5pTtcNlemxpQKX9YmsVbhtUm8If96QNoyW0qENbWjPgJ6lnw8zRb44nre7YMwschXa2
	7ygAxGIdzczZH5SpR6Arp/etB82qtJWGVQvN2yKFuo9KVo6rCEFJf
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr73086401cf.78.1757088876921;
        Fri, 05 Sep 2025 09:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKI6ICcB8YsU1+RJItro0ZVf3DZvV4LKkRV/LL6vupHTnzLn+/DenDDljZTOEtKsyf4ex7gw==
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr73086051cf.78.1757088876476;
        Fri, 05 Sep 2025 09:14:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad523b3sm1816008e87.151.2025.09.05.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:14:34 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:14:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire
 port correctly
Message-ID: <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0X7TdtyuZxA9
 xHQGSzBNKqWT2NfB5ZrlTg/EQbSXFNXPBrpHqKB0bM3INsSSpGKrwgmwNHkoaoH8dwXpqKVBQ0o
 peEIaijaGDSRGcNSitaL8+7AMgoruEAlDMkCHFckCAp8hWeeBpmZmyMgjgHjOgVPqyemKiBNmxH
 fy8gDuXG4wjJGfmBujCXI2BWbRWisaeHGR8UEgwuQasIh+UhsP83W6VV8ooSkREREMCvjAV+QBZ
 eULUrHQmNwoCFxTbn4ov8Xfzdg4u8H5TVfPAxpVWcQgxqloFdumKzrpbX7R/Z5be0ldUpkoTvkU
 WxinkA+4cuBCwgyFh6ciuh4Jpx6WCeGSJV4suRriopuPGg0W24yI26pqQlZuGxHaj9fTXqJblpR
 uIgNa1rD
X-Proofpoint-ORIG-GUID: GuSc63WINJksX4xJszyiNYcbfzfyNXiM
X-Proofpoint-GUID: GuSc63WINJksX4xJszyiNYcbfzfyNXiM
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68bb0c6e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i95AebK-tMX4XhNiilcA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Fri, Sep 05, 2025 at 04:44:19PM +0100, Srinivas Kandagatla wrote:
> For some reason we endup with setting soundwire port for
> HPHL_COMP and HPHR_COMP as zero, this can potentially result
> in a memory corruption due to accessing and setting -1 th element of
> port_map array.

Nit: if passing 0 here might result in a memory corrution, then
corresponding code should be fixed to warn loudly and ignore that 0.

> 
> Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd937x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
> index 3b0a8cc314e0..de2dff3c56d3 100644
> --- a/sound/soc/codecs/wcd937x.c
> +++ b/sound/soc/codecs/wcd937x.c
> @@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
>  	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
>  		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
>  
> -	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
> +	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
> -	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
> +	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
>  
>  	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
> -- 
> 2.50.0
> 

-- 
With best wishes
Dmitry

