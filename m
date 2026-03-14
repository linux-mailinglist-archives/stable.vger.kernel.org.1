Return-Path: <stable+bounces-225420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id axF8DgVVtWnAzQAAu9opvQ
	(envelope-from <stable+bounces-225420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F628D23C
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFC023011D46
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC11AA1F4;
	Sat, 14 Mar 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KFyCjgek"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97891DD9AC;
	Sat, 14 Mar 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773491452; cv=none; b=uNJKtXihM/HqPvIz8ozw3pafH8eDEJV/HnSH4J2O9oQLf2YuKCC4a0wd8boEJOT8aLJM8FBlysRsWBsPcCTFZ1NHeW8tE/x8tvftfjnHdFt2olket5BTYxvFZo31g1iFTQX4NXT2WdLxVbp/8ZUmBbYjZFDXGTeLI9hXIDih1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773491452; c=relaxed/simple;
	bh=9ZK2vTkCbsS5uxnoWel8n1PDRrnyWVIPtUMBJGP84mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2x05Qyxryihakw8ucwqvxFt29z6/eWyGalREIr+6s/r5YLbyq8nDuQFXmrMKxd1A2xsULBQbWnPUi+ZWk0ZDdjVTW8JT5E1Pi8I0VaAWopWerAx5Ykaane5P1lZnhVNf+/e5eC9cKEjOT04G9gQ8mp3VAa7J0T4w9VkuyrHWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=KFyCjgek; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6506F14C2D6;
	Sat, 14 Mar 2026 13:30:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1773491447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcoWzFo2iytvBU59qSwVkLxsYp37sXMszYQYBam9i0c=;
	b=KFyCjgekH3VZNvEK1Lo/dG2gqjqtWALYEA5viHfhjhlY0lNXYsL6ISTAHhVrsVEdRBtqTp
	TytgEBqJKgzVHqP8BBbau0iToaUc7IRtTRTrzvc3FYJhS0O99JjbJ5eqX0ylR3Vdkq7qEb
	7LC/3Q+QayzQ0e/vMUmykycZ+26iooe2YfmM2CfR3RBEnwYU2/cwojnqQQiRNG8JTG/u2e
	5TftV0qfWen521PoAGRLTgP/IkxocKBTMZNmualiHNxVV8RxNrrcsVtpU40UuFpXjvEi7A
	/f3TmLVOaXKeKgnvzZaVvBDZi1jV1cVgLnQ61L7KftpPMIw47KEE80HAkgqv5w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4374c7c6;
	Sat, 14 Mar 2026 12:30:42 +0000 (UTC)
Date: Sat, 14 Mar 2026 21:30:27 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abVU46kfH0K5I6OY@codewreck.org>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
 <abT5tabfYV9a9RF_@codewreck.org>
 <CAP_j_b9i2n+ZUriWceZJgAKz_MeGMFkRiOz7yCYE4as4T6auVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP_j_b9i2n+ZUriWceZJgAKz_MeGMFkRiOz7yCYE4as4T6auVQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	TAGGED_FROM(0.00)[bounces-225420-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 273F628D23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hyungjung Joo wrote on Sat, Mar 14, 2026 at 04:24:19PM +0900:
> Thanks for the careful review.
> 
> > Just to make sure the problem is the usb9pfs struct being freed, not the
> > p9_client itself which is still alive after the usb device is gone
> > (until umount)?
> 
> The issue I am addressing is the stale use of the usb9pfs->client
> association after the transport has been closed. I am not relying on
> early free of struct f_usb9pfs for this bug.
> 
> The lifetime mismatch here is that struct f_usb9pfs belongs to the
> gadget function and can be reused across mount sessions, while
> struct p9_client is per-mount. On the close path, p9_usbg_close() did
> not detach usb9pfs->client, so late TX/RX completions could still
> follow that pointer after close, including into a later remount that
> rebinds it.

Ah, you did write p9_usbg_close() in the commit message and I skipped
over it too fast...

I also misread your locking, I thought you were just getting a client
pointer under lock, but you're also using it only within the lock (so
there is no benefit from using a local variable as far as locking goes,
but releasing the lock early would be invalid as the client itself is
freed immediately after close...)

From a performance point of view I think making close() stop the ep and
wait until any in flight calls would be better than taking the lock all
the time, but I'm not sure how visible that'd actually be on real
workloads... close() can take as long as you want, it's perfectly fine
to sleep there until the usb side has finished flushing if you want.
I'm curious what approach Michael picked?


> > I'm surprised free_func isn't called after unbind, which should stop the
> > queues (through disable_usb9pfs)?
> > or are the ep being disabled not enough to ensure the callbacks are not
> > in use? (e.g. disabling prevents further calls, but doesn't wait for
> > currently running/queued requests?)
> 
> My understanding is that the unbind/free_func path is different from the
> close path at issue here. This patch is not trying to change or rely on
> gadget teardown ordering; it addresses the close-side race where
> usb9pfs->client remained attached and the completion paths still
> dereferenced it.

Yes, transport close corresponds to a umount call, and is unrelated to
usb lifetime; I was thinking of the other way around (usb device
disappearing while the mount is still alive)

> That is why the patch:
> - clears usb9pfs->client under usb9pfs->lock on close,
> - detaches any pending TX request from in_req->context, and
> - makes TX/RX completions bail out once the transport has been detached.
> 
> So the intent is to prevent late completions from using a stale or
> rebound client association after close, rather than to claim an early
> free of the gadget object itself.

Thank you for the details (and the patch!); I'll have a deeper look
after hearing back from Michael

-- 
Dominique Martinet | Asmadeus

