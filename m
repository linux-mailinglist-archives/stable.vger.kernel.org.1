Return-Path: <stable+bounces-223348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPFWKvXpqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:51:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C403223199
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5BC31C060C
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5A3921E6;
	Fri,  6 Mar 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmNraALc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679D1DB34C;
	Fri,  6 Mar 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807726; cv=none; b=nYFVmofxBnO1ZwL+8kbzKlSwIjKU+oNFCHJFeaYdakdTEfjJs+nZnksjP5c1ByvKX/clpl6NuvCFCCBFuMNecQTjjxMeTJBEEU6VAXZTxhupt5xASnh6GgVnLs+c57i3BcLIyPoMjPlxY/XKkNga0xvHIjWOGsKV2zwd0mAd9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807726; c=relaxed/simple;
	bh=WpoyVr95NJdxgt1XFjVo4dbjBcIaivBaOppxAbmvDb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP8+Lvz1LpE5I/VIGVEXsk3FQx0wleFi1R0uD6xq87b9ZNXZLnqeqEQKCb6nNjSgMaD5W+4L8mfuufUYydQydpq66AQixkOjveLS2tq+vO8NXESV+G8alA9B5p8se53vwn7PYiLbEEBHwyUw0WHUmODl/qRkrFs2qAyPOPqvD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmNraALc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772807725; x=1804343725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WpoyVr95NJdxgt1XFjVo4dbjBcIaivBaOppxAbmvDb8=;
  b=nmNraALcMQGk5bZjNA3lI0/sFFVGZb9aJMjMhHlKdtQz4cyN+I4bvXOK
   WFSUe/ZoyJY+eZ/PPupWi//4IlDnrFBldL+jrqx/kpiCJQvTJagwmJvWu
   nh0tKd+avVryf2OaSZv/nrauchf+1AAenZUkk6A0xyPz3XLP/vKwacXDm
   wHQSCI3KojCviZnT+/TQXGXJ4k+7bCr4Cga8EPbYu/6MapWHuNAYMGgin
   lv71MsM6v0L1vErBPp5Dekxg96mbQQETLuEDLgnmyoOHDQZmY5bPUWswy
   Okoki+2pTT8kaIPz/YRrYZsp+knZhBBKek0iSU23bDDJHOY2V+o0l9vV+
   A==;
X-CSE-ConnectionGUID: LzGQQGNDT22P9W0pGuLRGA==
X-CSE-MsgGUID: 20KWeSrRSWiDXBKlue+qJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73990467"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73990467"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:35:24 -0800
X-CSE-ConnectionGUID: C21KvCFMR3G0gAP8muPcbg==
X-CSE-MsgGUID: OeQJFLWjSJCcfrDa/IwoOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218181405"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:35:23 -0800
Date: Fri, 6 Mar 2026 16:35:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Brian Mak <makb@juniper.net>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <aarmKE49wgbIblRb@ashevche-desk.local>
References: <20260226224511.458065-1-makb@juniper.net>
 <20260306133806.GM183676@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306133806.GM183676@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 0C403223199
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223348-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:38:06PM +0000, Lee Jones wrote:
> On Thu, 26 Feb 2026, Brian Mak wrote:

...

> > +	/*
> > +	 * FIXME: The fwnode design doesn't allow proper stacking/sharing. This
> 
> So when will this be fixed exactly?

I don't know, it's a huge task that requires of redesigning how struct
fwnode_handle looks like and how it cohabits with struct device. Do you
you think that NOTE will be more appropriate, because it may span several
releases.

> > +	 * should eventually turn into a device fwnode API call that will allow
> > +	 * prepending to a list of fwnodes (with ACPI taking precedence).
> > +	 *
> > +	 * set_primary_fwnode() is used here, instead of device_set_node(), as
> > +	 * device_set_node() will overwrite the existing fwnode, which may be an
> > +	 * OF node that was populated earlier. To support a use case where ACPI
> > +	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
> > +	 */
> > +	if (adev)
> > +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
> > +	else
> > +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));
> >  }

-- 
With Best Regards,
Andy Shevchenko



