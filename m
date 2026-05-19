Return-Path: <stable+bounces-249462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFwZBL/5C2qCSwUAu9opvQ
	(envelope-from <stable+bounces-249462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:48:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD675778F1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 724113026246
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32641342CBA;
	Tue, 19 May 2026 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnFFmYxR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15934D389
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169699; cv=none; b=UUjliLEJJUWxe1mfdKHYG0LnpQxNmBd9nNOlrI4R68IdUGMNiFSbASzms1ZtlOv/bqU7MxnX8jliQca5s8axhe9TXkpUUYdliuh7lb8q7GNefKPoCyoUuKWzLD8i8FeMxmwLMpMP4mldSs5SjBp2hmsCSpvWVT2blu+B0QuxxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169699; c=relaxed/simple;
	bh=XSmaZ+UW/aCsbh2Vbt1bjvGPeen1IM3+50X6oQvT1vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+ysNU9YY8+BJT8UFYXOsnR4uhhnqB/38hUUi2eYSVLHsbUN1nS+OCx3j2dzb5ctiUAcDX1XBGcxaAYbM3kLzYQOg32z/hFwxKseOL16/13z+kWVFgbb7sLEERy5TsP4scL3nevZHcypzBxHl5m2JUk381CyoRI8G1Fkbpi7QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnFFmYxR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso3926807e87.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779169695; x=1779774495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEVyf9cnprh4FvJXJW8Kjk04ICfYyCmgvfIQVl+Ic3A=;
        b=LnFFmYxRJs93FlcuvajYu8Cn1+mRScrKqsvocynd3Mojglo6BbIZu0yaFtXFtr4Kfj
         PoFjFhirqicVq5b/ToLFFcQ5qdZ25Q2rZgurwHi3RghjwPflSOQQPbRo2ViK3FBbuppe
         mNrG9aOhRkTEdAH1qJoOmU9ioydNWouvV+ihzr4RenqJLhUr8Xm9pDQzjPYa/MvJ3OG5
         rN6zcgRsGCEsqYpQFmkzXlHxdxCfw+uYAqspOFrg2oHkUa4BzAe2eyFB5QMzsvp4Ucg/
         VMMNCfl++POU7GH2yCKOnlT889bvTF0AvEydb+kijTdfhbnPMLBe2QFeJ/2wmMfmk91S
         WlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169695; x=1779774495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEVyf9cnprh4FvJXJW8Kjk04ICfYyCmgvfIQVl+Ic3A=;
        b=KSxvq1MvI9bVLw+71MztGjQ4p6IuKIjr5mn1mU3QZpmS9rYQNIo7C8o+q+EoPTQu1U
         an+vP4ONPzv1L1HbISeiWNd5YDNvXgT9+xYush1E3IWyt9n4DP09gdkUFIm/jpe/sL7r
         hI6bmJDMW9lqLfLE3lFtk61gMFhwjIOnVXxxzNaY0q/MHBw8JmRuoK5lyOzKMCQBd4CT
         ZDEXzSKW9QqS6eNRJOc8Aeq34QMDkCAEfgWTJP9+wu2MzBYJHOILwD+1PkSOXB0odFIE
         MihqUOwMKfP0ejftoi7W0LjoHqfAuxLtoWFmsxXOhEUvAo6j9sMa7A0hFbWMavPgKp9R
         /f5A==
X-Forwarded-Encrypted: i=1; AFNElJ+0839/1B/rYabLNhxpCSjV68N8LXk9/nMmaHU8KE8dMsQQcjVdqfa+/A+rCp/8ubf0WaMfsvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3S0PSyj14TicKoa4ejTbxVEX4LLMsSCbCYTk+KSHOQcB+Ln2Z
	tIKNlxfeyLOCRu1IIuzzN+jGGCCnuT5zreQML4aIBlURAHOpmzyiuIt9
X-Gm-Gg: Acq92OFTbQxelqC1CAMpjkT4uNigor4aCThAfac6onU24L42BmQ2MSqV/Qr2W9DVbUQ
	oxKt6VcEOyd6jYqSPvbGhF+5/YHjCPnJguJkXWS0a/NUKU3Fz31FoQyXCkIUXXZNQ7/V7gV0Hjq
	sST+1MDBJPLOwgrpuTxSiSzG1NhJkP96P+3efNMM/3DZlp3RQGKZhw2WxpW33Uk9ay73BC2QyUt
	C5N8dStzmbssoVwknENWtW859A42C7j9HKB2B1PwsKKwmZ+i1DTapt2hlId3KvoxCKxhWo7hMmI
	7Bn2UYG8HZryycQFvoMpP19l2AQDAILlNS01wsRwKHx2ITlGYc52fuYMJWpOGIMjq9OH8mFNDTm
	Hr4+IxRF2g6w7CwEQX86R1x0AgOB1NRDnctGOo1W+xvYtzD9ZxYcFihZ938Akf+q/cpXeFTndT6
	BLTuzSUvZPojvD4WqdDQfpwqsdQrwtichgfWTd5T4DZH1mESABGviarDQSo8YuOSBqTneoB8GmT
	KLJqSfs
X-Received: by 2002:a05:6512:1094:b0:5a7:468f:1b82 with SMTP id 2adb3069b0e04-5aa0e605829mr5610086e87.1.1779169695116;
        Mon, 18 May 2026 22:48:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c3928sm17628411fa.11.2026.05.18.22.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 22:48:14 -0700 (PDT)
Message-ID: <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
Date: Tue, 19 May 2026 08:48:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Jonathan Cameron <jic23@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260518161516.53f21777@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249462-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CD675778F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Jonathan,

Your post give me something to think about ;)

On 18/05/2026 18:15, Jonathan Cameron wrote:
> On Mon, 18 May 2026 14:42:38 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
> 
>> bm1390_trigger_handler() returns from three error paths without
>> calling iio_trigger_notify_done(). The success path at the end
>> does, so on a single transient regmap or read failure the trigger
>> use_count is never decremented, and the !atomic_read(&trig->use_count)
>> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
>> The buffered-data flow stays wedged until the trigger is detached.
>>
>> Funnel all returns through a single done label that calls
>> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
>>
>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> 
> These error path 'fixes' are fixes for hardware failure - so if anything
> they are hardending  against a possible error condition. I don't mind
> that bit it's not a bug to not do this so fixes tag an stable are not
> appropriate for any of these.
> 
> Note however that hardening against these conditions is not this simple.
> It takes careful analysis of exactly how the hardware behaves and what
> each error condition 'might' mean.  Whilst they are probably harmless
> I'm also very dubious about taking them without comprehensive testing
> on the particular device.
> 
>> ---
>> v2:
>> - Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)
>>
>> v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
>>
>>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> index 08146ca0f..81368e578 100644
>> --- a/drivers/iio/pressure/rohm-bm1390.c
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>   	struct iio_poll_func *pf = p;
>>   	struct iio_dev *idev = pf->indio_dev;
>>   	struct bm1390_data *data = iio_priv(idev);
>> +	bool handled = true;
>>   	int ret, status;
>>   
>>   	/* DRDY is acked by reading status reg */
>>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> So question 1.
> - What actually is device state if this read fails?  We have no idea.
>    It might have failed on the 'to device' path in which case the device
>    didn't see the read.  Or it might have failed on the 'from device path'.
> 
> Gets more complex...
> 
>> -	if (ret || !status)
>> -		return IRQ_NONE;
> 
> The trigger in use might well be the dataready trigger provided by this driver
> (though I note this device has no validate callbacks so we do allow other
> triggers - that may or may not be a bug!)  I really dislike read to clear
> register designs as they make this stuff more complex.

I have a strong feeling it should be the dataready. Still, I have no 
idea about actual systems using this driver, so I am a bit cautious 
adding new restrictions.

> Anyhow question 2:
> - What happens if we don't clear it and do acknowledge the interrupt plus
> ack the trigger (which is what iio_trigger_done() is doing?
>    Two obvious options - wedged device, it re interrupts immediately.
> If we are wedged, then meh device dead. Without adding retry loops
> (don't) recovery path is reset the driver by unbinding and rebinding.

The BM1390 keeps the IRQ pin asserted.

> Fun follow up is what happens if having acked the data ready trigger
> by this read, we get another read before getting to iio_trigger_notify_done()?
> 
> Quite possibly we wedge.

I see. This isn't fun at all. Even more so if the trigger use-count now 
prevents us from calling the handler, and returning further IRQ_NONEs, 
preventing the safety-mechanism intended to disable the offending IRQ. I 
have a feeling there is IRQF_ONESHOT set though, so perhaps we are safe 
from this (when no error path is taken in the handler).

> This drivers trigger may be missing a reenable() callback
> (which would typically reread the status register to clear any such interrupt).

Which works for case where we "get another read before getting to 
iio_trigger_notify_done()" - but not for a case where we might have the 
bus stuck, causing read errors.

> Whether it does is again a device implementation specific thing.
> 
> 
>> +	if (ret || !status) {
>> +		handled = false;
>> +		goto done;
>> +	}
>>   
>>   	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>>   
>> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>   		ret = bm1390_pressure_read(data, &data->buf.pressure);
>>   		if (ret) {
>>   			dev_warn(data->dev, "sample read failed %d\n", ret);
>> -			return IRQ_NONE;
>> +			handled = false;
>> +			goto done;
> 
> Hopefully all this stuff is unrelated to the trigger.  For these it is fair to
> ack the trigger and the interrupt.  Curiously the driver does it partly for the
> next one (IRQ_HANDLED).

I would keep the IRQ_NONE here because, if we keep constantly failing 
the reads, then the bus is likely to be unerliable - and disabling the 
useless IRQ is probably very sane thing to do. It should help debugging. 
What comes to acking the trigger - I am starting to agree with Stepan, 
we should probably ack the trigger in any case. If we don't ack the 
trigger, then the IRQ_NONE does not serve the purpose it is intended for.

>>   		}
>>   	}
>>   
>> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>   				       &data->buf.temp, sizeof(data->buf.temp));
>>   		if (ret) {
>>   			dev_warn(data->dev, "temp read failed %d\n", ret);
>> -			return IRQ_HANDLED;
>> +			goto done;
>>   		}
>>   	}
>>   
>>   	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>>   				    data->timestamp);
>> +done:
>>   	iio_trigger_notify_done(idev->trig);
>>   
>> -	return IRQ_HANDLED;
>> +	return IRQ_RETVAL(handled);
> If we are doing this Andy's suggestion of a helper is neater.
> 
> Anyhow, upshot is to get this stuff right requires device specific knowledge.

And time... :)

> Ideally the author tests injecting errors at each point to verify if the
> data capture survives.  However, it's up to a driver author to decide if they
> care.  There are normally dozens of paths in a driver that will result in needing
> a reset (unbind/bind for most IIO drivers) - that's expensive, complex, fragile
> handling code to maintain, so personally I consider it optional.

I am not going to try adding any such recovery code in driver. I am 
afraid it would be way too complex for me to maintain (with my memory, 
code I've seen last month is new Today) for the added benefit. If we 
have such a delicate system where this type of 'failure recovery w/o 
reset' is required, then such code should (in my opinion) be system 
specific and not generic. Most of the device users will never benefit 
from it, but will need to look at it...

What I DO care is the IRQ gets disabled (from host side) if it can't be 
acked (from device side). That shouldn't be so complex (although, it 
seems it is more complex I thought when I wrote this driver).

After all this babbling I've done - if I understood it right, omitting 
the call to iio_trigger_notify_done() will prevent further returns of 
the IRQ_NONE, even if the IRQ stays asserted. So yes, I would definitely 
like to see this fix getting in.

Thanks guys for giving me a lesson again!

> 
>>   }
>>   
>>   /* Get timestamps and wake the thread if we need to read data */
> 

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

