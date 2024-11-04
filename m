Return-Path: <stable+bounces-89601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87759BAE2C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CCAB20CC1
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D218A6AA;
	Mon,  4 Nov 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tt1DIjZq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096A3214
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709261; cv=none; b=jLmEOtFVlbpFny7hbpyVlcdxYl1/gm+Tf+YuB1SRXNYBKIOiLWSh9tSm3CAE4CNWgVIgAk4o/Od6871YFzB99zWU+0e9l7tDsoIT2Qe1U6dyTask4NZy/v62QpGgjPiWx5jJHXoNDto0ofjT9vdSKPcLz+Tvm+NiopC8Azpi9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709261; c=relaxed/simple;
	bh=iPapASz6aSeaJhVnQhr+zJowiyNX6G+1Nt1rrILwx84=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZWZB5O1z7DpeqwLnNzk80hzFQXtCxAcxRbmuOUk3R+wXz9wSDPoHwsSCRs0PBzBsMXMvmxz6KjT29LQbu+OIN+XDja73fpMENOfiVtsdTzZK5Klgk96uObszH1xC9XS62ZoCaAEz0Xy9QJko5BkfI5sugGGdWjNsgsrSa07meHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tt1DIjZq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so2478198f8f.1
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 00:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730709258; x=1731314058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ApKzuM1Dy1yHlR1OnkyQgRDQp0Q55UQ4hWD1IiDoII=;
        b=Tt1DIjZqxDA8vBHdDmEFlG130xBjAQsldgAjeZRFcsDZqHvvB/A92FrUJnYqxcUZ+a
         5Fbd8tVxs8a9DGXpgH/8muLWANlK2jHO1bgNnCfms6g7QCqH+CpR/xyzeJHnapBKKaP+
         CrILoCHo2awlBDgJMnV6GFJvH9o1qw4CyZk8SznOOD+hnwMznNT6RMSJZwh3Pjy/g1IM
         G7sDuINpwz8AhsBQ7eralTPLCHPXqh4To/Xx3VsRZGKd2epjhZp8SNY01auSwG0CJ3b8
         JiZeAdW9/cPO9aSDuVfhEZB51Paxm3e96UrqwYQNA0I+5o9QgaHnWg+6LFOlHxO/0Rv3
         xu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709258; x=1731314058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ApKzuM1Dy1yHlR1OnkyQgRDQp0Q55UQ4hWD1IiDoII=;
        b=mfDD/5XXUXHDRLi+T/bXApe83V0wiRxpk4sKwdI7tfTHaxElzT2AI7XzeI4v6qrIBo
         KwPKudHL2ESuSSt+QSiQ4bmNsvzt58bGhfhNpZaiWxGfBx4we3Lgt6KgkeEo8df4ystX
         IBxCHfEPZ/EhAPek2/WiXJxqmdxaRTOHNPjE92aDZw/ihpsTCbb8/0egwo+RgCYv2Vqo
         ea3BmvTDRSbUAGk80IFEoWWyE8RVrdqOIqkO3powsSuMOh87mdC0HpScOHfVQgkLgMfr
         OiW46UmoVOyz/yGfXn7EOJF+NSRpGOlN17ceQeZOZl6BVXJG+kWprmr+FexoehazCLAG
         vedg==
X-Forwarded-Encrypted: i=1; AJvYcCVlR8VQyYo905xhzIlWy4SiPj9oLbLj18MUebx3MHlh170EV/7eX2IihkQQI+9QqQCsSBWbgpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyrhaE1M0O4Rz2RguR5NO8UxNjfEUpo9d11dwh/n4J45tpJIB
	zQ7HCGgE4tnuEF2qmosAK0oNURF6AAoRVXY7W5qSvej71+4b7rxdbIL9fjvyLB4=
X-Google-Smtp-Source: AGHT+IFxmI5A9LHrUN21bEWOHNg1hm+NCdXeoy97NqjdjCzBuK2/l+VfezM4eItvxCTFN1s/k5MfCg==
X-Received: by 2002:adf:edc2:0:b0:37d:4ebe:164b with SMTP id ffacd0b85a97d-380611e1252mr20361114f8f.44.1730709257844;
        Mon, 04 Nov 2024 00:34:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5b00:c640:4c96:8a97? ([2a01:e0a:982:cbb0:5b00:c640:4c96:8a97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd95sm12652484f8f.83.2024.11.04.00.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 00:34:17 -0800 (PST)
Message-ID: <e4bf88e3-e77f-49dd-84b8-e3fa3d8ee95e@linaro.org>
Date: Mon, 4 Nov 2024 09:34:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
To: Chen-Yu Tsai <wenst@chromium.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20241029095411.657616-1-wenst@chromium.org>
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
In-Reply-To: <20241029095411.657616-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 10:54, Chen-Yu Tsai wrote:
> The IT6505 bridge chip has a active low reset line. Since it is a
> "reset" and not an "enable" line, the GPIO should be asserted to
> put it in reset and deasserted to bring it out of reset during
> the power on sequence.
> 
> The polarity was inverted when the driver was first introduced, likely
> because the device family that was targeted had an inverting level
> shifter on the reset line.
> 
> The MT8186 Corsola devices already have the IT6505 in their device tree,
> but the whole display pipeline is actually disabled and won't be enabled
> until some remaining issues are sorted out. The other known user is
> the MT8183 Kukui / Jacuzzi family; their device trees currently do not
> have the IT6505 included.
> 
> Fix the polarity in the driver while there are no actual users.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 7502a5f81557..df7ecdf0f422 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2618,9 +2618,9 @@ static int it6505_poweron(struct it6505 *it6505)
>   	/* time interval between OVDD and SYSRSTN at least be 10ms */
>   	if (pdata->gpiod_reset) {
>   		usleep_range(10000, 20000);
> -		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
> -		usleep_range(1000, 2000);
>   		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
> +		usleep_range(1000, 2000);
> +		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
>   		usleep_range(25000, 35000);
>   	}
>   
> @@ -2651,7 +2651,7 @@ static int it6505_poweroff(struct it6505 *it6505)
>   	disable_irq_nosync(it6505->irq);
>   
>   	if (pdata->gpiod_reset)
> -		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
> +		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
>   
>   	if (pdata->pwr18) {
>   		err = regulator_disable(pdata->pwr18);
> @@ -3205,7 +3205,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
>   		return PTR_ERR(pdata->ovdd);
>   	}
>   
> -	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pdata->gpiod_reset)) {
>   		dev_err(dev, "gpiod_reset gpio not found");
>   		return PTR_ERR(pdata->gpiod_reset);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

