Return-Path: <stable+bounces-198073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15754C9B3C2
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA233A5FAA
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940D30E0D9;
	Tue,  2 Dec 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh0Builh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4303054F5
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672971; cv=none; b=gPmKf2R37sA02LeZt0FGmIKHdjf9cN+z7JF4TX1RaRGM27nqjICMgpYbgQzu7Ms3Q7GhSI5EA0YZP1I6CQfV4CmWbP0jMHJw2p4kL884VPuSaIcIYnmdjv0PF+oIk51PY4jKtfS2thJsFHec+2H3tu7tu8CBA+LYWYumAY8VFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672971; c=relaxed/simple;
	bh=5QPqjLcy+uoya6TepPFnlqxc3TR/wC7U4Pv6bjnPUbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDt8Ib4iepnKJkveOO9gni9w4/96yqHroKHW5amyIx6PSy4ArlQ74zTQfdWCjxpGFTnKUtcdYkWBGYMk3t+nr22y5A74/+zJ6IgFoQ1D38jZ1+52pWlwHsVMxSqXnqSrhV6Xa/l0GSwo+wdQXFD5lbYQLik3+ZN89+UqhBJdJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh0Builh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso8074575a12.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764672967; x=1765277767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehri81yPiQwv2TtMVBNaIP6q+no9/49Tq7gYw/RdK/w=;
        b=bh0BuilhnYA6M0lfLN0mu9i+rLqGarSPq/d/91dmM5zd4+0S52vGJLVYdIJUKOXNqj
         Nt2aTtWS4bkVOl7nWD/Rvv46/DKCL0XcBmRpNp9eNBFMZb9jzplxGVaj4JQFrGNBqXh+
         NhlQy2p2L4ON/71aj1UqvUxDyCCDgynKwG9ZAI7CSQOsWcigDg0qft9uYGagnvlyMB49
         E1tfdoi/gAxVyi6MIXGY4jtApM/YWvfeFooh7vs88Lif7INg+YjKtLspYYR2jfQiKY/+
         YENYqunUuNmiy6JjHsCnxt4RyMqCV0xEC/NCAl64+qAbeay0aAkxd3R+0TXl1bQxQeBu
         QK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672967; x=1765277767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehri81yPiQwv2TtMVBNaIP6q+no9/49Tq7gYw/RdK/w=;
        b=WwcxB5SCOuyTGEUaZihdkOElt5uh7AdQidEFPpF6DfXAtS1QmbVblrIFXffrFECbdb
         MlfwJW6EGER3zgdQAAqLjFD0aXgB4hHoAWkooi8kQOLTAK3P88xrGHyL28eDvUQUcor8
         +ilkfqXu/cyDhiXJfxzl5bjr48aNs19/zOkGl6urNkPLZ5DjkD9lPTX18ibtW7deERGO
         GdXVzh68/QjuNVjUlJ0iUKPmr22qrr2aELyuBVayPyfxBWM0bOFWMeWCFvjejMeEzG4y
         XI/JKBnCwlQwznV8x4/1e4Yb7e8tsTScxhsTO3r/7MzqlcJRruE3l7kkiqYcgaQ/zPEg
         IQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfl3FRi+ozkUzlrVXAmmsk8AVac/WXxkoF8TPIzjwmfuocQzUrDoDj8W3Xs4j5JaUhW8lJjN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFdTH/j5ZbRpUOsGWud4ixJAiuhqyz8+J5I0/ESnnn8OTsPH8
	SnOsSr0F8DQgbjRE1zw8Pln4WcLpH9kcE2dvA7+ukXzMMpJ70TtP+mjz
X-Gm-Gg: ASbGncuQtFNUgpJGj1ezGXn3tFtY/Vc3Tw/ubUAfprNFKDThBvVCHOmLWBIQ2XKx+Jx
	b+BtDI+2/mXGQliki4Wxz65u7/pKpOXTmqBPa7tWBXjM+eaHSaM4Ifyw0WMekaLDTrBvPQWFr9h
	D8Mn2BfTKYckZdusHJGuUvpMiMCdySvcNYEddUjeBA8eAtHePmLpaezy0mE+dR5uZ5JNwreQre3
	CWE6rmDeHjZ39up9KaHB/wtd52aPfx3kskDVEy9SGFosVHeFAuq5AUShzws9FJX5LeO1QTO7G+S
	4cUG7UNJzWXhKZ+hptcpx0LHZNb3jzqOAnAOPfbW5ESUULc4FqH+WOuYoKw5rMiywlx/RqtKFL5
	TXr+t/WdZ58FpzK7yobGiHxJ2KLIegf+czKX9ZdNDaSzECu8loS2YwQuYmlzRIJ4hmxJWzrTMB7
	m23fAj5HQPEakoIM5lUu7ssWIYIDq1Ixg57YsV+BAltzZc5r7Pmw==
X-Google-Smtp-Source: AGHT+IGDWo9fAKrIqK6pOzWcubTiXGsGXBZvWB+hJAa+IdynlbdlFuxAhEoOWusf+Q1ptI8yJnHO7A==
X-Received: by 2002:a05:6402:4405:b0:640:c95c:be17 with SMTP id 4fb4d7f45d1cf-64555cd8ccfmr40873221a12.16.1764672967228;
        Tue, 02 Dec 2025 02:56:07 -0800 (PST)
Received: from [10.251.131.228] (93-44-9-97.ip94.fastwebnet.it. [93.44.9.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751061e14sm16962796a12.31.2025.12.02.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:56:06 -0800 (PST)
Message-ID: <19d4abb7-551b-4c86-aee0-a3ae7b054ba9@gmail.com>
Date: Tue, 2 Dec 2025 11:56:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: ignore PLL_UNLOCK errors
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Philippe Schenker <philippe.schenker@impulsing.ch>,
 Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?Herv=C3=A9_Codina?=
 <herve.codina@bootlin.com>
References: <20251127-drm-ti-sn65dsi83-ignore-pll-unlock-v1-1-8a03fdf562e9@bootlin.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20251127-drm-ti-sn65dsi83-ignore-pll-unlock-v1-1-8a03fdf562e9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/11/2025 09:42, Luca Ceresoli wrote:
> On hardware based on Toradex Verdin AM62 the recovery mechanism added by
> commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery
> mechanism") has been reported [0] to make the display turn on and off and
> and the kernel logging "Unexpected link status 0x01".
> 
> According to the report, the error recovery mechanism is triggered by the
> PLL_UNLOCK error going active. Analysis suggested the board is unable to
> provide the correct DSI clock neede by the SN65DSI84, to which the TI
> SN65DSI84 reacts by raising the PLL_UNLOCK, while the display still works
> apparently without issues.
> 
> On other hardware, where all the clocks are within the components
> specifications, the PLL_UNLOCK bit does not trigger while the display is in
> normal use. It can trigger for e.g. electromagnetic interference, which is
> a transient event and exactly the reason why the error recovery mechanism
> has been implemented.
> 
> Idelly the PLL_UNLOCK bit could be ignored when working out of
> specification, but this requires to detect in software whether it triggers
> because the device is working out of specification but visually correctly
> for the user or for good reasons (e.g. EMI, or even because working out of
> specifications but compromising the visual output).
> 
> The ongoing analysis as of this writing [1][2] has not yet found a way for
> the driver to discriminate among the two cases. So as a temporary measure
> mask the PLL_UNLOCK error bit unconditionally.
> 
> [0] https://lore.kernel.org/r/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42
> [1] https://lore.kernel.org/all/b71e941c-fc8a-4ac1-9407-0fe7df73b412@gmail.com/
> [2] https://lore.kernel.org/all/20251125103900.31750-1-francesco@dolcini.it/
> 
> Closes: https://lore.kernel.org/r/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42
> Cc: stable@vger.kernel.org # 6.15+
> Co-developed-by: Hervé Codina <herve.codina@bootlin.com>
> Signed-off-by: Hervé Codina <herve.codina@bootlin.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Francesco, Emanuele, João: can you please apply this patch and report
> whether the display on the affected boards gets back to working as before?
> 
> Cc: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>
> Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 033c44326552..fffb47b62f43 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -429,7 +429,14 @@ static void sn65dsi83_handle_errors(struct sn65dsi83 *ctx)
>  	 */
>  
>  	ret = regmap_read(ctx->regmap, REG_IRQ_STAT, &irq_stat);
> -	if (ret || irq_stat) {
> +
> +	/*
> +	 * Some hardware (Toradex Verdin AM62) is known to report the
> +	 * PLL_UNLOCK error interrupt while working without visible
> +	 * problems. In lack of a reliable way to discriminate such cases
> +	 * from user-visible PLL_UNLOCK cases, ignore that bit entirely.
> +	 */
> +	if (ret || irq_stat & ~REG_IRQ_STAT_CHA_PLL_UNLOCK) {
>  		/*
>  		 * IRQ acknowledged is not always possible (the bridge can be in
>  		 * a state where it doesn't answer anymore). To prevent an
> @@ -654,7 +661,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
>  	if (ctx->irq) {
>  		/* Enable irq to detect errors */
>  		regmap_write(ctx->regmap, REG_IRQ_GLOBAL, REG_IRQ_GLOBAL_IRQ_EN);
> -		regmap_write(ctx->regmap, REG_IRQ_EN, 0xff);
> +		regmap_write(ctx->regmap, REG_IRQ_EN, 0xff & ~REG_IRQ_EN_CHA_PLL_UNLOCK_EN);
>  	} else {
>  		/* Use the polling task */
>  		sn65dsi83_monitor_start(ctx);
> 
> ---
> base-commit: c884ee70b15a8d63184d7c1e02eba99676a6fcf7
> change-id: 20251126-drm-ti-sn65dsi83-ignore-pll-unlock-4a28aa29eb5c
> 
> Best regards,

Hi Luca,
the display works correctly with this patch, thanks!

Kind regards.

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

