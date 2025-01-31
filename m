Return-Path: <stable+bounces-111846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61705A24243
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF51A168D15
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132851CD215;
	Fri, 31 Jan 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YqwpWY10"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8501E5701;
	Fri, 31 Jan 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345948; cv=none; b=rMtdE5y0C8wgTgBy60vKhGwHiLg67lyrwkTsFozPgkffVdK6r18RYu6mOGdRsvL+kIbtqvHnapW6Xf/usCp212cNWg6GCmULNfoQxWT0NtkezxEpSqTTprHwCNV36BMulhckrkhP2aqU92hbdWYzTvIM7MrMEtxIzntMIvSnkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345948; c=relaxed/simple;
	bh=rH9r7GGdDzz7ys5thmw9E6gZYx/6fySb5x8d6unw4j4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEaFj+SNF8j9k5qxuOwfVdbusgtZsJRAwZprKWSpRaaCFhbnXxuIvQBD2A+xsok7sOZmgTri6Yng7V5PD0NPRQdYCXd+doVMz+geBHwuZq22/u9NwokMw64O7lTTb2n0ygub8htoxoLFvotTw7cct9S4HRnkb7BBTjz+yVaNfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YqwpWY10; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.234.206] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 704792109CFA;
	Fri, 31 Jan 2025 09:52:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 704792109CFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738345946;
	bh=X3+uuE3lHwhvwb4/wtttSu3RsXd73os101p33Jto/OM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YqwpWY10GT3Ja4v4xeoLX9wG6Isx4wYcadiHzR35I9LmBHJ/QKp7KXcZO6+LqMxnD
	 YYoXYvyChnGxjzKWXtTZX8hy69N17QtFZcBDytu3uvrBaC1K5EiZabtzXaRW8CKSdB
	 mVZHjaFSDDmfOCgyJ3GNYmEaX0ade2Pr6Oy0G39A=
Message-ID: <7cd5aed4-aa3f-4aa4-9476-47bd57091f8f@linux.microsoft.com>
Date: Fri, 31 Jan 2025 09:52:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 eahariha@linux.microsoft.com, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] jiffies: Cast to unsigned long for secs_to_jiffies()
 conversion
To: Jiri Slaby <jirislaby@kernel.org>
References: <20250130192701.99626-1-eahariha@linux.microsoft.com>
 <3c99f58e-bd42-4021-ba36-039eeee9110b@kernel.org> <87bjvnpeqv.ffs@tglx>
 <04c2959e-bf41-4483-b30f-8b4b6a81242b@kernel.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <04c2959e-bf41-4483-b30f-8b4b6a81242b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/31/2025 12:52 AM, Jiri Slaby wrote:
> On 31. 01. 25, 9:30, Thomas Gleixner wrote:
>> On Fri, Jan 31 2025 at 08:06, Jiri Slaby wrote:
>>> On 30. 01. 25, 20:26, Easwar Hariharan wrote:
>>>> While converting users of msecs_to_jiffies(), lkp reported that some
>>>> range checks would always be true because of the mismatch between the
>>>> implied int value of secs_to_jiffies() vs the unsigned long
>>>> return value of the msecs_to_jiffies() calls it was replacing. Fix this
>>>> by casting secs_to_jiffies() values as unsigned long.
>>>>
>>>> Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
>>>> CC: stable@vger.kernel.org # 6.13+
>>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-
>>>> lkp@intel.com/
>>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>>> ---
>>>>    include/linux/jiffies.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>>>> index ed945f42e064..0ea8c9887429 100644
>>>> --- a/include/linux/jiffies.h
>>>> +++ b/include/linux/jiffies.h
>>>> @@ -537,7 +537,7 @@ static __always_inline unsigned long
>>>> msecs_to_jiffies(const unsigned int m)
>>>>     *
>>>>     * Return: jiffies value
>>>>     */
>>>> -#define secs_to_jiffies(_secs) ((_secs) * HZ)
>>>> +#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>>>
>>> Could you just switch the fun to an inline instead?
>>
>> It's a macro so it can be used in static initializers.
> 
> It's the only one from the *_to_jiffies() family we offer. And I fail to
> find such a use (by a quick grep, it only might be hidden)? People
> apparently use "* HZ" in initializers...
> 
> So sure, iff there is this intention for this very one, keep it as macro.
> 

Yes, the intent is to convert those usages of "* HZ" to use
secs_to_jiffies() for better readability.

Thanks,
Easwar

