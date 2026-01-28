Return-Path: <stable+bounces-211971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOgWA3wWemlS2QEAu9opvQ
	(envelope-from <stable+bounces-211971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:00:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A511DA2666
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C3AF3004F05
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B211D5ADE;
	Wed, 28 Jan 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUcVl0mW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CE1FD4;
	Wed, 28 Jan 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608824; cv=none; b=c8jFehnmxCcL3VdH46f/WAhfF0uy1lW2HvkB1rDxmO6+KV9ELkCBmKXhl2EkC1mqmaB3dvLrproWAJK4mxXug62pT3veYUoUUCf/RXR92Cyj0FI3mmXBNjeqnRgGXUYYB4XKMdsuajkO7px8nT9YX/tCTPUoFJ8l7GbB//2WiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608824; c=relaxed/simple;
	bh=byRlle8Wj1duceObS6/KWcbfgI+TekkH0u33xL8DUBs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GCWG0CHj1Ph6ncpVbTJm103ViPwUBoL0LEg39I2PHXzGrbveTsW6WFYQBD+g1bjMjG5pjoa0Cibb4JK4VXUI/jlhDQY9N0qk8rIPOaIFEsL5ncp6XclhBgb7zEYAwTT4zlgwceu7MlOSjlFBFoLtKCkW7vkIH4qwiZgh7FWiYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUcVl0mW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769608823; x=1801144823;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=byRlle8Wj1duceObS6/KWcbfgI+TekkH0u33xL8DUBs=;
  b=UUcVl0mWAjE+Kq5CoCRFRN80l+FD1DqWOp7EudCaTwwwr2KCXEqz8AtI
   rM6qDaNHQS1+6CyiUc3K9/SZQr3lsgQcqIyL9eaDLQdDsUjywWBZp8YRA
   km0zhP78jAArauPis5yximnK/RMw5RP4MwPhop2c1pOVEEpOYMpKWHZLu
   UkzfU6jj+ALPI5mzSFC7J6oH1933A1eqpgcC11NrEjGXM0O80oiSlRoZh
   t+hAW2vOLBHn5H4Illooee2s/irumo4Tg9nTMDKBue1iPdJR8H7H641VY
   MU6Cig3hDcUc41+v9vq2/+khhUIEdvHA9mOR3+RQOuvdrUILPVB6v4z8K
   w==;
X-CSE-ConnectionGUID: bUkwPzvdSJyDQCnSjsEuZA==
X-CSE-MsgGUID: gOISKK/6RVC7OyBqGFfGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70909857"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70909857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:00:22 -0800
X-CSE-ConnectionGUID: cLTIXfdGTRCF1raqnGH/kQ==
X-CSE-MsgGUID: 6HxhhKr3RfeSs0AdRURxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208340622"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:00:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 16:00:14 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] serial: 8250_dw: Rework dw8250_handle_irq()
 locking and IIR handling
In-Reply-To: <aXoTnKJjwO5_GMoL@smile.fi.intel.com>
Message-ID: <f050a630-8732-346e-0f5f-0186e5640c30@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com> <20260128105301.1869-5-ilpo.jarvinen@linux.intel.com> <aXoTnKJjwO5_GMoL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2146939067-1769608814=:1017"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211971-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A511DA2666
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2146939067-1769608814=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jan 2026, Andy Shevchenko wrote:

> On Wed, Jan 28, 2026 at 12:52:58PM +0200, Ilpo J=E4rvinen wrote:
> > dw8250_handle_irq() takes port's lock multiple times with no good
> > reason to release it in between and calls serial8250_handle_irq()
> > that also takes port's lock.
> >=20
> > Take port's lock only once in dw8250_handle_irq() and use
> > serial8250_handle_irq_locked() to avoid releasing port's lock in
> > between.
> >=20
> > As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
> > lock, it has to be done already in dw8250_handle_irq().
> >=20
> > DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
> > collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
> > (because & is used instead of =3D=3D) meaning that no other work is don=
e by
> > serial8250_handle_irq() during an BUSY_DETECT interrupt.
> >=20
> > This allows reorganizing code in dw8250_handle_irq() to do both
> > IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
> > the logic.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> ...
>=20
> >  =09if (!up->dma && rx_timeout) {
> >  =09=09status =3D serial_lsr_in(up);
> > =20
> >  =09=09if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >  =09=09=09serial_port_in(p, UART_RX);
> >  =09}
> > =20
> >  =09/* Manually stop the Rx DMA transfer when acting as flow controller=
 */
> >  =09if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_runn=
ing && rx_timeout) {
> >  =09=09status =3D serial_lsr_in(up);
> > =20
> >  =09=09if (status & (UART_LSR_DR | UART_LSR_BI)) {
> >  =09=09=09dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
> =09=09=09...
> >  =09=09}
> >  =09}
>=20
> Looks like now (perhaps in a separate change) this may be refactored even=
 more.

Definitely, as was noted in the coverletter. ;-)

--
 i.

>=20
> =09if (rx_timeout) {
> =09=09status =3D serial_lsr_in(up);
>=20
> // Although not sure about moving the above read out from the specific co=
nditions.
>=20
> =09=09if (up->dma && (status & (UART_LSR_DR | UART_LSR_BI))) {
> =09=09=09/* Manually stop the Rx DMA transfer when acting as flow control=
ler */
> =09=09=09if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma->rx_running) {
> =09=09=09=09dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
> =09=09=09=09dw8250_writel_ext(p, DW_UART_DMASA, 1);
> =09=09} else if (!up->dma && !(status & (UART_LSR_DR | UART_LSR_BI)))
> =09=09=09/* ... */
> =09=09=09serial_port_in(p, UART_RX);
> =09=09}
> =09}
>=20
>=20
--8323328-2146939067-1769608814=:1017--

