Return-Path: <stable+bounces-178818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B4B48122
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C82B7A24E1
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD842227B83;
	Sun,  7 Sep 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmLrxwKk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225C315D46;
	Sun,  7 Sep 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757285653; cv=none; b=MDCv0++yUxcSo7PPw2YpyGUeiPjgbFaohc9IOaitupSm5DcO4v/H5Td0SYSWfKPgwfhaR/ImHGbgbeYxDsG0mCsqu6Gi/yBpem/FO13SXOwtKyRQlH7eMPrC7Xnb0/oqlYVw2BaVUynuQ1zgU8g903OYmJKxBs+fFajhDHFNxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757285653; c=relaxed/simple;
	bh=DDAQoUGsYX6TFnzxEpH2953bT0lZKSM+pgByo83UOsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1dMohNCVz0rdXivJpvSDOrg4Y60p6x0T0FRHt8bjjHxUfUzNOaxhDnNCLHs3ub1eUEHBnjX50uC9xSvNVhIbuilRUJ8v/muiWbKhV3oOj2UNrvk++DrA/XJFrIH90YhaM1vIOZDPYCjJxENbqz599hrn8B1hTn6dpvX9pUmRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmLrxwKk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2588869a12.0;
        Sun, 07 Sep 2025 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757285651; x=1757890451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T5y5RZq1DArtLs4ymhS8UGU5Kg3AS+haT36o3EyZ8NM=;
        b=QmLrxwKkMBfVlJazoYuVHi4SWF1vSH51JVpNBRKrw4ilYcN+YlCulT9IoY9wRutmn+
         xGMzw3swRZH9G1doDztg2XMgEpxqDJfR3FRlDlOy69cONG5HTu/q47m5XPmuTHnwADfS
         jbzPXYhYNu7y4uEzYq22ZTpm42GDFxm1qfYoFYjHIuMWtf1stVzP3uDyvgla9Aht8X9z
         DJ772aEvBSmltdtP0aM4TepEX4cV6R67GB0++rkC0IEyybRGSfdFO/n3emG3zouyfxUM
         BuZGyiR+14fuPSQN1IFSOgtZ7YphBeqnjjWhKvGPZyf/bqaBPMEEmAuT2bj7TvZKK+1s
         vBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757285651; x=1757890451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5y5RZq1DArtLs4ymhS8UGU5Kg3AS+haT36o3EyZ8NM=;
        b=EsM8vp/aGXAw3uC0mYpNSvWLwjxDwqzj9eS+9/6fiXWPiDnVY9i8OMCNl58Qg4/qsv
         +nO+vjvMmJe1vhQE+LX9/WqLnAZvSQ8dX7dLpT9MnrKBMUxSnM8ms9DQ8WExisNK2dN1
         Or5X3y71BiqJiETQ1caCkSI/4OaE5pgoI+uuyArkIMIC2xub/Lsb19v35yC2zKieM4zJ
         5EVx8d1oVyPkprM/X9mPXj6zg7u6xVcoNc5QOOpUUiWEL3gN3uTKnIt3Gv60c2YTgRXm
         qkaj0pvY9/7hH5KT2U2QC5s/453mo2HTi9PZQRQuP8PDoeRuhAjJy6TiFGWq0owwXnY/
         RGBA==
X-Forwarded-Encrypted: i=1; AJvYcCUYgyR30g0Ot9ysxccNp/X+vRIfFaHYo+ImhY/H21nlrCXNuKWv703xGaniw7XWFWhrksY7yYHTlxxVIWY=@vger.kernel.org, AJvYcCUluIag8UJTTL/7JSZ0xeTrPq2Q7tCo0X/khN9XSx8k2mYuz1UuNhjWpt/pDON10KYAl4iIRp3AOwKJmqhu@vger.kernel.org, AJvYcCVtFgw71rj/rEI6utVHWX3nCwAF7xZWb4hvu8Wd1RdlkzmiVzhERAO+Eu/KOvq3rCwaJYOY/PiE6Q8D@vger.kernel.org, AJvYcCWrQLlgA6SgPcdUV8FAos8DVVG3uULkWodKNjtytZ34SBdpsJODrfgpCTw0dxwuRBapGWFWdWarehjy@vger.kernel.org
X-Gm-Message-State: AOJu0YziOK2Y4siBS5nfqnxxTh4mpv/zaRLCV2bVt13hoFltow8/JGh+
	Tlo94tGG07mNJVhCfy8MekecIQYEz/qMEx+Sn5D9KJfb4bNqWwqeSmOi
X-Gm-Gg: ASbGncsh/kd1VGoK8JmPnMmKW623oy5Iwtjk+6gvRuC9jrCYgryghs3ZzTn2rgXYyeA
	Vyl9Ez9EpxFmEpMJ17+1JL0uGkrcyMdMKQKE5BqdvpfNSj1WvvztoM9kq9/jhmHYpIsSOa+GcUP
	M4JNiqa4CqKHyqmh9MMhiDMCjkkf1xEFt38pBRf631BxRnl15pxEE/4joHfZKACXx50LVv4cw9O
	cn1TsCzXLhMZ4787Cy+bTDexSxvfskCJc0DQnb8D4JYD9j7zZVNEw2ytnXwbvhc9ydI9UNTUId2
	Bxk/jVUmDwvZMBVlvpz9CuFDrG5Tj6cPGb2ZM7d9UsuoCveKlTh3pLhnNvCsGcS1pJGTQ+pC92H
	6NAJAgCLzfB0m/BfmP68J7UHma8c67uMkgR9zrb28zQv/Y0U8o+C490bVP5dFAkyW8daaCa/Knc
	D0DpvHRA==
X-Google-Smtp-Source: AGHT+IGSuYwerzGtAdObkspfZoD0biNc9XRU2FH60tdpSnBr/RSSEW3LuyBLows+ecYUxiSsYzBiAg==
X-Received: by 2002:a17:902:ec8e:b0:24e:e5c9:ed14 with SMTP id d9443c01a7336-251734f2fbemr81537425ad.35.1757285650706;
        Sun, 07 Sep 2025 15:54:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc56e7esm92041035ad.58.2025.09.07.15.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:54:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f72301c9-022b-47ed-a7dc-9e5b4ef9ff6c@roeck-us.net>
Date: Sun, 7 Sep 2025 15:54:08 -0700
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
 <6d385692-a4be-4fce-9628-274f95fb24ba@roeck-us.net>
 <DCMXLEBY7Z30.20SQGDLMZPYJS@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DCMXLEBY7Z30.20SQGDLMZPYJS@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 15:45, Kurt Borja wrote:
> On Sun Sep 7, 2025 at 5:19 PM -05, Guenter Roeck wrote:
>> On 9/7/25 15:06, Kurt Borja wrote:
>>> All sht2x chips share the same communication protocol so add support for
>>> them.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>    Documentation/hwmon/sht21.rst | 11 +++++++++++
>>>    drivers/hwmon/sht21.c         |  3 +++
>>>    2 files changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.rst
>>> index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..65f85ca68ecac1cba6ad23f783fd648305c40927 100644
>>> --- a/Documentation/hwmon/sht21.rst
>>> +++ b/Documentation/hwmon/sht21.rst
>>> @@ -2,6 +2,17 @@ Kernel driver sht21
>>>    ===================
>>>    
>>>    Supported chips:
>>> +  * Sensirion SHT20
>>> +
>>> +    Prefix: 'sht20'
>>> +
>>> +    Addresses scanned: none
>>> +
>>> +    Datasheet: Publicly available at the Sensirion website
>>> +
>>> +    https://www.sensirion.com/file/datasheet_sht20
>>> +
>>> +
>>
>> Too many empty lines.
> 
> The next entries are also separated by 3 lines. I did it like that for
> symmetry.
> 

Two wrongs don't make it right.

Guenter

>>
>> Please add SHT20 to Kconfig as well.
> 
> Sure!
> 
>>
>>>    
>>>      * Sensirion SHT21
>>>    
>>> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
>>> index 97327313529b467ed89d8f6b06c2d78efd54efbf..a2748659edc262dac9d87771f849a4fc0a29d981 100644
>>> --- a/drivers/hwmon/sht21.c
>>> +++ b/drivers/hwmon/sht21.c
>>> @@ -275,7 +275,10 @@ static int sht21_probe(struct i2c_client *client)
>>>    
>>>    /* Device ID table */
>>>    static const struct i2c_device_id sht21_id[] = {
>>> +	{ "sht20" },
>>>    	{ "sht21" },
>>> +	{ "sht25" },
>>> +	{ "sht2x" },
>>
>> AFAICS there is no sht2x chip.
>>
>>
>>>    	{ }
>>>    };
>>>    MODULE_DEVICE_TABLE(i2c, sht21_id);
>>>
> 
> 


