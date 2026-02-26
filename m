Return-Path: <stable+bounces-219766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOC2HP71n2kyfAQAu9opvQ
	(envelope-from <stable+bounces-219766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:27:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96D1A1D9D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79F1D301CCA7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579338F24D;
	Thu, 26 Feb 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrPHXMMi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9438E5E9;
	Thu, 26 Feb 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090874; cv=none; b=DYVpasetSWUsWu/d1oiu9aCoIB6f/JYiSlOhVXQYK49YFESht/UfhpQ97OhX3qo7GWDRUNg603SyfBftf8ArwyobMQgtbqe3yBy53VKuKzpHGDpRNw7i56rjSdX+ca90TCtotd8289RNXH11G0UOIAeYy7R/QVVbSF7Nw0ADOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090874; c=relaxed/simple;
	bh=ejKY8cckU0ZMHpQ2P4ITpVBIoo3BVhnF6hFc7Qr3r3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S53qizKqhhJsQjvDrTVKYXLX8e+X77D46bH+dotGYmer+0uGfiWOdfOdAE3K6CjUVw7nOtJFOTxBAqlT2YKazghTcWdEdYKl1t85474fXZmwwAcl5v/Ek5P1yV632VvQ9AOW90gaGfZuQQ0/xD1LzM/7PI5xwCvHhNDhd1xJceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrPHXMMi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772090871; x=1803626871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ejKY8cckU0ZMHpQ2P4ITpVBIoo3BVhnF6hFc7Qr3r3I=;
  b=YrPHXMMimudjNW7xyZy/sxvur4WpVI1hrbE9UpUGv8G6tz+fCVBrs3mD
   PoiV88qxghtc0nIIQSrUNMxoX6CooPU3otrDf/6lPTyNKMFgUZP74EKKr
   S7mYek5vsg6IB5A90/PMrQ23ylxAzQxiCsV5lngf4+aaQ8AfzT6VWHSLj
   AbDbpbULiJkjXV6ewnnZHKbD+zbKR95W42ctJNYDD4a1oEpwa3dZ0+rt3
   DCHku/2by7AIpIS+q9OUNeRfBlqOaTRvxdU+n1uwnnP4AcyHMwUn/mPYS
   jgsNQ6pYNBSwEaoYO47WFGQvrE+mG5NEE+H8PhO0JRkvCW5s4uu3fK/5W
   A==;
X-CSE-ConnectionGUID: 6lV3yfX9TaqU1NmngZXhmQ==
X-CSE-MsgGUID: wJsScsgjQu+xAFFrSJmY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73054258"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73054258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:27:50 -0800
X-CSE-ConnectionGUID: VDCYjIxuTk+8jwXAp1dydA==
X-CSE-MsgGUID: SuaDiaT7RMi3x+CI0z2d1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="254242969"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:27:49 -0800
Date: Thu, 26 Feb 2026 09:27:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Message-ID: <aZ_18m0gYBDEpSlt@smile.fi.intel.com>
References: <20260225232105.454931-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225232105.454931-1-makb@juniper.net>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219766-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 1D96D1A1D9D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:21:05PM -0800, Brian Mak wrote:
> Switch device_set_node back to ACPI_COMPANION_SET, so that the ACPI

device_set_node()
ACPI_COMPANION_SET() // but see below.

> fwnode does not overwrite the of_node with NULL.

> This allows MFD children with both OF nodes and ACPI handles to have OF
> nodes again.

Do you have a real use case? Can you elaborate more (platform, drivers
being involved, et cetera)?

...

> -	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> +	ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);

As a quick fix this may be fine, but it needs a big FIXME explaining that this
is actually a design limitation of fwnode that doesn't allow proper sharing
and stacking.

Bouncing back to ACPI_COMPANION_SET() also doesn't feel right as it hides
the real thing here, and real thing is the primary/secondary fwnode types
that we need to care of. Just call set_primary_fwnode() directly. It helps
also to get rid of ACPI_COMPANION_SET() calls where it may be replaced with
simple device_set_node().

-- 
With Best Regards,
Andy Shevchenko



