Return-Path: <stable+bounces-111776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B4A23A93
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E8B7A3E5E
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867114B086;
	Fri, 31 Jan 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzOBqs4R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3401tN6X"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC21474B8;
	Fri, 31 Jan 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312220; cv=none; b=W5If0aNC91OpUTYkKB6InWNSGYXtDIzqiWfiamf/wTWCNqtpw26Rt75Pv0kIYU7WOTSNP8qOQP21KL/909oTATNI9/kikibAdoJls5JdhALEF9JKmHZOMawBsgnauU9tt5MMGYvc0Yvx3lq7vAnZQexbvR0E4hMJ7VQ6rcb5jJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312220; c=relaxed/simple;
	bh=ui75wqL4zDVbPE5FxT1AXpwQNdWuDQ/ZISq1ZmLU7mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYDXCrpi9jGyZBe75nQWBfECptcdWl+OTqsDspe63vcOMU3JaHLfHAKik0PQX8lWfilaLR5NCUm+iuafFBRd9ZrBcN+WCIMpUMA+GZ4gcCoL3BZ1Ghe6P+bWUfTocJzWEozkmJocZpL4V9Vlm92zc72XIQAsjsipI2eftz9Y2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzOBqs4R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3401tN6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738312217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dh72hoG7r8uFDHYLjclyvn98U7Cc7oqExPBc9lcIw2s=;
	b=rzOBqs4RLEwwMW86Q+H+/0p+VDCoqNzm5Bd8/soMuZV4vESW6ugEFM2Npj1oqO96C7oJ/E
	QdDNYiBCxcA5lL/YDMmBIRPB/HzEcN1Nh+oFN8DdlLNKjo8IdtJSacOw67+7/eNMcbJaUk
	nh5Vnq9zFAKpl54+NnZ3cGS4/q73HKiLGYudYlwiaByWeFA9JoMKLh+3okTb/t8WS4k4GZ
	+DZuj26iaNJz5fM6zbiASinDKO9j/HwhREUG75o5KHCjwCQ/TXfV77pA8IfUW1w8EJU3k4
	r3G900TesW2sDTV1Jw7xSEb957NirxY5iQ/lr0f/oQpE3vqJ2jlwKem3H/F/8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738312217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dh72hoG7r8uFDHYLjclyvn98U7Cc7oqExPBc9lcIw2s=;
	b=3401tN6XErrwGzKOQCPasoiRkJcYVX/Cs90mroIDWiD00wseDJmcsMiYSJwLnd2m2d8jgj
	FO9qeBOriFzLgUAg==
To: Jiri Slaby <jirislaby@kernel.org>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Miguel Ojeda
 <ojeda@kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] jiffies: Cast to unsigned long for secs_to_jiffies()
 conversion
In-Reply-To: <3c99f58e-bd42-4021-ba36-039eeee9110b@kernel.org>
References: <20250130192701.99626-1-eahariha@linux.microsoft.com>
 <3c99f58e-bd42-4021-ba36-039eeee9110b@kernel.org>
Date: Fri, 31 Jan 2025 09:30:16 +0100
Message-ID: <87bjvnpeqv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 31 2025 at 08:06, Jiri Slaby wrote:
> On 30. 01. 25, 20:26, Easwar Hariharan wrote:
>> While converting users of msecs_to_jiffies(), lkp reported that some
>> range checks would always be true because of the mismatch between the
>> implied int value of secs_to_jiffies() vs the unsigned long
>> return value of the msecs_to_jiffies() calls it was replacing. Fix this
>> by casting secs_to_jiffies() values as unsigned long.
>> 
>> Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
>> CC: stable@vger.kernel.org # 6.13+
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-lkp@intel.com/
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>   include/linux/jiffies.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>> index ed945f42e064..0ea8c9887429 100644
>> --- a/include/linux/jiffies.h
>> +++ b/include/linux/jiffies.h
>> @@ -537,7 +537,7 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>>    *
>>    * Return: jiffies value
>>    */
>> -#define secs_to_jiffies(_secs) ((_secs) * HZ)
>> +#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>
> Could you just switch the fun to an inline instead?

It's a macro so it can be used in static initializers.

