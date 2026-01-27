Return-Path: <stable+bounces-211840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKtRLZfReGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:54:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B696139
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93718305724A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6035CBA6;
	Tue, 27 Jan 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7KrMF+B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3F35CBB2;
	Tue, 27 Jan 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525118; cv=none; b=RcoEpMAaruyJWkYWHEjHKiUo4tDq71l377BuWXwQAah5XSsrll+h5H/Ew+eF1N7FAOsZVcEmxZL1wZxH5I1B/FAePhrpLbeRFQvWblmvg0XIJOXElZUmHet9jVlMxO2hTaZl+qR5SwiQvBviYMKMIE+QC6sKyZRmnFRjzDoLvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525118; c=relaxed/simple;
	bh=FZSLZndPM2IFrzMqbhFWGL/bCVFHfI5oqgjmq1IXq3k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fDA5mC1TFh9s+CTv4Py8rFJyxZyEtVXMbRKdSQyIjsvzcFEZ8GDJf7D54w9s9rWrIhKBpn0X0sNRNLIE1OkajoF0c6jU42dS6d28+LDoHcLGfO0C3stWy5Wu9vskw213GP3SZkY1Tq+CnY1tp96ozaWhd7rb30oLh30OVT5vMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7KrMF+B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769525117; x=1801061117;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=FZSLZndPM2IFrzMqbhFWGL/bCVFHfI5oqgjmq1IXq3k=;
  b=N7KrMF+Bx3RPDBqgKn3UP6RgqCymJcwFuiSsgDkBwhG0p+BM7wyHToNw
   wB80O0LM9a4ts1T6yf5LzMSUWbQ8JtMPuBOeJI/IQ1WwNU1WH4T68z031
   wBP6380x//ne+4YkIIkD5TjXsNSDLzJRVOZWhhkOo/TefEsnhGx6zSYBM
   hbjvW8Oa5vkjqavs93R3/ytSX3a4e45PrDOT/7Wp1RX17DaKPInVsT+Ce
   fJhLhxcvwee1HVpCDPLF15v8Txq224oi7cxwS0+kscIzw1tXRiYjIQNB0
   EaMVQrv+FNwPMmMXvHSlGhrCF/E1DFtyiZme/mPLbydiie4bLcgvqCeVN
   Q==;
X-CSE-ConnectionGUID: b8Q+Ml+9RQutuqGex9sgtQ==
X-CSE-MsgGUID: +cNgRNAcR+WMAtw2pvGNwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74344222"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="74344222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:45:17 -0800
X-CSE-ConnectionGUID: 59t1uevXQpSsaQYRGsZMIg==
X-CSE-MsgGUID: mv/AoVqSQFa1o7aR1v7LdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207788311"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:45:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 16:45:08 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    qianfan Zhao <qianfanguijin@163.com>, Adriana Nicolae <adriana@arista.com>, 
    Markus Mayer <markus.mayer@linaro.org>, Tim Kryger <tim.kryger@linaro.org>, 
    Matt Porter <matt.porter@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Jamie Iles <jamie@jamieiles.com>, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org, "Bandal, Shankar" <shankar.bandal@intel.com>, 
    "Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
In-Reply-To: <2026012608-slicing-vehicular-6987@gregkh>
Message-ID: <608bedc0-41b4-8d00-b586-5adf8754c701@linux.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com> <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com> <2026012608-slicing-vehicular-6987@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2035551506-1769521494=:1055"
Content-ID: <da8768f5-3a13-5971-af1e-c82c279f1563@linux.intel.com>
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com,linaro.org,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211840-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,arista.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 2D3B696139
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2035551506-1769521494=:1055
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b5ab8498-ef41-ce3b-79df-e4f4ccecfea6@linux.intel.com>

On Mon, 26 Jan 2026, Greg Kroah-Hartman wrote:

> On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo J=E4rvinen wrote:
> > DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> > Existance of BUSY depends on uart_16550_compatible, if UART HW is
> > configured with 16550 compatible those registers can always be written.
> >=20
> > There currently is dw8250_force_idle() which attempts to archive
> > non-BUSY state by disabling FIFO, however, the solution is unreliable
> > when Rx keeps getting more and more characters.
> >=20
> > Create a sequence of operations to enforce that ensures UART cannot
> > keep BUSY asserted indefinitely. The new sequence relies on enabling
> > loopback mode temporarily to prevent incoming Rx characters keeping
> > UART BUSY.
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
> >=20
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
> > Cc: <stable@vger.kernel.org>
>=20
> Why is patch 6/6 only marked for stable?  If this is needed "now",
> shouldn't this be a separate patch?  Do you need all of the first 5 for
> this to work properly?

Some of those are really dependencies but I'll try to improve this=20
situation for v2 and add a few more Fixes tag to the introducing commits.

> I can't take this series as-is because I don't know how to route it :(


--=20
 i.
--8323328-2035551506-1769521494=:1055--

