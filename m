Return-Path: <stable+bounces-226637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKQYHNKPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBF02AFB9F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7EBF30FB7FC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862A3F54DC;
	Tue, 17 Mar 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="B/8N2RpW"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB843E122D;
	Tue, 17 Mar 2026 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767578; cv=pass; b=QOUSrAzi1Tai91lvvN1ji79dIn57ts0ABt7VfaqfhuLqMBmm0osEyyFKCrNNULSs9MJQeVPteBJE2l6R6A6IYMSKSBC9m09n6qpaMg9kP+6H96oQ2GpFAjheEQJK0KnpRyTvYDMvfsaQde51b7UZnWkC/x8GO42Nf1H4fb13y5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767578; c=relaxed/simple;
	bh=aSbn3w83erJyY1Kuzr4MqCMoZ7gYSa9v60/gwYg4JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/VlfBYmq62NUIbihprtf3i3c2q5fTvVxXaKEsp+mUeyrhxF5l5Sd3u5Gq+KpYPRSTHSyTetGXzi1BaNdTwjLEfkdPqZBZJxqvv5eA3cjS1J6nNImYogSnuL0K+qbYvOO1anHCHwfBvQBLLh5k0Bfa4z4+464O09yyvBDGZU72U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=B/8N2RpW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1773767546; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FF4BqwPGdW5DFe369nz1f+ciEhnx0Eef5MXt6z8vvYTdWXb25VVfgS6SGfLnUVkcbdFz15GAGY+mx+BSwZ3UxvqgIKg++Wb/4NurTCdqmcXTljlzpeFwhjkEB4QyENs5Kq7Yn4UnpN4eiCBLRl/XuVlCl5aLK0EUaLgb50Ag51U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773767546; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9irpAcGw+NdAnNy24mMqOQpUWn4QESBkT1r91NxXKMo=; 
	b=amLty4pQ/X51NE4isTlZ7dWJ9FnHJsLdpIdYAHPhLUbyl/XRbGBzqyAXrilvM1II91ngT/Yj092GibxUDRgjmqDvnw1HctpoyYkCOc0YffxuhWwowS1nxX/sQpiAO8jabvu8o0ghAZzn9bNoaa425Ox34eYiyAa+Uaa1BY7sV+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773767546;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9irpAcGw+NdAnNy24mMqOQpUWn4QESBkT1r91NxXKMo=;
	b=B/8N2RpWBEs5ICpzvauCP5n6fVsRb/Q1aWJaMoVKCQ5oaNvh5pnyh9KpK97947WF
	yHIpR+TVukNKuU5XwiMVD55KBruy7ZGhPTPwR2K+8vTwpAE3uEruzc3C6z6fOGVus32
	7wkurcPAj+SYB6XEI1zvBJ9vRe3elXV7bjSWcBic=
Received: by mx.zohomail.com with SMTPS id 1773767543213553.1088646451747;
	Tue, 17 Mar 2026 10:12:23 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 84441180085; Tue, 17 Mar 2026 18:12:19 +0100 (CET)
Date: Tue, 17 Mar 2026 18:12:19 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Alexey Charkov <alchark@flipper.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yongbo Zhang <giraffesnn123@gmail.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Switch to threaded IRQ handler
Message-ID: <abmFHsVObD2GDquV@venus>
References: <20260311-fusb302-irq-v1-1-7e7105706629@flipper.net>
 <abKDG8wHJ-19c3AD@kuha>
 <63dfd90a-d54d-4d87-8c62-61a3c24d76fd@kernel.org>
 <20260312120418.99U0NPWL@linutronix.de>
 <22c94dd0-7bef-4682-acdb-905dd81f8083@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nm4kkjqdvu4lxn2s"
Content-Disposition: inline
In-Reply-To: <22c94dd0-7bef-4682-acdb-905dd81f8083@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.758.55
X-ZohoMailClient: External
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,linux.intel.com,flipper.net,linuxfoundation.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-226637-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EBF02AFB9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--nm4kkjqdvu4lxn2s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: fusb302: Switch to threaded IRQ handler
MIME-Version: 1.0

Hi,

On Fri, Mar 13, 2026 at 05:21:33PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 12-Mar-26 13:04, Sebastian Andrzej Siewior wrote:
> > On 2026-03-12 11:49:30 [+0100], Hans de Goede wrote:
> >> Using a threaded interrupt handler should be ok, yes. This should
> >> also fix the issue this patch tries to fix:
> >>
> >> https://lore.kernel.org/linux-usb/20260103083232.9510-4-linux.amoon@gm=
ail.com
> >=20
> > This issue went away with commit a7fb84ea70aae ("usb: typec: fusb302:
> > Remove IRQF_ONESHOT").
> >=20
> >> Normally an i2c device like this would use a threaded interrupt handle=
r to
> >> do all the work since I2C transfers can sleep combined with disabling =
the IRQ
> >> on suspend to avoid the interrupt handler running while the parent i2c=
-adapter
> >> may be suspended.
> >>
> >> The problem with the fusb302 is that it can be a wakeup source so we c=
annot
> >> disable the IRQ. I worked around this in commit 207338ec5a2 ("usb: typ=
ec: fusb302:
> >> Improve suspend/resume handling") by moving the actual work to a workq=
ueue
> >> and have a hard (non threaded) interrupt handler which disables the IR=
Q and
> >> queues the work, with the work re-enabling the IRQ when done + special
> >> handling for the suspended case. Basically our own manual oneshot.
> >>
> >> If we move the IRQ disabling to a threaded handler, which appears to be
> >> necessary for some IRQ controllers (arguably a IRQ controller driver i=
ssue,
> >> but this seems to be a re-occuring issue), then I wonder if we need
> >> the ONESHOT flag again to avoid a level type IRQ re-triggering before
> >> the threaded handler gets a chance to disable it (with the workqueue
> >> item eventually re-enabling it).
> >>
> >> I think we need to re-add the ONESHOT flag, but maybe that is the defa=
ult
> >> with a primary NULL handler ?
> >>
> >> Sebastian Siewior I think you now the IRQ subsystem better then me,
> >> any advice / remarks ?
>=20
> Sebastian, Thank you for your input.
>=20
> > You could do
> > 	request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> > 			     IRQF_ONESHOT | IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
>=20
> Ok, that is good to know.
>=20
> > which would ensure that the handler runs as a thread and the interrupt
> > line is disable while it is active.
>=20
> That is what we want, thank you.
>=20
> > Then you could let fusb302_irq_intn() do what fusb302_irq_work() does.
> > Since it is a thread, mutex_lock() works here.
>=20
> Right, but the resume handler needs to also schedule the work when the
> IRQ is initially ignored if the IRQ triggers before the i2c_client's
> resume-handler is called to ensure that the parent i2c-adapter is
> ready when the IRQ handling code does i2c accesses.
>=20
> > Last step would be to replace fusb302_chip::irq_suspended with
> > disable_irq() in fusb302_pm_suspend() and enable_irq() in
> > fusb302_pm_resume().
>=20
> That unfortunately is not possible because the fusb302 maybe
> a wake-up source so it cannot be disabled unconditionally
> and without the disable_irq() / enable_irq() pair the IRQ
> may trigger before the parent i2c-adapter is resumed.
>=20
> This is why the IRQ handling in this driver is as convoluted
> as it is in the first place. With the IRQ handler setting
> an irq_while_suspended flag if the IRQ runs before the
> i2c_client resume and then with resume checking that flag
> + queuing the work do to the actual IRQ handling once the
> parent i2c-adapter is ready (if we hit this race).

After re-checking everything, I don't see anything special about the
fusb302 and wondering a bit why this is not an issue with other
devices like e.g. i2c-hid (which can also be wakeup sources, see
e.g. HID devices on your Qualcomm T14s). Does that have the same
issue and we are just not running into the race condition?

In that case it might be sensible to move the logic for "interrupt
function should only run after the device has been PM resumed" into
the IRQ core behind a flag and simplify the drivers?

> So as far as I can see the current state of fusb302 code
> is good as is.

I think with the threaded irq handler, the code could be simplified
to no longer use a worker thread. Instead the thread and the irq
handler can be merged. It seems sensible to do this in a separate
patch, though.

> [...]

Greetings,

-- Sebastian

--nm4kkjqdvu4lxn2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmm5i2wACgkQ2O7X88g7
+pquDQ//UPbEjEwUsxuke6UTE20vrdgvMrbj9idEL6tytRE66rYsrEmUnERMijss
nrxaVa8d6b4OwVBcFMuV099riXFEY+VK8fycKeCGkBlvReVI457GqsN/i+2R/Rti
WwS30sW30xjVkO0we0hSYSdCC53IXfB1C43PCBh4NNFCZdSZKFr/sml5Bp/+4mPp
9bpeP4CvWsg7ExkNOFI+RXozW5H/gue3TcNMQ171gqHzszBtNjztS55kScgRvTb5
3YPLyy99B0CRUrVrI3/S+Pd++hQRHZs1VTkAh5LROfkjsvoW1/erLqtsNtwJD3/C
9jOH4r7NxIpxBQOUIL2LiIxvR+Ycootojz+BZ7FAOAzI9T57VYriD3/5YnPBLKKp
8EpbhQ018mGINJoG+3MzQDD3uK6cPr9JtN9+ZhhGbVDKdpMBZZITxgPA8i0zvYuv
0Drg2wkjk7lzLscIm7RxN6HpiwIsDTo3w9M19oEa0BWp9LWymCRJjdvhdQzD+9wW
3FaYEY5/mWHsXcIqqNysaRNtfGtHjHwkYC1ZUf08qy720mzgvhqeVljY708AGW5+
YqRsMdSCOLUmJY+hxSpJlOMJyLIN7FvmQBab/AbJq/0DPFbdLBKYzyAxwxbN5hkD
0laqrnjwXG+UjMAbtK5VOJT14iVYJ9yCF7ImFBI9nvjYVSzItWg=
=KliU
-----END PGP SIGNATURE-----

--nm4kkjqdvu4lxn2s--

