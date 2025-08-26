Return-Path: <stable+bounces-172918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBEB3531D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 07:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F183B01D9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52351A23B9;
	Tue, 26 Aug 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZIXCni+"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DF11CA9;
	Tue, 26 Aug 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185399; cv=none; b=RYDEFMsAmgSlCsJeYPkE6QPzti21+syusYG5ccOO8niZoFWpqhM3wLlYM3pF9Uc9vQEQcPlOhebWdQtQGpzxu6b5X1PVpwkYmMU9Uy+7iS5yINQmthTWX1Rt/0hqz9+tTiYdweTWb6gKd8qCheJvUj8no5s52bhyGt5pCZcGs1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185399; c=relaxed/simple;
	bh=2jbbXl6GDwJvfi5DE0nXIK0RqpNAJHPFS3yDlEfn2QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQXgI96uAF2cc8zdIT0vSGD8UxCh1r0dXBEOETUwU6bQ+4BrAAuzjEH/q+i7kUJSe8YV9SSNLUNYunc+0AKQrvjBdSgcn24yoRqjC8zaX78XK3mNQkXQnG1IukP2HWxVORw8423v9d+ubSX/mvEJg7tNBYpZTOxTshAF18VzlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZIXCni+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1edc08b2-801f-4968-8198-ebb0d7c3accb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756185395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci1PdBuzNcOaR7y0193uhT7DsHMGCXsYNxvG0Vv+L28=;
	b=tZIXCni+4wK0EP62V+S2BZuZBIQQws2yaAgZvU3Iqj4kP9q8pHcuR98QSThIliOFz8mmYN
	XzdzZG5TMOKZnf63CvCg34Rft41XAaxTCJNEoym1yhUTRb0yum5IlLr0e9D/SkU455HAF8
	X/kcqfcjs/Oa1OwV1AsjPa0+mB7bBfY=
Date: Tue, 26 Aug 2025 13:16:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, fthain@linux-m68k.org, geert@linux-m68k.org,
 senozhatsky@chromium.org, amaindex@outlook.com, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org,
 jstultz@google.com, kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com,
 oak@helsinkinet.fi, peterz@infradead.org, rostedt@goodmis.org,
 tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
References: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
 <20250823074048.92498-1-lance.yang@linux.dev>
 <20250826140217.7f566d2b404ac5ece8b36fa3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250826140217.7f566d2b404ac5ece8b36fa3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/26 13:02, Masami Hiramatsu (Google) wrote:
> Hi Lence,
> 
> On Sat, 23 Aug 2025 15:40:48 +0800
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
>> To fix this, enforce a minimum of 4-byte alignment on the core lock
>> structures supported by the blocker tracking mechanism. This ensures the
>> algorithm's alignment assumption now holds true on all architectures.
>>
>> This patch adds __aligned(4) to the definitions of "struct mutex",
>> "struct semaphore", and "struct rw_semaphore", resolving the warnings.
> 
> Instead of putting the type flags in the blocker address (pointer),
> can't we record the type information outside? It is hard to enforce

Yes. Of course. The current pointer-encoding is a tricky trade-off ...

> the alignment to the locks, because it is embedded in the data
> structure. Instead, it is better to record the type as blocker_type
> in current task_struct.

TODO +1. Separating the type into its own field in task_struct is the
right long-term solution ;)

Cheers,
Lance

> 
> Thank you,
> 
>>
>> Thanks to Geert for bisecting!
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
>> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   include/linux/mutex_types.h | 2 +-
>>   include/linux/rwsem.h       | 2 +-
>>   include/linux/semaphore.h   | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
>> index fdf7f515fde8..de798bfbc4c7 100644
>> --- a/include/linux/mutex_types.h
>> +++ b/include/linux/mutex_types.h
>> @@ -51,7 +51,7 @@ struct mutex {
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   	struct lockdep_map	dep_map;
>>   #endif
>> -};
>> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>>   
>>   #else /* !CONFIG_PREEMPT_RT */
>>   /*
>> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
>> index f1aaf676a874..f6ecf4a4710d 100644
>> --- a/include/linux/rwsem.h
>> +++ b/include/linux/rwsem.h
>> @@ -64,7 +64,7 @@ struct rw_semaphore {
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   	struct lockdep_map	dep_map;
>>   #endif
>> -};
>> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>>   
>>   #define RWSEM_UNLOCKED_VALUE		0UL
>>   #define RWSEM_WRITER_LOCKED		(1UL << 0)
>> diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
>> index 89706157e622..ac9b9c87bfb7 100644
>> --- a/include/linux/semaphore.h
>> +++ b/include/linux/semaphore.h
>> @@ -20,7 +20,7 @@ struct semaphore {
>>   #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>>   	unsigned long		last_holder;
>>   #endif
>> -};
>> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>>   
>>   #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>>   #define __LAST_HOLDER_SEMAPHORE_INITIALIZER				\
>> -- 
>> 2.49.0
>>
> 
> 


