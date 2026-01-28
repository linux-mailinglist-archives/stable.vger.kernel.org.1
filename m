Return-Path: <stable+bounces-211978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIcoAK8gemmv2wEAu9opvQ
	(envelope-from <stable+bounces-211978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:43:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B605A3066
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5333025294
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257C35FF67;
	Wed, 28 Jan 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpmn7TkD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BB280327;
	Wed, 28 Jan 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611058; cv=none; b=gv4jJsETEq3w784Ft508nriVrVX7H2TvbwtW3FbCuO5EmfbOgysIeRKvDjiEgTGyKpb342G6jqAPhgpY6v8z01aEZClB7NjSbJJzbamdTuhdBUGNX7bZfbxmHv8CllEv04+nlVzcZ98jO4t3NyLkDP0SZQ9tRSqc+r9jsK/zu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611058; c=relaxed/simple;
	bh=xIMimHCjlq0F2QtbChhd5VKFQKGNtpQMk5hJqptOr1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr8WRCqch828wta+5TZXEJKJf6AEFh8siSxMyp6PHOYq+OgHZ3mTd/sBmNcRfj4bgr47Vo0QQxl8kt/riEXHJDKSLT3xIM/HYyrMCbtk0XfbYTqACgpiLoG6XO6izFZTLZTPbImlyeTiMSa+9casdYPNJCWmx6UxVIrU0uIk0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpmn7TkD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769611057; x=1801147057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xIMimHCjlq0F2QtbChhd5VKFQKGNtpQMk5hJqptOr1k=;
  b=Gpmn7TkDY5eT6KadsqKPo251A6NPib5e91NfWyMvkjOzo4327iqzWWA7
   dodn0bl4nZx71qS5PGHvrjHz2SLzpy8oBUB1FGi974sW+ZXcjZh6XP1py
   XepC5DnyGoA5LCRLDKzk38d7r+3kZLHNYJ9sv0bwXXFawCbAPeDsJW+JP
   8hODPqXbrPiw7BEGzZPvIKmukTgQv3Xx8a62zOHUZe37yP+6y4Giklng6
   w+kcd+QegWI2AWPi56IOjvfupbdKKoGp/A0xyt200GFDlN3OeOy0a1j9o
   YHisYZE2bdDaLT2cR/2393PHt+RQokq/uWrZXrBatJvBxYBjwbBGtpbar
   A==;
X-CSE-ConnectionGUID: jLBs8sOxSpeIFSPQg3aGUQ==
X-CSE-MsgGUID: sBYU77bAS8qN/er3gaLPcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81139548"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81139548"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:37:36 -0800
X-CSE-ConnectionGUID: R9ccK9IGTBatJCBjT5CwHA==
X-CSE-MsgGUID: jFuagXk9R6ip6QJOH2OVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208659051"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:37:33 -0800
Date: Wed, 28 Jan 2026 16:37:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] serial: 8250: Add late synchronize_irq() to
 shutdown to handle DW UART BUSY
Message-ID: <aXodg7E6dkqS2e37@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-7-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,jamieiles.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5B605A3066
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:53:00PM +0200, Ilpo Järvinen wrote:
> When DW UART is !uart_16550_compatible, it can indicate BUSY at any
> point (when under constant Rx pressure) unless a complex sequence of
> steps is performed. Any LCR write can run a foul with the condition
> that prevents writing LCR while the UART is BUSY, which triggers
> BUSY_DETECT interrupt that seems unmaskable using IER bits.
> 
> Normal flow is that dw8250_handle_irq() handles BUSY_DETECT condition
> by reading USR register. This BUSY feature, however, breaks the
> assumptions made in serial8250_do_shutdown(), which runs
> synchronize_irq() after clearing IER and assumes no interrupts can
> occur after that point but then proceeds to update LCR, which on DW
> UART can trigger an interrupt.
> 
> If serial8250_do_shutdown() releases the interrupt handler before the
> handler has run and processed the BUSY_DETECT condition by read the USR
> register, the IRQ is not deasserted resulting in interrupt storm that
> triggers "irq x: nobody cared" warning leading to disabling the IRQ.
> 
> Add late synchronize_irq() into serial8250_do_shutdown() to ensure
> BUSY_DETECT from DW UART is handled before port's interrupt handler is
> released. Alternative would be to add DW UART specific shutdown
> function but it would mostly duplicate the generic code and the extra
> synchronize_irq() seems pretty harmless in serial8250_do_shutdown().

Dunno if the triggered interrupt may lead to a new DMA transfers (since
this is generic 8520 code...) in some cases. Anyway I've just sent a patch
that is Cc'ed to you to prevent that from happening. Not sure if it needs
to be incorporated into your series or should have a Fixes tag.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



