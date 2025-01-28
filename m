Return-Path: <stable+bounces-110926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1790A20362
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0EB16408F
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AC1304BA;
	Tue, 28 Jan 2025 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNz+bsG3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8B1465B8;
	Tue, 28 Jan 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738035267; cv=none; b=cBkCvDDrmLy2wQYR1skyde6icA3QLTYg2fwyVckQtWRUAZY5eSOGn6+ycTb/wL2oOVB8dagX+6VIXjSq9Hw3AYcY55hkSW2SiJqNIg1f/xUH7io45wAXr+/7kyfxe84BkdNyZmEecKZbN5kh2Pfyy2I/uKlp60MabQijOmjla4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738035267; c=relaxed/simple;
	bh=OkMgp+KSjMPUSJYK0nRFWa4FKKPTAn7WywVSMnMzR9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkER987nFK/l9d/j0LHj7eXzT1uXEJECUPa+DAoOrjHgOgWhu5U8d2W5+9SkTzyav+EdtsKjO43EhL5MltAwcyvQBVqX64BgmnElKwXflsKs+8o34+GSu/hEtyj3CiE1XgF6yLBxqKxMfRywNPl9rJi48P5idCso0XLCm+LQkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNz+bsG3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so7146840a91.2;
        Mon, 27 Jan 2025 19:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738035264; x=1738640064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=doDS1Ex+NRiuf6+avUfXFW5qSGMVzArkbg9TLw/ICV8=;
        b=JNz+bsG3qXfaNK1EMEgMeA25DqviKrGgztjzKuajA9/39PNkZV5MFbXQOzdc6ksldj
         qxERlZeP05ihTcKyQXq867nt5SlOlwy/5ut1fSW4vELCoQBfzley3gMjx+mi/SXAXRN5
         RGoYyqEXeWSLtCNZRb8YvSKWdM7st+/SRrXPSDLnB3RdQzJyxWASYzzOfpDCbjqX2v+N
         icmqZMFG93mY+aQNqUQ9WAH8mQyiStRAOrs+H6qXchMhEgEG7ncxkzpwpaZHVh5wcnhx
         1J/ba1HqsRsZJDlFMbng32s3F4BeZHCBbbUvyjp21C43HYCd9RVVMWn4e1wp2LsyLqVl
         jSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738035264; x=1738640064;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doDS1Ex+NRiuf6+avUfXFW5qSGMVzArkbg9TLw/ICV8=;
        b=la+c62C+xKvzJBE+WDhb6c+SDYf4hS0FgVxZ9UBF+6nuBAaY51wK7RKMugoy0x8xwH
         plpdqguKcx6wqlXXz2AFZ9NBg1gsdn0sVDm/1wUV2szbGYDHkAFlhN5U7sIOemq2iaWb
         M7J9aRcaDilFj81AsIQiq7ja4v7KYBl5s4FnKXStlWzOcJu/ppspRPn0tTwyJkK+ueg6
         kgtu+5zmDigK4iNB1z70fL8o0UWuHV8P4p3duiSEHfvtzOdp5+uIbmAm5WLSapjSAlpC
         I+2Iij801a5rPfU1e8LFvQ04IX/gHbSXc9JxKxpp0zJz9+kylGK33yQghDygCWwEz5Ol
         fhQg==
X-Forwarded-Encrypted: i=1; AJvYcCUnI4CBG8uJtXsyo6zv3bv4NwDGT0UsU0+6Qi1vrK1ybH9zmEdt94N1fnuqol6/rzx0tu0n8oEAZxtJVQ==@vger.kernel.org, AJvYcCWsMo6bQc4Ug4sW2l1zaZJdQH8YWSa20fHKa3Aum6D28IGPGS/uPDZQdnekiX4X/ltS2Xq6XAFVzHyAV2On@vger.kernel.org, AJvYcCXziCfQbscnc6FVlr9+UN+XY8InUcAZjbrLRTkxS0/v9UYfG4LDCHMot8HFdaZv/51XuLa/Sxa9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr20h1uiTh5WOWU52qCI+khoNu6rbAr1BVaGlTgPorTkcJzOy0
	5pHX9mLisOocFhJQI1Qswk7at2QtT3uD6I38cokkjTBq2ysBs/nyEVQwng==
X-Gm-Gg: ASbGncvNF6XuEeIVudoQWrE/9/z7WkR8M8OQ9DzAq4rxvV/t47vkXvWI0Kpdv+wphuN
	yC5mQe2PHaErh1HLIoXP9UHY0iCKXy6LNLUxZfzHCABnhaOrzlqdFUGxas/izhBuNfQ7A7gwe/7
	iH2xoGisRM1Rqo7sc95BaIYr0hsFvcDT9EoWP56xLoic7y99p51G9EdshvVinICx7qv5GZVFBJC
	xx8Rgbmnm+lCzZx9TgveHCQo/A32gvgvgnT9MEmAaJc1cg9zj1ZuChHF2QJO2hiYZyaLJn40IiM
	8B18NdMpo9iVp7tWoDHVL2p0+kb7kYfa49/RwBBR0A6g9java79Aby/48puX3MeB
X-Google-Smtp-Source: AGHT+IHxlXFkKRZG5NVu3qkkHeZu3JQGoWYIXJQ8OKeJ0rg7uk8OSoIHBVXjTMC4TqOqFsCjkq5dEw==
X-Received: by 2002:aa7:9a83:0:b0:725:e325:ab3a with SMTP id d2e1a72fcca58-72daf97a541mr61104610b3a.14.1738035264264;
        Mon, 27 Jan 2025 19:34:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a761172sm7972233b3a.110.2025.01.27.19.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 19:34:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e352bf36-188b-4d2b-8b17-4a86d4d4345e@roeck-us.net>
Date: Mon, 27 Jan 2025 19:34:21 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (peci/dimmtemp) Do not provide fake thresholds
 data
To: Paul Fertser <fercerpav@gmail.com>
Cc: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
 "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
 "Rudolph, Patrick" <patrick.rudolph@9elements.com>,
 "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
 "Solanki, Naresh" <naresh.solanki@9elements.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "fr0st61te@gmail.com" <fr0st61te@gmail.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "joel@jms.id.au" <joel@jms.id.au>
References: <20250123122003.6010-1-fercerpav@gmail.com>
 <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>
 <7ee2f237-2c41-4857-838b-12152bc226a9@roeck-us.net>
 <Z5fQqxmlr09M8wr8@home.paul.comp>
 <1dc793cd-d11d-441a-a734-465eb4872b2a@roeck-us.net>
 <Z5faC6M2MUj8KYoB@home.paul.comp>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z5faC6M2MUj8KYoB@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 11:10, Paul Fertser wrote:
> On Mon, Jan 27, 2025 at 10:39:44AM -0800, Guenter Roeck wrote:
>> On 1/27/25 10:30, Paul Fertser wrote:
>>> Hi Guenter,
>>>
>>> On Mon, Jan 27, 2025 at 09:29:39AM -0800, Guenter Roeck wrote:
>>>> On 1/27/25 08:40, Winiarska, Iwona wrote:
>>>>> On Thu, 2025-01-23 at 15:20 +0300, Paul Fertser wrote:
>>>>>> When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
>>>>>> critical thresholds for particular DIMM the driver should return an
>>>>>> error to the userspace instead of giving it stale (best case) or wrong
>>>>>> (the structure contains all zeros after kzalloc() call) data.
>>>>>>
>>>>>> The issue can be reproduced by binding the peci driver while the host is
>>>>>> fully booted and idle, this makes PECI interaction unreliable enough.
>>>>>>
>>>>>> Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
>>>>>> Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
>>>>>
>>>>> Hi!
>>>>>
>>>>> Thank you for the patch.
>>>>> Did you have a chance to test it with OpenBMC dbus-sensors?
>>>>> In general, the change looks okay to me, but since it modifies the behavior
>>>>> (applications will need to handle this, and returning an error will happen more
>>>>> often) we need to confirm that it does not cause any regressions for userspace.
>>>>>
>>>>
>>>> I would also like to understand if the error is temporary or permanent.
>>>> If it is permanent, the attributes should not be created in the first
>>>> place. It does not make sense to have limit attributes which always report
>>>> -ENODATA.
>>>
>>> The error is temporary. The underlying reason is that when host CPUs
>>> go to deep enough idle sleep state (probably C6) they stop responding
>>> to PECI requests from BMC. Once something starts running the CPU
>>> leaves C6 and starts responding and all the temperature data
>>> (including the thresholds) becomes available again.
>>>
>>
>> Thanks.
>>
>> Next question: Is there evidence that the thresholds change while the CPU
>> is in a deep sleep state (or, in other words, that they are indeed stale) ?
>> Because if not it would be (much) better to only report -ENODATA if the
>> thresholds are uninitialized, and it would be even better than that if the
>> limits are read during initialization (and not updated at all) if they do
>> not change dynamically.
> 
>>From BMC point of view when getting a timeout there is little
> difference between the host not answering being in idle deep sleep
> state and between host being completely powered off. Now I can imagine
> a server system where BMC keeps running and the server has its DIMMs
> physically changed to a different model with different threshold.
> 
> Whether it's realistic scenario and whether it's worth caching the
> thresholds in the kernel I hope Iwona can clarify. In my current
> opinion the added complexity isn't worth it, the PECI operation needs
> to be reliable enough anyway for BMC to monitor at least the CPU
> temperatures once a second to feed this essential data to the cooling
> fans control loop. And if we can read CPU temperatures we can also
> read DIMM thresholds when we need them and worse case retry a few
> times while starting up the daemon.
> 

Makes sense.

Applied.

Thanks,
Guenter

