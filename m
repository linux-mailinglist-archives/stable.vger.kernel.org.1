Return-Path: <stable+bounces-133210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B442A921AC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90098175C8B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB53253F22;
	Thu, 17 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaGsPXR6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3351253B64
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903893; cv=none; b=HlicpUcRFbk2nIIziDpjqK+j6wA4L2wVDVVesF/v80iH+Mgw3p5JBDougPsmv94DQCSRQ5okMMc1roLo7JsKZerRGiETedjMhvGY6zUYrtAdpsv2bd0SP30OAP9mUsXo9SDnBt0zyEAxob0NM/FTqW14hXcfTL8qGF/FWVI+c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903893; c=relaxed/simple;
	bh=LZEPpejIfFxYDDGNK0bRJuD+hdjnNFo5RREyMTxXYqM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jmJJN74s18ROOFZ+/MZWucSWWWV3fn1YdEl8kbq8oNdpUxM98Ti+mKuQcwsKTU/mJfbNtbBBnwnmpfwRkSZYi5AOt5krkPggQL/TXjfMBp6Yn+Quet0cgOTZFHKeyhT7fUgz6Kaj9doWCIqg0Z7iV2TOsBO49elv//D6t3lHDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JaGsPXR6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso9462565e9.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744903889; x=1745508689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GabpQFM6FHZHsv6ak2pU2BPX+s6Z3k+bnrJDF1aRDfE=;
        b=JaGsPXR6wlyt8B1JMr+RgC+J3OX/Q2zw3eCenvKtnycuRWz9HP3xuV47yT+DxZBayn
         gDDU8TdaG0MYd9EEepLiyqWHKCbkzvJOslPc0NLu9Po0dimnMIq9c2UqxBML0/Gy08q3
         7L2IlVD9AbWGFszianCz3E5gDSxDeptS7Ie9PyoprK4eslQ2C5QQBN4OYEK+8amNU9pw
         WLguYfB/qoyj/BMT1GwdzLTagNFdUfEoNQlltm1XpybiduJMSCWycCGQ1VQ5XAF3U+cS
         x0I52jH90sdgUVKt1MHO25LDpSrJ3dLJLkFCrxPV+NhmqwX6cbH1Thd+cLaMmfA8v1Kc
         nYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744903889; x=1745508689;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GabpQFM6FHZHsv6ak2pU2BPX+s6Z3k+bnrJDF1aRDfE=;
        b=uxLuOKZGYh2jRVBc43eLp3EMw03hOg1ZeV2fj7ZC3qBygnAtNLWzfCtFxdKNoKht7v
         379dM2sjFAJ1HWhhCpfoJwFEGwpV6rDKfwgey5pxZO+pyrPLQiDQjWrhuc6eGx2B9pT8
         Mv1u1yDW5sXA/cPfJDTNgTltvRAMpJ7ADEmGmphAnwnhRO2J+kTC98Owww8rnV9Ea7aI
         Zgp6IwjlPt4PfZv+roYviElI4JGYiM4xUOgX3YltDgNiMdVud+GKHWgYSqki2C+b7Mmr
         gThB0u9WA4T/kiA6b0wE3jK4n3lwKkywMdrx3vxlZ6BOcQ1zbrHrXEztm06FnCiB0nC5
         lEgg==
X-Forwarded-Encrypted: i=1; AJvYcCXL3u95+e6UCxDwh180AJVukel2zzIKvcZMELuw8/gO+mEUlKA1VQwwfhNK/yCdYab9rRnmUX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tiKndnvWEY4GHBG+Y/oQfKCFMrb3Sd3LdznB0Ojurt3IX3Kz
	nVtv+N1EQGz3JUSfrrInXtS5dRmUaRbyquBtSPhym7hB8ZAiB0k/vLIpr4F9pgw=
X-Gm-Gg: ASbGncva82EsrsKyeVYJLvj5F7F+4D5lU1XPpMQ/KQ8C5tu8BSFdI1YE6blBV78LazV
	aRCrX+wcgKzpTJJS8VEYZLPcmLzZ3fVPN1wXzay3ylky5AYcmu6LPCBP/MRD2c2CfDJunG7PUY6
	T4/PQnYPmxmODd+XELvRb0GodLn0KHmBZYoxdQptH8WNQ/GopUDVIOXpcKxsR+c+KY9WEA8whUc
	ECRKkn8v/sRwMpd1wLtJfDeZ7DJsPO3QpYXMUqEj97zFS1xVIoe3832rZKZpDKEohD+/1dlsPmD
	N/Qp/9+dyS2deDnzidUqQqUr6Zx7HDBgNkyrF1MiE19KYHLh1LaAmFh/b5O3jX6yuBnYOmiuAFg
	xW2c8CDDeU32AahQ=
X-Google-Smtp-Source: AGHT+IEXc2yZ84OQzIxc27xjxj+s0MRjzbSsN1SkSFfY0y63NTO2TgOX8V5f9KQrjAvVEdjTrXopHA==
X-Received: by 2002:a5d:64ae:0:b0:39a:c9b3:e1d7 with SMTP id ffacd0b85a97d-39ee5b35fc8mr5056045f8f.29.1744903888828;
        Thu, 17 Apr 2025 08:31:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a7f9:634b:42d:1546? ([2a01:e0a:3d9:2080:a7f9:634b:42d:1546])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979663sm21247275f8f.51.2025.04.17.08.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 08:31:28 -0700 (PDT)
Message-ID: <969b474b-b154-466b-87a1-3ae16c45af26@linaro.org>
Date: Thu, 17 Apr 2025 17:31:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/3] drm/panel: simple: Tianma TM070JDHG34-00: add
 delays
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Pu, Hui" <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250411-tianma-p0700wxf1mbaa-v3-0-acbefe9ea669@bootlin.com>
 <20250411-tianma-p0700wxf1mbaa-v3-2-acbefe9ea669@bootlin.com>
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
In-Reply-To: <20250411-tianma-p0700wxf1mbaa-v3-2-acbefe9ea669@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 21:19, Luca Ceresoli wrote:
> Add power on/off delays for the Tianma TM070JDHG34-00.
> 
> Fixes: bf6daaa281f7 ("drm/panel: simple: Add Tianma TM070JDHG34-00 panel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v3:
> - add Fixes: and Cc:
> - remove regulator delay
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index df718c4a86cb7dc0cd126e807d33306e5a21d8a0..fd7ee5d1ca280be306620def30d3b423106b4304 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4452,6 +4452,12 @@ static const struct panel_desc tianma_tm070jdhg34_00 = {
>   		.width = 150, /* 149.76 */
>   		.height = 94, /* 93.60 */
>   	},
> +	.delay = {
> +		.prepare = 15,		/* Tp1 */
> +		.enable = 150,		/* Tp2 */
> +		.disable = 150,		/* Tp4 */
> +		.unprepare = 120,	/* Tp3 */
> +	},
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

