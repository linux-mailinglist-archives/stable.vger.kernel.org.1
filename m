Return-Path: <stable+bounces-211858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdUH6HseGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9997F41
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 528D230CBBF1
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B135EDAD;
	Tue, 27 Jan 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufdKbr4O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abXFZ/MN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F335CBC6;
	Tue, 27 Jan 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530752; cv=none; b=u0nhRXDWaRT6L6ijiefBw8zn64FnhWYczzUEK+fxBs53zHfdAEwn2EXTirhudcQSyckZ3ZfO4v/KYKWZelHY7vtgn0GQKLOfrdRgVkG93cxFM+Ka3skPFMfuFPQ/kbVak7n5frlvouT70NUbL/56lUVrMzv60E8FVAq5GB9IyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530752; c=relaxed/simple;
	bh=Y1R+TJNguLWi69GtS7mRj+xsWoAN4CJgoKP+3u0CB4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBnnI8i1lR0kM7E/JcVJHkgNPL6ldmhHxmqDxu+9gnxb042GbllNb3jhO0D8ZOYlcGOj7YK+xraSGD2WKMTBpX8twdw5fW3FEVAmV5kjyTcp8PO5knRp3EmNl1s9sT2oEzCr53AlK/CB2R64rzOYcTXqX23FpBgnrW2KkKzpLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufdKbr4O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abXFZ/MN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769530749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTWFCtf+mdQvk1B3TlRGJzO6FYqSCXfxkBPbyjRRz0=;
	b=ufdKbr4Oqx/uYlPl3IAPk0gx8FgxGgkBFVhOgua7A07i2Cnam5feqLGvLEEGFKL/GO7Y+k
	2TmQ2TG8ndfoSl2SudkSQuvJi6OOqcFqkpoQ2MKaQsmK/hR3KSY5zyP9bU1BWrQTP/oGS1
	810cwHj+ehIG2WYYWcsqq44bsI/oLI43mHZ+6nnYjWI3XlKF+jwQoYyYyYLad1xrmqzsq3
	ALlpTRJQGhyt6rEen6aOT9QqRKJdyQFOY+IQnzGMTS04GQ0AMtKQpzmM3/iViv2qhl7iT2
	Ynw+4c2dpmWj+iC+XXTHd0Oln3iiPbVOueSqOF8ieshjPnveiDAr7RXdl7B7AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769530749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTWFCtf+mdQvk1B3TlRGJzO6FYqSCXfxkBPbyjRRz0=;
	b=abXFZ/MNcUARd7jEp9+PwBfc2hc3SIU3Xezk1TDbGygK45me6LMH7BdLw8fpraAVFrd7o8
	Oa2hT11/vC1kSTAw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?Q?J?=
 =?utf-8?Q?=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial <linux-serial@vger.kernel.org>,
 qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae
 <adriana@arista.com>, Markus Mayer <markus.mayer@linaro.org>, Tim Kryger
 <tim.kryger@linaro.org>, Matt Porter <matt.porter@linaro.org>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Jamie Iles
 <jamie@jamieiles.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, "Bandal, Shankar" <shankar.bandal@intel.com>,
 "Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
In-Reply-To: <aXjHZQnIFjfPabdU@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
 <aXP5YMNix8EfbJeF@smile.fi.intel.com>
 <fc09f6fd-013f-25fd-484c-cac59b0a60b6@linux.intel.com>
 <aXjHZQnIFjfPabdU@smile.fi.intel.com>
Date: Tue, 27 Jan 2026 17:25:08 +0106
Message-ID: <871pjb6nb7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211858-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0B9997F41
X-Rspamd-Action: no action

On 2026-01-27, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > > +	if (d->in_idle) {
>> > 
>> > > +		/*
>> > > +		 * FIXME: this deadlocks if port->lock is already held
>> > > +		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
>> > > +		 */
>> > 
>> > Hmm... That FIXME should gone since we have non-blocking consoles, no?
>> 
>> No, lockdep still gets angry if printing is used while holding port's 
>> lock.
>
> Hmm... Let's ask PRINTK people about this. John, do we still have a gap
> with nbcon? Or did I misunderstand the scope of its use?

The 8250 has not yet been converted to a nbcon. I am still working on
it. Unfortunately I got side-tracked first fixing the broken 8250
console hardware-flow-control support. :-/

So the comment is correct. Once the driver converts to nbcon, the
dev_err() is fine.

Note that if the message is important, you could use a printk_deferred()
here with a FIXME to say to convert it to dev_err() once the 8250
supports nbcon.

John Ogness

