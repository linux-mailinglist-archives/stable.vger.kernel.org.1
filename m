Return-Path: <stable+bounces-197630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FBC9308F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4A1534CC43
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2C32ED3D;
	Fri, 28 Nov 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="dTbux98G"
X-Original-To: stable@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F482D543D;
	Fri, 28 Nov 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764358657; cv=none; b=Tq7nC249b4Spja0KacLAgP+j4i5u6kCmIg/bpeE3LLJUkh7XaWiY5KN/yruZDWXnkDFdnExxzdP7w6wvT5PAQ05g78jKkBa8xmhR3Ak0RO7kUeK+ZCEQzwAkTGnTiAixvaPz/caYWREe31F8sCBuTpNYfJAtqzKVuPsXIkYjM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764358657; c=relaxed/simple;
	bh=Tu92tSYiiI8OLTUptK9rmmlury0hxJC+jIINSxWNnPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL9PpidQxGg/CMxubT+R9zTbBxPIO3nauE3GXV9Azpo1bRmvnG2HeLqGViSYktSI2VqVq4p2JFXYpzWqq9R/OO3eTY1whhnF1BmuGqu3YjmPkHWKIBX4B5oiJ9Yf8W/WdbTSxAtAi4d+zipndnqCb9jK60R7XxqBaNo12b+PUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=dTbux98G; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vP4Hc-00GxiK-9J; Fri, 28 Nov 2025 20:37:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=tFUu51b64ZhLY0G6AJnWM6/dq60Fbw6fVa/fMfghShg=; b=dTbux98Gpwk8o9mdfuqVU6gv1M
	fWwUL6cAQerOMkuqWzK+NjkZD/Oo+ngKJkezUmVTEAXieTBRGehHFFcCeKZP10GdRHb3tz9RZKWLR
	mHgHMGXDmzWZDNQyjk+csitorUcJWQ9ftgPO5ksPIdpmlbhM57VlFc52qLzoMRMklnhWC1OWkydU+
	/YTJpC754wmgCr7mAai5fpOzo1aKlat+wNCMqwkRsrbcN8hd5Mk9bKBcY+HaED9poN9x+kcfZrn2W
	vFS4gVvOhlnRNvC9K+HKHBYSRh70qclO+IzU5Xh1AvosyletokiZ7SRa6/HCztkn1K2iRbi+jQ6UJ
	WHjPOsDQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vP4Hb-0006Da-Dz; Fri, 28 Nov 2025 20:37:31 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vP4HS-001Z7h-Ii; Fri, 28 Nov 2025 20:37:22 +0100
Date: Fri, 28 Nov 2025 19:37:20 +0000
From: david laight <david.laight@runbox.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid
 TOCTOU
Message-ID: <20251128193720.0716cc6d@pumpkin>
In-Reply-To: <20251128123816.3670-1-hanguidong02@gmail.com>
References: <20251128123816.3670-1-hanguidong02@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 20:38:16 +0800
Gui-Dong Han <hanguidong02@gmail.com> wrote:

> The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
> multiple times. When used in lockless contexts involving shared driver
> data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
> conditions.
> 
> Convert the macros to static functions. This guarantees that arguments
> are evaluated only once (pass-by-value), preventing the race
> conditions.
> 
> Adhere to the principle of minimal changes by only converting macros
> that evaluate arguments multiple times and are used in lockless
> contexts.
> 
> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
> Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> Based on the discussion in the link, I will submit a series of patches to
> address TOCTOU issues in the hwmon subsystem by converting macros to
> functions or adjusting locking where appropriate.
> ---
>  drivers/hwmon/w83l786ng.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> index 9b81bd406e05..1d9109ca1585 100644
> --- a/drivers/hwmon/w83l786ng.c
> +++ b/drivers/hwmon/w83l786ng.c
> @@ -76,15 +76,25 @@ FAN_TO_REG(long rpm, int div)
>  	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
>  }
>  
> -#define FAN_FROM_REG(val, div)	((val) == 0   ? -1 : \
> -				((val) == 255 ? 0 : \
> -				1350000 / ((val) * (div))))
> +static int fan_from_reg(int val, int div)
> +{
> +	if (val == 0)
> +		return -1;
> +	if (val == 255)
> +		return 0;
> +	return 1350000 / (val * div);
> +}
>  
>  /* for temp */
>  #define TEMP_TO_REG(val)	(clamp_val(((val) < 0 ? (val) + 0x100 * 1000 \
>  						      : (val)) / 1000, 0, 0xff))

Can you change TEMP_TO_REG() as well.
And just use plain clamp() while you are at it.
Both these temperature conversion functions have to work with negative temperatures.
But the signed-ness gets passed through from the parameter - which may not be right.
IIRC some come from FIELD_GET() and will be 'unsigned long' unless cast somewhere.
The function parameter 'corrects' the type to a signed one.

So you are fixing potential bugs as well.

	David

> -#define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
> -				  (val) - 0x100 : (val)) * 1000)
> +
> +static int temp_from_reg(int val)
> +{
> +	if (val & 0x80)
> +		return (val - 0x100) * 1000;
> +	return val * 1000;
> +}
>  
>  /*
>   * The analog voltage inputs have 8mV LSB. Since the sysfs output is
> @@ -280,7 +290,7 @@ static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
>  	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct w83l786ng_data *data = w83l786ng_update_device(dev); \
>  	return sprintf(buf, "%d\n", \
> -		FAN_FROM_REG(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
> +		fan_from_reg(data->reg[nr], DIV_FROM_REG(data->fan_div[nr]))); \
>  }
>  
>  show_fan_reg(fan);
> @@ -347,7 +357,7 @@ store_fan_div(struct device *dev, struct device_attribute *attr,
>  
>  	/* Save fan_min */
>  	mutex_lock(&data->update_lock);
> -	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
> +	min = fan_from_reg(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
>  
>  	data->fan_div[nr] = DIV_TO_REG(val);
>  
> @@ -409,7 +419,7 @@ show_temp(struct device *dev, struct device_attribute *attr, char *buf)
>  	int nr = sensor_attr->nr;
>  	int index = sensor_attr->index;
>  	struct w83l786ng_data *data = w83l786ng_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr][index]));
> +	return sprintf(buf, "%d\n", temp_from_reg(data->temp[nr][index]));
>  }
>  
>  static ssize_t


