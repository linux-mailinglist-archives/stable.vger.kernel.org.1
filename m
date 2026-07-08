Return-Path: <stable+bounces-272568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H07GOCoDTmqKBgIAu9opvQ
	(envelope-from <stable+bounces-272568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 09:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38447722DF1
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 09:58:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="mF89D/+y";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272568-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272568-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC433300BD91
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532737754B;
	Wed,  8 Jul 2026 07:48:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC833F390;
	Wed,  8 Jul 2026 07:47:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496889; cv=none; b=bktGWUXwi693L3obqt19p8/SpKGk4DUVl/YsqtzCdLF/Gy1EhOBDFRaTCG+kZlNb0vcYhmNKJAmNPyJUZIlSggVIhDSVY4u3FsOy0OqR8ACpq+PiU3hJHnD6ahJfKN8eB/i4wqgFTY/hA43/btz2ju3lEkzJWgHAQNTWFfY94sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496889; c=relaxed/simple;
	bh=aHzI6mxmmlRO+E09CSvGaPGEmJtJ76hGqbCz94+ocX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQaI9Qh/79g/i/D3+8teGCdTjrDPbAbqfTWwrYAIIQgRZKoGi91+2OAl7y0+K0A1yJQeZzkCCpevNAbSAuaJeSy0HuxQfas3SZwHVz4zme7/K2DRb2Z9dV7Ggj0Bu8sR5bkuFSBlaqQ6FFbmb/FKFt4B58LgDqJ5Uade/tHfK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF89D/+y; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783496878; x=1815032878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHzI6mxmmlRO+E09CSvGaPGEmJtJ76hGqbCz94+ocX4=;
  b=mF89D/+yYf8qz9gax6k1SxM0AJ1K7n6sed/FtlCKtUl0pPJaneEr294N
   sCp6bgiBQMvnsva2dR5ypdzc0KhGskmpzelsgEsTFLzIL8DWqYRzTqzsw
   phFktyjCDgwNOa/Fa8YKFVpYQZ+tU8ZDNoqN/vREpMyA6rMUKHRikqU3Y
   FLMtNQJjCbKBxCB2gWTcpAaBbUsV+bG5EFJNIFY+kdHBcrE4Nwgu1XIAr
   2mUG6PaazAjOC4BpwY+jMfum7hLX3/VSkOhuKoEYUm/nwwP8KV25IwuK4
   wGRvcQC0vGNpmhWErIf6uwkjPxpC6qAo1I/17rksfAUJRl/1cJGqWtBjg
   w==;
X-CSE-ConnectionGUID: unCAWDcGSP6uj3nAEO8a4A==
X-CSE-MsgGUID: i6R5P0EoQrOvt4fQvUKVHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84250610"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84250610"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:47:55 -0700
X-CSE-ConnectionGUID: KPjmA0lOQi2992z/tn/mQw==
X-CSE-MsgGUID: gKsz5fWXSs2wQACQFcSCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253133908"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:47:51 -0700
Date: Wed, 8 Jul 2026 10:47:48 +0300
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
Message-ID: <ak4ApBBYdyVNd1Al@ashevche-desk.local>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272568-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38447722DF1

On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> may result in a failure.

> Steps to reproduce build failure:
> 1. Run `make allnoconfig`.
> 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
> 3. Run `make .` and make will end with regmap-related errors.

Repeating same mistake from the previous similar contribution. Where is the
actual excerpt of the failure? Please, provide one.

-- 
With Best Regards,
Andy Shevchenko



