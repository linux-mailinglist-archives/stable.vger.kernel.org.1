Return-Path: <stable+bounces-211813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GwoH/W/eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:39:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9C194FE0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83CC430467D5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2725352949;
	Tue, 27 Jan 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ2LWu+S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C13595B;
	Tue, 27 Jan 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520939; cv=none; b=bjwtCKW4nJgXF2KJvOoA5i5SjaSd2GEaXe/9IXqtb8u9UssXo8WZUpP6ehDLhFQnc9aRuFRSIFyLAxTVtD35t0gXtA5zllwIWrqo5Frx+Spa8bTDgrW7jjHfAco7cxyzTGa5emf2Er5/GSU5jn1FvraCgRQxGegApN28cHrSI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520939; c=relaxed/simple;
	bh=Uz2b6GqDTeayEs2jG42Pe8XY6xbdBuCY14ZgRFFQ2Ps=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wa5yR1YpiFBwrR9+pk7ckyub5JoeEom1sjzQfTEbx0rBKo70iapEguaCxJ9WU8IwJcpYAveyzkpi9QhRN6AOSeCKsvr/SJiCqnTH3aELXWHzKuzAz+I8h7I8Ucog5GhnlSF3uk/O77oYpxEnNvDbt77oDutLCrOXtc3ancEx6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ2LWu+S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769520938; x=1801056938;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uz2b6GqDTeayEs2jG42Pe8XY6xbdBuCY14ZgRFFQ2Ps=;
  b=MJ2LWu+SLcuiMLnPEQXBOR31rr3RKp/aQamn4wFVdl10Z2fjCjHnevkU
   qrMegZW/6QWUjkc9kESk/mAhgfkQVryac4R6IHSHPqqyMf0KRrUX8yt7l
   CTw0lQ3VROksMP2lnqZFKYAfY2fZRZcm72F8tG0NLLVv7aRwcmwsN6CxY
   X1BaMOsNFtz7TdMUeuENdOi5iP7A4vxOPPMY3e9Xc0xKz/Zvf3FQc8Flk
   +vRruHj1ky1m7VCgf9jvzZbnofQ8fALjyQ2IVWWqfd20dTzAoAlBSH7jS
   645/vgMj8ULpAQQRR12CRbnjPbZjn52cznP0zjetP5dSeU88TlIB3Ol/H
   Q==;
X-CSE-ConnectionGUID: aUxPPBXWRju7W3QWGyCbyQ==
X-CSE-MsgGUID: whZpDC4mTFKglnYUusVJLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70689641"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70689641"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:35:37 -0800
X-CSE-ConnectionGUID: DlNWaKRcQmeYIpv/noscSA==
X-CSE-MsgGUID: MesGnefZQKKR/9ErS3j7Gw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:35:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 15:35:27 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
In-Reply-To: <aXP5YMNix8EfbJeF@smile.fi.intel.com>
Message-ID: <fc09f6fd-013f-25fd-484c-cac59b0a60b6@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com> <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com> <aXP5YMNix8EfbJeF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-313706942-1769520927=:1055"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211813-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,arista.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A9C194FE0
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-313706942-1769520927=:1055
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 24 Jan 2026, Andy Shevchenko wrote:

> On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo J=E4rvinen wrote:
> > DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> > Existance of BUSY depends on uart_16550_compatible, if UART HW is
> > configured with 16550 compatible those registers can always be written.
>=20
> with 16550 compatible --> with it
>=20
> > There currently is dw8250_force_idle() which attempts to archive
> > non-BUSY state by disabling FIFO, however, the solution is unreliable
> > when Rx keeps getting more and more characters.
> >=20
> > Create a sequence of operations to enforce that ensures UART cannot
> > keep BUSY asserted indefinitely. The new sequence relies on enabling
> > loopback mode temporarily to prevent incoming Rx characters keeping
> > UART BUSY.
>=20
> What if UART was already in a loopback mode? I assume that Tx pause
> described below should not affect the case.
>
> The real case scenario that I am thinking of is a stress test of UART
> using loopback mode.

If you're running a stress test that transfers characters while writing to=
=20
LCR, IMO you get to keep all the pieces yourself.

What will happen though is that LCR write would succeed still because of=20
the locking that will prevent Tx'ing more to loopback, but the stress test=
=20
might lose some pieces instead of getting to keep them. :-)

In general, I don't see sane reasons to mess with LCR while a real=20
transfer is going on. How is it sane to change line settings such as # of=
=20
bits while xferring something!?!


This is to fix scenarios where what's happening on the serial line is not=
=20
under our control (the other end keeps sending characters). There's=20
nothing we can do to stop that unlike running a loopback the stress test=20
while writing to LCR which is plain stupidity.

> > Ensure no Tx in ongoing while the UART is switches into the loopback
> > mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
> > DMA Tx pause/resume functions).
> >=20
> > According to tests performed by Adriana Nicolae <adriana@arista.com>,
> > simply disabling FIFO or clearing FIFOs only once does not always
> > ensure BUSY is deasserted but up to two tries may be needed. This could
> > be related to ongoing Rx of a character (a guess, not known for sure).
>=20
> Sounds like a plausible theory because UART has shift registers that are
> working independently on the current situation with FIFO. They are actual
> frontends for Tx and Rx data on the wire.

Yes. I just mentioned it's a guess as it's hard to verify, so if somebody=
=20
looks at this commit from the history, they know I've not been able to=20
confirm but just made an educated guess. And if they've been able to
acquire better information, they're more likely to rely on that info=20
instead of my guesswork.

> > Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
> > number but using, e.g., p->fifosize seems overly large). Tests
> > performed by others did not exhibit similar challenge but it does not
> > seem harmful to leave the FIFO clearing loop in place for all DW UARTs
> > with BUSY functionality.
> >=20
> > Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> > writes. In case of plain LCR writes, opportunistically try to update
> > LCR first and only invoke dw8250_idle_enter() if the write did not
> > succeed (it has been observed that in practice most LCR writes do
> > succeed without complications).
> >=20
> > This issue was first reported by qianfan Zhao who put lots of debugging
> > effort into understanding the solution space.
>=20
> ...
>=20
> > +=09/* Prevent triggering interrupt from RBR filling */
> > +=09p->serial_out(p, UART_IER, 0);
>=20
> Do we specifically use callbacks directly and not wrappers all over the c=
hange?

I guess it's just a habit, I suppose you meant using serial_port_in/out=20
instead. I can try to change those.

> ...
>=20
> > +=09serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
> > +=09ndelay(p->frame_time);
>=20
> Wouldn't be a problem on lowest baud rates (exempli gratia 110)?

Perhaps, but until somebody comes with an issue report related to 110, I'm=
=20
wondering if this really is worth trying to address. Any suggestion how is=
=20
welcome as well?

> > +=09retries =3D 4;=09/* Arbitrary limit, 2 was always enough in tests *=
/
> > +=09do {
> > +=09=09serial8250_clear_fifos(up);
> > +=09=09if (!(p->serial_in(p, usr_reg) & DW_UART_USR_BUSY))
> > +=09=09=09break;
> > +=09=09ndelay(p->frame_time);
> > +=09} while (--retries);
>=20
> read_poll_timeout_atomic() ? I assume it can't be used due to small frame=
 time?

Frame time is in nanoseconds yes. I did consider=20
read_poll_timeout_atomic() but it would have required nsec -> usec=20
conversion so I left this as it is.

> > +=09if (d->in_idle) {
>=20
> > +=09=09/*
> > +=09=09 * FIXME: this deadlocks if port->lock is already held
> > +=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > +=09=09 */
>=20
> Hmm... That FIXME should gone since we have non-blocking consoles, no?

No, lockdep still gets angry if printing is used while holding port's=20
lock.

What would be possible though, is to mark the port's lock critical section=
=20
for print deferral (but it's outside the scope of this series). In case of=
=20
serial, it would be justified to use deferred printing (which is only=20
meant for special cases) because serial console and printing are related.

> > +=09=09return;
> > +=09}
>=20
> ...
>=20
> > +=09ret =3D dw8250_idle_enter(p);
> > +=09if (ret < 0) {
> > +=09=09/*
> > +=09=09 * FIXME: this deadlocks if port->lock is already held
> > +=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > +=09=09 */
> > +=09=09goto idle_failed;
> >  =09}
> > -=09/*
> > -=09 * FIXME: this deadlocks if port->lock is already held
> > -=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > -=09 */
>=20
> Ditto.
>=20
> >  }
>=20
> ...
>=20
> >  =09p->dev=09=09=3D dev;
>=20
> Maybe put an added line here?
>=20
> >  =09p->set_ldisc=09=3D dw8250_set_ldisc;
> >  =09p->set_termios=09=3D dw8250_set_termios;
> > +=09p->set_divisor=09=3D dw8250_set_divisor;
>=20
> ...
>=20
> > +EXPORT_SYMBOL_GPL(serial8250_clear_fifos);
>=20
> Same Q, perhaps start exporting with a namespace?

Yes, I'll put this and the wait func into NS.

> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_set_defaults);
>=20
> ...
>=20
> > +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsi=
gned int count)
> > +{
> > +=09unsigned int i;
> > +
> > +=09for (i =3D 0; i < count; i++) {
>=20
> =09while (count--) ?
>=20
> Ah, it's existing code... OK then.
>
> > +=09=09if (wait_for_lsr(up, UART_LSR_THRE))
> > +=09=09=09return;
> > +=09}
> > +}
>=20
>=20

--=20
 i.

--8323328-313706942-1769520927=:1055--

