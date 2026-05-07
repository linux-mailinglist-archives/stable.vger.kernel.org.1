Return-Path: <stable+bounces-244522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UISsLgpD/GlYNgAAu9opvQ
	(envelope-from <stable+bounces-244522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:45:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F84E43A8
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40E7C3006782
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4A371D11;
	Thu,  7 May 2026 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxraskCA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2X3yYjPV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41878371877;
	Thu,  7 May 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139907; cv=none; b=QRuytJjSBpcqD2o5yuVW9zRq/t9EaOpzWrCr4p7iyCSAyciPlu+I5o1ingzw1sh5IbJyPAW87laSrmw0V6lVjcsRJHYNhJ8HwQAjDQpn95iU2BtFxQ9JUowZmPJl6UGVk/0qIgKza52F3N1kALrWcSY9IbfpZgwWzsJoF25UsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139907; c=relaxed/simple;
	bh=rkS+YzYjiz1cYPhnoBVPlmvY3N/4cZL314TQCS/wiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTQiv7XgQXY9+QoKkd2zvmZQo70vnWaNOEeKkOTiFeD97fw9lHbUQkT7hZzNA+RzvgWHLPCuER7NnnaeDBIMQQH5/rc70yQnpH0LP4o9scY3+zp6Sxa48IKkBchF+QstR6QlpWBrfJkb8EhFN7N/bHJ6h7gnsqhpeWsBa0mPJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxraskCA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2X3yYjPV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 May 2026 09:45:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778139904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Zv8xPFu900O3h26bI67++ajYHZyEd1VjLaocjBZuY=;
	b=FxraskCA4rZS+yLzybKGmhlrEsbvZ1yk8YxUD8VR78v9JM3k6JfMOUkJjwnrQ3gnvF20rx
	y09UFLkDQIQRKCjhuBlG3eaQfC8JedVePDGpBOhp0kTul2o6DZm7wPuvM3wL6Q1/3fAATM
	DTqf9W33/ENByQsSS9WLaHF2WLapMAf4cjggFfISCVY21xnQf8WPjYlwiBgtrhaKrK02+9
	gy0Ira5CyFkh8gU51S2BJUtgcK1lTgaUIdFXcqTm8o+LoYM3AnyGUi6F+H5ghPGT5ZhdXh
	zU87ZA4oPObDQv3nqPax6PyQTEJ0OHS9lg62fxKLF9OEyDMWZpIqWiLUXMQBRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778139904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Zv8xPFu900O3h26bI67++ajYHZyEd1VjLaocjBZuY=;
	b=2X3yYjPVTiVXLp0DhX7ZEDvAHmY6CA/LyOcZF2Wn6ycTL+UBSdvPZS1YhWhcgesTh3RtoR
	rMa6fCrzTYbnmKAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org, clrkwllms@kernel.org,
	rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, chris.friesen@windriver.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
Message-ID: <20260507074502.cFMtH9BB@linutronix.de>
References: <cover.1778048987.git.ionut.nechita@windriver.com>
 <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
 <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>
 <20260506074758.8zEg1ZBh@linutronix.de>
 <713ba2ae-e322-4e56-b0b8-89766f7f65c1@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <713ba2ae-e322-4e56-b0b8-89766f7f65c1@acm.org>
X-Rspamd-Queue-Id: 2E9F84E43A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[windriver.com,kernel.dk,vger.kernel.org,kernel.org,goodmis.org,redhat.com,linux.dev,purestorage.com,lists.linux.dev,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-244522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 2026-05-06 11:43:32 [+0200], Bart Van Assche wrote:
> On 5/6/26 9:47 AM, Sebastian Andrzej Siewior wrote:
> > On 2026-05-06 09:14:33 [+0200], Bart Van Assche wrote:
> > > If the atomic_inc() in blk_mq_quiesce_queue_nowait() is protected by
> > > hctx->queue->queue_lock then the above code doesn't have to be modified.
> > 
> > But wouldn't the atomic_inc + barrier avoid the need to have the lock?
> > Isn't this a normal pattern? If the lock is kept, we could use
> > non-atomic ops here then. But this avoids having the lock.
> 
> I strongly prefer a spinlock + non-atomic variables rather than using an
> atomic variable and barriers because algorithms that use a spinlock are
> easier to verify.

Hmmm. If we keep the lock, then there is no need for the atomic and we
keep int counter. Then we are where we are right now with the lock
synchronizing everything.
Isn't this also improving the performance for the !RT case or is it
simply not that visible here?

> Thanks,
> 
> Bart.

Sebastian

