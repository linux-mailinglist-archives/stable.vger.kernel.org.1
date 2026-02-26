Return-Path: <stable+bounces-219770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCLFA+X5n2n3fAQAu9opvQ
	(envelope-from <stable+bounces-219770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:44:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C61A1FBD
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BD4300183F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D393921FF;
	Thu, 26 Feb 2026 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+6jRiAF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A079394462;
	Thu, 26 Feb 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091568; cv=none; b=jdTTEoF4lc9u64Ul76ixeHakr3mmDz5FeAZruisWTwB6luwgePkogC/F3399VETrQVhYUk5Ie7WiBEopn6brcdycvUbmHR2QXZJ7MqVGSGZZ7rkbxCVYBOKEevWsUPz1xVvNwJiPBe84Sdjq0OhcYK3k89XQvYVy7UyssKwoFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091568; c=relaxed/simple;
	bh=i7iP6SLqvueBiBwMWCpHe631svyqbUXNRPwIet3OvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+NVx6Pi63O07deNNVGIHAPT7XyTxN7H1JuPQ/UGfoXnT1M+e3043FS7TsqLggASszFgJ4kNNYiNeULlv+7mXtbEM39hD+9IMNiAFOaRMvtKXSBp40Ef3usc1WLOq8IO79gcCGBRHFbn/ssHAIG0Or7Q4sYHl0mNdFxeNbJfAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+6jRiAF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772091567; x=1803627567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7iP6SLqvueBiBwMWCpHe631svyqbUXNRPwIet3OvZA=;
  b=l+6jRiAFvyXQptMVyYUATMePI4FuVr20lthBcb4hwfLzyjtL+UU0uqXj
   xHfxSE9hk7GeA69mYkIMSeNgTmEvNzucBnetbmL4voBVdt0AqmFaTPXvU
   tKa1rLtAHVjgqvYqadhC2doWs5U3/1mLEYYfGmjMEAB52ySN9DGxZFnlO
   lCKxLW29Y+j3UBucyW/Jlx/GUSUT45y2amdC5ixmLu/svKS/YFri4xAgr
   xUXzMUChv9QnPSUzo54EnUP+8PZCihnq/VVLxf3hO0Um/yTjCvqpgVhWQ
   HdJB0UuL2aTM4aSUTjw/n7RDZ/cgNNEf/Z7wPCUPrtRs5IrSmnNwPyTZT
   A==;
X-CSE-ConnectionGUID: am96dhvuSqu4WUWBTlBRlA==
X-CSE-MsgGUID: zDsNf6w5Tfq7+A/FLlyOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73055343"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73055343"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:39:26 -0800
X-CSE-ConnectionGUID: fPAAVPIkQ1SWENSS28/HPw==
X-CSE-MsgGUID: YCz21X1dRFKPHDecmmGLJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="214499028"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:39:25 -0800
Date: Thu, 26 Feb 2026 09:39:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Message-ID: <aZ_4qqZCnpMKD_5q@smile.fi.intel.com>
References: <20260225232105.454931-1-makb@juniper.net>
 <aZ_18m0gYBDEpSlt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_18m0gYBDEpSlt@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 966C61A1FBD
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:27:50AM +0200, Andy Shevchenko wrote:
> On Wed, Feb 25, 2026 at 03:21:05PM -0800, Brian Mak wrote:
> > Switch device_set_node back to ACPI_COMPANION_SET, so that the ACPI
> 
> device_set_node()
> ACPI_COMPANION_SET() // but see below.
> 
> > fwnode does not overwrite the of_node with NULL.
> 
> > This allows MFD children with both OF nodes and ACPI handles to have OF
> > nodes again.
> 
> Do you have a real use case? Can you elaborate more (platform, drivers
> being involved, et cetera)?

Even more thinking on this it looks like a violation of the levels of
the fwnodes. The current design was not expecting the ACPI *and* OF node
to appear in the list. They both are considered "primary" from the design
point of view.

In your case it seems like an OF node comes from likely DT overlay and
messes up this logic (although it can be considered 'secondary' semantically).
But the proposed patch is not a solution, it's a band-aid.

TL;DR: if there is a use case that worked before (please elaborate),
the patch as a quick fix looks okay, but with FIXME added and open coded logic:

	/*
	 * ...description of use case...
	 *
	 * FIXME: The fwnode design doesn't allow proper sharing and stacking.
	 * Eventually this should become some device fwnode API call that will
	 * prepend the list of fwnodes (making ACPI one "primary" in that sense).
	 */
	if (adev)
		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
	else if (parent)
		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));

...

> > -	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > +	ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
> 
> As a quick fix this may be fine, but it needs a big FIXME explaining that this
> is actually a design limitation of fwnode that doesn't allow proper sharing
> and stacking.
> 
> Bouncing back to ACPI_COMPANION_SET() also doesn't feel right as it hides
> the real thing here, and real thing is the primary/secondary fwnode types
> that we need to care of. Just call set_primary_fwnode() directly. It helps
> also to get rid of ACPI_COMPANION_SET() calls where it may be replaced with
> simple device_set_node().

-- 
With Best Regards,
Andy Shevchenko



