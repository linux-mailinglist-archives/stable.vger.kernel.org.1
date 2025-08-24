Return-Path: <stable+bounces-172688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E2B32D93
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BE844423E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB181EBA19;
	Sun, 24 Aug 2025 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cepYAXge"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B281DD0C7
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 05:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756011780; cv=none; b=O+rmr95U8w9z9dHmjmPM66tBmn3lSwWByuUen+YBZK1clBjuOJiEC5S3afX7kBuPoBilxkoK3Q4zjYdOxiWzTOnS+CTijKN8cNKMTSDwM40oVlWX1HxJp/F9IPFrIeTW1jfcnec1Q+rrslQkslWkvtsUt8VOa1qLXEHDVEa16Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756011780; c=relaxed/simple;
	bh=tejoCZqNU5e1GU6VHE07uE14H+C8ZZh5dND8Sm7cosI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k82PGr1KwAfOYuXJZ/Uerp3rnbshUZAoqKpDTER1bBSnom5NuIOqg6se7y6ALdNe7gjBc2/q5noIA6VkOKkOG7GEDqM+ya6/VJ3WPg4i3KA7A7i649cBAYDdfRBcOgU1CN6U74GGDARKaCYzScUykD5oX/ax8KMq+8fMte1Et70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cepYAXge; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e27b6484-8fb9-4c7f-9c8f-4d583cb64781@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756011766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+C9CJkSEuQgYGHw1lbFUqDE2Jeb1C0+Cs1jri69fPE=;
	b=cepYAXgeUTdFov/Saqr7T9XgMErRDc+9/whTMHwDBmx0+kp6LvjmGjsaLf6+KdhtCqHJF7
	QoMRntHK5ANXrtS8FnvmJRAUYi19BT/RCMK1pdOspqmEc3nQlVjDghhc0prIbu6woHHYH/
	K35fp9I3fZz1jDKY3TDXdlYmtxCAF30=
Date: Sun, 24 Aug 2025 13:02:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org,
 kernel test robot <lkp@intel.com>, geert@linux-m68k.org,
 senozhatsky@chromium.org, oe-kbuild-all@lists.linux.dev,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com,
 oak@helsinkinet.fi, rostedt@goodmis.org, tfiga@chromium.org,
 will@kernel.org, stable@vger.kernel.org
References: <20250823074048.92498-1-lance.yang@linux.dev>
 <202508240539.ARmC1Umu-lkp@intel.com>
 <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org>
 <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev>
 <a70ad7be-390f-2a2c-c920-5064cabe2b36@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a70ad7be-390f-2a2c-c920-5064cabe2b36@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/24 12:18, Finn Thain wrote:
> 
> On Sun, 24 Aug 2025, Lance Yang wrote:
> 
>> On 2025/8/24 08:47, Finn Thain wrote:
>>>
>>> On Sun, 24 Aug 2025, kernel test robot wrote:
>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>      In file included from sound/soc/codecs/mt6660.c:15:
>>>>>> sound/soc/codecs/mt6660.h:28:1: warning: alignment 1 of 'struct
>>>>>> mt6660_chip' is less than 8 [-Wpacked-not-aligned]
>>>>         28 | };
>>>>            | ^
>>>>>> sound/soc/codecs/mt6660.h:25:22: warning: 'io_lock' offset 49 in 'struct
>>>>>> mt6660_chip' isn't aligned to 8 [-Wpacked-not-aligned]
>>>>         25 |         struct mutex io_lock;
>>>>            |                      ^~~~~~~
>>>>
>>>
>>> Misalignment warnings like this one won't work if you just pick an
>>> alignment arbitrarily i.e. to suit whatever bitfield you happen to need.
>>
>> Yes.
>>
>> The build warnings reported by the test robot are exactly the kind of
>> unintended side effect I was concerned about. It confirms that forcing
>> alignment on a core structure like struct mutex breaks other parts of
>> the kernel that rely on packed structures ;)
>>
> 
> Sure, your patch broke the build. So why not write a better patch? You
> don't need to align the struct, you need to align the lock, like I said
> already.

I think there might be a misunderstanding about the level of abstraction
at which the blocker tracking operates.

The blocker tracking mechanism operates on pointers to higher-level
locks (like struct mutex), as that is what is stored in the
task_struct->blocker field. It does not operate on the lower-level
arch_spinlock_t inside it.

While we could track the internal arch_spinlock_t, that would break
encapsulation. The hung task detector should remain generic and not
depend on lock-specific implementation details ;)

> 
>>>
>>> Instead, I think I would naturally align the actual locks, that is,
>>> arch_spinlock_t and arch_rwlock_t in include/linux/spinlock_types*.h.
>>
>> That's an interesting point. The blocker tracking mechanism currently
>> operates on higher-level structures like struct mutex. Moving the type
>> encoding down to the lowest-level locks would be a more complex and
>> invasive change, likely beyond the scope of fixing this particular
>> issue.
>>
> 
> I don't see why changing kernel struct layouts on m68k is particularly
> invasive. Perhaps I'm missing something (?)
> 
>> Looking further ahead, a better long-term solution might be to stop
>> repurposing pointer bits altogether. We could add an explicit
>> blocker_type field to task_struct to be used alongside the blocker
>> field. That would be a much cleaner design. TODO +1 for that idea :)
>>
>> So, let's drop the patch[1] that enforces alignment and go back to my
>> initial proposal[2], which adjusts the runtime checks to gracefully
>> handle unaligned pointers. That one is self-contained, has minimal
>> impact, and is clearly the safer solution for now.
>>
>> [1] https://lore.kernel.org/lkml/20250823074048.92498-1-lance.yang@linux.dev
>> [2] https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev
>>
> 
> I am willing to send a patch if it serves correctness and portability. So
> you may wish to refrain from crippling your blocker tracking algorithm for
> now.


Completely agreed that correctness and portability are the goals.

Please, feel free to send a patch.

