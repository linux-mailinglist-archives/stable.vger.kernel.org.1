Return-Path: <stable+bounces-172853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846EDB33F91
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489EA205637
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB84274FF5;
	Mon, 25 Aug 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lma77gxy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6772701C2
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125220; cv=none; b=ebO1q5hOIk2+sZxmtaU3uYllagQfXyr03lfTbGSuWc3d5ecp6WsXCf1D/1dKDB+R/mVjCqZzMYLjg7u2kWRqR8JuDq9F17dNLaWaGG/Qml9edN5DyR9YB9Gpw/NWISRoicRMuuPyaqQz/R/ezVhd773+AzMe+id3FB8PR8gkwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125220; c=relaxed/simple;
	bh=Ty74hZnXxWKvhet9JdbuwC8Mits1/1r65GA1qNGnYFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqGEqCANsLG9KI+bqXqTtYbo4bwIPQ66cCnMXETZDzb+3K52SOYaEXGShFld/nV5xV7vEV97vYeH1yW6RoiYwrnqQaVoprWoe1zzYISUa3n7nqXHe54x6c6aK6j96lnRwHrCzcPZAwFfT96JgKfJplChM165wqNMSw84ndpbzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lma77gxy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b627ea685so4106925e9.1
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756125216; x=1756730016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TgyYW+EFxanlM3ZuOCikuS7pxBlxHl7zqHrCzYeY36I=;
        b=Lma77gxyhHRtjNh0X14rzN5kkklXGuXPf2ldI/JPx7dv1rtqa0iOF5YFdMq6Ai0ZlI
         UX90Wj5LONh6Jzb5UwQ2W9f/lggNW5gHWe5Oo69ldGV7l76jbZnCa15kId0HeKdTFZ/1
         DQO1n8SAQwTgTQWg1AvhQE2rV7IqGgbc1bes+5tHmZKXSLfGL4FxO6Zgm8udTfaYv8JD
         u4GLeomD0wYMxh2qg5Bwdh//SbTjG/2D+9SUbDsOvKdwj49rwleIS1h7fsvIlEM4M+Dq
         5RtIIqioBdtuYODTY9s/NwcYzom14IQY73p5iMs3TSeBWDLJozVvhcO5CuYbfL5SXSw8
         rUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125216; x=1756730016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgyYW+EFxanlM3ZuOCikuS7pxBlxHl7zqHrCzYeY36I=;
        b=b7LkGvZeOuzWiaSnKzbaJ9JeB4x1AwqCHYjF63Pn41gXuzUo4D/SgZNk5maLelhr0E
         c8D9cr9zLNVSS/VNxHPNJbW2dLykn4HzLqvrxBK7xzphPcGMDSfvcpcz8hQMGUMKxLu8
         m10w7SK3S0eCkq0/y1w3kXrGUq1Tbo7eShc0PJNgNc9JD2IQ3ySpCCg31tlcFkUflL8y
         PLYgCHXS77NVC7XYc+G5yr98f2sGgl3DNx3tUNqFIAWo/IFsAMX+kgmCrU5o00xFoPvW
         /QEsZO+caGfaMnYB4Iwv1kdMhm7UPMZhyfcYYdBcXyoM1afSvAoeWdXPWOlikGh1p1oc
         XweA==
X-Forwarded-Encrypted: i=1; AJvYcCXPHi21p3Gt3Ao5YR4IpjUDm12wKEGEakfGFvpaJxaFEiHt2ABcqBuh2eSezSXk5i2e3HgtuWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9p8Vaiu9vFQq7MU7IzQY2T/m/9PjpcSmN7+mffQVcs/WwLcKL
	pC9KqakWrdwHaxaE4jYCF/7hF4BGW/vd3Qh26d6Q3Bt7lMb5TYZWL2A7pps5SsIzZpw=
X-Gm-Gg: ASbGncti8vhGHYekWxP0WkNmA3Y+Mh/JzzLXVgk0rvhF9sAUpklJPP2D2mtlV0NyLad
	c25642Z2SYuiblFnpj1JxYBGlyPe/o2dDav/53s3eZciiwc2mpD1hnoltzGVtIZe7zsbKXFMULx
	pR05+91zv8G0QX7AzoJg8Q+IMe0XGz5nsWkzb6xyvHl3Ud84LxDfAXcxn8iazbxCsoidjc7ePcU
	+J/aQsfze5gvLYSdcsiNYN7LeNUelVQIpbcGSuFVFiEOP5ky79qA4+vaCDk87oJXcRQtpfw/su9
	c04jQnjLeI0NC2/KsiuCBpUbwg+h6GbHjXyr1DLUJV8AAyKq7ENIePo+r5xwZ0Vn/NXvUjHLO0w
	xk3AtRhXi4nay53+M17GFGk2c224LhOXXweeEFqeIzw==
X-Google-Smtp-Source: AGHT+IG8r5+sVjMa01w8IZgVwuhCEDiGDvftj5dR2IQIaEIX1i8970n/oog07azqK0eoXxNWJVJyPQ==
X-Received: by 2002:a05:600c:1c97:b0:45b:629b:dc1e with SMTP id 5b1f17b1804b1-45b639a0d26mr10121405e9.1.1756125215756;
        Mon, 25 Aug 2025 05:33:35 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753adf7sm107972935e9.7.2025.08.25.05.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:33:35 -0700 (PDT)
Message-ID: <b84dbc22-62d6-4a63-9b53-80e939c36e38@linaro.org>
Date: Mon, 25 Aug 2025 13:33:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: exynos-acpm: fix PMIC returned errno
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com,
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
References: <20250821-acpm-pmix-fix-errno-v1-1-771a5969324c@linaro.org>
 <c744f5da-ed3a-4559-80b1-9cef5254224b@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c744f5da-ed3a-4559-80b1-9cef5254224b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/25 5:50 PM, Krzysztof Kozlowski wrote:
> On 21/08/2025 15:28, Tudor Ambarus wrote:
>> ACPM PMIC command handlers returned a u8 value when they should
>> have returned either zero or negative error codes.
>> Translate the APM PMIC errno to linux errno.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-input/aElHlTApXj-W_o1r@stanley.mountain/
>> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/firmware/samsung/exynos-acpm-pmic.c | 36 +++++++++++++++++++++++++----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> index 39b33a356ebd240506b6390163229a70a2d1fe68..a355ee194027c09431f275f0fd296f45652af536 100644
>> --- a/drivers/firmware/samsung/exynos-acpm-pmic.c
>> +++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> @@ -5,6 +5,7 @@
>>   * Copyright 2024 Linaro Ltd.
>>   */
>>  #include <linux/bitfield.h>
>> +#include <linux/errno.h>
>>  #include <linux/firmware/samsung/exynos-acpm-protocol.h>
>>  #include <linux/ktime.h>
>>  #include <linux/types.h>
>> @@ -33,6 +34,26 @@ enum exynos_acpm_pmic_func {
>>  	ACPM_PMIC_BULK_WRITE,
>>  };
>>  
>> +enum acpm_pmic_error_codes {
> 
> This enum is not used. Size is not needed and you can just use
> designated initializers in the array.
> 
>> +	ACPM_PMIC_SUCCESS = 0,
>> +	ACPM_PMIC_ERR_READ = 1,
>> +	ACPM_PMIC_ERR_WRITE = 2,
>> +	ACPM_PMIC_ERR_MAX
>> +};
>> +
>> +static int acpm_pmic_linux_errmap[ACPM_PMIC_ERR_MAX] = {
> 
> const
> 
>> +	0, /* ACPM_PMIC_SUCCESS */
>> +	-EACCES, /* Read register can't be accessed or issues to access it. */
>> +	-EACCES, /* Write register can't be accessed or issues to access it. */
>> +};
>> +
>> +static inline int acpm_pmic_to_linux_errno(int errno)
> 
> Drop inline
> 
> s/int errno/int err/
> (or code?)
> 
> errno is just too similar to Linux errno.
> 

I agree with all the comments, will address them. Thanks for the review!
ta

