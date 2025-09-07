Return-Path: <stable+bounces-178812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5767B480FC
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B063A06FC
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7811E51FB;
	Sun,  7 Sep 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtm/ZfD2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163715853B;
	Sun,  7 Sep 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283596; cv=none; b=TyAHP85ErCqbAB6ligXk4G2PcnpDW0nEri5qEKGGcYCqNHWER9b71YnZi9UHlUL/jeqS6OdW8QDMPIUD7mxp2iBdZ6oJtd+DwDVHM2rfRXUcO8lF9npCk2xA+PDEbys82LcIb2OqiKyIicZERRWVwwInUcecRzePoagP4uFOmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283596; c=relaxed/simple;
	bh=REDt9tBHgqC0yaPap13tTQHVOMVnE1p/e1kEg+EkQH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxDmMzILBCHzqOQYAcQ12h7JQIauHn52QGQV8bkRtvj7/Tvds1QLE6VViP3jbRlV1YfRKcXFQGr4dlknxXDWAQl221HxiTzZ703ooD3cKLaKXV88niNkPtpQ+QV6WTigbjjsm8rvs1psi3Lkp93R1dXozK8ttOMcxjQK3XLtacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtm/ZfD2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2585750a12.0;
        Sun, 07 Sep 2025 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757283593; x=1757888393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4J4fibk9ng0A+ggW+gAsxsjjd90wsaSlu+bA481AQwI=;
        b=dtm/ZfD2tD4n21VdrK6RPS9sxyKzltiHNoIcsVkRyy+ofMDpYS2eFLwGKywBmHKV6R
         NQTILLmIoB1bYMuvMzZaoD0nmILsZnpKGZ9k2vAInA+I5PtePc8pMs1n8mWgeZhcRDod
         E9ZJrZ8cSl3nF/ztMQOctJqtqKMrLs0U0MFPzkD2q5T8ElnzFHl2IoxcrZyX4iMfHTAX
         ybWcJkMWwen0Gy75OZSvI+1LeNgK6npdw02k8P8YHp2iQpJ4BT/uUsyAhDKmRE38SmnF
         zBSUYao7NZecczwfiKgxPOhRO67C8pUyyueXEQJmAMDPx0aOPVnj8mWAdM3TY72u7g0Y
         Vl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757283593; x=1757888393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J4fibk9ng0A+ggW+gAsxsjjd90wsaSlu+bA481AQwI=;
        b=bcVkVIulXJ1S5cPv4cJ5aaVv21ej7zJWPwalXxL4wmxHHKSZ2y8KMZcJ4ielRvMF0+
         p7FhwXP0LeMryB2erjjv+G5CsemyaZzmehu5wcUu0CtN+Tb6cgN1gg25bk35XMFp1gDe
         tMRN8VEp2yEn+/z/oS44ewp/aPr2LiPlhE66PXDpyiynaI5L+1AXLVxqYukPVbqNyuJX
         ngM5fNiDLEzqv1+1wWB5LSq1MAQ5fPWL0wFz3u182rQwe5+3qcSLiYLF+JjjshnDZCqf
         7ERRa6FCKhR4ti65nQHcHxAp3zZpEw8nKKcLzjq0Rk6U3qIRT6BqJs4Tr3iFqLKoMsJf
         pyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfsAXAbzs9eniv6JtskWr+9h5F/OLuFqO3n23GAUWXFl8Y6FfDVYq+Z+pkDIZTbGK4UjfSy88YDc6L@vger.kernel.org, AJvYcCVqdfKwjoECf/VmC634U3IaaRjYf7Wn6boiNjxTHcAbz7kGre0duVG9nqytcQ0TSLd6WqaIvScvlwnEMMg=@vger.kernel.org, AJvYcCW0K+RSLW9lv4bgFHDb9WVL6CY04+vpf4xBjD+pdbAGamihe/eRE+eBF4MYE2qUyoBfkBPmqpbqflwF@vger.kernel.org, AJvYcCX8i5o/ebHu7LQ9gabO1gP1Zgrk9KPNPctCGtZx5AaKbti0YKHFIXn6SvInxUCQeWkRRmaWLH08RjlVgUi0@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyrMkLAoJ+NgeToLif3k+A3N4QSY1H+R48O4qIiNANzI3iuua
	MjlgAcg9XgVqBm7qD5ZWuC7JYAugPLE5O7DqimoLkkFM71rEghkl5un0
X-Gm-Gg: ASbGncsANDtRi41YmF3ff3FgwpJjMOqGB9HnyxmPOdbkR7tb9Aay7eFD1VkV66lrHWu
	4N15PA7JtaghqN15ZUi9pNNDayfS8jO2M8Se8PhQUWooG5/cyKwfM2JfORcoXLDFW9pFU9NTK+E
	soB30BdTkij/9UNehMZMG7GGuwb0ieCtVSHcedH4z0Axm77ZyS/odKowLY84aR8u9aqiJRiv8y7
	tRTQ/gOKRaP8RsiPyFH1kaF57AUodvAqMdeMjwGCl8xrwN0rPlUELDtLaWB+Aww6/PgltPUmpcW
	x0XF93QAHH66H1uhGMwaNNXyaC34NvBzJOiOA4jyoOet8sbfOv+sjdYBNqkJgc0NWHp7xOr0ReZ
	BlMmQODocs3gR7O6fmNPLg0nq5QGde8ZMgyxGz1ZUa11r6vPT+TKmHIdk+nUMxAfQNB7xiypcrh
	H6Pevzew==
X-Google-Smtp-Source: AGHT+IHoe3rt0UnIql4riTkuMzFWommXpgYmzwxexPBtTMwXbWo2fhzz6inLleq0ElNdDt4/P3AuFA==
X-Received: by 2002:a17:90b:1fcc:b0:327:ca0a:67b4 with SMTP id 98e67ed59e1d1-32d43f00255mr9242086a91.12.1757283593085;
        Sun, 07 Sep 2025 15:19:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b5d95709fsm14200455a91.10.2025.09.07.15.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:19:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <502a7a9d-3b5d-4bf9-9cd3-fc3d387ebe62@roeck-us.net>
Date: Sun, 7 Sep 2025 15:19:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (sht21) Add devicetree support
To: Kurt Borja <kuurtb@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
 <20250907-sht2x-v1-2-fd56843b1b43@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250907-sht2x-v1-2-fd56843b1b43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 15:06, Kurt Borja wrote:
> Add DT support for sht2x chips.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/hwmon/sht21.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
> index a2748659edc262dac9d87771f849a4fc0a29d981..9813e04f60430f8e60f614d9c68785428978c4a4 100644
> --- a/drivers/hwmon/sht21.c
> +++ b/drivers/hwmon/sht21.c
> @@ -283,8 +283,16 @@ static const struct i2c_device_id sht21_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, sht21_id);
>   
> +static const struct of_device_id sht21_of_match[] = {
> +	{ .compatible = "sensirion,sht2x" },

This should be individual entries, not a placeholder for multiple chips.

> +	{ }
> +};
> +
>   static struct i2c_driver sht21_driver = {
> -	.driver.name = "sht21",
> +	.driver = {
> +		.name = "sht21",
> +		.of_match_table = sht21_of_match,
> +	},
>   	.probe       = sht21_probe,
>   	.id_table    = sht21_id,
>   };
> 


