Return-Path: <stable+bounces-178811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D81B480F7
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67B1C4E13CB
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7341C84A0;
	Sun,  7 Sep 2025 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGodD0lJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522811187;
	Sun,  7 Sep 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283567; cv=none; b=g8bVbOMnYeTAoQiJgDVLuk1hyxejqOUoqwDx+VRTYRnZFCRgvRI1kxfOcu4ZV04SR7UbQ9QSAF/68vEpyHBEIHsh+FzdyH+aqfXUuWEK5Cy3CdZMSjo8mV0DDXLZsbD8zp5X4eSHuhWpYoxu6lgDqIpvo/FivaHgf2zqyMXMGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283567; c=relaxed/simple;
	bh=eZTsOkoKMhjbme01dEVhw58QFdW+25N2Q5pfF93MP3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8IEndAAoRlWO0SJ8dGXE+KAK9GSy0eBRkNc79+1weq9na3WpgNbSd16YzCRE1wInyYZaAvmvBwjYHQW/12fvs2kvnntxuXjbuspqZMq9HNo/gyB05V+1MiV3wK5XqJVAKO4uPSVNvCqG/U16zbdcqPh2NaTjQdfj7SEjR0iwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGodD0lJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b52196e8464so1268324a12.3;
        Sun, 07 Sep 2025 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757283565; x=1757888365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nOFINSsardnktHpLa8/z21dgEWAihHseyXSOQbkPZEs=;
        b=JGodD0lJXi59MkGF1VWkb4GKLURiSLfrCIUznoY8hlcwamboT9QFvlNuTH71QRHpvw
         xQfmdfxHe+avyQhwO3Sq0BwlHWjsX7YRuxfILWYvy+Pn0paG6e1o9tFkwEGdAfOPJ8bV
         2nHkFGhzN9rasV5yS5qqNTGnjoAn/1mfKtLzYfwxkQQJKNWw0MIHP0qMYFaP9xiqL/uC
         3ifvsq/nk+Mg3nuVedFM1r5PWpNIS35urncFJu7eKrCsIs+8STT3m0skY7qNdvOBjCLE
         bzlKfSmeKfT7X8HuMG45cHtp0pgHki1xgafJsdyXXcniTUzJP7M6qRrjDwu8MFtThcxK
         YADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757283565; x=1757888365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOFINSsardnktHpLa8/z21dgEWAihHseyXSOQbkPZEs=;
        b=BoxjZ/bHLZ0+UDhU6QN3Y6Sh3i8qv8/o+HD4LWGHpMCxEv8o9pQydZY0zawwSwE5E/
         Ncv5WBE4ant2xLB+qJtEIMpH9J6qynNlfeUAv5ZnzUbc4SrFq28dkEGtdvozRazkUhPM
         SU0smVSzL5zc+VF7VdXFx5V5DqnGcNhQ0XxELSgyG6QPdcqGYNUIGgLFBNbytG+QTGXr
         M0W5kl0DmZ0skdHfxdio5Sfb9OXxygiV49wNq4VfAT9MR27GIfB0AxiLi/SA9XSZOTqg
         5M4UKAZRQNGGyrzpnMGH1wIY8vzgbUbSm0tyThdHDXjMHswXrbYtYA9S4V6eNwPIWKaF
         swzg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsUu/iob8PYFBM/Uqqc0W4bHcwKbqfP6vDvHVLVUnYfG5aQgE814u5N+xWYEv5NGKRz0cpHq6EwwA@vger.kernel.org, AJvYcCV4Qm+QzKz7C3ttOWVtaBYNEERaWI0tmCy46OPqAffYtYOv+FzkTAlzD9GuzqdPaqDUw9GBCS6I84C2@vger.kernel.org, AJvYcCVAgEczISs8UgGrONeEcaiBmgVt6gtCKQP7s0/uVKiT6JjS5PA7EGSZvnWd2GUJ4fy6F08XOE7N/3cwlf2p@vger.kernel.org, AJvYcCWrMuBtjLsZNaOlWuBb8z31AzeWjMVlAeGc4G+3TlMVpsRpQd5vkjNWR+wDbaGeyY80xphwIUFL/fvZwHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytM/uiEg/xVDg8226u7nuIPCgeLFtOVkdOEulc/jHtzsWMNdRC
	Lp62mLpYeEWctrYo3YikN3hACAEfNKgVku81lNOGqpFJDbt7UpbOMMfC
X-Gm-Gg: ASbGncsgBI5eibz/6b69pGsKrMqCuxeiNWG8k8Z7qCZr0XrDrV6VGrIvd7d9IGJ6tYK
	r/au6a+bc+7Ow67Y1CJxBXXaugsShD7j5jDoiR32gtZbD9VAvvx9uaVHZ8UREpNtBeSJhDYQbVO
	HLOSczwZsO9xPeetWXkAOZqo1NmTKvnFV2FUMt6wDCe5yQFnQIrToxzoCflefqbx5CabW9wiVVX
	IpiTVvj5Fk/i5p87d8QQfRPM7zpz727uHK8lFX069pE1rfUVY8jM+v4Iwr5x7EfIEgYxVWmg+pl
	2lPbdty7vIJUbdurY2FboUzh8Awcn3+17xb25s92jQb18xe8G9lV89wT8B/A7My3j35FjBhlGNY
	SrgLhoUoh5HAhPffzuAkySdCyT7vUEYYFq73qDy5qDIryj0LzhsBfK8fDjsY3HrjlTAJoIn8=
X-Google-Smtp-Source: AGHT+IHhVp/+lDlmHkN/kg743agblfHXogH2wRJm6g2H/7DhB2sYLgdi/C4FmHam27b11HDYbLM68A==
X-Received: by 2002:a17:902:d2ce:b0:24c:c8fe:e272 with SMTP id d9443c01a7336-2516e9816eemr85688645ad.19.1757283564876;
        Sun, 07 Sep 2025 15:19:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cbc8706a2sm100903925ad.79.2025.09.07.15.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:19:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d385692-a4be-4fce-9628-274f95fb24ba@roeck-us.net>
Date: Sun, 7 Sep 2025 15:19:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: (sht21) Add support for all sht2x chips
To: Kurt Borja <kuurtb@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
 <20250907-sht2x-v1-1-fd56843b1b43@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250907-sht2x-v1-1-fd56843b1b43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 15:06, Kurt Borja wrote:
> All sht2x chips share the same communication protocol so add support for
> them.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/hwmon/sht21.rst | 11 +++++++++++
>   drivers/hwmon/sht21.c         |  3 +++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
> index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..65f85ca68ecac1cba6ad23f783fd648305c40927 100644
> --- a/Documentation/hwmon/sht21.rst
> +++ b/Documentation/hwmon/sht21.rst
> @@ -2,6 +2,17 @@ Kernel driver sht21
>   ===================
>   
>   Supported chips:
> +  * Sensirion SHT20
> +
> +    Prefix: 'sht20'
> +
> +    Addresses scanned: none
> +
> +    Datasheet: Publicly available at the Sensirion website
> +
> +    https://www.sensirion.com/file/datasheet_sht20
> +
> +

Too many empty lines.

Please add SHT20 to Kconfig as well.

>   
>     * Sensirion SHT21
>   
> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
> index 97327313529b467ed89d8f6b06c2d78efd54efbf..a2748659edc262dac9d87771f849a4fc0a29d981 100644
> --- a/drivers/hwmon/sht21.c
> +++ b/drivers/hwmon/sht21.c
> @@ -275,7 +275,10 @@ static int sht21_probe(struct i2c_client *client)
>   
>   /* Device ID table */
>   static const struct i2c_device_id sht21_id[] = {
> +	{ "sht20" },
>   	{ "sht21" },
> +	{ "sht25" },
> +	{ "sht2x" },

AFAICS there is no sht2x chip.


>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, sht21_id);
> 


