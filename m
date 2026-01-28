Return-Path: <stable+bounces-211966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK5nOGINemmS2AEAu9opvQ
	(envelope-from <stable+bounces-211966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:21:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47921A20C8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317D8303C003
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA022FDEA;
	Wed, 28 Jan 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1wCPbr2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F9352C5B;
	Wed, 28 Jan 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606415; cv=none; b=kowxyl2F9bMdS9QJYijJ1JngJYh+NljmOJWE5Bnr3wCRxoztguwWebsZn4gzXwZ5yMDTVZp1j8LnXdKePj5eqMjenoeyxLEflvTRvDAsk8Bp3+rWUqt4jnDHno1IJnzp3kI58ilWxLg+ZhMm96lajbIL0FZBjARMYhCXwFY10cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606415; c=relaxed/simple;
	bh=rYQiCKYmGUs9pqPPXXraR5oSy02uVDt6UeGr16ewpow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYZdDScMU94T+zAol3ESksNv/+YnNkg6fHcpp9SyudgyWMY8ffwcuKL2/iC7I8oiudh0VWwpzFuA4AcZ2bQLjaSqP/OHm4lBhBqy82XtBmQl1b/0/RmlwoOeHOxRuFlRN3P+XlY813zqE3WG2lNFQq3S1yC+XnmLZcbG3wibGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1wCPbr2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769606414; x=1801142414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rYQiCKYmGUs9pqPPXXraR5oSy02uVDt6UeGr16ewpow=;
  b=E1wCPbr2pDEi+msNqKKuzVZngtHeyy1q2kQA2z5L6wpphOdWUi/7B0+b
   1p9aUiCaUdRAd1jbZ1LBVPuV90Smoo1vA8RHoGJErPVlKdGsqzxDXl0Tf
   Fa8GoiY3K5rPyzmdtw7MzbT5QcbjQERQQh1gqyucNSeLAWgwrJ5B7dKlJ
   yXA7illJZL0iEamkpIFFadkxgcp3s3ulD8TQtdXwrynfHDmevfMBT/Nyh
   6C0fJjuwnEe30kJxXdHap8EcyVPXXH+juwjWNjsv1WaTOXZHXr1b09Xzd
   /tfv1tnhrs4wksKC+ClqdL6/tMaZmt32VX+H0MOAznZfup4BD5d6wN13g
   w==;
X-CSE-ConnectionGUID: v8mIOYp6Tuqb5i0YF+ruvw==
X-CSE-MsgGUID: zpo7YqhHRgCsgoOVx60fWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81132412"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81132412"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:20:13 -0800
X-CSE-ConnectionGUID: QgYAQwHMQ5a2igWBAMeKsQ==
X-CSE-MsgGUID: 6ztZMXJeSTm42M+KE6/rfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="238990782"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:20:10 -0800
Date: Wed, 28 Jan 2026 15:20:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/7] serial: 8250: Add serial8250_handle_irq_locked()
Message-ID: <aXoNB7pnQMpPd8xY@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-4-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211966-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47921A20C8
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:52:57PM +0200, Ilpo Järvinen wrote:
> 8250_port exports serial8250_handle_irq() to HW specific 8250 drivers.
> It takes port's lock within but a HW specific 8250 driver may want to
> take port's lock itself, do something, and then call the generic
> handler in 8250_port but to do that, the caller has to release port's
> lock for no good reason.
> 
> Introduce serial8250_handle_irq_locked() which a HW specific driver can
> call while already holding port's lock.
> 
> As this is new export, put it straight into a namespace (where all 8250
> exports should eventually be moved).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);

Looking at these I think at some point we can move to 'u32 iir'.

>  u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
>  void serial8250_read_char(struct uart_8250_port *up, u16 lsr);

-- 
With Best Regards,
Andy Shevchenko



