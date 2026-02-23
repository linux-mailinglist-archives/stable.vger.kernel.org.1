Return-Path: <stable+bounces-217694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SnmiBcn5m2l5+gMAu9opvQ
	(envelope-from <stable+bounces-217694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:55:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A1172667
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D6B30073DD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9463451B5;
	Mon, 23 Feb 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGyJOOzX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Es5Vrl0O"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704251F099C;
	Mon, 23 Feb 2026 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771829699; cv=none; b=IWGmvflkkMN8QnZRlNFMSIR2yhhwo1DoFhyjgREwa3NMmudq4dDZiQsRtn3JRScjNk7sX4y/Ku5dwf0L6+KX/oXjkRh0YcfeSDYY9dQoXElfaHlFGv9bsUzDZmbstoSzCCHDdCgOABI5WP8U2zeNn8DjgOzAQDIdIHPD0whYbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771829699; c=relaxed/simple;
	bh=Jf4+BMfK9yxpQ1qdJ73i7eagB2Ar/8aOmOSAUFBWKMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blSrcNV24dg6gk1B5UYi9U6y+sNuE4DyfnIbWZZHlsjyZ1XcFTm6Vloq62bvI4rtmmpHFemOYvku4aqz+5nMom1h3mUyZkcCqcHSVZP0s886JzBI2nDyQkEbR+ja7rgqwQCVVrS2bT8RuJsBIA8LarixyLJKzSfBVyNtZkAYMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGyJOOzX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Es5Vrl0O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 07:54:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771829689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ngJ9v3T6olOJUBQhV3Yq+s2wMHi6sn3NcFxNw2DzKM=;
	b=lGyJOOzXhvETVaL9oP0KCLzTQu9Gtb4N2A4PMaobhGd4qvMer0Cam3apR3l4zArnuntrKa
	Uzh4TfqO6JfCU7sxul9zTFgZ3rq8oS7S+c5r7joTQRBefZ1rUrwILS+hJW3Qe8S6/U9HJb
	BMrwXOHv9iXl6Cdm4+bU2wR3ncZiYjSNDdHePxFfpzn1n7bVTEwsC2LvLTABCtp9iXecDJ
	/TavG+A/ZxN5XKI9s426XmiUZvgHX/OZaKe4nknApa0CFqkz6ZpSjQ21fW+Ac5cZskMjwt
	9fdfVvzNs++dPZHOXHEaBI1xq/GvPIyDCloFdPogj1WrTu3iVpkTcWo+i52XQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771829689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ngJ9v3T6olOJUBQhV3Yq+s2wMHi6sn3NcFxNw2DzKM=;
	b=Es5Vrl0O0b8EDpuPU58ja0xBLBWDkJ6ke/sS9mBgyQjl3JdeYUiBJRu5etJ5hQOewwzwOT
	7r4cKYt+8WXuS0AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "printk, vt, fbcon: Remove console_conditional_schedule()"
 has been added to the 6.12-stable tree
Message-ID: <20260223065448.xshEaalA@linutronix.de>
References: <20260221163924.4117536-1-sashal@kernel.org>
 <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217694-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 787A1172667
X-Rspamd-Action: no action

On 2026-02-21 18:20:15 [+0100], Helge Deller wrote:
> Hi Sasha,
Hi Helge,

> On 2/21/26 17:39, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      printk, vt, fbcon: Remove console_conditional_schedule()
> > 
> > to the 6.12-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       printk-vt-fbcon-remove-console_conditional_schedule.patch
> > and it can be found in the queue-6.12 subdirectory.
> I suggest not to backport this patch at all.
> We don't know yet, if it may have side effects. Even more in older kernels.
> 
> So, please drop it.
> Same for the other fbdev patches starting with "fbcon:".
> Those are just cleanups.

I would need it for PREEMPT_RT in v6.6 and v6.12 to get rid of the
mentioned problem. Any suggestions?
One idea would be to make the removed functions a NOP in the PREEMPT_RT
case if you prefer not to backport it at all.

> Helge

Sebastian

