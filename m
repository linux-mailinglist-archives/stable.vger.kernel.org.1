Return-Path: <stable+bounces-222900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIzAIaQAp2k7bgAAu9opvQ
	(envelope-from <stable+bounces-222900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:39:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0151F2CD6
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16C47308118B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7548C419;
	Tue,  3 Mar 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKWIBcRc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF447DD54;
	Tue,  3 Mar 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551604; cv=none; b=gegnnyZt2C3u/FC5X51vPc4DLZktP4Rsc+1SmtiNO5Zygd8mfprFBUGN7uv7mx8DFvWD22iU6w0aNVA0LvbnIn3BKnt0FT8iMYwfKblsxJyAZmP2R/dUu9R5GBUt1UUZI6bypJR1COO/zp21ghvxrtSzTl/SUZuNNQRdVqWOM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551604; c=relaxed/simple;
	bh=s6upj/80ray0y8cnqVlyuVAglNfhqP7ECvH0NYsoi1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD0aq3mfUUL9r4hw0/QgAsZzuvPHo5dpZ+Tu9yTfoWYbr/67Suyb7vvAoqg/PVTnGc3KMCobZni7pEtDqSDvUGsX4l1Iaubf3zGD+ot7Vljq0vcoEYN0nfXGLjewoXkC/v+Es93vM9C9VE84V0pD3JnWbJzAPDgF4NRjLfDnvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKWIBcRc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772551603; x=1804087603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6upj/80ray0y8cnqVlyuVAglNfhqP7ECvH0NYsoi1w=;
  b=IKWIBcRcH4oAbr0LgBz7JUVZwMbbdFQbT3nrurm5thXuJTpRqtSzKkls
   zRBzYudPT2rTzpgGLHKqVQFN4BgoKSKKz3SdtMzYrKupKdbJng544uLsp
   3yALBMktxReX71gEbaFt5wM+Wo7hwoILzuRlg2uv+ySiMZLKe4faitJHl
   MvosCKKlaoJMrJtL7SwK3UNFezg4M9cCZHcCIvfBF3AaAmZHhGkUMi5m5
   wG5D+WVSp8wUyxWx7dW6RibUb5fuVQGQziCDdLxAj+fWQoZZr36rU5yHl
   HonQSv5deXbsB2U+yKjwKZJmPuAPQSnlE8F8a3Q17OwUtOr7ZGlkUBltQ
   Q==;
X-CSE-ConnectionGUID: H5bl3wPUQMq7FMpMXqY71w==
X-CSE-MsgGUID: c1wggQ8DT+WSTCTLMFdNwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="61167864"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="61167864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:26:41 -0800
X-CSE-ConnectionGUID: BVMSlosdQdOXJLT1YGp35A==
X-CSE-MsgGUID: 4sfXODrsTOOG20LQw+E3vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="255920367"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:26:38 -0800
Date: Tue, 3 Mar 2026 17:26:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>
Cc: jic23@kernel.org, lars@metafoo.de, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, michal.simek@amd.com,
	victor.jonsson@guidelinegeo.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Fix sequencer mode in postdisable
 for dual mux
Message-ID: <aab9qzkAi80Cx_9z@ashevche-desk.local>
References: <20260303145843.1712811-1-christofer.jonason@guidelinegeo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303145843.1712811-1-christofer.jonason@guidelinegeo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 8E0151F2CD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:58:43PM +0100, Christofer Jonason wrote:
> xadc_postdisable() unconditionally sets the sequencer to continuous
> mode. For dual external multiplexer configurations this is incorrect:
> simultaneous sampling mode is required so that ADC-A samples through
> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> VAUX[8-15] channels return incorrect data.
> 
> Since postdisable is also called from xadc_probe() to set the initial
> idle state, the wrong sequencer mode is active from the moment the
> driver loads.
> 
> The preenable path already uses xadc_get_seq_mode() which returns
> SIMULTANEOUS for dual mux. Fix postdisable to do the same.

...

>  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -		XADC_CONF1_SEQ_CONTINUOUS);
> +		seq_mode);

The indentation can be also amended while at it.

>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko



