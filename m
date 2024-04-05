Return-Path: <stable+bounces-36121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD689A047
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB11C231C0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5316F27A;
	Fri,  5 Apr 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xs+/50jC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NBZEQQWF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0234E16DEAB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328937; cv=none; b=JJ8PH2Jerrvq035xEOASYI/3uo07Ko+2WylyP78uWtqv+/Ywh3c2uXObEOWTQSJgBq4ui7B9NWg4U30hKmx62v37mcBFbECZ3s8gNeBYDAdjEgvxhsaCBeO+ePAcaxKhUfCOpFE5aixw2EvolvIQVS2gIFHa4HQ0aSFfFSnlNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328937; c=relaxed/simple;
	bh=ancYg3HP4qSlLq3eREYpcL/mx43N/UWEjgFANuWkknA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7r/l1AcXkokL+HS1L26MbP/amTZF14Xu1m2Kr1ZRVG9xJtqLp9Q5xqnTiYjdf7xAAWEkKaKfeG2l2Nmip1MkSYgExYUmMebjH6EDnLuXcUxTMbW32hnUWbUw7JQ9GABHo9ZJkTBNzVNa7ZhIoPP/oxYhTEH/Bm25QkSZ5iUVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xs+/50jC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NBZEQQWF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712328933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxnpTUuyc8UWm+4m7aYHxuKWQGRvMPtGchvdt2jULjc=;
	b=Xs+/50jCSbrxsKpqokkii0z35fpfMB2aJg/+5Ibb7Jcb7QTKLJJU7+ZigTVQNSF7M/kMCM
	xWK87iHMrPd7/y15eEIPMr0V8ELG9hl3ZTJQzUeN40NTzgta/STJwGb7eoXRAfgvKqC35j
	YnwIIovwA8a3ToukLb074Hrfml8eAOOSmrtJdtXrnrS4wvK7ipJ+cyzpdZ16onVIikwOvE
	YMVj+G6CoqR4PCXF8ldv8yN0vZb8BrUSh98AE4kzQ1UOGYSWlUrMYYO6MM9iK5+WnYQLRC
	JpMt7slZDjytEToYZsrYFsLCgF16h8wEWL+brtiUN7zyBhXU8/mv9r4RsQpz+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712328933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxnpTUuyc8UWm+4m7aYHxuKWQGRvMPtGchvdt2jULjc=;
	b=NBZEQQWFTUpJNU9uCcuryqLTfR4gJFxqF8C0+cIOslF6YAafC35DvKZAj87Fw75kU6Nf0l
	HLj2VNDo4PoCS5Dw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfgang Walter <linux@stwm.de>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to
 "x86/mpparse: Register APIC address only once"
In-Reply-To: <2024040516-spill-uselessly-0a0e@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
 <899b7c1419a064a2b721b78eade06659@stwm.de> <87y19s82ya.ffs@tglx>
 <2024040516-spill-uselessly-0a0e@gregkh>
Date: Fri, 05 Apr 2024 16:55:33 +0200
Message-ID: <87r0fj97ve.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 13:34, Greg Kroah-Hartman wrote:
> On Fri, Apr 05, 2024 at 01:27:09PM +0200, Thomas Gleixner wrote:
>> On Fri, Apr 05 2024 at 12:35, Wolfgang Walter wrote:
>> > Am 2024-04-04 17:57, schrieb Greg Kroah-Hartman:
>> >> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
>> >> 
>> > It is not an issue with 6.9-rc1. 6.9-rc1 just boots fine.
>> 
>> Bah. That's my fault.
>> 
>> So before the topology evaluation rework landed in the 6.9 merge window
>> this eventual double registration was harmless and only happening for a
>> particular set of AMD machines. The topo rework restructured the whole
>> procedure and caused the new warnings to trigger.
>> 
>> So the Fixes tag I added to that commit was pointing at the wrong place
>> and this needs to be reverted from all pre 6.9 stable kernels.
>
> Sure, will be glad to, but what git is is "this"?  The original report
> is gone from my thread here, sorry.

The upstream commit with the bogus Fixes tag is:

    f2208aa12c27 ("x86/mpparse: Register APIC address only once")

