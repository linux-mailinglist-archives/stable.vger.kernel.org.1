Return-Path: <stable+bounces-208245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99964D1731F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F55730049EF
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D96378D8E;
	Tue, 13 Jan 2026 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Udou5s5d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB02F6925
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291638; cv=none; b=ICrqIt/dxx0nRC8jcUH6tJGEWICf5okSgJBcsMD7t71qcEvyvrw0oAlI7IdnCTCGSAfBam1qEtExTsm+yFx8GO5YS+76l6ukdExx2g4zHMsfrWT8m6uFJw+bRHQgloBOnUxIBxJDLPgAzoPr0SGgFsZlJONMnst5b4MsAsQrq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291638; c=relaxed/simple;
	bh=75wHd6EOZMPUyl7JqABEH1fCiXhV9j0pIqZjrNZ6yec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzT4EsT8De5H8MrJ2DlU7Hbeknu2li6HW4LUc5HF3F4HhH2wjCsGQinjHloXxFkvd6cxyqNZwS1nwfuLdC+IlcWXJwqReI1U0f7/hDVAEukr9hCeHZUCR0k3lyfS3WKwEGi1JYeQMl7LqvxWLcFGFV8kKy0TbiRJkvkpY8OuMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Udou5s5d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432da746749so1927649f8f.0
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768291636; x=1768896436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kBiGdnwoKI9eDWcWQTGe4djU3SzpP0pSq/NoI+kjks=;
        b=Udou5s5duBa0+UxlyjxCMJq45t+mhx7vFxFSQ0ReBg22fCs8jswSO5cdn6tWxRFfkW
         jO9CYukcQzEPHUq16LW88r2z1c03bELxN7OJ8cUi5rZyuS0VAjL3DMkTa8lVVlwjsLir
         EOZQgPj0NSTE9OpmYM6RM+KvfYiKOKa2jXtyL1p1l3XMfp5JZSmZjgpvrlciXWC99V0I
         aFraajXAcfuEtqfhjBu32krXjagoASFSd3aEiZ6MyWdXY/Y7YHgvopWn9H8NC9H4yZhg
         0nPfPuF4ttAbZ5VGc6xhilabCcKCkaVRsrCcozv8eoQcjWb2vmyxsf7xc+tbK3LP0GC6
         fDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768291636; x=1768896436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kBiGdnwoKI9eDWcWQTGe4djU3SzpP0pSq/NoI+kjks=;
        b=m2BFVPqywu6iuD0ldJf2JL9inRXotl6vIEK+Ff2lVUbwLlxNo2HyES2QPBmryGYfb1
         JuIhV/ZLDtD0k2G31Ewpfa+twfZjKo3HAI+ZsBuHcuXEERTP9vgIzHTuWvxp6Rm0BS1Y
         Hc4uzY0c6v8FXTO67WS38aPP/Ul0ZrjiRVa8nMuWI+B0HzB66IRN0rDmHHHXdNEhh6RY
         S5z0s3TVjQ0LtENH+PSgoUEehjSOrSJz9vG8KY0m+HYt+5H8rzKpkQ+6ZSfp3kRlV1Ve
         oAl/2E14Rs4IFQskbxY269eZ2TS2+JEspybgIgTB13Psc5k89w6xRl8zgEN8rlpYPXgL
         mrYA==
X-Forwarded-Encrypted: i=1; AJvYcCV1TJj+OOV0dUSVPcd57d99cws2C7mVQdqupj/ty1GfPdQeAKqb/cbO44U1vwszx4PNbB5vXrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJarnpJwX/mET2it+VldlCWZmqbVyPbzTyYqK9AxbUXR5DWtaE
	VAXKdWwTo8fSlK/WYvdRRovcndMk5Twu8fd0W5mjTqjCixKKqfSFQJVoWV7sPRvIdRk=
X-Gm-Gg: AY/fxX6WscNTD3jVGbQbm5g9N1NJa94uHb/ZXmiJtIbbdXBgTHBui4VGAnqdfNk8E5s
	ygyUtUQea3eFWII8gsEiUmJaJonuFP2gGjunJFE/36RsUFNNF4NrxjdSsrGhnc3KNr2OInPAEDr
	WG9O3CsRGiF+xY9moLYGxV+bw0bWGlSbxHIj3Warfpgj6Yy9iq7oz5dQ/5n7yXHIHqaN0xX03aC
	3Gdg+rvhg4rO9rNXLxY9IHHx+hv4EeTANmtbtglnqnFCu96acJWZQAzHVCl/AI5avH9xmH0EVbe
	Y9OIK4LgcSags4ydsYHxaVq9We4/MO5/R8YQSONmRAGEFX5y1PCANQFpmNgHaI23VKTb7WvY9Is
	VEj/uJ1DhWsZZRzbh+NM2p+FtRUudipPnZrjcAOYOeKGkkunJlnugwE3//0jUSHf1C0tMm5Fbhy
	pKugtaaCCqFh94L4L3TOaqiWCNLi6XjWo1SbjewF1O4rvOat4YsA==
X-Google-Smtp-Source: AGHT+IG6fAtmI1EQMhuKQOIVw+wGIFjBkyZewLv2jXMLbnUnN9fabCWnKyTIrO9pUyyRVG2gO/7/VA==
X-Received: by 2002:a05:6000:178d:b0:432:8537:8592 with SMTP id ffacd0b85a97d-432c3628106mr24027748f8f.4.1768291635424;
        Tue, 13 Jan 2026 00:07:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768? ([2a01:e0a:3d9:2080::fa42:7768])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm41710261f8f.10.2026.01.13.00.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:07:14 -0800 (PST)
Message-ID: <2f18dda9-7163-44bf-a075-bdd46ac5cef8@linaro.org>
Date: Tue, 13 Jan 2026 09:07:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] phy: rockchip: inno-usb2: Fix a double free bug in
 rockchip_usb2phy_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, vkoul@kernel.org, kishon@kernel.org,
 heiko@sntech.de
Cc: linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20260109154626.2452034-1-vulab@iscas.ac.cn>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260109154626.2452034-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 16:46, Wentao Liang wrote:
> The for_each_available_child_of_node() calls of_node_put() to
> release child_np in each success loop. After breaking from the
> loop with the child_np has been released, the code will jump to
> the put_child label and will call the of_node_put() again if the
> devm_request_threaded_irq() fails. These cause a double free bug.
> 
> Fix by returning directly to avoid the duplicate of_node_put().
> 
> Fixes: ed2b5a8e6b98 ("phy: phy-rockchip-inno-usb2: support muxed interrupts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> ---
> Changes in v2:
> - Drop error jumping label.
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index b0f23690ec30..fe97a26297af 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1491,7 +1491,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>   						rphy);
>   		if (ret) {
>   			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
> -			goto put_child;
> +			return ret;
>   		}
>   	}
>   

Good catch !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

