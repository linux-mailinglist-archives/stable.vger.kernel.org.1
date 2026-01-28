Return-Path: <stable+bounces-211972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INF1FpoYemlS2QEAu9opvQ
	(envelope-from <stable+bounces-211972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:09:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E135DA2836
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 410D13059F2E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035124466C;
	Wed, 28 Jan 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH8dT3+f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C721ADC7;
	Wed, 28 Jan 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609043; cv=none; b=GdIHJ0oJDUY2lScgzylqbX6uGBnJsCWXf5WMmVFCw2JgIcQwUCts2ulRRt0SHZIEyXjQq/8+w6ieNORgCL/KG4YgirXE7JBJXCH8bqKDWGENqGDhBXtgaM7VKnmly0XBzQM4glMIooFv8Pn4nTN2DGPCqDWiqfIWAXiNCbhlaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609043; c=relaxed/simple;
	bh=SFtQMNHPKE1yXRWSraFCFqTuzBc22YS6zrY4oHIClwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9hdlGjXMuXspIetybjMgBWPleeztwZvyjdx+hkJ+2RZ/pTQkTF6SmBEGh7XQsnA9mJ9qluGaJDonhclyOPChLrl0D/kxp2RVwPxxZlFPIpskFOrryx8SvIMXIcdSqCqGvMTSwcCIO4KytEVt46+VcwO5T9vj/7OZkY4oBUPd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH8dT3+f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769609042; x=1801145042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SFtQMNHPKE1yXRWSraFCFqTuzBc22YS6zrY4oHIClwE=;
  b=JH8dT3+f6cbCvxGAwU+MJCMP1oFVLbTGGrEb8Fob7vnxmoLaTs759xDf
   0dxDtP3Cv/aulGTYbblN+orcuYoJguwNd3JEbVhnMf/gBfcQtiJEXLesL
   MbrByxFFAhaabodrxgd/tlIep8LLqBtC6L8xd0YBFnG4LlqpNByiVisBp
   EgKRX9xP5aKlkQK1feK7W0T9kaPgb2plcs7r8GgaFTdBgKdJeYwZeq+B5
   x/NVikBTQ02IA9hQk2qwiH5Lzn95moDsG9UrESD1fLIkJNIzCI1aClwcc
   QIpJN9kF5lGTCOGZXuG34uqhyhVCtcfnLGS8aiwFZXIODRGNa7INPtJBX
   A==;
X-CSE-ConnectionGUID: fhppmwFYTLKGw/fKIQ0Nfg==
X-CSE-MsgGUID: WFsCSO78S/udefSW6LR6UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88393045"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88393045"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:04:01 -0800
X-CSE-ConnectionGUID: FmAYn18xQkaKL1JwTjTvrg==
X-CSE-MsgGUID: IWnOBzN9RkaHoPj3tVcXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208290530"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:03:58 -0800
Date: Wed, 28 Jan 2026 16:03:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/7] serial: 8250_dw: Rework IIR_NO_INT handling to
 stop interrupt storm
Message-ID: <aXoXSxsem4hOLlrO@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-6-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-6-ilpo.jarvinen@linux.intel.com>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211972-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E135DA2836
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:52:59PM +0200, Ilpo Järvinen wrote:
> INTC10EE UART can end up into an interrupt storm where it reports
> IIR_NO_INT (0x1). If the storm happens during active UART operation, it
> is promptly stopped by IIR value change due to Rx or Tx events.
> However, when there is no activity, either due to idle serial line or
> due to specific circumstances such as during shutdown that writes
> IER=0, there is nothing to stop the storm.
> 
> During shutdown the storm is particularly problematic because
> serial8250_do_shutdown() calls synchronize_irq() that will hang in
> waiting for the storm to finish which never happens.
> 
> This problem can also result in triggering a warning:
> 
>   irq 45: nobody cared (try booting with the "irqpoll" option)
>   [...snip...]
>   handlers:
>     serial8250_interrupt
>   Disabling IRQ #45
> 
> Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
> register do not result in the UART deasserting the IRQ.
> 
> Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
> currently empty and inactive. Rework IIR_NO_INT to keep track of the
> number of consecutive IIR_NO_INT, and on fourth one perform the quirk.
> Enabling Tx interrupts should change IIR value from IIR_NO_INT to
> IIR_THRI which has been observed to stop the storm.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +/*
> + * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
> + * storm prevention code.
> + */
> +#define DW_UART_QUIRK_IER_KICK_THRES	4

Actually if we...

>  struct dw8250_platform_data {

>  	u8 usr_reg;

>  	unsigned int		skip_autocfg:1;
>  	unsigned int		uart_16550_compatible:1;
> +
> +	u8			no_int_count;

...define this as

	unsigned int		no_int_count:2;

there will be no need to have a modulo at all. But I agree it might look a bit
weird.

>  };

-- 
With Best Regards,
Andy Shevchenko



