Return-Path: <stable+bounces-47793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA88D6347
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712C1C24022
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA8158DC4;
	Fri, 31 May 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PEDp8uNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZlGhLIf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A45158D69;
	Fri, 31 May 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162958; cv=none; b=fDHxZg0Y9cLjy490hENRU8Xl03oRKFvfC7Ib5FQOh2CUWXJa3krYdYXfH0EqXyuKUX4l9lo5g1dlpZ8vQO3Wai1K1RE0PdE4T0j9xOKn4U8XzUcYI1V8eBH17if6L7BRjLnXGjPpfCIH6u8/s/3jGOdhUYBd6pnrolc1v/nU7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162958; c=relaxed/simple;
	bh=eY2qkBo8TuMtICupkOTJ+jXO0M+B2a1HCHXG4Y9V598=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqikTMnkgyyq36YdKhPSrweYKiyCCpYLE63cI1aVnOUEM8H+RNL6VflxDhlvra1pP59PXFMuLkzR39zIEM+WOuey2jKdPK+eXg1NxuP7rLaZhR5AJYyAsgp1jN7Fusaw/KL6wk4raiZyYAS6uPNtXL4GoyVBdYwAY56hP5RuShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PEDp8uNJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZlGhLIf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717162949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vnvx/b3YBPJGdrGkvIGOzq//fKgTkTsLUSK9I8zckqM=;
	b=PEDp8uNJNYaj3NgyjQbG9GhoP2raHs3KNUeUNthy8WjQ6bJq3ogRxiu0V+vdKgIxt1E7Ab
	nj3LACMTyTj7AJ/LEZ1n0da4T5mqV6N0sRcDwxcHL5PJcjgWb5z5inQj7ouQ2nGljrN8s1
	VRbM5XRj8OGNsxWDKnrd2sW6rzMP0L2uLykiOsEOz0o/p1sl9+o4wXEmlEsCmNG52RiRKC
	Nhg7UDVl9yzW7vJQAMwqF3KD7ydfpSyftTmdKULog0RciygSa0x7UE64KFrpBo6NLrhPWZ
	0cvhkPfaSRApwNFpVePymtjetVLQinl0Ti1qG5qcjvYcXbR+GDcV34mAUPJxmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717162949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vnvx/b3YBPJGdrGkvIGOzq//fKgTkTsLUSK9I8zckqM=;
	b=hZlGhLIfpFoIcILmDCyged3NbGZSVUrewqV1qVXiggb+rPnVMLjeJqbb4XEGJmFGEDmtVC
	1QjuloI/vJYNzCCA==
To: Christian Heusel <christian@heusel.eu>
Cc: Peter Schneider <pschneider1968@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <b42363ac-31ef-4b1a-9164-67c0e0af3768@heusel.eu>
References: <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu> <87cyp28j0b.ffs@tglx>
 <875xuu8hx0.ffs@tglx> <b42363ac-31ef-4b1a-9164-67c0e0af3768@heusel.eu>
Date: Fri, 31 May 2024 15:42:26 +0200
Message-ID: <87sexy6qt9.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 31 2024 at 15:08, Christian Heusel wrote:
> On 24/05/31 11:11AM, Thomas Gleixner wrote:
>> On Fri, May 31 2024 at 10:48, Thomas Gleixner wrote:
>> 
>> It seems there are two different issues here. The dmesg you provided is
>> from a i7-1255U, which is a hybrid CPU. The i7-7700k has 4 cores (8
>> threads) and there is not necessarily the same root cause.
>
> It seems like I was also below my needed caffeine levels :p The person
> reporting (in the same thread) with the i7-7700k reports the problem
> fixed[1] as well, so this is in line with Peters observerations!

Cool!

> The other person with the i7-1255U in the meantime got back to me with
> the needed outputs:
>> - output of cpuid -r

> 0x0000000b: subleafs:
>   0: EAX=0x00000001, EBX=0x00000001, ECX=0x00000100, EDX=0x00000012
>   1: EAX=0x00000006, EBX=0x0000000c, ECX=0x00000201, EDX=0x00000012

> 0x0000001f: subleafs:
>   0: EAX=0x00000001, EBX=0x00000001, ECX=0x00000100, EDX=0x00000012
>   1: EAX=0x00000007, EBX=0x0000000c, ECX=0x00000201, EDX=0x00000012

So this is inconsistent already. Both leafs should describe the same
topology. See the differing EAX values (6/7) in subleaf 1, which are
exactly the values the kernel complains about :)

But that should not be an issue because the kernel preferres 0x1f over
0xb and will never evaluate both, but this is just from one randomly
picked CPU.

I wonder which variant of the cpuid tool that is. cpuid -r gives you
usually just the plain values and collects them for all CPUs.

I really need to have the values for all CPUs to see whether there are
differences at the relevant places. The above is probably from one of
the E-Cores.

Thanks,

        tglx

