Return-Path: <stable+bounces-59405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9899326BC
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246162848B0
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5919AA64;
	Tue, 16 Jul 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXzN2oqs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889D19A87D
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133772; cv=none; b=bAksD4BKcHY51NGoZs0Gkk4jxqp5dWai1a3OjcOh7Owk6S5Q+Myv7qpka26hvntkmjgrMvy4bGPI8Z2BW1oOzmRNbBXBSlFuU24Xs1j97+FclM98kjvozVN10Q8uAIPdXojOWmkA6GT3ETda4WGgW2C6y1VjbWByKBNtg4plVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133772; c=relaxed/simple;
	bh=VJJZquS/P0YNc9UeBC9Nt7mXot1B5hUOhRYzxYu3GJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpcDmimlYm3D/sB5110ho3AB1A98aJ7DFOX4BLyy4cYj8T1h2i5snj7xGcp0IJEB+L1BIsUUxr8GgexSWMf8MOODpC0NFguTD0vkVjACbwx6Yyim2I4MMH71hb99gW2u+qxZp0Kq0gSn6YGfLUJVFaTWZgXeeB3hAXJAW6nx220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eXzN2oqs; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso37855185e9.3
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721133769; x=1721738569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDOFu1w1GjC5O3toNyE2qTxbfeyv2wcTcN9pFC2ABm4=;
        b=eXzN2oqs4Aeub4OWqozwIHe2wM1yiyzl99znXTYfX8TMoSEaoLJ8ksWoD1gqvZIkEx
         KSR/SpWB5XWNx8tfPmxQdyDJIIZKoejHSYxdUnQUvkqD/AL5HutkC9OOAB9CvzvuqfPy
         CXwN2Ftg7Wyv6uuWW4vd0XoSBXwbCYT58xsP+EqgMlYFm50/j31AVqqgtUdbNPpbg/cj
         rcrW9wK0/4PuztMUUlK2cko5X/SvxhHg4JBOTCnO3mKTsab+TXiBPRznNRXkd/ZXPmh+
         qjKzAfL5aFJ76GjAVURy0fQWqXwPXUU5PDGui4+RozYLzdrqTN9scLlJhetpmpcvCQlt
         g3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133769; x=1721738569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDOFu1w1GjC5O3toNyE2qTxbfeyv2wcTcN9pFC2ABm4=;
        b=uQ2nT2b7YQqabcUD3d9pl4sLC94oNet+Rxe8lOIyUaHcZSAL556fhmnqv+zBzmJjt7
         sw5MOb07wiWsw7mA/9M/N+/vdWBr5OvCUuTDtiyj4HpWBAKSJrlAfzbL2bw2dwvkLQVr
         UbNW/q05uPUu87UtQ0+aBhgHfeEGOBXbW+Uc5LDx4JoIxSXq6doDcltPU9LREeKFRB48
         nqPKL6bKBum7EhE9hBqtCqKpzK+w0OHGsuGXIiu5lWVLump37wDbExys2Ib9uop6lUuL
         AMiYh6pOWZCoM5F3kgpkwB/NmzrdpnNMyua9hZzgROoruuP18OG2GXW5VdazZWh1D4ZM
         k+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWc8Qybd0H5VFQA8se49gwclXQvItFbDWbv/yq2dmtfBEhSHW9SI4j4h4xSXe9g3SaSuoaz8VbBl3R0RHOZOtCpjh0nN0g/
X-Gm-Message-State: AOJu0Yw1PI+csasnI91Ap4Nr/9/wS1tDejFoqYd/HxvBSxmx55fK+ZI+
	kyeJzXRaZtxaAl2EUJsY54/rMs/cABkj9SyplJemj+8gl/AE0mMh9XQizWyCAgI=
X-Google-Smtp-Source: AGHT+IHVhasDFRpNi8H81iWLBfyj86iIjk8RqZ5Dg+VMsBjYFk6zW1zKZ8bejyuXVEkAukw39EHSpw==
X-Received: by 2002:a05:600c:4455:b0:426:62c5:473e with SMTP id 5b1f17b1804b1-427ba697989mr12541385e9.26.1721133769202;
        Tue, 16 Jul 2024 05:42:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:1e82:77b7:9ac1:bc6c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f259761sm157780385e9.11.2024.07.16.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:42:48 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:42:44 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: return EAGAIN when firmware
 service is not up
Message-ID: <ZpZqxEof85jo-1K3@linaro.org>
References: <20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-16e842ccead7@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-16e842ccead7@linaro.org>

On Mon, Jul 15, 2024 at 02:57:06PM +0200, Neil Armstrong wrote:
> The driver returns -ENODEV when the firmware battmrg service hasn't
> started yet, while per-se -ENODEV is fine, we usually use -EAGAIN to
> tell the user to retry again later. And the power supply core uses
> -EGAIN when the device isn't initialized, let's use the same return.
> 
> This notably causes an infinite spam of:
> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> because the thermal core doesn't understand -ENODEV, but only
> considers -EAGAIN as a non-fatal error.
> 
> While it didn't appear until now, commit [1] fixes thermal core
> and no more ignores thermal zones returning an error at first
> temperature update.
> 
> [1] 5725f40698b9 ("thermal: core: Call monitor_thermal_zone() if zone temperature is invalid")
> 
> Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
> Cc: stable@vger.kernel.org
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

The "failed to read out thermal zone (-19)" error happens on 6.10 on the
Qualcomm X1E80100 CRD too. This patch fixes it. Thanks for looking into
this! FWIW:

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  drivers/power/supply/qcom_battmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 46f36dcb185c..bde874b5e0e7 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -486,7 +486,7 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>  	int ret;
>  
>  	if (!battmgr->service_up)
> -		return -ENODEV;
> +		return -EAGAIN;
>  
>  	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>  		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> @@ -683,7 +683,7 @@ static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>  	int ret;
>  
>  	if (!battmgr->service_up)
> -		return -ENODEV;
> +		return -EAGAIN;
>  
>  	ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>  	if (ret)
> @@ -748,7 +748,7 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
>  	int ret;
>  
>  	if (!battmgr->service_up)
> -		return -ENODEV;
> +		return -EAGAIN;
>  
>  	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>  		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> @@ -867,7 +867,7 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
>  	int ret;
>  
>  	if (!battmgr->service_up)
> -		return -ENODEV;
> +		return -EAGAIN;
>  
>  	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>  		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
> 
> ---
> base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
> change-id: 20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-c5a2f956d28d
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

