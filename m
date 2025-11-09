Return-Path: <stable+bounces-192863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E6C44975
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B6A3AE5F0
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15F26E6E5;
	Sun,  9 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkeimSsK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4523D28B
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728631; cv=none; b=BW2eRzgQ/ClllW5hHScNLXUlCUMjb1tmr2+IvYKDg8+kA/ReLNqH2g9Vo59soRRXGTWFeFGH7gof6fBzXE+ITXlsxdNjAHflplfmBWhnAfo9xSlLb2KTumVPXvH9hjryFLlAXV+0jy+FJmFhwJmGjVgFk1ij06vXk+XLwQZEp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728631; c=relaxed/simple;
	bh=feQlK9sRBfw9QQ3QBugD4K/9zKK3X24S75c2Y3ixmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0TxWbqL0GtrSozbE7QkoYX4BHTXBpiqnqtCspZPThKg4t7+nqd6DbIIOexBjgJ5yMGjhbIVc0L8qQe8QUmg46zzLVBUuYVAVny/D7I6bje4BLkOTbwrPZwPGokHOZ1jbTbmfpvjcPRv2FrHD27jHPZWET/bG7dvIbpFqB2Qi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkeimSsK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so23694f8f.2
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762728627; x=1763333427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6cr2xzWCs5FTcj31R1wdIQxB8hrivWGS3hQiw3OiHE=;
        b=jkeimSsKIy7qeGKhd3m87VKShAqUTTEWWx5CjDYu1/VYAP5E/sOJ8cg7UovOXUXa9c
         g63z99moJt5LIZ5ktMQMxn1bTSl91wHdxgawf9hTtVMRO53owgDHsc8/djSGh11g2oo7
         +sZEC4LZpuDkY8RGIoB7bS/dv/1hWflWkSx2pD3bhVaK5x5NXWtiMWWwbmX/0widw+hY
         gWF/BcN/M1oMpHKCdt3rbYz8rIB3eT1HbCDemUd0KxojBloN2ha/HWjAmk8rjQaV/N4u
         kYKdj3hMrcm9gWaxf7+TFlQZvppQH/HiyrFWCRGFjk8Wxo2K+jGY1CO7G5vLv3i6uDEp
         /MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728627; x=1763333427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6cr2xzWCs5FTcj31R1wdIQxB8hrivWGS3hQiw3OiHE=;
        b=D6YzeAYNw1sy6FDdHWrp0uDz2wuObB+JS7TARX4rcZcL31TRfwf6fpCtURAMiVNmg2
         6JyTbZAkuq3/ZBnSyenZW00Uy0YdxAPVABYvaqAhRsZW4i9FJhA4eP7MhfHkprNF15kW
         QfRlOVKqWj9cj7SUztBJCbCKHX4a4yMAHgmg7Az1F34dFOau2QiEm4K95w3ktg1TmpuR
         UtrMZFgz9nvQsa55hm3o7H3V1VlWbIvb84iNqBWN11j/PEEXyFw8xFRPs40IsQLXgI/K
         11fZ5DRWOVUFDQRcxG/POT4qg9c9FZpdhsbTDxFkcZNbGnH4No3LwEei0ARt3i+/wd6S
         eGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozX4mcBtEhMt26Wj0vaxCuLwF2RfkKzJJCR82CUdE1fsd5uNaoF1SWaekE9FsZFH2kOzTSqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQC/rJumx01Ro91sunShZ9acQ1Hryuv3MrKJklG+f/obVuIyX
	e2E9w4TvPDsMmXXY/H9W6v4H582QNc42QHEevo1s8cHe512Mwd1LaZAG
X-Gm-Gg: ASbGnct9UgzajnnV+mk8T9ju1yrWg4LCRICEr3w3PwTOt2XtOCJr7qd627profZ+CYd
	EoRiexxxC/c11I5aPP7gjK0b7ufJF0R9uG82i0Ohn2xGI/1oghmR5OytPeHik3EspFHfZYt+UKR
	iev2VOtCToKiM70CHcxYNthK/AcVVaT9CC5YpWxUHkdKa8VfqVKkkD2myPFiPl6gtig1msSF9Ro
	Zp0VqI05XngswkNcYC/1Hk0HfGUZfdiPCZq/oUZ4SZTOek8fLvnwpc5PT20oB7idK8rRBnbd4W4
	Mp4F5L2c7WLHNzp/M0fGHzTAUrm8MwpCG1xobQZMDD7orgM+BuyWN5rc/v3giyFZQHr1EM+rM6T
	oaxAxhyC/8FPjaXOG8PyJPm8PmGX2hRYBLPTdKf3/aWPX5ohSjP9zNQpkkhiNerXiqXB4V1z+2s
	DnHg6/JT+VPKYLbOKNbrZMZ9LDVZhkRKhIAGGQ2P8OZg==
X-Google-Smtp-Source: AGHT+IEG6WKTIBPs7qZkZkS2TjZf+ibN3W4+z5yD9CPSWtzIene0C/VzFc03+ZucxIWlJRb5Wo46+g==
X-Received: by 2002:a05:6000:2c01:b0:429:d350:802d with SMTP id ffacd0b85a97d-42b2dc9e34dmr5278025f8f.45.1762728626881;
        Sun, 09 Nov 2025 14:50:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm18834631f8f.40.2025.11.09.14.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 14:50:26 -0800 (PST)
Date: Sun, 9 Nov 2025 22:50:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Huisong Li
 <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
Message-ID: <20251109225024.186845bb@pumpkin>
In-Reply-To: <20251030155614.447905-1-thorsten.blum@linux.dev>
References: <20251030155614.447905-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 16:56:09 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
> 
> Fix this by parsing the 'buf' parameter directly using simple_strtol()
> without allocating any intermediate memory or string copying. This
> removes the overflow while simplifying the code.
> 
> Cc: stable@vger.kernel.org
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> 
> Changes in v3:
> - Add integer range check for 'temp' to match kstrtoint() behavior
> - Explicitly cast 'temp' to int when calling int_to_short()
> - Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Fix buffer overflow instead of truncating the copy using strscpy()
> - Parse buffer directly using simple_strtol() as suggested by David
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
> ---
>  drivers/w1/slaves/w1_therm.c | 102 ++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 9ccedb3264fb..1dad9fa1ec4a 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -1836,59 +1836,32 @@ static ssize_t alarms_store(struct device *device,
>  	struct w1_slave *sl = dev_to_w1_slave(device);
>  	struct therm_info info;
>  	u8 new_config_register[3];	/* array of data to be written */
> -	int temp, ret;
> -	char *token = NULL;
> +	long temp;
> +	int ret;
>  	s8 tl, th;	/* 1 byte per value + temp ring order */
> -	char *p_args, *orig;
> +	const char *p = buf;
> +	char *endp;
>  
> -	p_args = orig = kmalloc(size, GFP_KERNEL);
> -	/* Safe string copys as buf is const */
> -	if (!p_args) {
> -		dev_warn(device,
> -			"%s: error unable to allocate memory %d\n",
> -			__func__, -ENOMEM);
> -		return size;
> +	temp = simple_strtol(p, &endp, 10);
> +	if (temp < INT_MIN || temp > INT_MAX || p == endp || *endp != ' ') {
> +		dev_info(device, "%s: error parsing args %d\n",
> +			 __func__, -EINVAL);
> +		goto err;
>  	}
> -	strcpy(p_args, buf);
> -
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> +	/* Cast to short to eliminate out of range values */
> +	tl = int_to_short((int)temp);

What is that all about (still) ?
The function name doesn't match what it is doing at all.
The comment is completely 'left field'.
You seem to generating an error for values outside INT_MIN..INT_MAX and
then using clamp() to convert large -ve values to (probably) -128 and
large +ve ones to +127.
If that is what you want (rather than erroring values between 127 and
INT_MAX, or just clamping values above INT_MAX on 64bit systems) then
after the bound check just do:
	tl = clamp(temp, MIN_TEMP, MAX_TEMP);
then the same for 'th'.

A little later perhaps you want:
	if (tl < th) {
		new_config_register[0] = th;
		new_config_register[1] = tl;
	} else {
		new_config_register[0] = tl;
		new_config_register[1] = th;
	}
Probably even before determining info.rom[4].
The generated code will be better (especially on non-x86) if
both 'tl' and 'th' are 'int' (not s8).
In fact, just make them 'long' - probably as temp_hi and temp_lo
and kill the 'temp' variable completely.
		
	David



>  
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -
> -	/* Convert 1st entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> -	if (ret) {
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> -	}
> -
> -	tl = int_to_short(temp);
> -
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -	/* Convert 2nd entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> -	if (ret) {
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> +	p = endp + 1;
> +	temp = simple_strtol(p, &endp, 10);
> +	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
> +		dev_info(device, "%s: error parsing args %d\n",
> +			 __func__, -EINVAL);
> +		goto err;
>  	}
> +	/* Cast to short to eliminate out of range values */
> +	th = int_to_short((int)temp);
>  
> -	/* Prepare to cast to short by eliminating out of range values */
> -	th = int_to_short(temp);
> -
> -	/* Reorder if required th and tl */
> +	/* Reorder if required */
>  	if (tl > th)
>  		swap(tl, th);
>  
> @@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
>  	 * (th : byte 2 - tl: byte 3)
>  	 */
>  	ret = read_scratchpad(sl, &info);
> -	if (!ret) {
> -		new_config_register[0] = th;	/* Byte 2 */
> -		new_config_register[1] = tl;	/* Byte 3 */
> -		new_config_register[2] = info.rom[4];/* Byte 4 */
> -	} else {
> -		dev_info(device,
> -			"%s: error reading from the slave device %d\n",
> -			__func__, ret);
> -		goto free_m;
> +	if (ret) {
> +		dev_info(device, "%s: error reading from the slave device %d\n",
> +			 __func__, ret);
> +		goto err;
>  	}
> +	new_config_register[0] = th;		/* Byte 2 */
> +	new_config_register[1] = tl;		/* Byte 3 */
> +	new_config_register[2] = info.rom[4];	/* Byte 4 */
>  
>  	/* Write data in the device RAM */
>  	if (!SLAVE_SPECIFIC_FUNC(sl)) {
> -		dev_info(device,
> -			"%s: Device not supported by the driver %d\n",
> -			__func__, -ENODEV);
> -		goto free_m;
> +		dev_info(device, "%s: Device not supported by the driver %d\n",
> +			 __func__, -ENODEV);
> +		goto err;
>  	}
>  
>  	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
> -	if (ret)
> -		dev_info(device,
> -			"%s: error writing to the slave device %d\n",
> +	if (ret) {
> +		dev_info(device, "%s: error writing to the slave device %d\n",
>  			__func__, ret);
> +		goto err;
> +	}
>  
> -free_m:
> -	/* free allocated memory */
> -	kfree(orig);
> -
> +err:
>  	return size;
>  }
>  


