Return-Path: <stable+bounces-95903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A619DF576
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 13:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A2AB20F31
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A5F166310;
	Sun,  1 Dec 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N0nhkKIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E21632F5
	for <stable@vger.kernel.org>; Sun,  1 Dec 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733055341; cv=none; b=CrQ3FpjWPi2rTMLJOcCqGzQ2qTPNb52qLelOITd0EXU2LXeU6pCjwQMQ0BIA2/1spwHszB0Chx2BJUac//dAIbYvfiHlYCHO+ctPqgV/7mbKOe++U97ajZDpyUgC2BAJUV+ZKK950bcCHXn6WoCej4KQEtQOJCkeFABBVOVdaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733055341; c=relaxed/simple;
	bh=OD5RbXnLcYUI6Lkoh4YmOYsGCrqxg1N3G4+4P7vvOU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyK06yrFEy6rCJ3FFppSCBhxgU+WhrhD+yVdNG+P6DrBNMyPsV00C9GfbdZUz7F3uA3qx6U+yQOWIo2coBIhEAuiAUSb4OiOCTptyZPjjPx29amO/HqVkI249MvpPn8mCwg5IerPNHvTIu+nWTwhtWgUjqThxfP2J4tPQ7ECBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N0nhkKIR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5CE73F298
	for <stable@vger.kernel.org>; Sun,  1 Dec 2024 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733055331;
	bh=+Bep4MW8ltny8AhXj/MnN4uqUspcjkr8DMrhdOLo+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=N0nhkKIRtmx4AKdWyvTXDZkXF/4KdlQjBI4CEcmxeVbZ8rUqOUvgkdeAMZqrm+1wa
	 ySI/hUV6zJiXBwcXsuDYe1pp7d7b7/460HU6nGFAetUBDX0u6Uszv+9DgkqB0LsL/w
	 hRFfWsBbs+AL2xSt7zoWtCZk9cp01weewTn0CDel7I5Pt9mfgnZgg+3vWGxm2+ciiN
	 AG3qG8TU+hDj8gos/H9CIbi2BDoO4pt7Lxtv6pMMHq0bsSsvtSMPihVJzbpSTgynIg
	 Q3fO6i6mktuezGESF9cEVE/jGcqdOUWHO/bKevx7gz1LwwDEqnMMLztIvfgzfDKP18
	 i+Y2iklZudI+A==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7f8af3950ecso2580857a12.3
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 04:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733055330; x=1733660130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bep4MW8ltny8AhXj/MnN4uqUspcjkr8DMrhdOLo+Ls=;
        b=IPkGBFw+5yNE+1ruTgJehF/wWGnyKKuNSbznMcbp41S9U7DpQJ20oeVCRZKZpOkKvg
         RrM9CSJtPov6Ro5gwD/Rk1xTAMwm50yQ6ShmRFbU00nrmv+Wdd2K0NxFZtuGqAlnQCaA
         cpAD6nKgBA8/Oml41P3qlaaLNZELFXYt07Mpu4zqt9pCB2915qDGMcr+c938tQGACm1w
         ZwYtp04SWy0gtd7TcrUJL5MkBFBlpclh7NDfEcne5OaIWiKYgThgsLMUDwJGTgx4Cncw
         WnYPB1CR4klKmSuvHJQjKP7FcA6xhwuprzG7OaOtlSnsb+HYIGlbFereO1vOHdDHbYyI
         UbxA==
X-Gm-Message-State: AOJu0YyQnD9E+pGYS7EKDGMLHWO9No/h8cPTQ4kAYTHGmBcznoT/k72n
	IUh56jGgY10Jwm0W+bc+RhufKBhDEUi6/yYwS6sj5XpiP53hmJX4F0O3fkjFi4Z+E6/JZKOXQ/Q
	6SZZLHG3PcCTljLZvDJETQAIx1K3jswr0/IQuYNJSdYdvYCfMTYYmYNyGUK68Su4SHL36aw==
X-Gm-Gg: ASbGncsq7ZLmlPYR+OF1voEwmLTZg82unEAyk7P6y+6lGbfO4Dm2rfTvvDm2NDQZimw
	tPseSDPLvmrM1Wv3r0yRA+6AH2H00ciR4ARTljXrbvw2h+IMtCWjA1jKm119foTDdYbeVpOpeAw
	ngypxshk6Yo4Q8fhcx8Cv+JJ2CQKA/PFitoUZfK52YTRkXJXfpc/G9RanE6AQhESRy47fanwpdS
	Tt9pJeNN88AC18OSMD9Asxdo3VqcN+hmwKvZnqL0LXbPEpb/eKP
X-Received: by 2002:a05:6a20:6a1b:b0:1e0:dd8a:bef7 with SMTP id adf61e73a8af0-1e0e0b2ab0dmr30172888637.13.1733055330068;
        Sun, 01 Dec 2024 04:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtDQhxEw3jWkfkeUannFdCgJard0mxeGTdxtAgy2BAcPoMlV/2tqw/AjDRhcz4T37CmbQfUg==
X-Received: by 2002:a05:6a20:6a1b:b0:1e0:dd8a:bef7 with SMTP id adf61e73a8af0-1e0e0b2ab0dmr30172864637.13.1733055329722;
        Sun, 01 Dec 2024 04:15:29 -0800 (PST)
Received: from localhost ([240f:74:7be:1:8479:7cee:fba6:54d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fc93sm6772744b3a.63.2024.12.01.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:15:29 -0800 (PST)
Date: Sun, 1 Dec 2024 21:15:27 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen-Yu Tsai <wenst@chromium.org>
Cc: stable@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH 6.6 433/538] arm64: dts: mediatek: mt8195-cherry: Mark
 USB 3.0 on xhci1 as disabled
Message-ID: <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
References: <20241002125751.964700919@linuxfoundation.org>
 <20241002125809.530901902@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002125809.530901902@linuxfoundation.org>

On Wed, Oct 02, 2024 at 03:01:12PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> commit 09d385679487c58f0859c1ad4f404ba3df2f8830 upstream.
> 
> USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
> pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
> design.
> 
> Mark USB 3.0 as disabled on this controller using the
> "mediatek,u3p-dis-msk" property.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
> Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1312,6 +1312,7 @@
>  	usb2-lpm-disable;
>  	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>  	vbus-supply = <&usb_vbus>;
> +	mediatek,u3p-dis-msk = <1>;
>  };
>  
>  #include <arm/cros-ec-keyboard.dtsi>
> 
> 

It looks like this change is applied to xhci3 instead of xhci1. The same
appears in the backport for linux-6.1.y. Could you take a look?

Thanks,

-Koichiro Den

