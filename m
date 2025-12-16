Return-Path: <stable+bounces-201238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E3CC21E7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA1B03006735
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA83233EE;
	Tue, 16 Dec 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybbc1HkG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A733893E
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883984; cv=none; b=COt3gJK/yF1x73ANV0SQaeLEHDDJNzW9HB2WT/QVYE3bTXt0s60oINy5A4NoQIndFVP1b05+UOJ6nmZSNIqeLIPgGtMqvxbcVDkIqdPNPm2znYOped60n55+5q4nh6YrI21nLtI5Fgey84bdK54bX8ALlLTY6a3xehSjjPRI5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883984; c=relaxed/simple;
	bh=5FpYV2hyThaP6gxo9Uz3Gaum8K2+2MpBuxtaKA8b8Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMESwsy0xISF/kIb0X8j5DRsP1dXRJfEWR4GNh2LowyfAB2GxwF2h1NUBVmN4hx0KdpU1PFLgLDVGXoAttXV5NMBaCjZqF8UUvYOW/zHibq3Tu3ztc8+d+XB993ZAnfOW9hAlfL3A8ZHAtsIJ4RiXwTD2wuFx/YybjgWOI2+qW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybbc1HkG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b999d0c81so34862481fa.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765883980; x=1766488780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dC+oh+upH5G4XaoqKb2c8YIUZVE9MRCLwR8vX6V5s8=;
        b=Ybbc1HkGPXjuXiPyBxiqh2F0NB/5QqW5KgIxy7OXcxFfhPWC5iITt6jwEaGNZjiIdT
         3IreExrdIjJcWZIcutSgb6mKrodWa1Ip3rLCG9gyth83vLHjNp9OIVmt8Lb/1652NM4m
         +84Hj0bPeD6WJaf2K5TeiQl4moQ+qV5UyITfPNPRk1sqGwI8Xuagi6hqGUQ1iN38JdED
         rRsaZuwJwNKDr5iuouRbILTGC4rjrpogp36+8k+bFWjo2cwBBpQWTRTJKugHDvzdoBIF
         TzP02mvb4VI8Is4Gf8bwkEi8zyutAO5rJuqXXR0qeuGHeoz/jcXNzUdT9ZVV937LzAx+
         7uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765883980; x=1766488780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dC+oh+upH5G4XaoqKb2c8YIUZVE9MRCLwR8vX6V5s8=;
        b=mDJEZvXoM3gW0T2UzdgeVR3jbtCuxHKAock103IMrWF86fgpm7lFKxhr6aD0GDIAdU
         ThidVbegCKKHUW1QaV+i+9e0hwQcQ2BX0+Btt5CCNqLcEbrxKV5xavS/uyiippsk9+YJ
         WAdwyR7CMAet/tgJc7cjiPfi3JZI5iIB6cdke3B7ssDgZHN5vZFmapHLlRZrJcv+g4hT
         O834hLzNeZYKnSwlFxwcxU3+cnPpfw7QRoKTUGGbPAPXUgWaeSk52Uy0UPSvImGFrGUX
         Rw3ne3a+RTWhm7NtOuWK3ZfKoKGQt3T8oA6ZsztbXY34OezxMsJqX07Z7uc3p4eS8JBA
         FkgA==
X-Forwarded-Encrypted: i=1; AJvYcCXRwvhSE2gdozVt96DXLDlvlGRHAJoLA1kUukA2ZYFJaxp87Pm/5qjic4sWB7bbGZUX3AkizlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSx1I78Rb/bkRVjB6E4tBWDzweMiDc8GhTNpHS3xntP1nCiFr6
	woEkT22of5iyowKEqcwhHQ2g0R1fmUsKB3zcu7c+5C5NIv+FXHc9UUtukF6UWQ==
X-Gm-Gg: AY/fxX60MYVsVtpH0s2ZwkmxH7A0t3Or1aXzLPpRNIhe2FMIcc9bNYr8fKcNmYoDVXT
	p0L0yBF2ss6OCfznEeRMfw4/5UD2tKjr43hi+InmNF5bthAeEYqtM3dcpiXNfmWnHz2rhTLul8s
	lYhWM5gxbOycJGmGuhQrtcSKFNLtRZdaCI952C6cSPKmUL+LL/7Q/6sAYNEi3nBuaCnWnZmAUms
	P8VA4HgN9EZ6DKMc2B5VH48KlpwmUkOj6VQj3gvjaXbc+w7YVpvwV7q2My9JBFSfGewe9p1nsTL
	wJWVmHn/AyzqEzXTfyV9JUUvCMlMrzQuPl/fBjbHrLKz9jlv47+p1oxajuBqUtcsdXuaDg8teXN
	DUzDOn3v91NoSkYhMTHcReAAiQgtYCvUMaMBC0IS0uGNPlQFzWyld1FnyQJqwj9dIpkfWZ3ar16
	6bfu2ZndQRZTyCb2xAwCrBxySdwngTIVAwpfY1ccFbngt1ouI7fg25
X-Google-Smtp-Source: AGHT+IEUQefTteAyd6IImKCfTuCbjbOTUUOkytdsSBdw7FpMzi30wrUOr1L+Fr4XI2IVzYyunRrh6Q==
X-Received: by 2002:a05:6000:2083:b0:431:16d:63a3 with SMTP id ffacd0b85a97d-431016d695fmr5642674f8f.46.1765877291648;
        Tue, 16 Dec 2025 01:28:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ff626b591sm22236958f8f.15.2025.12.16.01.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 01:28:11 -0800 (PST)
Date: Tue, 16 Dec 2025 09:28:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Huisong Li
 <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
Message-ID: <20251216092809.2e9b153d@pumpkin>
In-Reply-To: <243ec26f-1fe1-4b3c-ab24-a6ebab163cde@kernel.org>
References: <20251111204422.41993-2-thorsten.blum@linux.dev>
	<243ec26f-1fe1-4b3c-ab24-a6ebab163cde@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 08:11:13 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 11/11/2025 21:44, Thorsten Blum wrote:
> > The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> > bytes and a NUL terminator is appended. However, the 'size' argument
> > does not account for this extra byte. The original code then allocated
> > 'size' bytes and used strcpy() to copy 'buf', which always writes one
> > byte past the allocated buffer since strcpy() copies until the NUL
> > terminator at index 'size'.
> > 
> > Fix this by parsing the 'buf' parameter directly using simple_strtoll()
> > without allocating any intermediate memory or string copying. This
> > removes the overflow while simplifying the code.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Compile-tested only.
> > 
> > Changes in v4:
> > - Use simple_strtoll because kstrtoint also parses long long internally
> > - Return -ERANGE in addition to -EINVAL to match kstrtoint's behavior
> > - Remove any changes unrelated to fixing the buffer overflow (Krzysztof)
> >   while maintaining the same behavior and return values as before
> > - Link to v3: https://lore.kernel.org/lkml/20251030155614.447905-1-thorsten.blum@linux.dev/
> > 
> > Changes in v3:
> > - Add integer range check for 'temp' to match kstrtoint() behavior
> > - Explicitly cast 'temp' to int when calling int_to_short()
> > - Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/
> > 
> > Changes in v2:
> > - Fix buffer overflow instead of truncating the copy using strscpy()
> > - Parse buffer directly using simple_strtol() as suggested by David
> > - Update patch subject and description
> > - Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
> > ---
> >  drivers/w1/slaves/w1_therm.c | 64 ++++++++++++------------------------
> >  1 file changed, 21 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> > index 9ccedb3264fb..5707fa34e804 100644
> > --- a/drivers/w1/slaves/w1_therm.c
> > +++ b/drivers/w1/slaves/w1_therm.c
> > @@ -1836,55 +1836,36 @@ static ssize_t alarms_store(struct device *device,
> >  	struct w1_slave *sl = dev_to_w1_slave(device);
> >  	struct therm_info info;
> >  	u8 new_config_register[3];	/* array of data to be written */
> > -	int temp, ret;
> > -	char *token = NULL;
> > +	long long temp;
> > +	int ret = 0;
> >  	s8 tl, th;	/* 1 byte per value + temp ring order */
> > -	char *p_args, *orig;
> > -
> > -	p_args = orig = kmalloc(size, GFP_KERNEL);
> > -	/* Safe string copys as buf is const */
> > -	if (!p_args) {
> > -		dev_warn(device,
> > -			"%s: error unable to allocate memory %d\n",
> > -			__func__, -ENOMEM);
> > -		return size;
> > -	}
> > -	strcpy(p_args, buf);
> > -
> > -	/* Split string using space char */
> > -	token = strsep(&p_args, " ");
> > -
> > -	if (!token)	{
> > -		dev_info(device,
> > -			"%s: error parsing args %d\n", __func__, -EINVAL);
> > -		goto free_m;
> > -	}
> > -
> > -	/* Convert 1st entry to int */
> > -	ret = kstrtoint (token, 10, &temp);
> > +	const char *p = buf;
> > +	char *endp;
> > +
> > +	temp = simple_strtoll(p, &endp, 10);  
> 
> Why using this, instead of explicitly encouraged kstrtoll()?

Because the code needs to look at the terminating character.
The kstrtoxxx() family only support buffers that contain a single value.
While they return an indication of 'overflow' they are useless for
more general parameter parsing.

The simple_strtoxxx() could detect overflow and then set 'endp'
to the digit that make the value too big - which should give an
error provided the callers checks the separator.

I don't know the full history of these functions...

	David


> 
> > +	if (p == endp || *endp != ' ')
> > +		ret = -EINVAL;
> > +	else if (temp < INT_MIN || temp > INT_MAX)
> > +		ret = -ERANGE;
> >  	if (ret) {
> >  		dev_info(device,
> >  			"%s: error parsing args %d\n", __func__, ret);
> > -		goto free_m;
> > +		goto err;  
> 
> So this is just return size.
> 
> 
> Best regards,
> Krzysztof


