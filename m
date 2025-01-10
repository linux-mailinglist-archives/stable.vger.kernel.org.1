Return-Path: <stable+bounces-108182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A4A08D9F
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 11:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6684F3A2343
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26220ADEC;
	Fri, 10 Jan 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrsWt2Zy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232A1CEAC3
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503987; cv=none; b=M5NBh+p1KX1wJe5SAJ+652dM8Gv7quQhiLqX5sMaK7nUlDjkEH/fA0PAFX77OSojTJYXfLoO4q9fcN140zCmckpyAUGF4CSk3ignCTRJKGbk4ZC8Jni0oQugdeeqDLSnimcEyeTDuFyObyOF7AMhQ1nCeI1NitWCgQ2Wmk/TKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503987; c=relaxed/simple;
	bh=rBUR4MXN75ZgWjuzX2LcLCFLyKr5iG/+0kPq4aCBM3M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DGdk+33mzioCQ0oj95oqpdh5iJtfVtSXa6g3RUnzD1LKAsPfW1Hy4PyRySmSDTBd4ZyNPHDuwhH87FVNTQG8c/llGgHy/9e61nkR72jAeeBRPLwx5ZBFiEi+GtXv2w+4S3Xo6iJVN3MauleAYVrVaDEuR2fcmIqSRqLf0YBmk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrsWt2Zy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436341f575fso19798295e9.1
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 02:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736503984; x=1737108784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOUzYhTzRbU2PZyaCr9aEEOmHEzU4GQv9eiFuMaGvrQ=;
        b=FrsWt2ZyClTNPJ1CjFLDUR+6MitRYK+DjF/ZUQ8vNTQTCb3I16vub6100meOhzq0ce
         ToImqZ+K9YDiK6B9pF2P1RQRt98nLo+Bz72m1utGekFe0QodoNKRwfRkxSECub70vxJ1
         66BCwHjnvQ4jNTmLNIW7B4yNqE5VNAr831V0RTLVbLdwekzQa+nqlI35blYY76AXP0DG
         BVbT8JWJzh935lm8TKEWuJKGensE/aY/OO5UNBzoNwfMKP1KWF5ktRBF+YtpNDE6aqdo
         fnkhzi3Q+SOt6h52wJwUC9VGybr5IHUcZdNB5ZOZxtUf0Fh08HSrR7+rIVCZiWCfutoB
         O9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503984; x=1737108784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QOUzYhTzRbU2PZyaCr9aEEOmHEzU4GQv9eiFuMaGvrQ=;
        b=Z8WXJ9KWY75UstdvjIQj8O5BtwZgHJrHRyrH+siu5zDzj7ESaVspUIFGFlidYmi8gb
         eTJIVLocTZt75L8w1rj7BDY30jmCN4V2pgIcpC4QSrsl83+GxPyyZrf5PIkz0Pl1a9Ma
         5BKm5nf4XcbSfLM+oIW5iBR4pkjYk8vdAr118+hUFTwpuHftTYoVGrvaBLF30uCl/UnV
         O9YsImVhN83qxzzuUkLj7pKPuZ/zXywSuZQ85R0KqvPIjtrK9Ns9k0ys/8FH0PB/tqMg
         E8LJIiQLM6ESUotLm3EE8Mwgl6qTOcjAaCwXZ0xEFahw92iTosYMCjqO3uMU4FBcx7gs
         dp3g==
X-Gm-Message-State: AOJu0Yx5T2eAj9083yPSeHZsADJzmqgrqGt3m2TJDeLjOg9YhlAJLgSL
	S+ciLk1sraEcLTbNWc39y02reTTrr6anVLAzRBKjDd+zS0U1FVXKBvkt/8UC4Ec=
X-Gm-Gg: ASbGncuZHcahjCZpk4x7w3o8HhG6wJSW9KpCg1d2Zku/4gjiX15/T3o7Q+XhJZyMwB4
	rOUbSjjc6lYHA7MgyiYPY0XNNeurzekoxtYgQbp2E0S8ojYu/1ybtGe02DNuA1EA8K5IceJRSWj
	/QpniHO6yaau4zfq8MYfIzCBq0MbyqSVFDn9vbGoZ9/3dw1QYcvWfZDASAS6TuHASBK/E48B+n6
	XTjOycZ5FXwYN3AD07XZg9bsKs7O7UKeC4yeRVY3B2E1C/0ABOPD1fizBfLt7dlzrSptwHGB2E4
	BE4ZqeS7WZLqNaSApuDTlt/RDWQTVGrWWw==
X-Google-Smtp-Source: AGHT+IH14VgpNAHxLDfw+eb1nzA4fydxlf+fdVrPXOSjYG/N+CGyBX4YnPcgAjL/ozrdB+dQhWcohA==
X-Received: by 2002:a05:600c:46d2:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-436e2679db4mr91257665e9.3.1736503983816;
        Fri, 10 Jan 2025 02:13:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8? ([2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm47221015e9.13.2025.01.10.02.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:13:03 -0800 (PST)
Message-ID: <bca7f65c-cdb8-48be-a800-2c36aeeeb8e3@linaro.org>
Date: Fri, 10 Jan 2025 11:13:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] Revert "drm/meson: vclk: fix calculation of 59.94
 fractional rates"
To: Christian Hewitt <christianshewitt@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250110074458.3624094-1-christianshewitt@gmail.com>
 <20250110074458.3624094-2-christianshewitt@gmail.com>
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
In-Reply-To: <20250110074458.3624094-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2025 08:44, Christian Hewitt wrote:
> This reverts commit bfbc68e4d8695497f858a45a142665e22a512ea3.
> 
> The patch does permit the offending YUV420 @ 59.94 phy_freq and
> vclk_freq mode to match in calculations. It also results in all
> fractional rates being unavailable for use. This was unintended
> and requires the patch to be reverted.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index 2a942dc6a6dc..2a82119eb58e 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
>   				 FREQ_1000_1001(params[i].pixel_freq));
>   		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
>   				 i, params[i].phy_freq,
> -				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
> +				 FREQ_1000_1001(params[i].phy_freq/10)*10);
>   		/* Match strict frequency */
>   		if (phy_freq == params[i].phy_freq &&
>   		    vclk_freq == params[i].vclk_freq)
>   			return MODE_OK;
>   		/* Match 1000/1001 variant */
> -		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
> +		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
>   		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
>   			return MODE_OK;
>   	}
> @@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
>   
>   	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
>   		if ((phy_freq == params[freq].phy_freq ||
> -		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
> +		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
>   		    (vclk_freq == params[freq].vclk_freq ||
>   		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
>   			if (vclk_freq != params[freq].vclk_freq)

I wonder if a Fixes is also required here

