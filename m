Return-Path: <stable+bounces-212263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN8TOsQwemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2FA49C9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0671231A8AF3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35662ED17B;
	Wed, 28 Jan 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dihCKWU8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99F1E1DFC;
	Wed, 28 Jan 2026 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614931; cv=none; b=awW9aU6j9T8ss1u9tYyuFKg1fUsJ2kuc2llou46VSBcsGhXnOqa2Ql74NQp1+DGtH6FgfDMncyFTRpxWph7NufJE/BrHJ27UBOUPT0Y7w9NgxtobobIVIHHzEe87jTtXlQF/gGKLLWqhNv6Rfqgz1Frp4wGtnKfAgfCpQeFqDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614931; c=relaxed/simple;
	bh=ykiUC42NdLn0dRmPnKVJ+6bAyPr9KKLz87bjgYi8dSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch62pCSiH6R7vAJ5uPUkS+O5IkIwq8to3pMIsDx5Ab2bHgCFzRJQgSAJWz+c9Hc/2Eijw4Pizp9mNcKelzsOByrfal7niRODByTscDtTje4CmsMndwF7Sa8FItb3YrnS4NIi4LdSjoOX/lI7o8tbBjuMW0I5/dcI9aVPhFthK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dihCKWU8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769614930; x=1801150930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ykiUC42NdLn0dRmPnKVJ+6bAyPr9KKLz87bjgYi8dSs=;
  b=dihCKWU80o50wKkHaFTbzfnart+Kz7nso1WnWEzYDDDFML/e2InAR7Sq
   7sD5yz5fSAs5jFN6kjDALgnne3YPOOScMz3hPTHfYZr+N4sERBgOt8sfW
   tt2sfIV/utnCzV8mmXBqANWUdqRDEsHpbw8AthcYgZK/XZBKBcpaoFGkW
   lRE0/Pb1upfJZAmi4UQ8pr4YAFHZSgBYeag5lcou41Fzvv5wORMCAFqP1
   UrcOFXW0UjXNy6+/upT24mEdGNWOQG4z8bOC9nxzPXDc5hpnzvo3xreHN
   jAAg8jNgXYzjqX8Rnnmj5ZTyeIkdvCfu2NQoFb6yQ9gBsJLu8qbvzW5oW
   A==;
X-CSE-ConnectionGUID: u1Blkm0kQPiYB2F6SbWa9Q==
X-CSE-MsgGUID: 9Rs8vtRBQbqc/IiaO9uAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70735867"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70735867"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:42:09 -0800
X-CSE-ConnectionGUID: 0yHbjRRtScWxHhvrYujYSg==
X-CSE-MsgGUID: dHS8ni7BQGmt06rmWNfTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208315572"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:42:05 -0800
Date: Wed, 28 Jan 2026 17:42:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Tim Kryger <tim.kryger@linaro.org>,
	Matt Porter <matt.porter@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/7] serial: 8250_dw: Ensure BUSY is deasserted
Message-ID: <aXouStgDF635dYya@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-8-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,linaro.org,linux.intel.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-212263-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 68D2FA49C9
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:53:01PM +0200, Ilpo Järvinen wrote:
> DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> Existance of BUSY depends on uart_16550_compatible, if UART HW is
> configured with it those registers can always be written.
> 
> There currently is dw8250_force_idle() which attempts to achieve
> non-BUSY state by disabling FIFO, however, the solution is unreliable
> when Rx keeps getting more and more characters.
> 
> Create a sequence of operations that ensures UART cannot keep BUSY
> asserted indefinitely. The new sequence relies on enabling loopback mode
> temporarily to prevent incoming Rx characters keeping UART BUSY.
> 
> Ensure no Tx in ongoing while the UART is switches into the loopback
> mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
> DMA Tx pause/resume functions).
> 
> According to tests performed by Adriana Nicolae <adriana@arista.com>,
> simply disabling FIFO or clearing FIFOs only once does not always
> ensure BUSY is deasserted but up to two tries may be needed. This could
> be related to ongoing Rx of a character (a guess, not known for sure).
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

Some nit-picks below, otherwise seems good to go
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> Reported-by: qianfan Zhao <qianfanguijin@163.com>
> Link: https://lore.kernel.org/linux-serial/289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com/
> Reported-by: Adriana Nicolae <adriana@arista.com>
> Link: https://lore.kernel.org/linux-serial/20250819182322.3451959-1-adriana@arista.com/

Shouldn't these Link:s be Closes: tags?

...

> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	struct uart_8250_port *up = up_to_u8250p(p);
> +	unsigned int usr_reg = DW_UART_USR;
> +	int retries;
> +	u32 lsr;


> +	if (d->pdata)
> +		usr_reg = d->pdata->usr_reg;

I would unite this with definition above:

	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;

...

> +	lsr = serial_lsr_in(up);

> +	if (lsr & UART_LSR_DR) {
> +		serial_port_in(p, UART_RX);
> +		up->lsr_saved_flags = 0;
>  	}

This seems repeating a top of serial8250_read_char(). Perhaps we can do it
in a helper at some point?

...

> +	if (d->in_idle) {

> +		/*
> +		 * FIXME: this deadlocks if port->lock is already held
> +		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +		 */

Does it make sense to print an error here (assuming it will work with nbcon)?
If so, maybe leave it at the end of the function, after dw8250_idle_exit()
and goto there?

> +		return;
> +	}

-- 
With Best Regards,
Andy Shevchenko



