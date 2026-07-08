Return-Path: <stable+bounces-272632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lgvzHH8vTmp2EwIAu9opvQ
	(envelope-from <stable+bounces-272632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:07:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D16724A89
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="l/ULR2K9";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272632-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272632-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5863131192E9
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B53FFF81;
	Wed,  8 Jul 2026 10:55:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49C3C09FE;
	Wed,  8 Jul 2026 10:55:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508147; cv=none; b=m2uxcJlDgR8gfUagzXW9rRM6rSa03wb/42v47s3v4Uc1F5OKKafFUsmhoT4+W4QNNhB9Fty/KPA8brMXYHdpT2tEQm5Fr7p+RbNjNNq6WnNjEu0g13jE46WItofeI3TtDsqUM5PZHtV2qc5hYd1140K3Hgh9QL6WPERBHqzwSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508147; c=relaxed/simple;
	bh=aMBco8sdazwnk4KPza4ON2ECyBlRQLZFTYPb2ZivFZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwxBwHFZSLrjltWTh67PMMKSoyc3z8wfn8ziD2sQHQPwzPHdjjmNi1qsT3BETp9O/OBmHrRKYi+YdENWFi57alvt1ul7PDZTdfdRzuDm1jPhmjWlAmyZOH4zBS7P4vY2kfGMhDXAcAz0kPrteJEDfyiC+gkmLkUVvbal4cfBFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ULR2K9; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508144; x=1815044144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMBco8sdazwnk4KPza4ON2ECyBlRQLZFTYPb2ZivFZ4=;
  b=l/ULR2K9V5cg80EGsv+VJG5NkMeMFA9R+Rcybtbid0QxQADdDIh2/pel
   ndYmvok7CACKIF1RmbhyX2dudkiKO7dHpbEDtDFs/QjVIFloUESGmTZ1E
   MLYSfiENu9hyVjyQC/LFHvXjEZjYDZEtOap6pFdXiFZteFUVrJALgMZrH
   NLdk7QRSrbYySDJ+Bho+bqytaUb4av7mrixjz+OTmnmARxY3Hgmo10II9
   kiEUETxhdJHCfbzUvTLCSTdTqUizttu/JUrGpurWHrNLDt/Pgb8Gp9p16
   bAmSoMbhGE3AuXsKWI9UkvabHIS4xlRvntzVRKo7NtZwBORwLe46WmIIO
   w==;
X-CSE-ConnectionGUID: 6cEqEDoyT2GMxTPfe3afBg==
X-CSE-MsgGUID: t+p0s9ZMQ5ytPYgR6V2Lrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83945310"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83945310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:55:38 -0700
X-CSE-ConnectionGUID: 9hBYBX1QRCSFbPbMG3gVXw==
X-CSE-MsgGUID: 8KapFLm9QaO2avoRMW2bqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277469880"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:55:34 -0700
Date: Wed, 8 Jul 2026 13:55:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Message-ID: <ak4so4KAztmqaUgk@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272632-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:stefan.popa@analog.com,m:jstephan@baylibre.com,m:fr0st61te@gmail.com,m:marcelo.schmitt1@gmail.com,m:marilene.agarcia@gmail.com,m:kimseer.paller@analog.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,m:marceloschmitt1@gmail.com,m:marileneagarcia@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8D16724A89

On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> may result in a failure.
> 
> Steps to reproduce build failure:
> 1. Run `make allnoconfig`.
> 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
> 3. Run `make .` and make will end with regmap-related errors.

Taking into account the real build failures as pointed in the replies,
the fixes LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



