Return-Path: <stable+bounces-235448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAZvIBHT12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:25:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B03CDA71
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 459DC3029A45
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96F3B19C1;
	Thu,  9 Apr 2026 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GiAI/bmW"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F426A1AC;
	Thu,  9 Apr 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751704; cv=none; b=GuubplhRVYhlYdppALU7+hNDleI9EapkJikbNCwx9ON/A56+Gv7d70mdKwTW76wUKTdaJndPB9Wgd9ZlrY1OMU2i/jubzIhaSsxnfpndxLKqpzY3Q37mO/G7tq0WxT6GP3HR6PzQWLtzpMeZFkGS8tNF5Z2ZwvJPU1WTHxf54LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751704; c=relaxed/simple;
	bh=VtaPdMssQz7ZG/5BH42Uga/5xviYf129A7lLHrGq/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn7D7qadAZ2Ij8FdNKHR7kxsRpFAy4sQfhnDPxLUHvkU0O1mpsjoYiybiPOFIAlTdfWJDq0cb+yagnkA4hYY2fHDlxm4TqHfxkmDQLbQhbmaOlbFDiiVCtAbBcwcEO5T4MlRUTzf+Wimt848vc16DF0W7Ryr1+0q9ASgBOdq4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GiAI/bmW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775751699;
	bh=VtaPdMssQz7ZG/5BH42Uga/5xviYf129A7lLHrGq/Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiAI/bmWkjNqTPBTjEw9ms8RgokP4JmddW0+9ABMnJ0SpjKw8lJYLx1DXvV+AZsRN
	 xuihevs4jJh3FyAn2ZbolhsfUOc1bisRYIOF0s6W8iWxJOQ3ht5fGWdMPXSoHmVDJw
	 tgWbGevQZDjw1to6IGBTo/9T3I8JorwkmJGyai/s=
Date: Thu, 9 Apr 2026 18:21:38 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>, 
	"mail@carsten-spiess.de" <mail@carsten-spiess.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH v3 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Message-ID: <82af43d8-5d3a-4b26-8e7e-dcbd5075f66b@t-8ch.de>
References: <20260408163029.353777-1-sanman.pradhan@hpe.com>
 <20260408163029.353777-4-sanman.pradhan@hpe.com>
 <fa22e0b7-f962-409d-8738-e06df1fb4b92@t-8ch.de>
 <20260409155045.402293-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409155045.402293-1-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,roeck-us.net,quantatw.com,carsten-spiess.de,gmail.com,juniper.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,t-8ch.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E48B03CDA71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-09 15:50:54+0000, Pradhan, Sanman wrote:
> On 2026-04-08 19:30+0000, Thomas Weißschuh wrote:

(...)

> > > 1. Use-after-free: When hwmon sysfs attributes are read concurrently
> > >    with USB disconnect, powerz_read() obtains a pointer to the
> > >    private data via usb_get_intfdata(), then powerz_disconnect() runs
> > >    and frees the URB while powerz_read_data() may still reference it.
> > 
> > powerz_read_data() is executed with the mutex held. powerz_disconnect()
> > will also take that mutex, so I don't see that race.
> 
> You are right, the mutex serializes concurrent access, so that
> description was misleading.
> 
> The actual issue is that after powerz_disconnect() frees the URB and
> releases the mutex, a subsequent powerz_read() can acquire the mutex
> and call powerz_read_data(), which would then dereference the freed
> URB pointer. Moving usb_set_intfdata() before registration and adding
> priv->urb = NULL with the corresponding NULL check is sufficient to
> prevent that. I will reword the commit message accordingly.

Agreed, that makes sense.

(...)

> > > 2. Signal handling: wait_for_completion_interruptible_timeout()
> > >    returns -ERESTARTSYS on signal, 0 on timeout, or positive on
> > >    completion. The original code tests !ret, which only catches
> > >    timeout. On signal delivery (-ERESTARTSYS), !ret is false so the
> > >    function skips usb_kill_urb() and falls through, accessing
> > >    potentially stale URB data. Capture the return value and handle
> > >    both the signal (negative) and timeout (zero) cases explicitly.
> > 
> > What impact does the signal delivery have on URB validity?
> 
> My understanding is that on signal the URB may still be in flight: it
> was submitted successfully, but the wait was interrupted before
> completion was signaled.

I misunderstood the "stale URB data". This is *not* a use-after-free
but read from the buffer that has not yet been filled by the device.

> In the original code, a negative return does not enter the timeout
> path, so usb_kill_urb() is skipped and the code falls through to read
> actual_length and transfer_buffer. It can also return with the URB
> still pending. A subsequent powerz_read() then reinitializes the
> completion and reuses transfer_buffer while the previous URB may still
> reference it.
> 
> The URB may also complete later and signal the completion, which can
> interfere with a subsequent read that reinitializes the same
> completion structure.
> 
> Calling usb_kill_urb() in the signal case ensures the in-flight URB is
> cancelled and its completion handler has finished before returning.

Ack.

Maybe the description can be reworded to be a bit clearer.

"""
wait_for_completion_interruptible_timeout() returns -ERESTARTYSYS when
interrupted. This needs to abort the URB and return an error. No data
has been received from the device so any reads from the transfer buffer
are invalid.
"""

(...)


Thomas

