Return-Path: <stable+bounces-212873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHiQIMqnfGnuOAIAu9opvQ
	(envelope-from <stable+bounces-212873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:44:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94888BA9F0
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52F413004D87
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866437999D;
	Fri, 30 Jan 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSZNVj9l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BD3783C7;
	Fri, 30 Jan 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777090; cv=none; b=RcI+8WbNJZXn5KerjBOjC83GkwrsBRrgxWXTRNZ1EXN4xevPqk2oI6fg38G/s/fZ6dqVbCZNQO2sn9eANgvE6H3/RyvGJhv+4Ra3e5ohEWKfenf53L/WvHWBEQVO+FGGymbhcaX35kjtRaT4tCtQpGKxsleotaF+VZ7fxUAtCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777090; c=relaxed/simple;
	bh=BYWDzl1hpidTm8MVscZ7wuR/NoorAY6uuctOeV4P49Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FK5MY9oSy21w4wfosV+L+eEgd3fYFWj4BlFAcXd6usb3qMLJXBm9KLiDIBP0rMh5e7DBTOKfM+iX1fOHoIJsfAzc1ub6Tyc/OJjoUya2uQcjXsujiUB4C0wuqIUzDWM4WfvCTSuVtRjWl85AgfMknMKHDmrU23W+5ZAzajtxX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSZNVj9l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769777089; x=1801313089;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BYWDzl1hpidTm8MVscZ7wuR/NoorAY6uuctOeV4P49Q=;
  b=CSZNVj9lzMEJ2zN66DRVTmN+tTflQwwg4S25YPzSx9JgDPOJ5kGNeg24
   ufstdX2MToQH/w2/ALU0Hx8vK56l5VvxZu6/gnbAoVnHiitGx9leRjNDx
   ORpz0L2YZHoHzx/xqiePYzVZRdiqg83xxxVULtAcf68OvgPKIkFICIp4o
   WsGiw1TMn29qBR+qpMvtt5OdHF6vFciBLc+towu/F/apsgwkH8PPNsxsp
   qh/7M3Yj8Wxu8d4lQj5bWQUKQd5/JVUto8jE/YReybdhVvN3YAzeud8PM
   WhLyEwyKaq+Yf2PlIwF0Q0EpK5K6VSu3mvd6iiprvyGU6lvrlmonH18EL
   g==;
X-CSE-ConnectionGUID: 86ozDU8HRYK9kLIH74Yx+A==
X-CSE-MsgGUID: wBSJ4cBpSputP95bPbIY3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74889485"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="74889485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 04:44:48 -0800
X-CSE-ConnectionGUID: U0sX5SB6RhigwbyWQAANNA==
X-CSE-MsgGUID: Vw0gopSMTQeVgHby5bSPgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="239568926"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 04:44:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Jan 2026 14:44:38 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    Tim Kryger <tim.kryger@linaro.org>, Matt Porter <matt.porter@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Markus Mayer <markus.mayer@linaro.org>, Jamie Iles <jamie@jamieiles.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/7] serial: 8250_dw: Ensure BUSY is deasserted
In-Reply-To: <aXouStgDF635dYya@smile.fi.intel.com>
Message-ID: <407db45d-c4d9-e6b1-8e35-e398da89d40e@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com> <20260128105301.1869-8-ilpo.jarvinen@linux.intel.com> <aXouStgDF635dYya@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1204532064-1769777025=:988"
Content-ID: <a3a9dc3e-c4a5-a654-e523-0842e8e22999@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-212873-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 94888BA9F0
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1204532064-1769777025=:988
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <705e7d09-3806-dd46-66ca-a6d132db4dd5@linux.intel.com>

On Wed, 28 Jan 2026, Andy Shevchenko wrote:

> On Wed, Jan 28, 2026 at 12:53:01PM +0200, Ilpo J=E4rvinen wrote:
> > DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> > Existance of BUSY depends on uart_16550_compatible, if UART HW is
> > configured with it those registers can always be written.
> >=20
> > There currently is dw8250_force_idle() which attempts to achieve
> > non-BUSY state by disabling FIFO, however, the solution is unreliable
> > when Rx keeps getting more and more characters.
> >=20
> > Create a sequence of operations that ensures UART cannot keep BUSY
> > asserted indefinitely. The new sequence relies on enabling loopback mod=
e
> > temporarily to prevent incoming Rx characters keeping UART BUSY.
> >=20
> > Ensure no Tx in ongoing while the UART is switches into the loopback
> > mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
> > DMA Tx pause/resume functions).
> >=20
> > According to tests performed by Adriana Nicolae <adriana@arista.com>,
> > simply disabling FIFO or clearing FIFOs only once does not always
> > ensure BUSY is deasserted but up to two tries may be needed. This could
> > be related to ongoing Rx of a character (a guess, not known for sure).
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
> Some nit-picks below, otherwise seems good to go
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> ...
>=20
> > Reported-by: qianfan Zhao <qianfanguijin@163.com>
> > Link: https://lore.kernel.org/linux-serial/289bb78a-7509-1c5c-2923-a04e=
d3b6487d@163.com/
> > Reported-by: Adriana Nicolae <adriana@arista.com>
> > Link: https://lore.kernel.org/linux-serial/20250819182322.3451959-1-adr=
iana@arista.com/
>=20
> Shouldn't these Link:s be Closes: tags?

To not possibly give wrong signals, until they confirm their cases are=20
indeed solved by this patch, I'd like to keep these as Link tag only.

> > +=09struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> >  =09struct uart_8250_port *up =3D up_to_u8250p(p);
> > +=09unsigned int usr_reg =3D DW_UART_USR;
> > +=09int retries;
> > +=09u32 lsr;
>=20
>=20
> > +=09if (d->pdata)
> > +=09=09usr_reg =3D d->pdata->usr_reg;
>=20
> I would unite this with definition above:
>=20
> =09unsigned int usr_reg =3D d->pdata ? d->pdata->usr_reg : DW_UART_USR;
>
> > +=09lsr =3D serial_lsr_in(up);
>=20
> > +=09if (lsr & UART_LSR_DR) {
> > +=09=09serial_port_in(p, UART_RX);
> > +=09=09up->lsr_saved_flags =3D 0;
> >  =09}
>=20
> This seems repeating a top of serial8250_read_char(). Perhaps we can do i=
t
> in a helper at some point?

I don't see enough similarity as I'd need to deal with lsr_saved_flags=20
somehow still here.

> > +=09if (d->in_idle) {
>=20
> > +=09=09/*
> > +=09=09 * FIXME: this deadlocks if port->lock is already held
> > +=09=09 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > +=09=09 */
>=20
> Does it make sense to print an error here (assuming it will work with nbc=
on)?
> If so, maybe leave it at the end of the function, after dw8250_idle_exit(=
)
> and goto there?

I think the print would be useful. I'll leave the FIXME+commented out=20
print into the end of the function in v3.

I also realized that on error, dw8250_idle_enter() should undo what it=20
changed, that is, call dw8250_idle_exit() within which will simplify=20
caller-side error handling slightly.

--=20
 i.
--8323328-1204532064-1769777025=:988--

