Return-Path: <stable+bounces-211822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIGJIozHeGmltAEAu9opvQ
	(envelope-from <stable+bounces-211822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:11:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2669565E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F369A302A7DA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE735B122;
	Tue, 27 Jan 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hearboA6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4934F472;
	Tue, 27 Jan 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523053; cv=none; b=jaTZjMNxT7HG5nxkuQAH3Pddl73jEGdkgMa6Am/QDM4i1R6xEgHN2NvH5lGX3DWtayhNlz+oSaSPDrCL5QeYYTMbR7hn9ROLlWvjZZnJ0y8YuxIcwrCe0EP5C22OfHMO/zBe+cM38SQ3OKWOeQ7/Ud0SoqHA8QDCFSd47bE2TYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523053; c=relaxed/simple;
	bh=raT5qDfoCho1XB7kfBfjvEHWMDY42gL7+rt+GyZuwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE2DcMA+4+kVLBxJKC0oVCcKz1/Z6SeSm2bgN0Nt54XV17u0SnZRqmBnAp1byRpzbTIiEUuY9Cpt0H/DgX0fR/LF9ZEFcdQaKYhUFQBeGeuvP6hCDm3xv9sghC2VF8VtKxBpKKxEHeFdAoz6DKbT/afTTDH7QAXE9aHgnSp5vx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hearboA6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769523052; x=1801059052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=raT5qDfoCho1XB7kfBfjvEHWMDY42gL7+rt+GyZuwR4=;
  b=hearboA6tyiZemMZFb6KDzFijLB7ZSqQXlG+0RFEqHxr1m5onS1JHC4X
   3+PhX6E4mXXgzCAeSUJG7ImMY/AblHK289tjJYDrW6Huy0LnJG0JJ5hFP
   QjU2f/RDa3JRGq3mR7mM3JGC2cd7Zg60sFN9TmXSlJxoLGDksDMLcHqEF
   Bj66TVjj0nROs7QZNv/8vGHvVbrF1L0CWK/q6F4IRbNgSi3O3v9yed4Tb
   t1VwcmMsdlGe0ZaaMMz38M8n8i2v0zD6fbgq2SXbST0ffu2cnsznpBkYU
   RCVLj2DnOJ1bflqSTUf1SGTMKwu6aIQKwlL3bOV5UuF6k4j9fcV4oZNX/
   A==;
X-CSE-ConnectionGUID: AvsFxUb1SlubtOXYI+riFA==
X-CSE-MsgGUID: X8zgL8tMQZeFIKJEIOIRpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81022303"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81022303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:10:52 -0800
X-CSE-ConnectionGUID: d6gKfEIsSr+Pi38RZnhhRg==
X-CSE-MsgGUID: StlcWXzTRLiLHJHZwXK1Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212524574"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:10:48 -0800
Date: Tue, 27 Jan 2026 16:10:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Tim Kryger <tim.kryger@linaro.org>,
	Matt Porter <matt.porter@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jamie Iles <jamie@jamieiles.com>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
Message-ID: <aXjHZQnIFjfPabdU@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
 <aXP5YMNix8EfbJeF@smile.fi.intel.com>
 <fc09f6fd-013f-25fd-484c-cac59b0a60b6@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc09f6fd-013f-25fd-484c-cac59b0a60b6@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211822-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 4C2669565E
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:35:27PM +0200, Ilpo Järvinen wrote:
> On Sat, 24 Jan 2026, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo Järvinen wrote:

+Cc: printk people to check on printing from a serial driver routines.

...

> > > +	/* Prevent triggering interrupt from RBR filling */
> > > +	p->serial_out(p, UART_IER, 0);
> > 
> > Do we specifically use callbacks directly and not wrappers all over the change?
> 
> I guess it's just a habit, I suppose you meant using serial_port_in/out 
> instead. I can try to change those.

Not (only) me. Jiri updated this driver (and many others) to use callbacks.
That's why I added comments here and there about possible recursions.

...

> > > +	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
> > > +	ndelay(p->frame_time);
> > 
> > Wouldn't be a problem on lowest baud rates (exempli gratia 110)?
> 
> Perhaps, but until somebody comes with an issue report related to 110, I'm 
> wondering if this really is worth trying to address. Any suggestion how is 
> welcome as well?

Polling work? Timer?

> > > +	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
> > > +	do {
> > > +		serial8250_clear_fifos(up);
> > > +		if (!(p->serial_in(p, usr_reg) & DW_UART_USR_BUSY))
> > > +			break;
> > > +		ndelay(p->frame_time);
> > > +	} while (--retries);
> > 
> > read_poll_timeout_atomic() ? I assume it can't be used due to small frame time?
> 
> Frame time is in nanoseconds yes. I did consider 
> read_poll_timeout_atomic() but it would have required nsec -> usec 
> conversion so I left this as it is.

Yeah with the same issue on low baud rates. So far I think we need to consider
9600 as commonly used by the old HW (which may be connected to a modern PC with
this new kernel running), so the frame time sounds like close to a millisecond.
And this can be met in real life.

Maybe put TODO/FIXME around these ndelay() calls?

> > > +	if (d->in_idle) {
> > 
> > > +		/*
> > > +		 * FIXME: this deadlocks if port->lock is already held
> > > +		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > > +		 */
> > 
> > Hmm... That FIXME should gone since we have non-blocking consoles, no?
> 
> No, lockdep still gets angry if printing is used while holding port's 
> lock.

Hmm... Let's ask PRINTK people about this. John, do we still have a gap
with nbcon? Or did I misunderstand the scope of its use?

> What would be possible though, is to mark the port's lock critical section 
> for print deferral (but it's outside the scope of this series). In case of 
> serial, it would be justified to use deferred printing (which is only 
> meant for special cases) because serial console and printing are related.
> 
> > > +		return;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko



