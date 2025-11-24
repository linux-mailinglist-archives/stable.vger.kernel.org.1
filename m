Return-Path: <stable+bounces-196672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08057C7FF01
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A96A3A878B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D302F4A00;
	Mon, 24 Nov 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev55sLRo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F72ED846
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980545; cv=none; b=gA1cNAOhFXpvwpaSXCBtMExrDhF2tc6v0Qun1e2x9jXja7gFUi7vUeVXgL3+o4IsyHVY1LG23AusLqk22bvfb1M+GZQJlp065gENEBD76NTOPvup4AFyk5somB6kBaDmhI8KjAl7xF+DAbAm63JAF5JGNKK6cAGq77pqffn8yG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980545; c=relaxed/simple;
	bh=6OTESRwNLxScQU78nE0ggduh/VNF1NB1gn02JAFvRw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl7ktHJz6PaxoWjNLZJBzwdSFtoXG95uA/omLOE88cITK+dFnu6+XTjBEzE8ttn8AK9pUm5qnwOhcBfsPQhyuvf2NVM1MCwp1FkSc44yJZr9rTQxSrknJlW/3oc3Rw6+LfzKXr6NAjH8BkWSqUJenDJHk1K2RdesLwFGPCBLPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ev55sLRo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755de027eso21552765e9.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 02:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763980542; x=1764585342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAIKS+tQIq5G6QZu607XSH9VxwKXNkvRuOzR0ldY0uA=;
        b=ev55sLRoYF56iaaiQzkmZIxhxlMccVSU4h0wQ4Dw1z66tFRDX5ljPUIlu+ouV9pWKm
         ycP9hLl8y1h9deOAdQgFDVpNhjhWRyfdCYBdGEHwCe74ZQO4S2VvDuMiIc5n6EsPZvO8
         0HuPdrXJlnt9mkDcWQsMiy+tZzXM/x3OUEWyfTbSwSqCvCMxyeAIXwODDFL9WB0ae9OH
         9FTMFgQCZrYoA6+Y1Z4rBcCeXkV/UnD//YFBFfXQUZmxCzgSZ+QJXMXv1SHFiQt6wxYO
         2Z0LvH3IC7usDlq7KjkBX7Ky2wYHLbBdGU7ILRepIKJQ4KbSPb7cAkl6iLDa2/Ym+zLM
         F3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980542; x=1764585342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAIKS+tQIq5G6QZu607XSH9VxwKXNkvRuOzR0ldY0uA=;
        b=TUbihMWKlf5LvmALDKzLOgucq72WFbwzXlyExFIWG+hCG89IOIjUxIRdFBv/h1SK4w
         zWmjx/3mWtwrDJpBwHUBNYeYU7GVOQD7d1yIrGgO4aKirKCFjozYVABqU9waLEMlZkLr
         aAvNNZDNHHIb7SGoHr16kZImxMud4pLeKv5TYTDW3QXtOctm1/l8nJKkLq7Cf5QYcrO8
         H+R579HzLoz7jua4tehu/WtRGjiirlwSe2831R8CS62lhXwBuhVdIT1+/JGtR2mn0PNG
         geJMLHur/tZNySzLe8ymISiwZN0+jqvyzVBrDyW45v4bua07l0B3Qvi25zev4h2ZtSVx
         soPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoheMeYqf7dK/8F6yCqPO733Pn7ycshoZ1g0XA2pqwmm6bcUF1KSl8B5hnZ8VVPAI8dX9adUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5YFAsm3DKAsrOQOr/iCR9Dj5JDWV7fdJaaMbmb7rlhxgEHBb
	W6XyaF3jGM+pYafB0AFOiihtU8yEsJCtc5VrTLn4VSmx6l1YVPkPKzmjVx9lMOv/Uxw=
X-Gm-Gg: ASbGncvBRd4PVx7bqJhUIfT9AICghpPaI5L90Xh7UeATAgUTndSXKmCmK82+brfu8Lj
	D0aMp3dfT08GIRd1xOUNU29X6nAJ4Rw7/cAzS2668IO9PzDDBnckh/0IltRkOkaIjg+v3+oUpCd
	TawO5+JU/fz7Rgu7MgQS0bjCQUFNUdFCo9FV6U9duooN8naHte5uueWKYsA1oSzaMFHN3lLavvG
	B3A3nBnKTQGb8mDGz57Z/MGpKklePC26RbK8l56/Rrdqwy7DbKhCByo7wdiyg1TxZfSpIM26vSd
	+ql7IwOyVWWIvzwI1kNBFfqYPz8w085JZoo/HuCg94ySYIVsM8DOQXMRX9i77X7CoPPSIPN6tMQ
	iZuK7Og9bP9qRpyRs56TfTueoA1RGhS2TyT7PXh0k8+h6zvpL2a9K+fqL5D0dZ5R09ayGYmKNyg
	sAleV35O52NB0AE38rXHDWRY4BZTG0QMQhZnOUjgn6UKsvuVyqjDpcK/2jBjGa23+Y0vFYujNaC
	w==
X-Google-Smtp-Source: AGHT+IHGv4bbS+3bVyw0pYcsA3BeS6dNhxGlltqoLwAE51qnNbKpUpuxJhUkaEhMz5T/wEJo8trcPQ==
X-Received: by 2002:a05:600c:a01:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-477c01f5980mr97488605e9.33.1763980542060;
        Mon, 24 Nov 2025 02:35:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:ab13:96f5:1459:8396? ([2a01:e0a:3d9:2080:ab13:96f5:1459:8396])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dbec2bsm150012445e9.5.2025.11.24.02.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 02:35:41 -0800 (PST)
Message-ID: <1d0ccc76-bc19-4446-926f-a12a16a3f88e@linaro.org>
Date: Mon, 24 Nov 2025 11:35:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] phy: fsl-imx8mq-usb: fix typec orientation switch when
 built as module
To: Franz Schnyder <fra.schnyder@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
 linux-phy@lists.infradead.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
References: <20251124095006.588735-1-fra.schnyder@gmail.com>
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
In-Reply-To: <20251124095006.588735-1-fra.schnyder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 10:50, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> Currently, the PHY only registers the typec orientation switch when it
> is built in. If the typec driver is built as a module, the switch
> registration is skipped due to the preprocessor condition, causing
> orientation detection to fail.
> 
> This patch replaces the preprocessor condition so that the orientation
> switch is correctly registered for both built-in and module builds.
> 
> Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> Cc: stable@vger.kernel.org
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> ---
>   drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index b94f242420fc..d498a6b7234b 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -124,7 +124,7 @@ struct imx8mq_usb_phy {
>   static void tca_blk_orientation_set(struct tca_blk *tca,
>   				enum typec_orientation orientation);
>   
> -#ifdef CONFIG_TYPEC
> +#if IS_ENABLED(CONFIG_TYPEC)
>   
>   static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
>   				enum typec_orientation orientation)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

