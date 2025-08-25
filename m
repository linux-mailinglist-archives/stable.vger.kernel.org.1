Return-Path: <stable+bounces-172864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA7B34479
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075803AB35F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8802F99BD;
	Mon, 25 Aug 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="myakrKyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6eRjWpqa"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4119DF62;
	Mon, 25 Aug 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133204; cv=none; b=CKhQZvyF2ax8fMIOF/kU1p+iBxtfZpFlFvE3U329DTZfHls8m3JNwYbXVszw/+Sfb+qd7PiXp450/dt3v/UXRgu2Eqkh4ZtWDUwfNykaHJm/WfJu4XnFjeiZL2lyzWUUlKV6WiH2a9mLouYfGTb5jNv27PWq7XpvzmOPHQyJiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133204; c=relaxed/simple;
	bh=aRdU+yGyXXMzFsB5f3S/4wxChOq9ZRynopJeuq05YfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjQvpH9vqJqA2LbR8wOARW4/eEaBLmgGmLL299W68eJXmI2TfWMXyAC9X9Ub252rDCRNCALUOl2OdlxI7aarmkqUXccZIPK5v4jbrPQGfz/hvvO/pD+PBdDeoEDIsHkr6LU4N7CR4I3gtk6SWFpxHrdtlom+F1erTjydQn05hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=myakrKyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6eRjWpqa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <633accd4-dd4a-4179-b6d9-e87a2188cd73@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756133194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JG7OYpEtFvMiYuIl3HXEfziWUYJSK9TgN9UcyEGnZ74=;
	b=myakrKyCUl9C+0ZrVsNuWEjQC71HXvdjByDqAaBBvosiH0OLNMlOTjheJHrqLI0/D2cjPo
	PpHPpxROJymlGz2BNVZrgIdvA6mewQtO3DAdrMNF7a2R5aO5UPMIP/st9+wRctLKPwfTKv
	5eMmcXXJl4DTa9KJjw+W+kBIZ7OyYD5DbSPSDFqlIuqaHyaeduNLJ8aw0J+CRufnYMUoa8
	K18jHoACUKGumX9w5/SIJHXd5orJTi8kw5RBva8QfAcZeKZ+sPTU2oY5m7Ep1dJFOtoJEF
	GEK7fBq4lpnmxCzCfE5vS2j8WckAj736DU42cmJfb/+BEKwUWVyvXyx56pfiSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756133194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JG7OYpEtFvMiYuIl3HXEfziWUYJSK9TgN9UcyEGnZ74=;
	b=6eRjWpqaPJQA75fGfy8gfAJHdqRjQS6fhzV+Z5sC86FcTuYAORtUmSoNwVd5K2DifrjSQt
	VrBv3QcIxTIhMoDw==
Date: Mon, 25 Aug 2025 16:46:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
 <DB6PR05MB4551C55567E135005F7E6E95833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <e25ab816-f05a-4fcd-9a71-8b71e4e3c299@linutronix.de>
 <DB6PR05MB4551A2BC19AAE2BCE5ACD00A833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <DB6PR05MB4551A2BC19AAE2BCE5ACD00A833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.08.25 um 15:54 schrieb Maarten Brock:
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> 
> Hello Martin,
> 
>> Am 25.08.25 um 13:58 schrieb Maarten Brock:
>>> Hello Martin,
>>
>> Hi Maarten,
>>
>>>
>>> Why not just start the timer and check TEMT after it has elapsed and restart the timer if not empty?
>>> It would prevent busy-loop waiting.
>>
>> It would, yes, but couldn't this cause the time between last transmitted byte
>> and switching the RTS GPIO to be less than the specified RTS delay?
>>
> Maybe you can calculate the nominal duration of the transmission and add that to the delay?
> But yes, that could still result in a short delay.
> 
> You stated that the TEMT interrupt is not useable. Why not?

I see in my traces that it sometimes does not fire (even though it should be 
enabled and more than enough time has passed since the last byte).

> 
> But it does trigger the question what the RTS delay is used for?
> - Is it to overcome the transmission of byte(s) still in the UART?
> - Is it to overcome the transmission of the stop bit(s)?
> - Can anyone imagine anything else that requires a delay?
> - Is the given delay a minimum, typical or maximum value?
> 
> Maarten
>>
>> Martin
>>
>>>
>>> Kind regards,
>>> Maarten Brock



