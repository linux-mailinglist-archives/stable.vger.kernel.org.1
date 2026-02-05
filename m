Return-Path: <stable+bounces-214516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH17KpDIhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:42:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C26F55FC
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 958083004DCC
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68DF43900D;
	Thu,  5 Feb 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1tHKh9y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B93D6497;
	Thu,  5 Feb 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309771; cv=none; b=nwGQVVFk57jg8/V2+1C7xSYsDoQJkdAvFqGpYrTuapoYNbqpmeENSYzozsSNcKSJ4XwEX7bqKSRUxmzdQ14NnHXu302kLzBM7oOCLmxQYU4E+4RSl9gk0rt7mKerd/jVt8EdU6uLixE9IG3tKxtStKHWSIZ8TB7sfzYXcF+zMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309771; c=relaxed/simple;
	bh=pybJFfjAFKQOLinw+Da6Y8V7SZxcElA5ZSPBHq0poFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K07BoONnpcnpYo47YuBa6+1lxhJNZDmFDBTvdwJzkAQ0mdc2K5jdPnywkhPoF57EPiUKHbLXUvUq6SGvCjtyP9A0EM8mWuYupL0oOT9lj5ePlldAjUmQETf5WkiyhXCF8eM1a/5ZD1dxlGiXDm5OWiLTD+NcjmbjP5oM/0s9Rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1tHKh9y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770309770; x=1801845770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pybJFfjAFKQOLinw+Da6Y8V7SZxcElA5ZSPBHq0poFk=;
  b=I1tHKh9yTpmCjQXpxZkZgmqqBTbSQYZaXvC1k/5dgURtFkPtF+89/iEC
   Z4KP+yxZY7pELq74It2M6Vg/NwXg7Il9L6h+JbFoAteLmDBmlbzSLEmNT
   BoE5ZlWWFFJusywtsGisp8ttEzpDlFGKMVgWZrxYVl5FJ2hlIlMC+sn+2
   NW99m+jd4s1UgEDCeaMu8Kx3aaHOyRNN/CIoXCE+qspCx0VDy7Q4Jv+8E
   +Hig066O7vJb+eBgO9KJ6rcHVxJsz2Lh4PUNhrl99ckrrkZ4DGmClnI3i
   Ufw4f7U++y6A6dBzY22Nz0JGRrQJVZROgnw3rBUNEBUgv5Sqm40QQ3/NH
   A==;
X-CSE-ConnectionGUID: B19PgqJmSD6JEZNXOXICMg==
X-CSE-MsgGUID: fnrx6ULoQoe6UsXO/5AMug==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="88935387"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="88935387"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:42:49 -0800
X-CSE-ConnectionGUID: X+vpgv8AR56bxavODEIrRg==
X-CSE-MsgGUID: J7itpvS3Tsyl+c57eY/Ifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="248187557"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:42:48 -0800
Date: Thu, 5 Feb 2026 18:42:45 +0200
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
Subject: Re: [PATCH v2] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Message-ID: <aYTIhUb9Z2_I0UNC@smile.fi.intel.com>
References: <20260205-inv-icm45600-fix-int1-drive-bit-v2-1-5e72608ea154@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-inv-icm45600-fix-int1-drive-bit-v2-1-5e72608ea154@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42C26F55FC
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 05:30:42PM +0100, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Drive bit must be set for open-drain mode and be cleared for push-pull
> mode.
> 
> Referring to datasheet DS-000576_ICM-45605.pdf section 17.23.

And where is my tag?

Please, carry tags as needed. But since you will need a v3 due to that, also
add a name of the section, so it will be better to find in different versions
of the datasheets (in case the numbering is shifted).

  Refer to datasheet DS-000576_ICM-45605.pdf section 17.23 "...bla bla bla...".

-- 
With Best Regards,
Andy Shevchenko



