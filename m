Return-Path: <stable+bounces-211838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF5eML7PeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:46:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBB95F4A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1B93302D92D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AB363C4F;
	Tue, 27 Jan 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ2CN8Cr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE235C188;
	Tue, 27 Jan 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524841; cv=none; b=jG0UABmSowuLGyWMwJH5cFjEC3rzpH9P/QDxLlWxuF8y/6VEoZV3zhLN8XZ8yWql6gUC8Dp3ru4sEvMo4cjSkdZMbCrop3+J2ZXug6BfaEwDGo8QJm62onT5kjs7qk5jMnf60HWM/+06aQjc1xSqY6+93kRfSRnz0Fa3sBZckUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524841; c=relaxed/simple;
	bh=mXRBNsG1KvltKGLWMjB9OhvYSZUWg1JfD4N+xZ/vjto=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=COm9ppWq8HLlwR+mv58wBLs/0drFGiY7lIYlXGWAcz7AXaVARM3sEZiv3he5FEJl/b8HcW8oXvKAPjQOAa05zrHnDzRhqBmGwhsh12xNX6j7Dr/zW/6/lnCmB7Jf24VGEByHRE/S/RaC6K4jYR9eCIYRNcRmjcwTSfADCNxxIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ2CN8Cr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769524840; x=1801060840;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mXRBNsG1KvltKGLWMjB9OhvYSZUWg1JfD4N+xZ/vjto=;
  b=TJ2CN8CrzlXOnhc1UElZcJhawv/7mBKWkcK7Q4iaTLLOvgY7ZR0g0lH0
   Rg7sCYbfgWZ7l6nkYhWSaVRtC70jJwlJZkjQXJ3B2MSCeUPXGjziVduDC
   II1C5KaXlVxBQMIQXcvp9lvj6kmcmKXhwLx7knUm3K3fEAq/slQgWQIjo
   dDQJQjHVWtolOAEnzzFrhKG2zTq0BFQZ3tdjxL1eUDCYvSAUWSw7Rcocl
   CmpJucfDBtlF7yxFQO7SfrSY6+KvU+51OrX52/7dOKIgXqvf1NJU0KdFL
   dI3Mtwu/UGMt5Hy0oM9WZXHnUsUpQGQ20AN8e0w8svfyY2AwyMbeBXNwv
   w==;
X-CSE-ConnectionGUID: CGTu9dU9SVupw07ho5p6fA==
X-CSE-MsgGUID: 7mcYIUYsQl+zFMN21eCKew==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82086059"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82086059"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:40:39 -0800
X-CSE-ConnectionGUID: 6sh9hCMKQyqWj2mWPnfFqA==
X-CSE-MsgGUID: k7g4QTf8TD2VVBG9XzPC/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207787333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:40:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 16:40:28 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    Markus Mayer <markus.mayer@linaro.org>, Tim Kryger <tim.kryger@linaro.org>, 
    Matt Porter <matt.porter@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Jamie Iles <jamie@jamieiles.com>, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org, "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
In-Reply-To: <aXjHZQnIFjfPabdU@smile.fi.intel.com>
Message-ID: <379cc557-7d09-d6e9-3b16-9621e344bd36@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com> <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com> <aXP5YMNix8EfbJeF@smile.fi.intel.com> <fc09f6fd-013f-25fd-484c-cac59b0a60b6@linux.intel.com> <aXjHZQnIFjfPabdU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-20834577-1769524828=:1055"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,linutronix.de,linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211838-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 7DDBB95F4A
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-20834577-1769524828=:1055
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Jan 2026, Andy Shevchenko wrote:

> On Tue, Jan 27, 2026 at 03:35:27PM +0200, Ilpo J=E4rvinen wrote:
> > On Sat, 24 Jan 2026, Andy Shevchenko wrote:
> > > On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo J=E4rvinen wrote:
>=20
> +Cc: printk people to check on printing from a serial driver routines.
>=20
> ...
>=20
> > > > +=09/* Prevent triggering interrupt from RBR filling */
> > > > +=09p->serial_out(p, UART_IER, 0);
> > >=20
> > > Do we specifically use callbacks directly and not wrappers all over t=
he change?
> >=20
> > I guess it's just a habit, I suppose you meant using serial_port_in/out=
=20
> > instead. I can try to change those.
>=20
> Not (only) me. Jiri updated this driver (and many others) to use callback=
s.
> That's why I added comments here and there about possible recursions.

Fair, this patch originated from a time way older than Jiri's conversion
(not an excuse, just stating how it came to be and I've not realized=20
using an old way until you mentioned).

> > > > +=09serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
> > > > +=09ndelay(p->frame_time);
> > >=20
> > > Wouldn't be a problem on lowest baud rates (exempli gratia 110)?
> >=20
> > Perhaps, but until somebody comes with an issue report related to 110, =
I'm=20
> > wondering if this really is worth trying to address. Any suggestion how=
 is=20
> > welcome as well?
>=20
> Polling work? Timer?

And how do I prevent others messing with the UART during that time? While=
=20
IER is zeroed here (and I could make up->ier zero as well, I think), I=20
can't hold port's lock if I do either of those.

And I can't take the tty_port's mutex here either because the caller=20
is already holding port's lock (and it wouldn't prevent console writes=20
anyway as that, I think, only takes port's lock).

Sadly THRE/TEMT are not trustworthy as they are set before all those=20
non-data bits have been fully blasted on to the wire (we learned this with=
=20
rs485 half-duplex scenarios).


Normal behavioral exceptation what I have here is that userspace is sane=20
and won't do LCR write and tx at the same time but I don't know how to=20
ensure that. Perhaps using now > last xmit timestamp + frame_time could=20
avoid this unconditional delay.

> > > > +=09retries =3D 4;=09/* Arbitrary limit, 2 was always enough in tes=
ts */
> > > > +=09do {
> > > > +=09=09serial8250_clear_fifos(up);
> > > > +=09=09if (!(p->serial_in(p, usr_reg) & DW_UART_USR_BUSY))
> > > > +=09=09=09break;
> > > > +=09=09ndelay(p->frame_time);
> > > > +=09} while (--retries);
> > >=20
> > > read_poll_timeout_atomic() ? I assume it can't be used due to small f=
rame time?
> >=20
> > Frame time is in nanoseconds yes. I did consider=20
> > read_poll_timeout_atomic() but it would have required nsec -> usec=20
> > conversion so I left this as it is.
>=20
> Yeah with the same issue on low baud rates. So far I think we need to con=
sider
> 9600 as commonly used by the old HW (which may be connected to a modern P=
C with
> this new kernel running), so the frame time sounds like close to a millis=
econd.
> And this can be met in real life.
>=20
> Maybe put TODO/FIXME around these ndelay() calls?

Seems reasonable, I'll add that.

I'm under impression that all LCR writes occur from contexts that are=20
non-atomic by nature (except they are holding the port's lock, of course)=
=20
so this should never delay an interrupt handler.

> > > > +=09if (d->in_idle) {
> > >=20
> > > > +=09=09/*
> > > > +=09=09 * FIXME: this deadlocks if port->lock is already held
> > > > +=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > > > +=09=09 */
> > >=20
> > > Hmm... That FIXME should gone since we have non-blocking consoles, no=
?
> >=20
> > No, lockdep still gets angry if printing is used while holding port's=
=20
> > lock.
>=20
> Hmm... Let's ask PRINTK people about this. John, do we still have a gap
> with nbcon? Or did I misunderstand the scope of its use?
>=20
> > What would be possible though, is to mark the port's lock critical sect=
ion=20
> > for print deferral (but it's outside the scope of this series). In case=
 of=20
> > serial, it would be justified to use deferred printing (which is only=
=20
> > meant for special cases) because serial console and printing are relate=
d.
> >=20
> > > > +=09=09return;
> > > > +=09}
>=20
>=20

--=20
 i.

--8323328-20834577-1769524828=:1055--

