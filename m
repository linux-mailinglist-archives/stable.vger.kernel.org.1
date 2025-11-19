Return-Path: <stable+bounces-195185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3360C6FA2D
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E13651CF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70DC34844F;
	Wed, 19 Nov 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbjwLgya"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1752C15AE
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564853; cv=none; b=iQqNmXdoeqz/wvAoG3SXH3vlqXZ5t+4qf3YdZm0MWW1vD9Xw4QCWGpp9g5OxtnN6x7G9TxreU5QMo84YMz9e5F903KoBed3rYrgxhD32F+YJxGebQ7Yj9iT8b40gshJHgrwl/jH40Qc4qdoFGwdD3t3VsjlmxA0O/tv39sZtQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564853; c=relaxed/simple;
	bh=zQGn2TBEg53bLFqIRWcH3TNqoIVQRmjshIxUlHg5MAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkOALcTEu6EEHyBPsF6tQKrVcqX2ZFjRUiShMkq/8mQBKWKsD3z9AaIgdS6NN9ykk3P5U+5xqJ9Ei8WoBP2MIvH6LaHQZWvTl/8RE2Qq6GXSjLO6lrZnfe1pZwJuF5W6N67je4VheNfSL68qlwKn5aGUDeQXxPM8qI0udJl8yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbjwLgya; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so5512249f8f.2
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763564850; x=1764169650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8MXHRVY48CutCxVOD2Cd8MderTR1vjNZQmBDMhIq4I=;
        b=lbjwLgyai4O3FlycwQXd9TqAoFjcsAixVhJWm7Tw3H6SVtXX4Rf/JkNSIFnlbBwMbW
         fdA/Hn88qPYOcMREaxDWeAlEFzYZXF8IRiNSXB3MiR3cvnDgFmqFStPl3N7fmC5fOLNV
         Rc/IfE4Y2ahk3y8O+7+ItMCa274GAxEukWmac30C5y0T1gY66bjFcZ0dKPt1NgqKFx6k
         5KEDAVvKq5+eLO3pudZW2dwFbxpgjk/yqhFi42Xk09PXgIZ85+AO6mBUIZfCL1xqXtH3
         0nLks7qtFP/WpIBAt2kID5V47WHWHVOp2RJefhVwOVvVTCNIOWALoSQpXTVNi/+Ne2IA
         Neqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763564850; x=1764169650;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8MXHRVY48CutCxVOD2Cd8MderTR1vjNZQmBDMhIq4I=;
        b=CfUj9PnH8+3yqbGhMXAWTrSklR0bHJ0HLpawS8zQO7/n1448Seefx8YYsoEP2+x9wn
         D79ZqOKSsA7bAPPhGrV5sMGXWzCQVQhGJhO6NDk+woZUV6FlGzRdnBpFDC+U0Rp5ciAJ
         9pfMBWsOv/7Hg4xPmyuQE6tLZ+yephKej2Hq9PV0ebUg8x5EXsyNhd/C4qopug0p50Cm
         mRTn5vopnd1pyMovomBoVnxKNgtHLQvJfGKjqGIFoVXD4wZaYAlIHhdQLLnL6YwPxQpV
         FrHeIg8kfIdMsl0z5ajuOdNpN/L2ULnDR9Ra/k1peu4kjbyBPwissNhwZk4zdLTxdHkL
         yhpw==
X-Forwarded-Encrypted: i=1; AJvYcCU7uLCB2CKeH+0gsqTMT+vuXnXfTqDBSDrS+N10N2tRQOXtCbCeiDMwn/YTneL3pWVtCsjom1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrBCKVTsRCnXrOT503NW3muWmm4v1pLBSqqWDS8/IyQsFFjDy
	IMZM1u6kGUQr3DwHDBbrvTNgPBZWXQZtmt64bosR7s79Fv2EV7sQZrZt2M9WQDVPd5A=
X-Gm-Gg: ASbGncv451bgMTjrF3VaWqvQGBNWAZnkZn124yjD95Efi0+y7akxIaNZqK9giGWhchk
	ww05PTP64uoXOY/xdDvPHTTRBBNfg/LMXTX7mhVZJbxIQwCHhiZceZJl2IVqdZaJMr8HGZjwFEY
	vnmYVZxg/6elOn5q5yK6Q8EUcGazrBQ4s3WmvUncEGRd0l51b2kB8ugkfZp2pFYLIJUShwfiwDt
	NX+J/GP0zDle1sqb0GLFL+iwLVYCQpmP9y5y+k4W896iqZXfi/0VSnM3cpKj2fVG4fq3z0mQPve
	eABw/kURUmMosGk1y+KytW6OCQXJYFNnuZ8FZ0sk/sihe8JUx1XeEJWB5ekunAhIEawE1qwTKlS
	ggXkrVnKdz+D9Vu4wiRP1dh2gxYDYf3PiP4tsE42POMkYIOzeLiUfYnq5e1Fla+ehoqPtSeln8H
	b5qdoLVtX5h3tLOZe1iaWD9Raw1HrTPwfdIAEp4AJLZFmwCZN7BzgEfxEEdCYbF58=
X-Google-Smtp-Source: AGHT+IHdI5AOlmNDX5m4IHoZ74FO5t2segG/koratGEOW9qb5av5beCTKzXqT4NvIhC8HV6z9TOzRg==
X-Received: by 2002:a05:6000:2010:b0:42b:55a1:214f with SMTP id ffacd0b85a97d-42b59340d6dmr20687485f8f.21.1763564849819;
        Wed, 19 Nov 2025 07:07:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:263d:925b:a11f:ae36? ([2a01:e0a:3d9:2080:263d:925b:a11f:ae36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm39622909f8f.19.2025.11.19.07.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 07:07:29 -0800 (PST)
Message-ID: <461244a1-3bc1-478f-b97f-b0607375e596@linaro.org>
Date: Wed, 19 Nov 2025 16:07:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: broadcom: bcm63xx-usbh: fix section mismatches
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>
References: <20251017054537.6884-1-johan@kernel.org>
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
In-Reply-To: <20251017054537.6884-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 07:45, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function and match table must not live in init.
> 
> Fixes: 783f6d3dcf35 ("phy: bcm63xx-usbh: Add BCM63xx USBH driver")
> Cc: stable@vger.kernel.org	# 5.9
> Cc: Álvaro Fernández Rojas <noltari@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/phy/broadcom/phy-bcm63xx-usbh.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> index 647644de041b..29fd6791bae6 100644
> --- a/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> +++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> @@ -375,7 +375,7 @@ static struct phy *bcm63xx_usbh_phy_xlate(struct device *dev,
>   	return of_phy_simple_xlate(dev, args);
>   }
>   
> -static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
> +static int bcm63xx_usbh_phy_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct bcm63xx_usbh_phy	*usbh;
> @@ -432,7 +432,7 @@ static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
> +static const struct of_device_id bcm63xx_usbh_phy_ids[] = {
>   	{ .compatible = "brcm,bcm6318-usbh-phy", .data = &usbh_bcm6318 },
>   	{ .compatible = "brcm,bcm6328-usbh-phy", .data = &usbh_bcm6328 },
>   	{ .compatible = "brcm,bcm6358-usbh-phy", .data = &usbh_bcm6358 },
> @@ -443,7 +443,7 @@ static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
>   };
>   MODULE_DEVICE_TABLE(of, bcm63xx_usbh_phy_ids);
>   
> -static struct platform_driver bcm63xx_usbh_phy_driver __refdata = {
> +static struct platform_driver bcm63xx_usbh_phy_driver = {
>   	.driver	= {
>   		.name = "bcm63xx-usbh-phy",
>   		.of_match_table = bcm63xx_usbh_phy_ids,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

