Return-Path: <stable+bounces-185485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF3BD583A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393AF4E1433
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9563019C3;
	Mon, 13 Oct 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWTQ2wtZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBB2877D5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376950; cv=none; b=c3/5wn+6V+jqLCa4a93cnxio/hXH0ArCUVi401gvd5GXFlkHVshsFhO8f/EWdpj4vBqO/ZgL3IVqeTwYSM8oviBstGSRz+zoi06eFupDAQ0gWJj5HXn026zfCp13Z467BY/VKsgFhQmfYPgQoF++XmyWEBL9cs4/9gAi8nAlluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376950; c=relaxed/simple;
	bh=L0l1dvVBxI7aQ6QdvNh005q/lMuJAaIhHH3fZWHnXOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rta5FEvCmQo/Omtge3on9gCfcG9EZGOgGNWTTbM8yGHo3PDIJ2hfhhm7Fxll/k5e6aPOBt3vjkPwRZdzigd94stkEC4tdZTUgsyQFMO8Q216SVWz/Pa6tvPxoKenfihBS/vV/99uL7a/8FE1cGc8xzLw1WrcaMXdj/ej0zBMZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWTQ2wtZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-373a56498b9so54629141fa.1
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760376947; x=1760981747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sg1Kp/xD6wqtV9F7MB6gIXsPYnhCTR4iWbhAE/BQKm0=;
        b=IWTQ2wtZZjJUBq5Qo/vg/A3uocbp5W6Rs1qtW/6GgE88gPr8SEA4BSns57eI/6QfJN
         CkeVHFlegqo6hH4qz61+S0hK30xDUSiLDEEdRLrbesLooInPic8GmCZc01g/teJ7r64f
         KLIhp4E2aNFfNitIbJYq2fbYPG5cTX960MKTNwGcg0IIdtlIKZu12tXDvoeMHOxrrnyL
         HD7Aw5FxbvMw6cHImeuLe1sSml0N+l2BTZqefxTI/57qdW8R3q1DwKLwD8+XBhPP27D5
         aVs1seOqgBTF/KZPr8v3BnvXNzcRJ2qFfXzEgXnAnB+swtssAcW/gPRs7Ugvix5QMO42
         6TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376947; x=1760981747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg1Kp/xD6wqtV9F7MB6gIXsPYnhCTR4iWbhAE/BQKm0=;
        b=BywkjBR9tm6ePzl8FDKog6XtLB6B1hMdDQ5UB7TOVxlFFU5JP4jAaE5xpdKOQ46Hyj
         BxiY+JXDAK53wKXFXRVNbhmrJbGfe1l8QgjrwK1PyVLDo4BtA4m9WmrmQul4FOXpuffy
         y/WiY5AsCADewwXliKFkSEKsnJyY4Tbull2K2CWyc3qqMM1DXhY1DWPZ4FI+N8eLAbl8
         leJxFnQIkYPXZzNvjJjZumdL0M5/P+EZ6epWVTTh7mjhFW94231V9DwW82zYIjkYjAM2
         V2H2zyp976J1PYMkeAEaFksMARyj648yxGikfTwvRBHYxeiySluLjf85JFtO+oL912e1
         cMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAdpcBNGiKB8sGWlejt6bZPH3/cXM4CtJ9hYZtdCYgz3iyaxxR4qu4z+ejgUYU2XLB0gi6KK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywX16GGl+lVKicyaHWR1eLQId3v96pjIA4i+iJsjq3Nn9Hhrdt
	CA6/2MkldNxyb0EdVha6US/LHA85PR+pHHqzdEMX6MD+BeEuRjw/OCsT
X-Gm-Gg: ASbGnctKCd3MddfzNnbaGOd6LWBZU2fEYXNYQb5qokA6cOPK+ps71bjpJ+qmTqII5+Z
	mHq8+63Ayoogw+9hnIb8w7VcKrzxoZAOVYd2nawwhp5s4vkJkd0nyKSyjm558qQVBenWDVuolQD
	enHp5t0X8Pw2gIVCFTPPrUcvIwSLt9hraU9K8JYc4eLiwm4BCD+m0oqT5jAQJEg1X/EkWAq+OAy
	ZJOpSBk8SLkpWUErgGKNAJzUs2Gz+4N6u0Th6jU6WWMGq2GeW2qsH84w5rHJ4/UBz/89Rj5zbYf
	HYUteRDenqWo8cBuSS3/8jkDR5KmJ1iSITAtuq5ebluqL85af0bsLrR0kZkfSNvXs6OWQEqmq16
	JNrL6io8EBBBtNYAqWQYm9iDQUylqOrFdyRjw+wLh3BN3ZcPPaL7Dag==
X-Google-Smtp-Source: AGHT+IEV56bnvcGPwOPYB8vnYJAS9fKrH/qReZKaBeWAX+wJt7Mt+B1FaBTD08zZaMMvB5YtKyIwJQ==
X-Received: by 2002:a05:651c:3246:20b0:376:5391:88b1 with SMTP id 38308e7fff4ca-3765391f543mr14711741fa.9.1760376946456;
        Mon, 13 Oct 2025 10:35:46 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577571sm4306355e87.102.2025.10.13.10.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:35:44 -0700 (PDT)
Message-ID: <c68111e0-e651-44ee-af7f-737a408fe080@gmail.com>
Date: Mon, 13 Oct 2025 19:35:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: leds-lp50xx: allow LED 0 to be added to module bank
To: Christian Hitz <christian@klarinett.li>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Christian Hitz <christian.hitz@bbv.ch>, stable@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251013085514.512508-1-christian@klarinett.li>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20251013085514.512508-1-christian@klarinett.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 10:54, Christian Hitz wrote:
> On Sat, 11 Oct 2025 14:16:16 +0200 Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> 
>> Hi Christian,
>>
>> On 10/8/25 14:32, Christian Hitz wrote:
>>> From: Christian Hitz <christian.hitz@bbv.ch>
>>>
>>> led_banks contains LED module number(s) that should be grouped into the
>>> module bank. led_banks is 0-initialized.
>>> By checking the led_banks entries for 0, un-set entries are detected.
>>> But a 0-entry also indicates that LED module 0 should be grouped into the
>>> module bank.
>>>
>>> By only iterating over the available entries no check for unused entries
>>> is required and LED module 0 can be added to bank.
>>>
>>> Signed-off-by: Christian Hitz <christian.hitz@bbv.ch>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>    drivers/leds/leds-lp50xx.c | 10 ++++------
>>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
>>> index 94f8ef6b482c..d50c7f3e8f99 100644
>>> --- a/drivers/leds/leds-lp50xx.c
>>> +++ b/drivers/leds/leds-lp50xx.c
>>> @@ -341,17 +341,15 @@ static int lp50xx_brightness_set(struct led_classdev *cdev,
>>>    	return ret;
>>>    }
>>>    
>>> -static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[])
>>> +static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[], int num_leds)
>>>    {
>>>    	u8 led_config_lo, led_config_hi;
>>>    	u32 bank_enable_mask = 0;
>>>    	int ret;
>>>    	int i;
>>>    
>>> -	for (i = 0; i < priv->chip_info->max_modules; i++) {
>>> -		if (led_banks[i])
>>> -			bank_enable_mask |= (1 << led_banks[i]);
>>> -	}
>>> +	for (i = 0; i < num_leds; i++)
>>> +		bank_enable_mask |= (1 << led_banks[i]);
>>
>> Probably the first idea was to have a bitmask indicating which bank
>> to enable, but it ended up in having array of bank ids in DT with no
>> related adjustment in the driver.
>>
>> This patch deserves Fixes tag.
> 
> This code has not changed since the inital introduction of this driver.

Yeah, I had on mind design approach changes between subsequent
versions of the patch that was adding the driver.

> Fixes: 242b81170fb8 ("leds: lp50xx: Add the LP50XX family of the RGB LED driver")
-- 
Best regards,
Jacek Anaszewski


