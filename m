Return-Path: <stable+bounces-247634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FSAA+7vBmofpAIAu9opvQ
	(envelope-from <stable+bounces-247634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:05:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63E54D001
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2353F30796C2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6543DA24;
	Fri, 15 May 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZzWPytA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA43C8C65;
	Fri, 15 May 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838637; cv=none; b=T3AVKQy+o5H2wdNlJIedXNtwp12aLL7yzSNzYtUToijbX4Q7AqTAP63shnPJ8WXIfBOjDbCLvNGFzwIXs7IezJMyviSkG1ZxUK7MNH4+Oxx1u7hRtQilLL5FZqYong3J/VVgcijYuiVHB7PIdP+qiZC5PJKiIaMuQVg1nHEqch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838637; c=relaxed/simple;
	bh=JdWqPrFuCYRw7pfqkRXLJdxKgObVBq7GjJajWDEOmcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVe0D8XGDguYQq4G8h4FsyzqWTF4UGXm05b9fyXgDF9GFnAyqOiZdnMWwXXnWoyLm2YjTLInPrv54VJl/Z2PlN4q/s6ZDhM1l2NIkIOZ0zB3Zg5K6qRCRmmqQX//nI7ahX6s4Wxp+CgWFfl17/NHz80CLW6QyRtKJv1w9JYUxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZzWPytA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778838636; x=1810374636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JdWqPrFuCYRw7pfqkRXLJdxKgObVBq7GjJajWDEOmcg=;
  b=jZzWPytAJKV/SmvypItRhz9tWFsot55lDVOimgLTvFq7eluq8Xb3aiEL
   wmSfZI3X9Zt9z+N8j1iVKPv1S4M9OPMnIRfFUXbz5lKRaKU2d5JGS178K
   vmH04lcNsQ/2rwuUfmVVt/+9fe5ytbLEDyGe4whqTYt4A/lsBAYVqGO4E
   47Kb0iaul1pcgap63n7e6eBIlvDsimka3QCgUhKtkfMZmUdLD8dF4E+Ww
   j71YFOvhptW9H6Wn9CLGRqHy6N6aBygOQL22Jka03OmB1Xv/leYYiLE/o
   dz0Ht6JCxhuyL8dyHIslf0h6lA5d9Q1TeWXOhUw5P309IqdpemGXzs0z5
   g==;
X-CSE-ConnectionGUID: PtQFSLm3TNewbij8a4mxdw==
X-CSE-MsgGUID: MsvGYj/0R/apw6Zz8mP0PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="105250210"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="105250210"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:50:35 -0700
X-CSE-ConnectionGUID: qjRCK1zYTBKhk3DMGEdhjw==
X-CSE-MsgGUID: W0HK/LpOR/mxphhtsgKiHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232253769"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:50:33 -0700
Date: Fri, 15 May 2026 12:50:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
Message-ID: <agbsZs8UorOLzyhd@ashevche-desk.local>
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: DE63E54D001
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,parrot.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247634-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 01:38:17PM +0200, Joshua Crofts via B4 Relay wrote:

> Currently in the AK8975 driver there are two instances where potential
> uninitialized kernel stack memory leaks can occur. If
> i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> the size of the buffer, uninitialized bytes are retained in the buffer
> and later the buffer is passed on to IIO buffers, potentially leaking
> memory to userspace.
> 
> Fix this by adding checks whether the return value of the function is
> equal to the size of the buffer and subsequently if the value is
> lesser than zero to distinguish from a returned error code.

...

> -	if (ret < 0)
> +	if (ret != sizeof(rval)) {
> +		if (ret >= 0)
> +			ret = -EIO;
>  		goto exit;
> +	}

Still better to not mix the two

	if (ret < 0)
		goto exit;
	if (ret != sizeof(rval)) {
		ret = -EIO;
		goto exit;
	}

...

Ditto for the second case.

-- 
With Best Regards,
Andy Shevchenko



