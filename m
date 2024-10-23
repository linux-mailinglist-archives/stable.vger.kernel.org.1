Return-Path: <stable+bounces-87813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F7F9AC0F3
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E87B1F21A6F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837614D6ED;
	Wed, 23 Oct 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBrLBQUU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0A1448DF
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670609; cv=none; b=Vyl5T81ViQH+TlmfnTo2A7Dvi4BDWXKIkgBePqws/DTIaVrLXuc7SanqJ+xjIkx9EDzQkHzcz2rPDaUow+lPBXtjpxXbsXtBcOzIXmMOvQl1dN4/6feUCcN7c4lqdgIdyr+XzEh3MOgJbIJejKcEmh+OBjBtYVGaGW+/uJ4qwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670609; c=relaxed/simple;
	bh=h5rrHQaT74f5d0llBGChfcRKdYgKSqE8h63ctS808VM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gMSDxcFyc3yNuKbliv7LTI4dqDkhEjgovwLkqeSpG4dJAgzQ+UAedkacrJDVJe3rEvmpjSMB5I1M+4bMqaca6W4X6c1CYowUwJbq04f8Cg360nOD80UjRtcFPjfJblk27YsGSGCeOfXsx8JoYADoJmvWg93WxrF4nRi0AHtSIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBrLBQUU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431616c23b5so4052025e9.0
        for <stable@vger.kernel.org>; Wed, 23 Oct 2024 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729670605; x=1730275405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jns0AjCrY+/sra6NNKO1WPiOfep6FlanuvD1RpWqF+U=;
        b=fBrLBQUUIwAr/ELw0ct2zX/lUC6qmzxDxv4PxwaLPBbtb1mfjBy+fckla2iLVcZ9rp
         2c5Nxj3AhIb8JfJ34/8TtjWfVhWO7/kernqdTv4zcX3qI8K13c+IOdIg/p7khFwAx7ke
         YKYlXyerizR1dN94m7qd3ci1X77tLpKqJrW+taSvA5e9Ewt2pBLOO6bwHtajeuGa0rpC
         j8OP4QkVHOKrmE51P/9ZHclcISlpcntXIAbHcSGSIoa19mbrpwUOKgxYkgTvlTX6aQtk
         5mNLohWZjU+ktrp1Ceq51H3SZF8d2+Q8ZmCbSei/DXl0IFARnRzNbitkm8PCn99BrFly
         IoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729670605; x=1730275405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jns0AjCrY+/sra6NNKO1WPiOfep6FlanuvD1RpWqF+U=;
        b=q6bFgfWxweqlaHQq4af2aMn4EmSAYdPcYT0nPLMhlCyrvhHMIegO32hlhEFUUk3RKq
         b3rw5EIKoQ6gh8LDbNuZZUr4CN+SbUYd2dd+AUrVYY2sgDLFaJI87Kj1A4Zhm1yj1Ubr
         gQCWpfK4HMDQasMvbz1G53WFFPdSSSKUCE8mn3zeTiqHSvoH1d1Q070SbtNIIkFtsusu
         H+1xNaBcvBjWC+mITZNlM/VcJwmt8NwgPcKZNFY4HfoHmkfxLqtFcBIGcyLLXui2P7yd
         lGjh+hYbvtOo1BPuiLEC+jaZ/SfLreRl40XRcx9OmgPUWfs1znr5tE6WgybuUA6eyqfM
         dkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtO6q/DxfTDucF5YbhQax3i7ayWyx8K2uvgRLBFcYk7fUlL8+84CcIelZK3S1MO1cEyZdCBqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNoUpSIqyiyDoOEzaDUHWdNjJpY7AlpRgLc3DVE0FHrzDRtDt
	R2mUnMddzNPuKU/y6dxkgNsWJeiWmY39u36TEGlqh+/IABTWZ/JdsoP8HFK4fSo=
X-Google-Smtp-Source: AGHT+IEWCBccjn+i9HJOQ1/tjUbWC5+hikC7YmkDAGQe/PxV0SKYHv1wTezrnaRpi1ipxHSEOShBhQ==
X-Received: by 2002:a05:600c:4589:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-4317bd7f197mr37781505e9.5.1729670605471;
        Wed, 23 Oct 2024 01:03:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f9e2:19d:5b22:8044? ([2a01:e0a:cad:2140:f9e2:19d:5b22:8044])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1eccesm8882305e9.46.2024.10.23.01.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:03:25 -0700 (PDT)
Message-ID: <e28f88ca-357b-4751-8b37-c324ff40f9f5@linaro.org>
Date: Wed, 23 Oct 2024 10:03:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drm/bridge: tc358768: Fix DSI command tx
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240926141246.48282-1-francesco@dolcini.it>
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
In-Reply-To: <20240926141246.48282-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2024 16:12, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Wait for the command transmission to be completed in the DSI transfer
> function polling for the dc_start bit to go back to idle state after the
> transmission is started.
> 
> This is documented in the datasheet and failures to do so lead to
> commands corruption.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   drivers/gpu/drm/bridge/tc358768.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 0e8813278a2f..bb1750a3dab0 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -125,6 +125,9 @@
>   #define TC358768_DSI_CONFW_MODE_CLR	(6 << 29)
>   #define TC358768_DSI_CONFW_ADDR_DSI_CONTROL	(0x3 << 24)
>   
> +/* TC358768_DSICMD_TX (0x0600) register */
> +#define TC358768_DSI_CMDTX_DC_START	BIT(0)
> +
>   static const char * const tc358768_supplies[] = {
>   	"vddc", "vddmipi", "vddio"
>   };
> @@ -229,6 +232,21 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
>   		tc358768_write(priv, reg, tmp);
>   }
>   
> +static void tc358768_dsicmd_tx(struct tc358768_priv *priv)
> +{
> +	u32 val;
> +
> +	/* start transfer */
> +	tc358768_write(priv, TC358768_DSICMD_TX, TC358768_DSI_CMDTX_DC_START);
> +	if (priv->error)
> +		return;
> +
> +	/* wait transfer completion */
> +	priv->error = regmap_read_poll_timeout(priv->regmap, TC358768_DSICMD_TX, val,
> +					       (val & TC358768_DSI_CMDTX_DC_START) == 0,
> +					       100, 100000);
> +}
> +
>   static int tc358768_sw_reset(struct tc358768_priv *priv)
>   {
>   	/* Assert Reset */
> @@ -516,8 +534,7 @@ static ssize_t tc358768_dsi_host_transfer(struct mipi_dsi_host *host,
>   		}
>   	}
>   
> -	/* start transfer */
> -	tc358768_write(priv, TC358768_DSICMD_TX, 1);
> +	tc358768_dsicmd_tx(priv);
>   
>   	ret = tc358768_clear_error(priv);
>   	if (ret)

Look good, I'll leave it here a few days if someone has comments

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

