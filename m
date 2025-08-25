Return-Path: <stable+bounces-172777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48DB335B1
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95CE17EEF6
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388F23CEF9;
	Mon, 25 Aug 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deQub1nM"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C1DED64
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098027; cv=none; b=bwSueU/38io2bmiQx4WF24Y+TFME4IoaLrai+K+uPLH6CWk7kMeGsenUPBFoOiUGYBJx6QVgB8PeVzQaAAno5DPK9ghC0/QtLaRSQbWzauGlXxMSsYGOrk/9Y86dZEw2kzuptanqNMCQ1u5riteyO0M1v4sSsafIasUlfdtsnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098027; c=relaxed/simple;
	bh=M1v7MgXYo2ZiAJLrPGScb7fokwoK7VA0/6vpxL6DlOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlzRQVpl8JX8X7/dYcx8so2Y/afR+NIkfBa9ABFf/gjYD0EPyorEn5h0NgHoZbjNeR+Z6Ozcjxy4SFWljs6JDU6dhoWxORvryuEmakLr+ea/SRHZOb0A/x+ONOzYlxVSwmu5wPWx6eIDUv9PY5tXaQyAPuhsPVbEvv83Uuia5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deQub1nM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756098011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twXdCbxQD+p45jDlWlWguELy0/DhGVBnMbLch4+9XPE=;
	b=deQub1nM8cbt2AwA9kv9b3GMZFv/No8mwmXGpvLZ0MQRjfzPohPnMsGhCQxTdxrUJugUwH
	+WZF9NWWzrI5feE6Jk1J+rBItdJonYgg0V5ek3bQ9aVZLeoCt2o9xkSWTpQUXflf9Twl7m
	Fsi8TJwDmBedibOhIhVQAM0C3RQXBAg=
Date: Mon, 25 Aug 2025 13:00:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi,
 peterz@infradead.org, stable@vger.kernel.org, will@kernel.org,
 Lance Yang <ioworker0@gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com>
 <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/25 12:07, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Lance Yang wrote:
> 
>>
>> Perhaps we should also apply the follwoing?
>>
>> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
>> index 34e615c76ca5..940f8f3558f6 100644
>> --- a/include/linux/hung_task.h
>> +++ b/include/linux/hung_task.h
>> @@ -45,7 +45,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>>   	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
>>   	 * without writing anything.
>>   	 */
>> -	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
>> +	if (lock_ptr & BLOCKER_TYPE_MASK)
>>   		return;
>>
>>   	WRITE_ONCE(current->blocker, lock_ptr | type);
>> @@ -53,8 +53,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>>
>>   static inline void hung_task_clear_blocker(void)
>>   {
>> -	WARN_ON_ONCE(!READ_ONCE(current->blocker));
>> -
>>   	WRITE_ONCE(current->blocker, 0UL);
>>   }
>>
>> Let the feature gracefully do nothing on that ;)
>>
> 
> This is poor style indeed.

Thanks for the lesson!

> 
> The conditional you've added to the hung task code has no real relevance
> to hung tasks. It doesn't belong there.

You're right! The original pointer-encoding was a deliberate trade-off to
save a field in task_struct, but as we're seeing now, that assumption is
fragile and causing issues :(

> 
> Of course, nobody wants that sort of logic to get duplicated at each site
> affected by the architectural quirk in question. Try to imagine if the
> whole kernel followed your example, and such unrelated conditionals were
> scattered across code base for a few decades. Now imagine trying to work
> on that code.

I agree with you completely: scattering more alignment checks into core 
logic
isn't the right long-term solution. It's not a clean design :(

> 
> You can see special cases for architectural quirks in drivers, but we do
> try to avoid them. And this is not a driver.

So, how about this?

What if we squash the runtime check fix into your patch? That would create a
single, complete fix that can be cleanly backported to stop all the spurious
warnings at once.

Then, as a follow-up, we can work on the proper long-term solution: changing
the pointer-encoding and re-introducing a dedicated field for the 
blocker type.

