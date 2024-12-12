Return-Path: <stable+bounces-100924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EA9EE8E7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1AA168A9A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62026F2FE;
	Thu, 12 Dec 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQqCR4gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVCqAnzA"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175C213E9E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013948; cv=none; b=oBH3vMQN/TZ+OfCogyj/dMmRiMsMlD83bJj6ogkgy3TstCYX4wv77CjFdLsVNRzhUdCa7l5K0cwtek6wyGQKYAFcZ/hyi0h8PDQjy8lFROaH4YzskzWG+b1CIs9QSkX84zgnuBOeN2Y9dDuL2o3so+n3sWKHP4orRMzhxhIbVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013948; c=relaxed/simple;
	bh=+IaNur7q3nZAqW7wLKHoYXclGZ7UOgbbJaBcp1+stBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3XYlsMGPVzTVS0HsLdSODiQREPyhrN4FzJzijlalpCkXIW19V031GRSE9dvdnwpl15sfa21MIb2yRF2c5eiYtQ2UEsTDcM2eLWJ6utnxe0T1uhysQB95OUro1ChbAtF4b+1thsAA6pGvUe9eaBQdYfnWUa9gwpbFr92JGmcUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQqCR4gi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVCqAnzA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734013945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlndYzozqyql5l5TO6Yqma5lFwmbUZc6H9EYxrjP+gI=;
	b=NQqCR4giyONhz9vEhpDX5MKZGc3i9o2LmAsT9yLk+XmOYc6c6Mn3n0sFT/o1B38nHRizBc
	rBvg+9/yQIx9vPakMcQv2PUPAcm8Jb7Gv7j1TD/LoO73bC6gztsLAsZ8TiVxTxP3I7AJ3a
	3P3nYU2mOe5TRL/DlOiLE5o07X1YyilDtPYpl2Q7a66gFPUPzKgyjPPIGeZu6CS4jD9sJ8
	muNq7+Si16JUNkRRuHBzAOB4wQldnieHD1anx4tZG/MuY5tZLaTl6twyMhiNBv2TGghiJV
	8BWMXBhOfmyN3ovuTt88BBBbvV1XijwGfkWBeE4ngcB3f/UF/RRM0M6YjHLwUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734013945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlndYzozqyql5l5TO6Yqma5lFwmbUZc6H9EYxrjP+gI=;
	b=dVCqAnzAnsT81X1KmRC3Pq7a2e6eTGje/aoZpEz9z2Bn6Pb9Ydv4QOvdXPQ/zKQGjxPrkM
	9m0xhpdCYzAY6kBQ==
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
In-Reply-To: <2024121235-impale-paddle-8f94@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh> <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
 <2024121235-impale-paddle-8f94@gregkh>
Date: Thu, 12 Dec 2024 15:32:24 +0100
Message-ID: <87frmt9dl3.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 12 2024 at 15:18, Greg KH wrote:
> On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
>> > But I don't think these two commits are necessarily stable material,
>> > though I don't have a strong opinion on it. If c163e40af9b2 is
>> > backported, then it has it's own large dependency chain on pre 6.10
>> > kernels...
>> 
>> It's in the queues for some reason, let me figure out why...
>
> Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
> 6.12.y for now, thanks.
>
> But, for 6.12.y, we want this fixup too, right?

If you have c163e40af9b2 pulled back into 6.12.y, then yes. I don't know
why this actually rejects. I just did

git-cherry-pick c163e40af9b2
git-cherry-pick 51f109e92935

on top of v6.12.4 and that just worked fine.

Thanks,

        tglx

