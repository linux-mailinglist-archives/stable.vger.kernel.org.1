Return-Path: <stable+bounces-272313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id co9uNDwKTGrofAEAu9opvQ
	(envelope-from <stable+bounces-272313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 22:04:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCC71542C
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 22:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=G0grXB6v;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272313-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272313-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B1CA30254BB
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D99397332;
	Mon,  6 Jul 2026 20:01:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8903446CE;
	Mon,  6 Jul 2026 20:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368096; cv=none; b=QlYeGQSKIt6K3dP8O8CLQEztD4QxBQoendVQaZUIdCPnEYIniwoRsz8CVsnzP4MUwXJ16ItHtgTR+ZvBUlxCAmj9l1SaAEvl2Z+c7LFTeNzC3Ddb6YIWTTGH3wmKSfbZxivfjEvqTrDOargNdjutuZaNqZRkop6ivnmEpAm60M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368096; c=relaxed/simple;
	bh=5xfJqS2aaRzQYveMm2C0uDJWas4EwwnhfgPKx0bu1Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNJf8Vc9WScDxdK3fWOWN2yfmQvQkj+2PpzARmIN5taXLdckvpwscuIT7cddrikitrTkXv2ducz14TIt0uimLVMIXoP8xNF32JMPscuCpGx1rYDy/O1NEi7i0HY1h1dzLACM1CWZScOvwoaFonbsFxd5s+6VZiJHqYTcrATsuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0grXB6v; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783368094; x=1814904094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xfJqS2aaRzQYveMm2C0uDJWas4EwwnhfgPKx0bu1Kg=;
  b=G0grXB6v3ENuZFjfw3fecOU9dS1ZKNT+22ZfnNMkRxs3AirU62iFy9fP
   /b9ByL5FvmuGsPuu1RmDTqv1q+nk08sElOZTUw3xXUz0CbnCAzX7K7xl3
   JJHxkQfU1K3ZuHfpPE70nAXH7kA3jsEw2CAx5Cuuht/CF+Xo8ONbOy/t8
   fEpnny9RKn7NzDOblHVSxT/xoxThlwiZMa2S05cHeTPWyOpKzYOF992EI
   hzuuvYb5zKtbTPp8aKCupel5Uh66XeHABpyb1WnZojsY34VFSXjzg+3A7
   0d4EgXBfybZkB+21G29P+S6WGYE8xgBBF9kSskuVqHqPTifqMaEgrWnux
   g==;
X-CSE-ConnectionGUID: vnrYQPtIRMai2ZvfjDKv4Q==
X-CSE-MsgGUID: JreMIObsRFmw1nCS3TSc6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="86560229"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="86560229"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:01:33 -0700
X-CSE-ConnectionGUID: 8fTwLb3VT9Sbu7VupIeMbw==
X-CSE-MsgGUID: 66ZHab8rQ1mEYSJLJS+8fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="249367328"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:01:31 -0700
Date: Mon, 6 Jul 2026 23:01:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: kxsd9: fix Use-After-Free in remove()
Message-ID: <akwJmUiCXHezZfcl@ashevche-desk.local>
References: <20260706074650.96042-3-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706074650.96042-3-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:birenpandya@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:sakari.ailus@linux.intel.com,m:linusw@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272313-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,ashevche-desk.local:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85FCC71542C

On Mon, Jul 06, 2026 at 01:16:51PM +0530, Biren Pandya wrote:
> The kxsd9 driver currently calls iio_triggered_buffer_cleanup() before
> iio_device_unregister() in the remove() function. This order creates a
> race condition where userspace can still access sysfs or ioctl interfaces
> while the triggered buffers are being torn down, potentially leading to
> a use-after-free.
> 
> Fix this by swapping the cleanup order. Unregister the IIO device first
> to guarantee that all userspace interfaces are destroyed and no new
> accesses can occur before cleaning up the triggered buffers.
> 
> This vulnerability was flagged by the Sashiko automated review system.

> Link: https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya@gmail.com

I believe you wanted Closes: and Reported-by: tags instead of simple Link.

> Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

...

You have a series, where is the cover letter and the changelog, please?
Do not abuse the process.

-- 
With Best Regards,
Andy Shevchenko



