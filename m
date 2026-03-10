Return-Path: <stable+bounces-223857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBTLDmryr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63692249636
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EFE0309A71B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404A44E05B;
	Tue, 10 Mar 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORNGBZbc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095344D031;
	Tue, 10 Mar 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138356; cv=none; b=ass6LkK6TVPo9MHp9Z9GRLLKk8VvsL6tws+ONhvle5OX5avJZebAI0fWCu2XK5G4S3eTJkYtakAGavJULTB6bMPDSXEHulvi8KqvSaeXwzgk93JKxsISxu+lC9Zxnt5/sswGrKaNGymaAK6Miz1XCToNqeu8BvJDkCxeHYaldBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138356; c=relaxed/simple;
	bh=bhAW5MOmZUjx9mkQj11fGuIHG+Yc4g2ly/sx9of0FAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P67ZVz4HElFq+ooWCkGREM5bhvv5xAaYcmwJrbFrcUstdfNCaSg/XtaT1xhFuBVGyOdstN2Uq9bDbbtNcyPcoj/4FOEBWegQ3nbvbMgqfVD5N7ftA+Qk5WBD3eCZWKzz8s6vdq3Fb3V2ncuHHhq+8RDpbphvqdJnoqDGnHrqI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORNGBZbc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773138355; x=1804674355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhAW5MOmZUjx9mkQj11fGuIHG+Yc4g2ly/sx9of0FAI=;
  b=ORNGBZbchF7fnpgyn9hRJkKw8cOUw+kFOuYc4JJi1PcgFYoLEu7AaThF
   9zh417KQH4y1vn0EKHOxQ/bRzoi2nzUxXazq0c8Y+iqfIt2gBMI+V3s2R
   sN5ViuBzBkWzHSIWiXXOHZ8DAfpX+DCSPJTnYy/ybbc4rP8PYQK7h9x3n
   rp3V3ySjSiCsuWp0SkrU2/wk6CsLlkh58ivkq1QJ5qheCR2Z04YD8BqmC
   IDv0XRnQn6iHlb57KV1G+I+/bryu4GYpNzeLwi3fqxrs0IT/TvkAnF+98
   q1iBPuzZ5ENW0/2fo1ZqKTsOEXBnXTVPxwtE6rDi/gHZj8gaCmw9encCt
   w==;
X-CSE-ConnectionGUID: p/W6o4qVQ7qssjSshMOBRw==
X-CSE-MsgGUID: w+crc9ECTGqpoPDNfS70iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74221908"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74221908"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:25:55 -0700
X-CSE-ConnectionGUID: TxIVIO7FTw+AaShQreaqXg==
X-CSE-MsgGUID: Dsp9Ut7RTHC1moU7/K+jSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224755127"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:25:52 -0700
Date: Tue, 10 Mar 2026 12:25:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Brian Mak <makb@juniper.net>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <aa_xriW62F2j3Cpu@ashevche-desk.local>
References: <20260226224511.458065-1-makb@juniper.net>
 <20260306133806.GM183676@google.com>
 <aarmKE49wgbIblRb@ashevche-desk.local>
 <20260310092148.GE183676@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310092148.GE183676@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 63692249636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 09:21:48AM +0000, Lee Jones wrote:
> On Fri, 06 Mar 2026, Andy Shevchenko wrote:
> > On Fri, Mar 06, 2026 at 01:38:06PM +0000, Lee Jones wrote:
> > > On Thu, 26 Feb 2026, Brian Mak wrote:

...

> > > > +	/*
> > > > +	 * FIXME: The fwnode design doesn't allow proper stacking/sharing. This
> > > 
> > > So when will this be fixed exactly?
> > 
> > I don't know, it's a huge task that requires of redesigning how struct
> > fwnode_handle looks like and how it cohabits with struct device. Do you
> > you think that NOTE will be more appropriate, because it may span several
> > releases.
> 
> If someone is going to do the work sometime in the near future, it can
> stay as FIXME.  A few releases isn't going to offend anyone.  However,
> if we're just going to sit on it and this is likely to be here for an
> elongated period, it should be changed.

Then better to be just a NOTE:.

> Any idea who is planning on working on it?

I am not sure anyone is planning on working on this in the near future.
We see the problem, but it hasn't hit someone's work too much to become
a showstopper (some workarounds, or not fully correct, but acceptable
behaviour was a way out so far).

-- 
With Best Regards,
Andy Shevchenko



