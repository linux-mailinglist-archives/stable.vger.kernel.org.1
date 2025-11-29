Return-Path: <stable+bounces-197641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09372C941B1
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981D33A5BFB
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B886218AC4;
	Sat, 29 Nov 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLv4BGfF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A71EE7B9
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431725; cv=none; b=qppp0R6egUh7G5E7engyfG+PSQfxn2ri79+0pEvsmEj4bHzMqKub+qTbu6BS61lESwLvTMY/M3+yEAfJ8PWc/To/l1Ph/5SK5XCIs8VIUy27aqHbN5sT1EdL5Z+YuptU/dtpRQk9IIJZ2uHKsS5I5ia+atB6zP2rlBmmkG7/SJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431725; c=relaxed/simple;
	bh=hW7QVlUNpaZY7Ylf70i9DgbfCIcNy1XWz+MAxnt4CqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iz4O2A2i/P5Cv9TYQ7eivEfccTJq05ghulwgqHZ6aSOAeLBw8xGCK3yiIyvgGvEy71W4DXuOJmKCHuSbFmhJxlhqgeh/CJTdCzPm5zTQYRBdjCffbt2AZJdh1rRzvMH+9AfkwSGj0icIRFfPpGc5Q3g1y1x3GgKyR2JlSDZ4VzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLv4BGfF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso3376738b3a.0
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764431722; x=1765036522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FILplgLXEZgxFeyo/Z95euXOg6o1DHgnlcHWIEY4wAI=;
        b=FLv4BGfF8jKy7LmTLjCQZB5e7faLlOwNAhxmpUE3y5Tx+ODJQWZ8m3V/KSA5auCXTP
         EN/jgYzKpcrzd9szbkLRiJCgbqfOZUJv88hJnUlptiQBIF6cR6wXwvcYHwvlPZukhlnW
         +EyMBUTt7FXKivGYCub7gK1z+GRno1L9YyaVSBAJF5FXLOFwKVKc6cy3rNiBn/atZ+U3
         XhBKp7cA75LtbKh87pWzOYowhodOG9ucjyDbB0Ou8C04Lr89uCk+mca58HtSRkzos5Rk
         3DgzjlkJ0hXekw1tstJ8v8fokWYnuOOqhjJKBAf4R9KMDf2nO8+sZ5PgUglIQLpCVZSa
         aqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764431722; x=1765036522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILplgLXEZgxFeyo/Z95euXOg6o1DHgnlcHWIEY4wAI=;
        b=vzmnhfqYZpyZp/cD7Fboqh0+MattaD4JFtcCfvZI5+QhJ1vyQPRYOgu4yjzpAFrj0P
         qBzZNd5yWg5DhKIulKFNlMGxcXakyW0SRMpEofD0RRAQPoTtef7vaqrCGr31C45zvDc1
         3S+QoKMv1yBIeZEW6R7iWgUkCobelbO0ryfoicZMpg1OtZEm7G/vQqORtCyTPHvdk2gy
         vDUTGOPw6HGyWo3KDEBYiqKvimpurb+rp+xUGxLsM6IAJC6B4cWLAFgQy/pvUoBj+4q2
         5K9t5JiyAjZ5sH0RS+JHBl0azKvFJNEWk8Jf+AYRHjZWjOr16MTU7bHLNAlmK5P7zrgH
         KLYA==
X-Forwarded-Encrypted: i=1; AJvYcCXILE0bbWo8ksapOMega5LWQTG/SGjBoA9ZGJqcV8BxixFBwknXKXrZZulWLQ1d+JfJg33+CVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlc+tysc/oZNIu49gERCszKXfTotRxiKPhR7xhhTlUePfr+jpy
	Eqv7dV0SUJf9TxwcVX3sxKGOv8j4TR5ntjkSLyYsXbR0uLXtyhaAQyBA
X-Gm-Gg: ASbGncsy+sy3U/lhwhUo4SKn0kLuC89egz9uadH/nwdz3mjY9Fk0m22PWVQ2kn4j0fw
	ak+LZwBwEzh1pQqSoq5kPhjSqDDlQWD5EMJlvhcvik7O09+z8AvwcizWFB7AmiVJFsNYkylAE7C
	tSqB/Eoc3dmLRvGwVBQeIXv3okvIpL91dh1vI45m0jQDzSNw5gdYAzwJKsuSBTFpPqiPgcdl/hp
	CYfm+6ne7zHRBWCTYkmWMHmbGPf14u4Manor1Nof7/FPJmFMEibyFg/fCp4xT/+UQvN0fFFVs+w
	S+M7bqAOZiBxTR+Jc7mrom5IzNilj48JGELGo3//bNjwFeWzq9AOVW40kcdhuwjTzGKv47wGirN
	NY2moZeDoviAHRgAjHlmnNT3uci7ktUQaA4h6gW7lRo2ki4PQNEroAeBpiqTrekkpRY0700r2l2
	UsolHgRl0iHawdjqb23ykxWL5tIFEnsivxbGK7FXPuLHRVYJz/QhCZ2ctsXuD89Z+u9SkjlQ==
X-Google-Smtp-Source: AGHT+IEBD9n7FNKv88IprgbhQGe+ktNn1QSzk/wly9q12lcdGNCFafUk2CIt/NKIrUJYcNrG99yZZw==
X-Received: by 2002:a05:7022:2393:b0:119:e569:f279 with SMTP id a92af1059eb24-11c9d865659mr25569004c88.34.1764431722166;
        Sat, 29 Nov 2025 07:55:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm40532343c88.1.2025.11.29.07.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 07:55:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a989d07a-a473-4d9a-ae76-d39de6981e35@roeck-us.net>
Date: Sat, 29 Nov 2025 07:55:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid
 TOCTOU
To: david laight <david.laight@runbox.com>,
 Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20251128123816.3670-1-hanguidong02@gmail.com>
 <20251128193720.0716cc6d@pumpkin>
 <CALbr=LbYY-_-Uc_45fXDYzOMiYTJpwbNpuj41q2nHmdfangcBQ@mail.gmail.com>
 <20251129101736.000fac82@pumpkin>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251129101736.000fac82@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/29/25 02:17, david laight wrote:
> On Sat, 29 Nov 2025 08:33:42 +0800
> Gui-Dong Han <hanguidong02@gmail.com> wrote:
> 
>> On Sat, Nov 29, 2025 at 3:37 AM david laight <david.laight@runbox.com> wrote:
>>>
>>> On Fri, 28 Nov 2025 20:38:16 +0800
>>> Gui-Dong Han <hanguidong02@gmail.com> wrote:
>>>   
>>>> The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
>>>> multiple times. When used in lockless contexts involving shared driver
>>>> data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
>>>> conditions.
>>>>
>>>> Convert the macros to static functions. This guarantees that arguments
>>>> are evaluated only once (pass-by-value), preventing the race
>>>> conditions.
>>>>
>>>> Adhere to the principle of minimal changes by only converting macros
>>>> that evaluate arguments multiple times and are used in lockless
>>>> contexts.
>>>>
>>>> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
>>>> Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>>>> ---
>>>> Based on the discussion in the link, I will submit a series of patches to
>>>> address TOCTOU issues in the hwmon subsystem by converting macros to
>>>> functions or adjusting locking where appropriate.
>>>> ---
>>>>   drivers/hwmon/w83l786ng.c | 26 ++++++++++++++++++--------
>>>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
>>>> index 9b81bd406e05..1d9109ca1585 100644
>>>> --- a/drivers/hwmon/w83l786ng.c
>>>> +++ b/drivers/hwmon/w83l786ng.c
>>>> @@ -76,15 +76,25 @@ FAN_TO_REG(long rpm, int div)
>>>>        return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
>>>>   }
>>>>
>>>> -#define FAN_FROM_REG(val, div)       ((val) == 0   ? -1 : \
>>>> -                             ((val) == 255 ? 0 : \
>>>> -                             1350000 / ((val) * (div))))
>>>> +static int fan_from_reg(int val, int div)
>>>> +{
>>>> +     if (val == 0)
>>>> +             return -1;
>>>> +     if (val == 255)
>>>> +             return 0;
>>>> +     return 1350000 / (val * div);
>>>> +}
>>>>
>>>>   /* for temp */
>>>>   #define TEMP_TO_REG(val)     (clamp_val(((val) < 0 ? (val) + 0x100 * 1000 \
>>>>                                                      : (val)) / 1000, 0, 0xff))
>>>
>>> Can you change TEMP_TO_REG() as well.
>>> And just use plain clamp() while you are at it.
>>> Both these temperature conversion functions have to work with negative temperatures.
>>> But the signed-ness gets passed through from the parameter - which may not be right.
>>> IIRC some come from FIELD_GET() and will be 'unsigned long' unless cast somewhere.
>>> The function parameter 'corrects' the type to a signed one.
>>>
>>> So you are fixing potential bugs as well.
>>
>> Hi David,
>>
>> Thanks for your feedback on TEMP_TO_REG and the detailed explanation
>> regarding macro risks.
>>
>> Guenter has already applied this patch.
> 
> Patches are supposed to be posted for review and applied a few days later.
> 

As long as I am the maintainer of this code, if and when to apply a patch
after it was posted is my call to make.

>> Since the primary scope here
>> was strictly addressing TOCTOU race conditions (and TEMP_TO_REG is not
>> used in lockless contexts), it wasn't included.
>>
>> However, I appreciate your point regarding type safety. I will look
>> into addressing that in a future separate patch.
> 
> It's not just type safety, and #define that evaluates an argument more
> than one is just a bug waiting to happen.
> We've been removing (or trying not to write) those since the 1980s.
> 
> You also just didn't read the code:
> 

That is just a claim. It could be seen as insult, so I would kindly
ask you to refrain from such comments.

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
> Both those only work if 'val' is 8 bits.

Yes, and it is. What exactly is your point ? It says "temp_from_reg",
and reg is an 8-bit value. Passing it as int doesn't change that.

> They are just ((s8)(val) * 1000) and generate a milli-centigrade
> value from the 8-bit signed centigrade value the hardware provides.

Exactly, and the code above does that. Yes, I know, "((s8)(val) * 1000)"
would have been more efficient, but, again, it is my call to decide if
I request that or if I think that the patch I accepted is good enough.

Thanks,
Guenter


