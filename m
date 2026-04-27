Return-Path: <stable+bounces-241251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NeeDkQU72l85wAAu9opvQ
	(envelope-from <stable+bounces-241251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:46:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA646E8BF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A243B30087A0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545CC396D19;
	Mon, 27 Apr 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTP7hEC1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5152396599
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275966; cv=none; b=C+1+ZuLmr1VceIlA8eJxQjP8OnwOUM321uLtzCMkUXmeoaCrmdbLQVqnSkhuQzB7SOWPrXk0Yp02T+bOIYXLa9/lX+fqCK94O0/jSQwyPyEzW+H4tmX/3b22HX2fWEMh2T7fu3wzBMeHe1PBmLSuB8CFMRkJLhEMxQqU/AKZ6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275966; c=relaxed/simple;
	bh=V2k1rOTgQ1406sqBOy/fWzb7CT9nWq+QCeodNCDdTrQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OpQ/GsQS+aUGA31RnJzZfTHotk/ysj815CRjZ6otcpj4WYZpyfdv1PwCp91JqE9P76d6J2fJAJjb8VIT/uuNp2Y0Ffz17XB9nWeAUx3sRWfjxky96kNiQrjCvL2DHK4ZcMoH6+ylJR2Q+NIOaSlZofMo5EdEDDcOlQmaqw8k/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTP7hEC1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so9125220f8f.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777275963; x=1777880763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u3/elMDWz/LKtOmsePu2UI5vStego255LeN+cFbL/c=;
        b=qTP7hEC1IgJCrPAoIuLAeP+Nho2PPsI1giijCJIrVjuFQx8XQ1Wd+Ffi2enW8jXs/S
         Dl87xWACl52fd6FeYc4wHYDr86QP9ErMqhx55WafAUe29+LjIevb17OXkt+nVa/vVfeH
         7owRmvsXigGBv2WiFQ+gjf4ebaE33iTuGVNF3uRRxNHlDucjRLxkHVuHIgj8JtQQnZzE
         pIMuZRgusLk0Doh9nU+qkwAmOy72Q/ITaLdIWIno07/zoP8SmFHqSQeiaEMmQDL0PuzU
         j01x0t+ESTZi9/t5vZ7c4egUZKLCTT/ed/OtNkX9mTFQwb/CL+zWPXblmG1hqLGz8nhL
         1eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275963; x=1777880763;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u3/elMDWz/LKtOmsePu2UI5vStego255LeN+cFbL/c=;
        b=Z8Lmvy0OJb5pfFcWMY8G4iQKGYjdbOm3Q/RTVRBy09P0QzzhKxkycc4ECCL/lb6WZE
         CKQjuuKwfDMw5ac0C97krSOxkBDKZ9VEUEOEPQqDHL+nMv5lQeUhZ28MVwMKHh6cJLd1
         Ix0YQLBK7m4E9ZjZRbn0c+AnqnsiLZX03MoyPRWAHqPsVilNc3ik2JQywN8wmoTEjhmo
         kuQ0T7yw0nxc5dCLLarVkZUKMIM6J0plLdvVHiC0kFbyDtDjci3rCL56YE831AcxjimG
         qQBnbQ44WFlp/Wi/b3SCaa7X0tfbQ6P/aWbvDjw+l7ORRk3L+S+7zMs4+zGFxc17YEBD
         DZ9A==
X-Forwarded-Encrypted: i=1; AFNElJ84DilnAsK/ruM6WWVv+8fJs4PvxBeBIzslWX6qzHqgKzXxSRAc8lVQQgHyjTFGTY9cTbO32hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEd0UBPDdYm7G5E9NcVKroFDda+MtMwknCnYOlZl4uG+nOwBK
	UhU6OLsuQliQjL+rx9P5rXhB1Mau5hT6/yQznjLk+/dGIL4XJR/+vAJE5MYuHBUHyyc=
X-Gm-Gg: AeBDieuRK1CuT1dHnmDHnt42VUjaHbrvO4NzDhlfh2rVRP4XzRbp3V1rZjnoaCfySm+
	GFKxT3vzx8KaKHIZ9fwy9UAuNmQ2YihmE6n5vTAWmD2qBycxJtcfJgfsTSGZ+rZtBWvcOtSULh4
	H6hF/WQFnQjek148pN5C42Qufyi+Qnjj1t6hVYeccv9F8KkVjoswNb3ajbqJ7mFscf/LZ6uGNGi
	FogF2J50flzR2xjXAIyehJQPF2rq2vMdnn5G/fA7B0H5gszZOWbrjzYK7U1vEAZ6e4sLYP7dY/f
	so9nu8HHgA+boPJsapQYdHvlbmyOxunnZp0S8cvLT6cllURQk9Dld//q4jgq2pQRL4/so2KR9V1
	MjL4Ftln5ZOq7lHr4ySD8o3ydEr+jB3ykrHiAwxjNnlTYGeISmA7GE2QeW/aTWLU72cgtmEV270
	PTxQoMmOzcc/0aFev/3lSfzKvlEgctwPBAt2OeXzhpjWrYXBiyjyXBUU5KgDqk3V7OehQJC7D69
	BLNRaBnAzaBUZr2tw==
X-Received: by 2002:a05:6000:24c6:b0:442:d9c0:799c with SMTP id ffacd0b85a97d-442d9c07aabmr10780863f8f.0.1777275963001;
        Mon, 27 Apr 2026 00:46:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440? ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm90235565f8f.20.2026.04.27.00.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 00:46:02 -0700 (PDT)
Message-ID: <20884589-8868-4596-b39a-f5bb55ce6b46@linaro.org>
Date: Mon, 27 Apr 2026 09:46:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5DEA646E8BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,chromium.org,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241251-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:email,linaro.org:dkim,linaro.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

On 4/25/26 18:57, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> This fixes screen unblanking (after blanking once) on
> mt8188-geralt-ciri-sku1 device.
> 
> Cc: stable@vger.kernel.org # 6.11+
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index 8b2a68ee851e3..a5e5c9ea7a73f 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -937,6 +937,8 @@ static int hx83102_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
>   	mipi_dsi_msleep(&dsi_ctx, 150);
>   
>   	return dsi_ctx.accum_err;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

