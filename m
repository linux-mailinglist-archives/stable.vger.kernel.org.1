Return-Path: <stable+bounces-253778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBuKM/dQEGq5VwYAu9opvQ
	(envelope-from <stable+bounces-253778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:49:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C75B476C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E212F303A919
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607C399CE2;
	Fri, 22 May 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q887/Xbp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6C37FF5B
	for <stable@vger.kernel.org>; Fri, 22 May 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453541; cv=none; b=rlMlGLDIuU19FC+FWSMGJbxT/phyp1z9f/VYOdFjzfqnD3Gn/cHMMSPMMCZXCwAgY+BBRDAZK7rV0c7K0HpOe8M6vYEPODmCEOrOYUNopQN30wmcI1oF6Ke1cAPmAncPKmYRIWAOhuu8AhFwFtutAcvqQy0xtn0sBSbAHLNzoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453541; c=relaxed/simple;
	bh=Qe+U4HO7WD8KknELE7AjHe+LqmBJ+B1Rtp/U1kePi/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNLQU9FjqEue1IAG6BE+QpL14LE/JyRs3n7+zmF/eq5abzYzde1qpO+F2U72YtZKMuozPqmDh2pgOXrn/2Tr/QATQkdCyhzO7/zdruY8ZTUO8sBlpkcP+TzLZiH7iwcPD5fHppDz7yIlDUi823dT9+EdmfMQBnrZfp0RsSxBny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q887/Xbp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8721851e2so8469338e87.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453537; x=1780058337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnfk/VbrXKWZP8/5WpIT3Z2vqg/BP7hHVgXBgV215sA=;
        b=q887/Xbp2Jg3CNQknKgj6q4gmCcLYdMh86TvnFQM2t8S7jv5GfR3idTji/XsaTkw9l
         CPq+r4rJB8YPIL/k83qS+wp3uSdLRf6+B0HrH8fXhyMscQ+cxMK5tA+RI9e0rzAC4hgD
         fzl6z85A1hxyZKhbkTsuEcZsBfz8h/3U/ntzI3GmJdVHudJ5firFN/BT1mc0GPzf02V4
         vazsD9GimzinylTK8K8QvbMQepqEkJ+M4+NtyjmLHjpbmFgZxuG1tpiOtDhODT+W5czI
         hO1SS0Wq8ANVXejr1GOQDOoH3c/P5PZHNX012O93OItHnq/kGvXJhjvl973VPKjd9g1q
         6Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453537; x=1780058337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnfk/VbrXKWZP8/5WpIT3Z2vqg/BP7hHVgXBgV215sA=;
        b=kKXEydsGKg0z63vV8qF4/5gDu/0aPQoYtl6kxHah/qpIym3r8lc8RfgOtrPL8HVN5R
         us0aUywLkO9BCfs9cKlJmwh07qVI7pksjxglvb9hwmhZmD1sTSaGUtjeo6IXYDhkHlwm
         oIUnEZRryF7FHjOEbtv8fflCBfCfIOqe7Z+XzK2PgVWwtHbPFQ+1HxaxlkuAVLbvkjAn
         Q3Bpxkx28DXPVL12pNxg9JlUpxhv1474hGYUN0Mus2FRrQCZj8Aj9JPyirmte3pO9yS9
         ymncOKjNdsB32C6UwZgHtaHClkvhHzMq8W+MRSEI9xs3VwuyXAfuHY1a4TslvYJRXbb2
         XSzg==
X-Forwarded-Encrypted: i=1; AFNElJ/eTKiBwXW5yNy8TeZdkLSMdZxdFqWOT0fCSgFheaxS2dNfXhaM75pR3xFY4caS5/ifOqQQ8TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZOAlQdXDOE3124s0EJJYJihO606UyvpTu64o54j8fY7DSZ/4
	MVNudnr/W9nSkJQ4Abpngujy8Hugc0UbwX/dNDVKB2uRado5fSdOTl3J
X-Gm-Gg: Acq92OGkZVtEoqywk+huQ8xJIWuLyDSELH87h4yEk87q/eERfix3LW3Qrlf+QVlxCtW
	dnxBpLklZM0HpjuSWTcgbO17cDPM5aJs/bdqvh+wYmcL5JpQzetlpIRs0pUSEtrBk4fgx8mcscR
	YHznoe/d/xmlpjfm/up4ppw57snPJ1xmgJ0xJgqGIB8qwN6MdeiE+MnlPVlV799rxeXVtI5d9AC
	jheClcxsE2i6rCY7UKE8EyQPSwhDRWxg0Mo3/jRvIecQro3vDVcyaUe0tSSsbEq5F8djZGDYACW
	ru4Xj1bWyX9MWSbl+eeVVdrVYdR0Ag/jwm/ySH0peJyhDbFJn4jNxuLIloJHaQ2C1RNgJGAzJuv
	uqFjXxWbLUjn8Z7bddli1hMjcFnygq7Ae3X4/2DzsjOpvhX59s2O7W7+lqXwG0MRd/GWHBTQ3qQ
	R8ETScsJrdpT3aD3LGjnQQHoYyGWmaJk65YidmaaRL6dbb9Jgw00VyD0EDQgFM36oHtgWXrdRhu
	ELnC9If
X-Received: by 2002:a05:6512:31c5:b0:5a8:f04d:573a with SMTP id 2adb3069b0e04-5aa3232b465mr1276360e87.17.1779453537271;
        Fri, 22 May 2026 05:38:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbaaf2sm404364e87.33.2026.05.22.05.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 05:38:56 -0700 (PDT)
Message-ID: <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
Date: Fri, 22 May 2026 15:38:55 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260520120822.351aa58f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253778-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B0C75B476C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/05/2026 14:08, Jonathan Cameron wrote:
> On Tue, 19 May 2026 08:48:13 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Thanks Jonathan,
>>
>> Your post give me something to think about ;)
> 
> This is a can of worms.  More below.
> 
> I'm unconcerned as long as (and ideally someone should check it)
> we can get of being stuck by unbind/rebind of driver.  Anything
> else is best effort.
> 
> 
>>
>> On 18/05/2026 18:15, Jonathan Cameron wrote:
>>> On Mon, 18 May 2026 14:42:38 +0500
>>> Stepan Ionichev <sozdayvek@gmail.com> wrote:
>>>    
>>>> bm1390_trigger_handler() returns from three error paths without
>>>> calling iio_trigger_notify_done(). The success path at the end
>>>> does, so on a single transient regmap or read failure the trigger
>>>> use_count is never decremented, and the !atomic_read(&trig->use_count)
>>>> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
>>>> The buffered-data flow stays wedged until the trigger is detached.
>>>>
>>>> Funnel all returns through a single done label that calls
>>>> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
>>>>
>>>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
>>>
>>> These error path 'fixes' are fixes for hardware failure - so if anything
>>> they are hardending  against a possible error condition. I don't mind
>>> that bit it's not a bug to not do this so fixes tag an stable are not
>>> appropriate for any of these.
>>>
>>> Note however that hardening against these conditions is not this simple.
>>> It takes careful analysis of exactly how the hardware behaves and what
>>> each error condition 'might' mean.  Whilst they are probably harmless
>>> I'm also very dubious about taking them without comprehensive testing
>>> on the particular device.
>>>    
>>>> ---

//snip

>>>>    
>>>> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>>>    		ret = bm1390_pressure_read(data, &data->buf.pressure);
>>>>    		if (ret) {
>>>>    			dev_warn(data->dev, "sample read failed %d\n", ret);
>>>> -			return IRQ_NONE;
>>>> +			handled = false;
>>>> +			goto done;
>>>
>>> Hopefully all this stuff is unrelated to the trigger.  For these it is fair to
>>> ack the trigger and the interrupt.  Curiously the driver does it partly for the
>>> next one (IRQ_HANDLED).
>>
>> I would keep the IRQ_NONE here because, if we keep constantly failing
>> the reads, then the bus is likely to be unerliable - and disabling the
>> useless IRQ is probably very sane thing to do. It should help debugging.
>> What comes to acking the trigger - I am starting to agree with Stepan,
>> we should probably ack the trigger in any case. If we don't ack the
>> trigger, then the IRQ_NONE does not serve the purpose it is intended for.
> 
> The interrupt that we'd get spurious detection on here would not be the device
> one it would be the software emulated one deep in the iio trigger stuff.
> 
> Might still be useful for debug. Anyone fancy hacking an error in and reporting
> back what we actually get from the debug hardware?  (with that trigger acked
> as you suggest?)

No promises but I'll see if I can try out something next week...

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

