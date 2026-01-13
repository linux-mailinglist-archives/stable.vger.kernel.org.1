Return-Path: <stable+bounces-208248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9CD173E6
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FC5301A701
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E937FF4C;
	Tue, 13 Jan 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY215ngP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16937FF51
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292233; cv=none; b=YkGJavQXWCJsGRZwkXOQJCZqjyvwVRZjAeKzDXt5KKKkMUkpkm6vYwIndAHvS1NvjksgamwqlvI/BApVY2KuQULfF38/glUgcku1WhPnRiSqiuzgcUcIW8SWzh+AgDCFyzcDwoB8UygS0QX4pdtxqdlsCml3TSzcFaKay4MJ3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292233; c=relaxed/simple;
	bh=apLACy5LRvAOPJ7IZmjerYfRaNl4zV1qNhBbrk1hzOg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D4NOZF5OO+hzMkJzFVfT+vkT06dr/r0iwOh8PNe5RfoLXFMQnsmWDCGfuQ+9aLuMsqV4bxM2ROilDaTy3JN/MkciZbwAk03M9Xd6yIawJDzoLKckpqtWoKV1TNioiUYDG6V+gDIZ8kIS9RxSVjeSPF4YDVT27hTeF/2JbnqmazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XY215ngP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so53570655e9.3
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 00:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768292230; x=1768897030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqrSisus0MAErIVOLJfrHVeAQH6IHBP3UWfckXEzYn8=;
        b=XY215ngPSO3xDdIQgxHL38fmfrQNpfe77I8iD1fLixm1iYKgGn6ttFtdDUPXENXAcU
         A1LSQyfThLrQDwLguzSA0eA87UeQ3hu5QeMgOQNoJAx5ZBe84O5Z6FFfK3upXbsx8Y44
         l40Y/eOZ3oiMRYbAWxkM3Xr+WOmviD8k37I4/6XpO/Ie97zppka8s/Xd5NUDm1y1gTvt
         FvwYp9Rpr5utlALrFzTKrvOYeWvfZf/L0Q6VLKYg9WwJS+Sz6pvYKf6DlisX+YLA/jJJ
         dASWqRaPSz7Ys/80gr1CTAWGPg56LrPG2zYpnhJiI2U0Z9iKTfoak7KoBx+E9JKlMPpU
         FXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768292230; x=1768897030;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqrSisus0MAErIVOLJfrHVeAQH6IHBP3UWfckXEzYn8=;
        b=gUmqjXvV4swdrfvaUokk2TVBBCmz4aQnw39K1m4ksgzlxmkKuEfSFHODby7ZXsuMZg
         uMULDVyGNSdtetIb0qEqQcuqiaRfw42YCtLpZapcNcBMdHK6VYtIi3EfhVwvGf9BU9lH
         fuZfVLwjSTH8tJStRFxpOqWFi1vU44ThyjCeW8IpqC9jQoFX2m2QGovt5fb2sth/f++O
         yp+WWvbPlX+M4LNW/oswFCY5aDywULjlAhPbb0MwXFtgIn/7ITZVIX6s46cZQQsrI2TR
         Qsk8Ah6IXG+ZW5Q23HpDa+gd9O4MioTh1DnFIQ//9bBA51p8EUDGfsst+jYZ4uoutlW/
         b2Gw==
X-Gm-Message-State: AOJu0YymTV7vXZbdnXNpnbg5zyqPvtdyd3SZPt1MYi1/ZXKYtqve0gWo
	Qzz8cGhvVqVnSTGfEc6WTh1SxYp9VFADkV9NUkc0+elGDRi1MN7WifKLGGOuX1vbkgo=
X-Gm-Gg: AY/fxX44fEgHgF3/jfqWpessbESqrgzkrbYsSfy3t/Y7dwn8RApuIrAVJNPXfswDatR
	JoQFj8y8HXhALIYEr5X2bq8TQEu9xYhHTdvqy8yyZMr9boWTmy5j6BEejL0ue3hrDycmejU1MUU
	bzHhFkvEC17apW0PJbWVrQTkPFBRUIoaT5iWxSQsFdroUSIFk7sftnVu7eAMNvt8lLJibP9HLAp
	lUzaCnBW6lZPZBjZX0gJ55pCoLSuaIxl3qxr31B/xQNTieTBuf11leZNI4ahPFs++ERRTup4xGB
	oeC/O39WLUzKam7ULdKTNSGlK6+z8XqixZZSTqI615vGTZ9h3DUXtgj0+KnHhS/wF0k9j6qBDXJ
	QqRqEEfnRVtc/ixrFIEmkSO23cycA2xR0+EAisvfUMiv7V+yLHRYGrRdb+uDbFI40cpJYUJN30/
	dfhnoHuZfq5VyXEWZbFYnuojsEGqc74oFJUSiZYt8=
X-Google-Smtp-Source: AGHT+IE/Af0e7am5EHJhqwtMQJAYtHfmFKUaSLvohxfAuYyi6lM6S9u92zWhoF35Ue3usR4XnrHH3g==
X-Received: by 2002:a05:600c:3114:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d84b2d27amr229627095e9.13.1768292230246;
        Tue, 13 Jan 2026 00:17:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768? ([2a01:e0a:3d9:2080::fa42:7768])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm407284565e9.14.2026.01.13.00.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:17:09 -0800 (PST)
Message-ID: <bf36363c-9e28-402e-932d-7844a947c73f@linaro.org>
Date: Tue, 13 Jan 2026 09:17:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel-simple: fix connector type for DataImage
 SCF0700C48GGU18 panel
To: Marek Vasut <marex@nabladev.com>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20260110152750.73848-1-marex@nabladev.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260110152750.73848-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/26 16:27, Marek Vasut wrote:
> The connector type for the DataImage SCF0700C48GGU18 panel is missing and
> devm_drm_panel_bridge_add() requires connector type to be set. This leads
> to a warning and a backtrace in the kernel log and panel does not work:
> "
> WARNING: CPU: 3 PID: 38 at drivers/gpu/drm/bridge/panel.c:379 devm_drm_of_get_bridge+0xac/0xb8
> "
> The warning is triggered by a check for valid connector type in
> devm_drm_panel_bridge_add(). If there is no valid connector type
> set for a panel, the warning is printed and panel is not added.
> Fill in the missing connector type to fix the warning and make
> the panel operational once again.
> 
> Cc: stable@vger.kernel.org
> Fixes: 97ceb1fb08b6 ("drm/panel: simple: Add support for DataImage SCF0700C48GGU18")
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3acc9f3dac16a..e33ee2308e715 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1900,6 +1900,7 @@ static const struct panel_desc dataimage_scf0700c48ggu18 = {
>   	},
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>   	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
>   static const struct display_timing dlc_dlc0700yzg_1_timing = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

