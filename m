Return-Path: <stable+bounces-111782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA029A23AE0
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212AC1886B9A
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BB158874;
	Fri, 31 Jan 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H25rwDSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AA85260;
	Fri, 31 Jan 2025 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738313564; cv=none; b=C/ExE/QBnIGmV1Tc+8f0y/HT+dqCcI/HcLKLPFyL/HFoTRpxXK5RYWcqa+/NHgeJ4+WkcB2ZoHZfE6R7NZANqOSPRlJF0URhuS9ngaSQbOGBBa6qbkIF8VDSCrSQ1Bg3ciPp2LbnuiT+rvckLmf0c2xT5v4CMSDYVJfcxdxhru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738313564; c=relaxed/simple;
	bh=t4gbtketeCsH/213O9ETThVAqYYepBPaTKUNxrokcpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6IX6zbFzJZZ4nWIH5SCzsAo6NAvXnwWj69BOOyBkJrx1j/97xMfkR7qGLokhWRe9qsItwCCHAKw/vauc28OCE4YTUucjm7j8/eJAGpn2mXIwKP5qJEYlzFCmzS8nZQDeteWW/I7C2YE5PWhgK8vz9W7/37lDO4CIyMw0aDhfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H25rwDSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CE2C4CED1;
	Fri, 31 Jan 2025 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738313563;
	bh=t4gbtketeCsH/213O9ETThVAqYYepBPaTKUNxrokcpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H25rwDSZ7hpIJED12jC3/Vp6MJjZV38QLGjlbvseAT93jDpAZmwo2nAfTlCYUPK8k
	 efprGw+ZZdN6e4udK+i4J/sqj3wLvDT2mUY52L43fgotIbSo18/aY8Ymizqd3gIeFe
	 46l9wPlrBL7RzhRr5lHUl9TPnlJZ5y8szFXoU0gVJXsCyPs371RfnVrfYCe/WPftmH
	 ibmyey+rI8DLpi/jmJz/s8RtHzpJNH4rUbRi4dri/z3Uidw+CoDpHzBmHn9DfwOsga
	 M8M6vPotSQwhPlPZ+xNgC6yJGJ0JOSmBirLElGGhSMvZ8I+n/LF9awjRAc9UEShDuz
	 sQrft+Wu6pLcw==
Message-ID: <04c2959e-bf41-4483-b30f-8b4b6a81242b@kernel.org>
Date: Fri, 31 Jan 2025 09:52:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jiffies: Cast to unsigned long for secs_to_jiffies()
 conversion
To: Thomas Gleixner <tglx@linutronix.de>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
References: <20250130192701.99626-1-eahariha@linux.microsoft.com>
 <3c99f58e-bd42-4021-ba36-039eeee9110b@kernel.org> <87bjvnpeqv.ffs@tglx>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <87bjvnpeqv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31. 01. 25, 9:30, Thomas Gleixner wrote:
> On Fri, Jan 31 2025 at 08:06, Jiri Slaby wrote:
>> On 30. 01. 25, 20:26, Easwar Hariharan wrote:
>>> While converting users of msecs_to_jiffies(), lkp reported that some
>>> range checks would always be true because of the mismatch between the
>>> implied int value of secs_to_jiffies() vs the unsigned long
>>> return value of the msecs_to_jiffies() calls it was replacing. Fix this
>>> by casting secs_to_jiffies() values as unsigned long.
>>>
>>> Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
>>> CC: stable@vger.kernel.org # 6.13+
>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-lkp@intel.com/
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>> ---
>>>    include/linux/jiffies.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>>> index ed945f42e064..0ea8c9887429 100644
>>> --- a/include/linux/jiffies.h
>>> +++ b/include/linux/jiffies.h
>>> @@ -537,7 +537,7 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>>>     *
>>>     * Return: jiffies value
>>>     */
>>> -#define secs_to_jiffies(_secs) ((_secs) * HZ)
>>> +#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>>
>> Could you just switch the fun to an inline instead?
> 
> It's a macro so it can be used in static initializers.

It's the only one from the *_to_jiffies() family we offer. And I fail to 
find such a use (by a quick grep, it only might be hidden)? People 
apparently use "* HZ" in initializers...

So sure, iff there is this intention for this very one, keep it as macro.

-- 
js
suse labs

