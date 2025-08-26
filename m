Return-Path: <stable+bounces-172917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E11B35300
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DAD207002
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 05:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755B2E1753;
	Tue, 26 Aug 2025 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAvXq27g"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53E284678
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185082; cv=none; b=BgAsVrEhh05fnwmF5/nR4bcNBG/EkhRNDYNrJSHuVwXTK4xd/S44qj178aEycn02UNW6RmLEFFAv0pW8jlgC/KUzSCktpvYSrCGkeAxOLm+P6Sl2KIZzfgR4+5XCMqKnBdyO3C7XwYm4loRrYvSxh+HkT+tLPTV5PmvbBSdrmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185082; c=relaxed/simple;
	bh=Zep0X6tOZE7uCnOoXvywPLCzT+CHkninh3NN6ejLEP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy+cwg4d4oaEtmxxBpb7P//3N5WZs+zBSzWEP0wIBr4Q9ijmtyZWrw/eM20sUhfcOEltkd27K2SFUlfdI0PoOBsuMW9uqX4yWTCGEpdt8l2CURXC6E7Kr1tNMvf/tCn4BdKTxne78QH8dUDtOkgUKLuoV/Bl0AcG9Xcej9RXpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAvXq27g; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca2785fa-ae29-44c9-8975-d7c98cd3792a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756185068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Q8IHLPdJUwQIRPuLkN+Fy+s8sGPjU+fhep8gdOFrYA=;
	b=VAvXq27gGTap0o7vdV7eVUEsxp8b6UdBFvNn1/ypjaDdQ3ZoQGu0hnwhdGj8TWzE8fpi56
	S6KMzDlkuNRqZ8UmGcL0LwcvkQWG9ceMoWORkrybKGDBKVkWAxDtD9T1ULN84eZEt9Fyve
	wI1w+1jXtZw3zPay6DK9/5E5ft+U/3E=
Date: Tue, 26 Aug 2025 13:11:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 akpm@linux-foundation.org
Cc: fthain@linux-m68k.org, geert@linux-m68k.org, senozhatsky@chromium.org,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com,
 oak@helsinkinet.fi, peterz@infradead.org, rostedt@goodmis.org,
 tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
References: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
 <20250823050036.7748-1-lance.yang@linux.dev>
 <20250826134948.4f5f5aa74849e7f56f106c83@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250826134948.4f5f5aa74849e7f56f106c83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for the review!

On 2025/8/26 12:49, Masami Hiramatsu (Google) wrote:
> On Sat, 23 Aug 2025 13:00:36 +0800
> Lance Yang <lance.yang@linux.dev> wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The blocker tracking mechanism assumes that lock pointers are at least
>> 4-byte aligned to use their lower bits for type encoding.
>>
>> However, as reported by Geert Uytterhoeven, some architectures like m68k
>> only guarantee 2-byte alignment of 32-bit values. This breaks the
>> assumption and causes two related WARN_ON_ONCE checks to trigger.
>>
>> To fix this, the runtime checks are adjusted. The first WARN_ON_ONCE in
>> hung_task_set_blocker() is changed to a simple 'if' that returns silently
>> for unaligned pointers. The second, now-invalid WARN_ON_ONCE in
>> hung_task_clear_blocker() is then removed.
>>
>> Thanks to Geert for bisecting!
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
>> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> Looks good to me. I think we can just ignore it for
> this debugging option.

Exactly. As Peter pointed out, most architectures would trap on the
unaligned atomic access long before this check is ever reached.

So this patch only affects the few architectures that don't trap,
gracefully silencing the warning there. This makes it a clean and safe
fix for backporting.

Cheers,
Lance

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you,
> 
>> ---
>>   include/linux/hung_task.h | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
>> index 34e615c76ca5..69640f266a69 100644
>> --- a/include/linux/hung_task.h
>> +++ b/include/linux/hung_task.h
>> @@ -20,6 +20,10 @@
>>    * always zero. So we can use these bits to encode the specific blocking
>>    * type.
>>    *
>> + * Note that on architectures like m68k with only 2-byte alignment, the
>> + * blocker tracking mechanism gracefully does nothing for any lock that is
>> + * not 4-byte aligned.
>> + *
>>    * Type encoding:
>>    * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
>>    * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
>> @@ -45,7 +49,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>>   	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
>>   	 * without writing anything.
>>   	 */
>> -	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
>> +	if (lock_ptr & BLOCKER_TYPE_MASK)
>>   		return;
>>   
>>   	WRITE_ONCE(current->blocker, lock_ptr | type);
>> @@ -53,8 +57,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>>   
>>   static inline void hung_task_clear_blocker(void)
>>   {
>> -	WARN_ON_ONCE(!READ_ONCE(current->blocker));
>> -
>>   	WRITE_ONCE(current->blocker, 0UL);
>>   }
>>   
>> -- 
>> 2.49.0
>>
> 
> 


