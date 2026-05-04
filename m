Return-Path: <stable+bounces-242849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC3vMEhB+GnCrwIAu9opvQ
	(envelope-from <stable+bounces-242849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:48:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACF4B8FDA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 542853001D68
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6D2BD58A;
	Mon,  4 May 2026 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IA5oBJqT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9D1DE4FB
	for <stable@vger.kernel.org>; Mon,  4 May 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877317; cv=none; b=BCQ3DLSZxA9XM/hyaEo4qbfcB2Y782TF5+XnMPftffKW0JaN0YdUtv7vdSQBf7Dufx23BFKKM5wF/+qasd32pJJy7CRwDTSBmWk+nl1lpRY682rrZ++pePgoWGLm3A+CZjy1k3RYJW/WJBeGaXG5bPZuQ1/XKsowJr43KiVAJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877317; c=relaxed/simple;
	bh=ZyShRhA03+Udr+Tp3fmoBsMOEISCs4fTfi3EnLeE6po=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l73rNx1HafiowBG6ipSEkh1TBRDOP4JHVjvzBC5XTmaSiBbEQ9NeQL7i6nxS4SM/WPj3pKu0UeYKq7U0WuXKyPNqNTeSLyxMvw1MLQOrzuTK/pdAmXmXe+ZOUl7dVwsE8fNpU/FaP54+A4oaoC8+eJYDQh37ssatHSdiyC3AdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IA5oBJqT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b0786beso25337775e9.1
        for <stable@vger.kernel.org>; Sun, 03 May 2026 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777877315; x=1778482115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaxFtQoSnlscJEi3V1l4or44PmWhxE+7z0WfULPFAyM=;
        b=IA5oBJqTz8+P4svknC6CcSOYYO1JjRtslnT+KsqMqAL/91DhOG8LzIS9oF6gbEiXX3
         uay2Z6LNPRF8G1w95EbbT5a9J6e00CRSsoxH5AjM+PLcddBZ9RmbdxWoS1R6Nk6NMWNz
         R4XnWWGbiPkT6u08FF6yYPYQqKHpP9FHDw3KiflpG5AUuAky3YP6xMFFB6/BieuTOdgP
         P+F/tX/YqDhnQKdkQUP5dsFFj7F8YINWpdLMcRnPu70LzZaIWW5j+KlRA1ktpg27mcWI
         2khb2xDQ9q4t7z7B95tMjdmVb+61catbL6XJrHU//ADOhjueThZHfBMsmal1sflHQ1If
         yc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877315; x=1778482115;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaxFtQoSnlscJEi3V1l4or44PmWhxE+7z0WfULPFAyM=;
        b=lK9lfE2aLd+Xkc65jsd+4BXrGee7sytRuoKS/cHws62p+lM1Ue1bT7+jA/bItGyaHJ
         SRsVz8XVaTLpEPPA/lWWLVHGVBfp3avPKqhSbdXko+qdUfjUK42OSXmYyjPjrFkPhXR6
         trW7xpFuM0lGbSjwPEJ+aZY598FLrMMmnkgvVRz98qpirgBPQg5N6Z9bbiHLXtjsr5Ky
         UUg6V4iG07ehQzA/xCZyXDZuS+LeBeq8yVgXQLxZwWIsGLN+74zVcAREk469s3igYVAt
         qDNj/j3iEae9FSMHZZAYiilE7mzVJfVIht1OlWIcJSiXiP5IXghx13DmtqJMX9P5A4hn
         dPSg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZL/yLWEAKPa9rLi00OEGhDk/HpLnsYKVTOEQEgwnCRZjmn6TRhA6E14a0w9rUfq8OUt3UYO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyA3gzaNtmgcNDgEkeP9VxiE9I7o15uNI1ZvvHODIqp2w9Nrqg
	n3VAPVVL103OILUDdySoQ7JSH0rMAzamo71i19i/Y6p12jMd0L2zFqBPBwlCHAe3Esg=
X-Gm-Gg: AeBDiesIbxJAzyRnL1nP1qFK6sb6/7OEgezjf8P8z/QwlGffNpI4Cvox9W3DarCqYYV
	6jt0R3UiiZATpfhqMFQov5uEJqUJciaysoD9lMk9EAwDpEnPZwSw5p1mEKM7OV5F8dinT6QjLBN
	E//yhtYsLPhtf3iF72TDXFb3Vq5cpjY1pGCS8qWCUvp7wit9olgldLyvJbAI3T0RQ/JqhjGJTFg
	1erBelBRPdAk58eXGdTXqKwOHgzsJCzhF5XEQHSwGN59wS09WWQhmr2/Z625MQOq+HrbeAYFEsa
	uLS5R+usV0nkCIYoM+3WgxfnpNhyGO0hZC1919Nfkbb+RLuRR4KY30q2b89CwYx1zDvqKNCD+Qa
	/g9tHIhgNPo4eQjgH8N4ypM9K8BEB4AsXF+9E7GdlxU0xf4PpbGvgiazWfjnyIasHrkgbGhW89F
	jEY7csfucG9SHmKeE7O1HLQXYXB9MOmIU2SZazwDPifEVUwdxMpZrjpMld+8y3aiR+0KhGBL5mJ
	DBKp82cYQlxMvhoEbtKUPyh+wSg
X-Received: by 2002:a05:600c:45d5:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48a98638a3dmr131035275e9.11.1777877314308;
        Sun, 03 May 2026 23:48:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:4245:af61:1735:3752? ([2a01:e0a:106d:1080:4245:af61:1735:3752])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm363878875e9.11.2026.05.03.23.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 23:48:33 -0700 (PDT)
Message-ID: <882682c6-2207-408c-ab35-96140ab462ab@linaro.org>
Date: Mon, 4 May 2026 08:48:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jitao Shi <jitao.shi@mediatek.com>, Douglas Anderson
 <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 60ACF4B8FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,mediatek.com,chromium.org,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242849-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:email,linaro.org:dkim,linaro.org:replyto];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

On 5/3/26 11:17, Icenowy Zheng wrote:
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> 
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
> 
> This fixes error messages shown in kernel log when unblanking on
> mt8183-kukui-kodama-sku32 device.
> 
> Cc: stable@vger.kernel.org
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index d5fe105bdbdde..658ce64c71eb2 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1324,6 +1324,8 @@ static int boe_panel_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>   
> +	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
>   	mipi_dsi_msleep(&ctx, 150);
>   
>   	return ctx.accum_err;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

