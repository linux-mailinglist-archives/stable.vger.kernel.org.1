Return-Path: <stable+bounces-211982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNhUERkoemlk3QEAu9opvQ
	(envelope-from <stable+bounces-211982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:15:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6879A39D0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FDA93079EF9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87121423C;
	Wed, 28 Jan 2026 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHe0BDkj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E333FE0A;
	Wed, 28 Jan 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612864; cv=none; b=TB95/PJKSBtOSg8v5hLj9qnzHoKpCq5YorY4sJQsyEwQaGC3gpAWmOUan6hL8QaTv53eDP7RVSNON9E1luWPudcdPeGy0PiFj3j7MTiCXPWP4ZFnqvBer1I6T9LVD7gVIGUKX9cGXOW7hBCPLOPk/N9ke37CizC2TxldYndGJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612864; c=relaxed/simple;
	bh=42xJqEppx6uere65jFemS9UG62b/cEvdAtAStThdFP0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YqZgbGGi3bh3IzMxYqcWK6uh3H3ALLBKiskzbadAleD6frWZT/gAIetue0W0r5N1/Muoh2CZ9/3ZwHnxwtGJ1S26PmWCBCMY8AAa4/Y8Zw4bf6ehfOR0F0J2S5xlVLvwmWO4rqdAKcKeEZlfzUyeitdaO4v8++AjeP4yjxhCHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHe0BDkj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769612863; x=1801148863;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=42xJqEppx6uere65jFemS9UG62b/cEvdAtAStThdFP0=;
  b=MHe0BDkjWaionmKEE88ju4tI0v44hLD0cx6v/6GcQIpVgkSux4Mhlv+M
   SkwoyPDqOxweUPGpTSk53L/NKZS1d0aqLCGYDxny1KOVV/vAcsYvnlWEu
   pgKHfcJTuc7bOOSC2tC4DrJ7ZbC6RtvcVTFQu2OvWrOJ/eszLPYJxdsRv
   EmO97A27zlY9coVtznHAw/trHknjoOkJ3JQwIn5ZKL/ZXDF2j8QlfqJeX
   gl6SG93hS4MWhsX9Z+BlMjZ6mSFu503b+ZQmXxtFqfby3ZbTeIkZqr6D7
   pGUoLeCH5A/tduCKOF3U+O9chHZNkMFAsz3AjWIpt4vDoK3ff0vHC8ESn
   A==;
X-CSE-ConnectionGUID: GgGuAJDsQ3eEpVL+L3hLFA==
X-CSE-MsgGUID: AavM88rdTg6pbEOqD3ikEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70993196"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70993196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:07:41 -0800
X-CSE-ConnectionGUID: Ng84lqKFTcm10fyFboFo2w==
X-CSE-MsgGUID: wwXtok1KRsK9fx08QVO0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208666219"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:07:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 17:07:33 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    Jamie Iles <jamie@jamieiles.com>, LKML <linux-kernel@vger.kernel.org>, 
    "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] serial: 8250: Add late synchronize_irq() to
 shutdown to handle DW UART BUSY
In-Reply-To: <aXodg7E6dkqS2e37@smile.fi.intel.com>
Message-ID: <7d6747b0-5cdc-6936-d52f-414edb063d3e@linux.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com> <20260128105301.1869-7-ilpo.jarvinen@linux.intel.com> <aXodg7E6dkqS2e37@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-159550698-1769612853=:1017"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211982-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6879A39D0
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-159550698-1769612853=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jan 2026, Andy Shevchenko wrote:

> On Wed, Jan 28, 2026 at 12:53:00PM +0200, Ilpo J=E4rvinen wrote:
> > When DW UART is !uart_16550_compatible, it can indicate BUSY at any
> > point (when under constant Rx pressure) unless a complex sequence of
> > steps is performed. Any LCR write can run a foul with the condition
> > that prevents writing LCR while the UART is BUSY, which triggers
> > BUSY_DETECT interrupt that seems unmaskable using IER bits.
> >=20
> > Normal flow is that dw8250_handle_irq() handles BUSY_DETECT condition
> > by reading USR register. This BUSY feature, however, breaks the
> > assumptions made in serial8250_do_shutdown(), which runs
> > synchronize_irq() after clearing IER and assumes no interrupts can
> > occur after that point but then proceeds to update LCR, which on DW
> > UART can trigger an interrupt.
> >=20
> > If serial8250_do_shutdown() releases the interrupt handler before the
> > handler has run and processed the BUSY_DETECT condition by read the USR
> > register, the IRQ is not deasserted resulting in interrupt storm that
> > triggers "irq x: nobody cared" warning leading to disabling the IRQ.
> >=20
> > Add late synchronize_irq() into serial8250_do_shutdown() to ensure
> > BUSY_DETECT from DW UART is handled before port's interrupt handler is
> > released. Alternative would be to add DW UART specific shutdown
> > function but it would mostly duplicate the generic code and the extra
> > synchronize_irq() seems pretty harmless in serial8250_do_shutdown().
>=20
> Dunno if the triggered interrupt may lead to a new DMA transfers (since
> this is generic 8520 code...) in some cases.

If BUSY_DETECT interrupt fires (like I'd expect), the handler won't start=
=20
anything but exits early from dw8250_handle_irq().

> Anyway I've just sent a patch
> that is Cc'ed to you to prevent that from happening. Not sure if it needs
> to be incorporated into your series or should have a Fixes tag.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--=20
 i.

--8323328-159550698-1769612853=:1017--

