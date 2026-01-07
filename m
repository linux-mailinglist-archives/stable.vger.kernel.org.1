Return-Path: <stable+bounces-206230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1FD003F1
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0614A3007C00
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD60303C86;
	Wed,  7 Jan 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbhRrnHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA82F1FDD
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822817; cv=none; b=NFjzcVDcXKlYxjCIpw6w9OfAyYuSGLBv0GPrqPJollfhjWOLcFqWET+3Ibcb4kiP8+wfRu8V1Yw6X13nK40wHdWWkPDlk2raXG45GgSYgvRQePA+WcixbVX9JAnO5LXEPlDz/9UxUpQlClUSaOl3/rOOcdunQ0obcckXRlCc/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822817; c=relaxed/simple;
	bh=UHwqB3gjL3ptwXoinVWuZA+mO2tTt6i7X4c8KTM3w5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+kFljO8tImL1ltfMITEH10dJ8OdfyC78WXfhXaRgaR7RYh3UBRGJ8gIZE2Nbp7q8Staxek7RPqRFJZZucsivcyAb4nbd1FVziJFtuBFqAY+1awMaz6GJ8WWEIVPwJHMT2hgrW9dDK7o0Hfk6Pmb77KI8gBR4kG3jn1ywxQl6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbhRrnHI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b717b0f80so91951e87.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767822813; x=1768427613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwYyN47XdExhmtpr22dRuy2KKRRsROowGgiRYq00HHY=;
        b=cbhRrnHIwSxba8s0l+xIuvvGw1khORdElAWEc/iAYgbxmrtdVJ+/nl7MRtrVd4IgOX
         QW171/Z65LOS1TUPgrNDNZrCbrdzUkB4I9QLNf3jKgNQT7WbitpncEEMKSH0bsH5ZkxN
         uidK2ckuvLif3cjDxAcfF4me7fW/i9I1giLE9oY08+DI+KsCxNFzAeGxju9csKHUu0Ia
         jzcm47lBRP/VGQshHncMq8T0K+yi7Y+owMZCZD3NNwA4qYW1nH/1N2IxArVZe6J8Lplz
         Rocr4FByVMgCkcNlAPg93tmb92saOKZuz4Ah+RmQpYvm/a1yAqjwTDsMxAGqYDf8Xblh
         QR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822813; x=1768427613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwYyN47XdExhmtpr22dRuy2KKRRsROowGgiRYq00HHY=;
        b=XQAt1f9tcCovwTaVOi9OuRyN1fSjDn0v2vG78b7EC/1gHkeb+gd/T/8KSeWSlRY+nG
         x7Rp/gOBF3wg0lAj3/CubX79vFY0Jyhoc7NCNhezcpZjqR5n0lkddJ0VzfcWUclzOmCi
         xwzkZUNuHq8Eo+xlBcol7Qcq1m2V36d/0Ev5PcDyuPX3JOsCelIEH3FZzActA43ouzgX
         0u7d8OWDZ9Wmbzy3pP0IWObVJ1mppJEI0LV271WqZLqwFTbqpk4Z4uIA8syHIx+QYdV6
         j0ce+0Dl3ci3ijCkLW145m1Wq+EdJY7grTLAg/7JYPO+xhe0hgb6FcEgbA7TAmhgBHzD
         0B4A==
X-Forwarded-Encrypted: i=1; AJvYcCX61fvIto7Ttwd01J/DlNUugGTwDy/67D7XiwhEOYcAYSLf2vZgdF7UFfs1TlFOgMzxASd8wk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2AFt/x+38NBr2DRbNEzuO9o+0kjsEY7T7qpySTb/dXUeKuCS
	EuwZsY991TmovBx1U97261VqPa/hSnQDQPS+HrsgOT/Wbitu/OU5y1LSzB2+IEl5AoYVNJ2CVTY
	9pJ++
X-Gm-Gg: AY/fxX4KxzxI8Nj5y4W59quz4srt52jsl+RkOGDhuxC3jYme4Tu5PFlkYPicmBzCJVq
	2nzYq1a7gDKmDEV7ybeXmhNhdHxwQdsm2uvIIqDyQBZNNFcJMQliiFLJIxIhIVbfIb2KGfFrHlw
	5XT87AH5BHZAEh460RQVY9czL0Jm9cNgjQkQHfL1BWYmasQl9wvCFxpSsfUY/pxUzzbtCuMWFjc
	v496x0bfvyRemKIbwQKEIABTRdqXcqJ8IYB+5UTk+oe+8gC0Zp3iNGXgxpYqBwA3PGje9HgbdVY
	sgFbJMZuW0kVfoEF1eL//lkXSjTN5C6CwzoCV2+DMmluTyqnmNFDa3VSivLONptNkYeM8Tjy3ql
	S4aycMGi+r+3k1lUk1xEjL71BxHxuAFANp+Q/VlprlhqlEgggqUS9NzrJhY5v34sRy9yvy/40AP
	vldnYVx9vYeMYl8Wq0Y4GBai2nBiHvUdtZcepIWUYymCOiU0AAGi9r6er9Oe8FdLVo2BEc+Hmfw
	P3U
X-Google-Smtp-Source: AGHT+IEnE7TRgr0qgv5X/Q7XVeME7jEJg54IM1ntnuvOBQBuc3vf8rcsAvJ6z2UwtAWIpQusEkXc/Q==
X-Received: by 2002:a05:6512:3d1c:b0:59b:1d24:7db7 with SMTP id 2adb3069b0e04-59b6ebd30d8mr766233e87.0.1767822813450;
        Wed, 07 Jan 2026 13:53:33 -0800 (PST)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d6985csm1566062e87.78.2026.01.07.13.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 13:53:31 -0800 (PST)
Message-ID: <de0d0f9d-be70-490d-9cc0-53f017c69985@linaro.org>
Date: Wed, 7 Jan 2026 23:53:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] media: ipu-bridge: Add DMI quirk for Dell XPS
 laptops with upside down sensors
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bryan O'Donoghue <bod@kernel.org>
Cc: Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
 stable@vger.kernel.org
References: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
 <20251210112436.167212-5-johannes.goede@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251210112436.167212-5-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 13:24, Hans de Goede wrote:
> The Dell XPS 13 9350 and XPS 16 9640 both have an upside-down mounted
> OV02C10 sensor. This rotation of 180° is reported in neither the SSDB nor
> the _PLD for the sensor (both report a rotation of 0°).
> 
> Add a DMI quirk mechanism for upside-down sensors and add 2 initial entries
> to the DMI quirk list for these 2 laptops.
> 
> Note the OV02C10 driver was originally developed on a XPS 16 9640 which
> resulted in inverted vflip + hflip settings making it look like the sensor
> was upright on the XPS 16 9640 and upside down elsewhere this has been
> fixed in commit 69fe27173396 ("media: ov02c10: Fix default vertical flip").
> This makes this commit a regression fix since now the video is upside down
> on these Dell XPS models where it was not before.
> 
> Fixes: d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
> Cc: stable@vger.kernel.org
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix fixes tag to use the correct commit hash
> - Drop || COMPILE_TEST from Kconfig to fix compile errors when ACPI is disabled
> ---
>   drivers/media/pci/intel/Kconfig      |  2 +-
>   drivers/media/pci/intel/ipu-bridge.c | 29 ++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
> index d9fcddce028b..3f14ca110d06 100644
> --- a/drivers/media/pci/intel/Kconfig
> +++ b/drivers/media/pci/intel/Kconfig
> @@ -6,7 +6,7 @@ source "drivers/media/pci/intel/ivsc/Kconfig"
>   
>   config IPU_BRIDGE
>   	tristate "Intel IPU Bridge"
> -	depends on ACPI || COMPILE_TEST
> +	depends on ACPI

Why this change is done? Apparently there should be a new dependency on DMI.

-- 
Best wishes,
Vladimir

