Return-Path: <stable+bounces-123200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B4A5BFBF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ED01899EF8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E525487F;
	Tue, 11 Mar 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8u739UW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A524169E
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693881; cv=none; b=YxXKy5eV2KPXA1BVnYo7LdVrN04U2fAVa4cvW3ONvBcGvTYJyJ5odPYdaw8DJYUCLBE6b07LEhzrrhsIkpFpORcvKF9RrFnPShipvOTR6zIPN7YfJ/A0DS8HzlAHDaIfjUuZkgajxg2bO/4aBtAQlBGDOBlej6wiCtC+27/mdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693881; c=relaxed/simple;
	bh=BRGPhWKMTP+x9rObzblyv23NkvpwSnlwYHn/rxeU66M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjSoOUBfwPReFd9P8w+D3H+DXUk43ZZW+rK4HwmqtJuNmgTIps4/aOcZUEfjRqwLQ3j9Nt3UPPUKmUN5PbH40NFkpDRLLT6pqtWtltSyTzc3SkjxSSwY12E6HuFxhG21Gu4+8fUg7FzzPKk3R7jMhPIozWxruOuL2y6x68Xa9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8u739UW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so10413571a12.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741693878; x=1742298678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYI2xGqGMCChSdpu+7M/u63WF0nwaKmmkm/WTEBGB08=;
        b=o8u739UWMMOs+Pm1NqqK2R6vRtCnw8iRSOeqfoYNG6dFHt9O5PtXH1TzSqjnN3Yjp8
         x3TKfkWwEcjV+3RsMAUPlKcdu/2eWqfv2uGzI7aZIeJlWOPcc/25TbO0SNRAC0wT6NLF
         ZVMk3qjiGkJNjM/s9zQBhGIk3Vph5T5DDVQFHccH0CTte2IzqOPsKrGJtd/TL4Nrf1lw
         FA26eIDH85RsDo8Ion5+6F66ZwLhfyIct304ebYEfJ1ianVYXdpXpnylxDnsflWmsQvv
         OXIqYjrXqQX3FKiPDQ85M+KGc6im6+wLKyA6t+dWccscTw8sH+bWMfhIUlH26k3xQU/c
         I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693878; x=1742298678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYI2xGqGMCChSdpu+7M/u63WF0nwaKmmkm/WTEBGB08=;
        b=W7LhoCQR58z1pRlcvALKW21CLxhffRdyHnExwpQyebwXAgUB0RkoImsDvb1P04MbJ0
         AW8Tm3BivMA4Tmt5PVi1BsfmdAZv9k0OxjEF/rhwpuuAgRMm0KbjuKN2Wzu4qVReoSE5
         Z4OzNpCELBhkvzlTz8+KyOHsmsamWVGT1LfWl4/Xd4Z/wiidiKU/RMyqVCu25U2vXMgD
         V4KoWsirGb4Fz/U4VVXWLk+UHwH6kUevkoR+K71j15GMUHMZHsblbp0rXfOWgtN7GI5A
         ZqgL1N4eAtNil9H/RpXk3VpkoM9eZOqiVYc9HkQiBvRYM7cBkLMUsqw5VrZoDxT0Gi4t
         aztQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvPDBGMaOtYUKVqA9NaY67b/VrpEBNAQD2HhdcQwDV5Lx+kGZGWybH0ifU+NsGkpQMHG8RcYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjihjAR6HYq2JEYMYDbWMAPnF3sTLNLbEJ8SNETSngSLfH+1o
	ESMuIhgRv/3epNyePylPIwJwM/hTcFjxZU6iG6AJuE25M7HAoHFIN3kGWB38EtY=
X-Gm-Gg: ASbGncu84dCIq9+0ogWGXwBka1+KPIVHJJgpmsHTlUOFU58bOOEVApXtGU1QC3EneJr
	Bke4jkLU6hbVqRRANXS5T/4nMblQIVDaxfwGhS51YCHOs97WhVvW2sn5wovLkCjPD6ox1vZmce5
	4lUuA2jixvqz8Ai8KNah4Gbj8g0OiHmZoaRd0r72SHWQweBMLs0oSt0s95RtY6FrKffZbjEr41z
	LlBkzOki84a6lXVqya1TdHIsufcmgTUa39ncuWbYMYd7XtondpQq41cQnxnPWsX03ZA0OGnSo5R
	Z+J05cGagGCpYd/fRVvD3SdpwSxWjzCnOvqQ+xtZGKMlIUmHjRVnwgIdjL45UauLoVT0AhPerkJ
	rLEz4j6Hneg==
X-Google-Smtp-Source: AGHT+IGjcdw4Qq6ZKkHAGN5K1gnRweSu2n2zrgdK5INR0vyUxjP11ElEAyNgg/FQtxdpk2Bibc79GQ==
X-Received: by 2002:a05:6402:2712:b0:5e6:6cc2:696 with SMTP id 4fb4d7f45d1cf-5e66cc21070mr10282823a12.14.1741693878159;
        Tue, 11 Mar 2025 04:51:18 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fca8sm8078637a12.4.2025.03.11.04.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 04:51:17 -0700 (PDT)
Message-ID: <10c7a09f-8c76-4815-bb62-39100f45e8ef@linaro.org>
Date: Tue, 11 Mar 2025 11:51:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: ov08x40: Extend sleep after reset to 5 ms
To: Hans de Goede <hdegoede@redhat.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 stable@vger.kernel.org
References: <20250311114844.25593-1-hdegoede@redhat.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250311114844.25593-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2025 11:48, Hans de Goede wrote:
> Some users are reporting that ov08x40_identify_module() fails
> to identify the chip reading 0x00 as value for OV08X40_REG_CHIP_ID.
> 
> Intel's out of tree IPU6 drivers include some ov08x40 changes
> including adding support for the reset GPIO for older kernels and
> Intel's patch for this uses 5 ms. Extend the sleep to 5 ms following
> Intel's example, this fixes the ov08x40_identify_module() problem.
> 
> Link: https://github.com/intel/ipu6-drivers/blob/c09e2198d801e1eb701984d2948373123ba92a56/patch/v6.12/0008-media-ov08x40-Add-support-for-2-4-lanes-support-at-1.patch#L4607
> Fixes: df1ae2251a50 ("media: ov08x40: Add OF probe support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/media/i2c/ov08x40.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
> index cf0e41fc3071..54575eea3c49 100644
> --- a/drivers/media/i2c/ov08x40.c
> +++ b/drivers/media/i2c/ov08x40.c
> @@ -1341,7 +1341,7 @@ static int ov08x40_power_on(struct device *dev)
>   	}
>   
>   	gpiod_set_value_cansleep(ov08x->reset_gpio, 0);
> -	usleep_range(1500, 1800);
> +	usleep_range(5000, 5500);
>   
>   	return 0;
>   

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

