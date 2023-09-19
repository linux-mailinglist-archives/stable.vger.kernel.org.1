Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10777A622A
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISMJp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjISMJj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 08:09:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F1F3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 05:09:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so745345366b.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695125372; x=1695730172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyymcUaSguDm3ESbxgv78EI5Vwk9UXn/QWZRGg06uqQ=;
        b=XqNw6rGEm6xq4dNb/wbtToWR45R14HRmqok7aSUxdsGbjhiPOfInJo71/rB/kobJVp
         S76s/n4lmtJm9Zqu9YWUun4ivM2FewI0kzUavEVa0Kxvsfh8xU01yo7gdArV2YwRW5OT
         ZaYzoz0LSG/cG55474fMCjvgAQwNwxTb7D8S97JMyYHZwIWRwPcBx5NZMWfuazWYR2u0
         2wglQ+KPNwNsTRDa1xfwrdwE23dQLFxr7RGbmG1SYHtpfVCk2JM/7/wne05cSk5M36Hx
         3TlPNP1yqkSntX/NKr+KduB51qaX1iO5o6Oc24aE/wuWvW7Gb3QIy8dSUyJ9VGz1fIrX
         2eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125372; x=1695730172;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyymcUaSguDm3ESbxgv78EI5Vwk9UXn/QWZRGg06uqQ=;
        b=BdQlnmXeovVMhsL17Lk+xejcy3mCF/BCU6+MNxCF9zZZuQ0Vh+pLCOlUgthRGbT9px
         Ek1vF9/8zoYWFBwlJzQqYQ4LVavnJQRmVWNKa7sNNlgq0CSdnbwdFxl3l9f6QWiXbIPo
         By/UslTjKxmHRqM6D1cKVDr4gAxvplGkXNx0xw027/1NGQrR13IAcjb3ry6OtQSnOEP5
         tYtKU1p2GDpmg9N2bYVUqrkBOI/P6Z6YqXU7w3Nhq7Ex9tSG/2xfpN1MoT45J+b2eIPO
         cPG/u8J1f1MHet0W5FtVy5kqHuEPIOmHv9OVSIxeHxJrKCvsVpDtgJ8EevJ01qlDhFkd
         qmtQ==
X-Gm-Message-State: AOJu0YyjMJXVmv3r/ud11JONsLaG8vQ6+9uxqwmlEffI4GOiv1mmgeFx
        ow7CV8LmjJovto1fAnHwjSyJ7g==
X-Google-Smtp-Source: AGHT+IF1gVma4UEtG0eqhW6UfpvwzjVxvPHSyF5dz/5Ez7OB90lYPomp4o1MKpXc5DjucepgYnDnHg==
X-Received: by 2002:a17:906:73cb:b0:9a5:c4ae:9fec with SMTP id n11-20020a17090673cb00b009a5c4ae9fecmr11336580ejl.52.1695125372060;
        Tue, 19 Sep 2023 05:09:32 -0700 (PDT)
Received: from [172.20.72.244] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709064a9a00b009a13fdc139fsm7635969eju.183.2023.09.19.05.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:09:31 -0700 (PDT)
Message-ID: <6c4fac8b-cf83-4cfe-9b81-607163c88757@linaro.org>
Date:   Tue, 19 Sep 2023 14:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: fix memory leak on ->hpd_notify callback
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
 <a4b4432b-fdde-4922-8d95-3697807eefdb@linaro.org> <87msxitrm5.fsf@intel.com>
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
In-Reply-To: <87msxitrm5.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 19/09/2023 11:54, Jani Nikula wrote:
> On Fri, 15 Sep 2023, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> On 14/09/2023 15:10, Jani Nikula wrote:
>>> The EDID returned by drm_bridge_get_edid() needs to be freed.
>>>
>>> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Sam Ravnborg <sam@ravnborg.org>
>>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> Cc: Kevin Hilman <khilman@baylibre.com>
>>> Cc: Jerome Brunet <jbrunet@baylibre.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-amlogic@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: <stable@vger.kernel.org> # v5.17+
>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>>
>>> ---
>>>
>>> UNTESTED
>>> ---
>>>    drivers/gpu/drm/meson/meson_encoder_hdmi.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>>> index 9913971fa5d2..25ea76558690 100644
>>> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>>> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>>> @@ -334,6 +334,8 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>>>    			return;
>>>    
>>>    		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
>>> +
>>> +		kfree(edid);
>>>    	} else
>>>    		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
>>>    }
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thanks. I don't seem to have a toolchain to get this to build... would
> you mind applying this, please?

Sure I'll handle this.

Thanks,
Neil

> 
> BR,
> Jani.
> 
> 

