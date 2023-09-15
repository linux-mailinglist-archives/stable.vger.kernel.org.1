Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062687A16B4
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 08:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjIOG72 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 02:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjIOG71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 02:59:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDDB2726
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 23:59:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-404732a0700so15074645e9.0
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761143; x=1695365943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mt0/vU7tS/I4WdeJ1B6LJJREbXiomv2o0TbUICA5gLw=;
        b=O6EHZIE8vUh6GkTc+2OQaqTVNzov57sjD0XUW7Xqr+ectObKPv4G6sZAth1DZaEnba
         i8dn8EGKbAU8crNs74xAnHD/JnrnPTIiJIkN+ICoITRxWkz64VW3R5JgZqKGrwa1/5dX
         Sf4roD37QVJJ2haAOjVQAqnVY90DJVrgQzCFzoRk4cysRO01+vgrvLHpVBujtt5fZBnv
         hswP6PkfnuCUpbSFaUaT9Hjis3y0sd0enmE5mnhGBH44v5nnuQhSofEA+QRMfdshHw5U
         djXM/CihkOjnPy2hwJyeYWDpyG/6T+YacuQV23CcNaB6ERNnOaGmZ7/PwYTcSvPZi3oJ
         KzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761143; x=1695365943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mt0/vU7tS/I4WdeJ1B6LJJREbXiomv2o0TbUICA5gLw=;
        b=vWlxLYQHyHyXEkiM57E6+SNllKxBNcFjwnf7XYvN5KqGbJzopJwH+aQfU79ykL32wH
         rVJJL75Klf37JK2KVXmUHCsGaDPZ53BBYc0Sq4S2w68tH7uNxFwSKnaSynTUFFgMgzxg
         8bKfCjkqRPwiWesEjs2CBhUjrMnyHpACO0SxqewUehENtDN2ku4/aSXKjyNT0Zp9WJzl
         9q1/6bZ+vt3yURzzs3xGy1Q/nR5oBt01SxQJ86HDpUXwy6FA3L5Dcvps1QpwyvA4SH1D
         e+ZcmfywJKt7Hl8vtDrwSnZdyjsdc+lfDgGcT93m07MFOHltZIGD7iXUWRioG/zDPyCg
         fKUg==
X-Gm-Message-State: AOJu0Yye8qu9Up0hdJvRPPsPRxWBnMTIBn/RWq6wngKvQCH1MeT/tKOi
        Fggoy8ihxxDId9vHYwkMoaPPtQ==
X-Google-Smtp-Source: AGHT+IE4jAQc/f0JC4LzXetxAe50ENFFr3PqEcIIEvx8Zg3C7YQLWDUFz7j8SYv1FN1qOLzLY1IAQQ==
X-Received: by 2002:a7b:c8d0:0:b0:3fe:173e:4a34 with SMTP id f16-20020a7bc8d0000000b003fe173e4a34mr674179wml.40.1694761143262;
        Thu, 14 Sep 2023 23:59:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:990a:74e6:266e:2294? ([2a01:e0a:982:cbb0:990a:74e6:266e:2294])
        by smtp.gmail.com with ESMTPSA id x13-20020a05600c21cd00b00402ff8d6086sm3779272wmj.18.2023.09.14.23.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 23:59:02 -0700 (PDT)
Message-ID: <a4b4432b-fdde-4922-8d95-3697807eefdb@linaro.org>
Date:   Fri, 15 Sep 2023 08:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: fix memory leak on ->hpd_notify callback
Content-Language: en-US, fr
To:     Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20230914131015.2472029-1-jani.nikula@intel.com>
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
In-Reply-To: <20230914131015.2472029-1-jani.nikula@intel.com>
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

On 14/09/2023 15:10, Jani Nikula wrote:
> The EDID returned by drm_bridge_get_edid() needs to be freed.
> 
> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v5.17+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> ---
> 
> UNTESTED
> ---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 9913971fa5d2..25ea76558690 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -334,6 +334,8 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>   			return;
>   
>   		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
> +
> +		kfree(edid);
>   	} else
>   		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
