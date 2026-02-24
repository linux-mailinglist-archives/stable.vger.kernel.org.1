Return-Path: <stable+bounces-217931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBV7OgPbnWmuSQQAu9opvQ
	(envelope-from <stable+bounces-217931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 18:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DB18A4E5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16A5F305454B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C4D3A9611;
	Tue, 24 Feb 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Jzs25VX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOQBS7u/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D73A7F57;
	Tue, 24 Feb 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952166; cv=none; b=JnzUPSCltpF0jZYu30tYB+KnXyYGqXDrAPl4Pq3A2zQdDmPDhC05+d1CUa6++ppb3cc3e6GEvbViJz8Yap6prde6kiLu/8bRdBh+V5Ux7lUEFzFc+8bMtZqRcc0UrP8fV88XJyJbAGrB+j396rbDkom/428wdIOt4sXn7nI9s98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952166; c=relaxed/simple;
	bh=YnKc/WluycibeLq6Y15TT/1JA6ENKA+AQby6cau1V9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmLO2Vsc119PgPIO52qUoC1Q6RrvcFa5BxSNq8GzbqTVxOmRRLgznh+jMLfLJu+aMg0/6KQamGf/Ve8Gqy5dl6LUaAiYuNCFtfaFzasuJOFpp/jXzB69YlfDBRjXEYwgqHywu0qLLkGpm/afvnU/6OdrDZIL/TTo98EnyXeccTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Jzs25VX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WOQBS7u/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 17:56:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771952163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnKc/WluycibeLq6Y15TT/1JA6ENKA+AQby6cau1V9A=;
	b=4Jzs25VXu1kEN8UxB8Z7BmYLYkq3DtcWsqGrU1/kFBsnhRDjGjTSLZbxkk6RLjQbw1tG+E
	XTg++P4bjQzhrk98q4/pcnOOKSctylSCC2gGAaOYRMm4VlVh9s334VJe5Ut3VDysEizpc4
	4ZUzTHHwZ54KOrB6Sj8I+CHB+2ZBl0kvAQdl0pnR935oKDcjnJnrO2KXyRpLmfqGU+RDON
	exjGwpC56+9p3cGOEeayYwsAA86CMtn6WeILtTNQScCQ8yUgnBEaO1jSDSJwIW7rvpqwyC
	zN0DHRy/4XpPHZyqOKeCVDcVlDTMthh+dgbd6SEL3C5NQ2tnlBoyUMnsV/SdxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771952163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YnKc/WluycibeLq6Y15TT/1JA6ENKA+AQby6cau1V9A=;
	b=WOQBS7u/7Va+ws965qmqWt1cfJAGxi71SxSsEW+dWIt5c5njp9F/oO3xYh8c5IwIwN1n7q
	4xn8kvravf/WUgCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "printk, vt, fbcon: Remove console_conditional_schedule()"
 has been added to the 6.12-stable tree
Message-ID: <20260224165601.2GtTLfmh@linutronix.de>
References: <20260221163924.4117536-1-sashal@kernel.org>
 <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
 <20260223065448.xshEaalA@linutronix.de>
 <ba3c30bd-5fe3-4774-b7ad-5c8335893fa7@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba3c30bd-5fe3-4774-b7ad-5c8335893fa7@gmx.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217931-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 078DB18A4E5
X-Rspamd-Action: no action

On 2026-02-23 10:01:23 [+0100], Helge Deller wrote:
> Hello Sebastian,
Hi Helge,

> Just to be sure: I assume you want this patch backported:
> 8e9bf8b9e8c0 ("printk, vt, fbcon: Remove console_conditional_schedule()")
> Not the other ones starting with "fbcon". Right?
> So, we talk about one patch only.

Correct, only this one.

> > One idea would be to make the removed functions a NOP in the PREEMPT_RT
> > case if you prefer not to backport it at all.
> I'm not generally against backporting the patch above.
> I'm only hesitant, because can we really be sure it will not produce
> any lockups in the older kernel either?

Not without trying. There is this scheduling point since v4.5-rc1 and
this should go to v6.12+ and based on this I don't see any problem with
it. Older kernel will be v6.12, v6.18 and v6.19.

> If you think it's safe, I too prefer to backport it as is.

Okay. Then a backport as is it is :)

> Helge

Sebastian

