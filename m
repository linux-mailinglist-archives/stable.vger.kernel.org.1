Return-Path: <stable+bounces-202699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D573ACC31F4
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EAED302EDB9
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BC3BE559;
	Tue, 16 Dec 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C31bi5xv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894763BE54A;
	Tue, 16 Dec 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890976; cv=none; b=R5kzp6DCO0G3Oim0Zt9gqSa6xLqz8iCSD5BY6/eCkvW+lwX1eU2M78Nemmsytnt5HBacVilUgJ/acG/q1DCb0f4qKjE/On4Jb1up4gyqjQcYRcVDwjjhKbMjNRayeQbelGf5CP71cjyeo/aJ3DD6f/mr+MOAAlQ8iAxbebEygPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890976; c=relaxed/simple;
	bh=2qLm7qLP78yIq98BOJp7Lpf5E6IukjXo8jHsSvSSKms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORh7yiyU/lwOZxtvg3dpzizeqNJbTqb84ggTklS2Q+Uq+3Np3+llrZl3oQHPyx49F0y8ysZyd9VyamChprbRncyFvt5XxE3IMBnBMciGjZmjFKBaZmsB5GqXuI4TmL85xwoOD1LaZ13YHxHwTQMCFR3AOhDbX9jAx9eKX6Y4lCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C31bi5xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB61C4CEF1;
	Tue, 16 Dec 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765890975;
	bh=2qLm7qLP78yIq98BOJp7Lpf5E6IukjXo8jHsSvSSKms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C31bi5xvG825o6nobsWDqZtAW94+2GEfq0tFJAY4/IUJ66prEIEsReaxEZpTyeHYd
	 C3GI8SrEXQGf4QSar6YHgI7lSEdjzQR4w4bobdILk9cEXyn66yJaHasPTTWqBsUjYl
	 d+U70VhhjCu3cbKzb+bNrbnVybzjglkIQYI/5wQqeoISeY5Op5vW6h8V+xWS2lNIv6
	 HGFowuDbT5FFgSRrJpu/6BTqhSPfq1gZotRgYZ1mFrAhSPcUOkxM2R+ey0S3/vJnoD
	 H7FhB/XI9iPgVM6PHIl35evOYIay3hVAzKHRH0JiGrC0uji9msAiNMfYusWvZkRCQM
	 KvFUhq4kBN3zw==
Message-ID: <6d4b05af-40ec-4bbf-9045-f259315e5332@kernel.org>
Date: Tue, 16 Dec 2025 14:16:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Huisong Li
 <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251111204422.41993-2-thorsten.blum@linux.dev>
 <243ec26f-1fe1-4b3c-ab24-a6ebab163cde@kernel.org>
 <20251216092809.2e9b153d@pumpkin>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251216092809.2e9b153d@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2025 10:28, David Laight wrote:
> On Tue, 16 Dec 2025 08:11:13 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 11/11/2025 21:44, Thorsten Blum wrote:
>>> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
>>> bytes and a NUL terminator is appended. However, the 'size' argument
>>> does not account for this extra byte. The original code then allocated
>>> 'size' bytes and used strcpy() to copy 'buf', which always writes one
>>> byte past the allocated buffer since strcpy() copies until the NUL
>>> terminator at index 'size'.
>>>
>>> Fix this by parsing the 'buf' parameter directly using simple_strtoll()
>>> without allocating any intermediate memory or string copying. This
>>> removes the overflow while simplifying the code.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>> Compile-tested only.
>>>
>>> Changes in v4:
>>> - Use simple_strtoll because kstrtoint also parses long long internally
>>> - Return -ERANGE in addition to -EINVAL to match kstrtoint's behavior
>>> - Remove any changes unrelated to fixing the buffer overflow (Krzysztof)
>>>   while maintaining the same behavior and return values as before
>>> - Link to v3: https://lore.kernel.org/lkml/20251030155614.447905-1-thorsten.blum@linux.dev/
>>>
>>> Changes in v3:
>>> - Add integer range check for 'temp' to match kstrtoint() behavior
>>> - Explicitly cast 'temp' to int when calling int_to_short()
>>> - Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/
>>>
>>> Changes in v2:
>>> - Fix buffer overflow instead of truncating the copy using strscpy()
>>> - Parse buffer directly using simple_strtol() as suggested by David
>>> - Update patch subject and description
>>> - Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
>>> ---
>>>  drivers/w1/slaves/w1_therm.c | 64 ++++++++++++------------------------
>>>  1 file changed, 21 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
>>> index 9ccedb3264fb..5707fa34e804 100644
>>> --- a/drivers/w1/slaves/w1_therm.c
>>> +++ b/drivers/w1/slaves/w1_therm.c
>>> @@ -1836,55 +1836,36 @@ static ssize_t alarms_store(struct device *device,
>>>  	struct w1_slave *sl = dev_to_w1_slave(device);
>>>  	struct therm_info info;
>>>  	u8 new_config_register[3];	/* array of data to be written */
>>> -	int temp, ret;
>>> -	char *token = NULL;
>>> +	long long temp;
>>> +	int ret = 0;
>>>  	s8 tl, th;	/* 1 byte per value + temp ring order */
>>> -	char *p_args, *orig;
>>> -
>>> -	p_args = orig = kmalloc(size, GFP_KERNEL);
>>> -	/* Safe string copys as buf is const */
>>> -	if (!p_args) {
>>> -		dev_warn(device,
>>> -			"%s: error unable to allocate memory %d\n",
>>> -			__func__, -ENOMEM);
>>> -		return size;
>>> -	}
>>> -	strcpy(p_args, buf);
>>> -
>>> -	/* Split string using space char */
>>> -	token = strsep(&p_args, " ");
>>> -
>>> -	if (!token)	{
>>> -		dev_info(device,
>>> -			"%s: error parsing args %d\n", __func__, -EINVAL);
>>> -		goto free_m;
>>> -	}
>>> -
>>> -	/* Convert 1st entry to int */
>>> -	ret = kstrtoint (token, 10, &temp);
>>> +	const char *p = buf;
>>> +	char *endp;
>>> +
>>> +	temp = simple_strtoll(p, &endp, 10);  
>>
>> Why using this, instead of explicitly encouraged kstrtoll()?
> 
> Because the code needs to look at the terminating character.
> The kstrtoxxx() family only support buffers that contain a single value.
> While they return an indication of 'overflow' they are useless for
> more general parameter parsing.
> 
> The simple_strtoxxx() could detect overflow and then set 'endp'
> to the digit that make the value too big - which should give an
> error provided the callers checks the separator.


Yes, there are two values here, so obviously this is right.

Best regards,
Krzysztof

