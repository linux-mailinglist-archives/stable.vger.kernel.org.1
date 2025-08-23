Return-Path: <stable+bounces-172658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43710B32B58
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B807B8CA8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A71DE4DC;
	Sat, 23 Aug 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9ieONYA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbvuSH0L"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CE14B977;
	Sat, 23 Aug 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755970950; cv=none; b=n/GJV7nwEQZiAF6Bbl2pZWCyFYUkw352VdjtqvjR+MrrBRdQe+xTweSSDckoJW03P3xYPgKk5c2OPM1XSnYOP5unq9cSpfojR1MIMy87BQYNjxwC6z0JG2moo0gyVVqedrbLtiEFubiDPwAy6h1rYpZvzc8XVYQ1mMhUs9zjRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755970950; c=relaxed/simple;
	bh=ys3E9OHMdP5Us8PZ5LuM+YUcdr7+gk8Grt+IehxAW3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nfI8oJWyWuG24n59WIbknYJB361qEIeI1cIkyU6bdPXqzJt+fcPWNrd2NRIZNeXztngwWXMnADhCjKGiqAcAOPV3twLPrxlUZw4FCcYn1iD+GligO/D90LpTH8J1cfkBCJjY/B4W9zlFye68mPQz3diJ2WzC22TCxTWMBddbM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9ieONYA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbvuSH0L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755970946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/de6x57hRmjghuW5hRj9wc3ZOTI+jL2dLeu0jXGpYYw=;
	b=F9ieONYAcUJiOYjMB94+sz+tM86drtSx1mvJVtdt83RYRfz5mL1TuhScahgNxVgHpdDWaf
	A/b61UshtHooa2kN8B4sDgB+4Y+pA1270N8i8hwT+GsFyoNSzfqklxPG6tPi4rC8EZZ9lf
	B+UGbPAoSuuuODwx2yjojKUGJuYhkctchNGHvZr4/Z0uEoZfg+MkV/r2Rc8NSWGDF3LBog
	rvwsnnWPdC2xKA0atcgy97LeYW+F6u19uIF6si1TTYQgBdAndLRZRc6cVf0v45QG+1Wfo1
	wvsnT/48UG3q1HFrNx5/Dv0IhUyR0F+XmCacd3s1w6ywzy2P8ijvV1oam/BVNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755970946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/de6x57hRmjghuW5hRj9wc3ZOTI+jL2dLeu0jXGpYYw=;
	b=tbvuSH0LmGaBIHWvaaAJko0FrtGSXoISrr2V22oRgAmY2nUmt9uZZ4JSaNJwVil+53BkA3
	ut5Va+LEuqNTRdCQ==
To: Greg KH <gregkh@linuxfoundation.org>, Sumanth Gavini
 <sumanth.gavini@yahoo.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, jstultz@google.com,
 clingutla@codeaurora.org, mingo@kernel.org, sashal@kernel.org,
 boqun.feng@gmail.com, ryotkkr98@gmail.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, "J . Avila"
 <elavila@google.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
In-Reply-To: <2025082257-smirk-backside-6d93@gregkh>
References: <20250812161755.609600-1-sumanth.gavini.ref@yahoo.com>
 <20250812161755.609600-1-sumanth.gavini@yahoo.com>
 <2025082257-smirk-backside-6d93@gregkh>
Date: Sat, 23 Aug 2025 19:42:25 +0200
Message-ID: <87ldnavsse.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 22 2025 at 15:07, Greg KH wrote:
> On Tue, Aug 12, 2025 at 11:17:54AM -0500, Sumanth Gavini wrote:
>
> And I'm with John, this makes no sense as to why you need/want these.  I
> think that the syzbot report is bogus, sorry.  Please prove me wrong :)

It was validated by AI (Absense of Intelligence) that adding tracepoints
makes the problem go away! So why do you want extra proof?

Thanks,

        tglx


