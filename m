Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9137A1C4C
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjIOKdG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjIOKcw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 06:32:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4581B8
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:32:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso21241615e9.2
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694773948; x=1695378748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0aca7PnmjAHHqfJ62cWuej3CDSoPPa06Inr7vVa8Ts=;
        b=e9OhE0I3Kkc9q6UjaorqCJs6BXaYo8c83UOQRUBVIcpWPkeKuF+SSHglyw8B1ZGeNu
         xTQRAX25v9kawrh1cYAu34YjHf32kXQUd/W5Vl6nixbGukrChCrzQtFC8YLg9SlXIG+r
         r1KTnZz/QSbb+j40U23S7HPClH+z4aSg2kWtDT2gxyFhz+FsSXd8q51sC0SvmOlk7r4u
         4B6HrD8dHQVcJLpOFfufzDyULXyY9HRadwy2/aMEI5e7hQrJ9y9PJ0jbVqpFi58HYORs
         8JqNvOYSjUR+yxtA1mHdy3go38yDDgMLq92OqTK36mCS/tp3T/FmcVs7qYxt91+sN659
         QO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773948; x=1695378748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0aca7PnmjAHHqfJ62cWuej3CDSoPPa06Inr7vVa8Ts=;
        b=fq+C0XltCNXYH3fDeNJX323rBqD2J10xcSvJ8Ih50auN6aHH1JMwVCwuW7OEjEhGcj
         8yaZdWqGiul3k4+S5d5IAMJ3aVqkwovia/fkGQ0Nm8BIax4vX6pD6wrz4Ak4Mxv4QVTC
         h9NvU9KI3ACHyQNLrqMu7z9r5xx7cnqdro7+ZMsDhtydmv5W+e9dEq3o/lvWiheSgcm7
         qlUQqhEfYuKYl8E2Ckj3hsBLQvGNIfDT6vgyMi0yva/tbXkICvKu6j4DMsytsKax3HGY
         ueiTqht/kpEbIwQZ0nDLtkX6ciFrzwlFnUXHiUPLV0f4AR44vLxtm+cwrWqBoH7As7d8
         cNlQ==
X-Gm-Message-State: AOJu0YwupjWLm5M3DVBf5eBc9A7ytKNe4Mn5HIxx7nLfTTvoBXHZqosG
        9evUIhbuEoseX9rHX5XaDsh0Sg==
X-Google-Smtp-Source: AGHT+IFybQKfEBpNlItCVpee/8rq+0HFpuzq/V78nKm58xypS5dbiUu0yQcIrVjidKY6MOBSpi12bg==
X-Received: by 2002:a05:6000:1f89:b0:31f:f72c:df95 with SMTP id bw9-20020a0560001f8900b0031ff72cdf95mr754975wrb.21.1694773948559;
        Fri, 15 Sep 2023 03:32:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:990a:74e6:266e:2294? ([2a01:e0a:982:cbb0:990a:74e6:266e:2294])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b003140f47224csm4046204wrr.15.2023.09.15.03.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:32:27 -0700 (PDT)
Message-ID: <4de57018-e7fd-488d-b564-a79176b79fc6@linaro.org>
Date:   Fri, 15 Sep 2023 12:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: bridge: it66121: ->get_edid callback must not return
 err pointers
Content-Language: en-US, fr
To:     Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Robert Foss <robert.foss@linaro.org>,
        Phong LE <ple@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        stable@vger.kernel.org
References: <20230914131159.2472513-1-jani.nikula@intel.com>
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
In-Reply-To: <20230914131159.2472513-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 14/09/2023 15:11, Jani Nikula wrote:
> The drm stack does not expect error valued pointers for EDID anywhere.
> 
> Fixes: e66856508746 ("drm: bridge: it66121: Set DDC preamble only once before reading EDID")
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Phong LE <ple@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: <stable@vger.kernel.org> # v6.3+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> ---
> 
> UNTESTED
> ---
>   drivers/gpu/drm/bridge/ite-it66121.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 3c9b42c9d2ee..1cf3fb1f13dc 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -884,14 +884,14 @@ static struct edid *it66121_bridge_get_edid(struct drm_bridge *bridge,
>   	mutex_lock(&ctx->lock);
>   	ret = it66121_preamble_ddc(ctx);
>   	if (ret) {
> -		edid = ERR_PTR(ret);
> +		edid = NULL;
>   		goto out_unlock;
>   	}
>   
>   	ret = regmap_write(ctx->regmap, IT66121_DDC_HEADER_REG,
>   			   IT66121_DDC_HEADER_EDID);
>   	if (ret) {
> -		edid = ERR_PTR(ret);
> +		edid = NULL;
>   		goto out_unlock;
>   	}
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
