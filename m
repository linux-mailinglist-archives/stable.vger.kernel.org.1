Return-Path: <stable+bounces-225762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA2NKnYLuWk/ngEAu9opvQ
	(envelope-from <stable+bounces-225762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:06:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1832A5490
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98944301B794
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95509394481;
	Tue, 17 Mar 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN/Vw3xF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E814347506;
	Tue, 17 Mar 2026 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734767; cv=none; b=S+5KVdnCAjJFLlghcHPFfLRK5vb4g9QHar9saXFVqRTRo+RlzZ4pFHsz4mLFncQvTjZ+IkEoRR82sfceRDry6zn0jW8AicRD1GA3Gfh1ZI/WQWRjQf5P3Qa08MgeXGE+Du9VRslBiolxxin4+Ylo4nJCEN5gzpcscLqyHU2itkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734767; c=relaxed/simple;
	bh=iMURNNM9AIH1rsZHJq+NkuOt1cRxxMqU8WKIAQJWBhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU5u5OEPnl0hB2zO3f3fBM/GOtxZ2RAK+cnHETEO1kIfdiqKWx1YiSgex8LTqp8KnKHyXkyzRxKCOwij4XSgXBCdPaQhWL1bVCdf9SqES02SZKC8rJKdXyklJ9p62saPkj9+0JXBHIfLOAnV40q8px80mWZ8TbSyr0zS/2lgQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN/Vw3xF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773734766; x=1805270766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMURNNM9AIH1rsZHJq+NkuOt1cRxxMqU8WKIAQJWBhY=;
  b=eN/Vw3xFo6L0Ez9LtUIqf1D5kZzucJMPpNuE9c49quSkRiwp3hvUMTkM
   OQ3Wd+uWy61SaY1m0Z/oHWqI9w2yHilgmMWtssQNnOIUDFq0hpdvmc4a1
   U3uiI0wNM8hA2vvvyjaB4DPKHiM4c+ctbAhvax0uL4/0I1ioXL9q4i9Rg
   vqRz0tPoOKSGsaE8zcZmDt7eWJktHfC5sAHThlm0TQnpOh6ehZEDZQDcz
   LrGV2cFt495+Ryl4BF109D2BIIAyyzhHkztBK90b4xMBuGJ8dAY3SCuhE
   E2bbv/nJ3KpFDskz/KdRL/ImefS5EbusHDRdDZkwpAy6PGOT6THx5y2zY
   g==;
X-CSE-ConnectionGUID: UdKncv1VTW+LFoCR9IAAxQ==
X-CSE-MsgGUID: SD5/ARtQQ/6BfGcU64M6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73777646"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73777646"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:06:05 -0700
X-CSE-ConnectionGUID: B6sce5gfS3eYat7KD1IA9A==
X-CSE-MsgGUID: 7EgpgieoQr+l3rFUEy13xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221425403"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:05:58 -0700
Date: Tue, 17 Mar 2026 10:05:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abkLY4AAQuFlTRC7@ashevche-desk.local>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro>
 <abkLEgrZbdb03VWg@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkLEgrZbdb03VWg@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-225762-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 4A1832A5490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:04:43AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 17, 2026 at 08:42:08AM +0100, Wolfram Sang wrote:
> 
> > > > ... this change costs some memory on every system. Maybe it can be
> > > > avoided?
> > > 
> > > How much memory does it cost? On most 64-bit architectures is +4 bytes,
> > > rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> > > +0 bytes. I expect that 64-bit machines will cope with this bump.
> > 
> > I am not opposing that the issue should be fixed. If it is not possible
> > to take the lock everywhere, this is a proper solution. But if we don't
> > have to use more memory, then we could save it. Our new SoC easily has
> > 'struct device' in the hundreds.
> 
> What's the alignment for the u8 member in your SoC? 4 bytes or 8 bytes?
> (I assume it's 64-bit SoC.)

FWIW, with the given change it will be still inside 64-byte data structure
which most likely occupies a single cache line (before this patch and after
as well).

-- 
With Best Regards,
Andy Shevchenko



