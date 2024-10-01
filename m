Return-Path: <stable+bounces-78533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA898BF7F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063F2282298
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E91CB52C;
	Tue,  1 Oct 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eauVa5vB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4C1CB519
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791994; cv=none; b=USX+LLYez+U3wNepe5zVx0k5QiihtewkUj26Zs+hqCjB0DUqE1XD2M8aQOnAq+sejDk1WZeppc2FJ+k3M53eC9b7HI/72eXxtRAkCazwYxtfgNw/DAQ13kPf/lZqICnb2i8lYPUl2ucpZhR9Rn0rk43kOu95t2eF3TDQUBAOsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791994; c=relaxed/simple;
	bh=/YEyf3fUIoo/+arxTCsVqbKnfQ6XnGcMlQny5sPFMuc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HgFX8ao26vGpFIUSYclto10iBVH74GKc8D+Kf8h7EIhtWwcQZXQtf+yqAOCbjbVxP+zsWakG0/J6JEtWNWVDUsFN++dLHfYvMo6nIYQnI59SJ/rbnp9jwcpGDfWI20Fe/e52KeLj5ppaK+aZFrNXSG/BGeVKQVGga0epccIgQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eauVa5vB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so68613065e9.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727791991; x=1728396791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1Cx91VSztN2rJnet5B8fnphU+Ct26TY7sP7XUXBJAE=;
        b=eauVa5vBD0r2Q7P2Xi2DWjfPMb02bsgr3xrj5hH1H9LfdODCyrSk9R1nJ4SqUKq4TA
         nSaUKwF2lRO7q59tBf6hEztarPqULaEF5Ry9MXhk0XOh/tMH+RmI2c5DnnzXn9l8hkqK
         zIxfrvNGMMRRnNSKav0TY9z8KzlSCms9HtJxJr9mc6fdCRxLtdODryN34ynHv2ewaIB7
         x3JuY13iTf5nu7VorHfE8dNpGGgseO+vYeKa8kfCVnmlJuWN/mze85Gy2QO6AqXyq8vm
         DbyLEBA0l4N1Fx0g6tSo6ciSCuWx5xQPjwkM9HqtM/yzZQccjnbm9D1Vd8s89yvpmucl
         XGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791991; x=1728396791;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1Cx91VSztN2rJnet5B8fnphU+Ct26TY7sP7XUXBJAE=;
        b=vU41TQPRKR9ZThVu4S2FGXmmgZKXgGSKho2CZjq9AZiQyHzsEi6G3+5OKtNWCB5WcI
         p6tquB67G9apsrFKytJG5KepP5SRerjic+QzS368YTtfZ3VjzV5sxholvh68XzwULrai
         lccE2lQQDdagfJqk5viZb9GYuLtwoULvQhL/OtUrqtKgQttztHmutqb77Eq3R8qi/xj4
         Q98uml6Dr5bdvejMR0ds45p/AzSmdqF89JhFuAOVAdGkp/uOJOD2NOGUGg4C2AeNVe4h
         wBFEvDYcy4cjl+BRCJcTGxQjC6MaCm/yzuNzSwTB6Mxh4y0H2bRaoNp/Qe8ECgV6r4Fd
         FrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9cQYgt58fnmMwuUZ6pX7Ic2itnRh0dcGRL47/2yVy2L8CibR3Yoq6ehc4CAJNr9fsRdRsn0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmX4GyYTiz/SUo2SHsUhRyZfwiciMg5Ii1akajqV2msDA8ZvDW
	oIkKUlCANk9vK2sODH9Ai2FbzJGJOixZ4ye7f9rUn7ppOfVUd7Ss7r6AhxbCSZvypKq6cpY4C0b
	K
X-Google-Smtp-Source: AGHT+IEXiTdUkwq0hs5gvz7znC7eRTgwUSQ6YDYbQFzkPBe0ChNgj2UgohJe3Hnz52MtEpTmvXyI3A==
X-Received: by 2002:a05:600c:4751:b0:42c:de34:34d8 with SMTP id 5b1f17b1804b1-42f5849771fmr149867555e9.27.1727791990540;
        Tue, 01 Oct 2024 07:13:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9b2:9800:19f8:2888? ([2a01:e0a:982:cbb0:f9b2:9800:19f8:2888])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575de73sm11807180f8f.115.2024.10.01.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:13:10 -0700 (PDT)
Message-ID: <e050f066-7c35-463f-8c0d-9061f78e319b@linaro.org>
Date: Tue, 1 Oct 2024 16:13:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: panel: jd9365da-h3: Remove unused num_init_cmds
 structure member
To: Hugo Villeneuve <hugo@hugovil.com>, Jagan Teki <jagan@edgeble.ai>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240930170503.1324560-1-hugo@hugovil.com>
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
In-Reply-To: <20240930170503.1324560-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2024 19:05, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Now that the driver has been converted to use wrapped MIPI DCS functions,
> the num_init_cmds structure member is no longer needed, so remove it.
> 
> Fixes: 35583e129995 ("drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 44897e5218a6..45d09e6fa667 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -26,7 +26,6 @@ struct jadard_panel_desc {
>   	unsigned int lanes;
>   	enum mipi_dsi_pixel_format format;
>   	int (*init)(struct jadard *jadard);
> -	u32 num_init_cmds;
>   	bool lp11_before_reset;
>   	bool reset_before_power_off_vcioo;
>   	unsigned int vcioo_to_lp11_delay_ms;
> 
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

