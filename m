Return-Path: <stable+bounces-89400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5789B7A81
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 13:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2791F24E2A
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4150619CC31;
	Thu, 31 Oct 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hf6A/JPz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AC14831D
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377771; cv=none; b=Lrvyl2q86Mfrv4HYQETbbUV5rjjyMBkFQvUZSHuPsR5wYBJ1w7XISU9FIJ9qagnjhSmqdYBkA8X2+VqeVea1IWuPTph0eUXIi96ZG46Xez5puDn1YNn6rA3otvCUfqaWQj+iybcXrRtwaZ1Fb0glu01uKpRUN+qgSq0XEjBZSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377771; c=relaxed/simple;
	bh=icFn/ulmOaFGaIVeWNkZxZlfkklmMO8RAk9Xs+6yFBM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C7w2GuvjnMLhg7nOSyk3peLBRv9fOmSP9vsM3nwq0FuDT1JNuxUbvXUtMXsIuw1tDf3O6ul9Qs7sX+4A9o0DMw8fk1b5S5t1/YmieXHqIHZ56QMaaDnpU0axnVfD40yk7rhg661iipZzpFIqzUhXh4B73Sdzev8C0OVlX1q2lJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hf6A/JPz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so6919885e9.2
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730377765; x=1730982565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQjZxBSmS0nagomVi07puYwXxun+vOekud8EvxwhAn4=;
        b=hf6A/JPzu2SyBKZNiqKXUBqLG6fWpNyRgFracSIsEvYghjT7GTcz6oSQzl2T0mUJSt
         vgm0zvc3b7qLstyXGuXgIV57Ff2thkZIoD8eUKQR1Qi6VvaH1bUfNC2mTa+M97l22Ucv
         SIVLm7qojw4JZy4rkoBT1CMt7+c8wRCTI36DnTANVUvWOZCB9UQ/C0kVj+GtWT6RR4RZ
         ldE/Tzn6G5lZQbSoHFK7n0OKZ6UYDcsqpDru51878UGjVegGbKaTM1sybMNBp6hnifnw
         W35QUmU7PaDvBYTusxz21TlHhX47I3mWLwy61MNNbIBqdhyHtTFNv+7zratq+x09Ipke
         Ww0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377765; x=1730982565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UQjZxBSmS0nagomVi07puYwXxun+vOekud8EvxwhAn4=;
        b=n0Pj0QRpn2QrM57vG/yAkeIcgisAsfZHMFLFScMxviuqHmUoXKE2JXIwT1GOuJ0R4F
         SOg770g/IzCZn1Etnu7HGjagat2B+9HBCi77opXyHQ7Jjff0cPXjNSRBeq9Sps+ql5ng
         hT4zza/tzx3bWXUX0imHGfGEs7bI9bysO3usSSiKI8tWa4SBhHFILMseU+FJozpcv8g9
         5MUJT/gjCoreAc72fJTEs3hNAILrlDAOJAAkiTyO9UcoMuZTpnTyHiuKTwg/5rjKTj7p
         cjnjRCItW+M/ZuTlwHrsrgEa7H1klHV08YiQN/IwMh41NIvBLOXHMCA5TG/JmjEBUioN
         ck9g==
X-Forwarded-Encrypted: i=1; AJvYcCV02rqr+XbaQP771cSvcpcwSzGVkTZmS4J1kTMUC8PprenlTgh0rescOWMsvazVNmkyEJrU2Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1Jt+3WizlVmfHTC6JlnQPC9HNk5GlZJ5LlEStaw+/GIzOiAC
	YBlCwv+8Rk1VlqiDT6PJY0qY2R/96lM5eRUO+IkZyeU/BKgIFe50Gisiy6uTvTo=
X-Google-Smtp-Source: AGHT+IGV3ikK4LIVn2AEbWDsvCMNTGZrNaaz9Bv2gNUYQPFFcoac/gExNqwApmsNW+NykCyyZ64SOA==
X-Received: by 2002:a05:600c:a01:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-431bb984e8cmr62424155e9.8.1730377765149;
        Thu, 31 Oct 2024 05:29:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514? ([2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm24596425e9.7.2024.10.31.05.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 05:29:24 -0700 (PDT)
Message-ID: <eb0c7296-ed5d-4bf3-8fab-130216a6d87b@linaro.org>
Date: Thu, 31 Oct 2024 13:29:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
 <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>
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
In-Reply-To: <f2119a4d-7ba3-4f11-91d7-54aac51ef950@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2024 17:45, Sui Jingfeng wrote:
> Hi,
> 
> On 2024/10/18 23:43, Dmitry Baryshkov wrote:
>> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
>>> The assignment of the of_node to the aux bridge needs to mark the
>>> of_node as reused as well, otherwise resource providers like pinctrl will
>>> report a gpio as already requested by a different device when both pinconf
>>> and gpios property are present.
>>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>>
>>> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
>>> Cc: stable@vger.kernel.org      # 6.8
>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>> Changes in v2:
>>> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
>>> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
>>> - Added Fixes tag and cc'ed stable
>>> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
>>> ---
>>>   drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 
> Technically speaking, your driver just move the burden to its caller.
> Because this driver requires its user call drm_aux_bridge_register()
> to create an AUX child device manually, you need it call ida_alloc()
> to generate a unique id.
> 
> Functions symbols still have to leak to other subsystems, which is
> not really preserve coding sharing.

???

> 
> What's worse, the action that allocating unique device id traditionally
> is the duty of driver core. Why breaks (so called) perfect device driver
> model by moving that out of core. Especially in the DT world that the
> core knows very well how to populate device instance and manage the
> reference counter.

This has nothing to do with DT, auxiliary device is a nice way to actually
use the driver model to handle devices sub-functions without overloading
drivers. It's still young and we need to collectively solve some issues,
but it's now agreed auxiliary device helps designing multi-functions drivers.

> 
> HPD handling is traditionally belongs to connector, create standalone
> driver like this one *abuse* to both Maxime's simple bridge driver and
> Laurent's display-connector bridge driver or drm_bridge_connector or
> whatever. Why those work can't satisfy you? At least, their drivers
> are able to passing the mode setting states to the next bridge.

HPD handling is now shared along all the bridges, because it corresponds
to a reality.

It simply takes in account complex uses-cases like Type-C Altmode where
we need to describe the connection between the DP controller and the
Type-C retimers/muxes and properly propagate HPD events to synchronize
all the chain.

> 
> Basically those AUX drivers implementation abusing the definition of
> bridge, abusing the definition of connector and abusing the DT.
> Its just manually populate instances across drivers.

It abuses nothing, the DT representation of the full signal path
in the Type-C complex was required by DT bindings maintainers.

The fact we can describe an element of the Type-C Altmode DP
path is very handy, and we have the full control of the data
path unlike x86 platforms where all this handling is hidden in
closed firmwares.

If you have an issue with the aux-bridge design please open a separate
thread, because the actual patch has nothing to do with aux devices or DRM
bridge implementation.

Please do not respond to this thread except concerning this fix.

Neil

> 
> 
> 


