Return-Path: <stable+bounces-268029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SlfCLUPrOmrJLQgAu9opvQ
	(envelope-from <stable+bounces-268029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:23:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B66B9F53
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:23:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fiH5bBiR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268029-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268029-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74AE13019F1B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF99396D2C;
	Tue, 23 Jun 2026 20:23:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130135DA7B;
	Tue, 23 Jun 2026 20:23:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246206; cv=none; b=O0qE0u2JlYu7igB/rxAOAaWgHGGhRHpdevneQ9kZ6Rh/pNIg9LUYAmX9CHWpAwxR91U5XEN+BGnZYBuN0EeLuFoIRHCre2r38uXz6YTD59wN8IbDgiNskWS2IDl9fPCSBEHIDjIEcQ6TorH/7JIAp7UkXJ/2/ZojlVJdPUcG8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246206; c=relaxed/simple;
	bh=15faP+ApOLh3ds+1OIn1FuNBNnTZfi1gAVLl7GOMuEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPKKIzLLIqGc5TejtBfWS3pKrTi6PwjpX01X6f5n6ZoZKHH4QPVKzf+AslWk30+tpQnk3uiZ0yE21Sq/iVSve6zzdCBTbflFU2T7mPwwQp1WCwHtA8awZFOb5MHuTYziXaleGcmdcIzamTOHUt6j8Wf3N6EhEyKoaS29TM1UGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiH5bBiR; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782246205; x=1813782205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15faP+ApOLh3ds+1OIn1FuNBNnTZfi1gAVLl7GOMuEo=;
  b=fiH5bBiRM2+rWnoCAIcmkuYEE3KNtOyEAbyGIi2vEV8y3MbkcQslGDnc
   iI6sFjF7rOe7IHXS861M/ason9wWIfWXeCgyyW/t60SsyYjRZRNqTKAwx
   tEfrar6084S2QPeGeQ4oXVu+A79lQrziQYoopNkXhFToYujWdEyC7ZcAs
   2qDyjo/BdUfF4134aCTdjQ1cn9/EknIuhWWEV8ZbQQIjozP2syWjJckW2
   QRvect63HIJTvgebn1EdK1xetd67xfxMPSSXQoCqY5OFmPvcZjpZEFTow
   yNe0hgy7q3dgzW/0RRCK1Ln5H08T6S9cNptLJhoyKuFWZICWoCaLnH6w5
   Q==;
X-CSE-ConnectionGUID: NRN2tDO/SXqefR737V8nCQ==
X-CSE-MsgGUID: cPeEzZOjQL2WEp8Z/pgdiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94493894"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94493894"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:23:24 -0700
X-CSE-ConnectionGUID: 5j53VBgJQDW4ZBL9w6iMcw==
X-CSE-MsgGUID: 7b9EAwXyR4ujyNCIUSPHFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249644650"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:23:21 -0700
Date: Tue, 23 Jun 2026 23:23:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Message-ID: <ajrrN9yPzr2yxqef@ashevche-desk.local>
References: <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268029-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jean-baptiste.maneyrol@tdk.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:jmaneyrol@invensense.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 313B66B9F53

On Tue, Jun 23, 2026 at 06:44:22PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Timestamps are made by measuring the chip clock using the watermark
> interrupts. If we read more than watermark samples as done today, we
> are reducing the period between interrupts and distort the period
> measurement. Fix that by reading only watermark samples in the
> interrupt case.
> 
> Better watermark computation using gcd and store watermark value for
> FIFO reading.

...

> +		/* use the shortest period and the gcd of the latencies */
> +		period = min(period_gyro, period_accel);
> +		latency = gcd(latency_gyro, latency_accel);

If gyro is 5 and accel is 7 the gcd() will give 1. I don't think it's what you
want.

Did you think of lcm()?

...

> +	/* update effective watemarks */
> +	st->fifo.watermark.value = max(latency / period, 1);
> +	if (wm_gyro)
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +	if (wm_accel)
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);

In my example this ends up with 1 in both cases.

-- 
With Best Regards,
Andy Shevchenko



