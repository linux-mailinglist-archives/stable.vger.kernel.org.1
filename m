Return-Path: <stable+bounces-179227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7CB525E9
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 03:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DAF3BE983
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 01:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8411D61B7;
	Thu, 11 Sep 2025 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DI0iCh/z"
X-Original-To: Stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A001A930
	for <Stable@vger.kernel.org>; Thu, 11 Sep 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555127; cv=none; b=Cz5AFIHXGpP5Cn9rQJkHAf4Vjrnd6Xx1zvVtSDFzSffK2nBBJ30lK1FGXxvNLXmYLA0P7P+Aodqwx9o4wvd9Kzy/XMQQGikUfD+CWcLrlAQBDlEq+IcKSsV8S5Kd36RI0FfbUoUhD8i3mhuBiHbnxCHW2mexyXSn4Ae4uayGtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555127; c=relaxed/simple;
	bh=/ybA8rV1EJNP2W7n4pc0WrgmP7vGzSXVOSvxu8gV984=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E9LCcAiUJYpoByJsQ3W+MIKp64a8zcMRLOqoVMMSu5aGslKqjXj0AOXwxxX31ChpHaQggGLC4DsxVsiq3fj+VOhI/FxbwjCnI6O3gd4bztlG2XRNNYMm+O2FVXJdswPA9HBY5YWIEQJ8gkhAdn0iBosc4r12Ao5XyKGI807cf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DI0iCh/z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dde353b47so823485e9.3
        for <Stable@vger.kernel.org>; Wed, 10 Sep 2025 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757555124; x=1758159924; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/d3COCVOI2+CAvfRN1DBcCvbUT4aDWnGnI7OhpJdo8=;
        b=DI0iCh/zjBsPg9Zf5gIIBs8oo0R6WNy4/3pXrWpcxhEJsimM02G8gjTWtIn7pQveJf
         K2qEiSQK97uXsGfpC0NhnL8TTQpjNI0mAN3Z+f6M70mh+7NiudxTzf3LLgui8YOTOyic
         AaoQFUfAN+wilkKF4cTO8FEf2gb8VDDlT8I/rU2a/0ewPZwh/zQvabCjHJrqoK60BD6j
         slmOgVy2Svk+5KIQ7ErOWegrGeO/GBrpLirMCzjooZ6GedZTPyOk12gGosvtTqV+bPWE
         Lwk7Yd5biCuhZOKqpvAhuqHPog7+jZebre5D8byehh3S6opiMHeTSs9GvVgJi3J4ryl0
         qpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555124; x=1758159924;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/d3COCVOI2+CAvfRN1DBcCvbUT4aDWnGnI7OhpJdo8=;
        b=cqjlkLXNTHAEmCRrCTSGAYHPY2v1Qb9nP2SrZ4nLjinMRsRK5KoeJnxaIZQWl71JQb
         n+VEQH8NnBixw64GfZaACR3DVqlp54Z8YrPgj+ikh8t9rfA12shnJixp8p0E+8wFbQEo
         sJKUUXyKFB9HndPBNB559uGQmsBlSYSB3NU4S9Jd0adkxfx7GnRPKpd2pcdJK0SlFzxl
         LGIAyDbei3Un0qbhsfdK9GGRzdvixcC91JWf8NEY4x9YOIyKt510egKgYDkPXf/Xosls
         bQWKWkwwYGFaBGqiZsa+ulYqhbcVp1dGlfkeaxxSZszSOic0OMeK05XVHoRj4LN48bpf
         Udcg==
X-Forwarded-Encrypted: i=1; AJvYcCUiHgpe2R58Rmt3J+Nb5s4BsZKwA9bJtR1PA5QXDhyqPu8GVQ+gn3uV/LqcXdQqbcDpBbH84r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4Crijolnc3h/Nwrg3y03tIfKdGZZdJF2Lr8BqT6cBntLq3On
	mPpLslTDzUHv4kh08Z6TeoFtRSlE9mfA0ffLxr1swL7GGTu6SWkxMYJ9+7yzQjjzFbE=
X-Gm-Gg: ASbGnctxcozA0OKxOOwyULY1nza4QMfX5LJwelb7U9qfIiYoq+NB5ws/AZNC3oDSSGj
	5QeEhODAaELXRuKlRxM2CjH8icFIISeyRRqFntQXJEiqKDUsBoVZtyZ2N3h0/e+1DCHi7A2v25t
	aLW1eli2VJo7R1gpAccWPHyWXzVuXEZj+7U07tPQmzRcT2b9XGt2edFl2ieWNr8cj4dmSEA7Ngm
	X2KQY1jBtjic5GGql8RQUV/uOV2g3UJGk2edAahEAd/K+Di06KYUxreSwDccF/OV0s0anHFr9up
	A3wwiuru6Sl3SdYxOLuOUywMVlPH5EfOqH5a7r8RpllbId3kVgbhWauXRpk0dgny3hU6/rG+YXu
	6sm26QyN6j87+aRgsAYDGx0yI4YyttAc2n8ZiSA==
X-Google-Smtp-Source: AGHT+IH4eMVXJCTPangdeJtchrAmKu6Lteh/vHgi48PICpOXu0flxxJARIoGuHWpxATLSXYCQLGOzA==
X-Received: by 2002:a05:600c:1c8b:b0:45d:f81e:6258 with SMTP id 5b1f17b1804b1-45df81e6532mr38124815e9.29.1757555124017;
        Wed, 10 Sep 2025 18:45:24 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:a727:6a46:52e3:cac2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870cfsm480074f8f.19.2025.09.10.18.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 18:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 02:45:21 +0100
Message-Id: <DCPLAK9BYI9D.256FT1VOPLSW3@linaro.org>
Cc: <lgirdwood@gmail.com>, <tiwai@suse.com>, <vkoul@kernel.org>,
 <srini@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <pierre-louis.bossart@linux.dev>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-sound@vger.kernel.org>, <Stable@vger.kernel.org>
Subject: Re: [PATCH v5 01/13] ASoC: codecs: wcd937x: set the comp soundwire
 port correctly
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250909121954.225833-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250909121954.225833-2-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250909121954.225833-2-srinivas.kandagatla@oss.qualcomm.com>

On Tue Sep 9, 2025 at 1:19 PM BST, Srinivas Kandagatla wrote:
> For some reason we endup with setting soundwire port for
> HPHL_COMP and HPHR_COMP as zero, this can potentially result
> in a memory corruption due to accessing and setting -1 th element of
> port_map array.
>
> Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>


> ---
>  sound/soc/codecs/wcd937x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
> index 3b0a8cc314e0..de2dff3c56d3 100644
> --- a/sound/soc/codecs/wcd937x.c
> +++ b/sound/soc/codecs/wcd937x.c
> @@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_co=
ntrols[] =3D {
>  	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
>  		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
> =20
> -	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
> +	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
> -	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
> +	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
> =20
>  	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),


