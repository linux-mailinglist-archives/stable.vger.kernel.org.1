Return-Path: <stable+bounces-211431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDZ5GGz5c2mf0gAAu9opvQ
	(envelope-from <stable+bounces-211431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 23:42:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8757B361
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6BA33006453
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18C2C234C;
	Fri, 23 Jan 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvr2yBnW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3126C3BD;
	Fri, 23 Jan 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208168; cv=none; b=GUrb3WRydHjv76QlYlqzzWKOOkwB40vuiNUFWMV73KjE3Lol/oqg5OB2VnV1qANt/kc2DDoC3x31GgA3o0kl6DyUjiUzjJZIzFj/gBhkEM7H5dU9GbZzUtverZywdrg1cOTrouA/BIxosi3xL34qeWETgxAPsjY6rEWz3/OuUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208168; c=relaxed/simple;
	bh=De9b6ZQikLqzMV20WpHp7NJ28FmPpNQ1DuZslv1czBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNgDCpcOPXmzVu9Gxv3To9Ez0i50ZCrTZwlA7ISppUWQ1U/LBzuAtRYOB13/ckJXWtd+2+OBTHw/CP9lW7J1MRqCwGT/r6T+7RW+CIxW+fUEtihjBDTksVw9H/cVCKKD8bIfUo/j9qg6IMiitPMjoWROiqdR4qgrZttg/CP39VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvr2yBnW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769208166; x=1800744166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=De9b6ZQikLqzMV20WpHp7NJ28FmPpNQ1DuZslv1czBw=;
  b=lvr2yBnWhWzJ1DSTfK5S07tO+jMKv3NBZhrPi/ruEfG7RzFkERT1EPg5
   xxceAVrX2dAWXW81rYM0I31XAqSD4dlkTroGqlYCqw7cfc053S0ThZxLa
   O22l9wWOwso1qBFtcAGosFYqlMuCFmluJoGKEh4PLr1NORubnjgBEqVep
   v5iyYXz3LPsPM2Bjz7a42rrNmV8FD8WzwMh2duW/pqGK6UNhihCJbF1sW
   84Pau1NJoKAmys0DRhLTKgII1JtyQZJYjujM3wBasA2cYNV5YlHVDtxOX
   mHbjz5OQlxxLonsYeTHHPPKEkdTQRBC1tuYfjzgXF6Uem+979szC8Qa2l
   A==;
X-CSE-ConnectionGUID: kKXUP3qzSAWt0JOTtsmw4Q==
X-CSE-MsgGUID: nhFzQg9vRYOKGVa5ZvxpGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81905480"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81905480"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:42:46 -0800
X-CSE-ConnectionGUID: 5gxmsB9EQu+J+tPNuIqEPg==
X-CSE-MsgGUID: kjq7Hk0SSwGDiME44amQKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207480297"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:42:42 -0800
Date: Sat, 24 Jan 2026 00:42:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Tim Kryger <tim.kryger@linaro.org>,
	Matt Porter <matt.porter@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
Message-ID: <aXP5YMNix8EfbJeF@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211431-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 9F8757B361
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo Järvinen wrote:
> DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> Existance of BUSY depends on uart_16550_compatible, if UART HW is
> configured with 16550 compatible those registers can always be written.

with 16550 compatible --> with it

> There currently is dw8250_force_idle() which attempts to archive
> non-BUSY state by disabling FIFO, however, the solution is unreliable
> when Rx keeps getting more and more characters.
> 
> Create a sequence of operations to enforce that ensures UART cannot
> keep BUSY asserted indefinitely. The new sequence relies on enabling
> loopback mode temporarily to prevent incoming Rx characters keeping
> UART BUSY.

What if UART was already in a loopback mode? I assume that Tx pause
described below should not affect the case.

The real case scenario that I am thinking of is a stress test of UART
using loopback mode.

> Ensure no Tx in ongoing while the UART is switches into the loopback
> mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
> DMA Tx pause/resume functions).
> 
> According to tests performed by Adriana Nicolae <adriana@arista.com>,
> simply disabling FIFO or clearing FIFOs only once does not always
> ensure BUSY is deasserted but up to two tries may be needed. This could
> be related to ongoing Rx of a character (a guess, not known for sure).

Sounds like a plausible theory because UART has shift registers that are
working independently on the current situation with FIFO. They are actual
frontends for Tx and Rx data on the wire.

> Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
> number but using, e.g., p->fifosize seems overly large). Tests
> performed by others did not exhibit similar challenge but it does not
> seem harmful to leave the FIFO clearing loop in place for all DW UARTs
> with BUSY functionality.
> 
> Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> writes. In case of plain LCR writes, opportunistically try to update
> LCR first and only invoke dw8250_idle_enter() if the write did not
> succeed (it has been observed that in practice most LCR writes do
> succeed without complications).
> 
> This issue was first reported by qianfan Zhao who put lots of debugging
> effort into understanding the solution space.

...

> +	/* Prevent triggering interrupt from RBR filling */
> +	p->serial_out(p, UART_IER, 0);

Do we specifically use callbacks directly and not wrappers all over the change?

...

> +	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
> +	ndelay(p->frame_time);

Wouldn't be a problem on lowest baud rates (exempli gratia 110)?

...

> +	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
> +	do {
> +		serial8250_clear_fifos(up);
> +		if (!(p->serial_in(p, usr_reg) & DW_UART_USR_BUSY))
> +			break;
> +		ndelay(p->frame_time);
> +	} while (--retries);

read_poll_timeout_atomic() ? I assume it can't be used due to small frame time?

...

> +	if (d->in_idle) {

> +		/*
> +		 * FIXME: this deadlocks if port->lock is already held
> +		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +		 */

Hmm... That FIXME should gone since we have non-blocking consoles, no?

> +		return;
> +	}

...

> +	ret = dw8250_idle_enter(p);
> +	if (ret < 0) {
> +		/*
> +		 * FIXME: this deadlocks if port->lock is already held
> +		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +		 */
> +		goto idle_failed;
>  	}
> -	/*
> -	 * FIXME: this deadlocks if port->lock is already held
> -	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> -	 */

Ditto.

>  }

...

>  	p->dev		= dev;

Maybe put an added line here?

>  	p->set_ldisc	= dw8250_set_ldisc;
>  	p->set_termios	= dw8250_set_termios;
> +	p->set_divisor	= dw8250_set_divisor;

...

> +EXPORT_SYMBOL_GPL(serial8250_clear_fifos);

Same Q, perhaps start exporting with a namespace?

>  }
>  EXPORT_SYMBOL_GPL(serial8250_set_defaults);

...

> +void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++) {

	while (count--) ?

Ah, it's existing code... OK then.

> +		if (wait_for_lsr(up, UART_LSR_THRE))
> +			return;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



