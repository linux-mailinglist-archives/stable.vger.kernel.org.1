Return-Path: <stable+bounces-211968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFDLGs8QemnH2AEAu9opvQ
	(envelope-from <stable+bounces-211968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:36:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48EDA2374
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B3C83009B13
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965D35B13B;
	Wed, 28 Jan 2026 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B30XBERM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FD3596F8;
	Wed, 28 Jan 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607370; cv=none; b=OukjN9LN9DXfBCwz4HDTmAVdIM0KAvlu/VurDIy3cUsJFAADA0EJIQcLuMCdP2kCAK3UEokH2S+SDkKB0qYy9YPUUGdrkz+QjDZ2IPVhOeJsaK2hNpOQH1hTIYywZR8oDDJlm/iERKXKt7JfwySBs2uvuEEEEX36TH8iep5FKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607370; c=relaxed/simple;
	bh=U2+AYSXn1R4pSacjbMSaP4EkhNfOLypKgHvIzvb4maI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfHkRrremZx8s1t3ozayLJnuh658Rq3zRa5nZbvgidTDt4zXmbMPhk7le/9G+tiwqEI+YEsdxwmzmsuxh3lXxiQOOdqzzlysK8pVhJyhwURjOAuUhoUYpqdbhIWzC8I2XHgtvwUPUznJXjh1Mz5wGcOPkPzkTDAXilxEWP7FGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B30XBERM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769607367; x=1801143367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U2+AYSXn1R4pSacjbMSaP4EkhNfOLypKgHvIzvb4maI=;
  b=B30XBERMnkOt9GdEmzK8C07io2UUsxGBdom+mLQXmgb1xe1SzXi1ml0z
   i/sEMpshV/IwRY+2LGtuIt2IvRuB8Q/O3dRuLdOefoS87ler0TjTsqkD3
   m0p8YkXBYVwOyTMaGiKxHoK7Vspm69HN/Cw2CbEnBCxmOTtGYZntniwqR
   RSu8aqbTBIJzIx3P+eLEY1zWhAk2HEI2FienZAHnXt0ubxm0aTmgKY7GJ
   /UOr5KIDp6olIS6FMyb1TlYB9HBCWoHO4L6BLONKFpbKJir6fZtizGaJY
   otd4NMrIJUAPMt5tBTK3HV8Am854B1iQAM2VaEPiQBMgbS1ZbtFWCAkjg
   g==;
X-CSE-ConnectionGUID: a9leuPXdRamVyAStO3PD+Q==
X-CSE-MsgGUID: /jehVZ6lQuaF2Y3TDWt2rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81541570"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81541570"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:36:06 -0800
X-CSE-ConnectionGUID: kfBPQ2yASzKLsv8EipeAaA==
X-CSE-MsgGUID: PrncbHrBS9iBWsTkSDfefQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208643792"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:36:03 -0800
Date: Wed, 28 Jan 2026 15:36:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/7] serial: 8250_dw: Avoid unnecessary LCR writes
Message-ID: <aXoQwQnt4CYmeElZ@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211968-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D48EDA2374
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:52:56PM +0200, Ilpo Järvinen wrote:
> When DW UART is configured with BUSY flag, LCR writes may not always
> succeed which can make any LCR write complex and very expensive.
> Performing write directly can trigger IRQ and the driver has to perform
> complex and distruptive sequence while retrying the write.
> 
> Therefore, it's better to avoid doing LCR write that would not change
> the value of the LCR register. Add LCR write avoidance code into the
> 8250_dw driver's .serial_out() functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
> +{
> +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> +	u32 lcr;
> +
> +	if (offset != UART_LCR || d->uart_16550_compatible)
> +		return false;
> +
> +	lcr = serial_port_in(p, offset);
> +	return lcr == value;

I don't expect the side-effects, but strictly speaking this compares
the 32-bit values, while in some callbacks the only part of that
is being used (often lowest 8 bits).

> +}

-- 
With Best Regards,
Andy Shevchenko



