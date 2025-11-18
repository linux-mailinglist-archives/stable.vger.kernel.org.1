Return-Path: <stable+bounces-195082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D91C686EF
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92B7F4E2125
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689982F39AD;
	Tue, 18 Nov 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8HvqEFj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3732571BD
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456965; cv=none; b=a+cMxYYcj7/X+uBpgkRHaPz8N1J3OxYu6kKcLg8er/4Mo9FLofgigCW8gZU87nTQBP0k15DQzx5fKnQuqzVZ2/LO+whEK73oOQTdtGI+SVbGAcEFNMo7/RSgbEcI9/fR5H0B9QVzk+I+J59gXKQz7Ma1CjKlfLijyNdLaIx6Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456965; c=relaxed/simple;
	bh=KStui9ZnJbovpsb3ngD0DxgyPevQ2vMiSRxvbuLxZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvlNMsElOeikdlqVzL4FbSyPjmCcyz77iVpWklLe/UL/IL5cEFtFrmI6FKq8OK+g888uKhYP8K6wj31Dzzdm6jJF0roDkIIM15Hrykk0jfV3TvvLZ6pp0l0jt/0srQDMDEMBnNljvLNCdeO2yrV9yk63yQ5QMcFJHiHdI6ZgKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8HvqEFj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a1c28778so25082225e9.3
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 01:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763456962; x=1764061762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oIfItUat9PClJ/7841Lk0/EAWLm0Y5CqmDrv2Vv/oI=;
        b=K8HvqEFjwynzXqkfjql1S0uwmMDGIdNxQw4TD9G8RBWRQLR0ffO+i631OgAbZmzS6o
         qltJ6vrpqTG4Dr3j0jWU1xePB4EYQ7+h9kXFMQJd+LJ3+bn29yEUa0nOGJAQiGo0tewJ
         ZnlSzvta8/ABD7fFidAlf8l+TsKaOtm4hPDUZwsZaMlXhs4bC82nvIjvJPbkPFrFGYGq
         GSALFEKTwXmJrKPtF5uWl6RsivbYju6lhHS8GaAEm1dsjQ4U/XvYUHcoIKIKQOjEqTRX
         oR6sDtpo4L25Eu6H+Jm+T1yoc6b+YmnC7LnxMTwtfzmLxBO1lr3qav/SrvwtiHZkYkCn
         yM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456962; x=1764061762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oIfItUat9PClJ/7841Lk0/EAWLm0Y5CqmDrv2Vv/oI=;
        b=FLgre39BSU8srVPKCK8ASd3jhCRUXWOD5AxeyiZJFMSLCTcltYo16/tcQoCESIqt1A
         cIQglbWbj4AJsX+/uHGbyVgm71nblaEpRVoH5UWWOieRv8cU0QpoaQkAGT+COLW7cRYd
         v+A24LD9/tyD/DvsLR3KVTEwaxnjmkX8QB+ZhOqSJdqEURGqu8U7bIPFAt2hsnTWz4W9
         sRTkgzYpq5WfkVR0e5KN8BoX1vJnVsq6IKFSd2w69nMSxToLVDZlrGmFDihUIs9xExnN
         ZrfNhkepvyyChojedhUdRAwNz/b9gjP5z+C0Es5z5zUkhjSu3ABi4M+onVmKZAy8gvS2
         tV8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQJRzK+PUNtZcsiAIYh5bu/f0QpmIEEfgAfMVYGnHJqCOia9E+Is/DWz7O9UpCV7ADJCK/pyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhqbjyqh2ud4BQaHpJZuvRCd7VWih6DwI9FIxMFRcLz9P7uPSD
	f+0nwv0Jflz/4oHKP1juVAGrx3XHeFwdKLuO5ftGU+j8HTlQ0H6xz+varglvQbRNcEg=
X-Gm-Gg: ASbGncu2qFovqqi50qB5FtH6SplzhzOH/6ilXUOGF/dn7hE91006HC2388cMGOfpDRb
	fmdbyERXy7Su7laiTz8SPVxii22qCCdK15VT4HuzvvpnzZwHoHI9VAI4gA9Anq6+as5wRRdroMI
	9drG4/7i15DpAxdjww/xUgii3aNoQA54/fcWr4ICEHehNCpOODncxCVZ2PVIYpEIMKEzBuvHdMM
	eTjL0nqHLyhp4TuWbjI8lCAPGKL6bgtGfuR8nJhQKDR3XNISCxkvB405KE7VSRnhnXIDxadozxc
	ajVXEXdH5kyREAQEhyMjju5w2DreH8KX/lRks7c+9VDadLfFAZ+zJz26B3ptqZn0/qu5r035S+Z
	ZI5JPbPfZPwbJmL7KRMQyBTC1O4aMMVOJ55Eo8u4Tgmvby1VIa8UssZ/YZAWKH0MBTcUAS29Exi
	kVm1nHws8LJT3uBf1Dhsgw4+lXflBoSZM/5EuhyHLST5P3OWrAgc1WpVgMqEXR8HA=
X-Google-Smtp-Source: AGHT+IHc8ApN7ctjZzzYbFA8HW7vBukVzWPj5prvx9bmeaSfL0r9Voscu8eVE4UTNA+dfltTKtHYaw==
X-Received: by 2002:a05:600c:354b:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4778fea1239mr167868515e9.27.1763456961571;
        Tue, 18 Nov 2025 01:09:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:366e:5264:fffe:1c49? ([2a01:e0a:3d9:2080:366e:5264:fffe:1c49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9741cbfsm13033615e9.6.2025.11.18.01.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 01:09:21 -0800 (PST)
Message-ID: <8d34bc6b-77e1-487e-af2f-fba99ab867ac@linaro.org>
Date: Tue, 18 Nov 2025 10:09:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] phy: HiSilicon: Fix error handling in
 hi3670_pcie_get_resources_from_pcie
To: Ma Ke <make24@iscas.ac.cn>, vkoul@kernel.org, kishon@kernel.org,
 andriy.shevchenko@linux.intel.com, mchehab+huawei@kernel.org, mani@kernel.org
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251117010227.17238-1-make24@iscas.ac.cn>
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
In-Reply-To: <20251117010227.17238-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 02:02, Ma Ke wrote:
> In hi3670_pcie_get_resources_from_pcie(), the reference obtained via
> bus_find_device_by_of_node() is never released with put_device(). Each
> call to this function increments the reference count of the PCIe
> device without decrementing it, preventing proper device cleanup. And
> the device node obtained via of_get_child_by_name() is never released
> with of_node_put(). This could cause a leak of the node reference.
> 
> Add proper resource cleanup using goto labels to ensure all acquired
> references are released before function return, regardless of the exit
> path.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch for the warning that variable 'ret' is set but not used.
> ---
>   drivers/phy/hisilicon/phy-hi3670-pcie.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
> index dbc7dcce682b..9960c9da9b4a 100644
> --- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
> +++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
> @@ -560,7 +560,8 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
>   {
>   	struct device_node *pcie_port;
>   	struct device *dev = phy->dev;
> -	struct device *pcie_dev;
> +	struct device *pcie_dev = NULL;
> +	int ret = 0;
>   
>   	pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
>   	if (!pcie_port) {
> @@ -572,7 +573,8 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
>   	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
>   	if (!pcie_dev) {
>   		dev_err(dev, "Didn't find pcie device\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_put_node;
>   	}
>   
>   	/*
> @@ -586,10 +588,15 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
>   	phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
>   	if (!phy->apb) {
>   		dev_err(dev, "Failed to get APB regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_put_device;
>   	}
>   
> -	return 0;
> +out_put_device:
> +	put_device(pcie_dev);
> +out_put_node:
> +	of_node_put(pcie_port);
> +	return ret;
>   }
>   
>   static int kirin_pcie_clk_ctrl(struct hi3670_pcie_phy *phy, bool enable)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

