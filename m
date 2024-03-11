Return-Path: <stable+bounces-27231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5C877BA5
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6911C20CEC
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F1111AA;
	Mon, 11 Mar 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG5BIkoP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54861119A
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145413; cv=none; b=ZnBSqXNZdgU0wb0xM+YuRFDkfIeI5z8vMpT8tIWxcQ+3bqGVPbNr5Lt/ZUzpp3fwx6GsgKFRDuiFSSxkfNAlEsBH1Y+ut5wT2/oQb73dLONZPnNfOGjGfUoSrdGEsG61TxgOO6BfMH7joKRKjzqLyAHjK9LoqtooeaMb40PtYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145413; c=relaxed/simple;
	bh=WV+ampiNXt59HPbUhKEKsNt0WDsax4NhKbkgRy0DI6w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gWg5PeA6+YvXJqmXKJJi/jzUIl4jHLZ8TLkqQN2ZfrUpfGI8lV/NNretdMVEr1yoP7aodsW5gF47J9Z/ygZWSvVhRjsGdsj8L77Jd//uKdSmOw4Zq4KX6HKo8IoqAj621ro32wzi6jlkwxYOz22lqmb3F7uSxDUld1QAXllpg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dG5BIkoP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412f1961101so31385395e9.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710145409; x=1710750209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMJIYAT1aoLggdRB8puSiHOpe8FLhZyNAYzFcBUjOwA=;
        b=dG5BIkoPx/+GWMgqQ2mRmt5mc9TJ20Qwv1mXQisH+Ot08Se1mzBbLf0hpPOC/Kjhal
         OL8xTgY0dVfFsr3v/OMzO1y72jDAphJeRFFPuhC5NKI6C47hSNi15AhSEjT/8gZTiQKW
         NSuM5BVDa2SfeWfaMmIPIQ8zKym3wzjduEhc+5ybkUGaD2qtDbNTFh2j3EcPvDCiemfk
         obaKqvPYWcNNMA8/nwfQpZInq8ecSiuB6iE/bsY+Tz/y82KplIPZl6pRCiZZc2U21mak
         5P/2lkj5rHAMdw5gHMpaTa4bWatWBGIRyvtcaN9LEj+x2bpW97PPYXKdBSZyB4Nx3AFO
         Qhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145409; x=1710750209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AMJIYAT1aoLggdRB8puSiHOpe8FLhZyNAYzFcBUjOwA=;
        b=Sqz9rjODe0QaiKrJBzk8ZHGAFzZ6Tchtp4QxjKLD67/v7i5YaasnX77mAFwrumeeUm
         y9G2frKfuurmAQ94m9JL7Fb7QM/yZAImqZWFUdD6iOQddZ6oDJY/nWLj/1FXTYWIQuft
         rXvZlzzRgT9qK4BbL+S7cLM4+gJdFcthUZMZT+B09q7tJiKbbNDtU9RZyjM6DF89kJSM
         PPDoz8LTVlXoxGu4pEq+gMul17SBmlaSjYab/niE4NHREh9hZi5L4oRwLd23txKwv2do
         3KSJQcckdBOnhuzqjWTHygCOCuZs9Kw2N1ddloTYblPxy+UwVAN199ZYjJac4GODkRfd
         u6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHqvdC/LwpYA5rG8YkhcSMWwHU6w9nJ/UBEeN7U4pgvC9hQxkHHedOlxxBPU1RCQ/dxGHgboL3lU6bvtLpIrCF1ceWQ9vk
X-Gm-Message-State: AOJu0Yx4PbVlh3ImU6tMn7h2pDci/to2bx0ARa5GT5istlLwZqr1I7te
	YidcSv2ULbyzUc3q2qmR7a8FEYLz9O+vkK7I10UyMK3KSMlhfvoTkeI4xiTwcqw=
X-Google-Smtp-Source: AGHT+IGojr92IZ9JNjUk6i05tLWnB0/kzB3DppIN43i5jY2MgknDStpDu7m0C6KmkiaP5e7N7wDdDA==
X-Received: by 2002:a05:600c:3d88:b0:413:2a07:20d3 with SMTP id bi8-20020a05600c3d8800b004132a0720d3mr1254967wmb.35.1710145409494;
        Mon, 11 Mar 2024 01:23:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:48be:feb9:192b:f402? ([2a01:e0a:982:cbb0:48be:feb9:192b:f402])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b004126afe04f6sm14688429wmq.32.2024.03.11.01.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 01:23:29 -0700 (PDT)
Message-ID: <af099226-6644-46c5-b424-3c3a61e454c4@linaro.org>
Date: Mon, 11 Mar 2024 09:23:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/8] drm/panel: do not return negative error codes from
 drm_panel_get_modes()
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 stable@vger.kernel.org
References: <cover.1709913674.git.jani.nikula@intel.com>
 <79f559b72d8c493940417304e222a4b04dfa19c4.1709913674.git.jani.nikula@intel.com>
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
Organization: Linaro Developer Services
In-Reply-To: <79f559b72d8c493940417304e222a4b04dfa19c4.1709913674.git.jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 17:03, Jani Nikula wrote:
> None of the callers of drm_panel_get_modes() expect it to return
> negative error codes. Either they propagate the return value in their
> struct drm_connector_helper_funcs .get_modes() hook (which is also not
> supposed to return negative codes), or add it to other counts leading to
> bogus values.
> 
> On the other hand, many of the struct drm_panel_funcs .get_modes() hooks
> do return negative error codes, so handle them gracefully instead of
> propagating further.
> 
> Return 0 for no modes, whatever the reason.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>   drivers/gpu/drm/drm_panel.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index e814020bbcd3..cfbe020de54e 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -274,19 +274,24 @@ EXPORT_SYMBOL(drm_panel_disable);
>    * The modes probed from the panel are automatically added to the connector
>    * that the panel is attached to.
>    *
> - * Return: The number of modes available from the panel on success or a
> - * negative error code on failure.
> + * Return: The number of modes available from the panel on success, or 0 on
> + * failure (no modes).
>    */
>   int drm_panel_get_modes(struct drm_panel *panel,
>   			struct drm_connector *connector)
>   {
>   	if (!panel)
> -		return -EINVAL;
> +		return 0;
>   
> -	if (panel->funcs && panel->funcs->get_modes)
> -		return panel->funcs->get_modes(panel, connector);
> +	if (panel->funcs && panel->funcs->get_modes) {
> +		int num;
>   
> -	return -EOPNOTSUPP;
> +		num = panel->funcs->get_modes(panel, connector);
> +		if (num > 0)
> +			return num;
> +	}
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(drm_panel_get_modes);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

