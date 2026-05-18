Return-Path: <stable+bounces-249185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJSTL5CiCmqL4QQAu9opvQ
	(envelope-from <stable+bounces-249185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:24:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C295661B7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8951330243AF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457939B955;
	Mon, 18 May 2026 05:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4+i1Ho2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629F3A1D14
	for <stable@vger.kernel.org>; Mon, 18 May 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081707; cv=none; b=keGbyZGZif9QdFzvxzKpwvvL5FowbNhYR/tP27CL1YPqXE5J2PDI5g6SPSUUo4BovOBfw1f03YXs1TzvsoLFDpszweXd5eM7DjJBuyT2IHmfOlggNhTR5+671a97PoWHc3NpydRzUByii3Hk+IxAasduMfWk9lP/44H/O04x67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081707; c=relaxed/simple;
	bh=vNdKnsYYZlKkKhRJ8ehWd4hcpi7UO7QeQ3RXo2YHBqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkqdS0aTkrYc10qfq/OO3DWyJZhW3eK9yVUzMYIIBS+8EcA+ppAx5cErlTb5elHXXpWDyXTdj6mtbYCR+1ojflFsbaKwL6P8QyK59ZwEzaWyXFjxuPc9A+Er8LbL3yqHNFSUaD/wXXpHNyMIHqdsPjEQnkLz7SPNjp5BikkNbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4+i1Ho2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a4113ab355so2248941e87.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779081680; x=1779686480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COvqQNzUKLRtL3QdO0fWmfEMf02deV0mUukamXhTeL4=;
        b=O4+i1Ho2ZPlGtLDsYR83zal+utYP1A/8ULtF3LhaUZm1ZSrLId4v1xiuH0tL7TundM
         mCCcKMvLWP/N0uHWhBl+HOyGZw8jgLLij5y/QDPGYJl1cylLXXYyeESBqSLrAKZ/fAfl
         SCqUHmJOtYexiOkSxPsXdXruFC6excpJcNubHoC1I4TNN64FWyki5qjiHq/y6/+uTSRI
         8NL9+e1c4XsfXaMnaXUp3Y9bwMFLbc1+6vSavocVV3oaHUS9U5eRySQDpO9FYfHHkXtI
         6DOL4nr7UsrVi0wZ/DFZR1FB159hTz5Bf5aoDwtuZxj2vunEMiXHglBu4akFXY+ncbEe
         9HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081680; x=1779686480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COvqQNzUKLRtL3QdO0fWmfEMf02deV0mUukamXhTeL4=;
        b=DjjZfNehvBgXvbAuQJxBu/n61W2lxnoyLK4hKVzCBK+drZn2R+enn9KlsKsN+PYhqf
         oFKUJPhs5c1P6zETESqAGWlZERH7aEuufpF72TQYIR0nZwD6OCHPR5qoNN1fBksMVQmb
         KIt+Q9sHtxdo+OWT7cATVOaNs8ThPbc3oOp7tARkWRa5hjtMflEc2r1QxkZPqEBxGSur
         NULcF5M8vM/6ihBWh4oq0SisLElfm55NefbZKbejzOGI5iOKREJ6hOivkwUBuMTllpE2
         E/Uaw8B36eIpHTEkaqr+yGyCKG+ExlDGLKTiJ0XvWv7Zu4bR7O3YrXykjfTKtoJ1TZRl
         0cAA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z1UBTY0KXHJggqF1wxnpLWsBa6MGTxm9E/Goc9Qo2GMIZCK3rHV/gumMR2WqZczAfkB4pgkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuiCJI8Ry8Ic4LkdnrazHSF+tmhwzHnLD9SVhpZKISG12Nngt
	kTLa1TGEqmyelZ2q9/rtMVr2F/2Un3qzpznJjmrDNwsTlGlHZngblJ5E
X-Gm-Gg: Acq92OESWkYM15WPZRlF59Ld6p3GXimvOw7XKCk2IiSbojETJhoI9beK1aGyj7/2Es8
	w56Hk8eyLirTM6qkJmSvwKa5TzhXg1V+6b6VOoYXaJWPwHASEsw44yDAtDQlCgAuFAMIMOaz57c
	X6+5tXvKi/iq5ic1UakjFRMOSxbGTpCWlcJKOP289TrAo2XWcaEBrfPQM6R0x5gPOI+o3cKHv1p
	xyNm4u0M6lVP3esmNO1aJXd/k0epQTxvmdOCFX9eVbG4+L0SnFXQs9DHoGJZdKAIw0LWZStxc9B
	tGD+Fqj0zVBN2dytZ1iTfklDdcy03mPD9OcXb+9LoqzfErvs6+C0ePU3MvZMXKTQmjzlMoGliJ/
	GffIJulhdFBjK7PTUxG6YhjxeY/1aAK8pJb26IuuO6GqjwinjquZEY/HsgD7EtRwOLVsc/k0y3e
	vUX2cX1fgEVgNqhdplcByeYHFjpH+wucHMlLhqdpPPF7BGcutFO7ICBRX+aLEyo0F1C8/LSzSsK
	Vwwd/Uc1DcNV65bc2g=
X-Received: by 2002:a05:6512:1193:b0:5a8:fc93:85c1 with SMTP id 2adb3069b0e04-5aa0e73c325mr3744302e87.32.1779081679717;
        Sun, 17 May 2026 22:21:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882cf497sm10171221fa.16.2026.05.17.22.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 22:21:18 -0700 (PDT)
Message-ID: <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
Date: Mon, 18 May 2026 08:21:17 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: David Lechner <dlechner@baylibre.com>,
 Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 91C295661B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249185-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 17/05/2026 20:12, David Lechner wrote:
> On 5/17/26 11:08 AM, Stepan Ionichev wrote:
>> bm1390_trigger_handler() has three error returns:
>>
>> 	if (ret || !status)
>> 		return IRQ_NONE;          /* status read failed */
>> 	...
>> 	if (ret) {
>> 		dev_warn(...);
>> 		return IRQ_NONE;          /* pressure read failed */
>> 	}
>> 	...
>> 	if (ret) {
>> 		dev_warn(...);
>> 		return IRQ_HANDLED;       /* temp read failed */
>> 	}
>>
>> None of them call iio_trigger_notify_done(). The success path at the
>> end does, so on a single transient regmap or pressure-read error the
>> trigger never sees its use_count decremented, and the
>> !atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
>> drops every subsequent dispatch for that trigger. The buffered-data
>> flow stays wedged until the trigger is detached.

I don't really know the intended logic of the use_count, so I'll leave 
this to those who understand it better. I'll just add some thoughts this 
invoked.

I think it is not really nice to require (or trust) drivers to call the 
"iio_trigger_notify_done()" if the handler fails. Maybe it would be 
better to do something like:

void iio_trigger_poll_nested(struct iio_trigger *trig)
{
         int i;

         if (!atomic_read(&trig->use_count)) {
                 atomic_set(&trig->use_count, 
CONFIG_IIO_CONSUMERS_PER_TRIGGER);

                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
                         if (trig->subirqs[i].enabled)
                                 handle_nested_irq(trig->subirq_base + i);
                         else
                                 iio_trigger_notify_done(trig);
                 }
		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers 
didn't */
         }
}

to prevent this class of problems once and for all. But yeah, wiser 
minds have designed this - so let's hear some other opinions as well :)

>>
>> The IRQ_HANDLED return on the temperature path additionally leaves
>> the temp branch's last partial state in &data->buf.temp without
>> pushing the sample, which is the existing intended behaviour; only
>> the missing notify_done() needs fixing.
>>
>> Funnel all returns through a single 'done' label that calls
>> iio_trigger_notify_done() before returning the saved irqreturn_t.
>>
>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
>> ---
>>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> index 08146ca0f..c18352399 100644
>> --- a/drivers/iio/pressure/rohm-bm1390.c
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>   	struct iio_poll_func *pf = p;
>>   	struct iio_dev *idev = pf->indio_dev;
>>   	struct bm1390_data *data = iio_priv(idev);
>> +	irqreturn_t result = IRQ_HANDLED;
>>   	int ret, status;
>>   
>>   	/* DRDY is acked by reading status reg */
>>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
>> -	if (ret || !status)
>> -		return IRQ_NONE;
>> +	if (ret || !status) {
>> +		result = IRQ_NONE;
> 
> IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
> and the handler will likely just run again immediately. So it probably
> isn't the right thing to be returning in the first place.

This is exactly why IRQ-none is returned, and what it is used for. If 
the problem with bus-access / device persists, the kernel will (after 
XXXX fails indicated by IRQ_NONE - don't remember exact numbers) disable 
the IRQ from the host side, and emit the, ass-saving, "nobody cared" -print.

This is (in my opinion) the only RightThing(tm). (Especially so, if the 
device is accessed from the fast handler, and is system is single-core). 
There is a tremendous difference when debugging a system which just 
hangs in IRQ loop forever (and you can't get no contact to it), and when 
debugging a system which, after a relatively short hang-up, let's you 
see the magic "nobody cared" -print telling a misbehaving IRQ was disabled.

Furthermore, if the status register read failure was a temporary one, 
then we should be getting new IRQ as soon as the handler exists. This 
should then successfully handle the IRQ.

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

