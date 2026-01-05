Return-Path: <stable+bounces-204825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25ACCF4583
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06FF13009200
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288B2EC081;
	Mon,  5 Jan 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LphmDeQx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B22DC320
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625680; cv=none; b=PTCrJIt5kMl++jMK99OW6kh6osGMKC+pgsCq2ZLiji/jmHWJC/SRltti5LSWZowjwbA9t/hyqlCKAyA3Gvo+CxgY1N5Ft+WUy4TIKa+V+nz4a21NxhAOl1P0syhVocUR1oexQaUk2HXqbAYl0dj/XfX/zImiqtbmZ2P4Q/jRWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625680; c=relaxed/simple;
	bh=OV9Z1KUE5yeE2dXIw79nHbxNnn1GF3eh4qO1VR3wxi0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=leQUoI3868n8KheaTDzbvgZ3W/DiHyidjEIKDgRT0/jysjdV3XaKqDQIn0juhE00oTGYnv8yfBJ+3oZk13JiLsqu69mxKfa2XTpw6BQmUKilxOo3T4PVwyaQo8i5hh+/NJYqVpm8L1ykw+euNZWxtQ6HHJWlEDoQKHQvA1UuxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LphmDeQx; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so83085e9.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767625676; x=1768230476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJeP3umUUPJKCdZprAUZ1ZTfLiCOqec4hH3IqgMAE2k=;
        b=LphmDeQxjhzU/GQtoKhKwhGyDr1TlcsN+pLu4GxhMT1d3Nv0OC0w8FyiW4A80aFMKG
         YJMgA8B0XlZG8Q5EurogkddbmBd66pJB2bIa2c9mg4K8E1MfSouy1pTrVN8/+QxUTI9f
         ksQnfUUpw4uOdS4JPUAIG+Xudd2otNdWEjyFsiTrxbZO7GgZHNR1zl6Z0gHNdMXuTn92
         TYsLgRyR9oIcYwDbbmLyvrJb14FnElNdsVNRBKiLwxakvNf6WWFHETJAPlHK+75wmeVM
         E2pBpPvpaMZbuma/f8ZFnubh7dlOFfuuko/9zCFY69ISLYf3VCBAHnB8z71RQnxDt2jg
         pDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625676; x=1768230476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJeP3umUUPJKCdZprAUZ1ZTfLiCOqec4hH3IqgMAE2k=;
        b=euikDV8sNjVBAVtMoL3u+6bvw3ka9iW8h+tyMu7DNKt4KOVyvb6VkzelBNrmsJXZBX
         4Tu2Lly3Nl+m1R71EMEmp2gf1zyv8DnpH6fNpO33xZgO/bsP18F7e9t0ZnWhjAc1H9V5
         ROZwC0AdNPrPFWmcGDNZOzfNMUqVxMqhxSJohOjgf3kaHDdCVpe4+RUaVGOjMBc1JTJv
         lol4CyiyYKlwdyAj1ukZLJ/EMpXNpRuaXv31yeUGm+BPx0uAeNpUhxaOGmx2UYlicHMJ
         J7G4f2TW35qQLjnMRLbV46+LWA59XHFBUnAu3BbRzsEwVOHHrhYqrzTD2dEsvXApuy3Q
         o6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVrBw67hWCSozD4V0VtD2eOGI2GijUn5NlbJuw6LWdOWOlgGY+ZDnRF8Cq7tuCBE1wdcjGHQec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53ktxoScLgza9dNc0OdS82+qXIc1NclMy+eUezX8wkqh3cYFd
	e5IZBkEjqzYi0dkP/AXuersQx+l0XWcVc7z3zqnyCCANUqKWyX0/Ylu7q3WQrBBuD3E=
X-Gm-Gg: AY/fxX7eNn3q4QrOyTd6VRzPVU4sMW6E0UA+gJIloGfLch6gX/vmLvdoO1AoYeZxoId
	MA3wYB0pF4lfzOtOxPDgzMd7OFYGH7MNcoBcOb6qv+hb0s+3Ixy+2ZXFOjYRX8oaM8mrB4Dd22o
	/YbIj0tLOTxI+nTkp6aXg4ly+QRJvpSGFuCbJJBGleSj3KOKXXUFVUd8WnELhx5+p+FGbc2ywfz
	a3wSAb5AgqZDnv0SV/IMQEZKXjyO7DdJoqCGNgU8PE5KXrXEBJ/kTEkDU57a4WM3x1b2amUpsWc
	mTrmFn+7TRdBUPGEH9nMOXOwkNh2gU0gZNEmFGIhXSxP5D2OqYQQxdu+qGkCqh9jita66/Q7Vhf
	KBDSY8zja7znC3PO6uMNeQqjiqaF+Jp9Q5tA3QDOlLffwCeI6HVHHk5sSqU3i91zsgamEZO1XuE
	jPwr9+cII5gQSR16/AjUCJ3g3WXLJsBm/aScBY+uDZF09PBHsB81MxSxM4lj0HsXE=
X-Google-Smtp-Source: AGHT+IHNPKjsE1L43Mcol0BPhYCu+RrWOpaqpZKfNqq23wdaZg/I9TTFl/xgV8vj8QWVD5+5pya8pQ==
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d1954a128mr636773765e9.13.1767625675529;
        Mon, 05 Jan 2026 07:07:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033? ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7443c04csm35338465e9.1.2026.01.05.07.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:07:55 -0800 (PST)
Message-ID: <0a457882-1700-4edd-ba86-3682b05731f0@linaro.org>
Date: Mon, 5 Jan 2026 16:07:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pinctrl: meson: mark the GPIO controller as sleeping
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260105150509.56537-1-bartosz.golaszewski@oss.qualcomm.com>
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
In-Reply-To: <20260105150509.56537-1-bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 16:05, Bartosz Golaszewski wrote:
> The GPIO controller is configured as non-sleeping but it uses generic
> pinctrl helpers which use a mutex for synchronization.
> 
> This can cause the following lockdep splat with shared GPIOs enabled on
> boards which have multiple devices using the same GPIO:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:591
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 142, name:
> kworker/u25:3
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 46379
> hardirqs last  enabled at (46379): [<ffff8000813acb24>]
> _raw_spin_unlock_irqrestore+0x74/0x78
> hardirqs last disabled at (46378): [<ffff8000813abf38>]
> _raw_spin_lock_irqsave+0x84/0x88
> softirqs last  enabled at (46330): [<ffff8000800c71b4>]
> handle_softirqs+0x4c4/0x4dc
> softirqs last disabled at (46295): [<ffff800080010674>]
> __do_softirq+0x14/0x20
> CPU: 1 UID: 0 PID: 142 Comm: kworker/u25:3 Tainted: G C
> 6.19.0-rc4-next-20260105+ #11963 PREEMPT
> Tainted: [C]=CRAP
> Hardware name: Khadas VIM3 (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>    show_stack+0x18/0x24 (C)
>    dump_stack_lvl+0x90/0xd0
>    dump_stack+0x18/0x24
>    __might_resched+0x144/0x248
>    __might_sleep+0x48/0x98
>    __mutex_lock+0x5c/0x894
>    mutex_lock_nested+0x24/0x30
>    pinctrl_get_device_gpio_range+0x44/0x128
>    pinctrl_gpio_set_config+0x40/0xdc
>    gpiochip_generic_config+0x28/0x3c
>    gpio_do_set_config+0xa8/0x194
>    gpiod_set_config+0x34/0xfc
>    gpio_shared_proxy_set_config+0x6c/0xfc [gpio_shared_proxy]
>    gpio_do_set_config+0xa8/0x194
>    gpiod_set_transitory+0x4c/0xf0
>    gpiod_configure_flags+0xa4/0x480
>    gpiod_find_and_request+0x1a0/0x574
>    gpiod_get_index+0x58/0x84
>    devm_gpiod_get_index+0x20/0xb4
>    devm_gpiod_get+0x18/0x24
>    mmc_pwrseq_emmc_probe+0x40/0xb8
>    platform_probe+0x5c/0xac
>    really_probe+0xbc/0x298
>    __driver_probe_device+0x78/0x12c
>    driver_probe_device+0xdc/0x164
>    __device_attach_driver+0xb8/0x138
>    bus_for_each_drv+0x80/0xdc
>    __device_attach+0xa8/0x1b0
> 
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> Cc: stable@vger.kernel.org
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/00107523-7737-4b92-a785-14ce4e93b8cb@samsung.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 18295b15ecd9..4507dc8b5563 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -619,7 +619,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
>   	pc->chip.set = meson_gpio_set;
>   	pc->chip.base = -1;
>   	pc->chip.ngpio = pc->data->num_pins;
> -	pc->chip.can_sleep = false;
> +	pc->chip.can_sleep = true;
>   
>   	ret = gpiochip_add_data(&pc->chip, pc);
>   	if (ret) {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

