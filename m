Return-Path: <stable+bounces-272202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 94mbIp+XS2qfWAEAu9opvQ
	(envelope-from <stable+bounces-272202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140F710215
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:55:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oYxLA/wM";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272202-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272202-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BB443013456
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6A4229CB;
	Mon,  6 Jul 2026 11:55:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB142254A;
	Mon,  6 Jul 2026 11:55:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338907; cv=none; b=LYtnX+doBuBKio/vNzFi0vN9iSc4kWWSlnDz3muuzk+sjS3rsfPleK4I8m7OGkHKticvG7mvyiwY9hVQFrq/QAmVLJj/FRFNBMXUk2ZbQDyc1g2FcLvducPyQE24CMLi5oum9wurJmfsTwQtCtDSNxIS/4rdGrNy0ngamVhuR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338907; c=relaxed/simple;
	bh=oK3OwA3GNcUpAS22YW+4T2d+4N8SnkHpxdwEEA7slK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D72AzNnF6yH8jYcYQHmczjukwy8Smn0fm07g2Lwyw4ZBkuFWiR1IctRDer5jr3rpKsXMikbkNLxufaOTo5tANKEZ6plIGRW7z7wz0sYAa9V+hsuCgSEQq4uBhFnXZHxVR6nBD/Uz9/6LKVGJ7kZQDMrBTkodNY7TK2YrzifqoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYxLA/wM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256231F000E9;
	Mon,  6 Jul 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783338906;
	bh=1zeff5+2id63hzvkwDo/KcQrlGts9itb0RT0AB+L234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oYxLA/wM9K42qyMQr8xU02DGNlL/46nQXwpob5/eeu3wIQSjmv+ZWfuLoa0ZjmD9K
	 jzUnZJXyALeZlVjPQShmH7qqKesk94LSu6XqNX9FuvpDjsOsCODnP/aIEcWJZ3o6S3
	 tPwmGQ5V7m0rjqBUvjm1xYbd7We2FHX7PKnkjbZgAi0ySWM/rdn6fFKP9mtdoxezID
	 YZWSeHU1DBEaHSs5uVDl0YcSHwNTbBYR3q7igvziwncv3dizI15UmoSrRMIfKywDrd
	 uHArmD+DrXUhrRD4Ch8k0Jhgpo1ATB0pJ9lpNdKExKYn/jnWQpiYepeYk1CmySSDLc
	 UsXTCp/BwVPHg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wghui-00000001qaI-020f;
	Mon, 06 Jul 2026 13:55:04 +0200
Date: Mon, 6 Jul 2026 13:55:04 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/usb/serial: usb_console_setup: unmatched
 usb_serial_put on error paths
Message-ID: <akuXmD-7nzKVgBT0@hovoldconsulting.com>
References: <20260627033410.58709-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627033410.58709-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1140F710215

On Sat, Jun 27, 2026 at 11:34:10AM +0800, WenTao Liang wrote:
> In usb_console_setup(), serial is obtained via a simple pointer
> assignment (port->serial) which does not increment the reference count.
> However, all error paths that reach error_get_interface call
> usb_serial_put(serial), decrementing a reference that was never acquired
> within the function. This causes a refcount underflow on the serial
> device.
> 
> Remove the unmatched usb_serial_put(serial) call from the error path.

No, there's a reference taken in usb_serial_port_get_by_minor() so this
patch would introduce an imbalance.

How are you coming up with these patches? Are you using an LLM? Why is
that not documented as required?

And why haven't you sent the follow-up mail telling maintainers to
ignore your patches as Greg asked you to do? [1]

Also I sent you review comments on other USB patches a month ago which
you still haven't replied to.

If you keep this up, you and your "lab" (why are you all using the same
mail address?) might end up banned as you've already been warned.

> Cc: stable@vger.kernel.org
> Fixes: 61dfa797c731 ("USB: serial: console: move mutex_unlock() before usb_serial_put()")

What on earth does this commit have to do with anything?

> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Johan


[1] https://lore.kernel.org/all/2026062704-detail-machine-270f@gregkh/

