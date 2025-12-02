Return-Path: <stable+bounces-198075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C3C9B4A5
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7BFC342BA0
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28E930FC27;
	Tue,  2 Dec 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghmkJHiN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C82F693D
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674352; cv=none; b=X77jdGAyVOjVyjOGl4MfldRnV5F0L3wn9WIlavjNrCuMTTgCfHr42WniXwW96GTOVInVIRGzd/A1oUvJQsaIfpgTxMoZ591DZ0m4n3BUZQ71ZvNsY3UJTyMh5TgwrvWFJDo5/VKX6VvjBKiCvjpD77nBClDHOVG/HDDTorI1K/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674352; c=relaxed/simple;
	bh=YgM4oQM0pItXOtlv7SOBfbImGy87mRYXLgSa4KdBjKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYP2TDwDBtxEAxFjQNMl0WV2e5ReiZ9GvnnZml4DNYgX4h7xkkqJtaUNCKk6+fi8HR6I85IOaQg1zMYtg4xdBosray5jqSGLUx2PWpD7Ca9d36LG5d07TpJM8szz51geYoW33tzJDEK968XrLmjsZww5h26QuTzW42JJhnZVQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghmkJHiN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324054so768988066b.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764674348; x=1765279148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFKm5TgCbXMywR9ztCslk4pzbDCGqU8JaRErdSAZu5w=;
        b=ghmkJHiNnNmZRzcV6Xhu1tVlXRA6QCJrLSRN0xCvte+91bynoWxNSr0NWx3H9NThLL
         LzPZ3z15BmRS4zvsQnkQfvQFvwx2QTUTOI6o+9aHTv5YV0Jg9Je6W5di21pQPDvdtFf8
         gngSLRm9702mk8MjILFYucsSXX91tN3UGYKk9JBwVPivkqyzEfbdXCUkWf83OjZLx95Q
         lgAu3Kwp5RCiTh0W984blIf/1XgwBKIVaN1dQV0DOtBoCMR37B+MaTQM5g46hlz93Bcf
         SACun13nf9w0TrlYmE1rlPm2HSmVFIq/hMjr7emgB1ZnFEKTrtojHhcIFE7PLBpkfE55
         KTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764674348; x=1765279148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFKm5TgCbXMywR9ztCslk4pzbDCGqU8JaRErdSAZu5w=;
        b=byCLg/eYNELwWwtvEY0s1mFmcbi+Onz2JK8uV1OX/dmbb0pvXpuoVR2FJLwPYV01N3
         iU33RdWAwF4M06Lm4ShxIetg9sT4s+jVfSV/rYQhyPamiy5uRJ5rNJtlsFXwlwua+zrt
         9KAtNNNiyfpJb8mgHDn50aS6zXHclHGFM0DdX2yt90DV2XLXC/mUZyaJR5W3pttj5lMk
         hQD8eJkYMv89ZANnDlpZmcPiZXO79eYJ17q2E2w6fLOvjoq6xKzlAxLfcBxvdQotpEMN
         W10fnHjEhS5TAaVmDVjl/JDusVVuhJ1PurDw4SGr5RUW0gPvMTNxxdOMVgdkdXE8UiM4
         4W8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCOckr9yQuHv2GBC+0detfszsmkS2avtM7KWA52fhcJfUnud70vCdIWDQM3A8cpZiFzFREzEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTlf3zkME4ITn8HBF1PAQLEBkKo0dVyUFyiOPYak0TasGt9q/
	Ij6wYFe8QwfWTLSs45TAfgz1eXqZlJafYN/a3bmuoLJazrTZ+jDGThSJ
X-Gm-Gg: ASbGnctnWcpuk9dUiNYtqG4MDiL4zUup3htYcjxniVC/yAHmIcuovdSuM4nNXRfCD4/
	6oUjYMsn+03cBltWyIAqkt1ZDwUHNxZGUEGRHAuQQqhkY3byzhRM9hL4LQ1g3Hq2r8GapySbR6B
	vbglUl68QJyxXCG/t6qQQvpWVCpAxEPJmQJKK6s1ZK90KvFxZN8XdZYihlnCmP9HNxxZE3A9H6L
	Nxxur7+CjS+MkcDdQX5vuzxshlLVXHh/ZobAUvOIflO+Ikr2QGWed11WKoGn7F8FGt1jO/4as37
	qNdQLWYHibQTq0HST+2k58CirepP7ORhX/LPO0S0QFw2hrjdHb4jpgQq97xdO2Sf73clNVTRJXX
	tDMmV/SehSmEIWURK2HAyXcPBRr4PWSPMbmQPfvkVJOT7QlvzX6JF0CQ1L0rntzse8MAzkjLroc
	fKE15ontXair/D0VoGM8STBJQDgbV5x1Ggka5EZwE6eMIidpkX3w==
X-Google-Smtp-Source: AGHT+IHY9Fm4775G9TVCUUeZO3LX6VYmaVn80vEWW1L95jQOyW7g8hXV8wnuSO7FTN6GjpPobn6rDw==
X-Received: by 2002:a17:907:9289:b0:b73:5a8b:c9af with SMTP id a640c23a62f3a-b767184bcafmr4940716066b.42.1764674347634;
        Tue, 02 Dec 2025 03:19:07 -0800 (PST)
Received: from [10.251.131.228] (93-44-9-97.ip94.fastwebnet.it. [93.44.9.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a695esm1464431066b.33.2025.12.02.03.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 03:19:07 -0800 (PST)
Message-ID: <cd607656-90d3-4821-98ea-4dad48288fc9@gmail.com>
Date: Tue, 2 Dec 2025 12:19:04 +0100
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

Well,
I would suggest a couple of tags, thanks.
Emanuele

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Reported-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

