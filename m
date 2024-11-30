Return-Path: <stable+bounces-95860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7D9DEFB6
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 10:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363CF1626A3
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461D14D28C;
	Sat, 30 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbDEEXs2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE13126C05
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960458; cv=none; b=KM42NjdQN42oWNm7wQnFtV0At8DjdtNuCRup2SNOZW2OZikSsP4ElCzfCEXdyLt75HL4/L/kwiCRDB4KCNDcGAmfJh0kpEHXywsagNS8maVY1jA7k9cEt7F89nJlxhIh2XJ3LV8HkWcv39qatkyobUEAMIzhI90Ei3/i9Lxg2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960458; c=relaxed/simple;
	bh=HDqXuqlxiaDPte0W46BTkT66Qu1FiJgD8ZkENUx5qKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsDA7GDATH8zKZ9XzTb5MqwAno99/fKjrPvPfNrKARk7mMXMgGtYJpJMHwEBI4mrfrMnCmLmhD/EOMbVtMnpbtUuOMQ1WxLAazWow1fBAz6HwPeDeHAKKCb7211GIMaUsGmoqPH4ofbK4ZGWMstc4DdtIFYj0mlGC/0EzHVRHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbDEEXs2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso20641921fa.1
        for <stable@vger.kernel.org>; Sat, 30 Nov 2024 01:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960455; x=1733565255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lc9DfCXaFvHVBMdEeSwVvJlevNEtc41NoCu48KM7Oc=;
        b=XbDEEXs2iMEiWiYU3Jbjb29viXcNK3i/s4a1DYZ+quROx9aqLMC88IeDXJE56O7pK5
         P2kvyiBzZgxkbflezUmnoch9EuoDi4LhQEkYNhOR65xe19MCRS73QK8Il5hdglu0M79C
         3KP5OHeba+tZY8KE/jqwqw/kfvn8s3irn7Xx72x/9UhGx56PIfLif0xiXH8p2g33brjO
         pdNpGC9EhoSe0CI7e7zgVa/j91r0o69RVFp84Ysi/6VlmWT/K4Fvi+15QvimaMg2SiwY
         vqdeyuHTyrhRU0ezzXUefZWcL7YcJE+N4saY5i5apNeO0To+rCkTZYRGyCdUU9tglrZA
         Lo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960455; x=1733565255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lc9DfCXaFvHVBMdEeSwVvJlevNEtc41NoCu48KM7Oc=;
        b=uNIM+wkqvYpm7ZybS4Jv9wUO36b+xUTvBh5M5tXuQJ9GJzmIQxrbKyyfDcIo5huA7u
         C3H5avQF+FRJ7QBuCVokOa+R3LlN1OCKV5QPwS0vXX2Wt0HZxB5nPnV2q/EFHZxXk4Ym
         M1aMk3Y/wJPFY+lOd4ro/fj1yztx0872rsAz7vFh8qXj3cPB8YoTeUg7rp3SYAGi6pEv
         uO7U1T1uCdw1UcUV4I7gNiHrmWMVf9dXvYZUuJGsv7KbSMGbBsLNjr6wBrYhou4DJf/9
         Hj/q5mgO9uyoyHTsFnQ+xZGWoJsd8AHhIpmgS7b79BsE8qGKxG/bnA2yfLkX5tJz6dSS
         gY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWSjdZ/fE3hAd7kBIwN7kpbf0/5/tsNlraa4UwwLSm4riufnszrp/RPfLuTMyuqqEU2KeNpFaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvYfpSTjCCmi17gNjg8y1ngoNMChzM8RIIO6P5Q3dX/A6jC4W
	uz1uuag8IWPtoPh+TjcC3P82n9kAnimrM8zOFZVQV2FT9ux2DRCaIhwSepmmSYY=
X-Gm-Gg: ASbGnct09WtVkJEksdfqNosRu72KWVdP1AsGyCag1QCThNWolj41k24F0f/s+gYetyq
	3Jctf02VSuBRdBygv5el5RvpY2oeiL30UGPdgsvevt06G1spQHrCXID33Xd2VP618iaUfnImvna
	Q3KR+1nsZVLIPYyXBcL8xLbGYehmaEf3PbJLnQLQm7NIWedFrjnOzIxq9Hdj7xYrO1XQTrEGctG
	/wy4/HVOxiDM7szbyoj79OxGQVDxwO44o1ANLuuzbqWDVl40yO5fG/djXiBTuJGnUtFM2mcrX0I
	Mx3wN03I7y14xMKjZ6MTmHl17zryXw==
X-Google-Smtp-Source: AGHT+IFkfMrwigSf+zgzstB/hgJoOKRZVbjeqFCsdGsPsNseLBJrUIenMSlGkjvt/K+9OUdn2YEiGQ==
X-Received: by 2002:a05:651c:2220:b0:2ff:d728:bbc1 with SMTP id 38308e7fff4ca-2ffde1f3281mr37422461fa.5.1732960455087;
        Sat, 30 Nov 2024 01:54:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f59sm6538471fa.17.2024.11.30.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:54:13 -0800 (PST)
Date: Sat, 30 Nov 2024 11:54:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Bauer, Markus" <Markus.Bauer2@avnet.eu>
Cc: "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] sn65dsi83.c: fix dual-channel LVDS output also divide
 porches
Message-ID: <4iow25webuwskjbx6gfft45x3jhxvg3diulfpjzonesgjmszhz@dk54ylmq7tnd>
References: <BE0P281MB0211EB59ADE02F4DB8F9D0CDC22F2@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE0P281MB0211EB59ADE02F4DB8F9D0CDC22F2@BE0P281MB0211.DEUP281.PROD.OUTLOOK.COM>

On Tue, Nov 26, 2024 at 09:42:45AM +0000, Bauer, Markus wrote:
> sn65dsi83.c: fix dual-channel LVDS output also divide porches

Please use drm/bridge: ti-sn65dsi83: as subject prefix. Drop the first
line of the commit message.

> 
> When generating dual-channel LVDS to a single display, the
> horizontal part has to be divided in halves for each channel.
> This was done correctly for hactive, but not for the porches.

I don't see this being handled for hactive. Could you please point out
the code?

> 
> Of course this does only apply to sn65dsi84, which is also covered
> by this driver.
> 
> Cc: stable@vger.kernel.org

Also:

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")

> Signed-off-by: Markus Bauer <markus.bauer2@avnet.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index ad73f69d768d..d71f752e79ec 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -399,7 +399,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	unsigned int pval;
>  	__le16 le16val;
>  	u16 val;
> -	int ret;
> +	int ret, hfront, hback;
>  
>  	ret = regulator_enable(ctx->vcc);
>  	if (ret) {
> @@ -521,12 +521,22 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>  	le16val = cpu_to_le16(mode->vsync_end - mode->vsync_start);
>  	regmap_bulk_write(ctx->regmap, REG_VID_CHA_VSYNC_PULSE_WIDTH_LOW,
>  			  &le16val, 2);
> +
> +	hback = mode->htotal - mode->hsync_end;
> +	if (ctx->lvds_dual_link)
> +		hback /= 2;
> +
>  	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_BACK_PORCH,
> -		     mode->htotal - mode->hsync_end);
> +		     hback);
>  	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_BACK_PORCH,
>  		     mode->vtotal - mode->vsync_end);
> +
> +	hfront = mode->hsync_start - mode->hdisplay;
> +	if (ctx->lvds_dual_link)
> +		hfront /= 2;
> +
>  	regmap_write(ctx->regmap, REG_VID_CHA_HORIZONTAL_FRONT_PORCH,
> -		     mode->hsync_start - mode->hdisplay);
> +		     hfront);
>  	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
>  		     mode->vsync_start - mode->vdisplay);
>  	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
> -- 
> 2.34.1
> 
> 
> --
> Markus Bauer
> 
> Avnet Embedded is becoming TRIA:
> www.tria-technologies.com
> 
> 
> 
> We continuously commit to comply with the applicable data protection laws and ensure fair and transparent processing of your personal data. 
> Please read our privacy statement including an information notice and data protection policy for detailed information on our website.

-- 
With best wishes
Dmitry

