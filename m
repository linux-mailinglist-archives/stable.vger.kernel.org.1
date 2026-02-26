Return-Path: <stable+bounces-219858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UED7AKKsoGlulgQAu9opvQ
	(envelope-from <stable+bounces-219858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:27:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC651AF1AF
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6351930B3D44
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A14657E2;
	Thu, 26 Feb 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lc5O6r2b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D145104C;
	Thu, 26 Feb 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137373; cv=none; b=KXp8tAYRBkfdkxbAIcqELzOgRXLN+MZn63J7H5hvGsVjD/syQBHjZSgeUIJwTW6HjRCgb5KtWja+2ErlkNFC+jXCHsaEog38FF4b4jFwrlztdHnbXEK0VQxyMBOP/b9SRr+gFxVCL9xaxy9FkFzWAafPM86hvhF7XXErAmoi6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137373; c=relaxed/simple;
	bh=bqQDOX0DO07ykQRXR1eVzzW7zXVVm9ep1w2wb88GA7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g56+QWuOemg+iCNWye5DxF/yxQYDNWVKbcu0qjtdED4fhc4rMtw1JTQMy+Utth3MjnR+wMOpUE028f5S1V1mmnJiZoubLzqh1jWiFAQP+PbT+wcVSCJ0KitHok74Lml2yJOVonUAb9ZoIAGn6b+7bEyq7md3z5gWfif2GO15dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lc5O6r2b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772137371; x=1803673371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqQDOX0DO07ykQRXR1eVzzW7zXVVm9ep1w2wb88GA7w=;
  b=lc5O6r2begVingcjJKSKL6/lXosV7OVlGB6sWeYp0SFukZdWddO0rhPj
   5E3hnfVK+PrrGjuP1gEvrTgGo5KZ9/8yQ5ErevTNFv0q/dobTrenjsyhJ
   kFcufDmrvbOjjRg8jxfpfBSztu3MDk7DAlxjBhjoF7grZFePJBSwXse0s
   P81pXVUCHvjfQtjl+Hd0N70hIEtIfyTUL1oQwmVKgHxhfAbvC84MU2y9T
   1K7XI3yJ+4tZd3e7puuvub0yQJ+5jKTABmqltvAtYAik0FEmOSZQKpPRV
   kerxuUy1Oj316aYj8vFmCwKZdPaFeCEImQ+hN5FjafxIft4puqWLg1p6/
   Q==;
X-CSE-ConnectionGUID: CbEOs2utTViWpJ6CxWnbCg==
X-CSE-MsgGUID: tz3A+yYaS7y340PjyCFpCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73396570"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="73396570"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:22:51 -0800
X-CSE-ConnectionGUID: zdHEHyyyRUqQGPqN5+oPCw==
X-CSE-MsgGUID: BRjC3oHZSd+UbFSZAhfaVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="214607347"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:22:49 -0800
Date: Thu, 26 Feb 2026 22:22:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Message-ID: <aaCrlxEW16n5iPa4@smile.fi.intel.com>
References: <20260225232105.454931-1-makb@juniper.net>
 <aZ_18m0gYBDEpSlt@smile.fi.intel.com>
 <aZ_4qqZCnpMKD_5q@smile.fi.intel.com>
 <E3EAF942-9F00-4214-9411-1B3612C8C3BF@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3EAF942-9F00-4214-9411-1B3612C8C3BF@juniper.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 6BC651AF1AF
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:40:30PM +0000, Brian Mak wrote:
> On Feb 25, 2026, at 11:39 PM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 26, 2026 at 09:27:50AM +0200, Andy Shevchenko wrote:
> >> On Wed, Feb 25, 2026 at 03:21:05PM -0800, Brian Mak wrote:

> >>> Switch device_set_node back to ACPI_COMPANION_SET, so that the ACPI
> >> 
> >> device_set_node()
> >> ACPI_COMPANION_SET() // but see below.
> >> 
> >>> fwnode does not overwrite the of_node with NULL.
> >> 
> >>> This allows MFD children with both OF nodes and ACPI handles to have OF
> >>> nodes again.
> >> 
> >> Do you have a real use case? Can you elaborate more (platform, drivers
> >> being involved, et cetera)?
> 
> Yes, at HPE Juniper, we have some MFD drivers for some PCIe devices on
> our x86 platforms that need to read properties from a device tree. These
> also have ACPI nodes attached to them, which do not have adequate
> descriptions for the HW.

Yes, that's what I was thinking of.

> > Even more thinking on this it looks like a violation of the levels of
> > the fwnodes. The current design was not expecting the ACPI *and* OF node
> > to appear in the list. They both are considered "primary" from the design
> > point of view.
> 
> For my reference, is there anything documented/implied that indicates
> that fwnodes were not designed to be used in such a way. To me, it seems
> that secondary fwnodes are designed to allow drivers to pull properties
> when the primary fwnode does not have the property, which is exactly how
> we're using it.

OF by definition is _firmware_ node. Secondary (when it was introduced) was
only about device properties (today is _software_ node). The concept of
using DT overlays on ACPI platforms not new, but was implemented much later
after the initial fwnode / unified device property approach. Basically
you are (mis)using it due to the design limitations / flaws and historical
evolution of the concept of device properties.

> >>> -   device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> >>> +   ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
> >> 
> >> As a quick fix this may be fine, but it needs a big FIXME explaining that this
> >> is actually a design limitation of fwnode that doesn't allow proper sharing
> >> and stacking.
> >> 
> >> Bouncing back to ACPI_COMPANION_SET() also doesn't feel right as it hides
> >> the real thing here, and real thing is the primary/secondary fwnode types
> >> that we need to care of. Just call set_primary_fwnode() directly. It helps
> >> also to get rid of ACPI_COMPANION_SET() calls where it may be replaced with
> >> simple device_set_node().
> 
> Sure, I can call set_primary_fwnode directly in v2. My only concern here
> is with the FIXME comment. To me, it seems like the fwnode API has
> already allowed for such a case, simply by allowing there to be a
> secondary fwnode. We have no need for more than a primary and secondary
> here.

Again, it's allowed technically, but not by design or definition.
primary == real firmware node (OF/ACPI)
secondary == (kernel built-in) device properties (software node)

Your case is primary + primary.
Or let's say not-so-primary, but definitely not built-in (a.k.a. secondary).

> Before I add the FIXME, can you elaborate on why you believe we
> need more than that?

Because tomorrow it might be an ACPI device that uses driver that already has
a software node for something and you will want to add DT overlay to it.

Or even more realistic case is the complex device where we have one firmware
node and several children which want to share same firmware node with different
software nodes (this is the case that may not be realised with the current
design).

It's just matter of time when we face the issue in full and some poor guy will
have to address that somehow.

What I think of is having a reference to parent and child without limitations
of the length of the lists and keeping secondary as a sibling pointer.

This hierarchy will allow to have a tree of fwnodes where one may be present
in different lists as a parent and/or sibling. With that we probably may have
a tree-like structure with many possible combinations and relationships.

TL;DR: It is not a problem in MFD, it's problem in fwnode current design.
FIXME is just to make sure we won't forget this.

-- 
With Best Regards,
Andy Shevchenko



