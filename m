Return-Path: <stable+bounces-188036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92ABF0C65
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851AC4F2C9E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283342FBDF1;
	Mon, 20 Oct 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irS7Ub8I"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206002FB094
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958913; cv=none; b=mONryite0FMOaWowwwauKNOuE11KaYECe4Q92Z2UgRb0dqLoxewe6E1Ys3CEKETHU+aRU5xsggbTsc++O2iNSn+LrzULYYzvaioygPUGwCyFvXt/bZLFh0cnfvZidp8Sf1lgVeqBynMeGVk1MIigaGxuAo88swdC7nwbIPhffTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958913; c=relaxed/simple;
	bh=YWbj8iYas+DX9yMt0sNRdXjfDT0rRGWpMvpSDzRYiHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un3KSz2ZcsczWiByD+1uedrw/Pf38Zws2AuRxeD/RUlGkHej3zdy1E3CrkDEQZBbsjwP2xcn5T1g4NP+UIFx7lI5xvi1/WyMFvjc8yWr0LZLnoia3reX+OLaFRolT7oooyRdFOGsFBDa0p8S2GHXQbbHNYIjsCd9SA/8fUtQhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irS7Ub8I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K0QgBH028205
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ooqu6xaruD9rxcgEW9tOeww9
	DyNGCODFn0WfAlwBaMo=; b=irS7Ub8Iyapyq+02NJLQfMtrrK6cC98obv60e2gL
	yRomT9Dh78EvLqCKh8+/vApjY872VFG9718ZXVzYEJ7XsP3maagA0O8ri0pnAGzc
	GHjlu50E2EF6ZN/e+WYQRTIvyYFpcMx9PXeux1wwW3G8c54r+cnKhj+ETLHTqy5n
	tCgMLJSfmW2rJXeShlN61i/jx8oB51dO45qKjdhkGya63Ewty5OV0y+vTMl2pD23
	ELoVbBMYPz/Y3Q7qhBlXfyUj19zHrg6K7L4reEO5tnN0ryr65Ha5zWkk4KOO+sC1
	7vdP8vvSrYVhVhREeTi9wEOqvMvHiy55CjkZx4R6orYO7A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfch12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:15:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-818bf399f8aso217242686d6.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 04:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958910; x=1761563710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooqu6xaruD9rxcgEW9tOeww9DyNGCODFn0WfAlwBaMo=;
        b=Oj/ZR1fEkz66v3qIJC4Db9FGuCSr3PlqXj4hNBP6IeAJqaUBgKJHkB85LSSAKdjsfR
         QUYi0fUy3cB0UAOXSeJAst+7jxVE0oyWoejsyEo3Pm81cSrqleybjjiCzLqKsHYUs7mN
         Ess0irsAZEEFP4hkcV726hF3AnPE/dIWgK9zovzbfik12ut/o2cs9dNWubaP79a2wP28
         ZPwPN5sAdt+cSvGqvg3zjpd4NTzLiwOP91U7wSWSKhnlrCjABWZKhp0Yr9jgHU25I3rA
         zjvRGysLerb7NgKER4rW6nXZFP3h6rUEx1QvxJU5TgVzrxkmGvSfLA0LBJojUVhfFtUI
         52UA==
X-Forwarded-Encrypted: i=1; AJvYcCXG1a49dbsB1/t9V0ihD4mrgHz5IJiZ0fEXRqU93HeEjkzWOfgMLfT69cLxJa6kXamoeymfc48=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmms3qVdaPg1z+p66K3jBOIJE7he+hq91vupENHMxDhMeJYWl5
	+BrwCF4l6u0PvriZi77au9E+8RiXQ4b5J4IqGDt3e514IA3Eg5mbNyR6X4kITdphDv8xGIHhZIz
	flXdInU+G2cuMHfVtcCDHjpCfosoInY2/mkcLeO31/DQRc+OHzZuEsQf/8u4=
X-Gm-Gg: ASbGncvlZMmE/Y3uK+EPnqwyHypZ6mIuBYmvDUoF6IgZd+LTTdr9k3w8WrlWGTkSgMG
	bECTgkVV21RxMI5KElHJHfnR8LDj/jGJawWC2qRlT1UIHN+SsU8zkla1TIVdz5mTmhz4HsPUsjn
	zI/OxbXGqm4aDxJQDLeIi0y8MCylBvaAPMGIapyNAeN5mC6AvzRXsqWniarPuTBWc/pn2sQfiAO
	CsEJbul0yrYyBmMjt3Hf0a9z8ueVD/Ks/VKCrCMKe8Ypw4qEtgSVIBQesnuu0m11CeEUmROsBn8
	KrTCBsmIZV+GVS9EU+90MH+UX46hLwbs8hlrJexOk3NuOggtCeZFueJC//248Edhkmm3SYwF0AY
	rG/3J1BWf613bG5RU4Aib9LjmVBADka+4wBOc9VTDiCOb09wXuNadCcM55TA5EQvkkNPhOmoQz3
	pXRmzhhWKuTB0=
X-Received: by 2002:ac8:7d55:0:b0:4e8:bb50:a7ee with SMTP id d75a77b69052e-4e8bb50ac5dmr49358451cf.33.1760958909891;
        Mon, 20 Oct 2025 04:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4943Xl/nY4LqGLDWB9RS+BKQeWqjCvKpSQKEP6uZ3s7Yd5kMgKj44+WxkdFtuLOsGbUgDQ==
X-Received: by 2002:ac8:7d55:0:b0:4e8:bb50:a7ee with SMTP id d75a77b69052e-4e8bb50ac5dmr49358161cf.33.1760958909367;
        Mon, 20 Oct 2025 04:15:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def28beasm2429223e87.114.2025.10.20.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:15:08 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:15:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, srini@kernel.org,
        rafael@kernel.org, dakr@kernel.org, make24@iscas.ac.cn, steev@kali.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] regmap: slimbus: fix bus_context pointer in
 __devm_regmap_init_slimbus
Message-ID: <asrczgrmisaqzhin37jzgylm6ez2mlxtsbe6qp5mqgfecprup4@yb32qzna367s>
References: <20251020015557.1127542-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020015557.1127542-1-alexey.klimov@linaro.org>
X-Proofpoint-ORIG-GUID: JaNNES0EQUW1dnMTzxuFKG02sSolnhae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX/NpTV3HwAePG
 Zer6ZkGeowqTm+U/IxGN0RLYt4O1dksv+EnmMhaYqSfDRxp0vWyv9RikefNDYBMR88eL35dXdFo
 0IaG477wT6ej8Bh9dB8NlRjgBWxGyzs4T/GPcIjdj8BgIvz1ATokpEDU4zrbJSFF4torU/f1Vka
 NZPv2XLflDXABE7Uyac7amm3YZan2JifHq5YTvwdI2A3DTybCsctYO6/2xNhQ691G1uHq3JGuA7
 CIFy20s7cIk6KBg+8cXZZbEU7aPtqbCYCX+6gBMVtsBWDnsw9PClKJzgaYfzwUr+LbprtoYUtjg
 0U6woszbYUpi8zNwK0Qbgj0ZO1ZjAQOeVLOnxPojgc81irc82WAVp+bn0+AfRS8DU/hFoWhjCfM
 lzJ0x/IsTRFEDNtWhKWZcOhpg2prpQ==
X-Proofpoint-GUID: JaNNES0EQUW1dnMTzxuFKG02sSolnhae
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f619bf cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FQcGyLhEAAAA:8 a=KKAkSRfTAAAA:8 a=flUO-uPbEbLbV0svWUEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=09nrmc514_O-33C_6P4G:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Mon, Oct 20, 2025 at 02:55:57AM +0100, Alexey Klimov wrote:
> Commit 4e65bda8273c ("ASoC: wcd934x: fix error handling in
> wcd934x_codec_parse_data()") revealed the problem in slimbus regmap.
> That commit breaks audio playback, for instance, on sdm845 Thundercomm
> Dragonboard 845c board:
> 
> 
> The __devm_regmap_init_slimbus() started to be used instead of
> __regmap_init_slimbus() after the commit mentioned above and turns out
> the incorrect bus_context pointer (3rd argument) was used in
> __devm_regmap_init_slimbus(). It should be &slimbus->dev. Correct it.
> The wcd934x codec seems to be the only (or the first) user of
> devm_regmap_init_slimbus() but we should fix till the point where
> __devm_regmap_init_slimbus() was introduced therefore two "Fixes" tags.
> 
> Fixes: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
> Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Ma Ke <make24@iscas.ac.cn>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
> 
> The patch/fix is for the current 6.18 development cycle
> since it is fixes the regression introduced in 6.18.0-rc1.
> 
>  drivers/base/regmap/regmap-slimbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
> index 54eb7d227cf4..edfee18fbea1 100644
> --- a/drivers/base/regmap/regmap-slimbus.c
> +++ b/drivers/base/regmap/regmap-slimbus.c
> @@ -63,7 +63,7 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
>  	if (IS_ERR(bus))
>  		return ERR_CAST(bus);
>  
> -	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
> +	return __devm_regmap_init(&slimbus->dev, bus, &slimbus->dev, config,

Looking at regmap_slimbus_write(), the correct bus context should be
just 'slimbus' (which is equal to '&slimbus->dev', because dev is the
first field in struct slimbus_device. So, while the patch is correct,
I'd suggest just passing slimbus (and fixing __regmap_init_slimbus()
too).

>  				  lock_key, lock_name);
>  }
>  EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

