Return-Path: <stable+bounces-214510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DJeDCLDhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:19:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C03F5238
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A502A3006823
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75743636D;
	Thu,  5 Feb 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liek9zKo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E892652A2;
	Thu,  5 Feb 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308381; cv=none; b=TmXuIZbMefCJMhxQGLcwEaMAKp/1Vn149JMmlk7J5Ag1IEe3GzfYCkl7qG5FPnk1qg4Ijz0OKysDJZEB326AAFW9bJzB+HRdMBkPww8GGRlV4pRReJUHcE2hzEhYGDPyS8LDo3Oue9v6npx4VPikbFZhmpwNwR8Kxlr05XxAyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308381; c=relaxed/simple;
	bh=2vwWW7894r1MtWc2WK0+pvPiaws8S8X1MVzNuKcAglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1zbj/7lR64nL/lNVgTShH8qRLOgQRUk6+z3go/dFQA63ID+z13ezpLZwsl2LoFj02CykSP4HJUOm1LNkTT5Wn6NzijdHv2zi1cFBi2xwI1fOeA4QC5IySr8WGWFJciMTpjrWvu4Tu1ArEfckjVeF5QfzbYysabrFOCxkl2Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liek9zKo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308381; x=1801844381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vwWW7894r1MtWc2WK0+pvPiaws8S8X1MVzNuKcAglQ=;
  b=liek9zKoC5ndoDrNs/IfMXbSNGGzgAG713pDkEYkz/fo0SDNzAH8E6vw
   6sd32zhiq0sCH4ZWzA5z0Up5DwK3LKp+nNG60NX9JzEM/9cVfQbxVmh/c
   S2ZOrHZel3JZLW/zTXZnLWrz+YJJWFWOeF7w/ce4SgUlXUIIIoQ7yChUW
   KzOxzEXuy5n1oVkBmI3edZ2aZrps26JYt5U/3h+ISJoXXInto8BkorV59
   QSibCogrmr7UbAdHTOSxPKmcnzC1P3g6ubDRB7eCYZ37v4LyUcXcaFB/z
   G/zY77lDTH8Cf+qM/mM+xcWb3cGJlnUUxhoHBh4gzBnvJ98P2UCdikLPp
   g==;
X-CSE-ConnectionGUID: gkP68HY8S/KzaV4on5pWAA==
X-CSE-MsgGUID: j8sIWUx2QUe/hAidClDvbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71407679"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71407679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:19:41 -0800
X-CSE-ConnectionGUID: HmHRSlsMQam9xheQ6/KGgA==
X-CSE-MsgGUID: 8sxpYnnaQr+mwYkRmkzldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210016740"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:19:37 -0800
Date: Thu, 5 Feb 2026 18:19:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Remi Buisson <remi.buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Message-ID: <aYTDF9BNwzXmd2J8@smile.fi.intel.com>
References: <20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 54C03F5238
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:35:33PM +0100, Jean-Baptiste Maneyrol via B4 Relay wrote:

> When the driver probe fails we encounter a regulator put warning
> because vddio regulator is not stopped before release. The issue
> comes from pm_runtime not already setup when core probe fails and
> the vddio regulator disable callback is called.
> 
> Fix the issue by deleting pm_runtime check in the vddio regulator
> disable callback and handing over the vddio disable management to
> pm_runtime by deleting the disable remove action before setting up
> pm_runtime.

...

> +	/* hand over vddio management to pm_runtime */
> +	devm_remove_action(dev, inv_icm45600_disable_vddio_reg, st);

First of all, note "remove" vs. "release". Have you tried to remove and insert
module several times? Does kmemleak happy about this?

Second, calling devm_*() for release resources is very exceptional situation.
This usually means that something is wrong to begin with in the probe.

Can you find a better way without calling devm_*() for releasing resources?

-- 
With Best Regards,
Andy Shevchenko



