Return-Path: <stable+bounces-172685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB0B32D55
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 05:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F9B1884F8E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9312C544;
	Sun, 24 Aug 2025 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nk8FL6JD"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5004A3C
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004630; cv=none; b=Aha+WNn6fjjCL87OFQmQW56OFojLJHs+757DX4Z4t4drH7W0GlEt/vxJM+HBPkyCPC2SZwNIuTjpq/B7mEv3KcfDUt/rcxQ99zehWcY4rjwZAcTGC08KYnUge3spYbrARHKGvwc1A+NhRxheNBMMgqDpli/7AI2FhO76lzYrM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004630; c=relaxed/simple;
	bh=+K/lszVKxf3zzyrhgjV3ZU2mbm5nQv+U8vo/X8QeaFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4n2yru9o5zTQn6eMD6l47x8jzOKvd/9XJgfQLb7X2joySTx70gbUsqPbOrp9XL1PyFLhxkfvLJCthCKSVPyck/69moPMl6xrERWegCrEJC1AiWgZmAtKsgjnf8HjrxGawDyemhGN1cDpSI6baprvswsV2vQulKn6QRwRNSq7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nk8FL6JD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756004625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc7ef/Ksi7DMP/n4li7WBwB/KUitXglMZ31+KczhEos=;
	b=nk8FL6JD3EJlk3oaPS9NHiiWDtH9a3G8AgJc22t/aaOPZKLMO3UsQ41vQ5Whi6Io/oAONw
	xNWMSzlQlX2+u5Gm67klHcIxPzept8c/WeTc91egj8XK5x+1+4lNN1vH7Ac7jyp/VAlo5f
	7yEPOWxJ57inI8miV7zMWAxEh0mTlDk=
Date: Sun, 24 Aug 2025 11:03:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>, akpm@linux-foundation.org,
 mhiramat@kernel.org
Cc: kernel test robot <lkp@intel.com>, geert@linux-m68k.org,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Finn, Hi all,

Thanks to the kernel test robot for finding this issue, and thank you,
Finn, for the explanation!

On 2025/8/24 08:47, Finn Thain wrote:
> 
> On Sun, 24 Aug 2025, kernel test robot wrote:
> 
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from sound/soc/codecs/mt6660.c:15:
>>>> sound/soc/codecs/mt6660.h:28:1: warning: alignment 1 of 'struct mt6660_chip' is less than 8 [-Wpacked-not-aligned]
>>        28 | };
>>           | ^
>>>> sound/soc/codecs/mt6660.h:25:22: warning: 'io_lock' offset 49 in 'struct mt6660_chip' isn't aligned to 8 [-Wpacked-not-aligned]
>>        25 |         struct mutex io_lock;
>>           |                      ^~~~~~~
>>
> 
> Misalignment warnings like this one won't work if you just pick an
> alignment arbitrarily i.e. to suit whatever bitfield you happen to need.

Yes.

The build warnings reported by the test robot are exactly the kind of
unintended side effect I was concerned about. It confirms that forcing
alignment on a core structure like struct mutex breaks other parts of
the kernel that rely on packed structures ;)

> 
> Instead, I think I would naturally align the actual locks, that is,
> arch_spinlock_t and arch_rwlock_t in include/linux/spinlock_types*.h.

That's an interesting point. The blocker tracking mechanism currently
operates on higher-level structures like struct mutex. Moving the type
encoding down to the lowest-level locks would be a more complex and
invasive change, likely beyond the scope of fixing this particular issue.

Looking further ahead, a better long-term solution might be to stop
repurposing pointer bits altogether. We could add an explicit blocker_type
field to task_struct to be used alongside the blocker field. That would be
a much cleaner design. TODO +1 for that idea :)

So, let's drop the patch[1] that enforces alignment and go back to my
initial proposal[2], which adjusts the runtime checks to gracefully handle
unaligned pointers. That one is self-contained, has minimal impact, and is
clearly the safer solution for now.

[1] https://lore.kernel.org/lkml/20250823074048.92498-1-lance.yang@linux.dev
[2] https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev

Thanks,
Lance

