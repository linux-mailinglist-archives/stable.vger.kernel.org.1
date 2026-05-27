Return-Path: <stable+bounces-254499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ0/KXGeFmq1ngcAu9opvQ
	(envelope-from <stable+bounces-254499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:34:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F185E081A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64AA300B623
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2D390CB7;
	Wed, 27 May 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asya3E9u"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383E3C09F1
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867184; cv=none; b=PT27XyC8ezIpCJKw4u+RMkwzh27EcadMsXmGMYCh0YSJ7FhWVqKCeBYf8HmOw7srZtsi2wFXCFI7BHfktaMWlqA37bQV3H3aBuHtt9AaNEj5bb2JlAjFGSI4oeM7cAXooL42IE6UhIFmrp3Zy/B1+sA5/WFtTi6vYTdaSFLj7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867184; c=relaxed/simple;
	bh=5Tee8Ss7lVikSWcDsjK7FCkoxIfVoi67SVTOwAWY7Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tri3Wh99/IngEFcCDv4xyGUYHype5nRDYVqdqfC1EoJYqb29Hu/Ujq7QwjUZ4u98FBQu+pU7/yWWmpJmJ4IoKoH+keHyhn4XZZ5Iws8rsQMIpTaNYy544vC82XnotA+VnbKNF4sFt8N0gvr1Fvvv/9WTm8l7igz9rw3Z/SosxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asya3E9u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso36933065e9.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867181; x=1780471981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvVoq60kjeElEbHQ7jSTrbLPRosQJq300xgMTu6D2Ng=;
        b=asya3E9uIBlKxnX/WogiX7wqViawfz3VsBzW7uq2HQPqgNJH044tBgwQWvy6UPkZAZ
         tyhsfZEIipnc5JBQSCs66GW9V+/oJQVSxVZoGm9ifIjEnukvhDkfShUO1ARGDL2j9A0w
         lem5/MO7DgRWT8DqUhyBOY5uQ/73fMt1YjMuUVk1W1TBs1qQ6o1hopuMM5v3cvWk9bvl
         4A9sNcV4ChLvTrIfTiBX/6/lJeE5C4709PHHbnCSyxaYM7hC5qs5UYLRjfazyGYYOHni
         emlGe10TXYNo2PxxX4cihUn2jXot7vy9u46r4h98bNsjTdSjWdCwivtsZmM4gAUn9a4a
         X7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867181; x=1780471981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvVoq60kjeElEbHQ7jSTrbLPRosQJq300xgMTu6D2Ng=;
        b=Jo4Cq+NyYXnwGFzkJtANakIhiS+JJzWDX+lD194czPwPHZgB5bas++hji3DVbdJqOV
         NDvqXv+pyVrJHpPU5VHCsRqjd1jQd9zW2bM7IpU0sougPrjwBK7iYu0sMGYj6rVKOEwk
         6leiijtmb8kaayYSanrZsIgS4j4XtgdSdtfDBIRvJQkxzKLOBdgXWLB/orZ+6mZ38GQ7
         i7X1mzAjaPWyj02J5fdD7EZkz1MLoc3yJqYNz8gc1QRarTvwWZele8nCHmBaejxfxx2w
         iBLYPjcQdo7Q4Z7MEXfbeXCe2UhqxUE+7skwRv6iMgb33Z0MA2+ow7gIPcQLrS2pZfhV
         DQ5g==
X-Forwarded-Encrypted: i=1; AFNElJ+Caf3N2Lt0SMlSb7efzx3e0lkCi/xZU1tlZzcZdYBxbyqoI45IaeqDltlRCFli2Ur8QYObDGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7LaMUuz7lgKQPTaszv37vZiw2YNQuqkxaE2kDc4sA7rJWvfr
	JnFnvbsAZ+8Cw1d8inpSzN+GPtyYGw4obEUGrEDxj1MA9EityVxR0dCL
X-Gm-Gg: Acq92OHBeQmSQxrt/zcomrZP0ZIS9idortonlze+V5zIg+3NzdEsqRF0/6bGk/TU0JQ
	IwuiKVfnSzF1PU3dwqiQ2i7/fMk0NPUIVuE/h0/s+xZVmATvypjUonVUIvctoDBc4sQ2jIb4JJw
	54dJrO0U5N4I8VccS+QrP7QCeog/c59gSnvsUzxe36TVJWWIoXVVMDMIdrZSC2MXYYNMW6m9Sct
	LJxtmbDlcCFA9oXDr7j29RRx0e/CQckf5yMhMdgVQzlAPsS/Ld+d8fcCgYIFfvrpA7yAtCH4tnk
	A9uR0If09uoBVdBAbWjWLu+GkKpfQfBGxbkLoAaUkadDfwUtTx9fCHeP8hI47+WHRCVqk6xc7Mp
	moNoLBGKn9YS7rFecrtJdf01sjRnwztQ2fH/gHwggdfoVrVuEAAUpe/w+W2vZJuj2GWEIvDSNdL
	EHNvifbtwYr0OmrhKAaObXHxpw8qm+8+SZCexoXAoYqdxGclLpMc6MpYXxnfKTGNBM
X-Received: by 2002:a05:600c:3e12:b0:490:40f1:5314 with SMTP id 5b1f17b1804b1-49042482845mr388648385e9.1.1779867181120;
        Wed, 27 May 2026 00:33:01 -0700 (PDT)
Received: from [192.168.2.178] (109-252-156-195.dynamic.spd-mgts.ru. [109.252.156.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2a07sm3619977f8f.19.2026.05.27.00.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 00:33:00 -0700 (PDT)
Message-ID: <7cc7626a-ba83-46bb-9a52-325d84bcdfb1@gmail.com>
Date: Wed, 27 May 2026 10:32:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Mark Brown
 <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
 <20260520161900.GM2767592@google.com>
 <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
 <286ebc23-944a-4374-8128-3511c68cd1bf@gmail.com>
 <6017863a-6587-4b6d-8c10-ade27fbafc2c@tecnico.ulisboa.pt>
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <6017863a-6587-4b6d-8c10-ade27fbafc2c@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254499-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digetx@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32F185E081A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

21.05.2026 12:19, Diogo Ivo пишет:
> 
> 
> On 5/20/26 18:44, Dmitry Osipenko wrote:
>> 20.05.2026 19:23, Mark Brown пишет:
>>> On Wed, May 20, 2026 at 05:19:00PM +0100, Lee Jones wrote:
>>>> On Wed, 20 May 2026, Diogo Ivo wrote:
>>>
>>>>> This patch was motivated by the Sashiko review I got in [1]. Its point
>>>>> here is that there is a possibility for a deadlock scenario in which
>>>>> a secondary CPU obtains the mutex for the regmap and then
>>>>> smp_send_stop()
>>>>> is called before this secondary CPU gets a chance to release the
>>>>> mutex,
>>>>> making it so that when the primary CPU tries to acquire it to issue
>>>>> the
>>>>> write it hangs. Is there something that I am misunderstanding here?
>>>>>
>>>
>>>> It's my understanding that using the Regmap wrappers _prevents_ locking
>>>> issues, rather than causes them.
>>>
>>> In the case where the CPU is being powered off during a regmap write
>>> there is a potential issue - as Diogo says if we're in the middle of
>>> holding the lock and we power off the CPU that owns the lock then it
>>> will never be able to release the lock.  I would expect the same issue
>>> to apply to a bus like I2C or SPI though, they'll hold a lock while
>>> they're in the middle of doing bus I/O unless you use some special API.
>>
>> Sounds bad
>>
>> Diogo, check if shutdown works with added nosmp to kernel's cmdline.
> 
> So to be clear shutdown already works with regmap_update_bits() and I
> have never encountered this deadlock in my testing as the write to power
> off the PMIC needs to happen at a very specific timing. I imagine adding
> nosmp will just guarantee that the deadlock can never happen.
> 
>> BTW, you can use i2c_smbus_read_byte_data+i2c_smbus_write_byte_data to
>> keep the old regmap_update_bits behaviour.
> 
> My question here is more if this is actually needed or we can skip the
> read. In any case the patch that Lee merged is with regmap_update_bits()
> so for the time being this is not a problem.
I'd suggest not to change anything if there is no real problem.
Otherwise you pleasing ai bot without understanding the problem, maybe
problem doesn't exist in practice.


