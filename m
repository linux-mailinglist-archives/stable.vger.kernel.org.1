Return-Path: <stable+bounces-160387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0DAFB9CE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC14A1D16
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCF299AAB;
	Mon,  7 Jul 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBl6v3WX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754422127A;
	Mon,  7 Jul 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909049; cv=none; b=DvurKBxovizeHBC9agM9JeEoFWwI1xBU3f5vEYe+rI1zWcl8x0If1baszMHtEJH40semUkrZsKDJkqxey6maYqBME0sjB/rh60UDS5yshhdtY+E8q9kj4YDfUr5SkpKAioxyLy7IR9Rg0p+5vxzh8jaANf2zXKlruXX09ocAj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909049; c=relaxed/simple;
	bh=LlHlum7NP2UOXFKSLxeEsd1WlEuAPhlZ5ZqOapgOmQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyNbrqLoLIhepEiX/1MPQsO5sJh++jmNbH9w60pwyfL0hsETwTBqwdAKpH540l2d/Bmo/KC7I38R1PPHNwT8pbEXlg1tO9ylyr0HE9TN6SG+V8zHOCzvIIrsyqTWPjVogpopHbI0FNpXTt8fiEJYs+KsO4yFzoe7w9vlTZmvkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBl6v3WX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AD4C4CEE3;
	Mon,  7 Jul 2025 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909049;
	bh=LlHlum7NP2UOXFKSLxeEsd1WlEuAPhlZ5ZqOapgOmQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RBl6v3WXJvvBEUhb1sluPF9ajW8rG1UZlML5bEGlycvZWLnAzcGbIjOd8uj74VDvd
	 +83NtFA67eQTLfShknczgaCfrGx+W4jy1+Q5yE9ziPM7apMiO/8Rcpk0G4sd6WXfQs
	 RHMcqjkpkzRC1Htp2kSWwhrR6XKKIr8r7UEwvKSisgA14vs13S6Vj4W9qyE+u6d+7d
	 F6CA1U/j7Zf7cyqXxkNruZWKOF0vUr7HwmNwJ3EfqYBx+24+o8gDfZnat3unHm1RYq
	 qTRXoQ4WqaTbzGHHNq0AcENsGQ0YirQXkRtbfRXHxulPlDlXfoFTWdus1xucGy1Zk6
	 urUsn1b5H2vFw==
Message-ID: <e5be9718-d53b-40ee-a1b7-087fe833042b@kernel.org>
Date: Mon, 7 Jul 2025 19:24:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: Fix kbd backlight not
 remembered among boots
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gergo Koteles <soyer@irl.hu>, =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?=
 <pobrn@protonmail.com>, stable@vger.kernel.org
References: <20250707163808.155876-1-i@rong.moe>
 <20250707163808.155876-3-i@rong.moe>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250707163808.155876-3-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Jul-25 6:38 PM, Rong Zhang wrote:
> On some models supported by ideapad-laptop, the HW/FW can remember the
> state of keyboard backlight among boots. However, it is always turned
> off while shutting down, as a side effect of the LED class device
> unregistering sequence.
> 
> This is inconvenient for users who always prefer turning on the
> keyboard backlight. Thus, set LED_RETAIN_AT_SHUTDOWN on the LED class
> device so that the state of keyboard backlight gets remembered, which
> also aligns with the behavior of manufacturer utilities on Windows.
> 
> Fixes: 503325f84bc0 ("platform/x86: ideapad-laptop: add keyboard backlight control support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Zhang <i@rong.moe>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans




> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 62a72b09fc3a..edb9d2fb02ec 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1669,7 +1669,7 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
>  	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
>  	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
>  	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
> -	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
> +	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
>  
>  	err = led_classdev_register(&priv->platform_device->dev, &priv->kbd_bl.led);
>  	if (err)


