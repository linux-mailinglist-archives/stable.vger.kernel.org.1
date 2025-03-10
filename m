Return-Path: <stable+bounces-121711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED13A596A0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 14:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C824B1889807
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F46229B18;
	Mon, 10 Mar 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG4g0V2V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747431F956;
	Mon, 10 Mar 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614396; cv=none; b=EBGDxlvUd3J1ibXZDAS9nhieDaEg1TVA5dAydxtJeFLWenNNumXHYeDnGzXNFxKRaUw8qvqBP2bPEPBjk/4Mbm9lNB/4eKyZsb3tVB5x6ocGZvZLjuyHodTnzK+e5CVU2eFJW7Qk6CikusFrYhD53IegBUYNeOCdUMS968aPH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614396; c=relaxed/simple;
	bh=SUrcSvL5qLmeImXtGq+OJxPeZI5A25/7uBfeFpHt9wc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bi5oMwp8tD3TzKpjVwU/H3VexMNxjZvW7a+UyDYfc8PdsMEQ7pSNmmZggx7i4jvO4wrIEX62+9wCnWSc6oxKzEnptBcUr9ks1kRdS4n/vM8hXoEwlbDUP4RzsjQH+mpVzlxArm63g84xN7Xak0KGBhvM4AGsHxWM+HTiE1uD/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG4g0V2V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso1249986f8f.0;
        Mon, 10 Mar 2025 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741614393; x=1742219193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6W2q6ww79dH6unrH45J+euLaeN4QlEFEIMUkdHmeXfg=;
        b=HG4g0V2Vmv0pfIxVlSxjpsukeuu1fsvekckHY3MWY1lErzbWVrpy0dcK3AKDxmblKK
         6OR3AtATsM+cZZ1zOb6SxCO+J2btp4R2uICsDIQ7VKf3gGWQeAKBxM0b29G5piNStN1/
         GWayXvHv6edC8eAETKCRm3svm3xyC57rDlP7dzX5m4YlYDYhK3l9fhitFfJjt9hxF4S2
         VWN48rMKAjNH94xahSwNbmoVGdLbqyvbQe2QbQ6htXb44UbMkp0rVHG0CaZBSh9tekHu
         fLvHphjQ6UqZZsBsQFWZPQUilRI9MEbZXKjiUcWLnreIw8slTNMJBJUjT5lUNB+aEweL
         QEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614393; x=1742219193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6W2q6ww79dH6unrH45J+euLaeN4QlEFEIMUkdHmeXfg=;
        b=tf4mroA6uoNA1GPxkkZS9zfWLxPJtaLf2phCd6wSrgHorsQXBZvwg2MB1lqi+/VnYv
         aRgJT/KqmGct7/jKrwVMp1jpT8Q6A5+viHNb+Y+1Iu0dQaAVfbCnnMb5QVwG8ZSM6jRc
         lXM7qxDsOAvR4gcdyzw4waiDDL5tiz5BubVpcv5zXWgxHUxJPmWiZCfqudQ+7TIrJJOM
         Iv7E58xoLV2Y8axQ6kqaYX76alhI0fs5L/VuIPlm6Por6U5PLKj9OqYZSIDedIDEPKkG
         +E/x0FKoXyPuzwJ4SRFsDGpzzPKdOfnC5ZmMQh/2z57jmwhXafWwpWTmviJNdEzujQ1r
         mUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzyFe5sEZqpE0f+81TJcGjgnJuhbklD+05DrFunaWFdl/ZDy958zMVnQ8csTtEw0FWXba+XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPX33zOWDNbPtTP79gZlCtV2sJ5lgZXb+msnqz/4pEZ4yJKly
	VpFJRvzJLWPSo4DPKwESo0nd/E3OblBQAf5FzSqIO1kISm+2vz+E
X-Gm-Gg: ASbGncvVcbSxlxt6dCQS8RJzVuiTz67Ca2eDSL4lEoxyukYHos4vfIogqVoMEiN/LPD
	LXORfgvu3lV9QUys0hg04OnsiqqkR3nRAvxgV7Zon+OXX11xZBYbHWgeFK4mbpC3wOxl4mJHcSW
	FWvS8oKazkivPyNvEi1UA5fQuVKN6Qm/cW4XAIZuc8q7vCAWcctWa5qZWSlnLCCR24TWcIE9xX/
	QipdLoA0H/rdvHgEtLRUQyUcWh+r8jZXw3yyQyvLXH5sITbJ6rvHzG4lRZ3RphKUZ8LLnGCoF1W
	4XFRL8WoKtk3NTdbgrFOXrPOkZ56X9c791gO/KlGt2VhoMiF07Aao4fj4GMDxmCuVjSzFtgmZVj
	qjh1xami9d+k=
X-Google-Smtp-Source: AGHT+IG0rfUbSGfyc0uNEKNiN0VOzWgqrPHplWEWCLgtH8tBnJgmzGNqjOdjIEHokHjixoj8t0wWkA==
X-Received: by 2002:a05:6000:4102:b0:391:487f:2828 with SMTP id ffacd0b85a97d-391487f2bbdmr2647368f8f.10.1741614392361;
        Mon, 10 Mar 2025 06:46:32 -0700 (PDT)
Received: from [93.173.93.237] (93-173-93-237.bb.netvision.net.il. [93.173.93.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ced9a4b19sm68553345e9.29.2025.03.10.06.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:46:31 -0700 (PDT)
Message-ID: <4cd852e0-6d6d-fcb4-6e4c-e6f861f429db@outbound.gmail.com>
Date: Mon, 10 Mar 2025 15:45:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Fix error handling in
 xillybus_init_chrdev()
To: Ma Ke <make24@iscas.ac.cn>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20250310022811.182553-1-make24@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20250310022811.182553-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thanks for your patch.

However, as far as I understand, applying it will cause a Use After Free 
(UAF) error by cdev_del(), as the call to kobject_put() unwinds the 
memory allocation made by cdev_alloc().

Or have I missed something?

Regards,
    Eli

On 10/03/2025 4:28, Ma Ke wrote:
> After cdev_alloc() succeed and cdev_add() failed, call cdev_del() to
> remove unit->cdev from the system properly.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/char/xillybus/xillybus_class.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
> index c92a628e389e..045e125ec423 100644
> --- a/drivers/char/xillybus/xillybus_class.c
> +++ b/drivers/char/xillybus/xillybus_class.c
> @@ -105,7 +105,7 @@ int xillybus_init_chrdev(struct device *dev,
>   		dev_err(dev, "Failed to add cdev.\n");
>   		/* kobject_put() is normally done by cdev_del() */
>   		kobject_put(&unit->cdev->kobj);
> -		goto unregister_chrdev;
> +		goto err_cdev;
>   	}
>   
>   	for (i = 0; i < num_nodes; i++) {
> @@ -157,6 +157,7 @@ int xillybus_init_chrdev(struct device *dev,
>   		device_destroy(&xillybus_class, MKDEV(unit->major,
>   						     i + unit->lowest_minor));
>   
> +err_cdev:
>   	cdev_del(unit->cdev);
>   
>   unregister_chrdev:


