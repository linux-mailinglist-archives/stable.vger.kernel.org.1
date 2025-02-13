Return-Path: <stable+bounces-116310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C7A34AB7
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813211895F54
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15B156C71;
	Thu, 13 Feb 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdk+fdDn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E51FFC75
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464941; cv=none; b=mdxs8DS25s+621m8doWUGog4uxYujadiMz9zaGOz3Lr2jGs1l3aqisovXR4DJM8GGvRHO8y/R83f6xKndDL0cUZbB4MS0NzxI1yc7xDAn+euPhtZIm80YB2fctd8RBjhtOD43Ny+OPTGRbwzh8YPZH2xlJRJxa7rdh3stAY6uU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464941; c=relaxed/simple;
	bh=cME7pm4g3G98JCd6zJ+yWsj0hF59QQ0tT2s7p4MsSqM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NnJwGvKOVUraKkvmZChHWBReLnBt9hV3rdCLRUnBQYthTd13GOldoDmCg/kGV/5rJEHCcc1uFzxaYrCv8UD9UDenKBM+XjyR+KVaXbYtNgNf8csg6KBsfMFG5GDuQR0Wj/IcDke7V5gMae7ZCubcQvwvGF+8EYTd2VbMJ8yhGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdk+fdDn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439585a067eso11748745e9.3
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464938; x=1740069738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3B83uWsYDmuTqDgqBDbXT/Rsks8AW0n9FN3+nFDl7Zg=;
        b=bdk+fdDnycTsYk6++ytOKYJ7onUWc6RYr760GzuZUlcWgVp2sa1pVjka/SCjw39xXq
         rn16BInkAwz2K5nKbcCn1TJzmYc400JUnRl3xdar+mBMU+c2KWEXM6EL2NdEOQIhZRhg
         TbARELI8zbZurRny6juKInI++Ob5BTNSkRcjzasehtjWx6c1WDe92IL79+M1KD7e7bt3
         OZXL9bkTpLiWeiLQPz9WxyzBuRrJiAraih1s6Wri3XHyxsUBOsuT8x5MAtoXcn5zljjJ
         9fYJwW+undcze+97cee9Aep6HUet70+nfWCTNKMsroG6+l05lBImkHjoNe1u4RCk20a0
         iVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464938; x=1740069738;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3B83uWsYDmuTqDgqBDbXT/Rsks8AW0n9FN3+nFDl7Zg=;
        b=aG9XB6nN2jqmGPswY4ExSkOgewGXJNGA60/N9GGT2p36Jxh1a6OE2cNWiYR+CF7uIF
         3Li50iu5RjIcvghzbZzlYj4q7xInqN2UWs4Bz3t1rft9MFOriTrf48ntg8wamwtLQzj+
         Q7yJEiZL6KEYdqMqgtc8euyKUPcHNispCaRjUtER2Qa7bn2BWVcnCdfmDhNEW5NdvrIh
         CP0qrr1JoWxcfYPw+vnf45+gp1+faQRIIA1W11FfC+jALQvbbCNbH5UtOtFA+PiiEGlr
         qAw2ZeCcLzfccDrPuOTg1XJBoKT+bIH7wxbsKX7sqTiuxrtrbuylw7ExSe6zKT0vMHGa
         +f/w==
X-Forwarded-Encrypted: i=1; AJvYcCWRAfVphVXwttrCSvQ5lLfsTJXn+pIjQ5OJ7VJBal0SZdaI5GMCQYWe0tqmjkNJZhc3RtWwGNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXNeWB7Ri1YGP/08wne8XJ0TdNbXqApG/RxFE6D68kxZMgwJp
	kZ6tykNdzxdCt9+1YdPdfkC4T2iJ4O5Yc/qJzggDi5TrjRYiI2RF5FkBr8Yxqj4=
X-Gm-Gg: ASbGncul2UxVPU3IbdbQXHVwibSmkdnO6ZBPQz35S4ka1bxxd04O+yN6cuxXRk2+rYg
	U/CfIcCQtjto5lTJJjD29RunH4tiytOUeykH09rtHFNj7EkA2FjtA4ucvAqNtImhyTsWMZmHvUe
	vBpQX0pRtKtPmyHduVKXJlJBWTdld64RaXgwV/vmbwm6H4ohwsc8KSOijm/PXYvTwvQnvqmYNV1
	TgWXm9AOCewMbCMdGgLwSQwrPm5SvWmlompcSpnim/AJ7a+7W0ctm0m29odOO7nVNDFRkpfb29c
	Bsvyl+UX5uJluMT5IVixCkxRaIcCfIEZZfZEwbgI02QtqEI8OjSnG/s9lYqPXHcZxMKs
X-Google-Smtp-Source: AGHT+IGy49IVyutPXQwSKvUdWc6ERgob1wg64K135om5hnsDIAMQ2/W3BtPEa3E3wnb4zSvKvNly1A==
X-Received: by 2002:a05:600c:2d54:b0:439:608b:c4ad with SMTP id 5b1f17b1804b1-439608bc717mr43429795e9.3.1739464937620;
        Thu, 13 Feb 2025 08:42:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b065:478c:3f8f:ac1b? ([2a01:e0a:982:cbb0:b065:478c:3f8f:ac1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617ffa28sm22112085e9.14.2025.02.13.08.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:42:17 -0800 (PST)
Message-ID: <f2ab3542-3463-4df0-96f0-cad41c1fcf3d@linaro.org>
Date: Thu, 13 Feb 2025 17:42:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
To: Linus Walleij <linus.walleij@linaro.org>,
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Jagan Teki <jagan@edgeble.ai>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240927135306.857617-1-hugo@hugovil.com>
 <f9b0cc53-00ae-4390-9ff9-1dac0c0804ba@linaro.org>
 <20240930110537.dbbd51824c2bb68506e2f678@hugovil.com>
 <16bd6bc2-8f10-4b99-9903-6e9f0f8778d8@linaro.org>
 <20250204124615.4d7a308633a15fc17b2215cb@hugovil.com>
 <CACRpkda+jac_7KKQDs3UcfODP6kK3W03Q3KtVOCjRV+wo=M8=g@mail.gmail.com>
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
In-Reply-To: <CACRpkda+jac_7KKQDs3UcfODP6kK3W03Q3KtVOCjRV+wo=M8=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/02/2025 12:42, Linus Walleij wrote:
> On Tue, Feb 4, 2025 at 6:46 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
>> On Mon, 30 Sep 2024 18:24:44 +0200
>> neil.armstrong@linaro.org wrote:
> 
>>> OK then:
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Hi Neil,
>> it seems this patch was never applied/picked-up?
> 
> We have some soft rule that the reviewer and committer should be
> two different people. So if I do this:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think Neil will apply it.

Yeah sorry I got very busy recently and forgot about it.

Sorry about that, applying it now to fixes.

Neil

> 
> Yours,
> Linus Walleij


